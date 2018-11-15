//
//  main.m
//  XQGSortPractice
//
//  Created by qiuzijie on 2018/10/23.
//  Copyright © 2018 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>

void print(int a[], int length, int time) {
    printf("\n%d:",time);
    for (int i = 0; i < length; i++) {
        printf(" %d",a[i]);
    }
}

void swap(int *a, int *b){
    int temp = *a;
    *a = *b;
    *b = temp;
}

void randomArray(int a[], int length){
    for (int i = 0; i < length; i++) {
        a[i] = rand() % 50+1;
    }
}

#pragma mark- 直接插入
void simpleInsertSort(int a[], int length) {
    printf("\ninsertSort");
    for (int i = 1; i < length; i++) {
        if (a[i] < a[i-1]) {
            int j = i-1;
            int x = a[i];
            while (j >= 0 && a[j] > x) {
                a[j+1] = a[j];
                j--;
            }
            a[j+1] = x;
        }
        print(a, length, i);
    }
}

#pragma mark- 折半插入
void binaryInsertongSort(int a[], int length){
    printf("\nbinaryInsertongSort");
    for (int i = 1; i < length; i++) {
        if (a[i] < a[i-1]) {
            int low = 0, high = i, mid;
            int key = a[i];
            while (low <= high) {
                mid = (low + high) / 2;
                if (a[mid] > key) {
                    high = mid-1;
                } else {
                    low = mid+1;
                }
            }
            for (int j = i; j > low; j--) {
                a[j] = a[j-1];
            }
            a[low] = key;
        }
        print(a, length, i);
    }
}

#pragma mark-

void shellSort(int a[], int length) {
    printf("\nShellSort");
    print(a, length, 0);
    for (int i = length/2; i > 0; i=i/2) {
        for (int j = i; j < length; j++) {
            int key = j;
            while (key-i>=0 && a[key] < a[key-i]) {
                swap(&a[key], &a[key-i]);
                key-=i;
            }
        }
        print(a, length, i);
    }
}


#pragma mark-
void twoPathInsertSort(int a[], int length){
    printf("\ntwoPathInsertSort");
    print(a, length, 0);
    int b[length];
    int first = 0, final = 0;
    b[0] = a[0];
    for (int i = 1; i < length; i++) {
        if (a[i] < b[first]) {//小于最小值
            first = (first - 1 + length) % length;
            b[first] = a[i];
        } else if (a[i] > b[final]) {//大于最大值
            final = (final + 1 + length) % length;
            b[final] = a[i];
        } else {
            int key = first;
            while (b[key] < a[i]) {
                b[(key-1+length)%length] = b[key];
                key = (key+1+length)%length;
            }
            b[(key-1+length)%length] = a[i];
            first = (first-1+length)%length;//更新头指针
        }
        print(b, length, 0);
    }
    for (int i = 0; i < length; i++) {
        a[i] = b[(first + i) % length];
    }
    print(a, length, 1);
}

#pragma mark-
void simpleSelect(int a[], int length){
    printf("\nsimpleSelect");
    for (int i = 0; i < length; i++) {
        int min = i;
        for (int j = i+1; j < length; j++) {
            if (a[min] > a[j]) {
                min = j;
            }
        }
        if (min != i) {
            swap(&a[i], &a[min]);
        }
        print(a, length, i);
    }
}

#pragma mark-
void heapAdjust(int a[], int length, int i) {//大顶堆
    int temp = a[i];
    for (int j=i*2+1; j<length; j=j*2+1) {
        if (j+1<length && a[j+1]>a[j]) {
            j++;
        }
        if (a[j] > temp) {
            a[i] = a[j];
            i=j;
        } else {
            break;
        }
    }
    a[i] = temp;
}

void heapSort(int a[], int length) {
    printf("\nheapSort");
    print(a, length, 0);
    for (int i = length/2-1; i>=0; i--) {
        heapAdjust(a, length, i);
        print(a, length, i);
    }
    
    for (int i = length-1; i > 0; i--) {
        swap(&a[0], &a[i]);
        heapAdjust(a, i, 0);
        print(a, length, i);
    }
    print(a, length, 0);
}

#pragma mark-
void bubblingSort(int a[], int length) {
    printf("\nbubblingSort");
    int key = 0;
    for (int i = 0; i < length; i++) {
        key = 0;
        for (int j = 0; j < length-i-1; j++) {
            if (a[j] > a[j+1]) {
                key = 1;
                int temp = a[j];
                a[j] = a[j+1];
                a[j+1] = temp;
            }
        }
        print(a, length, i);
        if (key == 0) {
            break;
        }
    }
}

#pragma mark- 快排
int partition(int a[], int low, int high, int length) {
    print(a, length, 0);
    int key = a[low];
    while (low < high) {
        //high左移找到小于key的交换
        while (high > low) {
            if (a[high] < key) {
                swap(&a[high], &a[low]);
                break;
            } else {
                high--;
            }
        }
        //low右移找到比key大的交换
        while (low < high) {
            if (a[low] > key) {
                swap(&a[high], &a[low]);
                break;
            } else {
                low++;
            }
        }
    }
    return low;
}

void qSort(int a[], int low, int high, int length){
    if (low < high) {
        int key = partition(a, low, high, length);
        qSort(a, low, key-1, length);
        qSort(a, key+1, high, length);
    }
}

void quickSort(int a[], int length) {
    printf("\nbubblingSort");
    qSort(a, 0, length-1, length);
    print(a, length, 0);
}

#pragma mark-
void merge(int a[], int temp[], int low, int middle, int high) {
    int i = low, j = middle+1, k = 0;
    while (i <= middle && j <= high) {
        if (a[i] < a[j]) {
            temp[k++] = a[i++];
        } else {
            temp[k++] = a[j++];
        }
    }
    while (i <= middle) {
        temp[k++] = a[i++];
    }
    while (j <= high) {
        temp[k++] = a[j++];
    }
    k = 0;
    while (low <= high) {
        a[low++] = temp[k++];
    }
}

void mSort(int a[], int temp[],int low, int high){
    if (low < high) {
        int mid = (low+high)/2;
        mSort(a, temp, low, mid);
        mSort(a, temp, mid+1, high);
        merge(a, temp, low, mid, high);
    }
}

void mergeSort(int a[], int length) {
    printf("\nmergeSort");
    print(a, length, 0);
    int temp[length];
    mSort(a,temp,0,length);
    print(a, length, 1);
}

#pragma mark-

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int a[10];
        randomArray(a, 10);
        simpleInsertSort(a, 10);
        randomArray(a, 10);
        bubblingSort(a, 10);
        randomArray(a, 10);
        quickSort(a, 10);
        randomArray(a, 10);
        binaryInsertongSort(a, 10);
        randomArray(a, 10);
        twoPathInsertSort(a, 10);
        randomArray(a, 10);
        shellSort(a, 10);
        randomArray(a, 10);
        simpleSelect(a, 10);
        randomArray(a, 10);
        heapSort(a, 10);
        randomArray(a, 10);
        mergeSort(a, 10);
    }
    return 0;
}
