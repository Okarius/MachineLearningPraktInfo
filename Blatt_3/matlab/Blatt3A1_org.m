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
%%