X=[0 1 0];
m=1;
P1=cross(N(m,1:3),X); %vector lying on cross section
k=1;
%%
for theta=2*pi/10:2*pi/10:2*pi
    
    Pn=P1*cos(theta) + cross(N(m,1:3),P1)*sin(theta)+ N(m,1:3)*dot(N(m,1:3),P1)*(1-cos(theta));%%find increment vector
    P0=B(1,1:3);
    Dcs=N(m,1)*B(m,1)+N(m,2)*B(m,2)+N(m,3)*B(m,3);
    
    ntri=1;
    tic
    
    
    for i=1:length(T)  
%% define the plane of the triangle
        A=T{i,2}(1,1:3);
        E=T{i,2}(2,1:3);
        C=T{i,2}(3,1:3);
        
        k1=N(m,1)*A(1)+N(m,2)*A(2)+N(m,3)*A(3)-Dcs;
        k2=N(m,1)*E(1)+N(m,2)*E(2)+N(m,3)*E(3)-Dcs;
        k3=N(m,1)*C(1)+N(m,2)*C(2)+N(m,3)*C(3)-Dcs;
        
        if(k1*k2<0 | k2*k3<0 | k1*k3<0)
        
            ntri=ntri+1;
            Nt=cross(A-E,A-C);
            
            Dtr=Nt(1)*A(1)+Nt(2)*A(2)+Nt(3)*A(3);
            
 %%           %%
            %find the point of intersection
            t=(Dtr-(Nt(1)*P0(1)+Nt(2)*P0(2)+Nt(3)*P0(3)))/(Nt(1)*Pn(1)+Nt(2)*Pn(2)+Nt(3)*Pn(3));
            
%%            %%% does pt lie withing the triangle
            Pi=P0+t*Pn;
            v2=Pi-A;
            v0=C-A;
            v1=E-A;
            u =(dot(v1,v1)*dot(v2,v0)-dot(v1,v0)*dot(v2,v1))/(dot(v0,v0)*dot(v1,v1)-dot(v0,v1)*dot(v1,v0));
            v =(dot(v0,v0)*dot(v2,v1)-dot(v0,v1)*dot(v2,v0))/(dot(v0,v0)*dot(v1,v1)-dot(v0,v1)*dot(v1,v0));
            
            if u>=0 & v>=0 &u+v<=1
                tri(k)=T(i,1);
                k=k+1;
                %%store the point of intersection also
            end
        end
    end
    toc
end
