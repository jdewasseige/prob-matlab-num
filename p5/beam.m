function [X,U] = beam()
%BEAM - Compute the approximated solution of the Cauchy's
%       problem given, using Runge-Kutta's method 4th order.
%
%   You can get the problem statement <a
%   href="http://perso.uclouvain.be/vincent.legat/teaching/bac-q3/data/probleme-problem1415-5.pdf">here</a>.
%   We computed the result of the same problem using the
%   MATLAB function ode45 and had the same plot, which
%   proves us that it works well.
%
%   [X,U] = BEAM()
%   X and U are vectors of the same length that represent
%   a set of points, these are the approximated solution.

% Methode Num FSAB 1104
% Probleme MATLAB 5 : Un peu de mecanique...
% Etudiants : Une collaboration de :
%                       - Antoine Legat 4776-1300
%                       - John de Wasseige 5224-1300
% Tuteur : Victor Colognesi

Xstart = 0;
Xend   = 15;
Ustart = [0 0];

n = 1000;
h = (Xend-Xstart)/n;
X = linspace(Xstart,Xend,n+1);
U = [Ustart ; zeros(n,2)];

for i=1:n
	K1 = f(X(i),     U(i,:)        );
	K2 = f(X(i)+h/2, U(i,:)+h*K1/2 );
	K3 = f(X(i)+h/2, U(i,:)+h*K2/2 );
	K4 = f(X(i)+h,   U(i,:)+h*K3   );
    U(i+1,:) = U(i,:) + h*(K1+2*K2+2*K3+K4)/6;    
end

end



function dudx = f(x,u)
dudx = u; % To make sure the dimensions are OK
m = 10;
k = 140;
L = 1;
C = 10;
I = (m*(2*L)^2) / 3;

dudx(1) = u(2); 
dudx(2) = ( Mressort_synthetic(k,L,u(1)) + m*9.81*L*sin(u(1)) ...
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

