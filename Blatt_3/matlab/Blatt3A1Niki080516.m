% Übungsblatt3 
% Hartman, Zeitschler, Diegel
%Bayesscher multivariater Klassifikator
%@TEAM: Wir machen solche Blöcke für den Code, dann können wir uns besser
% orientieren. Einzelne Sectionen sind auch einzeln ausführbar,sodass wir
% nicht immer alle Plots generieren lassen müssen zum Beispiel.


%%
%a) Trainings und Testdaten einlesen
traindata_setosa = csvread('../material/trainingSetosa.csv');
traindata_versicolor = csvread('../material/trainingVersicolor.csv');
traindata_verginica = csvread('../material/trainingVirginica.csv');

testdata_setosa = csvread('../material/testSetosa.csv');
testdata_versicolor = csvread('../material/testVersicolor.csv');
testdata_verginica = csvread('../material/testVirginica.csv');
%%
%b)Daten zu jeder Kenngröße jeder Schwertlinienart aus Trainingsdaten
%sollen in einem Histogramm veranschaulicht werden
[nrow,ncol] = size(traindata_setosa);


stringsValue= [{'SepaleLaenge'}; {'SepaleBreite'};{'PetaleLaenge'};{'PetaleBreite'}];
for i=1:4
    str1 = strcat('trainSetosa',stringsValue{i});
    str2 = strcat('trainVersicolor',stringsValue{i});
    str3 = strcat('trainVerginica',stringsValue{i});
    
    figure(1);
    subplot(2,2,i)
    histogram(traindata_setosa(:,i));
    title(str1);
    
    figure(2);
    subplot(2,2,i)
    histogram(traindata_versicolor(:,i));
    title(str2);
        
    figure(3);
    subplot(2,2,i)
    histogram(traindata_verginica(:,i));
    title(str3);
end
%Speichere figures
print(figure(1), '-djpeg', strcat('../plots/trainSetosa.jpg'));
print(figure(2), '-djpeg', strcat('../plots/trainVersicolor.jpg'));
print(figure(3), '-djpeg', strcat('../plots/trainVerginica.jpg'));

% Maximal 6 Sätze für Beschreibung von Auffälligkeiten in den Daten

% 1: Setosa: Sepale Breite hat Lücke zwischen 2.5 u 3, Sepale Länge ist
% ist bei den kleinsten Werten aller Schwertlilien konzentriert (5 ist
% max).

% 2:Versicolor: Sepale Breite großer Maximalwert (bei ~2.8-3)
% 3:Verginica: Sepale Länge bzw Petale Länge orientieren sich eher an den
% größten Werten (Maxima zw. 6 u 7 bzw 5 u 6). Verginica>Versicolor>Setosa

% 4: 
% 5:
% 6:

%%
%c) Mittelwert und Varianzen der Kenngrößen
mean_setosa = mean(traindata_setosa);
mean_versicolor = mean(traindata_versicolor);
mean_verginica= mean(traindata_verginica);

var_setosa = var(traindata_setosa);
var_versicolor = var(traindata_versicolor);
var_verginica= var(traindata_verginica);
%%
%d) likelihoods p(x|w) & Bayes
likelihood_setosa = @(X) normpdf(X,repmat(mean_setosa,length(X),1),repmat(var_setosa,length(X),1));
likelihood_versicolor = @(X) normpdf(X,repmat(mean_versicolor,length(X),1),repmat(var_versicolor,length(X),1));
likelihood_verginica = @(X) normpdf(X,repmat(mean_verginica,length(X),1),repmat(var_verginica,length(X),1));
figure(4)
subplot(3,1,1)
fplot(likelihood_setosa,[0 10])
title('Likelihoods-Setosa')
subplot(3,1,2)
fplot(likelihood_versicolor,[0 10])
title('Likelihoods-Versicolor')
subplot(3,1,3)
fplot(likelihood_verginica,[0 10])
title('Likelihoods-Verginica')

print(figure(4), '-djpeg', strcat('../plots/LikelihoodsAll.jpg'));

%PRIORIs: alle sind gleichwahrscheinlich
priori = 1/3;
bayes_setosa = @(X) likelihood_setosa(X)/3;
bayes_versicolor = @(X) likelihood_versicolor(X)/3;
bayes_verginica = @(X) likelihood_verginica(X)/3;

%Testplots
figure(5)
hold on
fplot(bayes_setosa,[0 10],'r')
fplot(bayes_versicolor,[0 10],'g')
fplot(bayes_verginica,[0 10],'b')
hold off
print(figure(5), '-djpeg', strcat('../plots/BayesAll.jpg'));

%%
%KLASSIFIZIERE die Schwertlilienarten in RESULTVEKTOR
%1=Setosa, 2=Versicolor, 3=Verginica

