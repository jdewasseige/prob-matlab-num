% Methode Num FSAB 1104
% Probleme MATLAB 3 : Interpolations d'Hermite
% Etudiants : Une collaboration de :
%                       - Antoine Legat 4776-1300
%                       - John de Wasseige 5224-1300
% Tuteur : Victor Colognesi
function [uh] = hermite(n,X,U,dU,x)
% Fonction qui renvoie les ordonnees des polynomes 
% d'interpolation cubique pour les abscisses x.
%
% input     - n : le nombre de polynomes d'interpolation
%           - X : abscisses des n+1 points
%           - U : ordonnees des n+1 points
%           - dU: valeurs des derivees premiere pour les n+1 points
%           - x : domaine des polynomes d'interpolation
% output    - uh: ordonnees des polynomes d'interpolation


% On va resoudre le systeme de 4 equations (4 donnees)
% a 4 inconnues (les coefficients des polynomes cubiques)
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
count = 1 ;

for i = 1:n
    A = [X(i)^3      X(i)^2    X(i)   1 ;
         X(i+1)^3    X(i+1)^2  X(i+1) 1 ;
         3*X(i)^2    2*X(i)    1      0 ;
         3*X(i+1)^2  2*X(i+1)  1      0 ] ;

     b = [U(i) ; U(i+1) ; dU(i) ; dU(i+1)] ;
     
     polynomes(:,i) = A\b ;
     % "On resout un systeme lineaire, on ne l'inverse jamais..."
     % (J. Meinguet)
     
     % Ensuite, on va assigner une valeur a uh pour chaque
     % abscisse x qui se trouve dans [X(i);X(i+1)],
     % tout en gardant en memoire (count) l'abscisse 
     % de debut afin de ne pas devoir parcourir x 
     % completement pour chaque polynome.
     
     % NB : Grace a la condition du while, on peut gerer les cas
     %      ou on desire extrapoler a gauche et/ou a droite de
     %      l'intervalle [X0;Xn], c'est-a-dire que certains
     %      elements de x sont en dehors de cet intervalle.
     % (meme si dans les cas de la fct de test_matlab3, si on prend
     % des x allant de -0.1 a 1.1 par exemple, les valeurs
     % extrapolees sont loin des valeurs correctes (ce qui, en
     % soit, semble logique))
     while count <= m && (x(count) < X(i+1) || x(count) > X(n))
         uh(count) = polyval(polynomes(:,i),x(count)) ;
         count = count + 1 ;
     end
     
end

end
