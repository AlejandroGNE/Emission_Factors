% Estimate MEFs for a given grid
function [MEF_data,Dispatch_data,hourlyGHG0,plant_tb0] = MEF_function(region,gasprice)
%% Starting code, load data, parameter specification
    storage = 0; % storage=1 if using storage model
    Year         =   2016;                  % Starting year
    monte        =   1;                     % Number of monte carlo simulations (1=deterministic)
    interest     =   0.05;                  % Interest rate
% New Plants Parameters by Technology Category
    load('Cap_small.mat','Cap_small');                  % Load input parameters aggregated by technology (e.g. HR, cap cost, fuel cost, etc.)
    Cap_cost = Cap_small;                   % Copy input params to local database
    num_tech = size(Cap_cost,1);            % Number of technologies (which equals number of rows in Cap_cost)
    name1 = strcat(Cap_cost.Fuel,'1');      
    [plant,Var_Energy] = Plant_data(region);         % Calls function 'Plant_data' whit outputs 'MISO' and 'Var_Energy' (basically renaming the data files 'MISO_2020' & 'Var_energy', respectively)
    load('Global_pop.mat','P0');                % For learning rates, starts from year 2015 to 2050 (Loads all contents from 'Global_pop.mat' i.e. '' & 'Cap_small')
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
    
%% 1- Emissions rate of plant at the margin

