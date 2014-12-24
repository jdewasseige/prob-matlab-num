function test_matlab8

%
% -1- Les jolis plots :-)
%
%close all;
set(figure,'Color',[1 1 1]);

zeta = [0 10 100 1000];
for i=1:4
    [X,Y,U] = convection(82,zeta(i));
    subplot(2,2,i)
    contourf(X,Y,U,0:0.05:2.0); caxis([0 0.8 ]);
    axis off; axis equal;
end
  

%
% -2- Représentation du champs de vitesse :-)
%

set(figure,'Color',[1 1 1]);
n = 30;
h =  2.0/(n-1);
X = -1.0:h:1.0;
Y = -1.0:h:1.0;
[Xm Ym] = meshgrid(X,Y);
[Um Vm] = velocity(Xm,Ym);
quiver(Xm,Ym,Um,Vm); axis off; axis equal;
end



