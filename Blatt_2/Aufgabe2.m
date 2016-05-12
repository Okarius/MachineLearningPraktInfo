function lachsBarschAPosterio = Aufgabe2()
lengths = csvread('material/fische.csv');
fishCount = size(lengths);
figure(1)
hist(lengths,fishCount(1)/10);
barschProb = 0.5;
lachsProb = 0.5;
lachsBayesDecision=zeros(fishCount);
LachsWK = zeros(fishCount);
BarschWK =zeros(fishCount);
likelihoodLachs=zeros(fishCount);
likelihoodBarsch=zeros(fishCount);
for i = 1 :fishCount
    likelihoodLachs(i) = normpdf(lengths(i), 1, 0.2);
    likelihoodBarsch(i) = normpdf(lengths(i), 1.6, 0.3);
    evidence = likelihoodLachs(i)  * lachsProb + likelihoodBarsch(i) * barschProb;
    LachsWK(i) = likelihoodLachs(i)*lachsProb/evidence;
    BarschWK(i) = likelihoodBarsch(i) * barschProb/evidence;
    if(LachsWK(i) > BarschWK(i))
        lachsBayesDecision(i) = 1; % 1 4 Lachs
    else
        lachsBayesDecision(i)=-1; % -1 4 Barsch
    end
end
disp('next');

figure(2)
hold on;
plot(LachsWK);
plot(BarschWK);
legend('lachs','barsch');
%f)????????
%d) Die Kurve die höher ist der Fisch ist es. Wobei auf der X achse der
%Index für die Längen ist. 

%g) die erste annahme das es gleich viele Lachse und Barsche gibt
%beeinflußt den Prior. (deswegen ist er hier 0.5) 
%Die andere Anahme, das sie Normalverteilt sind und was die Parameter
%dieser Normalverteilung beeinflußt die Likelihood.
end