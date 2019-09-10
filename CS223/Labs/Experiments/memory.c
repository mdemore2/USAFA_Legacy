//
// Created by C19Mark.Demore on 2/16/2017.
//

#include <stdlib.h>
#include <stdio.h>

void frag(int size)
{
    void * address = (void *) 1;
    int count = 0;
    while (address != NULL) {
        address = malloc(size);
        printf("%6d   address = %lu\n", count, (unsigned long) address);
        if(((long)address) % 3 ==0)
        {
            free(address);
        }
        count++;
    }
}
int main() {
    int    count;
    void * address;
    int    size = 1000000000;

    count = 0;
    address = (void *) 1;

    while (address != NULL) {
        address = malloc(size);
        printf("%6d   address = %lu\n", count, (unsigned long) address);
        count++;
    }
    frag(size/2);
    frag(size/4);
    frag(size/8);
    frag(size/16);
    frag(size/32);
    frag(size/64);
    frag(size/128);
}
