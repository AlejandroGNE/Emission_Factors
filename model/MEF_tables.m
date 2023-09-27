clear;
gas_prices = [2 2.5 3 3.5 4 6 8 10 12]; %#ok<*NOPTS>
for i = 1:length(gas_prices)
gas_price_string = string(gas_prices(i));
gas_price_string = strrep(gas_price_string,'.','_');
filename = strcat('MEFs_BOXX_01-Jun-2022_gasprice_',...
    gas_price_string,'$_MMBTU.mat');
load(filename)
techs = 3; grids = 2;
all_data_tCO2e = zeros(6*techs,4*grids);
all_data_percent = zeros(5*techs,4*grids);
for casestudy = 1:techs
for region = 1:grids
Emissions_data = Emissions{casestudy}{region};
Approximations = Emissions_data(1:5,1:4);
Actual_value = Emissions_data(6,1);
Percent_error =...
    ((Approximations - Actual_value)/Actual_value)*100;
rows = ((casestudy*6)-5):casestudy*6;
columns = ((region*4)-3):region*4;
all_data_tCO2e(rows,columns) = Emissions_data;
rows = ((casestudy*5)-4):casestudy*5;
all_data_percent(rows,columns) = Percent_error;
end
end
methods = 5; timespans = 4;
% master table is 5x4, plus the totals, so 6x5
master_table = zeros(6,5);
for method = 1:methods
    for timespan = 1:timespans
        rows = method:5:techs*methods;
        columns = timespan:4:2*4;
        master_table(method,timespan) =...
            mean(abs(all_data_percent(rows,columns)),'all');
    end
end
master_table(:,end) = mean(master_table(:,1:end-1)')';
master_table(end,:) = mean(master_table(1:end-1,:));
master_table = round(master_table,1);
master_table = string(master_table);
master_table = reshape(master_table,1,[]);
for j = 1:length(master_table)
    master_table(j) = strcat(master_table(j),'%');
end
master_table = reshape(master_table,6,[]);

master_table = array2table(master_table);
row_names = {...
    'Incremental MEF',...
    'Costliest MEF',...
    'Thermal MEF',...
    'Demand MEF',...
    'AEF',...
    'Total'};
column_names = {...
    'Hourly',...
    '24-hr Seasonal Average',...
    '24-hr Annual Average',...
    'Annual Average',...
    'Total'};
master_table.Properties.RowNames = row_names;
master_table.Properties.VariableNames = column_names;
% results_filename = strcat(...
%     'MEFs_results_gasprice_',...
%     gas_price_string,'$_MMBTU.txt');
% fileID = fopen(results_filename,'w');
% fprintf(fileID,master_table);
end