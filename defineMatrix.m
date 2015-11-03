function [T,A,B]=defineMatrix(sampleImg,sampleVector,sparselist)

DCTMatrix = DCT(sampleImg);      %T
T = DCTMatrix;
DCTMatrixA = DCTMatrix;
sampleVector_nz = sampleVector;
sampleVector_nz(sparselist)=[];    %B

B = sampleVector_nz;    %B
DCTMatrixA(sparselist,:)=[];   %A
A = DCTMatrixA;