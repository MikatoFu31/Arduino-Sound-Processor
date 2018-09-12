#include "hspmath.as"
#include "hspext.as"
//Mikatofu31's MIDI API version beta 20180911
//Plain midi synth用MIDIドライバをtvmiddrv用に小型化したものです。
//↑ってやつを、Arduino-SP type1用に改造したものです。
#module MIDITOOLS
	#deffunc 鍵盤の電源をつける int portno
		dim portnumber
		portnumber=portno
		dim tonetoplay
		dim toneupper
		dim tonedowner
		dim basetone
		comopen@ portnumber,"baud=9600 parity=N data=8 stop=1"
		dim tonedata,12
		tonedata( 0)=65
		tonedata( 1)=69
		tonedata( 2)=73
		tonedata( 3)=78
		tonedata( 4)=82
		tonedata( 5)=87
		tonedata( 6)=93
		tonedata( 7)=98
		tonedata( 8)=104
		tonedata( 9)=110
		tonedata(10)=117
		tonedata(11)=123
	return stat
	#deffunc  鍵盤を押す int channel,int tone
		tonetoplay=tonedata(tone\12)*pow@(2,tone/12)
		basetone=tonetoplay
		toneupper=tonedata((tone+1)\12)*pow@(2,(tone+1)/12)
		tonedowner=tonedata((tone-1)\12)*pow@(2,(tone-1)/12)
*sendtone
		//周波数データを一旦削除
		computc@ '.'
		logmes str(tonetoplay)
		//周波数データを書き込んでチャンネル電源をONにする
		comput@ str(tonetoplay)
		computc@ '+'
	return 0
	/*MIDIAPI-ASP専用命令です。
		ピッチ変更 int channel,int rate
		[channel]CHのピッチを変更します。
		半音上がレート10、半音下がレート-10です。
		-10<rate<10の範囲を超えても一応値に合わせて音程が上下しますが正確さは知りません。多分-20は全音下ではないです。(半音の周波数の差分から計算している関係で)
	*/
	#deffunc ピッチ変更 int channel,int rate
		if rate=0{
			tonetoplay=basetone
		}
		if rate<0{
			tonetoplay=basetone-(basetone-tonedowner)*abs(rate)/10
		}else{
			tonetoplay=basetone+(toneupper-basetone)*abs(rate)/10
		}
		gosub *sendtone
	return 0
	#deffunc  鍵盤のカスタムコマンド int status,int channel,int data1,int data2
		//midisendmsg midi_uuid,((status<<4) | channel | (data1<<8) | (data2<<16))
		computc@ data1
	return 0
/*	#deffunc  楽器を変える int channel,int data1,int data2
		midisendmsg midi_uuid,((12<<4) | channel | (data1<<8) | (data2<<16))
	return 0*/
/*	#deffunc  特殊コントロール int channel,int data1,int data2
		midisendmsg midi_uuid,((11<<4) | channel | (data1<<8) | (data2<<16))
	return 0*/
	#deffunc  鍵盤を離す int channel
		//鍵盤を押す channel,data1,0
		//midisendmsg midi_uuid,((11<<4) | channel | (123<<8) | (data1<<16))
		computc@ '-'
	return 0
/*	#deffunc 鍵盤を離す強制
		midiReset midi_uuid
	return stat*/
	#deffunc 鍵盤の電源を落とす
		//midiClose midi_uuid
		computc@ '.'
		computc@ '-'
		comclose@
	return stat
#global
/*
鍵盤の電源をつける 0
楽器を変える 0,81,0
鍵盤を押す 0,64,127
await 500
鍵盤を離す
*/