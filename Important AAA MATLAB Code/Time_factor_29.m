%D{i,5} contains the time differences in years
%D{i,7} contains the maximum diameter in mm
%P{i,1} time differences
%P{i,2} diamters
%P{i,3} sum times
%P{i,4} modified times
%P{i,5} time shifts
%P{i,6} time factors

close all

for i=1:length(D)
    T{i,1}=D{i,5}*12;
    %time differences
    T{i,2}=D{i,7};
    %diameters
end

for i=1:length(T)
    for j=1:length(T{i,1})
        T{i,3}(j,1)=sum(T{i,1}(1:j,1));
        %sum time 
    end
end

for i=1:length(T)
    plot(T{i,3},T{i,2});
    T{i,4}=T{i,3};
    hold on;
end
l=1;
%next we try to store all the different data for varying k1 and k2 calling
%it Da and the row incrementer for da is l
k1=2.9;
k2=0;
%increasing by factor of 10
while k1<=2.9
    
    %next we try to fit the exponential curve to the untouched data
    endcond(1)=2;
    for n=2:1:100
        j=1;
        for i=1:length(T)
            for k=1:length(T{i,3})
                Time(j)=T{i,4}(k,1);
                Dmax(j)=T{i,2}(k,1);
                j=j+1;
            end
        end
        
        ft=fittype('exp1');
        fte=fit(Time',Dmax',ft);
        
        a=fte.a;
        b=fte.b;
        
        t=-50:1:150;
        y=a*exp(b*t);
        %here we try to add cost fn for time shift
        x=[50 1];
        for i=1:length(T)
            X=fminsearch(@(x) costfunc(T,a,b,i,k1,k2,x),x);
            T{i,4}=(T{i,3}*X(2)+X(1));
            T{i,5}=X(1);
            T{i,6}=X(2);
        end
        tot=0;
        for i=2:length(T)
            tot=tot+(T{i,6}-T{i-1,6}).^2+(T{i,5}-T{i-1,5}).^2;
        end
        endcond(n)=sqrt(tot)/length(T);
        endcond(n)-endcond(n-1)
        
    end
    subplot (3,4,l)
    plot(t,y,'g');
    hold on;
    for i=1:length(T)
        plot(T{i,4},T{i,2});
        title(['k1 :',num2str(k1),' k2 :' num2str(k2), ' a:',num2str(a),' b:',num2str(b)]);
        xlabel('Time in months');
        ylabel('Diameter in mm');
    end
    savefig(['k1_',num2str(k1),'k2_',num2str(k1),'plots.fig']);
    
    %here we store all of the data
    hold off;
    Ma{l,1}=k1;
    Ma{l,2}=k2;
    Ma{l,3}=a;
    Ma{l,4}=b;
    for q=1:length(T)
        Ma{l,5}(q,1)=T{q,5}(1,1);
        Ma{l,6}(q,1)=T{q,6}(1,1);
    end
    res(l)=endcond(n)-endcond(n-1);
    l=l+1;
    
    k1=k1+10;
end

