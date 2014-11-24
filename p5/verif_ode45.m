function [X,U] = verif_ode45()
% Verif des resultats avec ode45

Xstart = 0;
Xend   = 15;
Ustart = [0 0];

[X,U] = ode45(@f,[Xstart Xend],Ustart) ;

end


function dudx = f(x,u)
dudx = u; % To make sure the dimensions are OK
m = 10;
k = 140;
L = 1;
C = 10;
I = (m*(2*L)^2) / 3;

% TO DO : verifier signes Mressort et 9.81
dudx(1) = u(2); 
dudx(2) = ( Mressort_analytic(k,L,u(1)) + m*9.81*L*sin(u(1)) ...
            - C*u(2) ) / I;
end



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

