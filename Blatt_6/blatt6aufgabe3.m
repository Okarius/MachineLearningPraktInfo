% Diegel, Hartmann, Zeitler
% Aufgabe 3
% 
%%
p1 = BayesNet(3,1,0,2,2)
p2 = BayesNet(1,1,1,2,1)
%%
c = BayesNet(0,0,2,0,1)/BayesNet(0,0,2,0,0)
%%
d = BayesNet(3,0,0,1,2)/BayesNet(0,0,0,1,2)

e = BayesNet(0,0,1,2,1)/BayesNet(0,0,0,2,1)