function test_matlab5()

close all;

[X,U] = beamDraft();

figure;
finalValue = U(end,1);
plot(X,U(:,1),'-r',X,U(:,2),'-b');

fprintf('\n\nIntegration by Runge-Kutta scheme \n');
fprintf('  Finale value is : %5.7f \n',finalValue);


[X,U] = beam();

figure;
finalValue = U(end,1);
plot(X,U(:,1),'-r',X,U(:,2),'-b');

fprintf('\n\nIntegration by Runge-Kutta scheme \n');
fprintf('  Finale value is : %5.7f \n',finalValue);


% Plot le probleme resolu par ode45, pour verif
[X,U] = verif_ode45();

figure;
finalValue = U(end,1);
plot(X,U(:,1),'-r',X,U(:,2),'-b');

fprintf('\n\nIntegration by Runge-Kutta scheme \n');
fprintf('  Finale value is : %5.7f \n',finalValue);

end