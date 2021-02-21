function [allLocUses] = doAllLocUses(batchtype,batchscen,batchloc,batchc)
tTot = tic;
optInputs %load inputs
if bc == 1 %agm chemistry
    batt = agm;
elseif bc == 2 %lfp chemistry
    batt = lfp;
end
%initialize outputs
allLocUses(length(opt.locations),length(opt.usecases)) = struct();
for loc_n = 1:length(opt.locations)
    loc = string(opt.locations(loc_n));
    data = load(loc,loc);
    data = data.(loc);
    data.loc = loc;
    for c = 1:length(opt.usecases)
        disp(['Optimization at ' char(opt.locations(loc_n)) ...
            ' using wave energy for ' ...
            char(opt.usecases(c)) ' application beginning after ' ...
            num2str(round(toc(tTot),2)) ' seconds.'])
        [allLocUses(loc_n,c).output, ...
            allLocUses(loc_n,c).opt] = ...
            optRun(opt,data,atmo,batt,econ,uc(c),bc,wave);
        allLocUses(loc_n,c).data = data;
        allLocUses(loc_n,c).atmo = atmo;
        allLocUses(loc_n,c).batt = batt;
        allLocUses(loc_n,c).econ = econ;
        allLocUses(loc_n,c).uc = uc(c);
        allLocUses(loc_n,c).c = c;
        allLocUses(loc_n,c).loc = loc;
        allLocUses(loc_n,c).wave = wave;
        disp(['Optimization at ' char(opt.locations(loc_n)) ...
            ' using wave energy for ' ...
            char(opt.usecases(c)) ' application complete after ' ...
            num2str(round(toc(tTot),2)) ' seconds.'])
    end
end
end

