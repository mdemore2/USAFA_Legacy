//
// Created by Wayne.Brown on 1/13/2017.
//

#include <stdio.h>

int main() {
    int aInteger;
    void * a = &aInteger;

    printf("a   = %lu\n", (unsigned long) a);
    printf("a+1 = %lu\n", (unsigned long) (a+1));   //void pointer, add 1

    int * b = &aInteger;

    printf("b   = %lu\n", (unsigned long) b);
    printf("b+1 = %lu\n", (unsigned long) (b+1));   //int pointer, add 1*sizeof(int) aka 4

    double * c = (double *) &aInteger;

    printf("c   = %lu\n", (unsigned long) c);
    printf("c+1 = %lu\n", (unsigned long) (c+1));   //double pointer, add 1*sizeof(double) aka 8

    int x[] = {0, 1, 2, 3, 4};
    void * y = &x;

    printf("x[0] = %d\n", *((int *) (y + 0*sizeof(int))) );     //retrieve array value using address
    printf("x[1] = %d\n", *((int *) (y + 1*sizeof(int))) );         //(increment from array pointer)
    printf("x[2] = %d\n", *((int *) (y + 2*sizeof(int))) );
    printf("x[3] = %d\n", *((int *) (y + 3*sizeof(int))) );
    printf("x[4] = %d\n", *((int *) (y + 4*sizeof(int))) );
    printf("x[5] = %d\n", *((int *) (y + 5*sizeof(int))) );     //pointing to random garbage value
}


