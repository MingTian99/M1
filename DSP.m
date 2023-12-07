#include "DSP28x_Project.h"     // Device Headerfile and Examples Include File
#include <math.h>

void WriteDAC(unsigned long data);
void delay(unsigned long);
void adm( float x,float y,float z,float yi[]);

#define N 1
float x[N],y[N],z[N],u[N];


void Buzz_Gpio_Init(void)
{
	EALLOW;
    GpioCtrlRegs.GPBPUD.bit.GPIO54 = 0;
    GpioCtrlRegs.GPBPUD.bit.GPIO56 = 0;
    GpioCtrlRegs.GPBPUD.bit.GPIO57 = 0;   									// Enable pullup on GPIO35
    GpioDataRegs.GPBSET.bit.GPIO54 = 1; 
    GpioDataRegs.GPBSET.bit.GPIO56 = 1;
    GpioDataRegs.GPBSET.bit.GPIO37 = 1; 									 // Load output latch
    GpioCtrlRegs.GPBMUX1.bit.GPIO35 = 0;
    GpioCtrlRegs.GPBMUX1.bit.GPIO36 = 0;
    GpioCtrlRegs.GPBMUX1.bit.GPIO37 = 0;  									// GPIO35 = GPIO
    GpioCtrlRegs.GPBDIR.bit.GPIO35 = 1; 
    GpioCtrlRegs.GPBDIR.bit.GPIO36 = 1;
    GpioCtrlRegs.GPBDIR.bit.GPIO37 = 1;  									// GPIO35 = output
    EDIS;
}
/*****************************************************************************************************/

/*****************************************************************************************************/
void main(void)
{
	float a[3];
	long mix[3];
	InitSysCtrl();
	DINT;					//关中断
	IER = 0x0000;
	IFR = 0x0000;

	Buzz_Gpio_Init(); 		//初始化GPIO
	
	
	
	x[0]=0.2;y[0]=0.5; z[0]=3;//initial value
	
    	GpioDataRegs.GPBSET.bit.GPIO35 = 1;   //SPISTEA=1
	for(;;)
	{
		adm(x[0],y[0],z[0],a);

		mix[0]=(a[0]+4)*3750;//a[0]:x,a[1]:y,a[2]:z
		mix[1]=(a[1]+4)*3750;
		x[0]=a[0];y[0]=a[1];
		mix[0]=0x000000+mix[0];
		mix[1]=0x340000+mix[1];
		WriteDAC(mix[0]);
		WriteDAC(mix[1]);
	}
}

void WriteDAC(unsigned long data)
{
	unsigned long send_bit;
	unsigned long yu=0x800000;
	int i;
		GpioDataRegs.GPBCLEAR.bit.GPIO35 = 1;   //SPISTEA=0
	//delay(10);
	for(i=0;i<24;i++)
	{
       GpioDataRegs.GPBSET.bit.GPIO36 = 1;   //SPICLK=1
	   //delay(10);
	   send_bit=data & yu;
	   if (send_bit!=0)
	      GpioDataRegs.GPBSET.bit.GPIO37 = 1;   //SPISIMO_15
	   else GpioDataRegs.GPBCLEAR.bit.GPIO37 = 1;
	   yu=yu>>1;
	   //delay(10);
	   GpioDataRegs.GPBCLEAR.bit.GPIO36 = 1;   //SPICLK=0
	   //delay(10);
	}
		GpioDataRegs.GPBSET.bit.GPIO35 = 1;   //SPISTEA=1	
}

void delay(unsigned long t)
{
	while(t>0)
    	t--;
}

void adm( float x,float y,float z,float yi[])
{
		float a,b,c,d,kk,e;
x=a/(1+x*x)+b+kk*(c+d*sin(y))*z;
y=y+e*z;
z=z+e*x;

	
}

