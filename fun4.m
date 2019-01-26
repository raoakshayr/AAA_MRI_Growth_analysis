function X=fun4(t,D,a,b,tf,A,patient)

X=0;
for i=1:length(t)
    %number of values in the time column
    for pat=1:length(A)
        for j=1:length(A{pat,1})
            A{pat,8}(j,1)=A{pat,1}(j,1)*tf;
        end
        %stretched and compressed time differences
        
        for j=1:length(A{pat,8})
            A{pat,9}(j,1)=sum(A{pat,8}(1:j,1))+A{pat,6}(1,1);
        end
        %modified time sum
    end
    
    
    X=X+(a*exp(b*(A{patient,9}(i,1)))-D(i))^2;
    %what is T? t(i) is the time sum V should be volume logically but it is
    %diameter in this case
    
end

end