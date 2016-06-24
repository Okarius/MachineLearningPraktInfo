function [ hmm ] = createHmm(  )
% T = Anzahl an der Knoten
% A = Übergangswahrscheinlichkeiten der Hidden States entsprechend der Tabellen auf dem Übungsblatt.
% B = Emissionswahrscheinlichkeiten der Visible States entsprechend der Tabellen auf dem Übungsblatt.
    hmm.T = 5;
    
    A = cell(1, 5);
    
    A{1, 1} = [0.4, 0.6];
    A{1, 2} = [[0.3, 0.7]; [0.7, 0.3]];
    A{1, 3} = [[0.8, 0.2]; [0.2, 0.8]];
    A{1, 4} = [[0.9, 0.1]; [0.1, 0.9]];
    A{1, 5} = [[0.6, 0.4]; [0.4, 0.6]];
    
    B = cell(1, 5);
    B{1, 1} = [[0.1, 0.9]; [0.9, 0.1]];
    B{1, 2} = [[0.4, 0.6]; [0.6, 0.4]];
    B{1, 3} = [[0.7, 0.3]; [0.3, 0.7]];
    B{1, 4} = [[0.6, 0.4]; [0.4, 0.6]];
    B{1, 5} = [[0.8, 0.2]; [0.2, 0.8]];
    
    hmm.A = A;
    hmm.B = B;


end

