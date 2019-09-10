/** WordList.h
 * ===========================================================
 * Name: James.Lotspeich, 1/19/2017
 * Section:
 * Project: PEX2
 * Purpose: Create and manipulate a list of words.
 * ===========================================================
 */

#ifndef PEX2_TST_WORDLIST_H
#define PEX2_TST_WORDLIST_H

// ===================================================================================================================
// Constants/Macros
// ===================================================================================================================

#define MAXSTRINGLENGTH 20

// ===================================================================================================================
// Type declarations
// ===================================================================================================================

typedef struct wordList {
    int numElements;
    char **words;
} WordList;

// ===================================================================================================================
// Constructors/Destructors
// ===================================================================================================================

/*
 * Create a new WordList
 * Return:
 *      An initialized WordList
 */
WordList * wordListCreate();

/*
 * Free the memory used by a WordList data structure
 */
void wordListDelete(WordList *words);

// ===================================================================================================================
// Modifier functions
// ===================================================================================================================

/**
 * Adds a word to the end of a WordList
 * @param words - an initialized WordList
 * @param word - the word to add to the list
 * @return true if the word was added, false otherwise.
 */
int wordListAdd(WordList *words, char *word);

/**
 * Combines two wordlists together by copying the source WordList into the destination WordList.
 *      Note:  The combined WordList will be in sorted order.
 * @param dest - a WordList pointer
 * @param source - a WordList pointer
 * @return the combined Wordlist
 */
WordList * wordListCombine(WordList *dest, WordList *source);

/**
 * Append a prefix to every word in the WordList
 * @param words - an initialized WordList
 */
void wordListAppendPrefix(WordList *words, char *prefix);

// ===================================================================================================================
// Utility functions
// ===================================================================================================================

/**
 * Returns the word at the index value.
 * @param words - a WordList pointer
 * @param index - the index value of the word to retrieve
 * @return the word that was retrieved, or NULL if no such index exists
 */
char * wordListGet(WordList *words, int index);

/**
 * Return the number of words in the WordList
 * @param words - a WordList pointer
 * @return the number of words in the WordList, or 0 if words is not initialized
 */
int wordListSize(WordList *words);


#endif //PEX2_TST_WORDLIST_H
