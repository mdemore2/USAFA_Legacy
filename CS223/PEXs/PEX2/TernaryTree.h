//
// Created by C19Mark.Demore on 3/2/2017.
//

#ifndef CS223_REPOSITORY_SPRING_2017_TERNARYTREE_H
#define CS223_REPOSITORY_SPRING_2017_TERNARYTREE_H

typedef struct ternaryTree{
    char data;
    struct ternaryTree * down;
    struct ternaryTree * left;
    struct ternaryTree * right;
}TernaryTree;

TernaryTree * ternaryTreeCreate();
void ternaryTreeDelete(TernaryTree * tree);
void ternaryTreeInsert(TernaryTree * tree, char * word);
WordList * ternaryTreeFindPattern(TernaryTree * tree, char * pattern);


#endif //CS223_REPOSITORY_SPRING_2017_TERNARYTREE_H
