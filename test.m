clear all;close all;clc
%this is for test
pointsNum = 1000;
%devide the img
IniImg = imread('fishing_boat.bmp');
IniImg = double(IniImg);
[P,Q] = size(IniImg);
imgBlock = 4;
blockSizeP = round(P/imgBlock);
blockSizeQ = round(Q/imgBlock);
processBlock = IniImg(1:blockSizeP,1:blockSizeQ);   
[sampleImg,sampleVector] = pickupPoint(processBlock,pointsNum);    %pointvector c
DCTMatrix = DCT(sampleImg);      %T
DCTMatrixA = DCTMatrix;
sparselist = (sampleVector == 0);
sampleVector(sparselist)=[];    %B
DCTMatrixA(sparselist,:)=[];   %A
%alpha = OMP(DCTMatrixA,sampleVector);  %claculate alpha
alpha = DCTMatrixA\sampleVector;
C = DCTMatrix*alpha;
imgShow(reshape(C,blockSizeP,blockSizeQ));
figure,imgShow(processBlock)
figure,imgShow(sampleImg)