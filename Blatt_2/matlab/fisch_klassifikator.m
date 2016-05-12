fische = csvread('../material/fische.csv');
length = size(fische, 1);

% hist(fische);
% figure;

%alles f�r den Barsch steht an 1. Position im Array
%alles f�r den Lachs steht an 2. Position im Array
barsch = 1;
lachs = 2;

priori = [0.5 0.5];
pdf{barsch} = @(x) normpdf(x,1,0.2);
pdf{lachs} = @(x) normpdf(x,1.6,0.3);

% hold on
% fplot(pdf{barsch}, [0,3]);
% fplot(pdf{lachs}, [0,3]);
% hold off
% figure;

likelihood = zeros(2, length);
posteriori = zeros(2, length);
evidence = zeros(length, 1);

for i=1:length
    likelihood(barsch, i) = pdf{barsch}(fische(i));
    likelihood(lachs, i) = pdf{lachs}(fische(i));
    %evidence ist Summe �ber alle Merkmale aus likelihood des Merkmals mal der
    %Auftrittswahrscheinlichkeit dieses Merkmals    
    evidence(i) = likelihood(barsch, i) * priori(barsch) + likelihood(lachs, i) * priori(lachs);    
    
    %a-posteriori Wahrscheinlichkeiten
    posteriori(barsch, i) = likelihood(barsch, i) * priori(barsch) / evidence(i);
    posteriori(lachs, i) = likelihood(lachs, i) * priori(lachs) / evidence(i);
end

%Die posteriori mal plotten lassen
hold on
for i=1:length
    plot(fische(i), posteriori(barsch, i), 'r.');
    plot(fische(i), posteriori(lachs, i), 'b.');
end
hold off

%Entscheidungsregel: barsch, wenn P(barsch|x) > P(lachs|y)
decision = [0 0];
for i=1:length
    if(posteriori(barsch, i) > posteriori(lachs, i))
        decision(barsch) = decision(barsch) + 1;
    else
        decision(lachs) = decision(lachs) + 1;
    end
end

fprintf('%d Barsche, %d Lachse\n', decision)
fprintf('Probabilities %f Barsche, %f Lachse\n', decision/length)
%d) Man entscheidet sich für den Fisch mit der Höheren Posteriori
%Wahrscheinlichkeit. Links des Schnittpunktes sind die Barsche, rechts
%davon die Lachse. Weiteres @TEAM TODO!
%e) @TEAM TODO!
%f)P(Barsch)=#Barsche/#Fische, P(Lachs)=#Lachse/#Fische
%g) Klassifikation ist abh�ngig von den Annahmen �ber die relative Anzahl
%der Fische und der gew�hlten Verteilungen der Fischl�ngen


%################      A3   ###############################################
%a)Loss-Funktion
lambdaBB=0;
lambdaBL=1.2;
lambdaLB=0.5;
lambdaLL=0;
ConditionalRisk= zeros(2, length);
for i=1:length
        % Risiko für Fehlinterpretation Barsch
        ConditionalRisk(barsch,i)= posteriori(barsch,i)*lambdaBB + posteriori(lachs,i)*lambdaBL;
        % Risiko für Fehlinterpretation Lachs
        ConditionalRisk(lachs,i)= posteriori(lachs,i)*lambdaLL + posteriori(barsch,i)*lambdaLB;
end

%b) Die Risiken plotten
figure(3)
hold on
plot(fische, ConditionalRisk(barsch, :), 'r.');
plot(fische, ConditionalRisk(lachs, :), 'b.');
hold off
%Man berechnet den Schnittpunkt beider Funktionen, bzw. schaut sich an wo
%sich die Kurven schneiden und sagt dann:
%Alles was links des Schnittpunkts ist wird als Barsch klassifiziert 
%(eine Fehlklassifikation als Lachs wäre teurer als eine Fehlklassifikation
% eines Barsches. Dementsprechend ist alles recht vom Schnittpunkt als
% Lachs zu klassifizieren. -> Man betrachtet beide Conditional risks und
% wählt stets den Fisch der das kleinere Risiko hat, sprich der Fisch bei
% dem eine Fehlentscheidung weniger teuer ist.


%Im Beispiel ist der Schnittpunkt etwa bei einer Länge von 1.2. 
% Alles was kleiner ist als 1.2 sollte man als Barsch und alles größere als
% Lachs klassifizieren.

%c) Klassifikation mit Risiko
decision2 = [0 0];
%kategorisiert entsprechend Fischlänge ob Barsch =1 oder Lachs =2
fishclass = zeros(length, 1); 
for i=1:length
    %TEAM: dieses > evtl umkehren?
    if(ConditionalRisk(barsch, i) > ConditionalRisk(lachs, i))
        decision2(barsch) = decision2(barsch) + 1;
        fishclass(i)=barsch;
    else
        decision2(lachs) = decision2(lachs) + 1;
        fishclass(i)=lachs;
    end
end
fprintf('Lossfkt 1\n')
fprintf('%d Barsche, %d Lachse\n', decision2)
fprintf('Probabilities %f Barsche, %f Lachse\n', decision2/length)
%d) Abänderung loss funktion
lambdaBB=0;
lambdaBL=1.8;
lambdaLB=1.8;
lambdaLL=0;
ConditionalRisk2= zeros(2, length);
decision3 = [0 0];
for i=1:length
    % Risiko für Fehlinterpretation Barsch
    ConditionalRisk2(barsch,i)= posteriori(barsch,i)*lambdaBB + posteriori(lachs,i)*lambdaBL;
    % Risiko für Fehlinterpretation Lachs
    ConditionalRisk2(lachs,i)= posteriori(lachs,i)*lambdaLL + posteriori(barsch,i)*lambdaLB;

    %Klassifizierung

    %TEAM: dieses > evtl umkehren?
    if(ConditionalRisk2(barsch, i) > ConditionalRisk2(lachs, i))
        decision3(barsch) = decision3(barsch) + 1;
    else
        decision3(lachs) = decision3(lachs) + 1;
    end
end

fprintf('Lossfkt 2\n')
fprintf('%d Barsche, %d Lachse\n', decision3)
fprintf('Probabilities %f Barsche, %f Lachse\n', decision3/length)

%H�here Kosten f�r eine Falschentscheidung, falls wir Barsch w�hlen aber es
%ein Lachs war (lambdaLB = 1.8) -> wir entscheiden uns �fter f�r den Lachs,
%weil damit die Kosten geringer sind

% Alles was kleiner ist als 1.2 sollte man als Barsch und alles größere als
% Lachs klassifizieren.--passt das hier vllt besser?

figure(4)
hold on
plot(fische, ConditionalRisk2(barsch, :), 'r.');
plot(fische, ConditionalRisk2(lachs, :), 'b.');
hold off

%Beschreibung
% Wir kehren die Gewichtung der Fehlinterpretation um und entscheiden uns,
% dass eine Fehlinterpretation des Barsches 0.2, die des Lachses 1.8
% (Kosten) verursacht. Dadurch streckt sich die Kurve für den Lachs und es
% staucht sich die Kurve für den Barsch. Der Schnittpunkt beider Funktionen
% verschiebt sich, sodass dieser nun deutlich weiter rechts (ca. 1.45)
% liegt. Nun entscheiden wir uns für Barsche bei Fischen bis zu einer Länge
% von 1.45
