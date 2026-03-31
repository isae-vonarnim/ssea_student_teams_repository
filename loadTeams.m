datadir = fullfile(".");
%%
[file, location] = uigetfile("*.xlsx","Select a Results file", datadir);
if location
    datadir = location;
end
%%
results = readtable(fullfile(location, file), ...
    ReadVariableNames=true, ...
    MergedCellColumnRule="duplicate");