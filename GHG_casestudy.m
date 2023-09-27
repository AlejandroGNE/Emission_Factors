% Estimate actual mitigation as well as the multiple MEF approximations
function [Emissions,Dispatch1,hourlyGHG1] = GHG_casestudy(region,load_changer,hourlyGHG0,MEF_data,gasprice)

%% Extract MEFs from big dataset

MEF1_8760 = MEF_data{1,1};
MEF2_8760 = MEF_data{2,1};
MEF3_8760 = MEF_data{3,1};
MEF4_8760 = MEF_data{4,1};
MEF5_8760 = MEF_data{5,1};

MEF1_spring = MEF_data{1,2}(1,:);
MEF2_spring = MEF_data{2,2}(1,:);
MEF3_spring = MEF_data{3,2}(1,:);
MEF4_spring = MEF_data{4,2}(1,:);
MEF5_spring = MEF_data{5,2}(1,:);

MEF1_summer = MEF_data{1,2}(2,:);
MEF2_summer = MEF_data{2,2}(2,:);
MEF3_summer = MEF_data{3,2}(2,:);
MEF4_summer = MEF_data{4,2}(2,:);
MEF5_summer = MEF_data{5,2}(2,:);

MEF1_fall = MEF_data{1,2}(3,:);
MEF2_fall = MEF_data{2,2}(3,:);
MEF3_fall = MEF_data{3,2}(3,:);
MEF4_fall = MEF_data{4,2}(3,:);
MEF5_fall = MEF_data{5,2}(3,:);

MEF1_winter = MEF_data{1,2}(4,:);
MEF2_winter = MEF_data{2,2}(4,:);
MEF3_winter = MEF_data{3,2}(4,:);
MEF4_winter = MEF_data{4,2}(4,:);
MEF5_winter = MEF_data{5,2}(4,:);

MEF1_24YA = MEF_data{1,3}(1,:);
MEF2_24YA = MEF_data{2,3}(1,:);
MEF3_24YA = MEF_data{3,3}(1,:);
MEF4_24YA = MEF_data{4,3}(1,:);
MEF5_24YA = MEF_data{5,3}(1,:);

MEF1_YA = MEF_data{1,4};
MEF2_YA = MEF_data{2,4};
MEF3_YA = MEF_data{3,4};
MEF4_YA = MEF_data{4,4};
MEF5_YA = MEF_data{5,4};

%% Starting code, load data, parameter specification
    storage = 0; % storage=1 if using storage model
    Periods     =   4;                      % Number of periods evaluated
    BPeriods    =   Periods + 4;            % Over-periods for proper cost accounting
    Year         =   2016;                  % Starting year
    monte        =   1;                     % Number of monte carlo simulations (1=deterministic)
    interest     =   0.05;                  % Interest rate
% New Plants Parameters by Technology Category
    load('Cap_small.mat','Cap_small');                  % Load input parameters aggregated by technology (e.g. HR, cap cost, fuel cost, etc.)
    Cap_cost = Cap_small;                   % Copy input params to local database
    num_tech = size(Cap_cost,1);            % Number of technologies (which equals number of rows in Cap_cost)
    name1 = strcat(Cap_cost.Fuel,'1');      % Names for new power plants 
% Current plants data for calculating fitness value (review purpose of 'for calculating fitness value' sentence)
    [plant,Var_Energy] = Plant_data(region);         % Calls function 'Plant_data' whit outputs 'MISO' and 'Var_Energy' (basically renaming the data files 'MISO_2020' & 'Var_energy', respectively)
    load('Global_pop','P0');                % For learning rates, starts from year 2015 to 2050 (Loads all contents from 'Global_pop.mat' i.e. 'P0' & 'Cap_small')
    load('NG_iter.mat','NG_mean');          % Natural Gas Prices data
%     NG_mean(35,1) = gasprice;                      % real natural gas price for 2020
    NG_iter=NG_mean;                        % Changes from distribution of Nat Gas Prices to mean value, for deterministic
    NG_iter=NG_iter(Year-1986+1:end,:)';    % Shapes input data to period of interest (base year through end)
    if region == 1
    load('Load2.mat','Load2');                          % Electricity Load data MISO
    elseif region== 2
    load('Load_NY_deter.mat','Load_NY_deter');                 % Electricity Load data NYISO
    Load2=Load_NY_deter;
    end
    if storage == 0
    plant(plant.Category == 'STORAGE',:) = [];
    end
    Load_monte = Load2;
%% Actual emissions, full year hourly resolution

Periods0 = 1;
BPeriods0 = Periods0 + 4;
x = zeros(num_tech*Periods0,1);
new_load = Load_monte;
new_load(1,:) = Load_monte(1,:) + load_changer;
[~,~,Dispatch1,hourlyGHG1,~,~] = CFAv4(BPeriods0,Periods0,Year,x,P0,plant,Var_Energy,interest,new_load,num_tech,name1,Cap_cost,NG_iter,monte);
GHG0 = sum(hourlyGHG0,'all'); % emissions without technology intervention
GHG1 = sum(hourlyGHG1,'all'); % emissions with 
GHG_true = (GHG1 - GHG0) * (0.000453522); % incremental emissions

%% Approximated emissions

    %% 8760 MEFs
    GHG_8760_MEF1 = nansum(load_changer .* MEF1_8760,'All');
    GHG_8760_MEF2 = nansum(load_changer .* MEF2_8760,'All');
    GHG_8760_MEF3 = nansum(load_changer .* MEF3_8760,'All');
    GHG_8760_MEF4 = nansum(load_changer .* MEF4_8760,'All');
    GHG_8760_MEF5 = nansum(load_changer .* MEF5_8760,'All');

    %% 24 hour time of day, seasonal averages MEFs