%SETOSA
testS1 = bayes_setosa(testdata_setosa);
testS2 = bayes_versicolor(testdata_setosa);
testS3 = bayes_verginica(testdata_setosa);
resultSet(testS1>testS2 & testS1>testS3)=1; 
resultSet(testS2>testS1 & testS2>testS3)=2;
resultSet(testS3>testS1 & testS3>testS2)=3;

%VERSICOLOR
testVE1 = bayes_setosa(testdata_versicolor);
testVE2 = bayes_versicolor(testdata_versicolor);
testVE3 = bayes_verginica(testdata_versicolor);
resultVE(testVE1>testVE2 & testVE1>testVE3)=1;
resultVE(testVE2>testVE1 & testVE2>testVE3)=2;
resultVE(testVE3>testVE1 & testVE3>testVE2)=3;

%VERGINICA
testVA1 = bayes_setosa(testdata_verginica);
testVA2 = bayes_versicolor(testdata_verginica);
testVA3 = bayes_verginica(testdata_verginica);
resultVA(testVA1>testVA2 & testVA1>testVA3)=1;
resultVA(testVA2>testVA1 & testVA2>testVA3)=2;
resultVA(testVA3>testVA1 & testVA3>testVA2)=3;

%% e) 
truePositive = sum(resultSet == 1) + sum(resultVE == 2) + sum(resultVA == 3);
falseNegative = sum(resultSet ~= 1) + sum(resultVE ~= 2) + sum(resultVA ~= 3);
trueNegative = 0;
falsePositive = 0;
%@Team
%trueNegative und falsePositive haben wir doch gar nicht? Weil wir in den
%result vectoren eigentlich nur die der zugehörigen pflanze haben sollten?
%also z.b. Die Anzahl der Datenpunkte, die korrekt als nicht zur Art gehörig klassifiziert wurden (true negative).
%ist bei uns 0 weil wir in z.B. resultSet nur Setosa pflanzen haben
%sollten?


%% f)
%@Team
%Hier plotte ich immer die Trainingsdaten k.A. ob die gemeint sind. Denke
%schon
figure(6);
subplot(2,2,1);
hold on;
h1=scatter(traindata_setosa(:,4),traindata_verginica(:,2),'r');
h2=scatter(traindata_verginica(:,4),traindata_verginica(:,2),'g');
h3=scatter(traindata_versicolor(:,4),traindata_versicolor(:,2),'b');
title('petale Breite vs sepale Breite');
legend([h1,h2,h3],'Setosa', 'Veginica','Versicolor');

hold off;

subplot(2,2,2);
hold on;
h1=scatter(traindata_setosa(:,3),traindata_verginica(:,1),'r');
h2=scatter(traindata_verginica(:,3),traindata_verginica(:,1),'g');
h3=scatter(traindata_versicolor(:,3),traindata_versicolor(:,1),'b');
title('petale Länge vs sepale Länge');
legend([h1,h2,h3],'Setosa', 'Veginica','Versicolor');
hold off;


subplot(2,2,3);
hold on;
h1=scatter(traindata_setosa(:,3),traindata_verginica(:,2),'r');
h2=scatter(traindata_verginica(:,3),traindata_verginica(:,2),'g');
h3=scatter(traindata_versicolor(:,3),traindata_versicolor(:,2),'b');
title('petale Länge vs sepale Breite');
legend([h1,h2,h3],'Setosa', 'Veginica','Versicolor');
hold off;



subplot(2,2,4);
hold on;
h1 = scatter(traindata_setosa(:,1),traindata_verginica(:,2),'r');
h2= scatter(traindata_verginica(:,1),traindata_verginica(:,2),'g');
h3=scatter(traindata_versicolor(:,1),traindata_versicolor(:,2),'b');
title('sepale Länge vs sepale Breite');
legend([h1,h2,h3],'Setosa', 'Veginica','Versicolor');
hold off;

%1: Setosa kann man mit sehr gut erkken nur wenn man sepale Länge vs Sepale
%Breite plottet gibt es probleme sie zu unterscheiden.
%2: Sepale Länge vs Sepale Breite scheint sehr durcheinander zu sein, einer
%erkennung ist nur bei einer kleinen bzw großen sepalen breite eindeutig
%möglich.  @Team warum?
%3: Auffallend ist das man immer einige wenige überschneidungen zwischen
%Veginica und Versicolor hat, eine eindeutige unterscheidung ausschließlich
%an hand der sepalen maße wird wohl schwer fallen.
%4: Man kann hoffen das diese wenigen überschneidungen immer andere
%Pflanzen sind, dann könnte es möglich sein mit hilfe der übrigen
%Plots ein eindeutiges Ergebnis zu erhalten
%
%
%

