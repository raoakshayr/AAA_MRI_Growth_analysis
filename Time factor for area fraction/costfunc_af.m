function X=costfunc(P,a,b,i,k1,k2,x)

%x(1) is the time shift and x(2) is the time factor
X=0;
for j=1:length(P{i,3})
    if(P{i,2}(1,1)>.2)
    X=X+(a*exp(b*(P{i,3}(j,1)*x(2)+x(1)))-P{i,2}(j,1)).^2+k1*(1-x(2)).^2+k2./abs(x(1));
    end
end

end