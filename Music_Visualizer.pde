import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;
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
  player = new AudioPlayer[filenames.length];
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
  player[selected].play();
  // first perform a forward fft on one of song's buffers
  // I'm using the mix buffer
  //  but you can use any one you like
  fft.forward(player[selected].left);

  stroke(255, 0, 0, 128);
  for (int i = 0; i < fft.specSize(); i++)
  {
    line(i, height, i, height - fft.getBand(i)*4);
  }
  stroke(0, 0, 255, 128);

  fft.forward(player[selected].right);
  for (int i = 0; i < fft.specSize(); i++)
  {
    line(width-i, height, width-i, height - fft.getBand(i)*4);
  }
  stroke(random(255), random(255), random(255));

  for (int i = 0; i < player[selected].left.size() - 1; i++)
  {
    line(i, 50 + player[selected].left.get(i)*50, i+1, 50 + player[selected].left.get(i+1)*50);
    line(i, 150 + player[selected].right.get(i)*50, i+1, 150 + player[selected].right.get(i+1)*50);
  }
  stroke(random(255), random(255), random(255));
  for (int i = 0; i < player[selected].left.size() - 1; i++)
  {
    line(mouseX, mouseY, mouseX + player[selected].left.get(i)*50, mouseY + player[selected].right.get(i)*50);
    line(mouseX, mouseY, mouseX - player[selected].right.get(i)*50, mouseY - player[selected].left.get(i)*50);
    line(mouseX, mouseY, mouseX + player[selected].left.get(i)*-50, mouseY + player[selected].right.get(i)*-50);
    line(mouseX, mouseY, mouseX - player[selected].right.get(i)*-50, mouseY - player[selected].left.get(i)*-50);
  }
  fill(random(255), random(255), random(255));
  for (int i = 0; i < player[selected].mix.size(); i++)
  {
    noStroke();
    fft.forward(player[selected].mix);
    ellipse((player[selected].mix.size()-i), height/2, player[selected].mix.get(i)*50, player[selected].mix.get(i)*50);
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

