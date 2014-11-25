function [ Mressort ] = test()
%test l'expression renvoyée par Mressort_synthetic
k = 140 ;
L = 1 ;
theta = pi/4 ;

(2^(1/2)*L*k*sin(pi/4 + theta)*((11*L)/10 - L*(3 - ...
    2*2^(1/2)*cos(pi/4 + theta))^(1/2)))/(3 - 2* ...
    2^(1/2)*cos(pi/4 + theta))^(1/2)


end

