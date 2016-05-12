function ex4()
    M = csvread('wuerfel.csv');
    figure
    hist(M);
    figure
    Bar = bar(hist(M));
    stem(Bar.XData,Bar.YData)
    
    
    Bar = bar(hist(M));
    absValues = Bar.YData;
    relValues = absValues(1:10)/100;
    f=getCummulativeDistFkt(relValues);

    
    figure
    plot(f);
    legend('cumDistFunc');

    
    A = rollTheDice(f);
    figure
    bar(A);
    legend('After 10000 throws');
end


function f= getCummulativeDistFkt(relVals)
    sum = 0;
    f = zeros(10,1);
    for i = 1:10
        sum =sum + relVals(i);
        f(i)=sum;
    end
end

function index = findIndex(rndN,ecdf)
    index = 1;
    for i = size(ecdf):-1:1
        if ecdf(i) < rndN
            index = i+1;
            break;
        end
    end

end

function A = rollTheDice(ecdf)
    A=zeros(10,1);
    for i = 1:10000
        rndN = unifrnd(0, 1);
        index = findIndex(rndN,ecdf);
        A(index) = A(index) +1;
    end
end