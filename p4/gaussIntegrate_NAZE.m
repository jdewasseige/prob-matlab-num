function [Ih] = gaussIntegrate_NAZE(z, error)
n = 2;
% Pas oublier de rendre le code robuste
% Pas oublier de faire le chgt de variable [-L, L] => [-1, 1]

% Calcule Ih par G-L avec n+1 points entre -1 et 1

[w, X] = WandXGaussLegendre(n);

for k = 0:n
   for l = 0:n
      Ih = Ih + w(k+1) * w(l+1) * z(X(k+1),X(l+1)); 
   end
end


end