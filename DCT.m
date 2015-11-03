function [DCTcoef] = DCT(img)
%this function is used to generate coefficient matrix of DCT transfermation;
%input:
%     P            %find the DCT matrix of img;
%
%output:
%     DCTcoef      %the coefficient matrix of img;
%
%10/20/2015  yihez@andrew.cmu.edu



                

[P,Q]=size(img);
T=[];
for i = 1:P*Q
    for j = 1:P*Q
        inix = ceil(i/Q);
        iniy = mod(i,Q);
        DCTx = ceil(j/Q);
        DCTy = mod(j,Q);
        if DCTx == 1
            a = sqrt(1/P);
        else 
            a = sqrt(2/P);
        end
        if DCTy == 1
            b = sqrt(1/Q);
        else
            b = sqrt(2/Q);
        end
        
        T(i,j) = a*b*cos(pi*(2*inix-1)*(DCTx-1)/(2*P))*cos(pi*(2*iniy-1)*(DCTy-1)/(2*Q));
        
    end
end
DCTcoef = T;