function [  ] = matlab7_test( )

%[x,y]=meshgrid([-5:0.5:5],[-5:0.5:5]);
%[alpha] = GearStability(x,y,3);
%figure; contourf(x,y,-alpha,[-1:0.1:0]); grid;

[x,y]=meshgrid([-8:0.5:8],[-8:0.5:8]);
[alpha] = GearStability(x,y,6);
figure; contourf(x,y,-alpha,[-1:0.1:0]); grid;
axis off;

end