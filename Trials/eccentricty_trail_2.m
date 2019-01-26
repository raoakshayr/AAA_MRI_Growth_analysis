% %As contains projections of surface pts onto the centerline cross sections
% %index and column heading-
% 1 cl coord
% 2 all pts on cs
% 3 distances to pts on cs
% 4 coord of max dist pt 
% 5 pt cluster 1 perpendicular to max dist vector
% 6 pt cluster 2 perpendicular to max dist vector
% 7 mean of pt cluster 1
% 8 mean of pt cluster 2
% 9 distance between means 1 and 2
% 10 pt cluster 3 on opp side of max dist
% 11 mean of pt cluster 3
% 12 major axis length cluster 3 to max dist pt
% 13 max dist *2
% 14 coord of closest pt
% 15 min dist *2

close all;
[max_sd,ind]=max(Ds);
ind;
B(ind,:);
for i=1:length(B)
    a = B(1,:) - B(end,:);
    b = B(i,:) - B(end,:);
    d(i) = norm(cross(a,b)) / norm(a);
end
[max_tort,indb]=max(d)
%plot (d);

for i=1:length(B)
    k=1;
    for j=1:length(As)-3
        if As(j,4)==i
            cs_pts{i,2}(k,1:3)=As(j,1:3);% all pts lying on a particular centerline cross section
            cs_pts{i,1}=B(i,:); %centerline pt
            k=k+1;
        end
    end
end

%axis equal;
for i=1:length(cs_pts)
    %scatter3(cs_pts{i,2}(:,1),cs_pts{i,2}(:,2),cs_pts{i,2}(:,3));
    hold on;
end

for i=1:length(cs_pts)
    for j=1:length(cs_pts{i,2})
        %cs_pts{i,3}=pdist([B(i);cs_pts{i,2}(j,1:3)],'euclidean'); %distance bw centerline pt and surface pt projection
        cs_pts{i,3}(j,1)=norm(B(i,1:3)-cs_pts{i,2}(j,1:3));%calculate distances to pts on cs
    end
    [max_dist,maxdist_ind]=max(cs_pts{i,3});% index of furthest pt
    [min_dist,mindist_ind]=min(cs_pts{i,3});% index of closest pt
    cs_pts{i,4}=cs_pts{i,2}(maxdist_ind,:);% coordinates of furthest pt
    cs_pts{i,13}=2*norm(cs_pts{i,4}-B(i,1:3));
    
    cs_pts{i,14}=cs_pts{i,2}(mindist_ind,:);% coordinates of closest pt
    cs_pts{i,15}=2*norm(cs_pts{i,14}-B(i,1:3));
end


for i=1:length(cs_pts)
    p=1;
    n=1;
    l=1;
    for j=1:length(cs_pts{i,2})
        a=cs_pts{i,4}(1,1:3)-B(i,1:3);% vector from cl pt to furthest pt
        b=cs_pts{i,2}(j,1:3)-B(i,1:3); %vector from cl pt to current cs pt
        
        if ((abs(dot(a,b))/(norm(a)*norm(b)))<.1 & dot(a,b)>0) %pts which are perpendicular to furthest pt vector and lie to one side
            cs_pts{i,5}(p,1:3)=cs_pts{i,2}(j,1:3);
            p=p+1;
        end
        
        if ((abs(dot(a,b))/(norm(a)*norm(b)))<.1 & dot(a,b)<0) %pts which are perpendicular to furthest pt vector and lie to one side
            cs_pts{i,6}(n,1:3)=cs_pts{i,2}(j,1:3);
            n=n+1;
        end
        
        if (((dot(a,b))/(norm(a)*norm(b)))<-.8) %pts which are on the other side of the major axis
            cs_pts{i,10}(l,1:3)=cs_pts{i,2}(j,1:3);
            l=l+1;
        end
    end 
    
    if (isempty(cs_pts{i,5})==0 & isempty(cs_pts{i,6})==0)
        
        cs_pts{i,7}=mean(cs_pts{i,5});
        
        cs_pts{i,8}=mean(cs_pts{i,6});
        
        cs_pts{i,9}=norm(cs_pts{i,8}-cs_pts{i,7});%minor axis length
    end
    
    if (cs_pts{i,10}~=0)
        cs_pts{i,11}=mean(cs_pts{i,10});
        
        cs_pts{i,11}=cs_pts{i,10};
        
        cs_pts{i,12}=norm(cs_pts{i,4}(1,1:3)-cs_pts{i,11}(1,1:3));%major axis length
        
    else
        cs_pts{i,12}=0;
    end
    
    
end

% a=N(i,1:3);
% b=cs_pts{i,4}(1,1:3)-B(i,1:3);
% costheta = dot(a,b)/(norm(a)*norm(b));
% theta = acos(costheta);
% cs_pts{i,5}=theta;
% dot(a,b)
% 
%clear cs_pts;