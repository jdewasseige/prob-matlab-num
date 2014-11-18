function [Ih] = gaussIntegrate_ant(L,z,error)

    function [IhSmall] = gaussIntegrateSmall(a,b,c,d)
       % Approxime l'integrale de z sur le carré (a,b,c,d)
       % en utilisant G-L avec 4 points
       
        function [x] = chgtVarX(xi)
            % Renvoie x(xi) tel que defini dans le cours
            x = ((b-a)/2.0)*xi + (b+a)/2.0 ;
        end
        function [y] = chgtVarY(chi)
            % Renvoie y(chi) tel que defini dans le cours
            y = ((d-c)/2.0)*chi + (d+c)/2.0 ;
        end
        % Note : on aurait pu tout faire avec une seule fonction
        %        mais on en garde 2 pour des raisons de lisibilité.
        
        r = sqrt(1/3);
        IhSmall = (((b-a)/2)^2) * ( z(x(-r),y(-r)) + ...
                                    z(x(-r),y(+r)) + ...
                                    z(x(+r),y(-r)) + ...
                                    z(x(+r),y(+r)) ) ;
    end


    function [IhBig] = gaussIntegrateBig(n)
        % Calcule Ih en separant le carre de cote 2L en n^2 carres
        % de cote 2L/n et en calculant pour chacun IhSmall et en
        % les sommant
        IhBig = 0 ;
        
        for i = 0:n-1
           for j = 0:n-1
              IhBig = IhBig + ...
                      gaussIntegrateSmall (-L + (2*L/n)*i , ...
                                           -L + (2*L/n)*(i+1) , ...
                                           -L + (2*L/n)*j , ...
                                           -L + (2*L/n)*(j+1) ) ;
           end
        end
    end

Ih =  gaussIntegrateBig(2.0);
end

