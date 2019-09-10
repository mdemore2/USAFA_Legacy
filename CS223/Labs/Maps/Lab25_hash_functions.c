//
// Created by Dr. Wayne Brown on 3/15/2017.
//

//=====================================================================
// A hash function performs a calculation (or bit manipulation) of
// a "key" value to generate an array index. In this lab you will
// experiment with the hash functions used by Python dictionaries.
//
// Python uses a different algorithm for each data type used for keys.
// The rules for Python dictionary keys are:
//    1) keys must be immutable.
//    2) keys can be numbers (e.g., 37, -23, 8755235)
//    3) keys can be strings (e.g., "fred", "unix", "apples")
//    4) keys can be tuples (e.g., (1, 4, "fred") )
//       (a tuple is an immutable list).
//
// The initial size of a Python's dictionary hash table array is 8.
//
//=====================================================================

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

// local function definitions
int hashNumber(int arraySize, int number);
int hashString(int arraySize, char *str);
void hashNumber_experiments();
void hashString_experiments();
void hashTuple_experiments();

int main() {
    hashNumber_experiments();
//   hashString_experiments();
//    hashTuple_experiments(); //(See description below, but no code.)
}

/*-----------------------------------------------------------------------
1. HASH FUNCTION when the key is a number:
   Python simply takes the key number and uses the low order bits
   consistent with the size of the hash table. For example,
   the following table shows the number of bits used for various
   array sizes. We will assume that the size of the table is always
   a power of 2.
   Array size     Low order bits
       8                 3
      16                 4
      32                 5
      64                 6

   Implement a function that receives an array size and an
   integer key value and returns an index value into the array.
   If the array size is n, the index must be a value in the
   range [0,n-1]. Use bit manipulation to "calculate" the
   array index.

   Hint: Use a bit-wise operation to get only the low order bits
   of the key. Think about the key value as a binary number.
   Write out the size value as a binary number. Think in binary!
-----------------------------------------------------------------------
*/

int hashNumber(int hashTableArraySize, int key) {
    // hashTableArraySize must be a power of 2.
    // Subtracting one creates a value that has all one's in the low
    // order bits.
    // Using bit-wise AND removes all the high order bits.

    double root = log(hashTableArraySize)/log(2);
    int bitCounter = 0;
    int returnVal = 0;

    if((int) root == root)
    {
        hashTableArraySize = hashTableArraySize - 1;
        returnVal = hashTableArraySize & key;
        while (hashTableArraySize > 0)
        {
         hashTableArraySize = hashTableArraySize >> 1;
            bitCounter++;
        }
        printf("Bits needed: %d\n", bitCounter);
    }
    return returnVal;

}

void hashNumber_experiments() {
    int size;
    int key;

    printf("Please enter the size of the hash table (a power of 2): ");
    scanf("%d", &size);
    printf("Please enter a key value: ");
    scanf("%d", &key);
    printf("The key hashes to index %d\n", hashNumber(size, key));
}

/*-----------------------------------------------------------------------
2. HASH FUNCTION when the key is a string:
    The function below implements the hash function used by
    Python to create an array index from a string. Please
    study the code, discuss it with your coding partner,
    and try it out.

 -----------------------------------------------------------------------
*/
int hashString(int hashTableArraySize, char * str) {
    // algorithm: (source: http://www.laurentluce.com/posts/python-dictionary-implementation/)
    // set len to string's length
    // initialize var p pointing to 1st char of string object
    // set x to value pointed by p left shifted by 7 bits
    // while len >= 0:
    //    set var x to (1000003 * x) xor value pointed by p
    //    increment pointer p
    // set x to x xor length of string object
    // return x as the hash

    int len = (int) strlen(str);
    char * p   = str;
    int    x   = *p << 7;
    while (*p != '\0') {
        x = 1000003 * x ^ *p;
        p++;
    }
    x = x ^ len;
    return x & (hashTableArraySize-1);
}

void hashString_experiments() {
    int size;
    char key[100];

    printf("Please enter a STRING key value:\n");
    fgets(key, 100, stdin);
    key[strlen(key)-1] = '\0'; // Removes the new-line character
    printf("Please enter the size of the hash table (a power of 2): ");
    scanf("%d", &size);
    printf("The key '%s' hashes to index %d\n", key, hashString(size, key));
}

/*-----------------------------------------------------------------------
3. HASH FUNCTION when the key is a tuple:
    A tuple in Python is an immutable list.
    A list can contain various types of data, such as a combination
    of numbers and strings. For example:
    exampleTuple = ('Test', 37, 76, "a string");

    This is the algorithm Python uses to convert a tuple to an
    array index, but it is difficult to simulate in C because
    C does not allow lists (arrays) to contain different data types.

    value = 0x345678
    for item in tuple:
        if item is a number:
            value = (1000003 * value) ^ hashNumber(item)
        else if item is a string:
            value = (1000003 * value) ^ hashString(item)

    value = value ^ len(tuple)

 -----------------------------------------------------------------------
*/








