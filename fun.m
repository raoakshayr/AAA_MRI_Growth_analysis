function X=fun1(t,V,a,b)

X=0;
for i=1:length(t)
    
    X=X+(a*exp(b*t(i))-V(i))^2;
    
end

end