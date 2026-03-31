loadTeams
%% load map
T = readgeotable("gadm\Europe\Europe_merged.shp");
%% show map
% newmap(T.Shape(1).GeographicCRS)
% geoplot(T)
geoshow(T)
%% select
FYSsel = string(results.ESA_FYS_TOTAL) =='x';
RXBXsel = string(results.RXBX) =='x';
ERCsel = string(results.ERC_TOTAL) =='x';
EUROCsel = string(results.EUROC_TOTAL) =='x';
sel = FYSsel | RXBXsel | ERCsel | EUROCsel;
%% clubs vs cupervision vs project
truerxclubssel = strip(results.ClubName) ~= "" & strip(results.ClubName) ~= "-" & ~contains(results.ClubName,"(");
rxsupervssel   = strip(results.ClubName) ~= "" & strip(results.ClubName) ~= "-" &  contains(results.ClubName,"(");
%% add cities
for i = 1:height(results)
    if sel(i)
        cities = split(results.City(i), "/");
        states = split(results.State(i), "/");
        if isscalar(states)
            states = repmat(states, length(cities));
        end
        lat = []; lon = [];
        for j = 1:length(cities)
            searchquery = cities(j) + "," + states(j);
            [lat(j), lon(j)] = getLatLon(searchquery);
            pause(0.2)
        end
        results.lat(i) = {lat};
        results.lon(i) = {lon};
        
    end
end
%% show all cities
geoscatter([results.lat{:}], [results.lon{:}])
hold on
%% show rexus / bexus cities
lat = results.lat(RXBXsel);
lon = results.lon(RXBXsel);
geoscatter([lat{:}], [lon{:}], ...
    MarkerFaceColor="red", MarkerEdgeColor="red")
hold on
% hold on
% geoscatter(results.lat(~sel & ~ERCsel), results.lon(~sel & ~ERCsel), ...
%     MarkerFaceColor="none", MarkerEdgeColor="blue")
% legend

%% connect multi-city projects
for i = 1:length(lat)
    if length(lat{i}) > 1
        geoplot(lat{i}, lon{i}, '-g')
    end
end
%% show ERC cities
lat = results.lat(ERCsel);
lon = results.lon(ERCsel);
geoscatter([lat{:}], [lon{:}], ...
    MarkerFaceColor="green", MarkerEdgeColor="green")
%% show ESA FYS cities

% sel = string(results.ESA_FYS_TOTAL) =='x';
lat = results.lat(FYSsel);
lon = results.lon(FYSsel);
% geoscatter([lat{:}], [lon{:}], ...
%     MarkerFaceColor="blue", MarkerEdgeColor="blue")
gic = geoiconchart([lat{:}], [lon{:}], fullfile("./symbols/FYS.png"));
iconColors = gic.IconColorData;
numColors = 4;
[X,cmap] = rgb2ind(iconColors,numColors);
whiteRowTF = cmap(:,1) > 0.9 & cmap(:,2) > 0.9 & cmap(:,3) > 0.9;
whiteRow = find(whiteRowTF);
whitePixelTF = X == (whiteRow - 1);
whitePixels = find(whitePixelTF);
iconSize = size(X);
iconAlphas = ones(iconSize);
iconAlphas(whitePixels) = 0;
gic.IconAlphaData = iconAlphas;
hold on
legend off

%% connect multi-city projects
for i = 1:length(lat)
    if length(lat{i}) > 1
        geoplot(lat{i}, lon{i}, '-', "Color", "blue")
    end
end
%% count ERC participation
erc_cols = results.Properties.VariableNames(contains( ...
    results.Properties.VariableNames, 'ERC_'+digitsPattern(1)));
erc_cols = string(erc_cols);
results.ERC_nProjects(ERCsel) = 0;
for col = erc_cols
    results.ERC_nProjects(ERCsel) = results.ERC_nProjects(ERCsel) + contains( ...
        results.(col)(ERCsel), alphanumericsPattern);
end
%% count RXBX participation
rxbx_cols = results.Properties.VariableNames(contains( ...
    results.Properties.VariableNames, 'REXUS_BEXUS_'));
rxbx_cols = string(rxbx_cols);
results.RXBX_nProjects(RXBXsel) = 0;
for col = rxbx_cols
    if any(~isstring(results.(col)(RXBXsel)) & ~ischar(results.(col)(RXBXsel)) & ~iscellstr(results.(col)(RXBXsel)))
        continue
    end
    results.RXBX_nProjects(RXBXsel) = results.RXBX_nProjects(RXBXsel) + contains( ...
        results.(col)(RXBXsel), alphanumericsPattern);
end
%% count FYS participation
fys_cols = results.Properties.VariableNames(contains(results.Properties.VariableNames, 'ESAFYS_selection'));
fys_cols = string(fys_cols);
results.ESA_FYS_nProjects(FYSsel) = 0;
for col = fys_cols
    results.ESA_FYS_nProjects(FYSsel) = results.ESA_FYS_nProjects(FYSsel) + contains( ...
        results.(col)(FYSsel), alphanumericsPattern);
