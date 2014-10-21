function egg(top,bottom,dt,mode)
%Fonction qui retourne trois matrices de m�me dimensions
%afin de pouvoir repr�senter graphiquement (avec la fonction
%'surf') des oeufs et formes qui en d�rivent.
%
%input  - top, bottom : allongements relatifs de la partie
%                       sup�rieure et inf�rieure de l'oeuf
%       - dt          : incr�ment utilis� pour parcourir 
%                       l'espace param�trique de la
%                       repr�sentation graphique
%       - mode        : (optional) 0 pour l'oeuf,
%                       1 pour une figure originale

if ~mode 
    modeEgg(top, bottom, dt)
else
    makeThing(top, bottom, dt)
end
    
end

function modeEgg(top, bottom, dt)

figure;
[x y z] = makeEgg(top,bottom,dt);
surf(x,y,z); axis('off'); axis('equal');

end

function [x y z] = makeEgg(top, bottom, dt)
T = [0 0 0 1 1 2 2 3] ;
S = [0 0 0 1 1 2 2 3 3 4 4 5] ;
R = [0 1 1 1 0];
H = [-1*bottom -1*bottom 0 1*top 1*top];%allongements relatifs

% En posant les points Xc et Yc tels que ci-dessous,
% et en d�veloppant le probl�me pour u=(x(t),y(t)),
% il faut que x(t)^2+y(t)^2
% Pour t dans [0;1], on connait les b-splines de 
% degr� 2 B0, B1, B2
% Sans perte de g�n�ralit� on r�sout pour un quart de cercle.
% Il nous reste alors � trouver la relation que doivent
% satisfaire 3 poids associ�s aux trois points (1,0),(1,1) 
% et (0,1). On trouve que W1^2 = (W0*W2)/2
% Dans notre cas on pose W0=W2=1, donc W1=sqrt(1/2).

a= sqrt(1/2);
p = 2;
Xc = [-1 -1 0 1 1 1 0 -1 -1] ;
Yc = [0 -1 -1 -1 0 1 1 1 0] ;
Zc = ones(size(Xc));
Wc = [1 a 1 a 1 a 1 a 1];
X = Xc' * R;
Y = Yc' * R;
Z = Zc' * H;
W = Wc' * [1 a 1 a 1];


nt = length(T) - 1;
t = [T(p+1):dt:T(nt-p+1)];
for i=0:nt-p-1
  Bt(i+1,:) = b(t,T,i,p);
end

ns = length(S) - 1;
s = [S(p+1):dt:S(ns-p+1)];
for i=0:ns-p-1
  Bs(i+1,:) = b(s,S,i,p);
end

w = Bs' * W * Bt;
x = Bs' * (W .* X) * Bt ./ w;
y = Bs' * (W .* Y) * Bt ./ w;
z = Bs' * (W .* Z) * Bt ./ w;

end


function u = b(t,T,j,p)
i = j+1;
if p==0
    u = (t>= T(i) & t < T(i+p+1)); return 
end

u = zeros(size(t));
if T(i) ~= T(i+p)
    u = u + ((t-T(i)) / (T(i+p) -T(i))) .* b(t,T,j,p-1);
end
if T(i+1) ~= T(i+p+1)
    u = u + ((T(i+p+1)-t) ./ (T(i+p+1) -T(i+1))) .* b(t,T,j+1,p-1);
end
end