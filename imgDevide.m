clear all;close all;clc;
%warning off all;
pointsNum = 10;
M = 20;
%devide the img
IniImg = imread('fishing_boat.bmp');
IniImg = double(IniImg);

[P,Q] = size(IniImg);
recoverImg  = zeros(P,Q);
sampleImgFull = zeros(P,Q);
blockSize = 8;
blockNumP = round(P/blockSize);
blockNumQ = round(Q/blockSize);


for i = 1:blockNumP
    for j = 1:blockNumQ 
        if i == blockNumP
            proBlockSizeP = P-blockSize*(blockNumP-1);
        else
            proBlockSizeP = blockSize;    
        end

        if j == blockNumQ        
            proBlockSizeQ = Q-blockSize*(blockNumQ-1);
        else
            proBlockSizeQ = blockSize;    
        end

        processBlock = IniImg(blockSize*(i-1)+1:blockSize*(i-1)+proBlockSizeP,blockSize*(j-1)+1:blockSize*(j-1)+proBlockSizeQ);   %C
        
        [sampleImg,sampleVector,randlist,sparselist] = pickupPoint(processBlock,pointsNum);    %pointvector c
        
        %[lambda]=optLambda(sampleImg,sampleVector,randlist,pointsNum,M,proBlockSizeP,proBlockSizeQ);
        
        [T,A,B]=defineMatrix(sampleImg,sampleVector,sparselist);
        [alpha] = OMP(A,B,8);  %claculate alpha

        
        C = T*alpha;
        recover = reshape(C,proBlockSizeQ,proBlockSizeP)';

        sampleImgFull(blockSize*(i-1)+1:blockSize*(i-1)+proBlockSizeP,blockSize*(j-1)+1:blockSize*(j-1)+proBlockSizeQ)=sampleImg;
        recoverImg(blockSize*(i-1)+1:blockSize*(i-1)+proBlockSizeP,blockSize*(j-1)+1:blockSize*(j-1)+proBlockSizeQ)=recover;
        [i j] 
        
    end
    
      
end

mseErr1=MSE(IniImg,recoverImg);
recoverImg = medfilt2(recoverImg,[3,3]);
figure,imgShow(sampleImgFull);
figure,imgShow(recoverImg);
mseErr2=MSE(IniImg,recoverImg);