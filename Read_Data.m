%%Magic Glove
%Fall 2019

%% Initialize
clear all;
close all;
clc;
figure;
ylim([-1.1,1.1]);
xlabel("Time [50 ms]");
ylabel("Acceleration in x axis [g]");
hold on;


fclose(instrfindall);
delete(instrfindall);
    
%% Read Data

s = serial('COM11','BaudRate',115200);
fopen(s);
disp("Port Open");

for i=1:1000
data = fscanf(s,'%c',18);
disp(data(2:16));

x_dat(i) = str2num(data(5:8));
y_dat(i) = str2num(data(9:12));
z_dat(i) = str2num(data(13:16));

% convert to decimal
x(i) = x_dat(i)/1000;
y(i) = y_dat(i)/1000;
z(i) = z_dat(i)/1000;

%check sign
if data(2)=='N'
    x(i) = -x(i);
end
if data(2)=='N'
    y(i) = -y(i);
end
if data(2)=='N'
    z(i) = -z(i);
end

%plot
plot((1:i),x(1:i),'LineWidth',2,'Color',[0,0.7,0.9]);
drawnow;
end

% Close
fclose(instrfindall);
disp("Port closed");
delete(instrfindall);




