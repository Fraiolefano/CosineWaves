class Wave
{
    constructor(amplitude,angularVelocity,angularWaveNumber)
    {
        this.a=amplitude;
        this.v=angularVelocity;
        this.k=angularWaveNumber;
        this.fi=0;

        this.col=color(0,255,0);
        this.nPoints=300;
        this.step=ceil(width/this.nPoints);
        this.points=[this.nPoints];
        
        for(let c=0;c<=this.nPoints;c++)
        {
        this.points[c]=new p5.Vector(c*this.step,0);
        }
        
        this.col=color(0,255,0);
    }
    shot()
    {
        stroke(this.col);
        for (let c=0;c<this.nPoints;c++)
        {
        let currentPoint=this.points[c];
        if (c>0)
            {
            let previousPoint=this.points[c-1];
            line(previousPoint.x,previousPoint.y,currentPoint.x,currentPoint.y);
            }
        }
    }
    
    update(t)
    {
        stroke(this.col);
        for (let c=0;c<this.nPoints;c++)
        {
        let currentPoint=this.points[c];
        currentPoint.y=this.a*cos((this.v*t)-(this.k*currentPoint.x));
        if (c>0)
            {
            let previousPoint=this.points[c-1];
            line(previousPoint.x,previousPoint.y,currentPoint.x,currentPoint.y);
            }
        }
    }
  
    sum(waves)
    {
        for (let c=0;c<this.nPoints;c++)
        {
            let yVal=0;
            for (let w=0;w<waves.length;w++)
            { 
            yVal+=waves[w].points[c].y;
            }
            this.points[c]=new p5.Vector(this.points[c].x,yVal);
        }
    }

    setColor(col)
    {
        this.col=col;
    }
  
};
