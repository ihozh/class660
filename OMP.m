function [newAlpha,setS,F,Anew] = OMP(A,B,lanbda)
% clear all;close all;clc;
% A=rand(10,10)
% B=rand(10,1)
[P,Q]=size(A);

alpha = [];
Anew = [];
setS = [];

F = B;

s_index = 1:1:P*Q;
for i = 1:Q
    norm_A(:,i) = A(:,i)/norm(A(:,i));
end
for p=1:1:lanbda
    simValue=[];
    for i = 1:Q
        simValue(i) = dot(norm_A(:,i),F);
    end
    [maxv,indexS] = max(abs(simValue));
    s = s_index(indexS);
    setS = [setS,s];
    Anew = A(:,setS);
    alpha = Anew\B;
    F = B-Anew*alpha;
    norm_A(:,indexS)=[];
    s_index(indexS)=[];
    [P,Q] = size(norm_A);
end
[P,Q]=size(A);
newAlpha = zeros(Q,1);
newAlpha(setS)=alpha;
%C = A*newAlpha;
