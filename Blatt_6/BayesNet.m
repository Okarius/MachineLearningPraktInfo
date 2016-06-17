function [ P ] = BayesNet( A, B, C, D, X )
%BayesNet Berechnet Wahrscheinlichkeit im Netz
%   Zustaende als Zahlen
%%
%A:= (0 -Keine Angabe, 1 -Winter, 2 -Fruehling, 3 -Sommer, 4 -Herbst)
%B:= (0 -Keine Angabe, 1 -Nordatlantik, 2 -Suedatlantik)
%C:= (0 -Keine Angabe, 1 -hell, 2 -mittel, 3 -dunkel)
%D:= (0 -Keine Angabe, 1 -breit, 2 -duenn)
%X:= (0 -Keine Angabe, 1 -Lachs, 2 -Barsch)
%%
% Define Matrices
TBL_PA = [0.25,0.25,0.25,0.25];
TBL_PB = [0.6,0.4];
TBL_XAB = [
    0.5,0.5;
    0.7,0.3;
    0.6,0.4;
    0.8,0.2;
    0.4,0.6;
    0.1,0.9;
    0.2,0.8;
    0.3,0.7;
    ];
TBL_CX=[
    0.6,0.2,0.2;
    0.2,0.3,0.5;
    ];
TBL_DX=[
    0.3,0.7;
    0.6,0.4;
    ];

%Check inputs
% hier muss evtl noch weiter Fehler abgefangen werden je nach Kombination.
%A = 3;B = 1;C = 0;D = 2;X = 2;
% Mein Test liefert 
if A < 1
    A=1:4;
end
if B < 1
    B=1:2;
end

if C < 1
    C=1:3;
end
if D < 1
    D=1:2;
end
if X < 1
    X =1:2;
end
% P(A,B,C,D,X) = P(A)*P(B)*P(X|A,B)*P(C|X)*P(D|X)
%Machs mal mit for schleifen...
sum=0;
for a=A
    for b= B
        for c=C
            for d=D
                for x=X
                    sum = sum + TBL_PA(a)*TBL_PB(b)*TBL_XAB(2*(a-1)+b,x)*TBL_CX(x,c)*TBL_DX(x,d);
                end
            end
        end
    end
end
P=sum;
end

