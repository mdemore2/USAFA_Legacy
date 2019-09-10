/** PEX3_word_verifier.c
 * ===========================================================
 * Name: Dr. Wayne Brown, Spring 2017
 * Modified by: Mark Demore II
 * Section: T3A
 * Project: PEX3
 * Purpose: Implement a program that creates a hash table that
 *          holds a large dictionary of words.
 * ===========================================================
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "HashTable.h"

#define MAXSTRINGLENGTH 22


void loadWordsIntoHashTable(char *fileName, HashTable * table);
void findAllWords(char *fileName, HashTable * table);
void countCollisions(HashTable * table);

void stripNewline(char *word);
unsigned int wordHashFunction1(HashTable *table, void *word);
unsigned int wordHashFunctionA(HashTable *table, void *word);
unsigned int wordHashFunctionB(HashTable *table, void *word);
unsigned int wordHashFunctionC(HashTable *table, void *word);
Boolean compareTwoWords(void * word1, void * word2);

/**
 * Main program
 * @return exit status - 0 means no errors
 */
int main() {
    char * dictionaryFileName = "PEXs/PEX2/dictionary.txt";
    HashTable * table;

    /*table = hashTableCreate(200000, wordHashFunction1, compareTwoWords);

    loadWordsIntoHashTable(dictionaryFileName, table);
    printf("It ain't a loadin error");
    findAllWords(dictionaryFileName, table);

    countCollisions(table);

    hashTableDelete(table, TRUE);*/

    /*table = hashTableCreate(200000, wordHashFunctionA, compareTwoWords);

    loadWordsIntoHashTable(dictionaryFileName, table);

    findAllWords(dictionaryFileName, table);

    countCollisions(table);

    hashTableDelete(table, TRUE);*/

    table = hashTableCreate(200000, wordHashFunction1, compareTwoWords);

    loadWordsIntoHashTable(dictionaryFileName, table);

    findAllWords(dictionaryFileName, table);

    countCollisions(table);

    hashTableDelete(table, TRUE);

   /* table = hashTableCreate(200000, wordHashFunctionC, compareTwoWords);

    loadWordsIntoHashTable(dictionaryFileName, table);

    findAllWords(dictionaryFileName, table);

    countCollisions(table);

    hashTableDelete(table, TRUE);*/

    return 0; //  no errors
}

/**
 * Load the words stored in the specified file into a hash table.
 * Each line in the file contains one word.
 * @param fileName - the name of the file that contains the dictionary words.
 * @param table - the hash table to contain all the dictionary words.
 */
void loadWordsIntoHashTable(char *fileName, HashTable * table) {
    char buffer[MAXSTRINGLENGTH + 1];
    char * newWord;
    int  numberWordsInDictionary = 0;

    FILE * fp = fopen(fileName, "r");
    if (fp == NULL) {
        printf("ERROR, the file '%s' could not be opened.\n", fileName);
        exit(1); // terminate the program
    }

    while (fgets(buffer, MAXSTRINGLENGTH, fp) != NULL) {
        stripNewline(buffer);

        // Create a separate block of memory for each word
        newWord = malloc(sizeof(char) * strlen(buffer) + 1);
        strcpy(newWord, buffer);

        // printf("%s\n", name);
        hashTableInsertElement(table, newWord);
        numberWordsInDictionary++;
    }
    fclose(fp);

    printf("Total words in dictionary: %d\n", numberWordsInDictionary);
}

/**
 * Find all the words that were inserted into the hash table. If a word
 * can't be found, there is something wrong with the hash table.
 * @param fileName - the name of the file that contains all the dictionary words.
 * @param table - the hash table that has stored all the dictionary words.
 */
void findAllWords(char *fileName, HashTable * table) {
    char buffer[MAXSTRINGLENGTH + 1];
    int  wordsFound = 0;
    int  wordsNotFound = 0;

    FILE * fp = fopen(fileName, "r");
    if (fp == NULL) {
        printf("ERROR, the file '%s' could not be opened.\n", fileName);
        exit(1); // terminate the program
    }

    while (fgets(buffer, MAXSTRINGLENGTH, fp) != NULL) {
        stripNewline(buffer);

        //if (hashTableFind(table, buffer)) {
        if (compareTwoWords(hashTableFind(table,buffer),buffer))
        {
            printf("Found word '%s'\n", buffer);
            wordsFound++;
        } else
        {
            printf("Could not find word '%s'\n", buffer);
            wordsNotFound++;
        }
    }
    fclose(fp);

    printf("Words found:     %7d\n", wordsFound);
    printf("Words not found: %7d\n", wordsNotFound);
}

