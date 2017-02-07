function [y]=demux_TDM2(x,N,ns)
L=length(x);
Ls=ceil(L/N);

k=1;
k2=1;
y=zeros(N,Ls);
for i=1:L
    

    for kk=1:ns
        y(k2,k)=x(k);
        k=k+1;
        if k==L
            break
        end


    end
    k2=k2+1;

    if k2==N+1
        k2=1;
    end


    if k==L
        break
    end

end

for i=1:N
    eval(['ud' num2str(i)  '=y(i,:)'])
end
clc
    

for i=1:N
    z=y(i,:);
    disp('Hit [Enter}]to listen to the demuxed signal ');
    pause
    sound(z)
end

