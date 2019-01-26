a=32.8429;
b=.0041;
C=A;
for pat=1:length(C)
    p=1;
    for k=.1:.1:20
        for j=1:length(C{pat,1})
            C{pat,8}(j,1)=C{pat,1}(j,1)*k;
        end
        C{pat,8};
        for j=1:length(C{pat,8})
            C{pat,9}(j,1)=sum(C{pat,8}(1:j,1));
            C{pat,9}(j,1)=C{pat,9}(j,1)+C{pat,6}(1,1);
        end
        diff=0;
        sumdiff=0;
        for i=1:length(C{pat,9})
            diff(i)=C{pat,3}(i,1)-a*exp(b*C{pat,9}(i,1));
        end
        diff;
        sumdiff=sum(abs(diff));
        psumdiff(p)=sumdiff;
        p=p+1;
    end
    [smallest_sumdiff,ind]=min(psumdiff);
    best_k=ind*.1;
    C{pat,10}=best_k;
end

t=0:1:200;
y=a*exp(b*t);
figure

title('Max Diameter vs time')
xlabel('Time')
ylabel('Max Diameter')
hold on

plot(t,y);
for i=1:length(C)
    C{i,8}=C{i,1}*C{i,10};
end
for i=1:length(C)
    for j =1:length(C{i,8})
        C{i,9}(j,1)=sum(C{i,8}(1:j,1));
        C{i,9}(j,1)=C{i,9}(j,1)+C{i,6}(1,1);
    end
end
for i=1:length(C)
    pl=plot(C{i,6},C{i,3},'g');
    pl=plot(C{i,9},C{i,3},'r');
    legend('Master Curve','Cctual plots after fitting','Compressed/Stretched')
end
%plotting the stretching and compression of the curves to understand time
%factor
figure
title('Time constant vs initial diameter')
xlabel('Time constant')
ylabel('Initial diameter')
hold on 

for i=1:length(C)
    scatter(C{i,6}(1,1),C{i,3}(1,1));
end

% plotting between the time constant and the initial diameter 
%this suggests that initial diameter depends on time constant
%time constant suggests time after which the data began to be collected for that
%patient
%the linear relationship suggests that the initial diameter varies linearly
%with the time at which we start collecting data from that patient

%probably we can see if the slope is higher for higher initial diameters

%average slope for the patient

for j=1:length(C)
    slopesum=0;
    for i=1:length(C{j,3})-1
        slopesum=slopesum+(C{j,3}(i+1,1)-C{j,3}(i,1))./C{j,1}(i+1,1);
    end
    slopeavg=slopesum./(length(C{j,3})-1);
    C{j,11}=slopeavg;
end

%we want to display the patient name the initial diameter and the time
%factor 
for i=1:length(C)
    B(i,1)=i;
    B(i,2)=C{i,3}(1,1);
    B(i,3)=C{i,10};
    B(i,4)=C{i,6}(1,1);
    B(i,5)=C{i,11};
end
disp('Patient|Initial Diameter|Time Factor|Time Constant|Slope')
disp(B)

figure
title('Cverage Slope vs Time Constant')
xlabel('Time constant')
ylabel('Cverage Slope')
hold on 

for i=1:length(C)
    scatter(C{i,6}(1,1),C{i,11}(1,1));
end

R=corrcoef(B);
R

%corelation coefficient suggests strong correlation between initial
%diameter and time constant and also a good correlation between slope and
%time factor