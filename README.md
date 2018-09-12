# Arduino-Sound-Processor
Arduinoに接続した圧電ブザーなどから音楽を鳴らすためのプログラム郡です。
PC側から音楽を鳴らす司令を出し(HSP3製ドライバ、MIDIAPIの改造版)、Arduino側は解釈して実際の発音を行います。
# How to use
1. Arduino-SP-1/Arduino-SP-1.inoをArduinoに書き込みます。
2. ArduinoのCOMポートをどうにかして調べます。
3. 鍵盤の電源をつけるときにパラメータに調べたCOMポートを書きます。
4. 動きます。
