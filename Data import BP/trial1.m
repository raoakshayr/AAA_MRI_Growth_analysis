%for including blood pressure
M=bp;
i=1;
for k=1:1:12
    t=1;
    while M{i,1}==M{i+1,1}
        
        %t is the index of data in the cell of the IN column cell in the
        %new cell array
        N{k,1}(t,1)=M{i,1}(1,1);
        for j=2:4
            N{k,j}(t,1)=M{i,j}(1,1);
        end
        %for inputting all the other data
        if i<64
            i=i+1;
            t=t+1;
        end
        
    end
    
    N{k,1}(t,1)=M{i,1}(1,1);
    for j=2:4
        N{k,j}(t,1)=M{i,j}(1,1);
    end
    %for inputting all of the other data
    %adding the IN into our new matrix and incrementing as long as IN is the
    %same
    i=i+1;
    %moving to the next set of INs in the aaa data
    k=k+1;
    %moving to the next row in the IN column in our new cell array
end
