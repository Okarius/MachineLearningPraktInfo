model = createHmm();
X = '11111'
t = 1

fward = forward(X, t, model);
bward = backward(X, t, model);
