clear all;
clc;
close all;
%% Patient ID
lister=ls;
k=1;
m=1;
for i=1:length(lister)
    if isempty(strfind(lister(i,:),'.mat'))==0
        id_mat(k)=i;
        k=k+1;
    end
end

for counter1=48:length(id_mat)
    counter1
    filename=lister(id_mat(counter1),:);
    filename=strtrim(filename);
    load (filename);
    [l w]=size(Pint);
    Pintx=Pint;
    %%
    filename = ['C:\Users\akshayrao\Documents\Rao Summer 17\AAA\Hamid_to_Akshay\P01to14_mindia5\ct_',lister(id_mat(counter1),1:4),'.dat'];
    delimiter = ' ';
    
    %% Format string for each line of text:
    
    formatSpec = '%f%f%f%f%[^\n\r]';
    
    fileID = fopen(filename,'r');
    
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN, 'ReturnOnError', false);
    
    fclose(fileID);
    
    %% Create output variable
    ct = [dataArray{1:end-1}];
    
    B = [ct(2:ct(1,1)+1,1),ct(2:ct(1,1)+1,2),ct(2:ct(1,1)+1,3)];
    
    %%  Max min dia eccentricity and perimeter
    for i=1:l-flag
        %max dia min dia and eccentricity
        
        for j=1:w
            if isempty(Pintx{i,j})==0
                
                b=Pintx{i,j}-B(i,1:3); %vector from cl pt to current cs pt
                
                [th2,r2,z2]=cart2pol(b(1),b(2),b(3)); %spherical local coord of current pt
                
                xcs(j,1)=r2*sin(th2); %x and y coord of  in local coord system of cs
                ycs(j,1)=r2*cos(th2);
                
            end
        end
        
        k=convhull(xcs,ycs);% the containing polygon in ccw direction
        perem{i,1}(1:length(k),1)=k(:);
        perem{i,2}(1:length(xcs),1)=xcs(:,1);
        perem{i,3}(1:length(ycs),1)=ycs(:,1);
        per=0;
        
        for count=1:length(k)-1
            if isempty(Pintx{i,k(count)})==0 & isempty(Pintx{i,k(count+1)})==0
                per=per+norm(Pintx{i,k(count+1)}-Pintx{i,k(count)});
            end
        end
        para{i,5}=per;%storing the perimeter
        %finding inscribing circle for minimum diameter
        xstart=mean(xcs(:,1));
        ystart=mean(ycs(:,1));
        pt{1,1}(1,1)=xstart;
        pt{1,1}(1,2)=ystart;
        for count=1:40
            if count==1
                for pq=1:w
                    ptdist(pq)=((xstart-xcs(pq,1))^2+(ystart-ycs(pq,1))^2)^.5;
                end
            else
                for pq=1:w
                    ptdist(pq)=((pt{1,1}(1,1)-xcs(pq,1))^2+(pt{1,1}(1,2)-ycs(pq,1))^2)^.5;
                end
            end
            [mindist,minind]=min(ptdist);
            minpt{1,1}(1,1)=xcs(minind,1);
            minpt{1,1}(1,2)=ycs(minind,1);
            p{1,1}=(pt{1,1}-minpt{1,1})/norm(pt{1,1}-minpt{1,1});
            if count<30
                delta=1;
            elseif count<31
                delta=.5;
            elseif count<32
                delta=.25;
            else
                delta=.01;
            end
            pt{1,1}=pt{1,1}+p{1,1}*delta;
        end
        %for max dia and eccentricity
        for j=1:w/2
            dist(j)=para{i,1}(j*2,1)+para{i,1}(j*2-1,1);%length of each theta line
        end
        pqr=1;
        for j=1:w
            for pq=1:w
                pairdist(pqr)=norm(Pint{i,j}-Pint{i,pq});
                pqr=pqr+1;
            end
        end
        para{i,3}=mindist*2;%min dia
        para{i,2}=max(pairdist);%max dia
        para{i,4}=para{i,2}/para{i,3};%eccentricity
        
    end
    
    %% Find parameters at maximum diameter and global max of parameters
    for i=1:l-flag
        loc_maxdia(i)=para{i,2};
        loc_mindia(i)=para{i,3};
        loc_ecc(i)=para{i,4};
        loc_per(i)=para{i,5};
    end
    
    [globmaxdia,globmaxdia_ind]=max(loc_maxdia);
    [globmindia,globmindia_ind]=min(loc_mindia);
    [globmax_ecc,globmax_ecc_ind]=max(loc_ecc);
    [globmax_per,globmax_per_ind]=max(loc_per);
    maxtort_disp=max(d);
    per_maxdia=para{globmaxdia_ind,5};
    ecc_maxdia=para{globmaxdia_ind,4};
    
    
    clearvars -except lister ls counter1 id_mat list perem cl_ind globmaxdia globmindia globmax_ecc globmax_per per_maxdia ecc_maxdia tort_disp_maxdia maxtort_disp tort_cl d idcount id_s id_cl list Pint para pat_id;
    save([lister(id_mat(counter1),:)]);
end

