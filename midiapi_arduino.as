#include "hspmath.as"
#include "hspext.as"
//Mikatofu31's MIDI API version beta 20180911
//Plain midi synth�pMIDI�h���C�o��tvmiddrv�p�ɏ��^���������̂ł��B
//�����Ă���AArduino-SP type1�p�ɉ����������̂ł��B
#module MIDITOOLS
	#deffunc ���Ղ̓d�������� int portno
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
	#deffunc  ���Ղ����� int channel,int tone
		tonetoplay=tonedata(tone\12)*pow@(2,tone/12)
		basetone=tonetoplay
		toneupper=tonedata((tone+1)\12)*pow@(2,(tone+1)/12)
		tonedowner=tonedata((tone-1)\12)*pow@(2,(tone-1)/12)
*sendtone
		//���g���f�[�^����U�폜
		computc@ '.'
		logmes str(tonetoplay)
		//���g���f�[�^����������Ń`�����l���d����ON�ɂ���
		comput@ str(tonetoplay)
		computc@ '+'
	return 0
	/*MIDIAPI-ASP��p���߂ł��B
		�s�b�`�ύX int channel,int rate
		[channel]CH�̃s�b�`��ύX���܂��B
		�����オ���[�g10�A�����������[�g-10�ł��B
		-10<rate<10�͈̔͂𒴂��Ă��ꉞ�l�ɍ��킹�ĉ������㉺���܂������m���͒m��܂���B����-20�͑S�����ł͂Ȃ��ł��B(�����̎��g���̍�������v�Z���Ă���֌W��)
	*/
	#deffunc �s�b�`�ύX int channel,int rate
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
	#deffunc  ���Ղ̃J�X�^���R�}���h int status,int channel,int data1,int data2
		//midisendmsg midi_uuid,((status<<4) | channel | (data1<<8) | (data2<<16))
		computc@ data1
	return 0
/*	#deffunc  �y���ς��� int channel,int data1,int data2
		midisendmsg midi_uuid,((12<<4) | channel | (data1<<8) | (data2<<16))
	return 0*/
/*	#deffunc  ����R���g���[�� int channel,int data1,int data2
		midisendmsg midi_uuid,((11<<4) | channel | (data1<<8) | (data2<<16))
	return 0*/
	#deffunc  ���Ղ𗣂� int channel
		//���Ղ����� channel,data1,0
		//midisendmsg midi_uuid,((11<<4) | channel | (123<<8) | (data1<<16))
		computc@ '-'
	return 0
/*	#deffunc ���Ղ𗣂�����
		midiReset midi_uuid
	return stat*/
	#deffunc ���Ղ̓d���𗎂Ƃ�
		//midiClose midi_uuid
		computc@ '.'
		computc@ '-'
		comclose@
	return stat
#global
/*
���Ղ̓d�������� 0
�y���ς��� 0,81,0
���Ղ����� 0,64,127
await 500
���Ղ𗣂�
*/