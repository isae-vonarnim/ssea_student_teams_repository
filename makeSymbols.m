%%
f = figure;
X = categorical(["ERC","REXUS/BEXUS"]);
p = piechart(f, X);
labels = repmat({''},size(X));%option 1
p.Labels = labels;

output_dir = fullfile("./symbols");
if ~isfolder(output_dir)
    mkdir(output_dir)
end
filename = matlab.lang.makeValidName(strjoin(string(X),'_')) + ".png";
exportgraphics(f, fullfile(output_dir, filename), ...
    Width=150, Height=150, Units="pixels");
% read in the existing image file
cdata = imread(fullfile(output_dir, filename));
% write image back out treating all white pixels as transparent
imwrite(cdata, fullfile(output_dir, filename), 'Transparency',[1 1 1]);
% filename = matlab.lang.makeValidName(strjoin(string(X),'_')) + ".pdf"; 
% exportgraphics(f, fullfile(output_dir, filename), ...
%     BackgroundColor="none", ContentType="vector");

%%
output_dir = fullfile("./symbols");
if ~isfolder(output_dir)
    mkdir(output_dir)
end
X = categorical(["ERC","REXUS/BEXUS","FYS","EUROC"]);
for i = 1:length(X)
    s = zeros(length(c),1, 'logical');
    s(i) = 1;
    c = colororder;
    c(~s,:) = 1;
    f = figure;
    p = piechart(f, X);
    labels = repmat({''},size(X));%option 1
    p.Labels = labels;
    p.ColorOrder = c;
    p.FaceAlpha = 1;
    p.EdgeColor = "flat";
    p.ExplodedWedges = i;
    filename = matlab.lang.makeValidName(strjoin(string(X(i)),'_')) + ".png";
    exportgraphics(f, fullfile(output_dir, filename), ...
        Width=150, Height=150, Units="pixels");
end