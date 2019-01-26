close all
Pintx=Pint;
[l w]=size(Pintx);

for i=1:l
    %B has centerline pts
    %Pint has the surface pts
    
    for j=1:w
        if isempty(Pintx{i,j})==0
            para{i,1}(j,1)=norm(B(i*5,1:3)-Pintx{i,j});
        end
    end
end


for i=1:l
    %max dia min dia and eccentricity
    para{i,2}=2*max(para{i,1});%max dia
    para{i,3}=2*min(para{i,1});%min dia
    para{i,4}=para{i,2}/para{i,3};%eccentricity
    
    for j=1:w
        if isempty(Pintx{i,j})==0
            
            b=Pintx{i,j}-B(i,1:3); %vector from cl pt to current cs pt
            
            [azi2,ele2,r2]=cart2sph(b(1),b(2),b(3)); %spherical local coord of current pt
            
            xcs(j,1)=r2*sin(azi2); %x and y coord of  in local coord system of cs
            ycs(j,1)=r2*cos(azi2);
        end
    end
    
    k=convhull(xcs,ycs);% the containing polygon in ccw direction
    per=0;
    
    for count=1:length(k)-1
        if isempty(Pintx{i,k(count)})==0 & isempty(Pintx{i,k(count+1)})==0
            per=per+norm(Pintx{i,k(count+1)}-Pintx{i,k(count)});
        end
    end
    
    para{i,5}=per;%storing the perimeter
end

