//HSPTV MIDI Driver for Arduino-SP version beta 0.1
//(C)2018 Mikatofu31
#include "midiapi_arduino.as"
/*
	技術的な面での簡易説明
	楽器:
		矩形波1chです。圧電ブザーをArduino Unoのch9に接続してください。
	ノート:
		発音:
			ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz
			C2          C3          C4          C5          C6
		発音停止
			 (スペース)
		何もしない(音がなっている場合は音がなりっぱなし)
			それ以外(今後のために「-」を推奨)
	
*/
#define global TVMIDDRV_TICK tick@tvmiddrv
#define global tvmiddrv_tick_next tick@tvmiddrv++
#module tvmiddrv
	#deffunc tvmiddrv_init int portno
		鍵盤の電源をつける portno
/*		#ifdef tvmiddrv_soundset
			#include tvmiddrv_soundset
		#else
			//デフォルトの音源セット。
			#include "tvmiddrv_soundset_default.as"
		#endif*/
		initialized=stat
		鍵盤を離す
	return initialized
	#deffunc tvmiddrv_play int ch,var data
		u_tick=tick
	if strlen(data)<=u_tick{
		u_tick=tick\strlen(data)
	}
	if peek(data,u_tick)=' '{
		鍵盤を離す ch
		return -1
	}
	if 65<=peek(data,u_tick) & peek(data,u_tick)<=122{
		鍵盤を離す ch
		鍵盤を押す ch,peek(data,u_tick)-65
		return peek(data,u_tick)-32
	}
	return 0
#global
