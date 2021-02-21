%created by Trent Dillon on January 15th 2019

%% run optimization

optInputs
T = tic;
if opt.sens && ~opt.alllocuses %multiple simulations, sensitivity
    disp(['Sensitivity for ' char(opt.usecases(c)) ' use case at ' loc ...
        ' under the ' char(opt.wavescens(econ.wave.scen)) ...
        ' beginning now.'])
    multStruct = doSens([],[],batchtype,batchscen,batchloc,batchc);
    disp(['Sensitivity complete after ' ...
        num2str(round(toc(T)/60,2)) ' minutes.'])
elseif opt.alllocuses %run all dimensions for a power module / scenario
    disp(['All locations and use cases for the '  ...
        char(opt.wavescens(econ.wave.scen)) ' scenario beginning now.'])
    allLocUses = doAllLocUses(batchtype,batchscen,batchloc,batchc);
    disp(['All locations and use cases for the ' ...
        char(opt.wavescens(econ.wave.scen)) ...
        ' scenario complete after' num2str(round(toc(T)/60,2)) ...
        ' minutes.'])
elseif opt.allscenuses %run all dimensions for a location
    disp(['All scenaios and use cases for the ' loc ...
        ' location beginning now.'])
    allLocUses = doAllScenUses(batchtype,batchscen,batchloc, ...
        batchc);
    disp(['All scenarios and use cases for the ' loc ...
        ' scenario complete after' num2str(round(toc(T)/60,2)) ...
        ' minutes.'])
elseif opt.senssm
    [s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s0] = ...
        doSensSM(batchtype,batchscen,batchloc,batchc);
    wiv = s1;
    wcm = s2;
    whl = s3;
    ild = s4;
    osv = s5;
    sdr = s6;
    utp = s7;
    bhc = s8;
    dep = s9;
    dtc = s10;
    lft = s11;
    spv = s12;
    tmt = s13;
    bcc = s14;
    bbt = s15;
    eol = s16;
else %just one simulation
    disp(['Optimization (' char(loc), ...
        ', bc: ' num2str(bc) ...
        ', uc: ' num2str(c) ') beginning'])
    tTot = tic;
    %optInputs %load inputs
    data = load(loc,loc);
    data = data.(loc);
    [output,opt] = ...
        optRun(opt,data,atmo,batt,econ,uc(c),bc,wave);
    optStruct.output = output;
    optStruct.opt = opt;
    optStruct.data = data;
    optStruct.atmo = atmo;
    optStruct.batt = batt;
    optStruct.econ = econ;
    optStruct.uc = uc(c);
    optStruct.c = c;
    optStruct.loc = loc;
    optStruct.wave = wave;
    disp(['Optimization complete after ' ...
        num2str(round(toc(tTot),2)) ' seconds.'])
end

clear i tTot batchtype
uc = uc(c); %for debugging









