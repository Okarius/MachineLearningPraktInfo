model = createHmm();
X = '11111';
t = 4;

fward = forward(X, t, model);
bward = backward(X, t, model);

%%
%1d)
X = '11111';
[vit,vpath] = viterbi(X,model)

%e) P(H5=1| X=ACFGI) (Wahrscheinlichkeit dass wir in H5 sind wenn Sequenz X
%gegeben ist

%Posterior Decoding: Forward*Backward/Marginalisierung(V^T)
% X=ACFGI => entspricht X=1,1,2,1,1
X = '11211';
H5=1;
%Das gibt mir Wahrscheinlichkeiten fuer H=1 und H=2, davon brauche ich die
%Summe als Marginalisierung
forback = forward(X,t,model).*backward(X,t,model); 
Pe = forback(H5)/sum(forback);

%f) P(H5=1|X=BCEGJ) => X=2,1,1,1,2
X = '21112';
forback2 = forward(X,t,model).*backward(X,t,model); 
Pf = forback2(H5)/sum(forback2);

%g) Wahrscheinlichste Frequenz X=ACFGI => X=1,1,2,1,1
X='11211';
[vit2,vpath2] = viterbi(X,model)