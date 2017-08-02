package imagecreator;

import java.io.IOException;

public class TimeStepper {

	public Stackholder Stacks = new Stackholder();
	public static Demo lApp;
	public float globMin;
	public float locMax;
	public float lowStep;
	public float StepVari;
	
	public TimeStepper(float minStep, float StepSpan)
	{
		lowStep=minStep;
		StepVari=StepSpan;
		globMin=1/0;
	}
	
	public void scanstacks()
	{
		for (int i=0;i<Stacks.Cache.length;i++)
		{
			if (Stacks.Cache[i]<globMin)
			{
				globMin=Stacks.Cache[i];
			}
		}
		locMax=Stacks.Cache[0];
		for (int i=1;i<Stacks.Cache.length;i++)
		{
			if (Stacks.Cache[i]>locMax)
			{
				locMax=Stacks.Cache[i];
			}
		}
	}
	
	public float computeStep(){
		float locDist = (((Stacks.Cache[0]+Stacks.Cache[1])/2)-globMin)/
									(locMax-globMin);
		float step = lowStep+(locDist*StepVari);
		return step;
	}
	
	public void assignCache() throws InterruptedException, IOException{
		for (int i=0;i<Stacks.Cache.length;i++)
		Stacks.Cache = lApp.CompareDemoImages();
	}
}