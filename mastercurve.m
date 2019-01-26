patient_data;

figure;
grid on;
for i=1:length(A)
    if ( strncmpi(A{i,5},'P06',3)==1 || strncmpi(A{i,5},'P07',3)==1 || strncmpi(A{i,5},'P08',3)==1 )
        scatter(A{i,3}(:,1),A{i,2}(:,1),'Filled');
        %the maximum diameter and total volume are column matrices inside
        %the total patient data matrix 
        %this creates a scatter plot for the data points for patients 6,7
        %and 8 and fills in the circles 
        text(A{i,3}(length(A{i,3}(:,1)),1),A{i,2}(length(A{i,3}(:,1)),1),A{i,5},... 
     'HorizontalAlignment','right',...
     'FontSize',10)
%     else
% scatter(A{i,3}(:,1),A{i,2}(:,1),'Filled');
    end
hold on
plot(A{i,3}(:,1),A{i,2}(:,1),'-','linewidth',1.0);
%we plot maximum diameter vs time difference and  total volume vs time
%difference
end

for i=1:length(A)
    for j=1:length(A{i,1})
        A{i,7}(j,1)=sum(A{i,1}(1:j,1));
    end
end
% A(i,7) contains the sum of the time differences upto that point so it is the current time 
figure;
for i=1:length(A)
    A{i,6}=A{i,7};
plot(A{i,7}(:,1),A{i,3}(:,1));
%here we plot time vs time difference and maximum diamter vs time
%difference
hold on;
end
%A{i,6} contains the same as A{i,7} ie the time upto that point
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%INITIALIZATION

 for k=1:length(A{6,7})
        Time(j)=A{6,7}(k,1);
        Dmax(j)=A{6,3}(k,1);
        j=j+1;
 end
 %we save time and diameter into new matrices or vectors
% for i=1:length(A)
%     for k=1:length(A{i,6})
%         Time(j)=A{i,6}(k,1);
%         Dmax(j)=A{i,3}(k,1);
%         j=j+1;
%     end
% end

ft=fittype('exp1');
%the type of fitting curve is exponential of degree one in x
fte=fit(Time',Dmax',ft);
%we fit the time and maximum diameter onto an exponential curve
a=fte.a;
b=fte.b;
%the function is y=a*e^bx so this might be extracting the parameters
%so it is possible that after fitting the data points to an exponential of
%one degree in x we then extract the parameters a and b so that we now know
%the curve that the data fits best to. 
%how does the fit function work? what does it use as a criterion for best
%fit? how does it determine the parameters a and b for the best fitting
%exponential curve?
%WHAT DOES THIS DO?

t=0:1:max(A{6,7});
%creates a vector that increases from 1 to the maximum of the patient6's
%time. Why did he choose patient 6?
y=a*exp(b*t);
plot(t,y,'g');
%we plot the fitting curve 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MAIN
T_AVE=1000;
counter=0;
sum=1;
%the next part is the minimizing and iteration thing
while (T_AVE>=1e-16)
    %a very small number to compare with for convergence
for i=1:length(A)
    %i goes from 1 to the number of patients
Tx=fminsearch(@(T) fun1(A{i,6},A{i,3},a,b,T),10);
%fun1 has t,V,a,b,T as input parameters this doesnt match because A{i,3} is
%maximum diameter and also what is 10?
%each of these inputs are vectors, column vectors
A{i,4}=Tx;
%this is the minumum value of the function fun1 for each patient is a
%column vector having different values for each of the times for each
%patient
end

for i=1:length(A)
    %number of patients
    
    A{i,6}=A{i,6}-A{i,4};
    %we're subtracting the minimum value of the function we obtained
    %through fminsearch of fun1 from the time column for each patient
    %so we changed all the t values
    
end

% figure;
% for i=1:length(A)
% plot(A{8,6}(:,1),A{8,3}(:,1));
% hold on;
% % end

j=1;
for i=1:length(A)
    for k=1:length(A{i,6})
        Time(j)=A{i,6}(k,1);
        Dmax(j)=A{i,3}(k,1);
        j=j+1;
    end
end
%we entered the new t values into Time()
fte=fit(Time',Dmax',ft);
%fit the curve with the data having new t values
a=fte.a;
b=fte.b;
%extract the parameters a and b
t=-50:1:150;
y=a*exp(b*t);
%the new curve 
%  plot(t,y,'g');
sum=0;
for i=1:length(A)
sum=sum+(A{i,4})^2;
%sum the squares of the values for each of the Tx or minimum values
%obtained 
end
T_AVE=sqrt(sum)/length(A)
%change the value of T_AVE 
counter=counter+1
% A{6,4}
% sum=sum+1
end

res=0;

for i=1:length(A)
    %no of patients
    for j=1:length(A{i,1})
        %no of time differences
        res=abs(a*exp(b*A{i,6}(j,1))-A{i,3}(j,1))+res;
        %the differences of the diameter as predicted by the curve and the
        %actual valus of the diameter at different times for each patient
        %this is summed for all patients
    end
end

figure;
for i=1:length(A)
plot(A{i,6}(:,1),A{i,3}(:,1),'linewidth',1.0);
text(A{i,6}(length(A{i,6}(:,1)),1),A{i,3}(length(A{i,6}(:,1)),1),A{i,5},... 
     'HorizontalAlignment','right',...
     'FontSize',9)
hold on;
end
plot(t,y,'-.g','linewidth',2.0);
grid on;
residual=0;
for i=1:length(Dmax)
    Res(i)=(a*exp(b*Time(i))-Dmax(i))^2;
    residual=Res(i)+residual;
end
Sigma=var(Res)
residual=residual/Sigma^2