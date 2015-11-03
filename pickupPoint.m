function [sampleImg,sampleVector,randlist,sparselist] = pickupPoint(img,pointsNum)
%this function is used to pick up random point in the img;
%input:
%     img            %the random points are chosen from img;
%     pointsNum      %pointsNum is the numeber of points chosen from the
%                     img
%output:
%     sampleImg      %sampled image
%           
%
%10/20/2015  yihez@andrew.cmu.edu

[P,Q] = size(img);
randlist = sort(randperm(P*Q,pointsNum));    %generate randlist
imgVector = reshape(img',P*Q,1);       %vector of img
sampleVector = zeros(P*Q,1);
sampleVector(randlist) = imgVector(randlist);    %vector of sample img
sampleImg = reshape(sampleVector,Q,P)';   %img of sample img

sparselist = (sampleVector == 0);


