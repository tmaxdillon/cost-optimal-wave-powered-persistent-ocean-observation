function [s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16, ...
    s0] = doSensSM(batchtype,batchscen,batchloc,batchc)

n = 10; %sensitivity discretization
f = 2; %factor

disp(['Sensitivity small multiple beginning. n = ' num2str(n) ])
tTot = tic;
optInputs %load inputs
uc = uc(c);
opt.S = n; %for command window notification
nps = 3; %number of power-specific parameters
tp{1} = 'wiv'; %wec interventions/year [WEC]
ta(1,:) = linspace(0,2.25,n);
tp{2} = 'wcm'; %wec cost multiplier [WEC]
ta(2,:) = linspace(2,14,n);
tp{3} = 'whl'; %wec hotel load [WEC]
ta(3,:) = linspace(0,.18,n);
tp{nps+1} = 'ild'; %instrumentation load [INST]
ta(nps+1,:) = linspace(uc.draw/f,uc.draw*f,n);
tp{nps+2} = 'osv'; %osv cost [OPEX]
ta(nps+2,:) = linspace(2500,40000,n);
tp{nps+3} = 'sdr'; %battery self discharge rate [BATT]
ta(nps+3,:) = linspace(0,15,n);
tp{nps+4} = 'utp'; %uptime percent [INST]
ta(nps+4,:) = linspace(.80,1,n);
tp{nps+5} = 'bhc'; %battery housing cost [BATT]
ta(nps+5,:) = linspace(0.25,3,n);
tp{nps+6} = 'dep'; %depth modifier [INST]
ta(nps+6,:) = linspace(120,5500,n); %watch MDD bounds!
tp{nps+7} = 'dtc'; %distance to coast [OPEX]
ta(nps+7,:) = linspace(10,1400,n)*1000;
tp{nps+8} = 'lft'; %lifetime [INST]
ta(nps+8,:) = linspace(1,10,n);
tp{nps+9} = 'spv'; %specialized vessel cost [OPEX]
ta(nps+9,:) = linspace(35000,150000,n);
tp{nps+10} = 'tmt'; %time spent on site for maintenance [OPEX]
ta(nps+10,:) = linspace(1,12,n);
tp{nps+11} = 'bcc'; %battery cell cost [BATT]
ta(nps+11,:) = linspace(120,1500,n);
tp{nps+12} = 'bbt'; %battery bank temperature [BATT]
ta(nps+12,:) = linspace(15,35,n);
tp{nps+13} = 'eol'; %battery end of life [BATT]
ta(nps+13,:) = 0.05:0.025:0.275;

s1 = doSens(ta(1,:),tp{1},batchtype,batchscen,batchloc,batchc);
s2 = doSens(ta(2,:),tp{2},batchtype,batchscen,batchloc,batchc);
s3 = doSens(ta(3,:),tp{3},batchtype,batchscen,batchloc,batchc);
s4 = doSens(ta(4,:),tp{4},batchtype,batchscen,batchloc,batchc);
s5 = doSens(ta(5,:),tp{5},batchtype,batchscen,batchloc,batchc);
s6 = doSens(ta(6,:),tp{6},batchtype,batchscen,batchloc,batchc);
s7 = doSens(ta(7,:),tp{7},batchtype,batchscen,batchloc,batchc);
s8 = doSens(ta(8,:),tp{8},batchtype,batchscen,batchloc,batchc);
s9 = doSens(ta(9,:),tp{9},batchtype,batchscen,batchloc,batchc);
s10 = doSens(ta(10,:),tp{10},batchtype,batchscen,batchloc,batchc);
s11 = doSens(ta(11,:),tp{11},batchtype,batchscen,batchloc,batchc);
s12 = doSens(ta(12,:),tp{12},batchtype,batchscen,batchloc,batchc);
s13 = doSens(ta(13,:),tp{13},batchtype,batchscen,batchloc,batchc);
s14 = doSens(ta(14,:),tp{14},batchtype,batchscen,batchloc,batchc);
s15 = doSens(ta(15,:),tp{15},batchtype,batchscen,batchloc,batchc);
s16 = doSens(ta(16,:),tp{16},batchtype,batchscen,batchloc,batchc);

%get S0, default results
optInputs %load inputs
data = load(loc,loc);
data = data.(loc);
[output,opt] = optRun(opt,data,atmo,batt,econ,uc(c),bc,wave);
s0.output = output;
s0.opt = opt;
s0.data = data;
s0.atmo = atmo;
s0.batt = batt;
s0.econ = econ;
s0.uc = uc(c);
s0.c = c;
s0.loc = loc;
s0.wave = wave;

disp(['Sensitivity small multiple complete after ' ...
    num2str(round(toc(tTot)/60,2)) ' minutes.'])

end

