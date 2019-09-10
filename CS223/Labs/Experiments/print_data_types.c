#include <stdio.h>

int main() {
    int    alpha = 37;
    float  beta = 4.5;
    char   gamma = 'C';
    char   name[] = "Wayne Brown";
    short  delta = -4;
    unsigned short theta = 100;

    printf("alpha = %d\n", alpha);
    printf("beta = %f\n", beta);
    printf("gamma = %c", gamma);
    printf("My name is %s so don't dispute it.\n", name);
    printf("delta only uses 16 bits to store %hd.\n", delta);
    printf("%hd is in theta.\n", theta);
    return 0;
}