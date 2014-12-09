function [alpha] = GearStability(x,y,n)
%GEARSTABILITY - Compute the module of the amplification factor for 
%                each point in the complex plane 'h lambda'.
%
%   You can get the problem statement <a
%   href="http://perso.uclouvain.be/vincent.legat/teaching/bac-q3/data/probleme-problem1415-7.pdf">here</a>.
%
%   [alpha] = GEARSTABILITY(x,y,n)
%   - x and y contains the coordinates of the points in the complex plane ;
%   - n is the order on the Gear method (0 < n < 7) ;
%   - alpha is the module of the amplification factor 
%           and it has the same length as x and y.


% Methode Num FSAB 1104
% Probleme MATLAB 7 : Zone de stabilite des methodes de Gear
% Etudiants : Une collaboration de :
%                       - Antoine Legat 4776-1300
%                       - John de Wasseige 5224-1300
% Tuteur : Victor Colognesi

assert(length(x)==length(y),'Les matrices x et y n''ont pas les memes dimensions !');
n = abs(n);


    

end