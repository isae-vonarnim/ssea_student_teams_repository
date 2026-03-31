function [lat, lon] = getLatLon(address, api_key, output_dir)
arguments (Input)
    address     string
    api_key     string  = "69abd57b5aeb1066466576cdxea8fe7"
    output_dir  string  = fullfile(".", "latLonQueries");
end
arguments (Output)
    lat double % latitude [deg]
    lon double % longitude [deg]
end
% output_dir = fullfile(".", "latLonQueries"); % modify as required
if ~isfolder(output_dir)
    mkdir(output_dir);
end
% api_key = "69abd57b5aeb1066466576cdxea8fe7"; % DO NOT SHARE
api_url = "https://geocode.maps.co/search?q=" + address + "&api_key=" + api_key;
% curlquery = sprintf(' curl -f -n -L -O "%s" --output-dir "%s"', ...
%     api_url, ...
%     output_dir);
% disp(curlquery);
% [A, cURL_out]  = system(curlquery);
% if A ~= 0
%     if A == 56
%         warning("Connection was reset -- confirm internet connection and try again!")
%     end
%     error("System returned '%d'\n%s",A,cURL_out);
% end
% jsondecode(fullfile(output_dir, "search"))
w = webread(api_url);
if ~isempty(w)
    disp(w(1).display_name)
    lat = w(1).lat;
    if iscell(lat)
        lat = lat{1};
    end
    lat = str2double(lat);
    lon = w(1).lon;
    if iscell(lon)
        lon = lon{1};
    end
    lon = str2double(lon);
else
    lat = nan;
    lon = nan;
    warning("%s not found", address)
end
end