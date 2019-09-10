/** PEX2.c
* ===========================================================
* Name: Mark Demore II, 15 Mar 17
* Section: T3A
* Project: PEX2 - Scrabble Words
* Purpose: ensures tree is balanced through insertion order, reads dictionary from file
* Documentation: segfaults debugged by C3C Payne, error resulting from redundant mallocs in PEX2.c
* ===========================================================
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "WordList.h"
#include "TernaryTree.h"

/**
 * Remove newline chars from words after read from file
 * @param word - word to strip newline char from
 */
void stripNewline(char *word){
    char *newLine;
    if ((newLine = strchr(word, '\n')) != NULL) {
        *newLine = '\0';
    }
    if ((newLine = strchr(word, '\r')) != NULL) {
        *newLine = '\0';
    }
}

/**
 * Read file and create wordlist from it
 * @param file - file to read words from
 * @return wordlist containing all words, sorted
 */
WordList * readDictionary(FILE * file)
{
    char newWord[20];
    WordList * dictionary = wordListCreate();
    while(fgets(newWord,20,file) != NULL)
    {
        stripNewline(newWord);
        printf("%s\n", newWord);
        wordListAdd(dictionary,newWord);

    }
    return dictionary;
}

/**
 * Navigate wordlist to insert into tree that would stay height balanced
 * @param root - tree to insert word into
 * @param dictionary - wordlist of words to insert
 * @param min - track min location in list to keep ordered
 * @param max  - track max location in list to keep ordered
 */
void insertBalanced(TernaryTree * root, WordList * dictionary, int min, int max)
{
    int mid = (max-min)/2+min;
    char * word = wordListGet(dictionary,mid);
    ternaryTreeInsert(root,word);
    printf("Inserting: %s\n",word);
    if(max != mid)
    {
        insertBalanced(root,dictionary,mid+1,max);
    }
    if(min != mid)
    {
        insertBalanced(root,dictionary,min,mid-1);
    }
}
/*
int main()
{
    FILE * file;
    file = fopen("PEXs/PEX2/test_dict1.txt","r");
    WordList * dictionary = readDictionary(file);
    TernaryTree * root = ternaryTreeCreate();
    int max = wordListSize(dictionary);
    insertBalanced(root,dictionary,0,max-1);
    fclose(file);
    return 0;
}*/
