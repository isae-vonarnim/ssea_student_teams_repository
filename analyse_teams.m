results = loadTeams;

%% count universities at rxbx
REXUSsel = string(results.RXBX) =='x';
selidx = find(REXUSsel);
allUnis = string(results.Var3(REXUSsel));
allClubs = string(results.Var4(REXUSsel));
[uniqueUnis,unia,unic] = unique(allUnis,"stable");
% uniqueUnis = allUnis(unia)
% allUnis = uniqueUnis(unic)
[uniqueClubs,clubia,clubic] = unique(allClubs,"stable");
% uniqueClubs = allClubs(clubia)
% allClubs = uniqueClubs(clubic)
clubssel = uniqueClubs ~= "" & uniqueClubs ~= "-";
truerxclubssel = clubssel & ~contains(uniqueClubs,"(");
rxsupervssel = clubssel & contains(uniqueClubs,"(");

[unisWClubs] = allUnis(clubia(truerxclubssel));
% disp(unisWClubs)
nwclubs = length(unisWClubs)
[unisWStruct] = allUnis(clubia(rxsupervssel));
% disp(unisWStruct)
nwstructs = length(unisWStruct)
[unisWOClubs] = allUnis; unisWOClubs(clubia(clubssel)) = [];
unisWOClubs = unique(unisWOClubs, "stable");
% disp(unisWOClubs)
nwcolubs = length(unisWOClubs)
unisWandWOClubs = intersect(unisWOClubs,unisWClubs)

ncollabs = nnz(contains(uniqueUnis,"/"))
uni_collabs = uniqueUnis((contains(uniqueUnis,"/")));
[rxunis2,uni2a,uni2c] = unique(strip(split(join(allUnis,"/"),"/")),"stable");
uni_added_by_collab = setdiff(rxunis2,uniqueUnis);
rxmultiusel = uniqueUnis ~= "" & uniqueUnis ~= "-" & contains(uniqueUnis,"/");

disp(uniqueUnis(~rxmultiusel))
disp(uniqueUnis(rxmultiusel))

nunis = length(uniqueUnis)
nclubs = nnz(truerxclubssel)
nsuper = nnz(rxsupervssel)
%%
rxcnt = string(results.Var1(REXUSsel));
[rxcountries,~,idx] = unique(rxcnt(unia),"stable");
disp(rxcountries)
npercountry = accumarray(idx,1);
disp(npercountry)
rx = table(npercountry, rownames=rxcountries);

[rxcountrieswclubs,~,idxclubs] = unique(rxcnt(clubia(truerxclubssel)),"stable");
disp(rxcountrieswclubs)
npercountrywclubs = accumarray(idxclubs,1);
disp(npercountrywclubs)
rxclub = table(npercountrywclubs, rownames=rxcountrieswclubs);

[rxcountrieswsuperv,~,idxsuperv] = unique(rxcnt(clubia(rxsupervssel)),"stable");
disp(rxcountrieswsuperv)
npercountrywsuperv = accumarray(idxsuperv,1);
disp(npercountrywsuperv)
rxsuperv = table(npercountrywsuperv, rownames=rxcountrieswsuperv);

% [rxcountrieswmultiu,~,idxsmultiu] = unique(rxcnt(clubia(rxmultiusel)),"stable");
% disp(rxcountrieswmultiu)
% npercountrymultiu = accumarray(idxsmultiu,1);
% disp(npercountrymultiu)
% rxmultiu = table(npercountrymultiu, rownames=rxcountrieswmultiu);


r = outerjoin(rxclub, rx, "Keys", "Row", "MergeKeys", true);
r = outerjoin(r, rxsuperv, "Keys", "Row", "MergeKeys", true);
% r = outerjoin(r, rxmultiu, "Keys", "Row", "MergeKeys", true);
r.npercountrywclubs(isnan(r.npercountrywclubs)) = 0;
r.npercountrywsuperv(isnan(r.npercountrywsuperv)) = 0;
% r.npercountrymultiu(isnan(r.npercountrymultiu)) = 0;
disp(r)
%%
figure
% bar(categorical(r.Row),[r.npercountrywclubs, r.npercountrywsuperv, r.npercountrymultiu,    r.npercountry-r.npercountrywclubs-r.npercountrywsuperv-r.npercountrymultiu], "stacked")
bar(categorical(r.Row),[r.npercountrywclubs, r.npercountrywsuperv,    r.npercountry-r.npercountrywclubs-r.npercountrywsuperv], "stacked")
ylabel("Number of Universities")
legend("Independent Student Club","Structured Lab Supervision","Unstructured Participation")
colororder("sail")

