%% Maschinelles Lernen SS 2016 Uebungsblatt 1 Aufgabe 3
%% Multivariate Normal probability density function

% mu of the two random variables.
%% TODO
mu = [0 0];

% covariance matrix
varianceX1 = 1;
varianceX2 = 1;
%% TODO
covarianceX1X2 = -0.99;
covarianceMatrix = [varianceX1 covarianceX1X2; covarianceX1X2 varianceX2];

%% Hint:
%% not important for your assignment below here!

% resolution of plot
resolution = 0.1;

% x and y arguments
xArgs = -3 : resolution : 3; 
yArgs = -3 : resolution : 3;

% map to grid
[X1,X2] = meshgrid(xArgs, yArgs);

% calculate pdf
F = mvnpdf([X1(:) X2(:)], mu, covarianceMatrix);

% F is a vector, shape it to matrix form.
F = reshape(F, length(yArgs), length(xArgs));

% plot the function values
surf(xArgs, yArgs, F);

% Coloring of the graph
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);

% axis limits
axis([-3 3 -3 3 0 0.5])

% Formatting: axis labels
xlabel('Zufallsvariable Z1'); 
ylabel('Zufallsvariable Z2'); 
zlabel('P(Z1 und Z2)');