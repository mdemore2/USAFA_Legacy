/** heap_test_program.c
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Section:
 * Project: Lab 31
 * Purpose: Test the implementation of a max-heap
 * ===========================================================
 */

#include <stdio.h>
#include "Heap.h"

typedef struct oneStudent {
    char  name[20];
    int   grades[30];
    float GPA;
} OneStudent;

Boolean compareInts(void * n, void * m);
void printIntArray(int array[], int size);

void printStudentsArray(OneStudent array[], int size);
Boolean compareStudents(void * s1, void *s2);

/** -------------------------------------------------------------------
 * Main program to test the implementation of a max-heap
 * @return the error status of the program.
 */
int main() {
    int num[20] = {0, 72, 10, 22, 8, 9, 7, 21, 3, 1, 4, 5, 6};
    int n = 12;

    Heap * integerHeap = maxHeapCreate(num, 20, 12, sizeof(int),compareInts);
    printIntArray(num, n);

    int testValue = 37;
    maxHeapInsertNewElement(integerHeap, &testValue);
    printIntArray(num, n+1);

    int * max = maxHeapRemoveMaximumElement(integerHeap);
    printf("The maximum value was %d\n", *max);
    printIntArray(num, n);

    OneStudent students[40] = { {"", {}, 0.0},  // First is element not used
                                {"Joe",  {70, 71, 72}, 71.0},
                                {"Fred", {90, 95, 93}, 92.3},
                                {"Mary", {80, 81, 82}, 81.0}
    };

    Heap * studentHeap = maxHeapCreate(students, 40, 3, sizeof(OneStudent), compareStudents);
    printStudentsArray(students, 3);

} //end main

/** -------------------------------------------------------------------
 * Compare two integers.
 * @param n - the address of the first integer
 * @param m - the address of the second integer
 * @return TRUE if the first integer is greater than the second integer
 */
Boolean compareInts(void * n, void * m) {
    int * a = (int *) n;
    int * b = (int *) m;
    return *a > *b;
}

/** -------------------------------------------------------------------
 * Print the contents of an array on a single line.
 * @param array - the array to print
 * @param size - the index of the last value in the array;
 *               the array contents are in positions [1] to [last]
 */
void printIntArray(int array[], int size) {
    for (int j = 0; j <= size; j++) {
        printf("%3d ", array[j]);
    }
    printf("\n");
}

/** -------------------------------------------------------------------
 * Print an array of student records
 * @param array - the array
 * @param size - the number of students
 */
void printStudentsArray(OneStudent array[], int size) {
    for (int j = 0; j <= size; j++) {
        printf("%20s ", array[j].name);
        printf("%6.2f\n", array[j].GPA);
    }
    printf("\n");
}

/** -------------------------------------------------------------------
 * Compare two students and retrun TRUE if the first student has a
 * higher GPA than the second student.
 * @param s1 - a pointer to the first student
 * @param s2 - a pointer to the second student
 * @return - TRUE if the GPA of s1 is greater than the GPA of s2.
 *           FALSE otherwise.
 */
Boolean compareStudents(void * s1, void *s2) {
    OneStudent * a = (OneStudent *) s1;
    OneStudent * b = (OneStudent *) s2;
    return a->GPA > b->GPA;
}