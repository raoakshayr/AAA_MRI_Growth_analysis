a=32.8429;
b=.0041;
Dev=0;
tot_dev=0;
%how well does the curve fit for patient 6 
for i=1:length(A{6,6})
    Dev(i)=(a*exp(b*A{6,6}(i,1))-A{6,3}(i,1))^2;
    tot_dev=Dev(i)+tot_dev;
end
tot_dev;
sigma_dev=(var(Dev)).^.5;
for i=1:length(A)
    A{i,8}=A{i,1};
    %new time difference
    A{i,9}=A{i,6};
    %new sum time
end

c=1;
for time_k=.1:.01:10
    %the time constant variation to allow for stretching and compression
    for j=1:length(A{6,2})
        A{6,8}(j,1)=A{6,1}(j,1)./time_k;
        %stretched/compressed time differences
        A{6,9}(j,1)=sum(A{6,8}(1:j,1));
        %adjusted time sum
    end
    p6_tot_dev(c)=0;
    p6_dev=0;
    for i=1:length(A{6,6})%sum times
        p6_dev(i)=(a*exp(b*A{6,9}(i,1))-A{6,3}(i,1))^2;
        p6_tot_dev(c)=p6_dev(i)+p6_tot_dev(c);
    end
    p6_tot_dev(c)
    p6_sigma_dev(c)=(var(p6_dev)).^.5
    
    c=c+1;
end
