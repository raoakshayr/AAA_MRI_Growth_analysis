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
%we want to display the patient name the initial diameter and the time
%factor 
for i=1:length(A)
    B(i,1)=i;
    B(i,2)=A{i,3}(1,1);
    B(i,3)=A{i,10};
    B(i,4)=A{i,6}(1,1);
end
disp('Patient Initial Diameter Time Factor Time Constant')
disp(B)

t=0:1:200;
y=a*exp(b*t);
figure

subplot(2,1,1)
title('Max Diameter vs time')
xlabel('Time')
ylabel('Max Diameter')
hold on

plot(t,y);
for i=1:length(A)
    A{i,8}=A{i,1}*A{i,10};
end
for i=1:length(A)
    for j =1:length(A{i,8})
        A{i,9}(j,1)=sum(A{i,8}(1:j,1));
        A{i,9}(j,1)=A{i,9}(j,1)+A{i,6}(1,1);
    end
end
for i=1:length(A)
    pl=plot(A{i,6},A{i,3},'g');
    pl=plot(A{i,9},A{i,3},'r');
    legend('Master Curve','Actual plots after fitting','Compressed/Stretched')
end
%plotting the stretching and compression of the curves to understand time
%factor
subplot(2,1,2)
title('Time constant vs initial diameter')
xlabel('Time constant')
ylabel('Initial diameter')
hold on 
for i=1:length(A)
    scatter(A{i,6}(1,1),A{i,3}(1,1));
end
% plotting between the time constant and the initial diameter 
%this suggests that initial diameter depends on time constant
%time constant suggests time after which the data began to be collected for that
%patient
%the linear relationship suggests that the initial diameter varies linearly
%with the time at which we start collecting data from that patient
