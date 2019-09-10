//
// Created by C19Mark.Demore on 1/11/2017.
//

#include <stdio.h>
#include <string.h>

void main()
{
    char name[30]={"\0"};
    char first[]="Fred";
    char last[]="Smith";

    strncpy(name,first,4);
    strncat(last," ",1);
    strncat(name,last,5);
    printf("%s",name);

}