/**
 * Gather statistics about a hash table and print the statistics
 * to the console window.
 * @param table - the hash table
 */
void countCollisions(HashTable * table) {
    int openSlots = 0;
    int slotsUsed = 0;
    int totalElements = 0;
    float avgElementsPerIndex = 0.0;
    int numberCollisions = 0;

    for (unsigned int index=0; index < table->arraySize; index++) {
        void * element = hashTableGetFirst(table, index);
        if (element != NULL) {
            slotsUsed++;
            int numInBucket = 1;
            while (hashTableGetNext(table, index) != NULL) {
                numInBucket++;
            }
            if (numInBucket > 1) {
                numberCollisions++;
            }
            totalElements += numInBucket;
        } else {
            openSlots++;
        }
    }

    printf("Total elements = %d\n", totalElements);
    printf("Number collisions         = %7d\n", numberCollisions);
    printf("Hash table slots used     = %7d\n", slotsUsed);
    printf("Hash table slots not used = %7d\n", openSlots);
    avgElementsPerIndex = (float) totalElements / (float) slotsUsed;
    printf("Average elements per bucket = %12.3f\n", avgElementsPerIndex);
}

/**
 * A hash function for a dictionary of words
 * @param table - the hash table
 * @param word - a single string (one element in the hash table)
 * @return - an index into the hash table where the element should
 *           be stored.
 */
unsigned int wordHashFunction1(HashTable *table, void *word) {
    char * w = (char *) word;
    unsigned int total = 0;
    for (int j=0; w[j] != '\0'; j++) {
        total += (total << 8) + (unsigned int) w[j];
    }
    total += strlen(w);
    return (unsigned int) (total % table->arraySize);
}
/**
 * A hash function for a dictionary of words
 * @param table - the hash table
 * @param word - a single string (one element in the hash table)
 * @return - an index into the hash table where the element should
 *           be stored.
 */
unsigned int wordHashFunctionA(HashTable *table, void *word) {
    char * w = (char *) word;
    unsigned int total = 0;
    total = (unsigned int) w[0];
    return total;
}
/**
 * A hash function for a dictionary of words
 * @param table - the hash table
 * @param word - a single string (one element in the hash table)
 * @return - an index into the hash table where the element should
 *           be stored.
 */
unsigned int wordHashFunctionB(HashTable *table, void *word) {
    char * w = (char *) word;
    unsigned int num = 0;
    for (int j=0; w[j] != '\0'; j++) {
        num = (unsigned int) w[j];
        num = (~ num) + 1;
    }

    return num;
}
/**
 * A hash function for a dictionary of words
 * @param table - the hash table
 * @param word - a single string (one element in the hash table)
 * @return - an index into the hash table where the element should
 *           be stored.
 */
unsigned int wordHashFunctionC(HashTable *table, void *word) {
    char * w = (char *) word;
    unsigned int total = 0;
    unsigned int num = 0;
    unsigned int length = 0;

    for (int j=0; w[j] != '\0'; j++) {
        num += (unsigned int) w[j];
        length = (unsigned int) j;
    }
    total = num + ((unsigned int) w[0]) + length;
    total = total ^ length;
    return total;
}
/**
 * Compare two strings for equality.
 * @param word1 - a pointer to a string.
 * @param word2 - a pointer to a string.
 * @return - TRUE if the two strings are equal, FALSE otherwise
 */
Boolean compareTwoWords(void * word1, void * word2) {
    char * w1 = (char *) word1;
    char * w2 = (char *) word2;
    return strcmp(w1,w2) == 0;
}

/**
 * Remove any carriage return or new-line characters from a string.
 * @param word - the string to modify.
 */
//
void stripNewline(char *word){
    char *newLine;
    if ((newLine = strchr(word, '\n')) != NULL) {
        *newLine = '\0';
    }
    if ((newLine = strchr(word, '\r')) != NULL) {
        *newLine = '\0';
    }
}


