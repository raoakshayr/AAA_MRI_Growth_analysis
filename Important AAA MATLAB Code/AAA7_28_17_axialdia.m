
%% Patient ID
list=ls;
k=1;
m=1;
for i=1:length(list)
    if isempty(strfind(list(i,:),'.mat'))==0
        id_mat(k)=i;
        k=k+1;
    end
end

for counter1=1:length(id_mat)
    counter1
    list=ls;
    filename=list(id_mat(count),:);
    filename=strtrim(filename);
    load (filename);
    [l w]=size(Pint);
    Pintx=Pint;
    %%
    filename = ['C:\Users\akshayrao\Documents\Rao Summer 17\AAA\Hamid_to_Akshay\P01to14_mindia2\ct_',list(id_mat(count),1:4),'.dat'];
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
    save([list(id_mat(counter1),:)]);
end

