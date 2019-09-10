// ====================================================================
// CS223 Lab02 - An array of struct's.
// Textbook pages 9-11. (Modified for format, style, and error issues.)
//
// Modified by C3C Demore
// ====================================================================

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>
#include <unistd.h>

#define MaxStudents 100
#define MaxNameLength 30
#define MaxNameBuffer MaxNameLength+1
#define NULL_CHAR  '\0'

typedef struct
{
    char name[MaxNameBuffer];
    int age;
    char gender;
    int squad;
} Student;

// ---------------------------------------------------------------------
int main()
{
    Student pupil[MaxStudents];
    char aName[MaxNameBuffer];
    void getString(FILE *, char[]);
    int getData(FILE *, Student[]);
    int search(char[], Student[], int);
    void sort(Student[], int);
    void printStudent(Student);
    void getString(FILE *, char[]);

    // Prints the "current working directory" for debugging if there
    // are problems reading the input file.
//    char cwd[1024];
//    if (getcwd(cwd, sizeof(cwd)) != NULL) {
//        printf("%s\n", cwd);
//    }

    // Open an input file for reading
    FILE *in = fopen("Data_files/Lab02_data.txt", "r");
    if (in == NULL)
    {
        printf("Error opening file: %s.\n", strerror(errno));
        exit(1);
    }

    // Fill the pupil array with data from the input file
    int numStudents = getData(in, pupil);
    if (numStudents == 0)
    {
        printf("No data supplied for students");
        exit(1);
    }

    // Print the data in the pupil array.
    printArray(numStudents,pupil);
    printf("\n");

    // Search for a student in the pupil array
    getString(in, aName);  // Read a pupil name

    while (strcmp(aName, "END") != 0)
    {
        printf("Looking for %s\n", aName);
        int ans = search(aName, pupil, numStudents);
        if (ans == -1)
        {
            printf("%s not found\n", aName);
        } else
        {
            printf("%s found at location %d\n", aName, ans);
        }
        getString(in, aName); // Read the next pupil name
    }

    // Sort the students in the pupil array
    sort(pupil, numStudents);

    // Print the pupil array, which is now in sorted order
    printArray(numStudents,pupil);
} //end main

// ---------------------------------------------------------------------
void printStudent(Student t)
{
    printf("Name: %-30s Age: %2d Gender: %c Squadron: %d\n", t.name, t.age, t.gender, t.squad);
} //end printStudent
void printArray(int numStudents, Student pupil[]){
    printf("\n");
    for (int j = 0; j < numStudents; j++) {
        printStudent(pupil[j]);
    }
}
// ---------------------------------------------------------------------
int search(char key[], Student list[], int n)
{
    // Search for key in list[0] to list[n-1]
    // If found, return the location; if not found, return -1
    for (int j = 0; j < n; j++)
    {
        if (strcmp(key, list[j].name) == 0)
        {
            return j;
        }
    }

    // The key was not found, so return an invalid position in the array.
    return -1;
} //end search

// ---------------------------------------------------------------------
void sort(Student list[], int n)
{
    // Sort list[0] to list[n-1] by name using an insertion sort
    Student temp;
    int k;

    for (int j = 1; j < n; j++)
    {
        temp = list[j];
        k = j - 1;
        while (k >= 0 && (temp.age < list[k].age))
        {
            list[k + 1] = list[k];
            k = k - 1;
        }
        list[k + 1] = temp;
    } //end for
} //end sort

// ---------------------------------------------------------------------
int getData(FILE *in, Student list[])
{
    char temp[MaxNameBuffer];
    void getString(FILE *, char[]);
    char readChar(FILE *);

    int n = 0;
    getString(in, temp);  // gets the pupil's name
    while (n < MaxStudents && strcmp(temp, "END") != 0)
    {
        strcpy(list[n].name, temp);  // copies the pupil's name into the struct
        fscanf(in, "%d", &list[n].age);  // reads the pupil's age
        list[n].gender = readChar(in);   // reads the pupil's gender
        fscanf(in, "%d", &list[n].squad); //read squad?

        n++;  // We now have one more pupil in the array

        getString(in, temp); // read the next pupil's name
    }

    return n;  // return the number of pupils that were read into the array
} //end getData

// ---------------------------------------------------------------------
void getString(FILE *in, char str[])
{
    // Stores, in str, the next string within delimiters.
    // The first non-whitespace character is the delimiter.
    // The string is read from the file 'in'.
    char ch, delimiter;
    int n = 0;

    // Initialize the string with zero characters. The last character in a
    // string is always a NULL character, which is a zero.
    str[0] = NULL_CHAR; // '\0';

    // Read characters until you get a non-white-space character
    ch = getc(in);
    while (isspace(ch))
    {
        ch = getc(in);
    }

    if (ch == EOF)
    {
        return;
    }

    delimiter = ch;
    ch = getc(in);  // read the first character
    while ((ch != delimiter) && (ch != EOF))
    {
        str[n++] = ch;
        ch = getc(in);  // read the next character
    }
    str[n] = NULL_CHAR; // The last character of a string is always 0 (NULL).

} // end getString

// ---------------------------------------------------------------------
char readChar(FILE *in)
{
    char ch;
    // Skip over zero or more spaces.
    ch = (char) getc(in);
    while (isspace(ch))
    {
        ch = (char) getc(in);
    }

    // Return the first non-space.
    return ch;
} //end readChar

/* ====================================================================
 * Instructions:
 * 1) Make sure you can build and run this program as it is. Don't
 *    proceed until the program, as it is, executes correctly.
 * 2) Add one or more students to the data file. Confirm that the
 *    new students appear in the output correctly.
 * 3) Add one or more names to the "search names". Confirm that they
 *    are found (or not found) correctly.
 * 4) Modify the struct to store a squadron number with each student.
 *    Then modify the getData() function to read this new value from the
 *    data file into each struct element. Then modify the printStudent()
 *    function to print this value for a student. Verify that your program
 *    still works correctly.
 *  5) Modify the sort function to sort on student age (instead of name).
 *     Verify that your program still works correctly.
 *  6) Printing all of the students is done with redundant code in
 *     the main() function. (Lines 58-63 and 82-86.) Move this code
 *     into a single function and call it appropriately.
 */
