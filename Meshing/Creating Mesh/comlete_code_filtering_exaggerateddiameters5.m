clc;%clear;
close all;

%% Patient ID
list=ls;
k=1;
m=1;
for i=1:length(list)
    if isempty(strfind(list(i,:),'_T'))==0
        if isempty(strfind(list(i,:),'P23'))==0
            id_s(k)=i;
            k=k+1;
        end
    end
    if isempty(strfind(list(i,:),'ct_P23'))==0
        id_cl(m)=i;
        m=m+1;
    end
end

for idcount=2:2%length(id_cl)
    
    
   
    %% Patient ID
    a = strtrim(list(id_s(idcount),:)); %surface plot file
    pat_id=a;
    b=strtrim(list(id_cl(idcount),:)); %centerline plot
    %% Initialize variables.
    filename = ['C:\Users\akshayrao\Documents\Rao Summer 17\AAA\Hamid_to_Akshay\P1819\',a];
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
    
    %% Clear temporary variables
    % clearvars -except a m b A id_s id_cl list ID np Aux;
    
    
    %% Centerline
    filename = ['C:\Users\akshayrao\Documents\Rao Summer 17\AAA\Hamid_to_Akshay\P1819\',b];
    delimiter = ' ';
    
    %% Format string for each line of text:
    
    formatSpec = '%f%f%f%f%[^\n\r]';
    
    fileID = fopen(filename,'r');
    
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN, 'ReturnOnError', false);
    
    fclose(fileID);
    
    %% Create output variable
    ct = [dataArray{1:end-1}];
    
    B = [ct(2:ct(1,1)+1,1),ct(2:ct(1,1)+1,2),ct(2:ct(1,1)+1,3)];
    %% Obtaining mesh triangles
    j=1;
    for i=(2+3*np):3:(2+3*np+3*(Aux(2,1)-1))
        
        for k=i+1:1:i+3
            
            T{j,1}=j;
            T{j,2}(k-i,1:3)=A(Aux(k,1),1:3);
        end
        j=j+1;
    end
    
    %% Finding Tangent to Centerline
    
    N = 0*B;
    
    for k = 1:length(B)
        if k==1
            N(k,:) = -3/2*B(k,:) + 2*B(k+1,:) - 1/2*B(k+2,:);
        elseif k==length(B)
            N(k,:) = +1/2*B(k-2,:) - 2*B(k-1,:) + 3/2*B(k,:);
        else
            N(k,:) = 1/2*B(k+1,:) - 1/2*B(k-1,:);
        end
    end
    
    
    
    %% Clear temporary variables
    clearvars -except a idcount id_s id_cl B T list ID N pat_id;
    % save([a(1:4),'.mat']);
  
    %% Finding mesh intersection pts
    X=[0 1 0];
    cl_count=1;
    pint_ind=1; %index for storing pts of intersection
    change=0;
    counter=0; %for filtering out big changes
    for m=4:4:(length(B)-mod(length(B),4)) %index for moving through points of Center line
        
        k=1;%index for p int in the CS
        tic
        P1=cross(N(m,1:3),X); %vector lying on cross section
        
        pt_counter=0;
        trflag=0;
        for theta=2*pi/20:2*pi/20:2*pi
            triflag=0;
            Pn=P1*cos(theta) + cross(N(m,1:3),P1)*sin(theta)+ N(m,1:3)*dot(N(m,1:3),P1)*(1-cos(theta));%%find increment vector
            P0=B(m,1:3);
            Dcs=N(m,1)*B(m,1)+N(m,2)*B(m,2)+N(m,3)*B(m,3);
            
            ntri=0;%number of triangles the line passes through
            
            
            for i=1:length(T)
                %define the plane of the triangle
                D=T{i,2}(1,1:3);
                E=T{i,2}(2,1:3);
                C=T{i,2}(3,1:3);
                
                k1=N(m,1)*D(1)+N(m,2)*D(2)+N(m,3)*D(3)-Dcs;
                k2=N(m,1)*E(1)+N(m,2)*E(2)+N(m,3)*E(3)-Dcs;
                k3=N(m,1)*C(1)+N(m,2)*C(2)+N(m,3)*C(3)-Dcs;
                
                if(k1*k2<0 | k2*k3<0 | k1*k3<0)
                    
                    
                    Nt=cross(D-E,D-C);
                    
                    Dtr=Nt(1)*D(1)+Nt(2)*D(2)+Nt(3)*D(3);
                    
                    
                    %find the point of intersection
                    t=(Dtr-(Nt(1)*P0(1)+Nt(2)*P0(2)+Nt(3)*P0(3)))/(Nt(1)*Pn(1)+Nt(2)*Pn(2)+Nt(3)*Pn(3));
                    
                    %%% does pt lie withing the triangle
                    Pi=P0+t*Pn;
                    v2=Pi-D;
                    v0=C-D;
                    v1=E-D;
                    u =(dot(v1,v1)*dot(v2,v0)-dot(v1,v0)*dot(v2,v1))/(dot(v0,v0)*dot(v1,v1)-dot(v0,v1)*dot(v1,v0));
                    v =(dot(v0,v0)*dot(v2,v1)-dot(v0,v1)*dot(v2,v0))/(dot(v0,v0)*dot(v1,v1)-dot(v0,v1)*dot(v1,v0));
                    
                    if u>=0 & v>=0 &u+v<=1
                        tri{m/4,k}=T{i,1}(1,1);%storing the index of the triangle which intersects and lies on either side of the cross section
                        if(pt_counter<40)
                            Pint{pint_ind,k}=Pi;
                        end
                        k=k+1;
                        pt_counter=pt_counter+1;
                        %%store the point of intersection also
                        ntri=ntri+1;
                    end
                end
            end
            
        end
        if ntri==1
            triflag=1;
        end
        pint_ind
        
        [l w]=size(Pint);
        if pint_ind>1 & pt_counter==40
            counter=counter+1;
            for j=1:w
                if isempty(Pint{pint_ind,j})==0
                    pt_dist(j)=norm(B(m,1:3)-Pint{pint_ind,j});
                end
            end
            pt_dist_max(pint_ind)=max(pt_dist);
            para{pint_ind,6}=pt_dist_max(pint_ind);
            %compare max distance of current section that we're looking it with the most recent one that we stored
            if counter>1
                change=abs((pt_dist_max(pint_ind)-pt_dist_max(pint_ind-1))/pt_dist_max(pint_ind-1))
                
            else
                change=.05;
            end
            pt_dist_max(pint_ind-1)
        end
        %avoiding situations where CS passes mesh at extra places
        pt_counter
        change
        if pt_counter==40 & change<.25 & triflag==0%only include CS if the number of pts is 40 or less
            pint_ind=pint_ind+1;
            cl_ind(cl_count)=m;
            cl_count=cl_count+1;
        end
        toc
        m/4
        (length(B)-mod(length(B),4))/4
    end
    %% Cleaning last scan
    [l w]=size(Pint);
    flag=0;
    if change>=.2
        for i=1:w
            Pint{end,i}=[];
        end
        flag=1;
    end
    %% Plotting the mesh
    figure
    for k=1:l
        for i=1:w
            %scatter3(T{tri{m,i},3}(1,1),T{tri{m,i},3}(1,2),T{tri{m,i},3}(1,3));
            if isempty(Pint{k,i})==0
                scatter3(Pint{k,i}(1,1),Pint{k,i}(1,2),Pint{k,i}(1,3));
                hold on;
            end
        end
    end
    axis equal;
    %% Eccentricity perimeter max min dia and tortuousity
    Pintx=Pint;
    [l w]=size(Pintx);
    %% Distances to pts on cs
    for i=1:l
        %B has centerline pts
        %Pint has the surface pts
        
        for j=1:w
            if isempty(Pintx{i,j})==0
                para{i,1}(j,1)=norm(B(cl_ind(i),1:3)-Pintx{i,j});
            end
        end
    end
    
    %%  Max min dia eccentricity and perimeter
    for i=1:l-flag
        %max dia min dia and eccentricity
%         [max1,max1_ind]=max(para{i,1});
% %         if mod(max1_ind,2)==0
% %             max2_ind=max1_ind-1;
% %             
% %         else
% %             max2_ind=max1_ind+1;
% %         end
%         
%         para{i,2}=para{i,1}(max1_ind,1)+para{i,1}(max2_ind,1);%max dia
%         
%         
%         [min1,min1_ind]=min(para{i,1});
%         if mod(min1_ind,2)==0
%             min2_ind=min1_ind-1;
%             
%         else
%             min2_ind=min1_ind+1;
%         end
%         
%         para{i,3}=para{i,1}(min1_ind,1)+para{i,1}(min2_ind,1);%min dia
%         
%         para{i,4}=para{i,2}/para{i,3};%eccentricity
        
        for j=1:w
            if isempty(Pintx{i,j})==0
                
                b=Pintx{i,j}-B(i,1:3); %vector from cl pt to current cs pt
                
                [azi2(j),ele2,r2(j)]=cart2sph(b(1),b(2),b(3)); %spherical local coord of current pt
                
                xcs(j,1)=r2(j)*sin(azi2(j)); %x and y coord of  in local coord system of cs
                ycs(j,1)=r2(j)*cos(azi2(j));
            end
        end
        %finding max dia and min dia
        [maxdist,maxdist_ind]=max(para{i,1});
        for j=1:w
            if abs(azi2(maxdist_ind)-azi2(j))==pi
                para{i,2}=((xcs(j,1)-xcs(maxdist_ind,1)).^2+(ycs(j,1)-ycs(maxdist_ind,1)).^2).^.5
            end
        end
        
        k=convhull(xcs,ycs);% the containing polygon in ccw direction
        per=0;
        
        for count=1:length(k)-1
            if isempty(Pintx{i,k(count)})==0 & isempty(Pintx{i,k(count+1)})==0
                per=per+norm(Pintx{i,k(count+1)}-Pintx{i,k(count)});
            end
        end
        
        para{i,5}=per;%storing the perimeter
    end
    
    %% tortuosity
    cl_length=0;
    for i=1:length(B)
        a = B(1,:) - B(end,:);
        b = B(i,:) - B(end,:);
        d(i) = norm(cross(a,b))/norm(a);
        if i<length(B)
            cl_length=cl_length+norm(B(i+1,:)-B(i,:));
        end
    end
    [max_tort,indb]=max(d);
    figure
    %plot (d);
    tort_cl=cl_length/norm(a);
    %% Find parameters at maximum diameter and global max of parameters
    for i=1:l
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
    tort_disp_maxdia=d(globmaxdia_ind*4);
    
    %% Save to file
    
    clearvars -except globmaxdia globmindia globmax_ecc globmax_per per_maxdia ecc_maxdia tort_disp_maxdia maxtort_disp tort_cl d idcount id_s id_cl list Pint para pat_id;
    save([pat_id(1:4),'.mat']);
    idcount=idcount+1;
end
