function [ Mressort ] = Mressort_synthetic(k,L,theta)
%Mressort_synthetic - Compute the torque of the force of
%                     the spring, using analytic calculation.
%
%   This gives the same result as Mressort_analytic, which is
%   great because the calculation is very different. That confirms
%   our solution.
%
%   [ Mressort ] = Mressort_synthetic(k,L,theta)

x = L*sqrt( 3-2*sqrt(2)*cos(pi/4 + theta) ) ;
thesinB = sqrt(2)*L*sin(pi/4 + theta ) / x ;
y = (x - 11*L/10 ) * thesinB ;
Mressort = -k*y*L ;

end