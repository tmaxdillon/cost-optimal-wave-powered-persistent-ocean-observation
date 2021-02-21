# cost-optimal-wave-powered-persistent-ocean-observation
This is the open source code repository for the journal article Cost-Optimal Wave-Powered Persistent Oceanographic Observation, submitted to Renewable Energy by Trent Dillon, Ben Maurer, Michael Lawson, Dale "Scott" Jenne, Dana Manalang and Brian Polagye. This contains only the code required to run the techno-economic model described in this paper. The living repository, which contains additional code (e.g., visualization scripts) can be found here: https://github.com/tmaxdillon/OO-TechEc

# How to run the code:
There are two ways to run the techno-economic model, either through the optScript.m script (output does not save to a .mat file) or through the optSave.m function (output to a .mat file):

## Running the techno-economic model using optScript.m (output does not save)
1. Download cost-optimal-wave-powered-persistent-ocean-observation and add this folder to your path
1. Enter all optimization and run settings in lines 3-11 in optInputs.m as follows: 
	1. Line 3: specify WEC scenario. 1 = conservative. 2 = optimistic cost. 3 = optimistic durability. 
    1. Line 4 and 5: specify objective space discretization 
		1. recommended 5-15 if using a standard computer, and >100 if using a parallel cluster
    	1. recommended n = m
    1. Lines 6, 7, 8 and 9: specify run type by setting one of these lines to 1 (if all are set to zero a single optimization will run) 
		1. Line 6: simulate all WEC scenarios and use cases 
		1. Line 7: simulate all locations and use cases 
		1. Line 8: sensitivity analysis (specificy sensitivity array and parameter within if statement on line 177 and see parameter key in doSens.m)
    	1. Line 9: sensitivity small multiple
    1. Line 10: specify use case. 1 = short-term instrumentation. 2 = long-term instrumentation.
    1. Line 11: specify location ("argBasin", "cosEndurance_wa", "cosPioneer", "irmSea", "souOcean")
1. Type "optScript" in the command window or command line
1. The output will save to the workspace as "optStruct" (single optimization), "multStruct" (sensitivity analysis), "allLocUses" (all locations and use cases) or "allScenUses" (all scenarios and uses)

## Running the techno-economic model using optSave() (output saves as .mat file) can be done interactively or through batch scripts.
###### Interactively
1. Follow steps 1 and 2 above
1. Type "optSave([insert path],[insert .mat filename])" into the command windo
1. The output will save to [insert path] as [insert .mat filename]
###### Through batch scripts
1. Save "cost-optimal-wave-powered-persistent-ocean-observation" to your home folder
1. Modify any run-specific parameters (e.g., optimization discretization, sensitivity paramater and array) in lines 18-56
1. Within the batch script, add "cost-optimal-wave-powered-persistent-ocean-observation" to your path
1. Within the batch script, type "optSave([insert path],[insert .mat filename],A,B,C,D)" for each run desired, where A, B, C and D are as follows:
    * A, batch run type: "ssm" (sensitivity small multiple), "alllocuses" (all locations and use cases), "sens" (sensitivity analysis) or [] (single optimization)
    * B, batch WEC scenario: 1 = conservative. 2 = optimistic cost. 3 = optimistic durability.
    * C, batch location: ("argBasin", "cosEndurance_wa", "cosPioneer", "irmSea", "souOcean")
    * D, batch use case: 1 = short-term instrumentation. 2 = long-term instrumentation.
1. The output will save to [insert path] as [insert .mat filename]

# For more information...
For further information, either consult the journal article titled "Cost-optimal wave-powered persistent oceanographic observation", published in Renewable Energy (submitted in February 2021), or email tmaxd@uw.edu or tmaxdillon@gmail.com, who is the author of this codeset and will very happily answer any questions.

  
