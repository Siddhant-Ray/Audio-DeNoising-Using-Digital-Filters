%%%Importing the audiofiles and mixing to simulate noise corruption

%%Train noise

[x,Fs1]= audioread('train.m4a');
player_x=audioplayer(x,Fs1);
figure
plot(x,'r')

figure 
x1=abs(fft(x));
f1=(Fs1/2)*linspace(0,1,length(x1)/2);
plot(f1,x1(1:length(x1)/2),'m')
grid;
xlim([0 10^5])
hold on;

%%Human voice

[y,Fs2]= audioread('v1.mp3');
player_y=audioplayer(y,Fs2);
figure
plot(y,'n')


figure 
y1=abs(fft(y));
f2=(Fs2/2)*linspace(0,1,length(y1)/2);
plot(f2,y1(1:length(y1)/2),'c')
grid;
xlim([0 10^5])


%%Combination of the sounds

l=min(length(x),length(y));
s=x(1:1)+y(1:1);
player_s=audioplayer(s,Fs1);
figure
plot(s,'r')
title('Track Combination');

z=abs(fft(s));
f3=(Fs1/2)*linspace(0,1,length(z)/2);
plot(f3,z(1:length(z)/2),'c')
grid;
title('Combination Spectrum');

%%% Sequential filter design 

%%Notch filter

%notch filter 1

fs=44100;  %sampling rate
f0=1347.95; %notch frequency
fn=fs/2; %Nyquist frequency
freqRatio=f0/fn; %ratio of notch freq. to Nyquist freq

notchWidth=0.1; %width of the notch 

%compute zeros
notchZeros=[exp(sqrt(-1)*pi*freqRatio),exp(-sqrt(-1)*pi*freqRatio)];

%compute poles
notchPoles=(1-notchWidth)*notchZeros;

%figure
%zplane(notchZeros.',notchPoles.');

b=poly(notchZeros); %Get moving average filter coefficients
a=poly(notchPoles); %Get autoregressive filter coefficients

figure;
freqz(b,a,32000,fs)

%filter signal s
s1=filter(b,a,s);


%notch filter 2

fs=44100;  %sampling rate
f0=1011.75; %notch frequency
fn=fs/2; %Nyquist frequency
freqRatio=f0/fn; %ratio of notch freq. to Nyquist freq

notchWidth=0.1; %width of the notch 

%compute zeros
notchZeros=[exp(sqrt(-1)*pi*freqRatio),exp(-sqrt(-1)*pi*freqRatio)];

%compute poles
notchPoles=(1-notchWidth)*notchZeros;

%figure
%zplane(notchZeros.',notchPoles.');

b=poly(notchZeros); %Get moving average filter coefficients
a=poly(notchPoles); %Get autoregressive filter coefficients

figure;
freqz(b,a,32000,fs)

%filter signal s1
s2=filter(b,a,s1);


%notch filter 3

fs=44100;  %sampling rate
f0=2021.75; %notch frequency
fn=fs/2; %Nyquist frequency
freqRatio=f0/fn; %ratio of notch freq. to Nyquist freq

notchWidth=0.1; %width of the notch 

%compute zeros
notchZeros=[exp(sqrt(-1)*pi*freqRatio),exp(-sqrt(-1)*pi*freqRatio)];

%compute poles
notchPoles=(1-notchWidth)*notchZeros;

%figure
%zplane(notchZeros.',notchPoles.');

b=poly(notchZeros); %Get moving average filter coefficients
a=poly(notchPoles); %Get autoregressive filter coefficients

figure;
freqz(b,a,32000,fs)

%filter signal s2
s3=filter(b,a,s2);

%notch filter 4

fs=44100;  %sampling rate
f0=673.5; %notch frequency
fn=fs/2; %Nyquist frequency
freqRatio=f0/fn; %ratio of notch freq. to Nyquist freq

notchWidth=0.1; %width of the notch 

%compute zeros
notchZeros=[exp(sqrt(-1)*pi*freqRatio),exp(-sqrt(-1)*pi*freqRatio)];

%compute poles
notchPoles=(1-notchWidth)*notchZeros;

%figure
%zplane(notchZeros.',notchPoles.');

b=poly(notchZeros); %Get moving average filter coefficients
a=poly(notchPoles); %Get autoregressive filter coefficients

figure;
freqz(b,a,32000,fs)

%filter signal s3
s4=filter(b,a,s3);

%notch filter 5

fs=44100;  %sampling rate
f0=474.5; %notch frequency
fn=fs/2; %Nyquist frequency
freqRatio=f0/fn; %ratio of notch freq. to Nyquist freq

notchWidth=0.1; %width of the notch 

%compute zeros
notchZeros=[exp(sqrt(-1)*pi*freqRatio),exp(-sqrt(-1)*pi*freqRatio)];

%compute poles
notchPoles=(1-notchWidth)*notchZeros;

%figure
%zplane(notchZeros.',notchPoles.');

b=poly(notchZeros); %Get moving average filter coefficients
a=poly(notchPoles); %Get autoregressive filter coefficients

figure;
freqz(b,a,32000,fs)

%filter signal s4
s5=filter(b,a,s4);

%notch filter 6

fs=44100;  %sampling rate
f0=337; %notch frequency
fn=fs/2; %Nyquist frequency
freqRation=f0/fn; %ratio of notch freq. to Nyquist freq

notchWidth=0.1; %width of the notch 

%compute zeros
notchZeros=[exp(sqrt(-1)*pi*freqRatio),exp(-sqrt(-1)*pi*freqRatio)];

%compute poles
notchPoles=(1-notchWidth)*notchZeros;

%figure
%zplane(notchZeros.',notchPoles.');

b=poly(notchZeros); %Get moving average filter coefficients
a=poly(notchPoles); %Get autoregressive filter coefficients

figure;
freqz(b,a,32000,fs)

%filter signal s5
s6=filter(b,a,s5);



%%Ouput after notch filter

player_d=audioplayer(s6,Fs1);
z1a=abs(fft(s6));
f4=(Fs1/2)*linspace(0,1,length(z1a)/2);
figure
plot(f4,z1a(1:length(z1a)/2),'r')
grid;
xlim([100 1000])
title('filtered notch spectrum');

%%elliptic filter

order=6;
fcutlow=2*pi*750;
fcuthigh=2*pi*3500;
[b,a]=ellip(order,5,80,[fcutlow,fcuthigh]/(fs/2));
s7=filter(b,a,s6);

%%filtered combination

hold off;
player_f=audioplayer(s7,Fs1);
figure
plot(s7,'r')

z1=abs(fft(s7));
f5=(Fs1/2)*linspace(0,1,length(z1)/2);
figure
plot(f5,z1(1:length(z1)/2),'c')
grid;
xlim([100 1000])
title('final filtered spectrum');
