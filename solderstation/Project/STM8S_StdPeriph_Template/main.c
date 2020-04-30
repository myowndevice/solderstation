/**
  ******************************************************************************
  * @file    Project/main.c 
  * @author  MCD Application Team
  * @version V2.2.0
  * @date    30-September-2014
  * @brief   Main program body
   ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */ 


/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"

//time
u8 ind[3]={0,0,0};
u8 tchk[3]={0,0,0};
u8 numind=0;


#define KNNUM  4  //колво кнопок
#define KNONE  4  //обычное нажатие
#define KNLONG 5  //долгое
#define KNTWO  6  //двойного нет!

#define KNDTIME 50 //время в мс дребезга контактов
#define KNTIMETWO 300 //время в мс двойного нажатия
#define KNTIMELONG 1000 //время в мс долгого нажатия

//паяльная станция
u8 fan=1;//1 - фен, 0 - паяльник
u8 fanold=0;
u8 speedfan=3;//1-2-3-4
u8 speedfanold=0;//1-2-3-4
u16 temp=0;//заданная температура
u16 tempold=0;
u8 timeshownext=0;
u8 showind=0;
u8 spiralpower=0;
u8 spiralon=0;
u16 spiraltime=0;
#define MAXPWM 5

//пид регулятор
#define hKp_Divisor 512
#define hKi_Divisor 2000
s32 wIntegral=0;

#define hUpper_Limit_Output (s32)70
#define wUpper_Limit_Integral (s32)(hUpper_Limit_Output*hKi_Divisor)

#define hLower_Limit_Output (s32)0
#define wLower_Limit_Integral (s32)(hLower_Limit_Output * hKi_Divisor)


s16 hKp_Gain=230;
s16 hKi_Gain=20;//50;

//пид регулятор

u16 adcval;
			
u8  kn[KNNUM];//итоговое состояние кнопки 0 - не обработана, и дальше обычное нажатие долгое и двойное
u8  knstatus[KNNUM];//состояние кнопки 0 - не нажата 1 - нажата
u16 kntime[KNNUM];//время нажатия кнопки
u8  kndtime=0;

u16 timenct=0;
u16 timemcp=0;
u8 timeuv=0;

u8 rezhim=0;

u8 sec,min;

void Delay (u16 nCount);
uint32_t LSIMeasurment(void);

uint32_t current_millis = 0;
bool blueen;
uint8_t buff[30];

#define MCPaddr 0b01101000
#define UVaddr  (0x10)
#define NCTaddr  (0x48)

int kn1=0,kn2=0,kn1old=0,kn2old=0,fandes=0;fansot=0;

//сегменты индикатора!

#define ON1 GPIO_WriteHigh(GPIOC,GPIO_PIN_5)
#define ON2 GPIO_WriteHigh(GPIOD,GPIO_PIN_6)
#define ON3 GPIO_WriteHigh(GPIOD,GPIO_PIN_4)
#define OFF1 GPIO_WriteLow(GPIOC,GPIO_PIN_5)
#define OFF2 GPIO_WriteLow(GPIOD,GPIO_PIN_6)
#define OFF3 GPIO_WriteLow(GPIOD,GPIO_PIN_4)

#define AON GPIO_WriteLow(GPIOA,GPIO_PIN_2)
#define BON GPIO_WriteLow(GPIOD,GPIO_PIN_5)
#define CON GPIO_WriteLow(GPIOD,GPIO_PIN_2)
#define DON GPIO_WriteLow(GPIOC,GPIO_PIN_7)
#define EON GPIO_WriteLow(GPIOC,GPIO_PIN_6)
#define FON GPIO_WriteLow(GPIOA,GPIO_PIN_1)
#define GON GPIO_WriteLow(GPIOD,GPIO_PIN_3)
#define TON ;//GPIO_WriteLow(GPIOC,GPIO_PIN_5)


#define ALLOFF GPIO_WriteHigh(GPIOC,GPIO_PIN_6|GPIO_PIN_7);GPIO_WriteHigh(GPIOD,GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_5);GPIO_WriteHigh(GPIOA,GPIO_PIN_1|GPIO_PIN_2);
//GPIO_WriteLow(GPIOC,GPIO_PIN_5);GPIO_WriteLow(GPIOD,GPIO_PIN_6|GPIO_PIN_4);


const double cK[9]={
2.508355*10,
7.860106/100,
-2.503131/10,
8.315270/100,
-1.228034/100,
9.804036/10000,
-4.413030/100000,
1.057734/1000/1000,
-1.052755/10000/10000};

const double cKm[8]={
2.5173462*10,
-1.1662878,
-1.0833638,
-8.9773540/10,
-3.7342377/10,
-8.6632643/100,
-1.0450598/100,
-5.1920577/100/100};

const double cKf[7]={
-1.318058*100,
4.830222*10,
-1.646031,
5.464731/100,
-9.650715/10000,
8.802193/1000000,
-3.110810/100000000};

long mcpT,bmeT;

