% Zeitschler, Hartmann, Diegel
% Blatt 5 - Aufgabe 3

%%
%a) Einlesen der Trainingsdaten
traindata_setosa = csvread('../data/trainingSetosa.csv');
traindata_versicolor = csvread('../data/trainingVersicolor.csv');
traindata_verginica = csvread('../data/trainingVirginica.csv');

alldata = [traindata_setosa; traindata_versicolor; traindata_verginica];
%%
%b) Durchfuehrung PCA
[pc ws sc] = pca(alldata);
dim=2; %will ich auf die ersten 2 (dim) dimensionen projezieren dann so
firstComp = pc(:,1:dim);
% Projeziere auf firstComp
newData = (firstComp.'*alldata.').';
%%
%c)
% die erste Komponente (sepale Laenge) macht alleine 92.3% aus. 
% Es sind also alle Kombinationen mit 1. Komponente zu pruefen.
% Nur ersten beiden Komponenten enthalten zusammen mind. 95% der Streuung!
res = (sc(1)+sc(2))/sum(sc); %97.68%
res = (sc(1)+sc(3))/sum(sc); %94.00%
res = (sc(1)+sc(4))/sum(sc); %92.91%

%%