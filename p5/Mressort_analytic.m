function [ Mressort ] = Mressort_analytic(k,L,theta)
%Mressort_analytic - Compute the torque of the force of
%                    the spring, using analytic calculation.
%
%   This gives the same result as Mressort_synthetic, which is
%   great because the calculation is very different. That confirms
%   our solution.
%
%   [ Mressort ] = Mressort_analytic(k,L,theta)

r = [ L*sin(theta) L*cos(theta) 0 ] ;

x = L*(1 - 11/(10* sqrt(3+2*sin(theta)-2*cos(theta)) )) ...
    * [-1-sin(theta) 1-cos(theta) 0 ] ;

VectMressort = -k * cross(r,x) ;
Mressort = VectMressort(1,3) ;

end