s16 PI_Regulator(s16 hReference, s16 hPresentFeedback)
{
  s32 wError, wProportional_Term,wIntegral_Term, houtput_32;
  s32 wIntegral_sum_temp; 
    
  // error computation
  wError= (s32)(hReference - hPresentFeedback);
 
  // Proportional term computation
  wProportional_Term = hKp_Gain * wError;

  // Integral term compuztation
  if (hKi_Gain == 0)
  {
    wIntegral = 0;
  }
  else
  { 
    wIntegral_Term = hKi_Gain * wError;
    wIntegral_sum_temp = wIntegral + wIntegral_Term;
		
		if (wIntegral_sum_temp > 0)
		{
			if (wIntegral < 0)
			{
				if (wIntegral_Term < 0)
				{
					wIntegral_sum_temp = S32_MIN;
				}
			}
		}
		else
		{
			if (wIntegral > 0)
			{
				if (wIntegral_Term > 0)
				{
					wIntegral_sum_temp = S32_MAX;
				}
			}
		}		
    
    if (wIntegral_sum_temp > wUpper_Limit_Integral)
    {
      wIntegral = wUpper_Limit_Integral;
    }
    else if (wIntegral_sum_temp < wLower_Limit_Integral)
    { 
      wIntegral = wLower_Limit_Integral;
    }
    else
    {
      wIntegral = wIntegral_sum_temp;
    }
  }
  
  houtput_32 = (wProportional_Term/hKp_Divisor+wIntegral/hKi_Divisor);

  if (houtput_32 > hUpper_Limit_Output)
  {
    houtput_32 = hUpper_Limit_Output;		  			 	
  }
  else if (houtput_32 < hLower_Limit_Output)
  {
    houtput_32 = hLower_Limit_Output;
  }
  return((s16)(houtput_32)); 		
}



char* shift_and_mul_utoa16(uint16_t n, char *buffer)
{
    char *ptr;
		uint8_t d4, d3, d2, d1, q, d0;

        d1 = (n>>4)  & 0xF;
        d2 = (n>>8)  & 0xF;
        d3 = (n>>12) & 0xF;

        d0 = 6*(d3 + d2 + d1) + (n & 0xF);
        q = (d0 * 0xCD) >> 11;
        d0 = d0 - 10*q;

        d1 = q + 9*d3 + 5*d2 + d1;
        q = (d1 * 0xCD) >> 11;
        d1 = d1 - 10*q;

        d2 = q + 2*d2;
        q = (d2 * 0x1A) >> 8;
        d2 = d2 - 10*q;

        d3 = q + 4*d3;
        d4 = (d3 * 0x1A) >> 8;
        d3 = d3 - 10*d4;

				ptr = buffer;
    *ptr++ = ( d4 + '0' );
    *ptr++ = ( d3 + '0' );
    *ptr++ = ( d2 + '0' );
    *ptr++ = ( d1 + '0' );
    *ptr++ = ( d0 + '0' );
        *ptr = 0;

        while(buffer[0] == '0') ++buffer;
        return buffer;
}


int I2C_writenbyte(uint8_t addr, uint8_t* buff, int nbyte, int nostop)
{
	uint32_t timeout;
	timeout = current_millis + 1000;
	
	while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
	{	
		if (current_millis>timeout) return 0;
	}	
	
	I2C->CR2 |= I2C_CR2_START;//I2C_GenerateSTART(ENABLE);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
	{	
		if (current_millis>timeout) return 0;
	}	
			
  I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_TX);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_TRANSMITTER_MODE_SELECTED))
	{	
		if (current_millis>timeout) return 0;
	}	
	
	while (nbyte>0)
	{
		I2C->DR = (uint8_t)*buff;//I2C_SendData((uint8_t)*buff);//ctrl meas
		while(!I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED))
		{	
			if (current_millis>timeout) return 0;
		}	
		*buff++;
		nbyte--;
	}
	
	if(nostop==0) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
	}
	
	return 1;
}

