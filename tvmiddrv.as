//HSPTV MIDI Driver for Arduino-SP version beta 0.1
//(C)2018 Mikatofu31
#include "midiapi_arduino.as"
/*
	�Z�p�I�Ȗʂł̊ȈՐ���
	�y��:
		��`�g1ch�ł��B���d�u�U�[��Arduino Uno��ch9�ɐڑ����Ă��������B
	�m�[�g:
		����:
			ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz
			C2          C3          C4          C5          C6
		������~
			 (�X�y�[�X)
		�������Ȃ�(�����Ȃ��Ă���ꍇ�͉����Ȃ���ςȂ�)
			����ȊO(����̂��߂Ɂu-�v�𐄏�)
	
*/
#define global TVMIDDRV_TICK tick@tvmiddrv
#define global tvmiddrv_tick_next tick@tvmiddrv++
#module tvmiddrv
	#deffunc tvmiddrv_init int portno
		���Ղ̓d�������� portno
/*		#ifdef tvmiddrv_soundset
			#include tvmiddrv_soundset
		#else
			//�f�t�H���g�̉����Z�b�g�B
			#include "tvmiddrv_soundset_default.as"
		#endif*/
		initialized=stat
		���Ղ𗣂�
	return initialized
	#deffunc tvmiddrv_play int ch,var data
		u_tick=tick
	if strlen(data)<=u_tick{
		u_tick=tick\strlen(data)
	}
	if peek(data,u_tick)=' '{
		���Ղ𗣂� ch
		return -1
	}
	if 65<=peek(data,u_tick) & peek(data,u_tick)<=122{
		���Ղ𗣂� ch
		���Ղ����� ch,peek(data,u_tick)-65
		return peek(data,u_tick)-32
	}
	return 0
#global
