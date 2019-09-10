//
// Created by C19Mark.Demore on 1/13/2017.
//

#include <stdio.h>
//#include <string.h>

void my_strcopy(char * dest, char * source)
{
    int i = 0;
        while(source[i]!='\0')
        {
            if(dest[i]!='\0')
            {
                dest[i-1]='\0';
                break;
            }
            else
            {
                dest[i]=source[i];

            }
            i++;
            dest[i]='\0';
        }

}

int main()
{
    char string1[5]={'\0'};
    char name[]="Sion Abraham";

    my_strcopy(string1, name);

    printf("%s\n", string1);
    printf("%d\n",string1[1]);

    return 0;
}
