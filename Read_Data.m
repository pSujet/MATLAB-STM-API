%%Magic Glove
%Fall 2019

%% Initialize
clear all;
close all;
clc;

fclose(instrfindall);
delete(instrfindall);

%% Plot initialize
figure;
set(gcf, 'Position',  [70, 70, 1200, 600])
% x-acceleration
subplot(3,6,[1,2,3])
x = [];
hx = line(NaN,NaN,'LineWidth',2,'Color',[0,0.7,0.9]);
ylim([-1.1,1.1]);xlim([0,1000]);
xlabel("Time [50 ms]");ylabel("Acceleration in x axis [g]");
title("Acceleration in x axis over time");
%ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
grid on;

% y-acceleration
subplot(3,6,[7,8,9])
y = [];
hy = line(NaN,NaN,'LineWidth',2,'Color',[0,0.0,0.9]);
ylim([-1.1,1.1]);xlim([0,1000]);
xlabel("Time [50 ms]");ylabel("Acceleration in y axis [g]");
title("Acceleration in y axis over time");
grid on;

% z-acceleration
subplot(3,6,[13,14,15])
z = [];
hz = line(NaN,NaN,'LineWidth',2,'Color',[0,0.0,0.5]);
ylim([-1.1,1.1]);xlim([0,1000]);
xlabel("Time [50 ms]");ylabel("Acceleration in z axis [g]");
title("Acceleration in z axis over time");
grid on;

% planar
subplot(3,6,[4,5,6,10,11,12,16,17,18])
p = plot(NaN,NaN,'o');
ylim([-1.1,1.1]);xlim([-1.1,1.1]);
xlabel("Acceleration X");ylabel("Acceleration Y");
title("Plane X-Y")
grid on;


%% Debug 1.1
figure;
hx = plot(NaN,NaN,'LineWidth',2,'Color',[0,0.7,0.9]);
ylim([-1.1,1.1]);xlim([0,1000]);
grid on;

%% Debug 1.2
s = serial('COM11','BaudRate',115200);
fopen(s);
disp("Port Open");
x = [];

for i = 1:1000
[x_dat,y_dat,z_dat] = decode(s);
% set x
x(i) = x_dat;
set(hx, 'XData', 1:i,'YData', x(1:i));

drawnow;
end

% Close
fclose(instrfindall);
disp("Port closed");
delete(instrfindall);

%% Debug 2.1
figure;
p = plot(NaN,NaN,'o');
ylim([-0.2,0.2]);xlim([-0.2,0.2]);
xlabel("Acceleration X");ylabel("Acceleration Y");
title("Plane X-Y")
grid on;

%% Debug 2.2
s = serial('COM11','BaudRate',115200);
fopen(s);
disp("Port Open");
x = [];
y = [];
windowSize = 5; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

for i = 1:10000
[x_dat,y_dat,z_dat] = decode(s);
x(i) = x_dat;
y(i) = y_dat;
x(i) = filter(b,a,x(i));
y(i) = filter(b,a,y(i));

set(p, 'XData', x(i));
set(p, 'YData', y(i));
drawnow;
end
fclose(instrfindall);
disp("Port closed");
delete(instrfindall);

%% Visualize

s = serial('COM11','BaudRate',115200);
fopen(s);
disp("Port Open");
% x = [];
% hx = plot(NaN,NaN,'LineWidth',2,'Color',[0,0.7,0.9]);

for i = 1:1000
[x_dat,y_dat,z_dat] = decode(s);

%plot

% set x
x(i) = x_dat;
%set(hx, 'XData', 1:i,'YData', x(1:i));

% % set y
y(i) = y_dat;
% set(hy, 'XData', 1:i);
% set(hy, 'YData', y(1:i));
% 
% % set z
% z(i) = z_dat;
% set(hz, 'XData', 1:i);
% set(hz, 'YData', z(1:i));
%
% set planar
set(p, 'XData', x(i));
set(p, 'YData', y(i));
drawnow;
end

% Close
fclose(instrfindall);
disp("Port closed");
delete(instrfindall);