int I2C_readnbyte(uint8_t addr, uint8_t * buff, int nbyte,int nocheckbusy)
{
	uint32_t timeout;
	timeout = current_millis + 1000;
	
	if (nocheckbusy==0) 
	{
		while (I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
		{	
			if (current_millis>timeout) return 0;
		}
	}	
	
	I2C->CR2 |= I2C_CR2_START;//I2C_GenerateSTART(ENABLE);
	while (!I2C_CheckEvent(I2C_EVENT_MASTER_MODE_SELECT))
	{	
		if (current_millis>timeout) return 0;
	}	
	
	I2C_Send7bitAddress((uint8_t)addr << 1, I2C_DIRECTION_RX);
	
	if (nbyte >= 3) 
	{
		
		while (I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
		disableInterrupts();
		(void)I2C->SR3;
		enableInterrupts();
	
		while  (nbyte > 3) {
			
			while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
			{	
				if (current_millis>timeout) return 0;
			}	
		
			*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
			*buff++;
			nbyte--;
		}
	
		//осталось 3 байта!
	
		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
		
		I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);//I2C_AcknowledgeConfig(I2C_ACK_NONE);
		disableInterrupts();
		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
		*buff++;
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
		enableInterrupts();
		*buff++;
		while (I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
	
		*buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();	
		 nbyte=0;

		while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Re-Enable Acknowledgement to be ready for another reception */
    I2C->CR2 |= I2C_CR2_ACK;
		I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);//I2C_AcknowledgeConfig( I2C_ACK_CURR);
	
	}
	
	
	if (nbyte == 2) 
	{
		I2C_AcknowledgeConfig(I2C_ACK_NEXT);
		
		while (I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
		(void)I2C->SR3;
		I2C_AcknowledgeConfig(I2C_ACK_NONE);
    
		while (I2C_GetFlagStatus( I2C_FLAG_TRANSFERFINISHED) == RESET)
		{	
			if (current_millis>timeout) return 0;
		}	
	
		disableInterrupts();
		I2C_GenerateSTOP(ENABLE);
		*buff= I2C_ReceiveData();
		enableInterrupts();
		// Point to the next location where the byte read will be saved
		*buff++;  
		*buff= I2C_ReceiveData();
		nbyte=0; 
		
		while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    // Re-Enable Acknowledgement to be ready for another reception
    I2C_AcknowledgeConfig( I2C_ACK_CURR);
	}
	
	
	if (nbyte == 1) 
	{
		I2C->CR2 &= (uint8_t)(~I2C_CR2_ACK);//I2C_AcknowledgeConfig(I2C_ACK_NONE);   
		
		while(I2C_GetFlagStatus( I2C_FLAG_ADDRESSSENTMATCHED) == RESET)
    {	
			if (current_millis>timeout) return 0;
		}	
			
		disableInterrupts();
    
    /* Clear ADDR register by reading SR1 then SR3 register (SR1 has already been read) */
    (void)I2C->SR3;
    
    /* Send STOP Condition */
    I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP( ENABLE);
   
    /* Call User callback for critical section end (should typically re-enable interrupts) */
    enableInterrupts();
    
    /* Wait for the byte to be received */
    while(I2C_GetFlagStatus( I2C_FLAG_RXNOTEMPTY) == RESET)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Read the byte received from the EEPROM */
    *buff = ((uint8_t)I2C->DR);//I2C_ReceiveData();
    
    /* Decrement the read bytes counter */
		nbyte=0;

    /* Wait to make sure that STOP control bit has been cleared */
    while(I2C->CR2 & I2C_CR2_STOP)
    {	
			if (current_millis>timeout) return 0;
		}	
	
		
    /* Re-Enable Acknowledgement to be ready for another reception */
    I2C->CR2 |= I2C_CR2_ACK;
		I2C->CR2 &= (uint8_t)(~I2C_CR2_POS);//I2C_AcknowledgeConfig( I2C_ACK_CURR);
	}
	
	return 1;
}

int nctinit(void)
{
		
		//not need
		buff[0] = (uint8_t) 0b1;
		buff[1] = (uint8_t) 0b0;//config reg
		if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 1,0) ) 
		{
			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		

		return 1;
}

int nctdata(void)
{
		long tmcpT;
		
		buff[0] = (uint8_t) 0x00;
		if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 1,0) ) 
		{
			I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		if (! I2C_readnbyte((uint8_t)NCTaddr, buff, 2,0) ) 
		{	
			return 0;
		};
		
		tmcpT = (u32) (buff[0]<<8) | buff[1];
		bmeT = (tmcpT>>4) * 625 / 100;
		
		return 1;
}


int uvinit(void)
{
		//return 1;
		buff[0] = (uint8_t) 0b0;//config reg
		buff[1] = (uint8_t) 0b00100000;//low byte
		buff[2] = (uint8_t) 0b0;//high byte
		if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 3,0) ) 
		{
			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
			return 0;
		};

		//I2C->CR2 |= I2C_CR2_STOP;
		
		return 1;
}

int uvdata(void)
{
		double e,t;
		int i;
		long tmcpT;
		
		buff[0] = (uint8_t) 0x09;//uva
		if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 1,1) ) 
		{
			I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		if (! I2C_readnbyte((uint8_t)UVaddr, buff, 2,1) ) 
		{	
			return 0;
		};
		
		//I2C_GenerateSTOP(ENABLE);
		
		return 1;
}


double mypow(double a,int b) {
		
		//if (b=0) return 0;
		double x=a;
		if (b==1) return a;
		//b--;
		while (b--) 
		{
			x *= a;
		}
		
		return x;
}

int mcpinit(void)
{
		buff[0] = (uint8_t) 0b00011111;
		if( ! I2C_writenbyte((uint8_t)MCPaddr, buff, 2,0) ) 
		{
			I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
			return 0;
		};
		
		
		return 1;
}

