#include <SpSolver.h>
#include <cusparse_v2.h>
#include <cusolverSp.h>
#include <mkl.h>

//TODO: cuda error handling
int cuSolverSpSolver(SpMat &A, double* b, double* x) {
  cusolverSpHandle_t handle; cusolverSpCreate(&handle);
  
  cusparseMatDescr_t descrA; cusparseCreateMatDescr(&descrA);
  cusparseSetMatType     (descrA, CUSPARSE_MATRIX_TYPE_GENERAL);
  cusparseSetMatIndexBase(descrA, CUSPARSE_INDEX_BASE_ZERO);  

  int reorder=0;
  double tol=0;
  int singularity=0;

  cusolverStatus_t t = cusolverSpDcsrlsvluHost(handle,A.n,A.nnz,descrA,A.csrVal.data(),A.csrRowPtr.data(),A.csrColInd.data(),b,tol,reorder,x,&singularity);
  printf("singularity: %d\n", singularity);

  return t;
}


//Todo MKL Error handling
int mklPardiso(SpMat &A, double* b, double* x) {
  //pardiso(_MKL_DSS_HANDLE_t pt, const MKL_INT *maxfct, const MKL_INT *mnum, const MKL_INT *mtype, const MKL_INT *phase, const MKL_INT *n, const void *a, const MKL_INT *ia, const MKL_INT *ja, MKL_INT *perm, const MKL_INT *nrhs, MKL_INT *iparm, const MKL_INT *msglvl, void *b, void *x, MKL_INT *error);
  void *pt[64];
  MKL_INT maxfct=1, mnum=1, mtype=11, n = A.n, perm=1, nrhs=1, msglvl=0, error=0;
  MKL_INT iparm[64];
  for(int i=0; i<64; i++) pt[i]=0, iparm[i]=0;
  pardisoinit(pt, &mtype, iparm);
  iparm[34]=1;

  std::vector<MKL_INT> RowPtr(A.csrRowPtr.size());
  std::vector<MKL_INT> ColInd(A.csrColInd.size());
  for(int i=0; i<RowPtr.size(); i++) RowPtr[i] = A.csrRowPtr[i]; //Todo int vector->long long vector casting?
  for(int i=0; i<ColInd.size(); i++) ColInd[i] = A.csrColInd[i];
  
  MKL_INT phase=13;
  pardiso(pt, &maxfct, &mnum, &mtype, &phase, &n, A.csrVal.data(), RowPtr.data(), ColInd.data(), &perm, &nrhs, iparm, &msglvl, b, x, &error);
  return (int)error;
}