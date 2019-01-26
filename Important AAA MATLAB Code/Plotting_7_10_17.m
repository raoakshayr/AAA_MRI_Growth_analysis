[l w]=size(Pint);
start=1;
last=59;
figure
for cs=start:1:last
    for i=1:w
        if isempty(Pint{cs,i})==0 & Pint{cs,i}~=0
        p(i,1:3)=Pint{cs,i}(1,1:3);
        
        scatter3(p(i,1),p(i,2),p(i,3));
        end
        axis equal
        hold on;
    end
end

scatter3(B(4:4:end-2,1),B(4:4:end-2,2),B(4:4:end-2,3));