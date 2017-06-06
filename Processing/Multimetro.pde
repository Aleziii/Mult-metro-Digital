import processing.serial.*;

PImage img;
PFont fonte;
PImage b1On,b1Off,b2On,b2Off,vidro;
boolean ativo = false, hold = false;
PImage botao1, botao2;
float ponto, holdPonto;
String volt = "", sVolt="V";
float resolucao = 0.0195;
float tensao = 0;

ArrayList<Ponto> pontos = new ArrayList();
Serial serial;
void setup(){
  serial = new Serial(this,Serial.list()[32],9600);
  img = loadImage("/layers/principal.png");
  b1On = loadImage("/layers/sw-01-on.png");
  b1Off = loadImage("/layers/sw-01-off.png");
  b2On = loadImage("/layers/sw-02-on.png");
  b2Off = loadImage("/layers/sw-02-off.png");
  vidro = loadImage("/layers/vidro.png");
  botao1 = b1Off;
  botao2 = b2Off;
  fonte = loadFont("DS-Digital-48.vlw");
  size(800,600);
  surface.setTitle("Multímetro Digital");
}
void draw(){
  background(img);
  textFont(fonte);
  image(botao1,90,391);
  image(botao2,638,400);
  
  if(ativo){
    if(!hold){ //Se hold desativado ativa leitura da serial
      while(serial.available()>0){
        volt = serial.readStringUntil('\n');
        holdPonto = ponto;
        sVolt = "V";
      }
    }else{
      ponto = holdPonto;
    }
    tensao = converter(volt);
    ponto = tensao;
  }else{
    volt="";
    sVolt="";
  }
  Ponto P1 = new Ponto(width-14, map(ponto,0,5,262,83));
  pontos.add(P1);
  if(ativo){
    textSize(70);
    fill(113,113,113);
    text(tensao,310,441);
    textSize(50);
    text(sVolt,480,441);
  }
  noFill();
  stroke(0);
  if(ativo) beginShape();
  for (int i=0;i<(pontos.size()/2);i++){
    Ponto P = (Ponto)pontos.get(i);
    if(ativo) curveVertex(P.x, P.y);
    if (P.x<92)
      pontos.remove(i); 
    P.x = P.x - 93;
  }
  if(ativo) endShape();
  image(vidro,77,56);
}

/* Controle dos botoes */
void mouseClicked(){
  if(mouseX>90 && mouseX<137 && mouseY>396 && mouseY<442){
    botao1=b1On;
    ativo=true;
  }
  if(mouseX>137 && mouseX<194 && mouseY>396 && mouseY<442){
    botao1=b1Off;
    ativo=false;
  }
  if(mouseX>637 && mouseX<677 && mouseY>400 && mouseY<434){
    botao2=b2On;
    hold=true;
  }
  if(mouseX>677 && mouseX<715 && mouseY>400 && mouseY<434){
    botao2=b2Off;
    hold=false;
  }
}

/* Converter de binario para decimal com cálculo da tensão */
float converter(String binario){
  float resultado = 0, aux = 0;
  for(int i=7;i>=0;i--){
    if(binario.charAt(i) == '1'){
      resultado = resultado + pow(2,aux);
    }
    aux++;
  }
  return resultado * resolucao;
}

class Ponto {
  float x, y;
  Ponto(float x, float y) {
    this.x = x;
    this.y = y; 
  }
}
