function [fward] = forward(X, t, model)

A = model.A;
B = model.B;

    if(t == 0)
        fward(1, 1) = 1;
        fward(1, 2) = 0;
    else
        j = str2num(X(t));
        fw = forward(X, t-1, model)*A{t};
        fward(1, 1) = fw(1)*B{t}(1, j);
        fward(1, 2) = fw(2)*B{t}(2, j);
    end
end