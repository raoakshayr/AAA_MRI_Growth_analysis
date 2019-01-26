function X=fun2(t,V,a,b,T)

X=0;
for i=1:length(t)
    
    X=X+((a*(1+b/100)^((t(i)-T)/12))-V(i))^2;
    
end

end