function [output,opt] = optRun(opt,data,atmo,batt,econ,uc,bc,wave)

%curve-fit device scatters, find polyvals (agm battery cost only)
[opt.p_dev.b,~,opt.p_dev.kWhmax] = calcDeviceVal('agm',[],econ.batt_n);
opt.p_dev.t = calcDeviceVal('turbine',[],econ.wind_n);

opt = prepWave(data,opt,wave,atmo,uc);
[output,opt] = optWave(opt,data,atmo,batt,econ,uc,bc,wave);

%print optimization results
results.width = output.min.width;
results.cw_avg = output.min.cw_avg;
results.cwr_avg = output.min.cwr_avg;
results.kW = output.min.kW;
results.Smax = output.min.Smax;
results.cost = output.min.cost;
results.CapEx = output.min.CapEx;
results.OpEx = output.min.OpEx;
results.nvi = output.min.nvi;
results.CF = output.min.CF;
results.batt_L_max = max(output.min.batt_L);
results

end

