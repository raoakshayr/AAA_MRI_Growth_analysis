%clc;clear;close all;
%% Patient ID
a = 'P192';
id = a;

%% Initialize variables.
filename = ['C:\Users\akshayrao\Documents\Rao Summer 17\AAA\Hamid_to_Akshay\P1819\',id,'_T.dat'];
delimiter = ' ';

formatSpec = '%f%f%f%f%f%[^\n\r]';

fileID = fopen(filename,'r');


dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN, 'ReturnOnError', false);

fclose(fileID);

%% Create output variable
Aux = [dataArray{1:end-1}];
[l, w] = size(Aux);
Aux = reshape(Aux',w*l,1);
Aux(isnan(Aux))=[];
np = Aux(1,1);

X = Aux(3:3+np-1);
Y = Aux(3+np:3+np+np-1);
Z = Aux(3+np+np:3+np+np+np-1);

A = [X, Y, Z];

%% Obtaining mesh triangles
j=1;
for i=(2+3*np):3:(2+3*np+3*(Aux(2,1)-1))
    
    for k=i+1:1:i+3
        
        T{j,1}=j;
        T{j,2}(k-i,1:3)=A(Aux(k,1),1:3);
    end
    j=j+1;
end

%% Clear temporary variables
clearvars -except A T B id list ID;


