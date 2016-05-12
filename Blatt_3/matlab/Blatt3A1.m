% Übungsblatt3 
% Hartman, Zeitschler, Diegel
%Bayesscher multivariater Klassifikator

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

%Kenndaten stochastisch unabh�ngig -> kovarianzmatrix hat die einzelnen
%varianzen auf der Diagonalen, sonst alle Eintr�ge 0
cov_setosa = diag(var_setosa);
cov_versicolor = diag(var_versicolor);
cov_verginica= diag(var_verginica);

likelihood_setosa = @(X) mvnpdf(X,mean_setosa,cov_setosa);
likelihood_versicolor = @(X) mvnpdf(X,mean_versicolor,cov_versicolor);
likelihood_verginica = @(X) mvnpdf(X,mean_verginica,cov_verginica);


%PRIORIs: alle sind gleichwahrscheinlich
priori = 1/3;
bayes_setosa = @(X) likelihood_setosa(X) * priori;
bayes_versicolor = @(X) likelihood_versicolor(X) * priori;
bayes_verginica = @(X) likelihood_verginica(X) * priori;

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
%SETOSA
tpSetosa = sum(resultSet==1);
tnSetosa = sum(resultVE ~=1)+sum(resultVA~=1);
fpSetosa = sum(resultVE ==1)+sum(resultVA==1);
fnSetosa = sum(resultSet~=1);

%VERSICOLOR
tpVersicolor = sum(resultVE==2);
tnVersicolor = sum(resultSet ~=2)+sum(resultVA~=2);
fpVersicolor = sum(resultSet ==2)+sum(resultVA==2);
fnVersicolor = sum(resultVE~=2);

%VERGINICA
tpVerginica = sum(resultVA==3);
tnVerginica = sum(resultSet ~=3)+sum(resultVE~=3);
fpVerginica = sum(resultSet ==3)+sum(resultVE==3);
fnVerginica = sum(resultVA~=3);

%% f)
%Wir tragen hier die Kenngr��en der Testdaten auf
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
title('petale Laenge vs sepale Laenge');
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

%1: Setosa kann man mit den einzelnen Kenngr��en sehr gut abgrenzen, nur wenn man sepale Länge vs Sepale
%Breite allein betrachtet, gibt es probleme sie abzugrenzen.
%2: Sepale Länge vs Sepale Breite scheint sehr durcheinander zu sein, eine
%klare Abgrenzung der Arten ist �ber diese Kenngr��en allein nicht m�glich
%3: Auffallend ist, dass man immer einige überschneidungen zwischen
%Veginica und Versicolor hat, eine eindeutige Unterscheidung ausschließlich
%anhand von einzelnen Kenngr��en w�rde wohl schwer fallen.
%4: Man kann hoffen das diese wenigen überschneidungen immer andere
%Pflanzen sind, dann könnte es möglich sein mit hilfe der übrigen
%Plots ein eindeutiges Ergebnis zu erhalten
%

%% g) Kenngr��en sind nicht stochastisch unabh�ngig

%Cov. aus den Trainingsdaten bestimmen, Kenndaten sind stoch. abh�ngig
cov_setosa = cov(traindata_setosa);
cov_versicolor = cov(traindata_versicolor);
cov_verginica= cov(traindata_verginica);

%mittelwerte entsprechen den oben bestimmten mittelwerten

%likelihoods mit mvnpdf bestimmen
likelihood_mvn_setosa = @(X) mvnpdf(X,mean_setosa,cov_setosa);
likelihood_mvn_versicolor = @(X) mvnpdf(X,mean_versicolor,cov_versicolor);
likelihood_mvn_verginica = @(X) mvnpdf(X,mean_verginica,cov_verginica);

bayes_mvn_setosa = @(X) likelihood_mvn_setosa(X) * priori;
bayes_mvn_versicolor = @(X) likelihood_mvn_versicolor(X) * priori;
bayes_mvn_verginica = @(X) likelihood_mvn_verginica(X) * priori;

%KLASSIFIZIERE die Schwertlilienarten erneut in RESULTVEKTOR
%1=Setosa, 2=Versicolor, 3=Verginica

%SETOSA
test_mvn_S1 = bayes_mvn_setosa(testdata_setosa);
test_mvn_S2 = bayes_mvn_versicolor(testdata_setosa);
test_mvn_S3 = bayes_mvn_verginica(testdata_setosa);
result_mvn_Set(test_mvn_S1>test_mvn_S2 & test_mvn_S1>test_mvn_S3)=1; 
result_mvn_Set(test_mvn_S2>test_mvn_S1 & test_mvn_S2>test_mvn_S3)=2;
result_mvn_Set(test_mvn_S3>test_mvn_S1 & test_mvn_S3>test_mvn_S2)=3;

