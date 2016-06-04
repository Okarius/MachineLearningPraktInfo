clear all; close all; clc;

% Linear Discriminant Analysis - general case

% args: numPoints, variance, stretchFactor, alpha
c1 = createPointCloud( 100, 3, 1, 45);
c2 = createPointCloud( 100, 3, 1, 45);
c=[c1;c2];
% shift second pointset 6 units to the right.
c2(:, 2) = c2(:, 2) + 6;



%Mittelwerte
mu1=mean(c1) ;
mu2= mean(c2);
mu = mean(c);

% streumatrix == covarianzMatrix
ScatterW1 = cov(c1);
ScatterW2 = cov(c2);

% scatter-within
ScatterW =ScatterW1 + ScatterW2;

% scatter-between
ScatterB = (mu1 - mu2)*(mu1 - mu2)';

proj = inv( ScatterW ) * ScatterB;
%proj  =  inv( ScatterW ) * (mu1-mu2)'; %ist alternative k.a. was das bring


%internet Tutorial
[v, d] = eig(proj);

w = v(: ,1) ;


f1 = @(x) w(1) * x;
f2 = @(x) w(2) * x;
%ende 


% figure;
title('original');
hold on;
plot(c1(:, 1), c1(:, 2)', 'og'); 
plot(c2(:, 1), c2(:, 2)', 'xr');
fplot(f2, [-4, 5], '--k');
