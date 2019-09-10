//
// Created by C19Mark.Demore on 3/8/2017.
//

#include <stdlib.h>
#include <stdio.h>
#include "avlTree.h"

//---------------------------------------------------------------------
// Helper functions
void          avlUpdateHeight(AvlTreeNode * tree);
AvlTreeNode * avlInsertRecursive(AvlTreeNode * tree, AvlTreeNode * newNode );
void          avlPrintRecursive(AvlTreeNode * tree);
AvlTreeNode * avlRebalance(AvlTreeNode * tree);

//---------------------------------------------------------------------
AvlTreeNode * avlCreateTree() {
    return NULL;
}

//---------------------------------------------------------------------
AvlTreeNode * avlDeleteTree(AvlTreeNode * tree) {
    if (tree != NULL) {
        avlDeleteTree(tree->leftTree);
        avlDeleteTree(tree->rightTree);
        free(tree);
    }
    return NULL;
}

//---------------------------------------------------------------------
AvlTreeNode * avlInsert(AvlTreeNode * tree, ElementType newValue) {
    // Create a new node
    AvlTreeNode * newNode = (AvlTreeNode *) malloc(sizeof(AvlTreeNode));
    if (newNode == NULL) {
        printf("Error in avlInsert. No more memory!");
        exit(1);
    }

    // Initialize the newNode's values
    newNode->data = newValue;
    newNode->leftTree = NULL;
    newNode->rightTree = NULL;
    newNode->height = 1;
    newNode->heightDifference = 0;

    if (tree == NULL) { // the tree is empty
        return newNode; // this is now the root node
    } else {
        return avlInsertRecursive(tree, newNode);
    }
}

//---------------------------------------------------------------------
AvlTreeNode * avlDelete(AvlTreeNode * tree, ElementType key) {
    return NULL;
}

//---------------------------------------------------------------------
AvlTreeNode * avlFind  (AvlTreeNode * tree, ElementType key) {
    return tree;
}

//---------------------------------------------------------------------
void avlPrint(AvlTreeNode * tree) {
    printf("avlTree values in-order:\n");
    avlPrintRecursive(tree);
    printf("\n");
}

void avlPrintRecursive(AvlTreeNode * tree) {
    if (tree != NULL) {
        avlPrintRecursive(tree->leftTree);
        if (tree->leftTree == NULL) {
            printf("LEFT: NULL       ");
        } else {
            AvlTreeNode * left = tree->leftTree;
            printf("LEFT: %2d (%2d,%2d) ", left->data, left->height, left->heightDifference);
        }
        printf("Node: %2d (%2d,%2d) ", tree->data, tree->height, tree->heightDifference);
        if (tree->rightTree == NULL) {
            printf("RIGHT: NULL\n");
        } else {
            AvlTreeNode * right = tree->rightTree;
            printf("RIGHT: %2d (%2d,%2d)\n", right->data, right->height, right->heightDifference);
        }
        avlPrintRecursive(tree->rightTree);
    }
}

//---------------------------------------------------------------------
int avlVerifyHeightBalanced(AvlTreeNode * tree) {
    if (tree == NULL) {
        return 0;
    } else {
        int leftHeight = avlVerifyHeightBalanced(tree->leftTree);
        int rightHeight = avlVerifyHeightBalanced(tree->rightTree);

        if (leftHeight > rightHeight) {
            tree->height = leftHeight + 1;
        } else {
            tree->height = rightHeight + 1;
        }
        int difference = abs(leftHeight - rightHeight);
        if (difference > 1) {
            printf("Tree is not balanced. For node %d, height difference = %d\n", tree->data, difference);
        }
        return tree->height;
    }
}

//---------------------------------------------------------------------
int avlTreeHeight(AvlTreeNode * tree) {
    int height = 0;
    if (tree == NULL) {
        return 0;
    } else {
        int leftHeight = avlTreeHeight(tree->leftTree);
        int rightHeight = avlTreeHeight(tree->rightTree);
        if (leftHeight > rightHeight) {
            height = leftHeight + 1;
        } else {
            height = rightHeight + 1;
        }
        tree->height = height;
        tree->heightDifference = abs(leftHeight - rightHeight);
        return height;
    }
}

