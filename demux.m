function y=demux(x,ns,N)

if(ns==0)
    ns=1;
else
    ns=round(ns); 
end % end if condition

r=length(x); % length of the data stream
y=zeros(N,r); % preallocation
b=1; % initialize var b
r=r-ns; % adjustment for the last data
for a=1:ns:r
        y(b,a:a+ns-1)=x(a:a+ns-1);
        b=b+1;
        
        if b>N
            b=1;
        end % end of condition
end % end of for loop
end % end of function