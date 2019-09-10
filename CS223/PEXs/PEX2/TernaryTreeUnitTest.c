/** TernaryTreeUnitTest.c
* ===========================================================
* Name: Mark Demore II, 15 Mar 17
* Section: T3A
* Project: PEX2 - Scrabble Words
* Purpose: provides test cases for insert function
* ===========================================================
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "WordList.h"
#include "TernaryTree.h"
#include "PEX2.h"

int main()
{
    FILE * file;
    file = fopen("PEXs/PEX2/test_dict2.txt","r");
    WordList * dictionary = readDictionary(file);
    TernaryTree * root = ternaryTreeCreate();
    int max = wordListSize(dictionary);
    for(int i = 0; i < max; i++)
    {
        printf("Inserting: %s\n",wordListGet(dictionary,i));
        ternaryTreeInsert(root,wordListGet(dictionary,i));      //test insert functionality
    }
    fclose(file);
    wordListDelete(dictionary);
    ternaryTreeDelete(root);

    file = fopen("PEXs/PEX2/test_dict1.txt","r");
    dictionary = readDictionary(file);
    root = ternaryTreeCreate();
    max = wordListSize(dictionary);
    insertBalanced(root,dictionary,0,max-1);                //test balanced insert functionality
    fclose(file);
    wordListDelete(dictionary);
    ternaryTreeDelete(root);

    /*file = fopen("PEXs/PEX2/test_dict1.txt","r");
    dictionary = readDictionary(file);
    root = ternaryTreeCreate();
    max = wordListSize(dictionary);
    char * pattern = "C.T";
    ternaryTreeFindPattern(root,pattern);           //test pattern matching functionality
    fclose(file);
    wordListDelete(dictionary);
    ternaryTreeDelete(root);*/

    return 0;
}