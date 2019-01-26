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
figure
plot (d);

for i=1:length(B)
    k=1;
    for j=1:length(As)-3
        if As(j,4)==i
            maxsd_pts{i,2}(k,1:3)=As(j,1:3);% all pts lying on a particular centerline cross section
            maxsd_pts{i,1}=i; %index of cross section of centerline
            k=k+1;
        end
    end
end

axis equal;
for i=1:length(maxsd_pts)
    scatter3(maxsd_pts{i,2}(:,1),maxsd_pts{i,2}(:,2),maxsd_pts{i,2}(:,3));
    hold on;
end
%clear maxsd_pts;

