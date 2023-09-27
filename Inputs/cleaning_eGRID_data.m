% cleaning eGRID data

%% import data from eGRID excel spreadsheet


% Unit-level data
opts = detectImportOptions('egrid2019_data.xlsx','NumVariables',32,'Sheet','UNT19','DataRange','A3:AF30000','VariableNamesRange','A2:AF2','TextType','string');
opts.SelectedVariableNames = {'PSTATABB','PNAME','ORISPL','UNITID','PRMVR','UNTOPST','NUMGEN','FUELU1','HRSOP','HTIAN','NOXAN','SO2AN','CO2AN','HGAN','HTIANSRC','NOXANSRC','SO2SRC','CO2SRC','HGSRC','UNTYRONL'};
egrid_unit_data = readtable('egrid2019_data.xlsx',opts);
egrid_unit_data.Properties.VariableNames = {'state','plant_name','orispl','unit_id','prime_mover','operational_status','associated_generators','fuel','hours_operated','heat_input_MMBTU','nox_emissions_tons','so2_emissions_tons','co2_emissions_tons','hg_emissions_lbs','heat_input_estimation_method','nox_emissions_estimation_method','so2_emissions_estimation_method','co2_emissions_estimation_method','hg_emissions_estimation_method','unit_year_online'};
% kept operational status although Deetjen drops it -may be an omission of him; I think it's necessary so we can drop those units that are already retired
% kept associated generators - just in case I need them later; it seems like units can power more than 1 generator? which is odd
% kept the data sources for unit level data in case I want to analyze specific sources e.g. estimated vs copied from database
egrid_unit_data = convertvars(egrid_unit_data,{'hours_operated','hg_emissions_lbs','unit_year_online'},'double'); % correct misread data types
egrid_unit_data(find(isnan(egrid_unit_data.orispl)),:) = []; % drop excess rows

% Generator-level data
opts = detectImportOptions('egrid2019_data.xlsx','NumVariables',17,'Sheet','GEN19','DataRange','A3:Q30000','VariableNamesRange','A2:Q2','TextType','string');
opts.SelectedVariableNames = {'PSTATABB','PNAME','ORISPL','GENID','NUMBLR','GENSTAT','PRMVR','FUELG1','NAMEPCAP','CFACT','GENNTAN','GENERSRC','GENYRONL','GENYRRET'};
egrid_generator_data = readtable('egrid2019_data.xlsx',opts);
egrid_generator_data.Properties.VariableNames = {'state','plant_name','orispl','gen_id','associated_boilers','operational_status','prime_mover','fuel','nameplate_capacity_MW','capacity_factor','generation_MWh','generation_estimation_method','gen_year_online','gen_retirements'};
% kept operational status although Deetjen drops it -may be an omission of him; I think it's necessary so we can drop those units that are already retired
% kept associated generators - just in case I need them later; it seems like units can power more than 1 generator? which is odd
% kept the data sources for unit level data in case I want to analyze specific sources e.g. estimated vs copied from database
egrid_generator_data(find(isnan(egrid_generator_data.orispl)),:) = []; % drop excess rows

% Plant-level data
opts = detectImportOptions('egrid2019_data.xlsx','NumVariables',140,'Sheet','PLNT19','DataRange','A3:EJ12000','VariableNamesRange','A2:EJ2','TextType','string');
opts.SelectedVariableNames = {'PSTATABB','PNAME','ORISPL','ISORTO','NUMUNT','NUMGEN','PLPRMFL','PLFUELCT','CAPFAC','NAMEPCAP','PLHTIAN','PLHTIANT','PLNGENAN','PLNOXAN','PLSO2AN','PLCO2AN','PLCH4AN','PLN2OAN','PLCO2EQA','PLHGAN','PLNOXRTA','PLSO2RTA','PLCO2RTA','PLCH4RTA','PLN2ORTA','PLC2ERTA','PLHGRTA','PLHTRT'};
egrid_plant_data = readtable('egrid2019_data.xlsx',opts);
egrid_plant_data.Properties.VariableNames = {'state','plant_name','orispl','ISO','associated_units','associated_generators','primary_fuel','fuel_category','capacity_factor','nameplate_capacity_MW','combustion_heat_input','total_heat_input','generation_MWh','nox_emissions_tons','so2_emissions_tons','co2_emissions_tons','ch4_emissions_lbs','n2o_emissions_lbs','co2e_emissions_tons','hg_emissions_lbs','nox_emissions_rate_lbs_per_MWh','so2_emissions_rate_lb_per_MWh','co2_emissions_rate_lbs_per_MWh','ch4_emissions_rate_lbs_per_MWh','n2o_emissions_rate_lbs_per_MWh','co2e_emissions_rate_lbs_per_MWh','PLHGRTA','heat_rate_BTU_per_KWh'};
% kept operational status although Deetjen drops it -may be an omission of him; I think it's necessary so we can drop those units that are already retired
% kept associated generators - just in case I need them later; it seems like units can power more than 1 generator? which is odd
% kept the data sources for unit level data in case I want to analyze specific sources e.g. estimated vs copied from database
egrid_plant_data(find(isnan(egrid_plant_data.orispl)),:) = []; % drop excess rows

%% screening rules

% keep only the grid of interest

