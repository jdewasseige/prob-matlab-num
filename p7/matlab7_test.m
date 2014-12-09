function [  ] = matlab7_test( )

[x,y]=meshgrid([-5:0.5:5],[-5:0.5:5]);
[alpha] = GearStability(x,y,2);
figure; contourf(x,y,-alpha,[-1:0.1:0]); grid;

end