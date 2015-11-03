function [lambda]=optLambda(sampleImg,sampleVector,randlist,pointsNum,M,proBlockSizeP,proBlockSizeQ)
%  input numsample
%        randlist
%        DCTmatrixA
%        sampleImg
%  output 
%         


%sampleImg,sampleVector,sampleVector_nz,randlist,sparselist
%randlist

[P,Q] = size(sampleImg);

testNum = floor(pointsNum/6);
lambdaEnd = pointsNum-testNum;
lambdaErr = zeros(1,lambdaEnd);
for i = 1:1:20
    optlist = randperm(size(randlist,2));
    testlist= sort(randlist(optlist(1:testNum)));
    trainlist = sort(randlist(optlist(testNum+1:size(randlist,2))));

    sampleVectorsub = zeros(P*Q,1);
    sampleVectorsub(trainlist) = sampleVector(trainlist);    %vector of sample img
    sparselist = (sampleVectorsub == 0);
    [T,A,B]=defineMatrix(sampleImg,sampleVectorsub,sparselist);
        
    
    for l = 1:1:lambdaEnd
        [subalpha] = OMP(A,B,l);  %claculate alpha
        C = T*subalpha;
        recover = medfilt2(reshape(C,proBlockSizeQ,proBlockSizeP)',[3,3]);
        C_r = reshape(recover',proBlockSizeP*proBlockSizeQ,1);
        lambdaErr(1,l) = lambdaErr(1,l)+sum(abs(C_r(testlist)-sampleVector(testlist)));
        
    end
end
[minLErr,indexL] = min(lambdaErr);
lambda = indexL;
