function [bward] = backward(X, t, model)

A = model.A;
B = model.B;

    if(t == size(A, 2))
        bward(1, 1) = 1;
        bward(1, 2) = 1;
    else
        j = str2num(X(t+1));
        bw = backward(X, t+1, model);
        bward (1, 1) = B{t+1}(1, j) * A{t+1}(1, 1) * bw(1) + B{t+1}(2, j) * A{t+1}(1, 2) * bw(2);
        bward (1, 2) = B{t+1}(1, j) * A{t+1}(2, 1) * bw(1) + B{t+1}(2, j) * A{t+1}(2, 2) * bw(2);

    end
end