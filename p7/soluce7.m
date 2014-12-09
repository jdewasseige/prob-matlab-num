% -------------------------------------------------------------------------
%
% MATLAB for DUMMIES 13-14
% Exercice 7
%
% Solution detaillee
%  Vincent Legat, Leopold Cambier, Victor Colognesi, Corentin Damman,
%  Francois Heremans, Benoit Legat, Gauthier Limpens, Lucas Nyssens,
%  Ignace Ransquin, Gaetan Ransonnet, Alexandre Sanchez Falcon, 
%  Adrien Scheuer, Harold Taeter, Joachim Van Verdeghem, Paul-Emile Bernard
%
% -------------------------------------------------------------------------
%
function soluce7()

[x,y]=meshgrid([-8:0.5:8],[-8:0.5:8]);
[alpha] = GearStability(x,y,6);
figure; contourf(x,y,-alpha,[-1:0.1:0]); grid;
axis off;

end

function [alpha] = GearStability(x,y,n)
% GEARSTABILITY Stability of Gear's method for order n= 1,2 ... 6
%
%       [alpha] = GearStability(x,y,n) returns the amplification 
%       factor of Gear's method applied 
%
%                          du(x)/dx = lambda*u(x)
%
%       at the points h*lambda = x+i*y.
%       Therefore, a stability plot can be easily plotted !
%


coeffs{1} = [ 1    1    0                    ]/1;    
coeffs{2} = [ 2   -4    1                    ]/3;
coeffs{3} = [ 6  -18    9   -2               ]/11;
coeffs{4} = [12  -48   36  -16    3          ]/25;
coeffs{5} = [60 -300  300 -200   75  -12     ]/137;
coeffs{6} = [60 -360  450 -400  225  -72  10 ]/147;
coef = coeffs{n};

%
%  Source pour les coefficients : 
%  http://en.wikipedia.org/wiki/Backward_differentiation_formula
%
%  C'est bien juste : les calculs savants de quelques tuteurs
%  donnent les memes valeurs :-)
%  Moralite : ne recalcule pas ce qui a deja ete fait :-)
%  Si vraiment vos calculs sont tres jolis, un petit bonus est attribue
%
%  Oui : ce probleme Matlab etait le meme en 2012-13 !
%  Faut bien encourager un peu nos amis les bisseurs... qui ont
%  garde leur programme de l'annee passe, non ?
%
%  Si tu recopies betement la solution de l'annee passee et que tu
%  ne cites pas tes sources, tu obtiens zero en raison du test anti-plagiat
%  Moralite : toujours citer la source originale.
%

z = x+i*y;
alpha = z;   % pre-allocation de alpha :-)
for k=1:size(z,1)
    for l =1:size(z,2)
        alpha(k,l) = max(abs(roots([(1 - coef(1)*z(k,l)) coef(2:end)])));
    end
end
 
end