D = [2 4 5 8 15];
n = numel(D);
sigma = 1;
hold on;
sum = @(x) 0;
for idx = 1:n
    x_i = D(idx);
    part = @(x) 1/n * 1/(sqrt(2*pi) * sigma) * exp(-(x_i - x)^2 / (2*sigma^2));
    fplot(part, [0 20]);
    sum = @(x) sum(x) + part(x);
end
%Sieht noch nicht genau gleich aus wie auf dem Blatt?
%Finde den Fehler!
fplot(sum, [0 20]);
hold off;

D1 = csvread('D1.csv');
D2 = csvread('D2.csv');

M = [[0 0]; [7 7]; [30 20]; [14 40]];

%PNN für D1 und D2
for m=1:numel(M)/2
    x = M(m,:);
    w_1 = 0;    
    w_2 = 0;
    for idx = 1:numel(D1)/2
       x_i = D1(idx,:);
       value_node_i = exp(-(x_i - x) * (x_i - x).' / (2*sigma^2));
       w_1 = w_1 + value_node_i;
    end
    
    for idx = 1:numel(D2)/2
       x_i = D2(idx,:);
       value_node_i = exp(-(x_i - x) * (x_i - x).' / (2*sigma^2));
       w_2 = w_2 + value_node_i;
    end
    
    %Keine Skalierung von w_1/w_2 nötig, da priori Wahrscheinlichkeit
    %gleich
    
    if w_1 > w_2
        %Klassifizieren zu D1
        fprintf('(%i,%i) als D1 klassifiziert\n', x)
    else
        %Klassifizieren zu D2
        fprintf('(%i,%i) als D2 klassifiziert\n', x)
    end
end

