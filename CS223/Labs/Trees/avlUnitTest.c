//
// Created by C19Mark.Demore on 3/8/2017.
//

#include <stdio.h>
#include "avlTree.h"

int main() {
    AvlTreeNode *tree;

    tree = avlCreateTree();
    for (int j=0; j<100; j += 10) {
        printf("Inserting %d\n", j);
        tree = avlInsert(tree, j);
        avlPrint(tree);
        avlVerifyHeightBalanced(tree);
    }
}