a=32.8429;
b=.0041;
p=1;
pat=6;
for k=.1:.1:10
    for j=1:length(A{pat,1})
        A{pat,8}(j,1)=A{pat,1}(j,1)./k;
    end
    A{pat,8};
    for j=1:length(A{pat,8})
        A{pat,9}(j,1)=sum(A{pat,8}(1:j,1));
    end
    diff=0;
    sumdiff=0;
    for i=1:length(A{pat,9})
        diff(i)=A{pat,9}(i,1)-a*exp(b*A{pat,3}(i,1));
    end
    diff;
    sumdiff=sum(abs(diff));
    psumdiff(p)=sumdiff;
    p=p+1;
end
plot(psumdiff)
[smallest_sumdiff,ind]=min(psumdiff);
smallest_sumdiff;
ind;
best_k=ind*.1;
best_k