% seasonal cutoffs
spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_load_changer = reshape(load_changer(spring),24,[]);
summer_load_changer = reshape(load_changer(summer),24,[]);
fall_load_changer = reshape(load_changer(fall),24,[]);
winter_load_changer = reshape(load_changer(winter),24,[]);

spring_load_changer_24SA = mean(spring_load_changer,2,'omitnan')';
summer_load_changer_24SA = mean(summer_load_changer,2,'omitnan')';
fall_load_changer_24SA = mean(fall_load_changer,2,'omitnan')';
winter_load_changer_24SA = mean(winter_load_changer,2,'omitnan')';

GHG_24SA_MEF1 = (sum((spring_load_changer_24SA .* MEF1_spring),'all'))*size(spring_load_changer,2)+...
    (sum((summer_load_changer_24SA .* MEF1_summer),'all'))*size(summer_load_changer,2)+...
    (sum((fall_load_changer_24SA .* MEF1_fall),'all'))*size(fall_load_changer,2)+...
    (sum((winter_load_changer_24SA .* MEF1_winter),'all'))*size(winter_load_changer,2);
GHG_24SA_MEF2 = (sum((spring_load_changer_24SA .* MEF2_spring),'all'))*size(spring_load_changer,2)+...
    (sum((summer_load_changer_24SA .* MEF2_summer),'all'))*size(summer_load_changer,2)+...
    (sum((fall_load_changer_24SA .* MEF2_fall),'all'))*size(fall_load_changer,2)+...
    (sum((winter_load_changer_24SA .* MEF2_winter),'all'))*size(winter_load_changer,2);
GHG_24SA_MEF3 = (sum((spring_load_changer_24SA .* MEF3_spring),'all'))*size(spring_load_changer,2)+...
    (sum((summer_load_changer_24SA .* MEF3_summer),'all'))*size(summer_load_changer,2)+...
    (sum((fall_load_changer_24SA .* MEF3_fall),'all'))*size(fall_load_changer,2)+...
    (sum((winter_load_changer_24SA .* MEF3_winter),'all'))*size(winter_load_changer,2);
GHG_24SA_MEF4 = (sum((spring_load_changer_24SA .* MEF4_spring),'all'))*size(spring_load_changer,2)+...
    (sum((summer_load_changer_24SA .* MEF4_summer),'all'))*size(summer_load_changer,2)+...
    (sum((fall_load_changer_24SA .* MEF4_fall),'all'))*size(fall_load_changer,2)+...
    (sum((winter_load_changer_24SA .* MEF4_winter),'all'))*size(winter_load_changer,2);
GHG_24SA_MEF5 = (sum((spring_load_changer_24SA .* MEF5_spring),'all'))*size(spring_load_changer,2)+...
    (sum((summer_load_changer_24SA .* MEF5_summer),'all'))*size(summer_load_changer,2)+...
    (sum((fall_load_changer_24SA .* MEF5_fall),'all'))*size(fall_load_changer,2)+...
    (sum((winter_load_changer_24SA .* MEF5_winter),'all'))*size(winter_load_changer,2);

    %% 24 hour time of day, yearly averages
    
reshaped_load_changer = reshape(load_changer,[24,365]);
load_changer_24YA = mean(reshaped_load_changer,2,'omitnan')';

GHG_24YA_MEF1 = (sum((load_changer_24YA .* MEF1_24YA),'all'))*365;
GHG_24YA_MEF2 = (sum((load_changer_24YA .* MEF2_24YA),'all'))*365;
GHG_24YA_MEF3 = (sum((load_changer_24YA .* MEF3_24YA),'all'))*365;
GHG_24YA_MEF4 = (sum((load_changer_24YA .* MEF4_24YA),'all'))*365;
GHG_24YA_MEF5 = (sum((load_changer_24YA .* MEF5_24YA),'all'))*365;

    %% Yearly averages MEFs
    
load_changer_YA = sum(load_changer,'all','omitnan');

GHG_YA_MEF1 = load_changer_YA * MEF1_YA;
GHG_YA_MEF2 = load_changer_YA * MEF2_YA;
GHG_YA_MEF3 = load_changer_YA * MEF3_YA;
GHG_YA_MEF4 = load_changer_YA * MEF4_YA;
GHG_YA_MEF5 = load_changer_YA * MEF5_YA;

%% Export data

Emissions(1,1) = GHG_8760_MEF1;
Emissions(2,1) = GHG_8760_MEF2;
Emissions(3,1) = GHG_8760_MEF3;
Emissions(4,1) = GHG_8760_MEF4;
Emissions(5,1) = GHG_8760_MEF5;

Emissions(1,2) = GHG_24SA_MEF1;
Emissions(2,2) = GHG_24SA_MEF2;
Emissions(3,2) = GHG_24SA_MEF3;
Emissions(4,2) = GHG_24SA_MEF4;
Emissions(5,2) = GHG_24SA_MEF5;

Emissions(1,3) = GHG_24YA_MEF1;
Emissions(2,3) = GHG_24YA_MEF2;
Emissions(3,3) = GHG_24YA_MEF3;
Emissions(4,3) = GHG_24YA_MEF4;
Emissions(5,3) = GHG_24YA_MEF5;

Emissions(1,4) = GHG_YA_MEF1;
Emissions(2,4) = GHG_YA_MEF2;
Emissions(3,4) = GHG_YA_MEF3;
Emissions(4,4) = GHG_YA_MEF4;
Emissions(5,4) = GHG_YA_MEF5;

Emissions(6,1) = GHG_true;


