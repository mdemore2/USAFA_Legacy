//
// Created by Dr. Wayne Brown on 3/15/2017.
//

//=====================================================================
// The C programming language gives you direct access to most CPU
// instructions. Most CPU instruction sets contain ways to manipulate
// the individual bits of a byte or larger data types. These lab
// exercises will help you learn how to manipulate bits in C.
// (These concepts are also included in most programming languages,
// including Python.)
//=====================================================================

#include <stdlib.h>
#include <stdio.h>

// local function definitions
void shifting_experiments();
void bit_wise_experiments();
void bit_manipulation_experiments();
void overflow_experiments();
char * toBitStr(size_t const size, void const * const ptr);

// You will perform various experiments by executing the following
// function, one at a time.
int main() {
//    shifting_experiments();
//    bit_wise_experiments();
//    bit_manipulation_experiments();
    overflow_experiments();
}

/*-----------------------------------------------------------------------
A review of integer (ordinal) data types:
  char           - 1 byte,  range [-128, +127]
  unsigned char  - 1 byte,  range [0, 255]
  short          - 2 bytes, range [−32,768 ... +32,767]
  unsigned short - 2 bytes, range [0 ... +65,535]
  int            - 4 bytes, range [−2,147,483,648 ... +2,147,483,647]
  unsigned int   - 4 bytes, range [0 ... +4,294,967,295]
  long           - 8 bytes, range [−9,223,372,036,854,775,808 ...
                                   +9,223,372,036,854,775,807
  unsigned long  - 8 bytes, range [0 ... +18,446,744,073,709,551,615]
  There are pre-defined constants that define the limits of each
  data type in <limits.h>.
  See https://www.tutorialspoint.com/c_standard_library/limits_h.htm
-----------------------------------------------------------------------
*/

/*-----------------------------------------------------------------------
A review of printf format specifiers:
  %d - print an int as a decimal (base 10) number
  %u - print an int as a decimal (base 10) unsigned number
  %x - print an int as a hexadecimal (base 16) number (unsigned)
  %o - print an int as an octal (base 8) number (unsigned)

 All of the above format specifiers assume a 4-byte value.
 To print a value that has a different number of bytes, you must
 precede the letter with a "length modifier"

   h - half (2 bytes)
   hh - half of half (1 byte)
   l - long (8 bytes)

For example:
  %hd - prints a short as a decimal (base 10) number
  %ld - prints a long as a decimal (base 10) number

 -----------------------------------------------------------------------
*/

/*-----------------------------------------------------------------------
CONCEPT 1: Shifting bits.
   You can shift the bits in any ordinal data value.
   >> Shifting right is equivalent to dividing    by powers of 2.
   << Shifting left  is equivalent to multiplying by powers of 2.
   Shifting is a much faster operation than multiplication or division.

Shifting experiments. (Uncomment in main, run, and experiment)
   1. Enter several small positive numbers and study the results
   2. Enter some negative numbers and study the results.
        (Remember your 2-complement's representation from CS351.)
   3. Make the shifts go from 0 to 32. (What happens to the
      high-order bits?)
   4. Change the shift be a right shift (>>). Experiment with
      both positive and negative numbers.
   5. NOTE: The C programming language does not specify whether
      a right shift (>>) is an "arithmetic shift" or a "logical shift".
      Therefore, you must always use a right shift (>>) with caution.
      An "arithmetic shift" retains the sign of a number. If the
      high order bit is a one before the shift, one's will be shifted
      into the number.
      A "logical shift" always fills bits with zero's.
   6. Experiment with different sizes of ordinal data types:
      char, short, and long. You must change the sizeof(int)
      parameter to the toBitStr() function appropriately (in 2
      places.) You must also include a "length modifier" on
      the format specifier. (See notes above.)

-----------------------------------------------------------------------
*/

void shifting_experiments() {
    int alpha;

    // Get a user value
    printf("Please enter an integer value: ");
    scanf("%d", &alpha);
    printf("%12d (%s)\n", alpha, toBitStr(sizeof(int), &alpha));

    // Print the value after it has been shifted
    for (int shift = 0; shift < 32; shift++) {
        int beta = alpha >> shift;
        printf(" shifted %d is %s which is %d\n", shift,
               toBitStr(sizeof(int), &beta), beta );
    }
}

/*-----------------------------------------------------------------------
CONCEPT 2: bit-wise logical operations.
   You can perform logical operations (AND, OR, NOT, COMPLEMENT)
   on the individual bits inside two ordinal values.
   & is bit-wise AND (result is 1 only if both bits are 1)
   | is bit-wise OR  (result is 1 if either bits are 1)
   ^ is bit-wise XOR (result is 1 if the bits are different)
   ~ is bit-wise NOT (or complement) (1's become 0's, 0's become 1's)

Bit-wise logical experiments. (Uncomment from main, run, and experiment)
   1. Enter several small positive numbers and study the results.
   2. Try some negative numbers.
   3. Try some combinations of positive and negative numbers.
   4. Try to modify the code to work with different sizes of
      ordinal data types (char, short, and long)
   5. Study the toBitStr() function at the bottom of this file.
      It uses a right shift (>>) and a bit-wise logical AND (&) to
      get each bit of an ordinal value and append it to a string.
      If you have any questions about how this works, discuss
      the function with your instructor.
 -----------------------------------------------------------------------
*/