int mcpdata(void)
{
		double e,t;
		int i;
		long tmcpT;
		
		if (! I2C_readnbyte((uint8_t)MCPaddr, buff, 4,0) ) return 0;		
		
		tmcpT = (int32_t) buff[0]<<16 | buff[1]<<8 | buff[2];
		
		e = (double) tmcpT/512; //* 15.625/8000;//в миливольтах
			
		if (e <-5) return 0;	
		if (e >30) return 0; //720gradusov
		
		t=0;

		//e = 20.0;

		if (e>20) 
		{		
			t=t+cKf[0];
			for (i=0;i<6;i++) 
			{
				t=t + (cKf[i+1])*mypow(e,(i+1));
			}
		} else {
			for (i=0;i<((e>0)? 9 : 8);i++) 
			{
				t=t + ((e>0)?cK[i]:cKm[i])*mypow(e,i+1);
			}
		}
		t*=100;
		tmcpT = (long) t + bmeT;
		mcpT = tmcpT;
		//mcpT += bmeT;
		//c = (float)pow(a,b);
		
		return 1;
}


void cifra(u8 num){
	ALLOFF
	
	if (num==0) {
		AON;BON;CON;DON;EON;FON;
	}
	if (num==1) {
		BON;CON;
	}
	if (num==2) {
		AON;BON;GON;EON;DON;
	}
	if (num==3) {
		AON;BON;CON;DON;GON;
	}
	if (num==4) {
		FON;GON;BON;CON;
	}
	if (num==5) {
		AON;FON;GON;CON;DON;
	}
	if (num==6) {
		AON;EON;FON;GON;CON;DON;
	}
	if (num==7) {
		AON;BON;CON;
	}
	if (num==8) {
		AON;BON;CON;GON;DON;EON;FON;
	}
	if (num==9) {
		AON;BON;CON;GON;DON;FON;
	}
	
}

//on off segment on all 3cif
void cifraS(u8 seg){
	u8 j=0;
	
	if(seg==0) AON;
	if(seg==1) BON;
	if(seg==2) CON;
	if(seg==3) DON;
	if(seg==4) EON;
	if(seg==5) FON;
	if(seg==6) GON;
	
	for (j=0;j<3;j++) {
		u8 num;
		u8 flag=0;
		num = ind[j];
		
		
		if (num==0) {
			//AON;BON;CON;DON;EON;FON;
			if(seg==0) flag=1;
			if(seg==1) flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;
			if(seg==4)  flag=1;
			if(seg==5)  flag=1;
		}
		if (num==1) {
			//BON;CON;
			if(seg==1) flag=1;
			if(seg==2)  flag=1;
			
		}
		if (num==2) {
			//AON;BON;GON;EON;DON;
			if(seg==0) flag=1;
			if(seg==1) flag=1;
			if(seg==3)  flag=1;
			if(seg==4)  flag=1;
			if(seg==6)  flag=1;
		}
		if (num==3) {
			//AON;BON;CON;DON;GON;
			if(seg==0) flag=1;
			if(seg==1) flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;
			if(seg==6)  flag=1;
		}
		if (num==4) {
			//FON;GON;BON;CON;
			if(seg==1)  flag=1;
			if(seg==2)  flag=1;
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
			
		}
		if (num==5) {
			//AON;FON;GON;CON;DON;
			if(seg==0)  flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
		}
		if (num==6) {
			//AON;EON;FON;GON;CON;DON;
			if(seg==0)  flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;
			if(seg==4)  flag=1;
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
		}
		if (num==7) {
			//AON;BON;CON;
			if(seg==0)  flag=1;
			if(seg==1)  flag=1;
			if(seg==2)  flag=1;
		}
		if (num==8) {
			//AON;BON;CON;GON;DON;EON;FON;
			if(seg==0) flag=1;
			if(seg==1) flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;
			if(seg==4)  flag=1;
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
		}
		if (num==9) {
			//AON;BON;CON;GON;DON;FON;
			if(seg==0) flag=1;
			if(seg==1) flag=1;
			if(seg==2)  flag=1;
			if(seg==3)  flag=1;			
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
		}
		
		if (num==10) {
			//P
			if(seg==0) flag=1;
			if(seg==1) flag=1;
			//if(seg==2)  flag=1;
			//if(seg==3)  flag=1;			
			if(seg==4)  flag=1;
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
		}
		
		if (num==11) {
			//F
			if(seg==0) flag=1;
			//if(seg==1) flag=1;
			//if(seg==2)  flag=1;
			//if(seg==3)  flag=1;			
			if(seg==4)  flag=1;
			if(seg==5)  flag=1;
			if(seg==6)  flag=1;
		}
		
		if (flag==1 && j==0 ) ON1;
		if (flag==1 && j==1 ) ON2;
		if (flag==1 && j==2 ) ON3;
			
		
	}
}

void shownumber(u16 num) {
	ind[0]=num/100;
	ind[1]=num/10-ind[0]*10;
	ind[2]=num - ind[0]*100 - ind[1]*10;

	if (ind[0]==0) {
		ind[0]=20;
		if (ind[1]==0) ind[1]=20;
	}
}

