Wave w1;
Wave w2;
Wave w3;

Wave[] wavesToSum;



int heightPos=0;

WindowSection main,menu;

Slider sliderAmplitude;
Slider sliderAmplitude2;
Slider sliderWaveL;
Slider sliderWaveL2;
Slider sliderPuls;
Slider sliderPuls2;
Radio colorRadio;
Radio drawRadio;
Button kSign1;
Button kSign2;

int colorIndex=0;
int drawIndex=0;
color bgColor;
color linesColor;
color pointColor;
color w1LColor;
color w2LColor;
color w3LColor;
color w1PColor;
color w2PColor;
color w3PColor;

void setup()
{
  //size(600,600);
  fullScreen();
  initWindows();
  setOptions();
  w1=new Wave(height/8.0,5,height/4);
  w2=new Wave(height/8.0,5,height/4);
  w3=new Wave(0,0,0);
  
  wavesToSum=new Wave[2];
  wavesToSum[0]=w1;
  wavesToSum[1]=w2;
  
  int np=int(height/2.0);
  w1.init(np,2);
  w2.init(np,2);
  w3.init(np,2);
  w3.amplitude=w1.amplitude+w2.amplitude;
  //w2.col=color(255,0,0);
  
  strokeWeight(1);
  linesColor=color(255,0,0);

  textAlign(CENTER);

  colorMode();
  
  w1.amplitude=sliderAmplitude.range.z;
  w2.amplitude=sliderAmplitude2.range.z;
  w3.amplitude=w1.amplitude+w2.amplitude;

  w1.setWaveLength(height/sliderWaveL.range.z);
  w2.setWaveLength(height/sliderWaveL2.range.z);
  w1.setPeriod(sliderPuls.range.z);
  w2.setPeriod(sliderPuls2.range.z);
  w2.angularVelocity=-w2.angularVelocity;
  
  drawIndex=int(drawRadio.values.y);
}

//funzione d'onda y= A * sin(omega* t - k(x) )
void draw()
{

  onChange();

  resetMatrix();
  
  main.bgColor=bgColor;
  main.draw();
  menu.draw();
  drawLines();
  
  
  w1.update();
  w2.update();
  w3.sum(wavesToSum);
  
  translate(0,height/8);
  w1.draw(drawIndex);
  translate(0,height/4);
  w2.draw(drawIndex);
  translate(0,height*(3/8.0));
  w3.draw(drawIndex);
}


void drawLines()
{
  stroke(linesColor);
  line(0,height/4.0,height,height/4.0);
  line(0,height/2.0,height,height/2.0);
}

void initWindows()
{
  main=new WindowSection(new PVector(0,0),new PVector(height,height));
  menu=new WindowSection(new PVector(height,0),new PVector(width-height,height));
  menu.stepSize=height/20.0;
  menu.scrollRange=new PVector(-25*menu.stepSize,0);
  
  main.bgColor=color(0);
  menu.bgColor=color(0);
}

void setOptions()
{
  float centerX=menu.size.x/2.0;
  float barW=menu.size.x-menu.stepSize;
  TextElem title_o=new TextElem("Sine waves",new PVector(centerX,menu.stepSize));
  title_o.fontSize=30;
  
  TextElem author_o=new TextElem("By "+"Fraiolefano",new PVector(centerX,menu.stepSize*1.5));
  author_o.fontSize=15;
  
  sliderAmplitude=new Slider("Ampiezza 1",new PVector(centerX,menu.stepSize*3),new PVector(-height/8.0,height/8.0,int(height/16.0)),1,barW);
  sliderAmplitude2=new Slider("Ampiezza 2",new PVector(centerX,menu.stepSize*4.8),new PVector(-height/8.0,height/8.0,int(height/16.0)),1,barW);
  
  sliderWaveL=new Slider("Lunghezza d'onda 1 (width/l)",new PVector(centerX,menu.stepSize*6.6),new PVector(0,20,20),0.1,barW);
  sliderWaveL2=new Slider("Lunghezza d'onda 2 (width/l)",new PVector(centerX,menu.stepSize*8.8),new PVector(0,20,18),0.1,barW);

  sliderPuls=new Slider("Periodo 1",new PVector(centerX,menu.stepSize*10.6),new PVector(0,10,2),0.1,barW);
  sliderPuls2=new Slider("Periodo 2",new PVector(centerX,menu.stepSize*12.4),new PVector(0,10,2),0.1,barW);

  kSign1=new Button(">>>>",new PVector(centerX-(centerX/2.0),menu.stepSize*14),new PVector(200,50));
  kSign1.fontSize=50;

  kSign2=new Button("<<<<",new PVector(centerX+(centerX/2.0),menu.stepSize*14),new PVector(200,50));
  kSign2.fontSize=50;

  colorRadio=new Radio("Color mode",new PVector(centerX,menu.stepSize*17),new PVector(6,5));
  colorRadio.boxDist=menu.size.x/colorRadio.values.x;

  drawRadio=new Radio("Drawing mode",new PVector(centerX,menu.stepSize*20),new PVector(9,8));
  drawRadio.boxDist=menu.size.x/drawRadio.values.x;

  menu.windowElements.add(title_o);
  menu.windowElements.add(author_o);
  menu.windowElements.add(sliderAmplitude);
  menu.windowElements.add(sliderAmplitude2);
  
  menu.windowElements.add(sliderWaveL);
  menu.windowElements.add(sliderWaveL2);
  
  menu.windowElements.add(sliderPuls);
  menu.windowElements.add(sliderPuls2);

  menu.windowElements.add(kSign1);
  menu.windowElements.add(kSign2);
  menu.windowElements.add(colorRadio);
  menu.windowElements.add(drawRadio);

  menu.initElements();
}

