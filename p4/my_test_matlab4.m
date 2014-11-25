function my_test_matlab4()

fprintf('\n\nComputation by Gauss-Legendre composite method \n');
fprintf('  Volume (Error required-observed) \n');

I = dblquad(@(x,y) z(x,y),-15,15,-15,15);

for i=0:6
    errReq  = 0.1/10^i;
    Ih = gaussIntegrate(15,@z,errReq);
    errObs = abs(I-Ih);
    if errObs > errReq
        fprintf('*!* \t');
    end
    fprintf('  %5.7f (%1.7f-%1.7f)\n',Ih, errReq,errObs);
end

end

function z= z(x,y)
z = 8+19*exp(-0.005*(2*x.^2+y.^2));
end