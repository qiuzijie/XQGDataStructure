//
//  main.m
//  XQGTreePractice
//
//  Created by qiuzijie on 2018/10/9.
//  Copyright © 2018 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>


typedef struct BiTNode{
    int data;
    struct BiTNode *lchild, *rchild;
} BiTNode, *BiTree;

typedef struct LStack{
    BiTree data[100];
    int top;
} LStack;

#pragma mark- 创建二叉链表
void CreateBiTree(BiTree *T){
    *T=(BiTNode*)malloc(sizeof(BiTNode));
    (*T)->rchild = NULL;
    (*T)->data = 1;
    (*T)->lchild=(BiTNode*)malloc(sizeof(BiTNode));
    (*T)->rchild=(BiTNode*)malloc(sizeof(BiTNode));
    (*T)->lchild->data = 2;
    (*T)->rchild->data = 3;
    (*T)->lchild->lchild = (BiTNode*)malloc(sizeof(BiTNode));
    (*T)->lchild->rchild = (BiTNode*)malloc(sizeof(BiTNode));
    (*T)->rchild->lchild = (BiTNode*)malloc(sizeof(BiTNode));
    (*T)->rchild->rchild = (BiTNode*)malloc(sizeof(BiTNode));
    (*T)->lchild->lchild->data=4;
    (*T)->lchild->lchild->lchild=NULL;
    (*T)->lchild->lchild->rchild=NULL;
    (*T)->lchild->rchild->data=5;
    (*T)->lchild->rchild->lchild=NULL;
    (*T)->lchild->rchild->rchild=NULL;
    (*T)->rchild->lchild->data=6;
    (*T)->rchild->lchild->lchild=NULL;
    (*T)->rchild->lchild->rchild=NULL;
    (*T)->rchild->rchild->data=7;
    (*T)->rchild->rchild->lchild=NULL;
    (*T)->rchild->rchild->rchild=NULL;
}

void visit(BiTree T){
    if (T) {
        printf(" %d",T->data);
    }
}

void push(BiTree T, LStack *S){
    (*S).data[++(*S).top] = T;
    
}

BiTree pop(LStack *S){
    if ((*S).top == -1) {
        return NULL;
    }
    return (*S).data[(*S).top--];
}

#pragma mark- 先序遍历_递归
void preOrder(BiTree T){
    if (T) {
        visit(T);
        preOrder(T->lchild);
        preOrder(T->rchild);
    }
}

#pragma mark- 先序遍历_栈
void preOrder_Stack(BiTree T){
    LStack stack;
    stack.top = -1;
    push(T, &stack);
    while (stack.top != -1) {
        BiTree p = pop(&stack);
        while (p) {//先把左树访问完，右节点压栈
            visit(p);
            if (p->rchild) {
                push(p->rchild, &stack);
            }
            p=p->lchild;
        }
    }
}

#pragma mark- 中序遍历
void inOrder(BiTree T){
    if (T) {
        inOrder(T->lchild);
        visit(T);
        inOrder(T->rchild);
    }
}

#pragma mark- 后序遍历
void postOrder(BiTree T){
    if (T) {
        postOrder(T->lchild);
        postOrder(T->rchild);
        visit(T);
    }
}

int main() {
    BiTree T;
    CreateBiTree(&T);
    printf("\n--------** preOrder1 **--------\n");
    preOrder(T);
    printf("\n--------** preOrder2 **--------\n");
    preOrder_Stack(T);
    printf("\n--------** inOrder **--------\n");
    inOrder(T);
    printf("\n--------** postOrder **--------\n");
    postOrder(T);
    return 0;
}
