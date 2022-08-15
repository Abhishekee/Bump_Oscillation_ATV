clear all
close all
clc

%% Bump oscillation profile 
% weights in kg per corner 

Ws_front = 66;
Ws_rear = 99;
Wus_front = 26;
Wus_rear = 39;

l = 1300;   %% wheelbase in mm
V = 60;     %% velocity in kmph

%% Motion Ratios
MR_f = 0.71;
MR_r = 0.86;

%time lag in sec
t1 = (l*(10^(-3)))/(60*(0.277));

%% Natural Frequrncies 
fs_front = 1.0;
fs_rear = 1.2;

%rates in N/mm
%tire rate
kt = 245;
%ride rate
kr_front = (((fs_front*2*pi)^2)*(Ws_front))/1000;
kr_rear = (((fs_rear*2*pi)^2)*(Ws_rear))/1000;

%wheel rates
kw_front = (kt*kr_front)/(kt-kr_front);
kw_rear = (kt*kr_rear)/(kt-kr_rear);

%spring rates
ks_front = kw_front/(MR_f)^2;
ks_rear = kw_rear/(MR_r)^2;

%unsprung mass frequencies
fu_front = (1/(2*pi))*((kw_front+kt)*1000/Wus_front)^0.5;
fu_rear = (1/(2*pi))*((kw_rear+kt)*1000/Wus_rear)^0.5;

%% plotting the graphs
%time range in sec
time = linspace(0,3.5,400);

i = 1;
for t = linspace(0,3.5,400)
    As_front(i) = exp(-t)*sin(2*pi*fs_front*t);
    As_rear(i) = exp(-t)*sin(2*pi*fs_rear*(t-t1));
    Au_front(i) = exp(-t)*sin(2*pi*fu_front*t);
    Au_rear(i)  = exp(-t)*sin(2*pi*fu_rear*(t-t1));
    i=i+1;
end

figure(1)
subplot(2,1,1)
plot(time,As_front,'g','linewidth',2)
hold on
plot(time,As_rear,'y','linewidth',2)
title('Bump oscillation profile for Sprung Mass')
xlabel('Time (s)')
ylabel('Amplitude (m)')
legend('Front','Rear')
grid on

subplot(2,1,2)
plot(time,Au_front,'y','linewidth',2)
hold on
plot(time,Au_rear,'g','linewidth',2)
title('Bump oscillation profile for unsprung mass')
xlabel('Time (s)')
ylabel('Amplitude (m)')
legend('Front', 'Rear')
grid on

saveas(1,'Bump_oscillation','jpeg')