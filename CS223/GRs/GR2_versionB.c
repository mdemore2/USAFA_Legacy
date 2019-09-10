/** GR2_versionB.c
 * ===========================================================
 * Name:                 , Spring 2017
 * Section:
 * Project: GR 2
 * Purpose: Assessment on trees and hash tables
 * ===========================================================
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Function definitions
void memoryOrganization();
void bitManipulations(int gamma);
char * toBitStr(size_t const size, void const * const ptr);

//---------------------------------------------------------------------
// Main function, start of execution
int main() {
    memoryOrganization();
    bitManipulations(11);
}

//---------------------------------------------------------------------
// Problem 11:                                        ________ / 15 pts
void memoryOrganization() {
    struct beta {
        char    c1;
        int     i1;
        char    c2;
        int     i2;
        double  d;
    };

    struct beta a;

    printf("\nSize of c1: %lu", sizeof(a.c1));
    printf("\nSize of i1: %lu", sizeof(a.i1));
    printf("\nSize of c2: %lu", sizeof(a.c2));
    printf("\nSize of i2: %lu", sizeof(a.i2));      //print sizes, unsigned long
    printf("\nSize of d: %lu", sizeof(a.d));

    printf("\n\nAddress of c1: %p", &a.c1);
    printf("\nAddress of i1: %p", &a.i1);
    printf("\nAddress of c2: %p", &a.c2);
    printf("\nAddress of i2: %p", &a.i2);           //print addresses, pointers
    printf("\nAddress of d: %p", &a.d);



}

//---------------------------------------------------------------------
// Problem 12:                                        ________ / 10 pts
void bitManipulations(int gamma) {

    int value;
    const void * const gam = &value;

    value = gamma << 4; // << is left shift operator
    printf("\n\nShift left by 4: %s",toBitStr(2,gam));

    value = gamma & 65534; // value chosen is 2 bytes - 2, in binary is 1111 1111 1111 1110
    printf("\nMake even: %s or %d", toBitStr(2,gam), value);

    value = ~gamma + 1; //not gamma and add 1, flip them bits
    printf("\nMake negative: %s or %d", toBitStr(2,gam), value);

    value = gamma & 15; //in binary 15 is 0000 1111, 2^4 - 1
    printf("\nLow order bits: %s or %d", toBitStr(2,gam),value);

    value = 1 << gamma; //binary each number is 2^x, shifting 1 over by gamma gets 2^gamma
    printf("\n 2^gamma: %s or %d", toBitStr(2,gam),value);

}


//---------------------------------------------------------------------
// Convert an ordinal value into a string of 0's and 1's.
// This assumes little endian byte ordering.
char * toBitStr(size_t const size, void const * const ptr)
{
    unsigned char *bytes = (unsigned char*) ptr;
    int bit;
    char * string = malloc(sizeof(char) * (size * 8 + 1));
    int k;

    k=0;
    for (int i = (int)size-1; i >= 0; i--) { // for each byte
        for (int j=7; j >= 0; j--) { // for each bit in this byte
            bit = (bytes[i] >> j) & 1;
            string[k++] = (char) ((bit == 1) ? '1' : '0');
        }
    }
    string[k] = '\0'; // null terminate the string

    return string;
}

