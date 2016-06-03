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
dim=1; %will ich auf die ersten 2 (dim) dimensionen projezieren dann so
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
res = (sc(1)+sc(3)+sc(4))/sum(sc); %94.62%

%%
%d) Projektion in Raum der mindestens 95% der Daten enthält
dimd=2; 
firstComp = pc(:,1:dimd);
% Projeziere auf firstComp
newDatad = (firstCompd.'*alldata.').';
% Alle Punkte werden auf eine Linie projeziert -zur Veranschaulichung habe
% ich deshalb Y=1 verwendet. Eigentlich waeren die Punkte alle auf der
% SepalenLaenge-Achse.
scatter(newDatad(:,1),ones(1,120))
%%
% e) das Ergebnis soll geeignet geplottet werden -HILFE?
scatter(newDatad(:,1), newDatad(:,2))
%Man erkennt 2 Cluster, die jetzt einfach mit einer Geraden separiert
%werden können. 
%%
%f) Ergibt die PCA sinn? Warum oder warum nicht?
% Ja - wir sehen, dass es möglich ist unseren Datensatz durch eine
% Projektion in die entsprechende Richtungen (erste beiden Principal
% Components) zu separieren.
% Fuer eine Klassifikation bzw. Zuordnung der Pflanzen anhand der Merkmale
% macht diese Projektion aber keinen Sinn mehr. 