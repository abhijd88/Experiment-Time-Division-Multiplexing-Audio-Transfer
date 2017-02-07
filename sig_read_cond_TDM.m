clc
clear all
%signal conditioning and muxing for 3 input

[u1 fs1 b1]=auread('guitar1.au');
[u2 fs2 b2]=auread('speech2.au');
[u3 fs3 b3]=auread('guitar2.au');
N=3;
ts=1/fs1;
Ts = ts; % Slot time interval
ns = Ts/ts;

disp('Press ENTER to hear the audio signals before conditioning');
pause
sound(u1)
disp('Press ENTER to hear the audio signals before conditioning');
pause
sound(u2)
disp('Press ENTER to hear the audio signals before conditioning');
pause
sound(u3)

% disp('Press ENTER to hear the audio signals before conditioning');
%pause 
%sound(u4)
% disp('Press ENTER to hear the audio signals before conditioning');
% sound(u5)
% disp('Press ENTER to hear the audio signals before conditioning');
% sound(u6)
% disp('Press ENTER to hear the audio signals before conditioning');
% sound(u7)
% disp('Press ENTER to hear the audio signals before conditioning');
% sound(u8)
% disp('Press ENTER to hear the audio signals before conditioning');
% sound(u9)

for s=1:N    %TO find LENGTH
    eval(['zz'  '=u' num2str(s)])
    eval(['l' num2str(s)  '=length(zz)'])
end

% m1=max(l1,l2);
% m=max(m1,l3);
mm=0;

for s=1:N    % FOR MAX LENGTH
    if eval(['l' num2str(s)])>mm
        mm=eval(['l' num2str(s)]);
    end
    
end
m=mm;

for s=1:N    %TO MAKE EQUAL LENGTH

    if eval(['l' num2str(s) ' <m;'])
        eval(['ll' '=l' num2str(s) ])

        eval(['zz' '=u' num2str(s)  ])
        eval(['uu' num2str(s)  '=zz;'])   
        for i=ll+1:m
            eval(['uu' num2str(s)  '(i)=0;'])
        end
    else
        eval(['zz' '=u' num2str(s)  ])
        eval(['uu' num2str(s)  '=zz;']) 
    end
end
clc

disp('Press ENTER to hear the audio signals before conditioning');
pause
sound(uu1)
disp('Press ENTER to hear the audio signals before conditioning');
pause
sound(uu2)
disp('Press ENTER to hear the audio signals before conditioning');
pause
sound(uu3)
% disp('Press ENTER to hear the audio signals before conditioning');
% sound(uu4)
% disp('Press ENTER to hear the audio signals before conditioning');
% sound(uu5)
% disp('Press ENTER to hear the audio signals before conditioning');
% sound(uu6)
% disp('Press ENTER to hear the audio signals before conditioning');
% sound(uu7)
% disp('Press ENTER to hear the audio signals before conditioning');
% sound(uu8)
% disp('Press ENTER to hear the audio signals before conditioning');
% sound(uu9)

for b=1:N
    eval(['u(b,:)=uu' num2str(b) ';' ])
end 


uuu=TDM_mux2(u,ns);

disp('Hit [Enter}]to listen to the muxed sound');
pause
sound(uuu)

y=demux_TDM2(uuu,N,ns);
