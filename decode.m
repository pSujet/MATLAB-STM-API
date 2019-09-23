function [x_dat,y_dat,z_dat] = decode(s)
data = fscanf(s,'%c',18);
if data(1)=='U' || data(1)=='D' || data(1)=='L' || data(1)=='R' || data(1)=='X' 

    x_dat = str2num(data(5:8))/1000;
    y_dat = str2num(data(9:12))/1000;
    z_dat = str2num(data(13:16))/1000;

    %check sign
    if data(2)=='N'
        x_dat = -x_dat;
    end
    if data(3)=='N'
        y_dat = -y_dat;
    end
    if data(4)=='N'
        z_dat = -z_dat;
    end

end
end