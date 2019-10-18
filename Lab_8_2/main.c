#include <msp430.h>
#include <stdio.h>


unsigned int sec = 0;
unsigned int tsec = 0;
const int limit = 11;

//char Time[8];
char inputBuffer[11];

//void SetTime(void);
//void sendTime(void);

void UART_sendCharacter(char c);
char UART_getCharacter();

void UART_sendString(char* string);
void UART_getLine(char* buffer, int limit);

void UART_Initialize(void)
{
    UCA0CTL1 |= UCSWRST;
    P2SEL |= BIT4 + BIT5;
    UCA0CTL0 = 0;
    UCA0CTL1 |= UCSSEL_2;
    UCA0BR0 = 54;
    UCA0BR1 = 0;
    UCA0MCTL = 0x0A;
    UCA0CTL1 &= ~UCSWRST;
}

void UART_sendCharacter(char c)
{
    UCA0TXBUF = c;
}

char UART_getCharacter()
{
    while(!(IFG2&UCA0TXIFG));
    UCA0TXBUF = UCA0RXBUF;
    return UCA0RXBUF;
}


void UART_sendString(char* string)
{
    int i = 0;
    while(i<limit-1 && string[i] != '\n')
    {
        UART_sendCharacter(string[i]);
        i++;

    }
    UART_sendCharacter('\0');
}

void UART_getLine(char* buffer, int limit)
{
    int i = 0;
    char currentChar;
    currentChar = UART_getCharacter();
    while(i<limit && currentChar != '\n')
    {
        buffer[i] = currentChar;
        i++;
        currentChar = UART_getCharacter();
    }
}


/*
void SetTime(void)
{
    tsec++;
    if(tsec == 10)
    {
        tsec = 0;
        sec++;
        P5OUT^= BIT1;

    }
}

void SendTime(void)
{
    int i;

    sprintf(Time, "%05d:%01d", sec, tsec);
    for(i=0; i<8; i++)
    {
        while(!(IFG2 & UCA0TXIFG));
        UCA0TXBUF = Time[i];
    }
    while(!(IFG2 & UCA0TXIFG));
    UCA0TXBUF = 0x0D;  //carriage return

}
*/
//MAIN*******************************************
//***********************************************
void main(void)
{
    WDTCTL = WDTPW + WDTHOLD;
    UART_Initialize();
    //TACTL = TASSEL_2 + MC_1 + ID_3;
    //TACCR0 = 13107;
    //TACCTL0 = CCIE;

    //P5DIR |= BIT1;
    while(1)
    {

        UART_sendString("Me:  ");
        UART_getLine(inputBuffer, limit);
        while(inputBuffer != "Hey, Bot!")
        {
            UART_sendString("Me:  ");
            UART_getLine(inputBuffer, limit);
        }
        UART_sendString("Bot:  ");
        if(inputBuffer == "1000")
        {

        }

    }
/*
    while(1)
    {
        _BIS_SR(LPM0_bits + GIE);
        SendTime();
    }
    */
}
/*
#pragma vector = USCIAB0RX_VECTOR;
__interrupt void USCIA0RX_ISR(void)
   {

       while(!(IFG2&UCA0TXIFG));
       UCA0TXBUF = UCA0RXBUF;
       P5OUT ^= BIT1;

   }


#pragma vector = TIMERA0_VECTOR
__interrupt void TIMERA_ISA(void){
    SetTime();
    _BIC_SR_IRQ(LPM0_bits);
}
*/
