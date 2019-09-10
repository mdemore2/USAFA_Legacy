//
// Created by C19Mark.Demore on 3/8/2017.
//
#include <stdlib.h>
#include <stdio.h>

struct alpha{
    int f1;
    double f2;
    char f3;
};

int main ()
{
    struct alpha thing;

    thing.f1=5;
    thing.f2=51.324;
    thing.f3='g';

    printf("Size of struct: %lu", sizeof(thing));

    printf("\nThe address of f1: %p", &(thing.f1));
    printf("\nThe address of f2: %p", &(thing.f2));
    printf("\nThe address of f3: %p", &(thing.f3));

}