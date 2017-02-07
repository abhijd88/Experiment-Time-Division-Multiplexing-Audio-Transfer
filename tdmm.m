function [y]=tdmm(x,ns)
if(ns==0)
    ns=1;
else
    ns=round(ns);
end % end if condition

[r c]=size(x); % determine dimension
y=zeros(1,c); % preallocate matrix
i=1; % initialize var i
c1=c-ns; % adjustment for the last data
for j=1:ns:c1
    y(j:j+ns-1)=x(i,j:j+ns-1);
    i=i+1;
    
    if i>r
        i=1;
    end % end of if condition
end % end of for loop
end % end of function