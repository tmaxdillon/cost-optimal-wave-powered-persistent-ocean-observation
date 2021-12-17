%simulation settings
%interactive job
econ.wave.scen = 1; %scenario indicator 1:C,2:OC,3:OD
opt.bf.m = 1;
opt.bf.n = 1;
opt.allscenuses = 0;
opt.alllocuses = 0;
opt.sens = 0; %sensitivity analysis (see line 177)
opt.senssm = 1;
c = 1;  %use case 1:ST 2:LT
loc = 'irmSea'; %location
if ~exist('batchtype','var')
    batchtype = [];
    batchscen = [];
    batchloc = [];
    batchc = [];
end
if isequal(batchtype,'ssm')
    opt.bf.m = 500; %optimization discretization
    opt.bf.n = 500; %optimization discretization
    %leave the following variables as is
    econ.wave.scen = batchscen;
    opt.allscenuses = 0;
    opt.alllocuses = 0;
    opt.sens = 0;
    opt.senssm = 1;
    c = batchc;
    loc = batchloc;
elseif isequal(batchtype,'alllocuses')
    opt.bf.m = 500; %optimization discretization
    opt.bf.n = 500; %optimization discretization
    %leave the following variables as is
    econ.wave.scen = batchscen; 
    opt.allscenuses = 0;
    opt.alllocuses = 1;
    opt.sens = 0;
    opt.senssm = 0;
    c = [];
    loc = [];
elseif isequal(batchtype,'sens')
    opt.bf.m = 100; %optimization discretization
    opt.bf.n = 100; %optimization discretization
    opt.tuning_array = linspace(0,2.25,10); %sensitivity array
    opt.tuned_parameter = 'wiv'; %sensitivity parameter (see doSens.m)
    %leave the following variables as is
    econ.wave.scen = batchscen; 
    opt.allscenuses = 0;
    opt.alllocuses = 0;
    opt.sens = 1;
    opt.senssm = 0;
    c = batchc;
    loc = batchloc;
end

%strings
opt.locations = {'argBasin';'cosEndurance_wa'; ...
    'cosPioneer';'irmSea';'souOcean'};
opt.powermodules = {'wind';'inso';'wave';'dies'};
opt.usecases = {'short term';'long term'};
opt.wavescens = {'Conservative';'Optimistic Cost';'Optimistic Durability'};

%ECONOMIC
%polynomial fits
econ.batt_n = 1;                    %[~]
econ.wind_n = 1;                    %[~]
%platform 
load('mdd_output.mat')
econ.platform.mdd.cost = cost;          %mooring cost lookup matrix
econ.platform.mdd.depth = depth;        %mooring cost lookup depth
econ.platform.mdd.diameter = diameter;  %mooring cost lookup diameter
clear cost depth diameter e_subsurface e_tension w_tension
econ.platform.t_i = [6 12];         %[h] added h for inst
econ.platform.d_i = [500 5000];     %[m] depth for inst cost
%vessel
econ.vessel.osvcost = 15000;        %[$/day]
econ.vessel.speed = 10;             %[kts]
econ.vessel.t_mosv = 6;             %[h] time on site for maint (osv)
econ.vessel.speccost = 50000;       %[$/day] 
econ.vessel.t_ms = 2;               %[h] time on site for maint (spec)
%battery 
econ.batt.enclmult = 1;             %multiplier on battery cost for encl
%wind
econ.wind.installed = 10117;        %[$/kW] installed cost (DWR)
%wave costs
econ.wave.scenarios = 3;            %number of scenarios
econ.wave.costmult_con = 10;         %conservative cost multiplier
econ.wave.costmult_opt = 4;         %optimistic cost multiplier
econ.wave.lowfail = 0;              %failures per year (optimistic)
econ.wave.highfail = 1;              %failure per year (conservative)

