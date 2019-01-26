P=D;

for i=1: length(P)
    for j=1:length(P{i,5})
        P{i,5}(j,1)=sum(D{i,5}(1:j,1));
    end
end