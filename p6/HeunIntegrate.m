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

function dudt = f(u)

    dudt = u; % Allocation
    dudt(1) = -0.01 * u(1);
    dudt(2) = u(1);
    dudt(3) = -9.81 - 0.01 * u(3);
    dudt(4) = u(3);
    
end