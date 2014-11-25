

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

cte = 3/(m*(2*L)^2) ;

corde = 2*L*sin(u(1)/2) ;

longx = L + corde*cos(u(1)/2) ;
longy = corde*sin(u(1)/2) ;
long = sqrt(longx^2 + longy^2) ;

deltaX = long - Lr ;
Fressort = -k*deltaX ;

r = [L*sin(u(1)) L*cos(u(1)) 0] ;

F_r = [longx -longy 0].*Fressort/long ;
F_p = [0 -m*g 0] ;

Mressort= cross(r,F_r) ;

Mpoids  = cross(r,F_p) ;

dudx(1) = u(2);
dudx(2) = cte*(Mressort(3) + Mpoids(3) - C*u(2));

end