void sleep(void) {
	//vse perevodim v shutdown
	//potom halt
	//potom opyat' vse vkl
	
	
	return;
	
	
	//nct datchik
	buff[0] = (uint8_t) 0b1;//config reg
	buff[1] = (uint8_t) 0b1;//shutdown
	if( ! I2C_writenbyte((uint8_t)NCTaddr, buff, 2,0) ) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		return;
	};
		
	
	//uv datchik
	buff[0] = (uint8_t) 0b0;//config reg
	buff[1] = (uint8_t) 0b00100001;//low byte
	buff[2] = (uint8_t) 0b0;//high byte - always 0
	if( ! I2C_writenbyte((uint8_t)UVaddr, buff, 3,0) ) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		return;
	};

	//mcp adc
	buff[0] = (uint8_t) 0b10001111;//one shot and sleep
	if( ! I2C_writenbyte((uint8_t)MCPaddr, buff, 1,0) ) 
	{
		I2C->CR2 |= I2C_CR2_STOP;//I2C_GenerateSTOP(ENABLE);
		return;
	};
		
	
	//ekran vykl!


	
}

void showinfo(u8 showind) {
	if (showind==0) {
		ind[0]=11;
		ind[1]=20;
		ind[2]=speedfan;
	}	else if (showind==1) {
		shownumber(temp);
	} else if (showind==2) {
		shownumber(hKi_Gain);
	}	else shownumber(mcpT);
	
}