end
% for col = fys_cols
%     results.ESA_FYS_nProjects(FYSsel) = results.ESA_FYS_nProjects(FYSsel) + contains(results.(col)(FYSsel), 'X');
% end
%% count EUROC participation
euroc_cols = results.Properties.VariableNames(contains(results.Properties.VariableNames, 'EUROC_'));
euroc_cols = string(euroc_cols);
results.EUROC_nProjects(EUROCsel) = 0;
for col = euroc_cols
    results.EUROC_nProjects(EUROCsel) = results.EUROC_nProjects(EUROCsel) + contains( ...
        results.(col)(EUROCsel), alphanumericsPattern);
end
%% multi-project teams
figure
colors = colororder;
% categories = categorical(["ERC","REXUS/BEXUS","FYS"]);
categories = categorical(["ERC","REXUS/BEXUS","FYS","EUROC"]);
% categories = categorical(["FYS"]);
anchors = ["bottomleft", "topleft", "topright", "bottomright"];
for i = 1:length(categories)
    cat = categories(i);
    switch string(cat)
        case "ERC"
            sel = ERCsel;
            nproj = results.ERC_nProjects;
        case "REXUS/BEXUS"
            sel = RXBXsel;
            nproj = results.RXBX_nProjects;
        case "FYS"
            sel = FYSsel;
            nproj = results.ESA_FYS_nProjects;
        case "EUROC"
            sel = EUROCsel;
            nproj = results.EUROC_nProjects;
    end
    % sel = sel & truerxclubssel;
    if ~any(sel)
        continue
    end
    xstring = matlab.lang.makeValidName(string(cat));
    disp(cat)
    disp(xstring)
    lat = results.lat(sel);
    lon = results.lon(sel);

    % split and merge cities

    nproj = nproj(sel);
    city = results.City(sel);
    tmpTable = table(city, lat, lon, nproj);
    for row = 1:height(tmpTable)
        cities = strip(split(tmpTable.city(row), "/"));
        if ~isscalar(cities)
            tmpTable.city(row) = cities(1);
            tmpTable.city((end+1):(end+length(cities)-1)) = cities(2:end);
            lat = tmpTable.lat(row);
            lon = tmpTable.lon(row);
            tmpTable.lat(row) = {[lat{1}(1)]};
            tmpTable.lon(row) = {[lon{1}(1)]};
            tmpTable.lat((end-(length(cities)-2)):end) = {[lat{1}(2:end)]};
            tmpTable.lon((end-(length(cities)-2)):end) = {[lon{1}(2:end)]};
            tmpTable.nproj((end-(length(cities)-1)):end) = tmpTable.nproj(row);
            % for city = cities
            %     tmpTable.city(end+1) = city; % creates new row
            %     tmpTable.lat(end) = tmpTable.lat(row);
            % end
        end
    end
    [c, ia, ic] = unique(tmpTable.city);
    city = tmpTable.city(ia);
    lat = tmpTable.lat(ia);
    lon = tmpTable.lon(ia);
    newtable = table(city, lat, lon);
    for row = 1:height(newtable)
        newtable.nproj(row) = sum(tmpTable.nproj(strcmpi(tmpTable.city, newtable.city(row))));
    end
    

    % geoscatter([lat{:}], [lon{:}], ...
    %     MarkerFaceColor="blue", MarkerEdgeColor="blue")
    gic = geoiconchart([lat{:}], [lon{:}], fullfile("./symbols/", xstring+".png"));
    hold on


    % connect multi-city projects
    % offset = 0.1;
    % for j = 1:length(lat)
    %     if length(lat{j}) > 1
    %         geoplot( ...
    %             lat{j} + offset*(-1)^(mod(floor((i) / 2), 2)), ...
    %             lon{j} + offset*(-1)^(mod(floor((i - 1) / 2), 2)), '-', Color=colors(i,:), ...
    %             DisplayName="");
    %     end
    % end

    iconColors = gic.IconColorData;
    numColors = 4;
    [X,cmap] = rgb2ind(iconColors,numColors);
    whiteRowTF = cmap(:,1) > 0.9 & cmap(:,2) > 0.9 & cmap(:,3) > 0.9;
    whiteRow = find(whiteRowTF);
    whitePixelTF = X == (whiteRow - 1);
    whitePixels = find(whitePixelTF);
    iconSize = size(X);
    iconAlphas = ones(iconSize);
    iconAlphas(whitePixels) = 0;
    gic.IconAlphaData = iconAlphas;

    gic.IconAnchorPoint = anchors(i);

    % gic.SizeData = 7;
    % scale discontinously
    newtable.sz(newtable.nproj <= 1) = 1;
    newtable.sz(newtable.nproj > 1 & newtable.nproj <= 3) = 1.4;
    newtable.sz(newtable.nproj > 3 & newtable.nproj <= 7) = 2.2;
    newtable.sz(newtable.nproj > 7 & newtable.nproj <= 13) = 2.9;
    newtable.sz(newtable.nproj > 13 & newtable.nproj <= 30) = 3.7;
    iconSizeBase = 7;
    iconSizeMultiplicator = newtable.sz;
    % iconSizeMultiplicator = {};
    % for j = 1:length(lat)
    %     iconSizeMultiplicator{j} = repmat(nproj(j),1,length(lat{j}));
    % end
    % iconSize     = iconSizeBase * [iconSizeMultiplicator{:}];
    iconSize = iconSizeBase * newtable.sz;
    gic.SizeData = iconSize;
end
legend(categories)