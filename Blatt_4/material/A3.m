%% Blatt 4
% Hartmann, Zeitschler, Diegel

%%Aufgabe 3
%%
%d)
data = csvread('samples.csv');%c)
i=0:5;
mu0 = -10; %Priori Schätzer
sigma0=1; % Unsicherheit für Priori Schätzer
sigma =1; %wahres Sigma

resMu=[0,0,0,0,0,0];% entaehlt alle bayes geschaetzten Mittelwerte
for ii=i
    numSamples = 2^ii*10;
    idata = data(1:numSamples);
    sampleMean = mean(idata);
    part1 = (numSamples*sigma0)/(numSamples*sigma0+sigma)*sampleMean;
    part2 = sigma/(numSamples*sigma0+sigma) * mu0 ;
    muN = part1+part2;
    resMu(ii+1)=muN;
end
%%
%e)
afunc = @(x) normpdf(x,3,1);
i0func=@(x) normpdf(x,resMu(1),1);
i1func=@(x) normpdf(x,resMu(2),1);
i2func=@(x) normpdf(x,resMu(3),1);
i3func=@(x) normpdf(x,resMu(4),1);
i4func=@(x) normpdf(x,resMu(5),1);
i5func=@(x) normpdf(x,resMu(6),1);
figure(1);
subplot(3,2,1);
hold on;
fplot(afunc,[-5 10], 'b')
fplot(i0func,[-5 10], 'r')
title('i=0');
hold off;

subplot(3,2,2);
hold on;
fplot(afunc,[-5 10], 'b')
fplot(i1func,[-5 10], 'r')
title('i=1');
hold off;

subplot(3,2,3);
hold on;
fplot(afunc,[-5 10], 'b')
fplot(i2func,[-5 10], 'r')
title('i=2');
hold off;

subplot(3,2,4);
hold on;
fplot(afunc,[-5 10], 'b')
fplot(i3func,[-5 10], 'r')
title('i=3');
hold off;

subplot(3,2,5);
hold on;
fplot(afunc,[-5 10], 'b')
fplot(i4func,[-5 10], 'r')
title('i=4');
hold off;

subplot(3,2,6);
hold on;
fplot(afunc,[-5 10], 'b')
fplot(i5func,[-5 10], 'r')
title('i=5');
hold off;
print(figure(1), '-djpeg', strcat('../plots/ApproxVsBayes.jpg'));
%%
%f) Stimmt das so?
mse0 = mean((i0func(-5:.001:10)-afunc(-5:.001:10)).^2);
mse1 = mean((i1func(-5:.001:10)-afunc(-5:.001:10)).^2);
mse2 = mean((i2func(-5:.001:10)-afunc(-5:.001:10)).^2);
mse3 = mean((i3func(-5:.001:10)-afunc(-5:.001:10)).^2);
mse4 = mean((i4func(-5:.001:10)-afunc(-5:.001:10)).^2);
mse5 = mean((i5func(-5:.001:10)-afunc(-5:.001:10)).^2);

