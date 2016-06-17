clear all; close all; clc;

% Linear Discriminant Analysis - general case
%%
% a) Punktmengen erstellen
% args: numPoints, variance, stretchFactor, alpha
c1 = createPointCloud( 100, 3, 1, 45);
c2 = createPointCloud( 100, 3, 1, 45);
%c=[c1;c2];
% shift second pointset 6 units to the right.
c2(:, 2) = c2(:, 2) + 6;
c=[c1;c2];

%%
% b)
%Mittelwerte
mu1=mean(c1) ;
mu2= mean(c2);
mu = mean(c);

% streumatrix == covarianzMatrix
ScatterW1 = cov(c1);
ScatterW2 = cov(c2);
%Formeln aus dem Skript nehmen und nicht die covarianzmatrix...

% scatter-within
ScatterW =ScatterW1 + ScatterW2;

% scatter-between
ScatterB = (mu1 - mu2)*(mu1 - mu2)';
%%
%c Projektion
proj = inv( ScatterW ) * ScatterB;
%proj  =  inv( ScatterW ) * (mu1-mu2)'; %ist alternative k.a. was das bring
projData = (proj *c.').';
% Finde first principal component - größte Eigenvalues und zugeöriger
% Eigenvektor
%internet Tutorial
[v, d] = eig(proj);
%v ist nach größe geordnet -Richtung mit größter Varianz ist 1.Spalte
w = v(: ,1) ;


f1 = @(x) w(1) * x;
f2 = @(x) w(2) * x;
%ende 


% figure;
title('original');
hold on;
scatter(c1(:, 1), c1(:, 2)', 'og'); 
scatter(c2(:, 1), c2(:, 2)', 'xr');
fplot(f2, [-4, 5], '--k');
fplot(f1, [-4, 5], '--k')

figure(2);hold on;
scatter(projData(:,1),projData(:,2));
title('projection');
print(figure(2), '-djpeg', strcat('../plots/4projection.jpg'));
%fplot(f2, [-200, 100], '--k');
hold off;

figure(3);hold on;
scatter(c(:,1),c(:,2));
%fplot(f1, [-4, 5], '--k');
title('original');
print(figure(3), '-djpeg', strcat('../plots/4original.jpg'));
hold off;