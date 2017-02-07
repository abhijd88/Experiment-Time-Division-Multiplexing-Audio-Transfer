%% cleanup
close all;clear all;clc;

%signal conditioning and muxing for N input(s)

N=3; % number of users to add

for a=1:N
    if(N<10)
        eval(['[u' num2str(a) ' fs' num2str(a) ']=auread(''user0' num2str(a) '.au'');' ])
    else
        eval(['[u' num2str(a) ' fs' num2str(a) ']=auread(''user' num2str(a) '.au'');' ])
    end
end % loop end

ts=1/fs1; % sampling period
Ts = ts; % Slot time interval

ns = Ts/ts; %Ts/ts;

disp('before conditioning');
pause
sound(u1)
pause
sound(u2)
pause
sound(u3)

%% adjustments
for s=1:N    %TO find LENGTH
    eval(['zz'  '=u' num2str(s) ';'])
    eval(['l' num2str(s)  '=length(zz);'])
end


mm=0;

for s=1:N    % FOR MAX LENGTH
    if eval(['l' num2str(s)])>mm
        mm=eval(['l' num2str(s) ';']);
    end
    
end
m=mm;

% calculate time axis data
tm=ts*(m-1);
tx=0:ts:tm;


for s=1:N    %TO MAKE EQUAL LENGTH

    if eval(['l' num2str(s) ' <m'])
        eval(['ll' '=l' num2str(s) ';' ]);
        eval(['zz' '=u' num2str(s) ';'  ])
        eval(['uu' num2str(s)  '=zz;'])  ;
        eval(['uu' num2str(s)  '(ll+1:m)=0;']);
    else
        eval(['zz' '=u' num2str(s) ';']);
        eval(['uu' num2str(s)  '=zz;']) ;
    end
end

% disp('after conditioning');
% pause
% sound(uu1)
% sound(uu2)
% sound(uu3)

%% Combine into one matrix
for b=1:N
    eval(['u(' num2str(b) ',:)=uu' num2str(b) ';' ])
end % loop end


% Plotting: input signal
figure(1)

for i=1:N
    subplot(N,1,i)
    plot(tx,u(i,:));
    xlabel('Time(s)');
    ylabel('Amplitude');  
    if i==1
        title('User Voice Data')
    end
end

%% Processing
% Input -> [TDM] -> um
um=tdmm(u,ns);

% add noise: use either awgn or rand
umn=awgn(um,25);
% umn=um+rand(1,m);

% Plotting: TDM signal with and w/o noise
figure(2)
subplot(2,1,1)

plot(tx,um);
xlabel('Time(s)');
ylabel('Amplitude');
title('TDM signal')
subplot(2,1,2)

plot(tx,umn);
xlabel('Time(s)');
ylabel('Amplitude');
title('Signal + Noise')


disp('Hit [Enter}]to listen to the muxed sound');
pause
sound(um)

% Processing
% um -> [Demux] -> ud
ud=demux(um,ns,N);

% split demuxed signals into individual user signal
for b=1:N
    eval(['ux' num2str(b) '=ud(' num2str(b) ',:);' ]);
end % loop end

% Play the demuxed audio signals to observe changes and effect of
% parameters

% disp('Playing the demuxed user voice stream sequentially with a delay of 1second');
% 
display('press enter to hear the demuxed signal')
pause
for b=1:N
    
    eval(['sound(ux' num2str(b) ');' ])
    display('press enter to hear the demuxed signal')
    pause
    
end % loop end

% Plotting: Demuxed voice signal
figure(3)
for a=1:N
    subplot(N,1,a)
    plot(tx,ud(a,:));
    xlabel('Time(s)');
    ylabel('Amplitude'); 
    if a==1
        title('Demuxed Signal')
    end
end

