/** PEX2.c
* ===========================================================
* Name: Mark Demore II, 15 Mar 17
* Section: T3A
* Project: PEX2 - Scrabble Words
* Purpose: establishes basic TernaryTree functions
* ===========================================================
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "WordList.h"
#include "TernaryTree.h"

/*TernaryTree * ternaryTreeCreate();
void ternaryTreeDelete(TernaryTree * tree);
void ternaryTreeInsert(TernaryTree * tree, char * word);
WordList * ternaryTreeFindPattern(TernaryTree * tree, char * pattern);*/

/**
 * Creates TernaryTree struct with initial values for empty and null
 * @return empty TernaryTree pointer
 */
TernaryTree * ternaryTreeCreate()
{
    TernaryTree * root = malloc(sizeof(TernaryTree));
    root->data = '*';
    root->down=NULL;
    root->left=NULL;
    root->right=NULL;
    return root;
}

/**
 * Deletes TernaryTree to free memory and prevent leak
 * @param root - TernaryTree to delete
 */
void ternaryTreeDelete(TernaryTree * root)
{
    if(root->left != NULL)
    {
        ternaryTreeDelete(root->left);
    }
    if(root->down != NULL)
    {
        ternaryTreeDelete(root->down);
    }
    if(root->right != NULL)
    {
        ternaryTreeDelete(root->right);
    }
    free(root);
}

/**
 * Insert words in tree, ordered based on alphabetical order
 * @param root - tree to insert word into
 * @param word  - word to insert into tree
 */
void ternaryTreeInsert(TernaryTree * root, char * word)
{
    char empty = '*';
    if (word[0] == '\0') {
        root->data = word[0];
        root->down = NULL;

    }
    else if(root == NULL)
    {
        //break
    }
    else if(root->data == empty)
    {
        root->data = word[0];
        if(root->down == NULL)
        {
            root->down = ternaryTreeCreate();
        }

        ternaryTreeInsert(root->down, &word[1]);

    }
    else if(strncmp(&root->data, &word[0],1) < 0)
    {
        if(root->right == NULL)
        {
            root->right = ternaryTreeCreate();
        }
        ternaryTreeInsert(root->right,&word[0]);

    }
    else if(strncmp(&root->data, &word[0],1) > 0)
    {
        if(root->left == NULL)
        {
            root->left = ternaryTreeCreate();
        }
        ternaryTreeInsert(root->left,&word[0]);
    }
    else if(strncmp(&root->data, &word[0],1) == 0)
    {
        if(root->down == NULL)
        {
            root->down = ternaryTreeCreate();
        }
        ternaryTreeInsert(root->down,&word[1]);
    }
}

/**
 * Pattern matching to find potential scrabble plays, using '.' as wildcard character
 * @param root - tree to search
 * @param pattern - word with wildcard to find
 * @return - list of word matches
 */
WordList * ternaryTreeFindPattern(TernaryTree * root, char * pattern)
{
    WordList * list = wordListCreate();
    char * newWord = malloc(sizeof(char)*20);
    if(strncmp(&root->data,pattern,1)==0)
    {
        newWord = &root->data;
        ternaryTreeFindPattern(root->down,pattern+1);
        wordListAdd(list,newWord);
    }
    else if(strncmp(&root->data,pattern,1)>0)
    {
        ternaryTreeFindPattern(root->left,pattern);
    }
    else if(strncmp(&root->data,pattern,1)<0)
    {
        ternaryTreeFindPattern(root->right,pattern);
    }

    return list;
}

/*
int main()
{

    char * word1 = "cot";
    char * word2 = "cat";
    char * word3 = "cut";

    char * word4 = "succumb";
    char * word5 = "succeed";
    char * word6 = "success";

    TernaryTree * root = ternaryTreeCreate();

    ternaryTreeInsert(root, word1);
    ternaryTreeInsert(root, word2);
    ternaryTreeInsert(root, word3);

    ternaryTreeDelete(root);

    TernaryTree * node = ternaryTreeCreate();

    ternaryTreeInsert(node, word6);
    ternaryTreeInsert(node, word5);
    ternaryTreeInsert(node, word4);

    ternaryTreeDelete(node);

    return 0;
}*/
