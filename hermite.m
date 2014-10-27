function [uh] = hermite(n,X,U,dU,x)
% Fonction qui renvoit les ordonnees des polynomes 
% d'interpolation cubique pour les abscisses x.
%
% input     - n : le degre du polynome d'interpolation
%           - X : abscisses des n+1 points
%           - U : ordonnees des n+1 points
%           - dU: valeurs des derivees premiere pour les n+1 points
%           - x : domaine des polynomes d'interpolation
% output    - uh: ordonnees des polynomes d'interpolation


% On va resoudre le systeme de 4 equations (4 donnees)
% a 4 inconnues (les coefficients des polynomes)
%
% a X0^3  + b X0^2 + c X0 + d = U0
% a X1^3  + b X1^2 + c X1 + d = U1
% a 3X0^2 + b 2X0  + c    + 0 = U'0
% a 3X1^2 + b 2X1  + c    + 0 = U'1
%
% pour chaque intervalle, afin de determiner
% a, b, c et d pour chaque polynome de degre 3.

polynomes = zeros(4, n);

m = length(x) ;
uh = zeros(1,m) ;
mem = 1;

for i =1:n
    A = [X(i)^3      X(i)^2    X(i)   1 ;
         X(i+1)^3    X(i+1)^2  X(i+1) 1 ;
         3*X(i)^2    2*X(i)    1      0 ;
         3*X(i+1)^2  2*X(i+1)  1      0 ] ;

     b = [U(i);U(i+1);dU(i);dU(i+1)] ;
     
     polynomes(:,i) = A\b ;
     
     
     % Ensuite, on va assigner une valeur a uh pour chaque
     % abscisse x qui se trouve dans [Xi;Xi+1],
     % tout en gardant en memoire (mem) l'abscisse 
     % de debut afin de ne pas devoir parcourir x 
     % completement pour chaque polynome.
     
     while x(mem) < X(i+1)
         uh(mem) = polyval(polynomes(:,i),x(mem)) ;
         mem = mem + 1 ;
     end
     
end

end