void main(void)
{
	//питание - оставляем только нужную периферию!
	CLK->PCKENR1 = CLK_PCKENR1_TIM4+CLK_PCKENR1_TIM2+CLK_PCKENR1_I2C+CLK_PCKENR1_TIM1;
	CLK->PCKENR2 = 0b01111111;

	
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);//2mgh энергосбережение
	//internal clock
	
	
	//индикатор
	GPIO_Init(GPIOD,GPIO_PIN_2|GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6,GPIO_MODE_OUT_PP_HIGH_SLOW);
	GPIO_Init(GPIOA,GPIO_PIN_1|GPIO_PIN_2,GPIO_MODE_OUT_PP_HIGH_SLOW);
	GPIO_Init(GPIOC,GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7,GPIO_MODE_OUT_PP_HIGH_SLOW);
 
	GPIO_WriteHigh(GPIOC,GPIO_PIN_1);
	GPIO_WriteLow(GPIOA,GPIO_PIN_2);
	
	GPIO_Init(GPIOC,GPIO_PIN_3,GPIO_MODE_OUT_PP_LOW_FAST);//PWM FAN
	GPIO_Init(GPIOA,GPIO_PIN_3,GPIO_MODE_OUT_PP_LOW_FAST);//Spiral


	//ADC кнопки
	GPIO_Init(GPIOC,GPIO_PIN_4,GPIO_MODE_IN_FL_NO_IT);//кнопка!
	ADC1_DeInit();
	ADC1_Init(ADC1_CONVERSIONMODE_SINGLE, ADC1_CHANNEL_2, ADC1_PRESSEL_FCPU_D2, \
            ADC1_EXTTRIG_TIM, DISABLE, ADC1_ALIGN_RIGHT, ADC1_SCHMITTTRIG_CHANNEL2,\
            DISABLE);
	ADC1_Cmd(ENABLE);
	
	/*
	while (1) {
			u16 i;
			ADC1_StartConversion();
			//for(i=0;i<10000;i++);
			//ADC1_StartConversion();
			while( ADC1_GetFlagStatus(ADC1_FLAG_EOC) == RESET);
			ADC1_ClearFlag(ADC1_FLAG_EOC);
			adcval = ADC1_GetConversionValue();
	};
	*/
	
	TIM4_TimeBaseInit(TIM4_PRESCALER_8, 249);
  TIM4_ClearFlag(TIM4_FLAG_UPDATE);
	TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  TIM4->IER |= (uint8_t)TIM4_IT_UPDATE;

	//настройку прерваний надо делать до их включения!
	//надо оба фронта для отслеживания долгого нажатия!
	/* enable interrupts */
	enableInterrupts();

	/* Enable TIM4 */
	TIM4_Cmd(ENABLE);
	
	
	TIM2_TimeBaseInit(TIM2_PRESCALER_8, 249);
  TIM2_ClearFlag(TIM2_FLAG_UPDATE);
	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);
  TIM2->IER |= (uint8_t)TIM2_IT_UPDATE;
  
	
	//PWM timer
	TIM1_DeInit();
	TIM1_TimeBaseInit(36000, TIM1_COUNTERMODE_UP, MAXPWM, 0);
	
	TIM1_CCPreloadControl(DISABLE);
	
	TIM1_BDTRConfig(TIM1_OSSISTATE_DISABLE,
                     TIM1_LOCKLEVEL_OFF,
                     0,
                     TIM1_BREAK_DISABLE,
                     TIM1_BREAKPOLARITY_LOW,TIM1_AUTOMATICOUTPUT_DISABLE);
										 
	TIM1_OC1Init(TIM1_OCMODE_PWM2, TIM1_OUTPUTSTATE_DISABLE, TIM1_OUTPUTNSTATE_DISABLE,
               0, TIM1_OCPOLARITY_LOW, TIM1_OCNPOLARITY_HIGH, TIM1_OCIDLESTATE_SET,
               TIM1_OCNIDLESTATE_RESET); 
	/* TIM1 counter enable */
  TIM1_CtrlPWMOutputs(DISABLE); //vse v preryvanii!
	TIM1_Cmd(ENABLE);
	TIM1_ITConfig(TIM1_IT_UPDATE|TIM1_IT_CC1, ENABLE);
	//Delay(10000);
	
	//BEEP_LSICalibrationConfig(LSIMeasurment());
	//BEEP_Cmd(DISABLE);
	//BEEP_Init(BEEP_FREQUENCY_1KHZ);
	//BEEP_Cmd(ENABLE);
	//Delay(1000);
	//BEEP_Cmd(DISABLE);
	Delay(100);

	bmeT=0;
	
	TIM2_Cmd(ENABLE);
	
	//I2C_DeInit();
	I2C_Cmd( ENABLE);
  I2C_Init(I2C_MAX_STANDARD_FREQ, (uint8_t)0xA0, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 7);
	
	mcpinit();
	//uvinit();
	nctinit();
	
	//kn[4] = KNONE;
	
	//fan=1;
	if (fan==0) {
		ind[0] = 10;//P
		ind[1] = 10;//P
		ind[2] = 10;//P
	} else {
		ind[0] = 11;//F
		ind[1] = 11;//F
		ind[2] = 11;//F
	}
	Delay(3000);
	
	
	/* Infinite loop */
  while (1) {
		
		{
			//аварийная остановка
			u8 i;
			for (i=0;i<4;i++) {
				if (kn[i]==KNTWO) {
					kn[i]=0;
					spiralpower=0;
					temp=0;
					shownumber(999);
					timeshownext=3;
				}
			}
		}
		
		if (kn[1] == KNONE) {
			//меньше скорость фена!!
			kn[1]=0;			
			temp-=10;
			if (temp>1000) temp=0;
		}
		if (kn[1] == KNLONG) {
			//меньше скорость фена!!
			kn[1]=0;			
			temp-=100;
			if (temp>1000) temp=0;
		}
		
		if (kn[2] == KNONE) {
			//меньше скорость фена!!
			kn[2]=0;			
			temp+=10;
			if (temp>500) temp=500;
		}
		if (kn[2] == KNLONG) {
			//меньше скорость фена!!
			kn[2]=0;			
			temp+=100;
			if (temp>500) temp=500;
		}

		
		
		if ((kn[0] == KNONE) || (kn[0] == KNLONG)) {
			//меньше скорость фена!!
			kn[0]=0;			
			speedfan--;
			if (speedfan==0) speedfan=1;
			
			//hKi_Gain -=1;
			
			timeshownext=2;
			showinfo(0);
			
		}
		
		if ((kn[3] == KNONE) || (kn[3] == KNLONG)) {
			//меньше скорость фена!!
			kn[3]=0;			
			speedfan++;
			if (speedfan>4) speedfan=4;
			
			//hKi_Gain +=1;
			
			timeshownext=2;
			showinfo(0);
		}

		if (temp != tempold) {			
			//поменяем скорость мотора!
			timeshownext=2;
			showinfo(1);
			
			tempold = temp;
		}

		if (speedfan != speedfanold) {			
			//поменяем скорость мотора!
			timeshownext=2;
			showinfo(0);
			
			speedfanold = speedfan;
			TIM1->CCR1L = (MAXPWM-4)+(uint8_t)(speedfan);
		}

		if (timeshownext==0) {
			timeshownext= 1;
			
			showinfo(10);
			
			showind++;
			if (showind>=6) showind = 0;			
		}

		/*
		if (kn[0] >= KNONE && 0) {
			kn[0]=0;
			rezhim++;
			if (rezhim>2) rezhim = 0;
			
			tchk[0]=0;
			tchk[1]=0;
			tchk[2]=0;
				
			if (rezhim==0) {
				tchk[1]=1;
				timenct=0;
			}	
		
			if (rezhim==1) {
				tchk[2]=1;
				timemcp =0;
				timenct =0;
			}	
			
			if (rezhim==2) {
				tchk[0]=1;
				ind[0]=10;
				ind[1]=10;
				ind[2]=10;
			}	
		}		
		*/	
		
		
		//if (timenct==0) {
		//	timenct = 200;
			//if (rezhim==0) {
			//	shownumber(bmeT/10);
			//}	
		//}	
		
		//if (rezhim == 2) {
		//	if (timeuv==0) {
		//		//uvdata();
		//	}	
		//	timeuv=200;
		//}	
		
		
		if (timemcp==0)  {
			nctdata();
			
			if (mcpdata()==0){
				//error!!
				mcpT = 999;
			} else mcpT /= 100;
			//получили новые данные, посчитаем новую мощность
			if ((temp==0) || (mcpT > 600)) {
				spiralpower=0;
			} else
				spiralpower = PI_Regulator(temp, mcpT);
				
			
			//shownumber(mcpT);
			timemcp=300;
		}		
		
		
  }
}

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval : None
  */