void bit_wise_experiments() {
    int alpha;
    int beta;

    // Get two user values
    printf("Please enter an integer value: ");
    scanf("%d", &alpha);
    printf("Please enter an 2nd integer value: ");
    scanf("%d", &beta);
    printf("%12d (%s)\n", alpha, toBitStr(sizeof(int), &alpha));
    printf("%12d (%s)\n", beta,  toBitStr(sizeof(int), &beta));

    // Apply the bit-wise operators and print the results
    // bitwise AND
    int gamma = alpha & beta;
    printf(" alpha & beta %s\n", toBitStr(sizeof(int), &gamma) );

    // bitwise OR
    gamma = alpha | beta;
    printf(" alpha | beta %s\n", toBitStr(sizeof(int), &gamma) );

    // bitwise XOR
    gamma = alpha ^ beta;
    printf(" alpha ^ beta %s\n", toBitStr(sizeof(int), &gamma) );

    // bitwise NOT (or complement)
    gamma = ~alpha;
    printf("       ~alpha %s\n", toBitStr(sizeof(int), &gamma) );
    gamma = ~beta;
    printf("        ~beta %s\n", toBitStr(sizeof(int), &gamma) );
}

/*-----------------------------------------------------------------------
CONCEPT 3: bit-wise manipulation of an ordinal value.
   A. You can GET any bit of an ordinal value by shifting a 1 to
      the desired position (with all other bits 0) and doing
      a bit-wise AND - then compare to zero.
   B. You can SET any bit of an ordinal value by shifting a 1 to
      the desired position (with all other bits 0) and doing
      a bit-wise OR.
   C. You can CLEAR any bit of an ordinal value by shifting a 0 to
      the desired position (with all other bits 1) and doing
      a bit-wise AND.

Bit manipulation experiments. (Uncomment from main, run, and experiment)
   1. Enter several small positive numbers and study the results.
   2. Try some negative numbers.
   3. Try some combinations of positive and negative numbers.
   4. Explain each operation (GET, SET, CLEAR) to your partner and
      make sure each partner understand how the operations work.
   5. Try to modify the code to work with different sizes of
      ordinal data types (char, short, and long)
   6. Study the toBitStr() function at the bottom of this file.
      It uses a right shift (>>) and a bit-wise logical AND (&) to
      get each bit of an ordinal value and append it to a string.
      If you have any questions about how this works, discuss
      the function with your instructor.
 -----------------------------------------------------------------------
*/

void bit_manipulation_experiments() {
    int alpha;
    int whichBit;

    // Get two user values
    printf("Please enter an integer value: ");
    scanf("%d", &alpha);
    printf("Which bit would you like to manipulate (0 is low order bit): ");
    scanf("%d", &whichBit);

    // Display the original value
    printf("%12d        (%s)\n", alpha, toBitStr(sizeof(int), &alpha));

    // GET the bit
    int gamma = alpha & (1 << whichBit);
    if (gamma == 0) {
        printf(" bit %d is a 0\n", whichBit);
    } else { // gamma != 0
        printf(" bit %d is a 1\n", whichBit);
    }

    // SET the bit
    gamma = alpha | (1 << whichBit);
    printf(" with bit %2d set     %s\n", whichBit,
           toBitStr(sizeof(int), &gamma) );

    // CLEAR the bit
    gamma = alpha & ~(1 << whichBit);
    printf(" with bit %2d cleared %s\n", whichBit,
           toBitStr(sizeof(int), &gamma) );
}

/*-----------------------------------------------------------------------
CONCEPT 4: overflow
   Ordinal values have a limited precision based on the number of
   bits used to store them.
   If the result of an operation creates a value that contains more
   binary digits than the data type can store, you have an overflow
   condition and you get the wrong answer!!!!!!!!!!!

Overflow experiments. (Uncomment from main, run, and experiment)
   1. Run this function and examine the results. What happened? Why?
      (Remember the things you learned in CS351!)
   2. Change the data type of alpha to short. (Make sure you change
      the format specifier to %hd. Change the largest value to
      the largest value a short can hold. (See the limit values
      at the top of this document.)
   3. When we calculate a hash value (which we will use as an
      index into a hash table) we often allow overflow to
      happen. Is that OK?
   4. Suppose you are trying to create an integer index into
      an array that has a size of n. Valid indexes are [0, n-1].
      What operation would guarantee that your final value is in
      the appropriate range? (Think about remainders.)
 -----------------------------------------------------------------------
*/

void overflow_experiments() {
    int alpha;

    printf("Add 1 to the largest integer possible\n");
    alpha = 2147483647;  // Largest int possible
    printf("%12d           (%s)\n", alpha, toBitStr(sizeof(int), &alpha));
    alpha = alpha + 1;
    printf("after adding 1 to alpha:\n");
    printf("%12d           (%s)\n", alpha, toBitStr(sizeof(int), &alpha));

    printf("\nTake the largest integer possible and double it\n");
    alpha = 2147483647;  // Largest int possible
    printf("%12d           (%s)\n", alpha, toBitStr(sizeof(int), &alpha));
    alpha = alpha + alpha;
    printf("after adding alpha to itself:\n");
    printf("%12d           (%s)\n", alpha, toBitStr(sizeof(int), &alpha));
}

//---------------------------------------------------------------------
// Convert an ordinal value into a string of 0's and 1's.
// This assumes little endian byte ordering.
// The use of this function in the above code produces a "memory leak"!
// As you study the code, please understand why the "memory leak" happens.
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