Periods0 = 1;
BPeriods0 = Periods0 + 4;
x = zeros(num_tech*Periods0,1);
[~,Emissions_rate0,Dispatch0,hourlyGHG0,plant_tb0,~] = CFAv4(BPeriods0,Periods0,Year,x,P0,plant,Var_Energy,interest,Load_monte,num_tech,name1,Cap_cost,NG_iter,monte);
plant_tb0 = table2struct(plant_tb0);
scatter(1:8760,Emissions_rate0,50,'.'); title('Hourly emissions rate of plant at the margin [lbsCO2e/MWh]'); xlabel('Hour of the year');
MEF1_8760 = (Emissions_rate0') * (0.000453522);
MEF1_sq = reshape(Emissions_rate0,[24,365]);
MEF1_24YA = (mean(MEF1_sq,2,'omitnan') * (0.000453522))';
MEF1_YA = mean(Emissions_rate0,'all','omitnan') * (0.000453522);

spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_Emissions_rate0 = reshape(Emissions_rate0(spring),24,[]);
summer_Emissions_rate0 = reshape(Emissions_rate0(summer),24,[]);
fall_Emissions_rate0 = reshape(Emissions_rate0(fall),24,[]);
winter_Emissions_rate0 = reshape(Emissions_rate0(winter),24,[]);

MEF1_spring = (mean(spring_Emissions_rate0,2,'omitnan') * (0.000453522))';
MEF1_summer = (mean(summer_Emissions_rate0,2,'omitnan') * (0.000453522))';
MEF1_fall = (mean(fall_Emissions_rate0,2,'omitnan') * (0.000453522))';
MEF1_winter = (mean(winter_Emissions_rate0,2,'omitnan') * (0.000453522))';
MEF1_24SA = [MEF1_spring; MEF1_summer; MEF1_fall; MEF1_winter];

MEF_data{2,1} = MEF1_8760;
MEF_data{2,2} = MEF1_24SA;
MEF_data{2,3} = MEF1_24YA;
MEF_data{2,4} = MEF1_YA;

Dispatch_data{1,1} = Dispatch0;

%% 2- Regression of total emissions ~ total load

Generation = Load2;
DeltaGHG = diff(hourlyGHG0);
DeltaGHG(1,8760) = hourlyGHG0(1)-hourlyGHG0(8760);
DeltaGeneration = diff(Generation(1,:));
DeltaGeneration(1,8760) = Generation(1,1)-Generation(1,8760);
MEF2_8760 = (DeltaGHG ./ DeltaGeneration) * (0.000453522);
DeltaGHG_sq = reshape(DeltaGHG,[24,365]);
DeltaGeneration_sq = reshape(DeltaGeneration,[24,365]);
for h = 24:-1:1
    MEF2_sq(1,h) = DeltaGeneration_sq(h,:)' \ DeltaGHG_sq(h,:)';
end
MEF2_24YA = MEF2_sq * (0.000453522);                    % tCO2e/MWh
MEF2_YA = (DeltaGeneration' \ DeltaGHG') * (0.000453522);

DeltaGeneration_spring_sq = reshape(DeltaGeneration(spring),24,[]);
DeltaGeneration_summer_sq = reshape(DeltaGeneration(summer),24,[]);
DeltaGeneration_fall_sq = reshape(DeltaGeneration(fall),24,[]);
DeltaGeneration_winter_sq = reshape(DeltaGeneration(winter),24,[]);

DeltaGHG_spring_sq = reshape(DeltaGHG(spring),24,[]);
DeltaGHG_summer_sq = reshape(DeltaGHG(summer),24,[]);
DeltaGHG_fall_sq = reshape(DeltaGHG(fall),24,[]);
DeltaGHG_winter_sq = reshape(DeltaGHG(winter),24,[]);

for h = 24:-1:1
    MEF2_spring_sq(1,h) = DeltaGeneration_spring_sq(h,:)' \ DeltaGHG_spring_sq(h,:)';
    MEF2_summer_sq(1,h) = DeltaGeneration_summer_sq(h,:)' \ DeltaGHG_summer_sq(h,:)';
    MEF2_fall_sq(1,h) = DeltaGeneration_fall_sq(h,:)' \ DeltaGHG_fall_sq(h,:)';
    MEF2_winter_sq(1,h) = DeltaGeneration_winter_sq(h,:)' \ DeltaGHG_winter_sq(h,:)';
end

MEF2_spring = MEF2_spring_sq * (0.000453522);
MEF2_summer = MEF2_summer_sq * (0.000453522);
MEF2_fall = MEF2_fall_sq * (0.000453522);
MEF2_winter = MEF2_winter_sq * (0.000453522);
MEF2_24SA = [MEF2_spring; MEF2_summer; MEF2_fall; MEF2_winter];

MEF_data{4,1} = MEF2_8760;
MEF_data{4,2} = MEF2_24SA;
MEF_data{4,3} = MEF2_24YA;
MEF_data{4,4} = MEF2_YA;

%% 3- Regression of total emissions ~ net load

Generation = Load2;
Generation(1,:) = sum(Dispatch0,1);
DeltaGHG = diff(hourlyGHG0);
DeltaGHG(1,8760) = hourlyGHG0(1)-hourlyGHG0(8760);
DeltaGeneration = diff(Generation(1,:));
DeltaGeneration(1,8760) = Generation(1,1)-Generation(1,8760);
MEF3_8760 = (DeltaGHG ./ DeltaGeneration) * (0.000453522);
DeltaGHG_sq = reshape(DeltaGHG,[24,365]);
DeltaGeneration_sq = reshape(DeltaGeneration,[24,365]);
for h = 24:-1:1
    MEF3_sq(1,h) = DeltaGeneration_sq(h,:)' \ DeltaGHG_sq(h,:)';
end
MEF3_24YA = MEF3_sq * (0.000453522);                    % tCO2e/MWh
MEF3_YA = (DeltaGeneration' \ DeltaGHG') * (0.000453522);

DeltaGeneration_spring_sq = reshape(DeltaGeneration(spring),24,[]);
DeltaGeneration_summer_sq = reshape(DeltaGeneration(summer),24,[]);
DeltaGeneration_fall_sq = reshape(DeltaGeneration(fall),24,[]);
DeltaGeneration_winter_sq = reshape(DeltaGeneration(winter),24,[]);

DeltaGHG_spring_sq = reshape(DeltaGHG(spring),24,[]);
DeltaGHG_summer_sq = reshape(DeltaGHG(summer),24,[]);
DeltaGHG_fall_sq = reshape(DeltaGHG(fall),24,[]);
DeltaGHG_winter_sq = reshape(DeltaGHG(winter),24,[]);

for h = 24:-1:1
    MEF3_spring_sq(1,h) = DeltaGeneration_spring_sq(h,:)' \ DeltaGHG_spring_sq(h,:)';
    MEF3_summer_sq(1,h) = DeltaGeneration_summer_sq(h,:)' \ DeltaGHG_summer_sq(h,:)';
    MEF3_fall_sq(1,h) = DeltaGeneration_fall_sq(h,:)' \ DeltaGHG_fall_sq(h,:)';
    MEF3_winter_sq(1,h) = DeltaGeneration_winter_sq(h,:)' \ DeltaGHG_winter_sq(h,:)';
end

MEF3_spring = MEF3_spring_sq * (0.000453522);
MEF3_summer = MEF3_summer_sq * (0.000453522);
MEF3_fall = MEF3_fall_sq * (0.000453522);
MEF3_winter = MEF3_winter_sq * (0.000453522);
MEF3_24SA = [MEF3_spring; MEF3_summer; MEF3_fall; MEF3_winter];

MEF_data{3,1} = MEF3_8760;
MEF_data{3,2} = MEF3_24SA;
MEF_data{3,3} = MEF3_24YA;
MEF_data{3,4} = MEF3_YA;

%% 4- Emissions of adding 1 MW to load

Load0 = Load_monte(1,:);
plants = size(Dispatch0,1);
[P0]= load('Global_pop.mat','P0');
P0 = P0.P0;
parfor h = 1:24
    Load_increase = zeros(1,8760);
    Load_increase(1,h:24:24*365) = 0.001;
    New_Load = Load0 + Load_increase;
    [~,~,Dispatch9,new_hourly_GHG90,~,Last_dispatched] = CFAv4(BPeriods0,Periods0,Year,x,P0,plant,Var_Energy,interest,New_Load,num_tech,name1,Cap_cost,NG_iter,monte);
    new_hourly_GHG90 = reshape(new_hourly_GHG90,24,365)
    Last_dispatched = reshape(Last_dispatched,24,365)
    for d = 1:365
        New_Emissions_square(h,d) = new_hourly_GHG90(h,d);
        Last_dispatched90_square(h,d) = Last_dispatched(h,d);
        for g = 1:plants
            sliced_dispatch_in = reshape(Dispatch9(g,:),24,365);
            sliced_dispatch_out(g,h,d) = sliced_dispatch_in(h,d);
        end
    end
end
New_Emissions = reshape(New_Emissions_square,1,8760); 
Last_dispatched_1moreMW = reshape(Last_dispatched90_square,1,8760);
for g = plants:-1:1
    Dispatch_1moreMW(g,:) = reshape(sliced_dispatch_out(g,:,:),1,8760);
end

Delta_Emissions_1moreMW = New_Emissions - hourlyGHG0;
MEF4_8760 = (Delta_Emissions_1moreMW) * (0.000453522);
MEF4_sq = reshape(Delta_Emissions_1moreMW,[24,365]);
MEF4_24YA = (mean(MEF4_sq,2,'omitnan') * (0.000453522))';
MEF4_YA = (mean(Delta_Emissions_1moreMW,'all','omitnan') * (0.000453522))';
scatter(1:8760,Delta_Emissions_1moreMW,50,'.'); title('Emissions of adding 1 MW of demand each hour [lbsCO2e/MWh]'); xlabel('Hour of the year');

spring_Delta_Emissions_1moreMW = reshape(Delta_Emissions_1moreMW(spring),24,[]);
summer_Delta_Emissions_1moreMW = reshape(Delta_Emissions_1moreMW(summer),24,[]);
fall_Delta_Emissions_1moreMW = reshape(Delta_Emissions_1moreMW(fall),24,[]);
winter_Delta_Emissions_1moreMW = reshape(Delta_Emissions_1moreMW(winter),24,[]);

MEF4_spring = (mean(spring_Delta_Emissions_1moreMW,2,'omitnan') * (0.000453522))';
MEF4_summer = (mean(summer_Delta_Emissions_1moreMW,2,'omitnan') * (0.000453522))';
MEF4_fall = (mean(fall_Delta_Emissions_1moreMW,2,'omitnan') * (0.000453522))';
MEF4_winter = (mean(winter_Delta_Emissions_1moreMW,2,'omitnan') * (0.000453522))';
MEF4_24SA = [MEF4_spring; MEF4_summer; MEF4_fall; MEF4_winter];

% uncomment to run 1+kWh
MEF_data{1,1} = MEF4_8760 * 1000;
MEF_data{1,2} = MEF4_24SA * 1000;
MEF_data{1,3} = MEF4_24YA * 1000;
MEF_data{1,4} = MEF4_YA * 1000;

% MEF_data{1,1} = MEF4_8760;
% MEF_data{1,2} = MEF4_24SA;
% MEF_data{1,3} = MEF4_24YA;
% MEF_data{1,4} = MEF4_YA;

Dispatch_data{2,1} = Dispatch_1moreMW;

%% 5- System-average emissions

    AEF_8760 = (hourlyGHG0 ./ Load2(1,:)) * (0.000453522);
    AEF_sq = reshape(AEF_8760,[24,365]);
    AEF_24YA = (mean(AEF_sq,2,'omitnan'))';
    AEF_YA = mean(AEF_8760,'all','omitnan');

spring_AEF = reshape(AEF_8760(spring),24,[]);
summer_AEF = reshape(AEF_8760(summer),24,[]);
fall_AEF = reshape(AEF_8760(fall),24,[]);
winter_AEF = reshape(AEF_8760(winter),24,[]);

AEF_spring = (mean(spring_AEF,2,'omitnan'))';
AEF_summer = (mean(summer_AEF,2,'omitnan'))';
AEF_fall = (mean(fall_AEF,2,'omitnan'))';
AEF_winter = (mean(winter_AEF,2,'omitnan'))';
AEF_24SA = [AEF_spring; AEF_summer; AEF_fall; AEF_winter];

MEF_data{5,1} = AEF_8760;
MEF_data{5,2} = AEF_24SA;
MEF_data{5,3} = AEF_24YA;
MEF_data{5,4} = AEF_YA;

%% Emissions of subtracting 1 MW to load

% Cancelled this part since we realized by mere analysis that 1 less MW is
% not as different, only in some very particular exceptions.

% Load0 = Load_monte(1,:);
% plants = size(Dispatch0,1);
% parfor h = 1:24
%     Load_increase = zeros(1,8760);
%     Load_increase(1,h:24:24*365) = -1;
%     New_Load = Load0 + Load_increase;
%     [~,~,Dispatch9,new_hourly_GHG90,~,Last_dispatched] = CFAv4(BPeriods0,Periods0,Year,x,P0,plant,Var_Energy,interest,New_Load,num_tech,name1,Cap_cost,NG_iter,monte);
%     new_hourly_GHG90 = reshape(new_hourly_GHG90,24,365)
%     Last_dispatched = reshape(Last_dispatched,24,365)
%     for d = 1:365
%         New_Emissions_square(h,d) = new_hourly_GHG90(h,d);
%         Last_dispatched90_square(h,d) = Last_dispatched(h,d);
%         for g = 1:plants
%             sliced_dispatch_in = reshape(Dispatch9(g,:),24,365);
%             sliced_dispatch_out(g,h,d) = sliced_dispatch_in(h,d);
%         end
%     end
% end
% New_Emissions = reshape(New_Emissions_square,1,8760); 
% Last_dispatched_1lessMW = reshape(Last_dispatched90_square,1,8760);
% for g = plants:-1:1
%     Dispatch_1lessMW(g,:) = reshape(sliced_dispatch_out(g,:,:),1,8760);
% end
% 
% Delta_Emissions_1lessMW = hourlyGHG0 - New_Emissions;
% MEF5_8760 = (Delta_Emissions_1lessMW) * (0.000453522);
% MEF5_sq = reshape(Delta_Emissions_1lessMW,[24,365]);
% MEF5_24YA = (mean(MEF5_sq,2,'omitnan') * (0.000453522))';
% MEF5_YA = (mean(Delta_Emissions_1lessMW,'all','omitnan') * (0.000453522))';
% scatter(1:8760,Delta_Emissions_1lessMW,50,'.'); title('Emissions of adding 1 MW of demand each hour [lbsCO2e/MWh]'); xlabel('Hour of the year');
% 
% spring_Delta_Emissions_1lessMW = reshape(Delta_Emissions_1lessMW(spring),24,[]);
% summer_Delta_Emissions_1lessMW = reshape(Delta_Emissions_1lessMW(summer),24,[]);
% fall_Delta_Emissions_1lessMW = reshape(Delta_Emissions_1lessMW(fall),24,[]);
% winter_Delta_Emissions_1lessMW = reshape(Delta_Emissions_1lessMW(winter),24,[]);
% 
% MEF5_spring = (mean(spring_Delta_Emissions_1lessMW,2,'omitnan') * (0.000453522))';
% MEF5_summer = (mean(summer_Delta_Emissions_1lessMW,2,'omitnan') * (0.000453522))';
% MEF5_fall = (mean(fall_Delta_Emissions_1lessMW,2,'omitnan') * (0.000453522))';
% MEF5_winter = (mean(winter_Delta_Emissions_1lessMW,2,'omitnan') * (0.000453522))';
% MEF5_24SA = [MEF5_spring; MEF5_summer; MEF5_fall; MEF5_winter];
% 
% MEF_data{5,1} = MEF5_8760;
% MEF_data{5,2} = MEF5_24SA;
% MEF_data{5,3} = MEF5_24YA;
% MEF_data{5,4} = MEF5_YA;

% Dispatch_data{3,1} = Dispatch_1moreMW;