void assert_failed(u8* file, u32 line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
uint32_t LSIMeasurment(void)
{

  uint32_t lsi_freq_hz = 0x0;
  uint32_t fmaster = 0x0;
  uint16_t ICValue1 = 0x0;
  uint16_t ICValue2 = 0x0;

  /* Get master frequency */
  fmaster = CLK_GetClockFreq();

  /* Enable the LSI measurement: LSI clock connected to timer Input Capture 1 */
  AWU->CSR |= AWU_CSR_MSR;

#if defined (STM8S903) || defined (STM8S103) || defined (STM8S003)
  /* Measure the LSI frequency with TIMER Input Capture 1 */
  
  /* Capture only every 8 events!!! */
  /* Enable capture of TI1 */
	//TIM1_ICInit(TIM1_CHANNEL_1, TIM1_ICPOLARITY_RISING, TIM1_ICSELECTION_DIRECTTI, TIM1_ICPSC_DIV8, 0);
	
	//TI1_Config((uint8_t)TIM1_ICPOLARITY_RISING,
  //             (uint8_t)TIM1_ICSELECTION_DIRECTTI,
  //             (uint8_t)0);
	TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
  
  /* Select the Input and set the filter */
  TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~(uint8_t)( TIM1_CCMR_CCxS | TIM1_CCMR_ICxF ))) | 
                          (uint8_t)(( (TIM1_ICSELECTION_DIRECTTI)) | ((uint8_t)( 0 << 4))));
	TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1P);
	TIM1->CCER1 |=  TIM1_CCER1_CC1E;
	
   /* Set the Input Capture Prescaler value */
	//TIM1_SetIC1Prescaler(TIM1_ICPSC_DIV8);
	TIM1->CCMR1 = (uint8_t)((uint8_t)(TIM1->CCMR1 & (uint8_t)(~TIM1_CCMR_ICxPSC)) 
                          | (uint8_t)TIM1_ICPSC_DIV8);
	
  /* Enable TIM1 */
  //TIM1_Cmd(ENABLE);
	TIM1->CR1 |= TIM1_CR1_CEN;
  
  /* wait a capture on cc1 */
  while((TIM1->SR1 & TIM1_FLAG_CC1) != TIM1_FLAG_CC1);
  /* Get CCR1 value*/
  ICValue1 = TIM1_GetCapture1();
  TIM1_ClearFlag(TIM1_FLAG_CC1);
  
  /* wait a capture on cc1 */
  while((TIM1->SR1 & TIM1_FLAG_CC1) != TIM1_FLAG_CC1);
  /* Get CCR1 value*/
  ICValue2 = TIM1_GetCapture1();
  TIM1_ClearFlag(TIM1_FLAG_CC1);
  
  /* Disable IC1 input capture */
  TIM1->CCER1 &= (uint8_t)(~TIM1_CCER1_CC1E);
  /* Disable timer2 */
  TIM1_Cmd(DISABLE);
  
#else  
  /* Measure the LSI frequency with TIMER Input Capture 1 */
  
  /* Capture only every 8 events!!! */
  /* Enable capture of TI1 */
  TIM3_ICInit(TIM3_CHANNEL_1, TIM3_ICPOLARITY_RISING, TIM3_ICSELECTION_DIRECTTI, TIM3_ICPSC_DIV8, 0);

  /* Enable TIM3 */
  TIM3_Cmd(ENABLE);

	/* wait a capture on cc1 */
  while ((TIM3->SR1 & TIM3_FLAG_CC1) != TIM3_FLAG_CC1);
	/* Get CCR1 value*/
  ICValue1 = TIM3_GetCapture1();
  TIM3_ClearFlag(TIM3_FLAG_CC1);

  /* wait a capture on cc1 */
  while ((TIM3->SR1 & TIM3_FLAG_CC1) != TIM3_FLAG_CC1);
    /* Get CCR1 value*/
  ICValue2 = TIM3_GetCapture1();
	TIM3_ClearFlag(TIM3_FLAG_CC1);

  /* Disable IC1 input capture */
  TIM3->CCER1 &= (uint8_t)(~TIM3_CCER1_CC1E);
  /* Disable timer3 */
  TIM3_Cmd(DISABLE);
#endif

  /* Compute LSI clock frequency */
  lsi_freq_hz = (8 * fmaster) / (ICValue2 - ICValue1);
  
  /* Disable the LSI measurement: LSI clock disconnected from timer Input Capture 1 */
  AWU->CSR &= (uint8_t)(~AWU_CSR_MSR);

 return (lsi_freq_hz);
}

