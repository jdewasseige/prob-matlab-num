function [theta] = adjustFire(y0,v0,epsilon,h,f,bonus)
%ADJUSTFIRE - Compute the optimal elevation angle in order to
%             maximize the distance traveled by a shell thrown
%             from a height y0 at a speed v0.
%
%   You can get the problem statement <a
%   href="http://perso.uclouvain.be/vincent.legat/teaching/bac-q3/data/probleme-problem1415-6.pdf">here</a>.
%   Supposing that the distance versus the elevation angle was unimodal, we
%   could use the "surrounding technique" described in the problem statement,
%   the Heun integration method and the bisection method to solve this
%   problem.
%
%   [theta] = ADJUSTFIRE(y0,v0,epsilon,h,f,bonus)
%   - epsilon is the required precision for theta ;
%   - h is the integration step for the Heun integration ;
%   - f is the function containing the equations describing the
%     trajectory of the shell ;
%   - bonus, if equal to 1, we use a faster algorithm.


% Methode Num FSAB 1104
% Probleme MATLAB 6 : Deduire portee maximale d un obusier !
% Etudiants : Une collaboration de :
%                       - Antoine Legat 4776-1300
%                       - John de Wasseige 5224-1300
% Tuteur : Victor Colognesi


% Merci pour tes chokotoffs je viens de m'en mettre un :D
% Robustesse :
y0 = abs(y0);
v0 = abs(v0);
epsilon = abs(epsilon);
h = abs(h);

if nargin < 6
    bonus = 0;
end

thetaMin = 0;
thetaMax = 90;

if bonus == 0
    while abs(thetaMax - thetaMin) > 2*epsilon
        
        b = thetaMin + (thetaMax - thetaMin)/3;
        c = thetaMin + 2*(thetaMax - thetaMin)/3;
        distB = HeunIntegrate(b,y0,v0,h,f);
        distC = HeunIntegrate(c,y0,v0,h,f);
        
        if distB > distC
            thetaMax = c;
            distMax = distB;
        else
            thetaMin = b;
            distMax = distC;
        end
        
        subplot(2,1,2);
        plot([thetaMin thetaMin],[0,300],'-r'); hold on;
        plot([thetaMax thetaMax],[0,300],'-r'); hold on;
        
        fprintf('==== New interval is [%f, %f]\n',thetaMin,thetaMax);
        fprintf('     Distance = %f : error = %f\n',distMax,thetaMax - thetaMin);
        % Vous pouvez "de-commenter" les deux lignes suivantes pour pouvoir
        % commander les iterations une par une (ca ralentit le programme).
        %input('      Press any key to do next iteration \n');
        %pause;
    end
    theta = (thetaMin + thetaMax) / 2;
    
else
    distA = HeunIntegrate(thetaMin,y0,v0,h,f);
    distE = 0;
    
    while abs(thetaMax - thetaMin) > 2*epsilon
        
        b = thetaMin + (thetaMax - thetaMin)/4;
        c = thetaMin + (thetaMax - thetaMin)/2;
        d = thetaMin + 3*(thetaMax - thetaMin)/4;
        distC = HeunIntegrate(c,y0,v0,h,f);
        
        dxB = (distA - distC)/abs(c - thetaMin);
        dxD = (distC - distE)/abs(thetaMax - c);
        
        if dxB*dxD < 0
            distA = HeunIntegrate(b,y0,v0,h,f);
            distE = HeunIntegrate(d,y0,v0,h,f);
            thetaMin = b;
            thetaMax = d;
            distMax = distC;
        elseif dxB >= 0
            distE = HeunIntegrate(b,y0,v0,h,f);
            thetaMax = b;
            distMax = distE;
        else
            distA = HeunIntegrate(d,y0,v0,h,f);
            thetaMin = d;
            distMax = distA;
        end
        
        subplot(2,1,2);
        plot([thetaMin thetaMin],[0,300],'-r'); hold on;
        plot([thetaMax thetaMax],[0,300],'-r'); hold on;
        
        fprintf('==== New interval is [%f, %f]\n',thetaMin,thetaMax);
        fprintf('     Distance = %f : error = %f\n',distMax,thetaMax - thetaMin);
        % Vous pouvez "de-commenter" les deux lignes suivantes pour pouvoir
        % commander les iterations une par une (ca ralentit le programme).
        %input('      Press any key to do next iteration \n');
        %pause;
    end
    theta = (thetaMin + thetaMax) / 2;
end

end


function [distance] = HeunIntegrate(theta,y0,v0,h,f)
%HEUNINTEGRATE - Integrate the EDO's using the Heun integration
%                method.
%
%   y0, v0 and theta specify the initial conditions. The temporal
%   integration stops when the height of the shell is (about) 0.
%
%   [distance] = HEUNINTEGRATE(theta,y0,v0,h,f)
%   - distance is the distance traveled by the shell ;
%   - theta is the elevation angle in DEGREES ;
%   - y0 is the initial height ;
%   - v0 is the initial speed ;
%   - h is the integration step for the Heun integration ;
%   - f is the function containing the equations describing the
%     trajectory of the shell.


epsilon = 0.0001; % precision requise pour hauteur nulle
global shot
U = zeros(4);
U(1) = v0*cosd(theta);
U(2) = 0;
U(3) = v0*sind(theta);
U(4) = y0;

% On utilise la methode de la bissection pour s'assurer
% d'obtenir une valeur (presque) nulle pour la derniere
% hauteur. Presque car nous avons du introduire un epsilon
% puisque l'identiquement nul est difficilement atteignable
% en calcul numerique a virgule...

while h > epsilon
    K1 = f(U);
    K2 = f(U+h*K1);
    Unew = U + h*(K1+K2)/2;
    if Unew(4) > 0
        U = Unew;
        % Vous pouvez "de-commenter" les deux lignes suivantes
        % pour avoir les graphes des trajectoires (ca ralentit le programme).
        %subplot(2,1,1);
        %plot(U(2),U(4),'.r','MarkerSize',5); hold on;
    else
        h = h/2;
    end
end

distance  = U(2);
subplot(2,1,2);
fprintf('Angle = %f : Distance = %f\n',theta,distance);
plot(theta,distance,'.b','MarkerSize',30); hold on;
shot = shot + 1;
end


