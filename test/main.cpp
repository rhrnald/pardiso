#include <iostream>
#include "SpSolver.h"
using namespace std;
#include <ctime>


int main(){
    SpMat A("/home/n5/chaewon/sparse/solvertest1.mat");

    double* b = (double*)malloc(sizeof(double)*A.n); b[0]=1, b[1]=4;
    double *x = (double*)malloc(sizeof(double)*A.n);

    //printf("Cu Error: %d\n", cuSolverSpSolver(A, b, x));
    //printf("Cu Result: "); for(int i=0; i<min(A.n, 10); i++) printf("%lf ", x[i]); printf("\n");

    
    clock_t start, finish;
    double duration;
 
    start = clock();
    printf("MKL Error: %d\n", mklPardiso(A, b, x));
    finish = clock();
 
    duration = (double)(finish - start) / CLOCKS_PER_SEC;
    cout << duration << "sec" << endl;

    printf("MKL Result: "); for(int i=0; i<min(A.n, 10); i++) printf("%.3lf ", x[i]); printf("\n");
    //Todo Check Ax-b
}

