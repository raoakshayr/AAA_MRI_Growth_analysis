
% k=1;
scan_no=1;
tot=0;
for pat=1:14
    pat
    close all;
    clearvars -except par P pat D scan_no tot;
%     for i=1:length(P{pat,5})
%         time(i)=P{pat,5}(i,1);
%     end
    scans=length(P{pat,5});
    tot=tot+scans;
    for i=1:scans
        i
        %     if i==1
        %         s(k)=load(['P02',num2str(i),'.mat']);
        %         k=k+1;
        %     end
        %     if i==2
        %         s(k)=load(['P02',num2str(i),'.mat']);
        %         k=k+1;
        %     end
        %     if i==3
        %         s(k)=load(['P',num2str(i),'.mat']);
        %         k=k+1;
        %     end
        % %
        % %     if i==5
        % %         s(k)=load(['P23',num2str(i),'.mat']);
        % %         k=k+1;
        % %     end
        %
        % if i==5
        if pat<10
            s{i}=load(['P0',num2str(pat),num2str(i),'.mat']);
        else
            s{i}=load(['P',num2str(pat),num2str(i),'.mat']);
        end
        %         k=k+1;
        %     end
    end
    
    for i=1:scans
        y(i,1)=s{i}.ecc_maxdia;
        
        y(i,2)=s{i}.globmax_ecc;
        
        y(i,3)=s{i}.globmax_per;
        
        y(i,4)=s{i}.globmaxdia;
        
        %y(i,5)=s(i).globmindia;
        
        y(i,6)=s{i}.per_maxdia;
        
        y(i,7)=s{i}.tort_cl;
        
        y(i,8)=s{i}.tort_disp_maxdia;
        
    end
    
    i=1;
    par{i,1}='Patient and Scan No.';
    
    par{i,2}='ecc_maxdia';
    
    par{i,3}='globmax_ecc';
    
    par{i,4}='globmax_per';
    
    par{i,5}='globmaxdia';
    
    %par{i,6}='globmindia';
    
    par{i,7}='per_maxdia';
    
    par{i,8}='tort_cl';
    
    par{i,9}='tort_disp_maxdia';
    
    for i=1:scans
        for j=1:8
            par{scan_no+i,j+1}(1,1)=y(i,j);
            par{scan_no+i,1}=['P',num2str(pat),num2str(i)];
        end
    end
    scan_no=scan_no+scans;
    
    
%     figure;
%     plot(time,y(:,1));
%     xlabel('Time in years');
%     ylabel('ecc maxdia');
%     title(['P ',num2str(pat),' Eccentricity at Max Dia vs Time']);
%     print(['P',num2str(pat),' Eccentricity at Max Dia vs Time'],'-dpng');
%     
%     figure
%     plot(time,y(:,2));
%     xlabel('Time in years');
%     ylabel('globmax ecc');
%     title(['P ',num2str(pat),' Max Eccentricity vs Time']);
%     print(['P',num2str(pat),'Max Eccentricity vs Time'],'-dpng');
%     
%     figure
%     plot(time,y(:,3));
%     xlabel('Time in years');
%     ylabel('globmax per');
%     title(['P ',num2str(pat),' Max Perimeter vs Time']);
%     print(['P',num2str(pat),'Max Perimeter vs Time'],'-dpng');
%     
%     figure
%     plot(time,y(:,4));
%     xlabel('Time in years');
%     ylabel('globmaxdia');
%     title(['P ',num2str(pat),' Max Diameter vs Time']);
%     print(['P',num2str(pat),'Max Diameter vs Time'],'-dpng');
%     
%     figure
%     plot(time,y(:,5));
%     xlabel('Time in years');
%     ylabel('globmindia');
%     title(['P ',num2str(pat),' Minimum Diameter vs Time']);
%     print(['P',num2str(pat),'Minimum Diameter vs Time'],'-dpng');
%     
%     figure
%     plot(time,y(:,6));
%     xlabel('Time in years');
%     ylabel('per maxdia');
%     title(['P ',num2str(pat),' Perimeter at Max Diameter vs Time']);
%     print(['P',num2str(pat),'Perimeter at Max Diameter vs Time'],'-dpng');
%     
%     figure
%     plot(time,y(:,7));
%     xlabel('Time in years');
%     ylabel('tort cl');
%     title(['P ',num2str(pat),' Centerline Tortuosity vs Time']);
%     print(['P',num2str(pat),'Centerline Tortuosity vs Time'],'-dpng');
%     
%     figure
%     plot(time,y(:,8));
%     xlabel('Time in years');
%     ylabel('tort disp maxdia');
%     title(['P ',num2str(pat),' Max Centerline Displacement vs Time']);
%     print(['P',num2str(pat),'Max Centerline Displacement vs Time'],'-dpng');
end

filename='Parameters_3';
xlswrite(filename,par,'Newparameters','B2');
