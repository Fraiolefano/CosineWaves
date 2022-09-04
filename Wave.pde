public class Wave
{
  float amplitude;
  float angularVelocity;
  float waveNumber;
  float waveLength;
  float fi;
  PVector[] points;
  int nPoints=300;
  float xUnit=1;
  color lineColor;
  color pointColor;
  float period=0;
  public Wave(float ampl,float period,float waveLength)
  {
    amplitude=ampl;
    fi=0;
    if (period==0)
    {
      period=0.0000001;
    }
    angularVelocity=(2*PI)/period;
    this.period=period;

    if (waveLength==0)
    {
      waveLength=0.0000001;
    }
    this.waveLength=waveLength;
    this.waveNumber=(2*PI)/waveLength;
    
    lineColor=color(0,255,127);
    pointColor=color(0,255,127);
    this.init(300,1);
  }
  public void setWaveLength(float wl)
  {
    this.waveLength=wl;
    this.waveNumber=( (2*PI)/this.waveLength);
  }
  public void setPeriod(float T)
  {
    this.period=T;
    this.angularVelocity=((2*PI)/this.period);
  }
  public void setAngularVelocity(float av)
  {
    this.angularVelocity=av;
  }
  
  public void init(int nPoints,int xUnit)
  {

    points=new PVector[nPoints];
    this.nPoints=nPoints;
    this.xUnit=xUnit;
    for(int c=0;c<nPoints;c++)
    {
      points[c]=new PVector(xUnit*c,0);
    }
  }
  
  public void update()
  {
    for(int c=0;c<nPoints;c++)
    {
       points[c]=new PVector(xUnit*c,amplitude*sin(angularVelocity*(millis()/1000.0)-waveNumber*c*xUnit));
    }
  }
  public void draw1() //draw points
  {
    stroke(pointColor);
    strokeWeight(5);
    for (int p=0;p<nPoints;p++)
    {
      if (p%5==0)
      {
        point(points[p].x,points[p].y);
      }
    }
  }
  
  public void draw2() // draw lines
  {
    stroke(lineColor);
    for (int p=1;p<nPoints;p++)
    {
      line(points[p].x,points[p].y,points[p-1].x,points[p-1].y);
    }
  }

  public void draw3() // draw lines and points
  {
    for (int p=1;p<nPoints;p++)
    {
      stroke(lineColor);
      strokeWeight(1);
      line(points[p].x,points[p].y,points[p-1].x,points[p-1].y);
      if (p%5==0)
      {
        stroke(pointColor);
        strokeWeight(5);
        point(points[p].x,points[p].y);
      }
    }
  }
  public void draw4() // artistically draw lines and points
  {
    for (int p=1;p<nPoints;p++)
    {
      stroke(lineColor);
      strokeWeight(noise(p)*3);
      line(points[p].x,points[p].y,points[p-1].x,points[p-1].y);
      if (p%5==0)
      {
        stroke(pointColor);
        strokeWeight( noise(p)*10);
        point(points[p].x,points[p].y);
      }
    }
  }
  public void draw5() // artistically draw lines and points
  {
    float heightVariation=0;
    float strokeSize=0;
    for (int p=1;p<nPoints;p++)
    {
      stroke(lineColor);
      // strokeWeight(noise(p)*3);
      heightVariation=abs(( points[p].y/(float)(amplitude)));
      strokeWeight(noise(p)*5);
      line(points[p].x,points[p].y,points[p-1].x,points[p-1].y);
      if (p%5==0)
      {
        stroke(pointColor);
        strokeSize=noise(p)*heightVariation*15;
        if (strokeSize<1){strokeSize=1;}
        else if(strokeSize>15){strokeSize=15;}
        strokeWeight(strokeSize);
        point(points[p].x,points[p].y);
      }
    }
  }
  public void draw6() // draw lines artistically
  {
    stroke(lineColor);
    for (int p=1;p<nPoints;p++)
    {
      strokeWeight(noise(p)*15);
      line(points[p].x,points[p].y,points[p-1].x,points[p-1].y);
    }
  }
  public void draw7() // draw points artistically
  {
    stroke(pointColor);
    float heightVariation=0;
    float strokeSize=0;
    for (int p=1;p<nPoints;p++)
    {
      if(p%5==0)
      {
        heightVariation=abs(( points[p].y/(float)(amplitude)));
        strokeSize=noise(p)*heightVariation*10;
        if (strokeSize<1){strokeSize=1;}
        else if(strokeSize>10){strokeSize=10;}
        strokeWeight(strokeSize);
        line(points[p].x,points[p].y,points[p-1].x,points[p-1].y);
      }
    }
  }
  public void draw8() // draw lines and a points
  {
    for (int p=1;p<nPoints;p++)
    {
      stroke(lineColor);
      strokeWeight(2);
      line(points[p].x,points[p].y,points[p-1].x,points[p-1].y);
      if (p%5==0)
      {
        stroke(pointColor);
        strokeWeight( noise(p)*10);
        point(points[p].x,points[p].y);
      }
    }
  }
  public void draw9() // artistically draw lines and points at max
  {
    float heightVariation=0;
    float strokeSize=0;
    for (int p=1;p<nPoints;p++)
    {
      stroke(lineColor);
      // strokeWeight(noise(p)*3);
      heightVariation=abs(( points[p].y/(float)(amplitude)));
      if (heightVariation>1){heightVariation=1;}
      //if (heightVariation>2){heightVariation=2;}
      strokeWeight(0);
      line(points[p].x,points[p].y,points[p-1].x,points[p-1].y);
      if (p%2==0)
      {
        stroke(pointColor);
        strokeSize=(heightVariation*10);
        //if (strokeSize<1){strokeSize=1;}
      //  else if(strokeSize>15){strokeSize=15;}
        strokeWeight(strokeSize);
        point(points[p].x,points[p].y);
      }
    }
  }
  public void draw(int mode)
  {
    switch (mode)
    {
      case 0:
        draw1();
        break;
      case 1:
        draw2();
        break;
      case 2:
        draw3();
        break;
      case 3:
        draw4();
        break;
      case 4:
        draw5();
        break;
      case 5:
        draw6();
        break;
      case 6:
        draw7();
        break;
      case 7:
        draw8();
        break;
      case 8:
        draw9();
        break;
    }
  }
  public void sum(Wave[] waveArray)
  {
      float[] tmpHeights=new float[nPoints];
      
      for(int w=0;w<waveArray.length;w++)
      {
        for(int p=0;p<nPoints;p++)
        {
          tmpHeights[p]+=waveArray[w].points[p].y;
          points[p].y=tmpHeights[p];
        }
      }
  }
}
