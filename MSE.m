function [mseErr]=MSE(picture_ini,picture_rec)
[P,Q]=size(picture_ini);
mseErr = 1/(P*Q)*sum(sum((picture_ini-picture_rec).^2));