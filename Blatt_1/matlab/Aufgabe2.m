%%%% Aufgabe 2
%% a)

f = @(x) normpdf(x,0,1)
x = [-8,8];

fplot(f,x)

%% b)
figure;
muFunction = @(x) normpdf(x,-2,1);
fplot(muFunction,x)

figure;
sigmaFunction = @(x) normpdf(x,0,2);
fplot(sigmaFunction,x)

% 
% baseFunction = @(x) normpdf(x,0,1);
% muFunction = @(x) normpdf(x,-2,1);
% sigmaFunction = @(x) normpdf(x,0,2);
% x = [-8,8];
% 
% figure;
% subplot(3,1,1);
% fplot(baseFunction,x);
% title('F1: mu = 0, sigma = 1');
% 
% subplot(3,1,2);
% fplot(muFunction,x);
% title('F2: mu = -2, sigma = 1');
% 
% subplot(3,1,3);
% fplot(sigmaFunction,x);
% title('F:3 mu = 0, sigma = 2');

%% c)



%% d)

