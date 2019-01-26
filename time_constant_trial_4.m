a=32.8429;
b=.0041;
for pat=1:length(A)
    p=1;
    for k=.1:.1:20
        for j=1:length(A{pat,1})
            A{pat,8}(j,1)=A{pat,1}(j,1)*k;
        end
        A{pat,8};
        for j=1:length(A{pat,8})
            A{pat,9}(j,1)=sum(A{pat,8}(1:j,1));
            A{pat,9}(j,1)=A{pat,9}(j,1)+A{pat,6}(1,1);
        end
        diff=0;
        sumdiff=0;
        for i=1:length(A{pat,9})
            diff(i)=A{pat,3}(i,1)-a*exp(b*A{pat,9}(i,1));
        end
        diff;
        sumdiff=sum(abs(diff));
        psumdiff(p)=sumdiff;
        p=p+1;
    end
    [smallest_sumdiff,ind]=min(psumdiff);
    best_k=ind*.1;
    A{pat,10}=best_k;
end
for i=1:length(A)
    disp(i);
    disp(A{i,10});
end