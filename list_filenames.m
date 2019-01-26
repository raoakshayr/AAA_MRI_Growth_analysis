list=ls;
k=1;
for i=1:length(list)
    if isempty(strfind(list(i,:),'_T'))==0
       ind(k)=i;
       k=k+1;
    end
end

%% Patient ID
a = list(ind(1),:);
id = a;

%% Initialize variables.
filename = ['C:\Users\akshayrao\Documents\Rao Summer 17\AAA\Hamid_to_Akshay\P1819\',id,'_T.dat'];
delimiter = ' ';

formatSpec = '%f%f%f%f%f%[^\n\r]';

fileID = fopen(filename,'r');


dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN, 'ReturnOnError', false);

fclose(fileID);