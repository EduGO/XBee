function GPS_data_filter(text_file)
fid = fopen(text_file,'rt'); %1)
if fid < 0
    fprintf('Error opening the file');
    return;
end
title = [input('What is the name of the mission? ') 'GPSdata.xlsx'];
data = {'Time','Latitude(m)','Longitude(m)','Altitude(m)'};
line = fgets(fid); %2)
while ischar(line)
    c = find(line==',');
    if numel(c)==4
        time = line(1:c(1)-1); lat = line(c(1)+1:c(2)-1); lon = line(c(2)+1:c(3)-1); alt = line(c(4)+1:end);
        point1 = find(lat=='.'); point2 = find(lon=='.'); point3 = find(alt=='.'); pos = find(time==':');
        if numel(pos)==2 && numel(point1)==1 && numel(point2)==1 && numel(point3)==1
            hour = time(1:pos(1)-1); min = time(pos(1)+1:pos(2)-1); sec = time(pos(2)+1:end);
            if (numel(hour)==1||numel(hour)==2 && isnumeric(str2double(hour))) && (numel(min)==1||numel(min)==2 && isnumeric(str2double(min))) && (numel(sec)==1||numel(sec)==2 && isnumeric(str2double(sec))) && isnumeric(str2double(lat)) && isnumeric(str2double(lon)) && isnumeric(str2double(alt))
                %% LATITUDE
                ent1 = lat(1:point1(1)-1); dec1 = lat(point1(1)+1:end);
                %% LONGITUDE
                ent2 = lon(1:point2(1)-1); dec2 = lon(point2(1)+1:end);
                %% ALTITUDE
                ent3 = alt(1:point3(1)-1); dec3 = alt(point3(1)+1);
                %% DATA
                latitude = [ent1 ',' dec1]; longitude = [ent2 ',' dec2]; altitude = [ent3 ',' dec3];
                data = [data; {time, latitude, longitude, altitude}];
            end
        end
    end
    line = fgets(fid);
end
fclose(fid);
xlswrite(title,data);
end














