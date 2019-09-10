//
// Created by C19Mark.Demore on 3/15/2017.
//
#include "TernaryTree.h"
#include "WordList.h"
#include "stdio.h"
#ifndef CS223_REPOSITORY_SPRING_2017_PEX2_H
#define CS223_REPOSITORY_SPRING_2017_PEX2_H

void stripNewline(char *word);
WordList * readDictionary(FILE * file);
void insertBalanced(TernaryTree * root, WordList * dictionary, int min, int max);

#endif //CS223_REPOSITORY_SPRING_2017_PEX2_H