%ENERGY
%wave energy parameters
wave.B_func_n = 1000;       %number of points in B(Gr) function
wave.Hs_ra = 4;             %[m], rated wave height
wave.Tp_ra = 9;            %[s], rated peak period
wave.eta_ct = 0.6;          %[~] wec efficiency
wave.house = 0.10;          %percent of rated power as house load
wave.kW_max = 17;           %[kW] maximum limit for wec-sim output
%AGM parameters
agm.V = 12;                %[V] Voltage
agm.se = 3.3;              %[Ah/kg] specific energy factor
agm.lc_nom = 18;           %[months] nominal life cycle
agm.beta = 6/10;           %decay exponential for life cycle
agm.lc_max = 12*5;        %maximum months of operation
agm.sdr = 5;               %[%/month] self discharge rate
agm.dmax = .2;             %maximum depth of discharge
agm.lcm = 1;    %battery life cycle model, 1:bolun 2:dyn_lc 3:fixed_lc
agm.T = 15;                 %[C] temperature
agm.EoL = 0.2;              %battery end of life
agm.rf_os = true;           %toggle using open source  rainflow
agm.bdi = 2190;              %battery degradation evaluation interaval
%LFP parameters
lfp.V = 12;                 %[V] Voltage
lfp.se = 8.75;              %[Ah/kg] specific energy factor
lfp.lc_nom = 18;            %[months] nominal life cycle
lfp.beta = 1;               %decay exponential for life cycle
lfp.lc_max = 12*5;          %maximum months of operation
lfp.sdr = 3;                %[%/month] self discharge rate
lfp.dmax = .0;              %maximum depth of discharge
lfp.cost = 580;             %[$/kWh]
lfp.lcm = 1;%battery life cycle model, 1:bolun 2:dyn_lc 3:fixed_lc
lfp.T = 15;                 %[C] temperature
lfp.EoL = 0.2;              %battery end of life
lfp.rf_os = true;           %toggle using open source  rainflow
lfp.bdi = 2190;              %battery degradation evaluation interaval
bc = 2; %battery chemistry 1:AGM 2:LFP
if bc == 1 %agm chemistry
    batt = agm;
elseif bc == 2 %lfp chemistry
    batt = lfp;
end

%atmospheric parameters
atmo.rho_w = 1025;          %[kg/m^3] density of water
atmo.g = 9.81;              %[m/s^2]

%USE CASES
%short term instrumentation
uc(1).draw = 200;               %[W] - secondary node
uc(1).lifetime = 5;             %[y]
uc(1).SI = 6;                   %[months] service interval
uc(1).uptime = .99;             %[%] uptime
uc(1).turb.lambda = 4;          %turbine interventions
uc(1).dies.lambda = 1;          %diesel interventions
%long term instrumentation
uc(2).draw = 200;               %[W] - secondary node
uc(2).lifetime = 5;             %[y]
uc(2).SI = 12*uc(2).lifetime;   %[months] service interval
uc(2).uptime = .99;             %[%] uptime
uc(2).turb.lambda = 4;          %turbine interventions
uc(2).dies.lambda = 1;          %diesel interventions

%sensitivity analaysis
%if conducting an interactive sensitivity analysis, specify the tuning 
%array and the tuned parameter here
if ~isfield(opt,'tuning_array') && ~isfield(opt,'tuned_parameter')
    % opt.tuning_array = linspace(.80,1,10);
    % opt.tuned_parameter = 'utp';
    % opt.tuning_array = [10:10:200];
    % opt.tuned_parameter = 'whl'; %wec house load
    % opt.tuning_array = 1:1:10;
    % opt.tuned_parameter = 'wcm'; %wave cost multiplier
    % opt.tuning_array = linspace(0,9,50);
    % opt.tuned_parameter = 'wiv'; %wec interventions
    % opt.tuning_array = linspace(1/2,2,10);
    % opt.tuned_parameter = 'dep'; %depth modifier
    % opt.tuning_array = linspace(uc(c).lifetime-3,uc(c).lifetime+3,10);
    % opt.tuned_parameter = 'lft'; %lifetime
    opt.tuning_array = linspace(10,1400,10)*1000;
    opt.tuned_parameter = 'dtc'; %distance to coast [OPEX]
end

%optimization parameters
opt.bf.M = 8; %[kW] max kW in grid
opt.bf.N = 500; %[kWh] max Smax in grid
opt.bf.maxworkers = 36; %maximum cores
