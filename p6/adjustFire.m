function [theta] = adjustFire(y0,v0,epsilon,h,f)


% Merci pour tes chokotoffs je viens de m'en mettre un haha
    thetaMin = 0;
    thetaMax = 90;
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
%        input('      Press any key to do next iteration \n');   
    end
    theta = (thetaMin + thetaMax) / 2;
    
end

% Idées :
%   - gérer si f est une fct vectorielle de taille différente que 4
%   - theta est en degrés


function [distance] = HeunIntegrate(theta,y0,v0,h,f)

    epsilon = 0.0001; % précision requise pour hauteur nulle
    global shot
    U = zeros(4);
    U(1) = v0*cosd(theta);
    U(2) = 0;
    U(3) = v0*sind(theta);
    U(4) = y0;

    subplot(2,1,1);
    
    while h > epsilon %U(4) >= 0 && abs(U(4) - Unew(4)) > epsilon/2
        K1 = f(U);
        K2 = f(U+h*K1);
        Unew = U + h*(K1+K2)/2;
        if Unew(4) > 0
            U = Unew;
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


