function [y]=TDM_mux2(x,ns)

i=1;
[r c]=size(x);
k2=1;
k=1;
for j=1:floor(c/ns)
    
    for kk=1:ns
    y(k)=x(k2,k);
    k=k+1;
    
    end
    k2=k2+1;
    
    if k2==r+1
        k2=1;
    end
end
    