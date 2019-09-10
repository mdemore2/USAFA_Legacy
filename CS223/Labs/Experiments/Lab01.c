// ====================================================================
// CS223 Lab01 - Experiments with C programming.
// Created by Wayne.Brown on 1/3/2017.
//
// Modified by C3C Mark Demore
// ====================================================================

/* --------------------------------------------------------------------
 * Instructions:
 * 1) Make sure you can build and run this program as it is. Don't
 *    proceed until the program, as it is, executes correctly.
 * 2) Modify the program to find prime numbers in the following ranges:
 *    a) all primes less than or equal to 1000
 *    b) all prime numbers between 300 and 400
 *    c) all prime numbers less than or equal to 1000 that have
 *       another prime number within plus or minus 2 of its value.
 *       (E.g., you would print 71 and 73, but not 53)
 *  3) Modify the program to find all composite numbers in some range.
 *     (A composite number is a number that is not prime.)
 *  4) Write a new function that prints the factors of a number, all on
 *     the same line. A number is a factor of another number if it will
 *     divide into the number with a zero remainder. In the main function,
 *     change the loop to print out the numbers from 0 to 100 and for
 *     each number print its factors.
 *  5) Write a new function that returns the number of factors of a number.
 *     Then modify your main program to print all numbers (and its factors)
 *     between 0 and 100 that have more than 5 factors.
 */

#include <math.h>
#include <stdio.h>

#define TRUE    1
#define FALSE   0

// ---------------------------------------------------------------------
int is_composite(int n)
{
    /**
     * Determines if the value of n is composite.
     * Returns True if n is composite, False otherwise
     */
    int maximum_divisor = (int) ceil(sqrt(n));
    for (int divisor = 2;  divisor <= maximum_divisor; divisor++)
    {
        if (n % divisor == 0)
        {
            return TRUE;
        }
    }

    return FALSE;
}
int is_prime(int n)
{
    /**
     * Determines if the value of n is prime.
     * Returns True if n is prime, False otherwise
     */
    int maximum_divisor = (int) ceil(sqrt(n));
    for (int divisor = 2;  divisor <= maximum_divisor; divisor++)
    {
        if (n % divisor == 0)
        {
            return FALSE;
        }
    }

    return TRUE;
}
int find_factors(int n)
{
    int factor_count = 0;
    int maximum_divisor = (int) ceil(n/2);
    for (int divisor = 1;  divisor <= maximum_divisor; divisor++)
    {
        if (n % divisor == 0)
        {
            factor_count++;
        }
    }
    return factor_count;
}
void print_factors(int n)
{
    int maximum_divisor = (int) ceil(n/2);
    for (int divisor = 1;  divisor <= maximum_divisor; divisor++)
    {
        if (n % divisor == 0)
        {
            printf("%d ",divisor);

        }
    }
}
// ---------------------------------------------------------------------
int main()
{
    // Print all of the prime numbers <= 100
    /*for (int value = 3; value <= 100; value++)
     * {
        if (is_prime(value))
        {
            if(is_prime(value+2))
            {
                printf("%d\n", value);
            }
            else if(is_prime(value-2))
            {
                printf("%d\n", value);
            }
        }
    }*/
    /*for (int value = 3; value <= 100; value++)
     * {
        find_factors(value);
        printf("\n");
    }*/
    for (int value = 0; value<=100; value++)
    {
        if (find_factors(value)>=5)
        {
            printf("%d : ",value);
            print_factors(value);
            printf("\n");
        }
    }
}
