% Methode Num FSAB 1104
% Probleme MATLAB 4 : Calcul du volume du musee de LLN
% Etudiants : Une collaboration de :
%                       - Antoine Legat 4776-1300
%                       - John de Wasseige 5224-1300
% Tuteur : Victor Colognesi
function [Ih] = gaussIntegrate(L,z,error)
% gaussIntegrate - Numerically evaluate volume under the surface 'z', 
%                  over a centered square of length '2L' and giving 
%                  an error lower than 'error'.
%
% Ih = gaussIntegrate(L,Z,ERROR).... where Z is a two-variable function.
% 
% Class support for input L : integer.
%                   input error and output Ih : float single/double.

assert(isfloat(error), 'error is not a number') ;
assert(rem(L,1)==0, 'L is not an integer') ;
error = abs(error) ;

% First evaluation of the integral for a step of L.
I0 = calcLocalVolume(L,z,0,0);
Ih = getNextIh(L/2,0,0,z,error/4,I0) ;

% divide basis in n*n squares 
% n=1,2,4,8,16,32...
% we are going to split each square in 4 smaller squares because we
% need a geometric progression for the abscissa (length/2 thus 4* nb of
% squares)

end

function total = getNextIh(L,x,y,z,error,Ip)

% Each new square is going to have its center distant from (x,y) 
% of (+-L,+-L).
addX = [-1 -1  1 1] ; 
addY = [-1  1 -1 1] ;

total = 0 ;
Inext = 0 ;
for i=1:4
    % Compute volume of each smaller square.
    Inext = calcLocalVolume(L,z,addX(i)*L +x,addY(i)*L +y) ;
    
    % Get the next Richardson value, InextR will be a vector containing
    % the value I(i,:) which, in addition to I(i+1,0),
    % are needed to compute the next best value of I.
    %
    % For example after 3 calls of the 'getNextIh' function,
    % 1/[I(0,0)] 2/[I(1,0) I(1,1)] 3/[I(2,0) I(2,1) I(2,2)] ...
    InextR = getNextR(Inext,Ip);
    
    % Check if difference btw current best value and previous best value
    % is smaller than error.
    % If not, we continue with 4 smaller squares.
    
    if abs(InextR(end)-InextR(end-1)) > error
        out = getNextIh(L/2,addX(i)*L +x, addY(i)*L +y, z, error/4,...
            InextR./4) ;
        total = total + out ;
    else
        total = total + InextR(end) ;
    end
end

end


function out = getNextR(In,Ip)

out = zeros(1,length(Ip)+1) ;
out(1) = In ;

for i=1:length(Ip)
    out(i+1) = (4^(2*i+1)*out(i)- Ip(i))/(4^(2*i+1) - 1) ;
end

end

% Compute the volume under the function Z in a square of length 2L, 
% centered in (x,y).
function out = calcLocalVolume(L,z,x,y)

a = sqrt(1/3) ;
X = [-a a] ;
Xm = ones(2,1)*X ;
Ym = X'*ones(1,2);
Wm = ones(2,2) ;

funVal = z(L*Xm +x,L*Ym +y) ;

out = L*L*sum(sum(Wm.*funVal)) ;

end
