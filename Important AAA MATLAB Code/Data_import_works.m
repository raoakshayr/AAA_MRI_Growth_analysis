C=noemptycells;
%k is the patient ID, ie row in our new cell array
i=1;
%i allows us to run through the aaa data
for k=1:1:8
    t=1;
    while C{i,1}==C{i+1,1}
        
        %t is the index of data in the cell of the ID column cell in the
        %new cell array
        D{k,1}(t,1)=C{i,1}(1,2);
        for j=3:16
            D{k,j}(t,1)=C{i,j}(1,1);
        end
        %for inputting all the other data
        i=i+1;
        t=t+1;
    end
    
    D{k,1}(t,1)=C{i,1}(1,2);
    for j=3:16
        D{k,j}(t,1)=C{i,j}(1,1);
    end
    %for inputting all of the other data
    %adding the ID into our new matrix and incrementing as long as ID is the
    %same
    i=i+1;
    %moving to the next set of IDs in the aaa data
    k=k+1;
    %moving to the next row in the ID column in our new cell array
end
t=1;
for t=1:1:5
    D{k,1}(t,1)=C{i,1}(1,2);
    for j=3:16
        D{k,j}(t,1)=C{i,j}(1,1);
    end
    i=i+1;
end
k=k+1;
%this handles the set of ID 9 because of transition from 9 to 10 is
%difficult to compare
for k=10:1:26
    t=1;
    while (C{i,1}==C{i+1,1} & i<=114)
        
        %t is the index of data in the cell of the ID column cell in the
        %new cell array
        D{k,1}(t,1)=C{i,1}(1,2);
        D{k,1}(t,2)=C{i,1}(1,3);
        for j=3:16
            D{k,j}(t,1)=C{i,j}(1,1);
        end
        %for inputting the other data
        i=i+1;
        t=t+1;
    end
    D{k,1}(t,1)=C{i,1}(1,2);
    D{k,1}(t,2)=C{i,1}(1,3);
    for j=3:16
        D{k,j}(t,1)=C{i,j}(1,1);
    end
    %adding the ID into our new matrix and incrementing as long as ID is the
    %same
    i=i+1;
    %moving to the next set of IDs in the aaa data
    k=k+1;
    %moving to the next row in the ID column in our new cell array
end

k=k-1;
t=t+1;
D{k,1}(t,1)=C{i,1}(1,2);
D{k,1}(t,2)=C{i,1}(1,3);
for j=3:16
    D{k,j}(t,1)=C{i,j}(1,1);
end