%VERSICOLOR
test_mvn_VE1 = bayes_mvn_setosa(testdata_versicolor);
test_mvn_VE2 = bayes_mvn_versicolor(testdata_versicolor);
test_mvn_VE3 = bayes_mvn_verginica(testdata_versicolor);
result_mvn_VE(test_mvn_VE1>test_mvn_VE2 & test_mvn_VE1>test_mvn_VE3)=1;
result_mvn_VE(test_mvn_VE2>test_mvn_VE1 & test_mvn_VE2>test_mvn_VE3)=2;
result_mvn_VE(test_mvn_VE3>test_mvn_VE1 & test_mvn_VE3>test_mvn_VE2)=3;

%VERGINICA
test_mvn_VA1 = bayes_mvn_setosa(testdata_verginica);
test_mvn_VA2 = bayes_mvn_versicolor(testdata_verginica);
test_mvn_VA3 = bayes_mvn_verginica(testdata_verginica);
result_mvn_VA(test_mvn_VA1>test_mvn_VA2 & test_mvn_VA1>test_mvn_VA3)=1;
result_mvn_VA(test_mvn_VA2>test_mvn_VA1 & test_mvn_VA2>test_mvn_VA3)=2;
result_mvn_VA(test_mvn_VA3>test_mvn_VA1 & test_mvn_VA3>test_mvn_VA2)=3;

%SETOSA
tp_mvn_Setosa = sum(result_mvn_Set==1);
tn_mvn_Setosa = sum(result_mvn_VE ~=1)+sum(result_mvn_VA~=1);
fp_mvn_Setosa = sum(result_mvn_VE ==1)+sum(result_mvn_VA==1);
fn_mvn_Setosa = sum(result_mvn_Set~=1);

%VERSICOLOR
tp_mvn_Versicolor = sum(result_mvn_VE==2);
tn_mvn_Versicolor = sum(result_mvn_Set ~=2)+sum(result_mvn_VA~=2);
fp_mvn_Versicolor = sum(result_mvn_Set ==2)+sum(result_mvn_VA==2);
fn_mvn_Versicolor = sum(result_mvn_VE~=2);

%VERGINICA
tp_mvn_Verginica = sum(result_mvn_VA==3);
tn_mvn_Verginica = sum(result_mvn_Set ~=3)+sum(result_mvn_VE~=3);
fp_mvn_Verginica = sum(result_mvn_Set ==3)+sum(result_mvn_VE==3);
fn_mvn_Verginica = sum(result_mvn_VA~=3);

%�nderung des Ergebnisses:
%Jetzt werden alle Testdaten korrekt klassifiziert.

%Die Annahme, dass die einzelnen Kenngr��en stochastisch unabh�ngig waren
%scheint falsch gewesen zu sein.
%Mit der Annahme, dass sie doch abh�ngig waren erhalten wir deshalb bessere
%Klassifizierungsergebnisse

%M�glicher plot:
%Differenzen f�r tp,tn,fp und fn visualisieren

figure(8)
subplot(3,1,1);
diff_tp_Setosa = tp_mvn_Setosa  - tpSetosa;
diff_tn_Setosa = tn_mvn_Setosa  - tnSetosa;
diff_fp_Setosa = fp_mvn_Setosa  - fpSetosa;
diff_fn_Setosa = fn_mvn_Setosa  - fnSetosa;
bar([diff_tp_Setosa diff_tn_Setosa diff_fp_Setosa diff_fn_Setosa]); 
title('Änderung der Klassifizierungen für Setosa');
set(gca,'XTickLabel',{'True Positive','True Negative','False Positive','False Negative'});

subplot(3,1,2);
diff_tp_Versicolor = tp_mvn_Versicolor  - tpVersicolor;
diff_tn_Versicolor = tn_mvn_Versicolor  - tnVersicolor;
diff_fp_Versicolor = fp_mvn_Versicolor  - fpVersicolor;
diff_fn_Versicolor = fn_mvn_Versicolor  - fnVersicolor;
bar([diff_tp_Versicolor diff_tn_Versicolor diff_fp_Versicolor diff_fn_Versicolor]);
title('Änderung der Klassifizierungen für Versicolor');
set(gca,'XTickLabel',{'True Positive','True Negative','False Positive','False Negative'});

subplot(3,1,3);
diff_tp_Verginica = tp_mvn_Verginica  - tpVerginica;
diff_tn_Verginica = tn_mvn_Verginica  - tnVerginica;
diff_fp_Verginica = fp_mvn_Verginica  - fpVerginica;
diff_fn_Verginica = fn_mvn_Verginica  - fnVerginica;
bar([diff_tp_Verginica diff_tn_Verginica diff_fp_Verginica diff_fn_Verginica]) ;
title('Änderung der Klassifizierungen für Verginica');
set(gca,'XTickLabel',{'True Positive','True Negative','False Positive','False Negative'});


print(figure(8), '-djpeg', strcat('../plots/diffsAll.jpg'));
