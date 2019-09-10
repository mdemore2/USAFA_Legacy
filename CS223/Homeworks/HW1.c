//
// Created by C19Mark.Demore on 2/1/2017.
//

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main()
{
//    printf("%d\n",(int)sizeof(int));
//    printf("%d\n",(int)sizeof(unsigned int));
//    printf("%d\n",(int)sizeof(float));
//    printf("%d\n",(int)sizeof(double));
//    printf("%d\n",(int)sizeof(short));
//    printf("%d\n",(int)sizeof(char));
//    printf("%d\n",(int)sizeof(unsigned char));
//    printf("%d\n",(int)sizeof(long));
//    printf("%d\n",(int)sizeof(long long));
//    char alpha[20];
//    printf("%d\n",(int)sizeof(alpha));
//    int beta[30];
//    printf("%d\n",(int)sizeof(beta));
//    struct gamma {
//        int field1;
//        float field2;
//        char field3[10];
//    };
//    printf("%d\n",(int)sizeof(struct gamma));
//    printf("%d\n",(int)sizeof(int *));
//    printf("%d\n",(int)sizeof(float *));
//    printf("%d\n",(int)sizeof(double *));
//    printf("%d\n",(int)sizeof(char *));
//    printf("%d\n",(int)sizeof(long *));
//    printf("%d\n",(int)sizeof(struct gamma *));


    int alpha[6] = {10, 20, 30, 40};
    char courseName[] = "CS223 Data Structures and System Programming";
    char aCharacter;

    alpha[0] = alpha[1] + 2;    // alpha = {22, 20, 30, 40,
    printf("\n");
    for(int i=0; i < 8;i++)
    {
        printf("%d",alpha[i]);
        printf("%c",',');

    }

    aCharacter = courseName[3];  // aCharacter = 2
    printf("\n");
    printf("%c",aCharacter);

    courseName[5] = '_';        // courseName = "CS223_Data Structures and System Programming"
    printf("\n");
    printf(courseName);

    strcpy(courseName + 6, "DataStructures"); // courseName =
    printf("\n");
    printf(courseName);

    alpha[10] = 2;               // alpha =
    printf("\n");
    for(int i=0; i < 11;i++)
    {
        printf("%d",alpha[i]);
        printf("%c",',');

    }

    *(alpha + 3) = -3;           // alpha =
    printf("\n");
    for(int i=0; i < 11;i++)
    {
        printf("%d",alpha[i]);
        printf("%c",',');

    }


    return 0;
}
