//
// Created by C19Mark.Demore on 3/8/2017.
//

#ifndef AVLTREE_H
#define AVLTREE_H

typedef int ElementType;

typedef struct treeNode {
    ElementType       data;
    struct treeNode * leftTree;
    struct treeNode * rightTree;
    int               height;
    int               heightDifference;
} AvlTreeNode;

AvlTreeNode * avlCreateTree();
AvlTreeNode * avlDeleteTree(AvlTreeNode * tree);
AvlTreeNode * avlInsert    (AvlTreeNode * tree, ElementType newValue);
AvlTreeNode * avlDelete    (AvlTreeNode * tree, ElementType key);
AvlTreeNode * avlFind      (AvlTreeNode * tree, ElementType key);

// Unit test functions
void avlPrint (AvlTreeNode * tree);
int  avlVerifyHeightBalanced(AvlTreeNode * tree);

#endif // AVLTREE_H