function test_matlab8

%
% -1- Les jolis plots :-)
%
close all;  set(figure,'Color',[1 1 1]);

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

function [u,v] = velocity(x,y)

epsilon = 1/5;
zp = (-1+ sqrt(1+4*(pi*epsilon)^2))/(2*epsilon);
zm = (-1- sqrt(1+4*(pi*epsilon)^2))/(2*epsilon);
D = ((exp(zm)-1)*zp + (1-exp(zp))*zm)/(exp(zp)-exp(zm));
fu = (pi/D) * (1+ ((exp(zm)-1)*exp(zp*(x+1)/2) + (1-exp(zp))*exp(zm*(x+1)/2))/(exp(zp)-exp(zm)));
fv = (1/D) * (((exp(zm)-1)*zp*exp(zp*(x+1)/2) + (1-exp(zp))*zm*exp(zm*(x+1)/2))/(exp(zp)-exp(zm)));
u = fu.*sin(pi*y/2);
v = fv.*cos(pi*y/2);

end



