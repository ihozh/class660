clear all;close all;clc;
%this file test DCT matrix, using dct2 find alpha vector,the
%consquence shows the DCT matrix is right.
%test DCT
pointsNum = 500;
%devide the img
IniImg = imread('fishing_boat.bmp');
IniImg = double(IniImg);
[P,Q] = size(IniImg);
imgBlock = 8;
blockSizeP = round(P/imgBlock);
blockSizeQ = round(Q/imgBlock);
processBlock = IniImg(1:blockSizeP,1:blockSizeQ);
DCTMatrix = DCT(processBlock);         %T
testalpha = reshape(dct2(processBlock)',blockSizeP*blockSizeQ,1);    %alpha       
C = DCTMatrix*testalpha;             
recover = reshape(C,blockSizeQ,blockSizeP)';
recoverImg = medfilt2(recover,[3,3]);
figure,imgShow(processBlock);
figure,imgShow(recover);
figure,imgShow(recoverImg);

