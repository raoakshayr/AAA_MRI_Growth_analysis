%D{i,5} contains the time differences in years
%D{i,7} contains the maximum diameter in mm
%P{i,1} time differences
%P{i,2} diameters
%P{i,3} sum times
%P{i,4} time shifts
%P{i,5} time factors
%P{i,6} modified time sums

for i=1:length(D)
    P{i,1}=D{i,5};
    %time differences
    P{i,2}=D{i,7};
    %diameters
end

for i=1:length(P)
    for j=1:length(P{i,1})
        P{i,3}(j,1)=sum(P{i,1}(1:j,1));
        %sum time 
    end
    P{i,6}=P{i,3};
    %time sums to manipulate
end
%initial plot
% for i=1:length(P)
%     plot(P{i,3},P{i,2});
%     hold on;
% end

%next we try to fit the exponential curve to the untouched data

for n=1:5
    j=1;
    
    for i=1:length(P)
        for k=1:length(P{i,3})
            Time(j)=P{i,3}(k,1);
            Dmax(j)=P{i,2}(k,1);
            j=j+1;
        end
    end
    ft=fittype('exp1');
    fte=fit(Time',Dmax',ft);
    
    a=fte.a;
    b=fte.b;
    
    t=-50:1:150;
    y=a*exp(b*t);
    
    %plot(t,y,'g');
    hold on;
    %here we try to add cost fn for time shift
    
    x=[50 1];
    k1=0;
    k2=100;
    
    for i=1:length(P)
        X=fminsearch(@(x) costfn(P,a,b,i,k1,k2,x),x);
        P{i,4}=X(1);
        %time shifts in this iteration
        P{i,5}=X(2);
        %time factor
    end
    
    %now let us obtain the modified data
    for i=1:length(P)
        P{i,7}=(P{i,3}+P{i,4})*P{i,5};
        %modified time sum for each iteration 
        P{i,6}=P{i,7};
        %time sum that we work with
    end
end
%now plot the modified plots
plot(t,y,'g');
hold on;

for i=1:length(P)
    plot(P{i,6},P{i,2});
end

