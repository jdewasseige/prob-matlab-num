function [  ] = GearStabilityExample( )
    [x,y]=meshgrid([-8:0.5:8],[-8:0.5:8]);
    [alpha] = GearStability(x,y,3);
    figure; contourf(x,y,-alpha,[-1:0.1:0]); grid;
end
 
function [alpha] = GearStability(x,y,n)      
    z = x+i*y;
    alpha = z;   % pre-allocation de alpha :-)
    for k=1:size(z,1)
        for l =1:size(z,2)
            c = [(z(k,l)*6 -11)  18 -9  2];
            r = roots(c);
            alpha(k,l) = max(abs(r));
        end
    end
end
 
