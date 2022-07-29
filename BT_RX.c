/*
 * BT_RX.c
 *
 *  Created on: 9 Jun 2015
 *      Author: Rahul
 */
#include <avr/io.h>
#include <inttypes.h>
#include <util/delay.h> // includes delay header file
#include <avr/interrupt.h>
//This function is used to initialize the USART
//at a given UBRR value
char buffer[10];
void USARTInit(uint16_t ubrr_value)
{

   //Set Baud rate

   UBRRL = ubrr_value;
   UBRRH = (ubrr_value>>8);

   /*Set Frame Format


   >> Asynchronous mode
   >> No Parity
   >> 1 StopBit

   >> char size 8

   */

   UCSRC=(1<<URSEL)|(3<<UCSZ0);


   //Enable The receiver and transmitter

   UCSRB=(1<<RXEN)|(1<<TXEN);


}


//This function is used to read the available data
//from USART. This function will wait untill data is
//available.
char USARTReadChar()
{
   //Wait untill a data is available

   while(!(UCSRA & (1<<RXC)))
   {
      //Do nothing
   }

   //Now USART has got data from host
   //and is available is buffer

   return UDR;
}


//This fuction writes the given "data" to
//the USART which then transmit it via TX line
void USARTWriteChar(char data)
{
   //Wait untill the transmitter is ready

   while(!(UCSRA & (1<<UDRE)))
   {
      //Do nothing
   }

   //Now write the data to USART buffer

   UDR=data;
}
int main()
{
   char data;
   USARTInit(103);
   DDRB=0b11111111;
   DDRC=0b1111111;
  // PORTB= 0xff;

   while(1)
   {
      data=USARTReadChar();
	  switch(data)
	  {
	  case 'F': 
				 PORTC=0b00010100;
				//PORTB = 0xff;
				_delay_ms(5000);
				PORTC =0x00;
				USARTWriteChar(data);
	            break;

	  case 'R': 
	            PORTC=0b00000100;
				//PORTB = 0xFF;
				_delay_ms(1200);
				 PORTC=0b00010100;
				 _delay_ms(2000);
				PORTC =0x00;
				USARTWriteChar(data);
	            break;

	  case 'L': 
	            PORTC=0b00010000;
				//PORTB|=(1<<2);
				//PORTB|=(1<<4);
				//PORTB = 0x0A;
				_delay_ms(1200);
				 PORTC=0b00010100;
				 _delay_ms(2000);
				PORTC =0x00;
				USARTWriteChar(data);
	            break;

      case 'B': 
	            PORTC=0b00010000;
				//PORTB|=(1<<1);
				//PORTB|=(1<<3);
				PORTB=0x05;
				_delay_ms(5000);
				PORTB =0x00;
				USARTWriteChar(data);
	            break;

	  default: 
	            PORTC=0b0000000;
	            break;
	  }
}
return 0;
}



