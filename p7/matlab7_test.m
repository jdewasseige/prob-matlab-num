function [  ] = matlab7_test( )

[x,y]=meshgrid([-30:0.5:30],[-30:0.5:30]);
[alpha] = GearStability(x,y,6);
figure; contourf(x,y,-alpha,[-1:0.1:0]); grid;

end