//Arduino-Sound-Processor type1 version 0.1 beta

#define AVAILABLE_CHANNEL_COUNT 1
byte data_recieved;
double freq[AVAILABLE_CHANNEL_COUNT];
byte chpower[AVAILABLE_CHANNEL_COUNT];
byte current_ch;
byte recieve_mode;
void setup() {
  Serial.begin(9600);
  for (byte i=0;i<AVAILABLE_CHANNEL_COUNT;i++){
    freq[i]=0.0;
    chpower[i]=0;
  }
    current_ch=0;
}

void loop() {
  while (Serial.available()>0){
      data_recieved=Serial.read();
      switch (recieve_mode){
        case 0:
          if (data_recieved>='0' & data_recieved<='9'){
            freq[current_ch]=freq[current_ch]*10+(data_recieved-'0');
          }
          if (data_recieved=='.'){
            //周波数データ削除
            freq[current_ch]=0.0;
          }
          if (data_recieved=='-'){
            //ノートオフ
            chpower[current_ch]=0;
          }
          if (data_recieved=='+'){
            //ノートオン
            chpower[current_ch]=1;
          }
          if (data_recieved==':'){
            //カレントチャンネル変更()
            recieve_mode=1;
          }
          if (data_recieved=='?'){
            //デバッグデータ出力
            Serial.print("Arduino-SP-Type1\n");
            Serial.print(chpower[i]);
            Serial.print(" ");
            Serial.print(freq[i]);
            Serial.print("\n");
          }
          break;
        case 1:
          current_ch=(data_recieved-'0');
          if (current_ch<0){
            current_ch=0;
          }
          if (current_ch>AVAILABLE_CHANNEL_COUNT-1){
            current_ch=AVAILABLE_CHANNEL_COUNT-1;
          }
          recieve_mode=0;
      }
  }
  for (byte i=0;i<AVAILABLE_CHANNEL_COUNT;i++){
    if (chpower[i]==1){
      tone(9+i,freq[i]);
    }else{
      noTone(9+i);
    }
  }
}
