clear all;close all;clc;
%test DCT
pointsNum = 50;
%devide the img
IniImg = imread('fishing_boat.bmp');
IniImg = double(IniImg);
[P,Q] = size(IniImg);
blockSize = 8;
blockNumP = round(P/blockSize);
blockNumQ = round(Q/blockSize);
processBlock = IniImg(1:8,1:8);   
[sampleImg,sampleVector,randlist] = pickupPoint(processBlock,pointsNum);    %pointvector c

DCTMatrix = DCT(sampleImg);      %T
DCTMatrixA = DCTMatrix;
sparselist = (sampleVector == 0);
sampleVector(sparselist)=[];    %B
DCTMatrixA(sparselist,:)=[];   %A

[alpha,setS,F,Anew] = OMP(DCTMatrixA,sampleVector');  %claculate alpha
%alpha = DCTMatrixA\sampleVector';
C = DCTMatrix*alpha;
recover = reshape(C,8,8)';
recoverImg = medfilt2(recover,[3,3]);

figure,imgShow(processBlock)
figure,imgShow(sampleImg)
figure,imgShow(recoverImg);