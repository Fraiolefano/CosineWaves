tInputs1=document.getElementsByName("tInput1");
tInputs2=document.getElementsByName("tInput2");

lInputs1=document.getElementsByName("lInput1");
lInputs2=document.getElementsByName("lInput2");

aInputs1=document.getElementsByName("aInput1");
aInputs2=document.getElementsByName("aInput2");
function initInputs()
{
  tInputs1[0].value=4;tInputs2[0].value=4;
  tInputs1[1].value=2;tInputs2[1].value=2;
  tInputs1[2].value=0.5;tInputs2[2].value=0.5;
  
  lInputs1[0].value=1;lInputs2[0].value=1;
  lInputs1[1].value=-0.5;lInputs2[1].value=-0.5;
  lInputs1[2].value=0.05;lInputs2[2].value=0.05;

  aInputs1[0].value=100;aInputs2[0].value=100;
  aInputs1[1].value=-100;aInputs2[1].value=-100;
  aInputs1[2].value=15;aInputs2[2].value=15;
}

var waves=[];
var wSum;
time=0;
function setup()
{
  pixelDensity(1);
  initInputs();
  if (page.orientation)
  {
    createCanvas(window_size,window_size*1.75);
  }
  else
  {
    createCanvas(window_size,window_size);
  }
  waves[0]=new Wave(aInputs1[0].value,(2*PI)/tInputs1[0].value,(2*PI)/(lInputs1[0].value*width));
  waves[1]=new Wave(aInputs1[1].value,(2*PI)/tInputs1[1].value,(2*PI)/(lInputs1[1].value*width));
  waves[2]=new Wave(aInputs1[2].value,(2*PI)/tInputs1[1].value,(2*PI)/(lInputs1[2].value*width));
  wSum=new Wave(0,0,0);
  generateButtons();
  changeColoration(0);
}

function draw()
{
  time=millis()/1000.0;
  background(0);


  if (page.orientation==false)
  {
    scale(1,0.25);
  }

  translate(0,150);
  waves[0].update(time);
  translate(0,250);
  waves[1].update(time);
  translate(0,250);
  waves[2].update(time);
  translate(0,550);
  wSum.sum(waves);
  wSum.shot();


}


function initWave(waveIndex)
{
  waves[waveIndex].a=aInputs1[waveIndex].value;
  waves[waveIndex].v=(2*PI)/tInputs1[waveIndex].value;
  waves[waveIndex].k=(2*PI)/(lInputs1[waveIndex].value*width);
}

function changeColoration(colorIndex)
{
  switch (colorIndex)
  {
    case 0:
      waves[0].setColor(color("#005555"));
      waves[1].setColor(color("#069A8E"));
      waves[2].setColor(color("#A1E3D8"));
      wSum.setColor(color("#F7FF93"));
      break;
    case 1:
      waves[0].setColor(color("#247881"));
      waves[1].setColor(color("#43919B"));
      waves[2].setColor(color("#30AADD"));
      wSum.setColor(color("#00FFC6"));
      break;
    case 2:
      waves[0].setColor(color("#006778"));
      waves[1].setColor(color("#0093AB"));
      waves[2].setColor(color("#00AFC1"));
      wSum.setColor(color("#FFD124"));
      break;
    case 3:
      waves[0].setColor(color("#143F6B"));
      waves[1].setColor(color("#F55353"));
      waves[2].setColor(color("#FEB139"));
      wSum.setColor(color("#F6F54D"));
      break;
    case 4:
      waves[0].setColor(color("#001E6C"));
      waves[1].setColor(color("#035397"));
      waves[2].setColor(color("#E8630A"));
      wSum.setColor(color("#FCD900"));
      break;

    case 5:
      waves[0].setColor(color("#FF5F00"));
      waves[1].setColor(color("#B20600"));
      waves[2].setColor(color("#0a2382"));
      wSum.setColor(color("#EEEEEE"));
      break;
    case 6:
      waves[0].setColor(color("#4700D8"));
      waves[1].setColor(color("#9900F0"));
      waves[2].setColor(color("#F900BF"));
      wSum.setColor(color("#FF85B3"));
      break;
    case 7:
      waves[0].setColor(color("#FFD36E"));
      waves[1].setColor(color("#FFF56D"));
      waves[2].setColor(color("#99FFCD"));
      wSum.setColor(color("#9FB4FF"));
      break;
    case 8:
      waves[0].setColor(color("#332FD0"));
      waves[1].setColor(color("#9254C8"));
      waves[2].setColor(color("#E15FED"));
      wSum.setColor(color("#6EDCD9"));
      break;
    case 9:
      waves[0].setColor(color("#630606"));
      waves[1].setColor(color("#890F0D"));
      waves[2].setColor(color("#E83A14"));
      wSum.setColor(color("#D9CE3F"));
      break;

  }
}

function generateButtons()
{
  buttonDiv=document.getElementById("colorButtons");
  for(let c=0;c<10;c++)
  {
    divEl=document.createElement("DIV");
    divEl.style="width:9%;display:inline-block;height:50px;";//border:white solid
    radioB=document.createElement("input");
    radioB.setAttribute("type","radio");
    radioB.name="colorations";
    radioB.value=c;
    radioB.onclick=function(){changeColoration(c)};
    radioB.style="width:50px;height:50px;accent-color:orange;";
    if (c==0){radioB.setAttribute("checked",true); }
    divEl.append(radioB);
    buttonDiv.append(divEl);
  }
}

function saveShot()
{
  nowTime=year()+"_"+month()+"_"+day()+"-"+hour()+"-"+minute()+"-"+second();
  imageName="./imgs/sineWaves"+"_"+nowTime+".png";
  save(imageName);
  console.log("Saved : "+imageName);
}