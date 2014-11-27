function [X,U] = beam()

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
dudx = u;

m = 10 ;
k = 140;
L = 1  ;
C = 10 ;
g = 9.81 ;
Lr = 11*L/10 ;

inertia = (m*(2*L)^2)/3 ;

r = [L*sin(u(1)) L*cos(u(1)) 0] ;
F_p = [0 m*g 0] ;
Mpoids  = cross(r,F_p) ;

Mressort = calcMressort_s(k,u(1),Lr) ;

dudx(1) = u(2);
dudx(2) = (Mressort + Mpoids(3) - C*u(2))/inertia ;

end


function Mressort = calcMressort_s(k,theta,Lr)
% synthetic way

L = 1 ;

%longueur du ressort en fonction de theta
long = sqrt((-L-sin(theta)*L)^2 +(L-L*cos(theta))^2) ;

% théorème d'Al-Kashi
cosN = ((sqrt(2)*L)^2 - L^2 - long^2)/(-2*L*long) ;

deltaX = long-Lr ;
Fressort = -k*deltaX ;
Mressort = L*Fressort*sqrt(1-cosN^2) ;

end


function Mressort = calcMressort_a(k,theta,Lr) 
% using coordinate system way 

L = 1 ;

corde = 2*L*sin(theta/2) ;

longx = L + corde*cos(theta/2) ;
longy = abs(corde*sin(theta/2)) ;
%long = sqrt(longx^2 + longy^2) ;
long = sqrt((-L-sin(theta)*L)^2 +(L-L*cos(theta))^2) ;


deltaX = long - Lr ;
Fressort = -k*deltaX ;

r = [L*sin(theta) L*cos(theta) 0] ;

F_r = [longx*(-L-L*sin(theta)) -longy*(L-L*cos(theta)) 0].*Fressort/long ;

Mressort_v = cross(r,F_r) ;
Mressort = Mressort_v(3) ;

end
