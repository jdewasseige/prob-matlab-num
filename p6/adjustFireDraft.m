function [theta] = adjustFireDraft(y0,v0,epsilon,h,f)

    thetaMin = 0;
    thetaMax = 90;
    while abs(thetaMax - thetaMin) > 2*epsilon
%
% A completer (les deux lignes qui suivent sont des stupidites 
%              qui servent juste a obtenir un truc bizarre) 
%
        thetaMax = thetaMax/7.0;
        distMax = 0;
%
%
%
        subplot(2,1,2);
        plot([thetaMin thetaMin],[0,300],'-r'); hold on;   
        plot([thetaMax thetaMax],[0,300],'-r'); hold on;
    
        fprintf('==== New interval is [%f, %f]\n',thetaMin,thetaMax);
        fprintf('     Distance = %f : error = %f\n',distMax,thetaMax - thetaMin);
%        input('      Press any key to do next iteration \n');   
    end
    theta = (thetaMin + thetaMax) / 2;
    
end

% Idées :
%   - gérer si f est une fct vectorielle de taille différente que 4
%   - theta est en degrés


function [distance] = HeunIntegrate(theta,y0,v0,h)%(theta,y0,v0,h,f)

    global shot
    U = zeros(4);
    U(1) = v0*cosd(theta);
    U(2) = 0;
    U(3) = v0*sind(theta);
    U(4) = y0;

    subplot(2,1,1);
    
    while U(4) >= 0
        K1 = f(U);
        K2 = f(U+h*K1);
        U = U + h*(K1+K2)/2;
    end
    % Je bloque un peu sur ça (cfr énoncé) :
    % "La longueur du dernier pas sera adaptee afin
    % d?obtenir une valeur nulle pour la derniere hauteur."

    distance  = U(2);
    subplot(2,1,2);
    fprintf('Angle = %f : Distance = %f\n',theta,distance);
    plot(theta,distance,'.b','MarkerSize',30); hold on;
    shot = shot + 1;
end