exportgraphics(gcf,"universitycnt.png")
%%

ERCsel = string(results.ERC_TOTAL) =='x';
selidx = find(ERCsel);
allUnisERC = string(results.Var3(ERCsel));
allClubsERC = string(results.Var4(ERCsel));
allCountriesERC = string(results.Var1(ERCsel));
[uniqueUnisERC,unia,unic] = unique(allUnisERC,"stable");
% uniqueUnis = allUnis(unia)
% allUnis = uniqueUnis(unic)
[uniqueClubsERC,clubia,clubic] = unique(allClubsERC,"stable");
% uniqueClubs = allClubs(clubia)
% allClubs = uniqueClubs(clubic)
ERCclubssel = uniqueClubsERC ~= "" & uniqueClubsERC ~= "-";
trueERCclubssel = ERCclubssel & ~contains(uniqueClubsERC,"(");
ERCsupervssel = ERCclubssel & contains(uniqueClubsERC,"(");

[ERCunisWClubs] = allUnisERC(clubia(trueERCclubssel));
% disp(unisWClubs)
nwclubs = length(ERCunisWClubs)
[ERCunisWStruct] = allUnisERC(clubia(ERCsupervssel));
% disp(unisWStruct)
nwstructs = length(ERCunisWStruct)
[ERCunisWOClubs] = allUnisERC; ERCunisWOClubs(clubia(ERCclubssel)) = [];
ERCunisWOClubs = unique(ERCunisWOClubs, "stable");
% disp(unisWOClubs)
nwcolubs = length(ERCunisWOClubs)
ERCunisWandWOClubs = intersect(ERCunisWOClubs,ERCunisWClubs)

ncollabs = nnz(contains(uniqueUnisERC,"/"))
ERCuni_collabs = uniqueUnisERC((contains(uniqueUnisERC,"/")));
[ERCrxunis2,uni2a,uni2c] = unique(strip(split(join(allUnisERC,"/"),"/")),"stable");
ERCuni_added_by_collab = setdiff(ERCrxunis2,uniqueUnisERC);
ERCrxmultiusel = uniqueUnisERC ~= "" & uniqueUnisERC ~= "-" & contains(uniqueUnisERC,"/");
%%
birth = results.Var11(ERCsel);
death = results.Var12(ERCsel);
lifetime = death-birth;
% lifetime(lifetime==0) = 1;

uniqueCountriesERC = unique(allCountriesERC);
for c = 1:length(uniqueCountriesERC)
    medlife(c) = median(lifetime(allCountriesERC == uniqueCountriesERC(c)));
    nclubsERC(c) = nnz(allCountriesERC == uniqueCountriesERC(c));
end

%% get winners

%%
[unisERCandREXUS, iuERC, iuREXUS]  = intersect(uniqueUnisERC, uniqueUnis)
lu = lifetime; lu(iuERC) = [];

[teamsERCandREXUS, itERC, itREXUS]  = intersect(uniqueClubsERC, uniqueClubs)
lt = lifetime; lt(itERC) = [];


%% 
figure
bar(categorical(uniqueCountriesERC), (medlife))
%% 
figure
bar(categorical(uniqueCountriesERC), (nclubsERC))
ylabel("Number of teams")

exportgraphics(gcf,"nerc.png")
%%
figure
tcl = tiledlayout(2,1,"TileSpacing","tight","Padding","tight");
nexttile
boxchart(categorical(allCountriesERC), lifetime)
ax = gca;
ax.XTickLabel = {};
nexttile
boxchart(categorical(allCountriesERC), lifetime)
ylim([0 15])
ylabel(tcl, "Team/Club age [years]")

exportgraphics(gcf,"ercage.png")
%%
figure
hold on
histogram(lt, BinWidth=1)
histogram(lifetime(iERC), BinWidth=1)

%%
figure
hold on
histogram(lu, BinWidth=1)
histogram(lifetime(iuERC), BinWidth=1)