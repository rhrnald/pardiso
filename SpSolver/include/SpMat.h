//#include <cusparse_v2.h>
#include <vector>
#include <tuple>

class SpMat {
public:
    //cusparseMatDescr_t descrA;
    std::tuple<int,int> shape;
    int n,nnz;
    std::vector<double> csrVal;
    std::vector<int> csrRowPtr, csrColInd;

//public:
    SpMat();
    SpMat(char const* str);

    void ReadFromFile(char const* str);
    //print mat
};