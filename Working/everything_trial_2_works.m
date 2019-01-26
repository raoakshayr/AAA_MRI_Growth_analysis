% %As contains projections of surface pts onto the centerline cross sections
% %index and column heading-
% 1 cl coord
% 2 all pts on cs
% 3 distances to pts on cs
% 4 coord of max dist pt 
% 5 angle theta
% 6 pt cluster 1 perpendicular to max dist vector
% 7 pt cluster 2 perpendicular to max dist vector
% 8 pt cluster 3 on opp side of max dist
% 9 mean of pts 1
% 10 mean of pts 2
% 11 minor axis
% 12 mean of pts 3
% 13 major axis
% 14 major axis approx
% 15 closest pt coord
% 16 minor axis approx
% 17 x and y coord of pts on cs
% 18 indices of boundary
% 19 perimeter
% 20 distance from cl to line joining first and last pt of cl

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

axis equal;
for i=1:length(cs_pts)
    scatter3(cs_pts{i,2}(:,1),cs_pts{i,2}(:,2),cs_pts{i,2}(:,3));
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
    cs_pts{i,14}=2*norm(cs_pts{i,4}-B(i,1:3));
    
    cs_pts{i,15}=cs_pts{i,2}(mindist_ind,:);% coordinates of closest pt
    cs_pts{i,16}=2*norm(cs_pts{i,15}-B(i,1:3));
end


for i=1:length(cs_pts)
    p=1;
    n=1;
    l=1;
    for j=1:length(cs_pts{i,2})
        a=cs_pts{i,4}(1,1:3)-B(i,1:3);% vector from cl pt to furthest pt
        b=cs_pts{i,2}(j,1:3)-B(i,1:3); %vector from cl pt to current cs pt
        
        [azi1,ele1,r1]=cart2sph(a(1),a(2),a(3)); % spherical local coord of max dist pt
        [azi2,ele2,r2]=cart2sph(b(1),b(2),b(3)); %spherical local coord of current pt
        
        theta=azi2-azi1;
 
        cs_pts{i,5}(j,1)=theta;
        cs_pts{i,17}(j,1)=r2*sin(azi2); %x and y coord of  in local coord system of cs
        cs_pts{i,17}(j,2)=r2*cos(azi2);
        
        if (abs(cos(theta))<.1 & sin(theta)>0)
            theta
            cs_pts{i,6}(p,1:3)=cs_pts{i,2}(j,1:3);
            p=p+1;
        
        
        elseif(abs(cos(theta))<.1 & sin(theta)<0)
            theta
            cs_pts{i,7}(n,1:3)=cs_pts{i,2}(j,1:3);
            n=n+1;
        
        
        elseif (cos(theta)<-.9)
            theta
            cs_pts{i,8}(l,1:3)=cs_pts{i,2}(j,1:3);
            l=l+1;
        end
        
    end
    
    if (isempty(cs_pts{i,6})==0 & isempty(cs_pts{i,7})==0)
        
        if numel(cs_pts{i,6})>3
            cs_pts{i,9}=mean(cs_pts{i,6});
        else
            cs_pts{i,9}=cs_pts{i,6};
        end
        
        if numel (cs_pts{i,7})>3
            cs_pts{i,10}=mean(cs_pts{i,7});
        else
            cs_pts{i,10}=cs_pts{i,7};
        end
        
        cs_pts{i,11}=norm(cs_pts{i,10}-cs_pts{i,9});%minor axis length
    end
    
    if (isempty(cs_pts{i,8})==0)
        if numel(cs_pts{i,8}>3)
            cs_pts{i,12}=mean(cs_pts{i,8});
        else
            cs_pts{i,12}=cs_pts{i,8};
        end
        cs_pts{i,13}=norm(cs_pts{i,4}-cs_pts{i,12});%major axis length
    end

end
% figure
% 
% scatter(cs_pts{1,17}(:,1),cs_pts{1,17}(:,2));
% hold on;

figure
for i=1:length(cs_pts)
    %if (isempty(cs_pts{i,11})==0 & isempty(cs_pts{i,13})==0)
    k=boundary(cs_pts{i,17}(:,1),cs_pts{i,17}(:,2));
    cs_pts{i,18}=k;%indices of perimeter pts
    per=0;
    for j=1:length(k)% x and y coord of perimeter pts
        x(j)=cs_pts{i,17}(k(j),1);
        y(j)=cs_pts{i,17}(k(j),2);
        if j>1
            per=per+((x(j)-x(j-1)).^2+(y(j)-y(j-1)).^2).^.5;
        else
            per=per+((x(1)-x(end)).^2+(y(1)-y(end)).^2).^.5;
        end
    end
    cs_pts{i,19}=per;
    
end
cl_length=0;
for i=1:length(B) %tortuosity by distance
    a = B(1,:) - B(end,:);
    b = B(i,:) - B(end,:);
    cs_pts{i,20} = norm(cross(a,b)) / norm(a);
    if i>1
        cl_length=cl_length+((B(i,1)-B(i-1,1)).^2+(B(i,2)-B(i-1,2)).^2+(B(i,3)-B(i-1,3)).^2).^.5;
    end
end
a_length=pdist([B(1,:);B(end,:)],'euclidean');
a_length
tort_ratio=cl_length/a_length;
tort_ratio;
for i=1:length(cs_pts)
    per(i)=cs_pts{i,19};
    if (isempty(cs_pts{i,11})==0 & isempty(cs_pts{i,13})==0 & cs_pts{i,13}/cs_pts{i,11}<5)
        ecc(i)=cs_pts{i,13}/cs_pts{i,11};
    end
    ecc_approx(i)=cs_pts{i,14}/cs_pts{i,16};
    tort_dist(i)=cs_pts{i,20};
end

ecc_clean=ecc(ecc~=0);

plot(per);
figure
plot(ecc_clean);
figure
plot(tort_dist);
figure
plot(ecc_approx);

