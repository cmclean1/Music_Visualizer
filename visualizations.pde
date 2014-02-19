void visualize1()
{
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
}
void visualize2()
{
  stroke(random(255), random(255), random(255));

  for (int i = 0; i < player[selected].left.size() - 1; i++)
  {
    line(i, 50 + player[selected].left.get(i)*50, i+1, 50 + player[selected].left.get(i+1)*50);
    line(i, 150 + player[selected].right.get(i)*50, i+1, 150 + player[selected].right.get(i+1)*50);
  }
}
void visualize3()
{
  stroke(random(255), random(255), random(255));
  for (int i = 0; i < player[selected].left.size() - 1; i++)
  {
    line(mouseX, mouseY, mouseX + player[selected].left.get(i)*50, mouseY + player[selected].right.get(i)*50);
    line(mouseX, mouseY, mouseX - player[selected].right.get(i)*50, mouseY - player[selected].left.get(i)*50);
    line(mouseX, mouseY, mouseX + player[selected].left.get(i)*-50, mouseY + player[selected].right.get(i)*-50);
    line(mouseX, mouseY, mouseX - player[selected].right.get(i)*-50, mouseY - player[selected].left.get(i)*-50);
  }
}
void visualize4()
{
  fill(random(255), random(255), random(255));
  for (int i = 0; i < player[selected].mix.size(); i++)
  {
    noStroke();
    fft.forward(player[selected].mix);
    ellipse((player[selected].mix.size()-i), height/2, player[selected].mix.get(i)*50, player[selected].mix.get(i)*50);
  }
}
void visualize5()
{
  colorMode(HSB, 360, 100, 100);
  color c = color((frameCount % 360), 100, 100);
  stroke((360-(frameCount % 360)), 100, 100);
  strokeWeight(1);
  for (int i = 0; i < player[selected].mix.size(); i++)
  {
    float wut = i;
    line(cos(degrees(map(wut, 0, player[selected].mix.size(), 0, 360)))*25+(width/2), (height/2)+sin(degrees(map(wut, 0, player[selected].mix.size(), 0, 360)))*25, cos(degrees(map(wut, 0, player[selected].mix.size(), 0, 360)))*abs(player[selected].mix.get(i))*1000+(width/2), (height/2)+sin(degrees(map(wut, 0, player[selected].mix.size(), 0, 360)))*abs(player[selected].mix.get(i))*1000);
  }
  fill(c);
  noStroke();
  ellipse(width/2, height/2, 60+(player[selected].mix.get(0)*10), 60+(player[selected].mix.get(0)*10));
}

