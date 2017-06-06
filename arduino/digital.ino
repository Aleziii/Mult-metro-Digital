int d[8];
  
void setup(){
  Serial.begin(9600);
  pinMode(2,INPUT);
  pinMode(3,INPUT);
  pinMode(4,INPUT);
  pinMode(5,INPUT);
  pinMode(6,INPUT);
  pinMode(7,INPUT);
  pinMode(8,INPUT);
  pinMode(9,INPUT);
}
void loop(){
  String valor = "";
  /*
  d[0] = digitalRead(2);
  d[1] = digitalRead(3);
  d[2] = digitalRead(4);
  d[3] = digitalRead(5);
  d[4] = digitalRead(6);
  d[5] = digitalRead(7);
  d[6] = digitalRead(8);
  d[7] = digitalRead(9);
  */
 
  for(int i=9;i>=2;i--){
    valor.concat(digitalRead(i));
  }

  Serial.println(valor);
}
