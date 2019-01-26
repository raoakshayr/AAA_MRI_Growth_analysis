
Pintx=Pint;
[l w]=size(Pintx);

for i=5:l
    %B has centerline pts
    %Pint has the surface pts
    for j=1:w
        if isempty(Pintx{i,j})==0
            para{i,1}(j,1)=norm(B(i,1:3)-Pintx{i,j});
        end
    end
end


for i=1:l
    %max dia min dia and eccentricity
    para{i,2}=2*max(para{i,1});
    para{i,3}=2*min(para{i,1});
    para{i,4}=para{i,2}/para{i,3};
    
    per=0;
    for count=1:length(k)-1
       per=per+norm(Pintx{i,j}-Pintx{i,k(count)}); 
    end
    per
    
end