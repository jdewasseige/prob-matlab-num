function GrapheConvection(n,zeta,k)
% Graphe le plot que tu veux maggle !

%n = 82;
%zeta = 1000;
%k = 1 ;

h =  2.0/(n-1);
X = -1.0:h:1.0;
Y = -1.0:h:1.0;


A = sparse(n^2,n^2);
map = zeros((n-2)^2,1);

B = zeros((n-2)^2,1);

l = 1 ; % Pour le calcul de B
for i = 2:n-1
    for j = 2:n-1
        index = (i-1)*n + j;
        map((i-2)*(n-2)+j-1) = index;
        % Abcisse du point
        x = 2*(i-1)/(n-1) - 1 ;
        % Ordonnée du point
        y = 2*(j-1)/(n-1) - 1 ;
        % Vitesse au point considere
        [v1,v2] = velocity(x,y) ;
        % Remplissage de A
        A(index,index)   = 8*k ;
        A(index,index+1) = zeta*v2*h - 2*k ;
        A(index,index-1) = - zeta*v2*h - 2*k ;
        A(index,index+n) = zeta*v1*h - 2*k ;
        A(index,index-n) = - zeta*v1*h - 2*k ;
        % Vecteur source
        B(l,1) = 2 * h^2 * source(x,y) ;
        l = l + 1 ;
    end
end

%A = A/(h^2); pris en compte dans B
%B = -ones((n-2)^2,1);

U = zeros(n,n);
U(2:n-1,2:n-1) = reshape(A(map,map)\B,n-2,n-2);
contourf(X,Y,U); 
axis off; axis equal
end


function f = source(x,y)
    assert(abs(x) <= 1 && abs(y) <= 1, ...
        'L''argument de f n''est pas dans le domaine Omega');
    if x >= 0.5
        f = 10 ;
    else
        f = 0 ;
    end
end
