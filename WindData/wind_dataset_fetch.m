function url_list = wind_dataset_fetch(station_number, start_date, end_date)

import matlab.net.http.*

dates = start_date:hours(12):end_date;
possible_hours = [0 12];

url_list = strings(numel(dates), 1);
count = 0;

req = RequestMessage('HEAD');

for i = 1:numel(dates)

    date = dates(i);
    date.Hour = interp1(possible_hours, possible_hours, date.Hour, 'nearest');
    date.Minute = 0;
    date.Second = 0;

    year_string = string(date.Year);
    if date.Month < 10; month_str = "0" + string(date.Month); else; month_str = string(date.Month); end
    if date.Day   < 10; day_str   = "0" + string(date.Day  ); else; day_str   = string(date.Day  ); end
    if date.Hour  < 10; hour_str  = "0" + string(date.Hour ); else; hour_str  = string(date.Hour ); end

    url = "https://weather.uwyo.edu/wsgi/sounding?datetime=" + ...
          year_string + "-" + month_str + "-" + day_str + ...
          "%20" + hour_str + ":00:00&id=" + station_number + ...
          "&src=UNKNOWN&type=TEXT:CSV";

    
    % "urlread sucks dick" - MatLab documentation
    % webread doesn't work but im not sure why, its supposed to be better
    % https://www.rfc-editor.org/rfc/rfc9110.html#name-head 


    %ok heres how it works:
    % UOW displays a different status code (liek an error code) when we enter an
    %invalid time, so thats why urlread and HEAD works :)	


    try
        resp = req.send(url);
    catch
        disp("FAIL: " + url)
        continue
    end

    if resp.StatusCode == 200
        disp("Status code: " + string(resp.StatusCode) + url)
        %disp("Status code: " + string(resp.StatusCode))

        count = count + 1;
        url_list(count) = url;

        writecell({url}, "urls.csv", "WriteMode", "append");
    else
        
        disp("Status code: " + string(resp.StatusCode) + url)
    end
end

url_list = url_list(1:count);

end