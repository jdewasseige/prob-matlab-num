

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

longx = Lr + 2*L*sin(u(1)/2)*cos(u(1)/2) ;
longy = 2*L*sin(u(1)/2)*sin(u(1)/2) ;
long = sqrt(longx^2 + longy^2) ;

deltaX = long - Lr ;
Fressort = -k*deltaX ;

Mressort= Fressort*L ;

Mpoids = -L*sin(u(1))*m*g ;

dudx(1) = u(2);
dudx(2) = cte*(Mressort + Mpoids - C*u(2));

end







