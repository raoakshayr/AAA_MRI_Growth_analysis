function X=fun3(t,V,a,b,T)

X=0;
for i=1:length(t)
    
    X=X+abs(a*(t(i)-T)+b-V(i))^2;
    
end

end