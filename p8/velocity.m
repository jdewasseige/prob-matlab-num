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