//---------------------------------------------------------------------
AvlTreeNode * avlInsertRecursive(AvlTreeNode * tree, AvlTreeNode * newNode ) {
    if(tree == NULL)
    {
        tree = newNode;
    }
    else
    {
        if(newNode->data >= tree->data)
        {
            tree->leftTree = avlInsertRecursive(tree->rightTree,newNode);
        }
        else
        {
            tree->rightTree = avlInsertRecursive(tree->leftTree,newNode);
        }
    }
    avlUpdateHeight(tree);
    if(tree->heightDifference >= 2)
    {
        avlRebalance(tree);
    }
    return tree;
}

//---------------------------------------------------------------------
int getTreeHeightDifference(AvlTreeNode * tree) {
    if (tree == NULL) {
        return -1;  // An invalid difference
    } else {
        return tree->heightDifference;
    }
}

//---------------------------------------------------------------------
void leftRotate(AvlTreeNode * a, AvlTreeNode * b, AvlTreeNode * c) {
    AvlTreeNode * temp = b->leftTree;
    b->leftTree = a;
    a->rightTree = temp;
}

//---------------------------------------------------------------------
void rightRotate(AvlTreeNode * a, AvlTreeNode * b, AvlTreeNode * c) {
    AvlTreeNode * temp = b->rightTree;
    b->rightTree = a;
    a->leftTree = temp;
}

//---------------------------------------------------------------------
AvlTreeNode * avlRebalance(AvlTreeNode * tree) {
    // This function is only called if tree->heightDifference == 2
    // Execute the correct rotation out of 4 cases possible.

    if(tree->leftTree->heightDifference >= 2)
    {
        if(tree->leftTree->rightTree->heightDifference >= 1)
        {
            rightRotate(tree, tree->leftTree, tree->rightTree);
        }
        leftRotate(tree, tree->leftTree, tree->leftTree->leftTree);
    }
    else
    {
        if(tree->rightTree->leftTree->heightDifference >= 1)
        {
            leftRotate(tree, tree->rightTree, tree->leftTree);
        }
        rightRotate(tree, tree->rightTree, tree->rightTree);
    }
    return NULL;  // the new root of the sub-tree
}

//---------------------------------------------------------------------
int getTreeHeight(AvlTreeNode * tree) {
    if (tree == NULL) {
        return 0;
    } else {
        return tree->height;
    }
}

//---------------------------------------------------------------------
void avlUpdateHeight(AvlTreeNode * tree) {
    int height;
    int leftHeight = getTreeHeight(tree->leftTree);
    int rightHeight = getTreeHeight(tree->rightTree);
    if (leftHeight > rightHeight) {
        height = leftHeight + 1;
    } else {
        height = rightHeight + 1;
    }
    tree->height = height;
    tree->heightDifference = abs(leftHeight - rightHeight);
}

int main()
{
    AvlTreeNode * newNode = malloc(sizeof(AvlTreeNode));
    AvlTreeNode * root = malloc(sizeof(AvlTreeNode));

    root->data=0;
    root->leftTree=NULL;
    root->rightTree=NULL;
    avlUpdateHeight(root);

    newNode->data = 6;
    newNode->leftTree = NULL;
    newNode->rightTree = NULL;
    avlUpdateHeight(newNode);

    root = avlInsertRecursive(NULL, newNode);
    newNode->data = 24;
    newNode->leftTree = NULL;
    newNode->rightTree = NULL;
    avlUpdateHeight(newNode);

    root = avlInsertRecursive(root, newNode);
    newNode->data = 27;
    newNode->leftTree = NULL;
    newNode->rightTree = NULL;
    avlUpdateHeight(newNode);

    root = avlInsertRecursive(root, newNode);

    avlPrintRecursive(root);

    free(root);
    free(newNode);

    return 0;
}


