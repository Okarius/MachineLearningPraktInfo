% Diegel, Hartmann, Zeitler
% Aufgabe 3
% 
%%
pxc = BayesNet(3,0,0,1,2)
pc = BayesNet(0,0,0,1,2)

aa=pxc/pc

xxx1 = BayesNet(0,0,1,2,1)
xxx2 = BayesNet(0,0,0,2,1)

xxx3= xxx1/xxx2