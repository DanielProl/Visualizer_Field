

// Considerar la idea de meter la FFT con 

//      FFT(int timeSize, float sampleRate)

// Constructs an FFT that will accept sample buffers 
// that are timeSize long and have been recorded 
// with a sample rate of sampleRate. 
// timeSize must be a power of two. 
// This will throw an exception if it is not.




import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.effects.*;
import ddf.minim.analysis.*;


Minim minim;
AudioInput in,in2;

int Nv= 100;  // Number of vertex
int Nh= ceil(sqrt((1.0)*Nv));  // Nº vertex in height (4:3)
int Nw= floor(sqrt((1.0)*Nv)*(1.0));  // Nº vertex in width (4:3)
int H= 400;
int W= 400;
int Ih= floor(H/Nh);   // Increment in height
int Iw= floor(W/Nw);   // Increment in width
float sensibilidad=500;
float sensibilidad2=500;
float x,pm,pm1;
float mic,mic2;
int Namp=30;
int rect_side = 300; //set the side size of the rectangle
float leftColor = 100;//set the initial color of the rectangle
int pointer = 0;//With the pointer we indicate the output value.
int sombra= -20; 
int sombraclr= 60;

void setup() {
  
  
  size(1280, 800, OPENGL);
  frameRate(50);
  sphereDetail(6);
  smooth();
  noiseDetail(2);
  noiseSeed(3);
  minim = new Minim(this);
  minim.debugOn();
  in = minim.getLineIn(Minim.MONO, 512);
  in2 = in;
  LowPassSP bpf = new LowPassSP(150, in2.sampleRate());
  in2.addEffect(bpf);
  

}

void draw() {
  

if (mousePressed) {
sensibilidad = mouseX-(rect_side/2);
sensibilidad2 = mouseY-(rect_side/2);
}


println(pointer);
  
  background(0); 
  x=x+0.007;
  translate(width/2,height/2);
//  rotateX(radians(-20)+x);
//  rotateY(radians(45)+x);
  rotateX(radians(-20));
  rotateY(radians(45));


  translate(-W/2-Iw/2,0,-H/2-Ih/2);

  noStroke();

  for (int j = 0; j < Nw+1; j++){
    for (int i = 0; i < Nh+1; i++){
      
      pm1=(in2.left.get(i+j)+2*in2.left.get(i+j+1)+in2.left.get(i+j+2))/4;
      pm=pm1*sensibilidad+(noise(x+i+j)+2*noise(x+i+j+1)+noise(x+i+j+2))*Namp/4;
      translate(j*Iw+Iw/2,-abs(pm*3),i*Ih+Ih/2);
  
      fill(noise(x+0.4+i*0.02+j*0.02)*400,noise(x+0.4+1+i*0.02+j*0.02)*400,noise(x+0.4+2+i*0.02+j*0.02)*400);
      sphere(in.left.get(i+j)*sensibilidad2+1);
      translate(-j*Iw-Iw/2,abs(pm*3),-i*Ih-Ih/2);

      beginShape(TRIANGLE_FAN);
      fill(noise(x+i*0.02+j*0.02)*255-sombraclr,noise(x+1+i*0.02+j*0.02)*255-sombraclr,noise(x+2+i*0.02+j*0.02)*255-sombraclr);
      vertex(j*Iw+Iw/2,pm-pm1*sensibilidad-sombra,i*Ih+Ih/2);
      fill(noise(x+i*0.02+j*0.02)*255-sombraclr,noise(x+1+i*0.02+j*0.02)*255-sombraclr,noise(x+2+i*0.02+j*0.02)*255-sombraclr);
      vertex(j*Iw,noise(x+i+j)*Namp-sombra,i*Ih);
      vertex(j*Iw,noise(x+i+j+1)*Namp-sombra,(i+1)*Ih);
      vertex((j+1)*Iw,noise(x+i+j+2)*Namp-sombra,(i+1)*Ih);
      vertex((j+1)*Iw,noise(x+i+j+1)*Namp-sombra,i*Ih);
      vertex(j*Iw,noise(x+i+j)*Namp-sombra,i*Ih);
      endShape();

      beginShape(TRIANGLE_FAN);
      fill(noise(x+i*0.02+j*0.02)*255,noise(x+1+i*0.02+j*0.02)*255,noise(x+2+i*0.02+j*0.02)*255);
      vertex(j*Iw+Iw/2,pm-pm1*sensibilidad,i*Ih+Ih/2);
      fill(noise(x+i*0.02+j*0.02)*255,noise(x+1+i*0.02+j*0.02)*255,noise(x+2+i*0.02+j*0.02)*255);
      vertex(j*Iw,noise(x+i+j)*Namp,i*Ih);
      vertex(j*Iw,noise(x+i+j+1)*Namp,(i+1)*Ih);
      vertex((j+1)*Iw,noise(x+i+j+2)*Namp,(i+1)*Ih);
      vertex((j+1)*Iw,noise(x+i+j+1)*Namp,i*Ih);
      vertex(j*Iw,noise(x+i+j)*Namp,i*Ih);
      endShape();
    }
  }  

         translate(W/2+Iw/2,0,H/2+Ih/2); 
}


