class Button
{
  int x;
  int whichPlayer;
  AudioMetaData meta;

  Button(int _x, int _player)
  {
    x=_x;
    whichPlayer = _player;
    meta = player[whichPlayer].getMetaData();
  }
  void display()
  {
    fill(255);
    textAlign(LEFT);
    textSize(8);
    text(meta.title(), x, height/2-50);
    text(meta.author(), x, height/2-40); 
    stroke(255);
    noFill();
    rect(x+1, height/2-35, 50, 50);
    fill(255);
    noStroke();
    triangle(x+10, height/2-30, x+10, height/2+5, x+45, height/2-10);
   // translate(0,0);
  }
  void ifPressed()
  {
    if (mouseX > x+1+transAmount && mouseX < x+51+transAmount && mouseY > height/2-40 && mouseY < height/2+10 && mousePressed)
    {
      selected = whichPlayer;
      //player[whichPlayer].play();
      menu = false;
    }
  }
}