u16 timedelay=0;

void Delay(u16 nCount)
{
    /* Decrement nCount value */
    timedelay = nCount;
				
		while (timedelay);
}

void knint(u8 knum, u8 zn,u8 pin) {
	//будет отслеживать только изменение состояния кнопки
	if (knstatus[knum] && ((zn&pin) == 0)) {//кнопку нажали
		knstatus[knum] = zn&pin;
		if (kn[knum]>=KNONE) return; //еще не обработали предыдущее нажатие в основном цикле пропустим это нажатие

		kn[knum]++;//колво нажатий плюс один
		if (kn[knum]==1) kntime[knum] = KNTIMELONG;//первый раз начнм замер времени
		
		if (kn[knum]==2) {
			if (kntime[knum] > (KNTIMELONG-KNTIMETWO) ) kn[knum] = KNTWO;
			else kn[knum] = KNONE;
		}
	}
	
	if ((kn[knum]==1) && (kntime[knum]==0)) kn[knum]=KNLONG;
	if ((kn[knum]==1) && (kntime[knum]<(KNTIMELONG-KNTIMETWO)) && zn&pin) kn[knum]=KNONE;
	
	knstatus[knum] = zn&pin;
	
}	 

u16 timesec=0;


INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 {
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	if (timedelay) timedelay--;

	if (timenct) timenct--;
	if (timemcp) timemcp--;
	if (timeuv) timeuv--;
	
	
	if (timesec) timesec--;	
	if (timesec==0) {
		timesec=1000;
		//секундные таймеры
		if (timeshownext) timeshownext--;	
	}
	

	if (spiralpower==0) {
		//выключаем спираль или паяльник
		GPIOA->ODR &= (uint8_t)(~GPIO_PIN_3);
		spiraltime=0;
		spiralon=0;
	} else {
		u16 timeon;
		u16 timeoff;
		
		spiraltime++;
		//расчитаем мощность
		//макс время 2000 мс
		timeon = 2000 * spiralpower/100;
		timeoff = 2000 - timeon;
		
		if (spiralon) {
			//ждем выключения! и если настало время выключаем!
			if (spiraltime > timeon) {
				spiraltime = 0;
				GPIOA->ODR &= (uint8_t)(~GPIO_PIN_3);
				spiralon = 0;				
			}
		} else if (spiraltime > timeoff) {
			spiraltime = 0;
			GPIOA->ODR |= GPIO_PIN_3;
			spiralon = 1;
		}
	}

	TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
	
	
	{  //-------обработка кнопок
		u8 i,pd;
		
		if(kndtime) kndtime--;
		if (kndtime==0) {
			u8 knall=0;
			//u16 adcval;
			//опрос кнопок редко для избежания дребезга
			kndtime = KNDTIME;
			//кнопки на ADC - прочитаем и выясним какая кнопка нажата
			ADC1_StartConversion();
			while( ADC1_GetFlagStatus(ADC1_FLAG_EOC) == RESET);
			adcval = ADC1_GetConversionValue();
			
		  if (adcval < 10 )  {knall |= GPIO_PIN_0;}
		  else if (adcval < 550 )  {knall |= GPIO_PIN_1;}
		  else if (adcval < 700 )  {knall |= GPIO_PIN_2;}
		  else if (adcval < 800 )  {knall |= GPIO_PIN_3;}
			
			knall = ~knall;
			
			knint(0, knall, GPIO_PIN_0);
			knint(1, knall, GPIO_PIN_1);
			knint(2, knall, GPIO_PIN_2);
			knint(3, knall, GPIO_PIN_3);
			
			//pd = GPIO_ReadInputData(GPIOC);
			//knint(0, pd, GPIO_PIN_4);
		}
		for (i=0;i<KNNUM;i++) if(kntime[i]) kntime[i]--;
	}

	
 }
 
 INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 {
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	TIM2_ClearITPendingBit(TIM2_IT_UPDATE);
	
	OFF1;
	OFF2;
	OFF3;
	ALLOFF

	if (numind<7) {
		cifraS(numind);
		//if (tchk[numind]) TON;
	}	
	
	numind++;
	if (numind==7) numind=0;
 }

INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	if (TIM1->CCR1L) GPIOC->ODR |= GPIO_PIN_3;
	else GPIOC->ODR &= ~GPIO_PIN_3;
	
	TIM1->SR1 = (uint8_t)(~(uint8_t)TIM1_IT_UPDATE);
}

u8 tsttst;

INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
{
  /* In order to detect unexpected events during development,
     it is recommended to set a breakpoint on the following instruction.
  */
	if (TIM1->CCR1L!=MAXPWM) GPIOC->ODR &= (uint8_t)(~GPIO_PIN_3);
	TIM1->SR1 = (uint8_t)(~(uint8_t)TIM1_IT_CC1);
}