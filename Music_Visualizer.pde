import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;
BeatDetect beat;
AudioInput in;
int tempo = 0;
int whichVis = 1;
Button[] buttons;
java.io.File folder;
java.io.FilenameFilter jpgFilter = new java.io.FilenameFilter() {
  boolean accept(File dir, String name) {
    return name.toLowerCase().endsWith(".mp3");
  }
};
java.io.FilenameFilter jpgFilter1 = new java.io.FilenameFilter() {
  boolean accept(File dir, String name) {
    return name.toLowerCase().endsWith(".m4a");
  }
};
String[] filenames;
String[] filenames1;

AudioPlayer[] player;
FFT fft;
int selected = 0;
boolean menu = true;
int transMax;
int transAmount = 0;
void setup()
{
  size(512, 200);
  folder = new java.io.File(dataPath(""));
  filenames = folder.list(jpgFilter);
  filenames1 = folder.list(jpgFilter1);

  for (int i = 0; i < filenames1.length; i++)
  {
    filenames = append(filenames, filenames1[i]);
  }
  buttons = new Button[filenames.length];

  minim = new Minim(this);
 // minim.debugOn();
  player = new AudioPlayer[filenames.length];
  in = minim.getLineIn(Minim.STEREO, int(1024));
  beat = new BeatDetect();


  for (int i = 0; i < player.length; i++)
  {
    player[i] = minim.loadFile(filenames[i]);
  }
  for (int i = 0; i < buttons.length; i++)
  {
    buttons[i] = new Button(i*150, i);
  }
  transMax = width-(buttons.length*150);
  fft = new FFT(player[selected].bufferSize(), player[selected].sampleRate());
}
void draw()
{
  colorMode(RGB, 255, 255, 255);
  background(0);
  if (menu)
  {
    translate(transAmount, 0);

    menu();
  }
  else
  {
    visualize();
  }
}
void menu()
{
  for (int i = 0; i < buttons.length; i++)
  {
    buttons[i].display();
    buttons[i].ifPressed();
  }
}
void visualize()
{
  beat.detect(in.mix);
  fill(255);
  if (whichVis == 1) 
  {
    visualize1();
  }
  else if (whichVis == 2)
  {
    visualize2();
  }
  else if (whichVis == 3)
  {
    visualize3();
  }  
  else if (whichVis == 4)
  {
    visualize4();
  }
  else if (whichVis == 5)
  {
    visualize5();
  }
}
void keyPressed()
{
  if (keyCode == RIGHT)
  {
    transAmount-=10;
    if (transAmount < transMax)
    {
      transAmount = transMax;
    }
  }
  if (keyCode == LEFT)
  {
    transAmount+=10;
    if (transAmount > 0)
    {
      transAmount = 0;
    }
  }
}
void mousePressed()
{
  if (!menu)
  {
    whichVis++;
  }
  if (whichVis > 5)
  {
    whichVis = 1;
  }
}