void mousePressed()
{
  menu.mousePressed();
}
void mouseReleased()
{
  menu.mouseReleased();
}
void mouseWheel(MouseEvent e)
{
  float delta=-e.getCount()*10;
  menu.mouseWheel(delta);
}

void colorMode()
{
  colorIndex=int(colorRadio.values.y);
  switch (colorIndex)
  {
    case 0:
      bgColor=color(255,255,255);
      linesColor=color(0,0,255);
      pointColor=color(0,0,0);
      w1LColor=color(0,0,0);
      w2LColor=color(0,0,0);
      w3LColor=color(0,0,0);
      w1PColor=color(0,0,0);
      w2PColor=color(0,0,0);
      w3PColor=color(0,0,0);
      break;
    case 1:
      bgColor=color(0,0,0);
      linesColor=color(255,0,0);
      pointColor=color(255,255,255);
      w1LColor=color(255,255,255);
      w2LColor=color(255,255,255);
      w3LColor=color(255,255,255);
      w1PColor=color(255,255,255);
      w2PColor=color(255,255,255);
      w3PColor=color(255,255,255);
      break;
    case 2:
      bgColor=color(0,0,0);
      linesColor=color(0,127,255);
      pointColor=color(255,255,255);
      w1LColor=color(0,255,127);
      w2LColor=color(0,255,127);
      w3LColor=color(0,255,127);
      w1PColor=color(0,255,127);
      w2PColor=color(0,255,127);
      w3PColor=color(0,255,127);
      break;
    case 3:
      bgColor=color(0,0,0);
      linesColor=color(0,255,127);
      pointColor=color(255,255,255);
      w1LColor=color(0,127,255);
      w2LColor=color(0,127,255);
      w3LColor=color(0,127,255);
      w1PColor=color(0,127,255);
      w2PColor=color(0,127,255);
      w3PColor=color(0,127,255);
      break;

    case 4:
      bgColor=color(0,0,0);
      linesColor=color(0,127,255);
      pointColor=color(255,255,255);
      w1LColor=color(0,255,127);
      w2LColor=color(0,255,127);
      w3LColor=color(0,255,127);
      w1PColor=color(0,127,255);
      w2PColor=color(0,127,255);
      w3PColor=color(0,127,255);
      break;
    case 5:
      bgColor=color(0,0,0);
      linesColor=color(0,255,127);
      pointColor=color(255,255,255);
      w1LColor=color(0,127,255);
      w2LColor=color(0,127,255);
      w3LColor=color(0,127,255);
      w1PColor=color(0,255,127);
      w2PColor=color(0,255,127);
      w3PColor=color(0,255,127);
      break;
  }

  w1.lineColor=w1LColor;
  w2.lineColor=w2LColor;
  w3.lineColor=w3LColor;
  w1.pointColor=w1PColor;
  w2.pointColor=w2PColor;
  w3.pointColor=w3PColor;
}

void onChange()
{
  if(menu.onChange().value)
  {
    if (menu.changed.el==sliderAmplitude)
    {
      w1.amplitude=sliderAmplitude.range.z;
      w3.amplitude=w1.amplitude+w2.amplitude;
    }
    else if (menu.changed.el==sliderAmplitude2)
    {
      w2.amplitude=sliderAmplitude2.range.z;
      w3.amplitude=w1.amplitude+w2.amplitude;
    }
    
    else if (menu.changed.el==sliderWaveL)
    {
      w1.setWaveLength(height/sliderWaveL.range.z);
      
    }
    else if (menu.changed.el==sliderWaveL2)
    {
      w2.setWaveLength(height/sliderWaveL2.range.z);
    }

    else if (menu.changed.el==sliderPuls)
    {
      w1.setPeriod(sliderPuls.range.z);
      
    }
    else if (menu.changed.el==sliderPuls2)
    {
      w2.setPeriod(sliderPuls2.range.z);
    }
    else if (menu.changed.el==colorRadio)
    {
      colorMode();
    }
    else if (menu.changed.el==drawRadio)
    {
      drawIndex=int(drawRadio.values.y);
    }

    else if (menu.changed.el==kSign1)
    {
      changeBtn(kSign1,w1);
    }
    else if (menu.changed.el==kSign2)
    {
      changeBtn(kSign2,w2);
    }

  }
}

void changeBtn(Button btnEl,Wave wToChange )
{
  if (btnEl.labelText==">>>>")
  {
    btnEl.labelText="<<<<";
    wToChange.angularVelocity=-abs(wToChange.angularVelocity);
  }
  else if (btnEl.labelText=="<<<<")
  {
    btnEl.labelText=">>>>";
    wToChange.angularVelocity=abs(wToChange.angularVelocity);
  }
}
