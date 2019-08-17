//
//  ViewController.m
//  stack_create
//
//  Created by lizizhen on 2019/8/17.
//  Copyright © 2019 lizi' zhen. All rights reserved.
//

#import "ViewController.h"

typedef struct Node {
    int data;
    struct Node *pNext;
}NODE, *PNODE;

typedef struct Stack {
    PNODE pTop;
    PNODE pBottom;
}STACK, *PSTACK;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    STACK S; // 等价于 struct Stack
    initStack(&S); // 目的是造出一个空栈
    pushStack(&S, 1);
    pushStack(&S, 3);
    pushStack(&S, -9);
    traverseStack(&S);
    
    int val;
    if (popStack(&S, &val)) {
        printf("出栈的值是：%d\n", val);
    }
    traverseStack(&S);
    
    clearStack(&S);
    traverseStack(&S);
}

// 初始化栈
void initStack(PSTACK pStack) {
    
    pStack->pTop = (PNODE)malloc(sizeof(NODE)); // 给头节点分配内存空间，栈顶指向这个头节点
    if (pStack->pTop == NULL) {
        printf("动态内存分配失败!\n");
        exit(-1);
    } else {
        pStack->pBottom = pStack->pTop;
        pStack->pTop->pNext = NULL; // 等价于pStack->pBottom->pNext = NULL;
    }
    
}

// 栈是否为空
bool emptyStack(PSTACK pStack) {
    if (pStack->pTop == pStack->pBottom) {
        return true;
    }
    return false;
}

// 压栈一次
void pushStack(PSTACK pStack, int val) {
    PNODE pNew = (PNODE)malloc(sizeof(NODE));
    pNew->data = val;
    pNew->pNext = pStack->pTop; // pStack->pTop不能写成pStack->pBottom
    
    pStack->pTop = pNew;
    return;
}

// 出栈一次
bool popStack(PSTACK pStack, int *pVal) {
    if (emptyStack(pStack)) {
        return false;
    }
    
    PNODE r = pStack->pTop;
    *pVal = r->data;
    pStack->pTop = r->pNext;
    free(r);
    r = NULL;
    
    return true;
}

// 遍历栈
void traverseStack(PSTACK pStack) {
    PNODE p = pStack->pTop;
    while (p != pStack->pBottom) {
        printf("%d ", p->data);
        p = p->pNext;
    }
    printf("\n");
    return;
}

//清空
void clearStack(PSTACK pStack) {
    if (emptyStack(pStack)) {
        return;
    }
    
    PNODE p = pStack->pTop;
    PNODE q = NULL;
    
    while (p != pStack->pBottom) {
        q = p->pNext;
        free(p);
        p = q;
    }
    pStack->pTop = pStack->pBottom;
}

@end

