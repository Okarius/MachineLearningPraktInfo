function [Phi, path ] = viterbi( X, model )
%viterbi Auswertung Viterbi Algorithmus zu gegebener Eingabe X
%   Detailed explanation goes here

A = model.A;
B = model.B;

 
%Initialisierung bzw Zustaende fuer t=0(1) fuer alle j (wir haben 2)
% Phi(0)
 path = '';
 Phi(1,1)=1;
 Phi(1,2)=0;
 
 %Jetzt alle weiteren Phi(t), 1 bis Ende
 %Es ist darauf zu achten, dass wir in der Iteration t+1 anschauen, da
 %Phi(t) fuer die Rechnung genutzt wird und Phi(0) quasi das Phi(1,1) ist
 for i=1:length(X)
     vk = str2num(X(i));
     Phi(i+1,1)= B{i}(1,vk)*max(Phi(i)*A{i}(1,1), Phi(i)*A{i}(2,1));
     Phi(i+1,2)= B{i}(2,vk)*max(Phi(i)*A{i}(1,2), Phi(i)*A{i}(2,2));
     
     %es gibt stets "nur" zwei Pfade deren Wahrscheinlichkeit wir
     %unterscheiden muessen- merke diese in path
     if Phi(i+1,1)>= Phi(i+1,2)
         path= strcat(path,'1');
     else
         path= strcat(path,'2');
     end

 end
end

