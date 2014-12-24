function [X,Y,U] = convection(n,zeta)
%CONVECTION - Compute the solution of the natural convection problem
%             undermentioned, which is an elliptic PDE with boundary
%             condition that sets the solution to zero at the border
%             of the domain.
%
%   You can get the problem statement <a
%   href="http://perso.uclouvain.be/vincent.legat/teaching/bac-q3/data/probleme-problem1415-8.pdf">here</a>.
%   We used the finite difference method. Note that k, the thermal
%   conductivity coefficient, can be changed in our code. We assigned it
%   to 1 to have the right solution, but we could set it as an argument to
%   observe its effect !
%
%   [X,Y,U] = CONVECTION(n,zeta)
%   - n is the length of one side of the uniform mesh set to solve the PDE,
%       the precision of the solution increases as n increases ;
%   - zeta is the product of rho and c, which are respectively the density
%          and the specific heat, convection increases as zeta increases ;
%   - X is the vector of abscissa of length n ;
%   - Y is the vector of ordinates of length n ;
%   - U is the solution vector, of length n too.
%   With the vectors X, Y and U, it's easy to graph the solution if
%   you want to !

% Methode Num FSAB 1104
% Probleme MATLAB 8 : Probleme de convection naturelle
% Etudiants : Une collaboration de :
%                       - Antoine Legat 4776-1300
%                       - John de Wasseige 5224-1300
% Tuteur : Victor Colognesi


% For robustness :
% n
assert(~isinteger(n), 'n must be an integer') ;
assert(n > 1, 'n must be > 1');
if n < 5
    fprintf('You chose n=%d, it is not enough, choose at least n=5\n', n) ;
end
% zeta
if zeta < 0
    fprintf('\nYou chose zeta=%d, it is negative and that makes no\n',zeta);
    fprintf('physical sense because zeta = density * heat capacity\n') ;
    fprintf('and none of both can be negative.\n') ;
end


% The thermal conductivity coefficient :
k = 1 ; % it can be changed !

h =  2.0/(n-1);
X = -1.0:h:1.0;
Y = -1.0:h:1.0;

A = sparse(n^2,n^2);
map = zeros((n-2)^2,1);

B = zeros((n-2)^2,1);

% Using finite difference method, we obtained the following formula :
% (zeta*v1*h - 2k)*U_(i+1,j) + (- zeta*v1*h - 2k)*U_(i-1,j)
% + (zeta*v2*h - 2k)*U_(i,j+1) + (- zeta*v2*h - 2k)*U_(i,j-1)
% + 8*k*U_(i,j)
% = 2 * h^2 * f

l = 1 ; % For the calculation of B in the 'for' loops
for i = 2:n-1
    for j = 2:n-1
        index = (i-1)*n + j;
        map((i-2)*(n-2)+j-1) = index;
        % Abscissa of the point :
        x = 2*(i-1)/(n-1) - 1 ;
        % Ordinate of the point :
        y = 2*(j-1)/(n-1) - 1 ;
        % Velocity at the considered point :
        [v1,v2] = velocity(x,y) ;
        % Filling of A :
        A(index,index)   = 8*k ;
        A(index,index+1) = zeta*v2*h - 2*k ;
        A(index,index-1) = - zeta*v2*h - 2*k ;
        A(index,index+n) = zeta*v1*h - 2*k ;
        A(index,index-n) = - zeta*v1*h - 2*k ;
        % Source vector :
        B(l,1) = 2 * h^2 * source(x,y) ;
        l = l + 1 ;
    end
end

U = zeros(n,n);
U(2:n-1,2:n-1) = reshape(A(map,map)\B,n-2,n-2);

end


function f = source(x,y)
%SOURCE - Gives the value of the source term at the point (x,y).

assert(abs(x) <= 1 && abs(y) <= 1, ...
    'The point argument of f in not in domain Omega');

if x >= 0.5
    f = 10 ;
else
    f = 0 ;
end

end
