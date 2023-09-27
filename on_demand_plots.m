% On-demand plots function
function [ondemand] = on_demand_plots(regionn,dispatch,hourlyGHG,Plotpath,MEF_data)
%% Uncomment to run without function call
regionn = 1;
dispatch = Dispatch_data{1,regionn}{1,1};
hourlyGHG = hourlyGHG0{1,regionn};
MEF_data = MEF_data{1,regionn};
[plant_data,Var_Energy] = Plant_data(regionn);
plant_tb = plant_data; % <-- only if plotting detailed RW gen

%% Name files
if regionn == 1
    region = 'MISO';
elseif regionn == 2
        region = 'NYISO';
end

if regionn == 1
load('Load2');                          % Electricity Load data MISO
elseif regionn== 2
load('Load_NY_deter');                 % Electricity Load data NYISO
Load2=Load_NY_deter;
end

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

%% Plot 8769 MEF for thermal in MISO
Reshaped_MEF3_8760 = reshape(MEF3_8760,24,365);
MEF3_marker = '-^'; MEF3_color = [0.9290,   0.6940, 0.1250, 0.2];
plot(1:24,Reshaped_MEF3_8760(:,1),MEF3_marker,'Color',MEF3_color);
hold on
for day = size(Reshaped_MEF3_8760,2):-1:2
    plot(1:24,Reshaped_MEF3_8760(:,day),MEF3_marker,'Color',MEF3_color);
end
hold off
box off
set(gca,'FontSize',15)
title('Thermal MEF 8760 (tCO2e/MWh)')
% saveas(gcf,strcat(Plotpath,region,'_','MEF3_8760.png'));

MEF3_8760_positive_outliers = MEF3_8760(1,MEF3_8760>5)
MEF3_8760_negative_outliers = MEF3_8760(1,MEF3_8760<-5)
[~,houroftheyear] = find(MEF3_8760<-5);
dayoftheyear = floor(houroftheyear/24);
houroftheday = (houroftheyear/24 - dayoftheyear)*24

thermal_generation = sum(dispatch);

thermal_generation(1341)-thermal_generation(1340)
hourlyGHG(1341)-hourlyGHG(1340)

%% Why negative MEF for MISO MEF2 in the fall?
% Plot 24-hour slices of sesonal trends (seasonal spaghettis)
%% Total generation
Load_monte = Load2; 

Load_1styear = Load_monte(1,:);

spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_Load_1styear = reshape(Load_1styear(spring),24,[]);
summer_Load_1styear = reshape(Load_1styear(summer),24,[]);
fall_Load_1styear = reshape(Load_1styear(fall),24,[]);
winter_Load_1styear = reshape(Load_1styear(winter),24,[]);

%               R           G       B           alpha
spring_color =  [1,         0,      1,          0.2];
summer_color =  [0.929,     0.694,  0.125,      .2];
fall_color =    [0.,        1,      0,          .2];
winter_color =  [0,         0,      1,          .2];

plot(1:24,spring_Load_1styear(:,1),'Color',spring_color);
hold on
for day = size(spring_Load_1styear,2):-1:2
    plot(1:24,spring_Load_1styear(:,day),'Color',spring_color);
end

plot(1:24,summer_Load_1styear(:,1),'Color',summer_color);
for day = size(summer_Load_1styear,2):-1:2
    plot(1:24,summer_Load_1styear(:,day),'Color',summer_color);
end

plot(1:24,winter_Load_1styear(:,1),'Color',winter_color);
for day = size(winter_Load_1styear,2):-1:2
    plot(1:24,winter_Load_1styear(:,day),'Color',winter_color);
end

plot(1:24,fall_Load_1styear(:,1),'Color',fall_color);
for day = size(fall_Load_1styear,2):-1:2
    plot(1:24,fall_Load_1styear(:,day),'Color',fall_color);
end

hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
title('Total generation (MWh)')
if regionn == 1
text(3,55000,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(16,115000,'summer','Fontsize',15,'Color',summer_color)
text(16,65000,'fall','Fontsize',15,'Color',fall_color)
text(3,85000,'winter','Fontsize',15,'Color',winter_color)
ylim([40000 120000])
elseif regionn == 2
text(17,15000,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(20,30800,'summer','Fontsize',15,'Color',summer_color)
text(3,11500,'fall','Fontsize',15,'Color',fall_color)
text(19,25000,'winter','Fontsize',15,'Color',winter_color)
ylim([0 35000])
end
saveas(gcf,strcat(Plotpath,region,'_','Seasonal_load.png'));
%% Thermal generation
Netload = sum(dispatch,1);

spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_Netload = reshape(Netload(spring),24,[]);
summer_Netload = reshape(Netload(summer),24,[]);
fall_Netload = reshape(Netload(fall),24,[]);
winter_Netload = reshape(Netload(winter),24,[]);

%               R           G       B           alpha
spring_color =  [1,         0,      1,          0.2];
summer_color =  [0.929,     0.694,  0.125,      .2];
fall_color =    [0.,        1,      0,          .2];
winter_color =  [0,         0,      1,          .2];

plot(1:24,spring_Netload(:,1),'Color',spring_color);
hold on
for day = size(spring_Netload,2):-1:2
    plot(1:24,spring_Netload(:,day),'Color',spring_color);
end

plot(1:24,summer_Netload(:,1),'Color',summer_color);
for day = size(summer_Netload,2):-1:2
    plot(1:24,summer_Netload(:,day),'Color',summer_color);
end

plot(1:24,winter_Netload(:,1),'Color',winter_color);
for day = size(winter_Netload,2):-1:2
    plot(1:24,winter_Netload(:,day),'Color',winter_color);
end

plot(1:24,fall_Netload(:,1),'Color',fall_color);
for day = size(fall_Netload,2):-1:2
    plot(1:24,fall_Netload(:,day),'Color',fall_color);
end

hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
title('Thermal generation (MWh)')
if regionn == 1
text(6,45000,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(16,105000,'summer','Fontsize',15,'Color',summer_color)
text(20,50000,'fall','Fontsize',15,'Color',fall_color)
text(2,75000,'winter','Fontsize',15,'Color',winter_color)
ylim([40000 120000])
elseif regionn == 2
text(17,8700,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(20,25300,'summer','Fontsize',15,'Color',summer_color)
text(3,3500,'fall','Fontsize',15,'Color',fall_color)
text(19,19400,'winter','Fontsize',15,'Color',winter_color)
ylim([0 35000])
end
saveas(gcf,strcat(Plotpath,region,'_','Seasonal_net_load.png'));
%% Renewable generation
Renewable_output = Load_1styear - Netload;

spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_Renewable_output = reshape(Renewable_output(spring),24,[]);
summer_Renewable_output = reshape(Renewable_output(summer),24,[]);
fall_Renewable_output = reshape(Renewable_output(fall),24,[]);
winter_Renewable_output = reshape(Renewable_output(winter),24,[]);

%               R           G       B           alpha
spring_color =  [1,         0,      1,          0.2];
summer_color =  [0.929,     0.694,  0.125,      .2];
fall_color =    [0.,        1,      0,          .2];
winter_color =  [0,         0,      1,          .2];

plot(1:24,spring_Renewable_output(:,1),'Color',spring_color);
hold on
for day = size(spring_Renewable_output,2):-1:2
    plot(1:24,spring_Renewable_output(:,day),'Color',spring_color);
end

plot(1:24,summer_Renewable_output(:,1),'Color',summer_color);
for day = size(summer_Renewable_output,2):-1:2
    plot(1:24,summer_Renewable_output(:,day),'Color',summer_color);
end

plot(1:24,winter_Renewable_output(:,1),'Color',winter_color);
for day = size(winter_Renewable_output,2):-1:2
    plot(1:24,winter_Renewable_output(:,day),'Color',winter_color);
end

plot(1:24,fall_Renewable_output(:,1),'Color',fall_color);
for day = size(fall_Renewable_output,2):-1:2
    plot(1:24,fall_Renewable_output(:,day),'Color',fall_color);
end

hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
title('Renewable generation (MWh)')
if regionn == 1
text(13,14890,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(8,3000,'summer','Fontsize',15,'Color',summer_color)
text(15,4900,'fall','Fontsize',15,'Color',fall_color)
text(3,16000,'winter','Fontsize',15,'Color',winter_color)
ylim([0 20000])
elseif regionn == 2
text(5,5700,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(10,5700,'summer','Fontsize',15,'Color',summer_color)
text(15,5700,'fall','Fontsize',15,'Color',fall_color)
text(20,5700,'winter','Fontsize',15,'Color',winter_color)
end
saveas(gcf,strcat(Plotpath,region,'_','Seasonal_renewable_output.png'));
%% Emissions
hourlyGHG = hourlyGHG * (0.000453522);
spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_hourlyGHG = reshape(hourlyGHG(spring),24,[]);
summer_hourlyGHG = reshape(hourlyGHG(summer),24,[]);
fall_hourlyGHG = reshape(hourlyGHG(fall),24,[]);
winter_hourlyGHG = reshape(hourlyGHG(winter),24,[]);

%               R           G       B           alpha
spring_color =  [1,         0,      1,          0.2];
summer_color =  [0.929,     0.694,  0.125,      .2];
fall_color =    [0.,        1,      0,          .2];
winter_color =  [0,         0,      1,          .2];

plot(1:24,spring_hourlyGHG(:,1),'Color',spring_color);
hold on
for day = size(spring_hourlyGHG,2):-1:2
    plot(1:24,spring_hourlyGHG(:,day),'Color',spring_color);
end

plot(1:24,summer_hourlyGHG(:,1),'Color',summer_color);
for day = size(summer_hourlyGHG,2):-1:2
    plot(1:24,summer_hourlyGHG(:,day),'Color',summer_color);
end

plot(1:24,winter_hourlyGHG(:,1),'Color',winter_color);
for day = size(winter_hourlyGHG,2):-1:2
    plot(1:24,winter_hourlyGHG(:,day),'Color',winter_color);
end

plot(1:24,fall_hourlyGHG(:,1),'Color',fall_color);
for day = size(fall_hourlyGHG,2):-1:2
    plot(1:24,fall_hourlyGHG(:,day),'Color',fall_color);
end

hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
title('Emissions (tCO2e)')
if regionn == 1
text(3,35000,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(15,76350,'summer','Fontsize',15,'Color',summer_color)
text(20,45000,'fall','Fontsize',15,'Color',fall_color)
text(2,61000,'winter','Fontsize',15,'Color',winter_color)
elseif regionn == 2
text(18,1200,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(18,8200,'summer','Fontsize',15,'Color',summer_color)
text(10,1000,'fall','Fontsize',15,'Color',fall_color)
text(20,5100,'winter','Fontsize',15,'Color',winter_color)
end
saveas(gcf,strcat(Plotpath,region,'_','Seasonal_emissions.png'));
%% Wind output
WindCF = Var_Energy{:,2};

spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_WindCF = reshape(WindCF(spring),24,[]);
summer_WindCF = reshape(WindCF(summer),24,[]);
fall_WindCF = reshape(WindCF(fall),24,[]);
winter_WindCF = reshape(WindCF(winter),24,[]);

%               R           G       B           alpha
spring_color =  [1,         0,      1,          0.2];
summer_color =  [0.929,     0.694,  0.125,      .2];
fall_color =    [0.,        1,      0,          .2];
winter_color =  [0,         0,      1,          .2];

plot(1:24,spring_WindCF(:,1),'Color',spring_color);
hold on
for day = size(spring_WindCF,2):-1:2
    plot(1:24,spring_WindCF(:,day),'Color',spring_color);
end

plot(1:24,summer_WindCF(:,1),'Color',summer_color);
for day = size(summer_WindCF,2):-1:2
    plot(1:24,summer_WindCF(:,day),'Color',summer_color);
end

plot(1:24,winter_WindCF(:,1),'Color',winter_color);
for day = size(winter_WindCF,2):-1:2
    plot(1:24,winter_WindCF(:,day),'Color',winter_color);
end

plot(1:24,fall_WindCF(:,1),'Color',fall_color);
for day = size(fall_WindCF,2):-1:2
    plot(1:24,fall_WindCF(:,day),'Color',fall_color);
end

hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
title('Wind capacity factor (%)')
if regionn == 1
text(12,0.55,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(7,0.05,'summer','Fontsize',15,'Color',summer_color)
text(12,0.6,'fall','Fontsize',15,'Color',fall_color)
text(12,0.65,'winter','Fontsize',15,'Color',winter_color)
elseif regionn == 2
text(5,0.95,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(10,0.95,'summer','Fontsize',15,'Color',summer_color)
text(15,0.95,'fall','Fontsize',15,'Color',fall_color)
text(20,0.95,'winter','Fontsize',15,'Color',winter_color)
end
saveas(gcf,strcat(Plotpath,region,'_','Seasonal_windCF.png'));

%% Δ Total generation

DeltaLoad = diff(Load_1styear);
DeltaLoad(1,8760) = Load_1styear(1)-Load_1styear(8760);
    
spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_DeltaLoad = reshape(DeltaLoad(spring),24,[]);
summer_DeltaLoad = reshape(DeltaLoad(summer),24,[]);
fall_DeltaLoad = reshape(DeltaLoad(fall),24,[]);
winter_DeltaLoad = reshape(DeltaLoad(winter),24,[]);

%               R           G       B           alpha
spring_color =  [1,         0,      1,          0.2];
summer_color =  [0.929,     0.694,  0.125,      .2];
fall_color =    [0.,        1,      0,          .2];
winter_color =  [0,         0,      1,          .2];

plot(1:24,spring_DeltaLoad(:,1),'Color',spring_color);
hold on
for day = size(spring_DeltaLoad,2):-1:2
    plot(1:24,spring_DeltaLoad(:,day),'Color',spring_color);
end

plot(1:24,summer_DeltaLoad(:,1),'Color',summer_color);
for day = size(summer_DeltaLoad,2):-1:2
    plot(1:24,summer_DeltaLoad(:,day),'Color',summer_color);
end

plot(1:24,winter_DeltaLoad(:,1),'Color',winter_color);
for day = size(winter_DeltaLoad,2):-1:2
    plot(1:24,winter_DeltaLoad(:,day),'Color',winter_color);
end

plot(1:24,fall_DeltaLoad(:,1),'Color',fall_color);
for day = size(fall_DeltaLoad,2):-1:2
    plot(1:24,fall_DeltaLoad(:,day),'Color',fall_color);
end

% xline(16)

hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
title('Δ Total generation (MWh)')
if regionn == 1
text(20.5,1600,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(9,5900,'summer','Fontsize',15,'Color',summer_color)
text(14.5,2600,'fall','Fontsize',15,'Color',fall_color)
text(19.5,4200,'winter','Fontsize',15,'Color',winter_color)
% ylim([40000 120000])
elseif regionn == 2
text(20,740,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(15,-1300,'summer','Fontsize',15,'Color',summer_color)
text(13,1140,'fall','Fontsize',15,'Color',fall_color)
text(12,-685,'winter','Fontsize',15,'Color',winter_color)
% ylim([40000 120000])
end
saveas(gcf,strcat(Plotpath,region,'_','Seasonal_delta_load.png'));
%% Δ Thermal generation

DeltaNetLoad = diff(Netload);
DeltaNetLoad(1,8760) = Netload(1)-Netload(8760);


spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_DeltaNetLoad = reshape(DeltaNetLoad(spring),24,[]);
summer_DeltaNetLoad = reshape(DeltaNetLoad(summer),24,[]);
fall_DeltaNetLoad = reshape(DeltaNetLoad(fall),24,[]);
winter_DeltaNetLoad = reshape(DeltaNetLoad(winter),24,[]);

%               R           G       B           alpha
spring_color =  [1,         0,      1,          0.2];
summer_color =  [0.929,     0.694,  0.125,      .2];
fall_color =    [0.,        1,      0,          .2];
winter_color =  [0,         0,      1,          .2];

plot(1:24,spring_DeltaNetLoad(:,1),'Color',spring_color);
hold on
for day = size(spring_DeltaNetLoad,2):-1:2
    plot(1:24,spring_DeltaNetLoad(:,day),'Color',spring_color);
end

plot(1:24,summer_DeltaNetLoad(:,1),'Color',summer_color);
for day = size(summer_DeltaNetLoad,2):-1:2
    plot(1:24,summer_DeltaNetLoad(:,day),'Color',summer_color);
end

plot(1:24,winter_DeltaNetLoad(:,1),'Color',winter_color);
for day = size(winter_DeltaNetLoad,2):-1:2
    plot(1:24,winter_DeltaNetLoad(:,day),'Color',winter_color);
end

plot(1:24,fall_DeltaNetLoad(:,1),'Color',fall_color);
for day = size(fall_DeltaNetLoad,2):-1:2
    plot(1:24,fall_DeltaNetLoad(:,day),'Color',fall_color);
end

% xline(16)

hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
title('Δ Thermal generation (MWh)')
if regionn == 1
text(20.5,1711,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(10.5,4728,'summer','Fontsize',15,'Color',summer_color)
text(16,-3800,'fall','Fontsize',15,'Color',fall_color)
text(10,-2500,'winter','Fontsize',15,'Color',winter_color)
% ylim([40000 120000])
elseif regionn == 2
text(20,740,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(15,-1300,'summer','Fontsize',15,'Color',summer_color)
text(13.5,1140,'fall','Fontsize',15,'Color',fall_color)
text(12,-685,'winter','Fontsize',15,'Color',winter_color)
% ylim([40000 120000])
end
saveas(gcf,strcat(Plotpath,region,'_','Seasonal_delta_net_load.png'));
%% Δ Renewable generation

Delta_Renewable_output = diff(Renewable_output);
Delta_Renewable_output(1,8760) = Renewable_output(1)-Renewable_output(8760);

spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_Delta_Renewable_output = reshape(Delta_Renewable_output(spring),24,[]);
summer_Delta_Renewable_output = reshape(Delta_Renewable_output(summer),24,[]);
fall_Delta_Renewable_output = reshape(Delta_Renewable_output(fall),24,[]);
winter_Delta_Renewable_output = reshape(Delta_Renewable_output(winter),24,[]);

%               R           G       B           alpha
spring_color =  [1,         0,      1,          0.2];
summer_color =  [0.929,     0.694,  0.125,      .2];
fall_color =    [0.,        1,      0,          .2];
winter_color =  [0,         0,      1,          .2];

plot(1:24,spring_Delta_Renewable_output(:,1),'Color',spring_color);
hold on
for day = size(spring_Delta_Renewable_output,2):-1:2
    plot(1:24,spring_Delta_Renewable_output(:,day),'Color',spring_color);
end

plot(1:24,summer_Delta_Renewable_output(:,1),'Color',summer_color);
for day = size(summer_Delta_Renewable_output,2):-1:2
    plot(1:24,summer_Delta_Renewable_output(:,day),'Color',summer_color);
end

plot(1:24,winter_Delta_Renewable_output(:,1),'Color',winter_color);
for day = size(winter_Delta_Renewable_output,2):-1:2
    plot(1:24,winter_Delta_Renewable_output(:,day),'Color',winter_color);
end

plot(1:24,fall_Delta_Renewable_output(:,1),'Color',fall_color);
for day = size(fall_Delta_Renewable_output,2):-1:2
    plot(1:24,fall_Delta_Renewable_output(:,day),'Color',fall_color);
end

% xline(16)

hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
title('Δ Renewable generation (MWh)')
if regionn == 1
text(19.5,2400,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(10.5,1400,'summer','Fontsize',15,'Color',summer_color)
text(14,2400,'fall','Fontsize',15,'Color',fall_color)
text(21,-1220,'winter','Fontsize',15,'Color',winter_color)
% ylim([40000 120000])
elseif regionn == 2
text(5,-1200,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(10,-1200,'summer','Fontsize',15,'Color',summer_color)
text(15,-1200,'fall','Fontsize',15,'Color',fall_color)
text(20,-1200,'winter','Fontsize',15,'Color',winter_color)
% ylim([40000 120000])
end
saveas(gcf,strcat(Plotpath,region,'_','Seasonal_delta_renewable_output.png'));
%% Δ Emissions

DeltahourlyGHG = diff(hourlyGHG);
DeltahourlyGHG(1,8760) = hourlyGHG(1)-hourlyGHG(8760);

spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_DeltahourlyGHG = reshape(DeltahourlyGHG(spring),24,[]);
summer_DeltahourlyGHG = reshape(DeltahourlyGHG(summer),24,[]);
fall_DeltahourlyGHG = reshape(DeltahourlyGHG(fall),24,[]);
winter_DeltahourlyGHG = reshape(DeltahourlyGHG(winter),24,[]);

%               R           G       B           alpha
spring_color =  [1,         0,      1,          0.2];
summer_color =  [0.929,     0.694,  0.125,      .2];
fall_color =    [0.,        1,      0,          .2];
winter_color =  [0,         0,      1,          .2];

plot(1:24,spring_DeltahourlyGHG(:,1),'Color',spring_color);
hold on
for day = size(spring_DeltahourlyGHG,2):-1:2
    plot(1:24,spring_DeltahourlyGHG(:,day),'Color',spring_color);
end

plot(1:24,summer_DeltahourlyGHG(:,1),'Color',summer_color);
for day = size(summer_DeltahourlyGHG,2):-1:2
    plot(1:24,summer_DeltahourlyGHG(:,day),'Color',summer_color);
end

plot(1:24,winter_DeltahourlyGHG(:,1),'Color',winter_color);
for day = size(winter_DeltahourlyGHG,2):-1:2
    plot(1:24,winter_DeltahourlyGHG(:,day),'Color',winter_color);
end

plot(1:24,fall_DeltahourlyGHG(:,1),'Color',fall_color);
for day = size(fall_DeltahourlyGHG,2):-1:2
    plot(1:24,fall_DeltahourlyGHG(:,day),'Color',fall_color);
end

% xline(16)

hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
title('Δ Emissions(tCO2e)')
if regionn == 1
text(18,-5000,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(16.5,-2800,'summer','Fontsize',15,'Color',summer_color)
text(10,3000,'fall','Fontsize',15,'Color',fall_color)
text(7,-590,'winter','Fontsize',15,'Color',winter_color)
% ylim([40000 120000])
elseif regionn == 2
text(19.5,290,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(19,-1024,'summer','Fontsize',15,'Color',summer_color)
text(14,608,'fall','Fontsize',15,'Color',fall_color)
text(17.5,711,'winter','Fontsize',15,'Color',winter_color)
% ylim([40000 120000])
end
saveas(gcf,strcat(Plotpath,region,'_','Seasonal_delta_emissions.png'));
%% Δ Wind output

DeltaWindCF = diff(WindCF');
DeltaWindCF(1,8760) = WindCF(1)-WindCF(8760);


spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_DeltaWindCF = reshape(DeltaWindCF(spring),24,[]);
summer_DeltaWindCF = reshape(DeltaWindCF(summer),24,[]);
fall_DeltaWindCF = reshape(DeltaWindCF(fall),24,[]);
winter_DeltaWindCF = reshape(DeltaWindCF(winter),24,[]);

%               R           G       B           alpha
spring_color =  [1,         0,      1,          0.2];
summer_color =  [0.929,     0.694,  0.125,      .2];
fall_color =    [0.,        1,      0,          .2];
winter_color =  [0,         0,      1,          .2];

plot(1:24,spring_DeltaWindCF(:,1),'Color',spring_color);
hold on
for day = size(spring_DeltaWindCF,2):-1:2
    plot(1:24,spring_DeltaWindCF(:,day),'Color',spring_color);
end

plot(1:24,summer_DeltaWindCF(:,1),'Color',summer_color);
for day = size(summer_DeltaWindCF,2):-1:2
    plot(1:24,summer_DeltaWindCF(:,day),'Color',summer_color);
end

plot(1:24,winter_DeltaWindCF(:,1),'Color',winter_color);
for day = size(winter_DeltaWindCF,2):-1:2
    plot(1:24,winter_DeltaWindCF(:,day),'Color',winter_color);
end

plot(1:24,fall_DeltaWindCF(:,1),'Color',fall_color);
for day = size(fall_DeltaWindCF,2):-1:2
    plot(1:24,fall_DeltaWindCF(:,day),'Color',fall_color);
end

hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
title('Δ Wind capacity factor (%/h)')
if regionn == 1
text(14.5,-0.05,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(19,0.13,'summer','Fontsize',15,'Color',summer_color)
text(13,0.08,'fall','Fontsize',15,'Color',fall_color)
text(13,0.11,'winter','Fontsize',15,'Color',winter_color)
elseif regionn == 2
text(5,-0.45,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
text(10,-0.45,'summer','Fontsize',15,'Color',summer_color)
text(15,-0.45,'fall','Fontsize',15,'Color',fall_color)
text(20,-0.45,'winter','Fontsize',15,'Color',winter_color)
end
saveas(gcf,strcat(Plotpath,region,'_','Seasonal_dleta_windCF.png'));

% Wind output boxplots (used to look for trends in NYISO, didn't save them)
Wind_CF_sq = reshape(WindCF,[24,365])';

boxplot(Wind_CF_sq);
title('Wind output')

spring_Wind_CF_sq = spring_WindCF';
boxplot(spring_Wind_CF_sq);
title('Wind output - spring')

DeltaWind_CF_sq = reshape(DeltaWindCF,[24,365])';

boxplot(DeltaWind_CF_sq);
title('Δ Wind output')

spring_DeltaWind_CF_sq = spring_DeltaWindCF';
boxplot(spring_DeltaWind_CF_sq);
title('Δ output - spring')

fall_DeltaWind_CF_sq = fall_DeltaWindCF';
boxplot(fall_DeltaWind_CF_sq);
title('Δ output - fall')

%% Δ Total generation vs Δ Emissions for the fall
if regionn == 1
plot(1:24,fall_DeltaLoad(:,1),'Color',fall_color);
hold on
for day = size(fall_DeltaLoad,2):-1:2
    plot(1:24,fall_DeltaLoad(:,day),'Color',fall_color);
end
plot(1:24,fall_DeltahourlyGHG(:,1),'Color',spring_color);
for day = size(fall_DeltahourlyGHG,2):-1:2
    plot(1:24,fall_DeltahourlyGHG(:,day),'Color',spring_color);
end
xline(16)
yline(16)
hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
text(1,-4000,'Δ Total generation (MWh/h)','Fontsize',15,'Color',fall_color)
text(1,-6000,'Δ Emissions(tCO2e/h)','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
% ylim([40000 120000])
saveas(gcf,strcat(Plotpath,region,'_','deltas_totalgen_emissions.png'));
axis([14 18 -1000 1000])
saveas(gcf,strcat(Plotpath,region,'_','deltas_totalgen_emissions_closeup.png'));
elseif regionn == 2
plot(1:24,spring_DeltaLoad(:,1),'Color',fall_color);
hold on
for day = size(spring_DeltaLoad,2):-1:2
    plot(1:24,spring_DeltaLoad(:,day),'Color',fall_color);
end
% yyaxis right
plot(1:24,spring_DeltahourlyGHG(:,1),'Color',spring_color);
for day = size(spring_DeltahourlyGHG,2):-1:2
    plot(1:24,spring_DeltahourlyGHG(:,day),'Color',spring_color,'LineStyle', '-','Marker', 'none');
end
xline(2)
yline(0)
hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
text(1,-1500,'Δ Total generation (MWh/h)','Fontsize',15,'Color',fall_color)
text(1,-2000,'Δ Emissions(tCO2e/h)','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
% ylim([40000 120000])
saveas(gcf,strcat(Plotpath,region,'_','deltas_totalgen_emissions.png'));
% yyaxis left
axis([1 5 -1000 2000])
saveas(gcf,strcat(Plotpath,region,'_','deltas_totalgen_emissions_closeup.png'));
% close all
end
%% Δ Thermal generation vs Δ Emissions for the fall
if regionn == 1
plot(1:24,fall_DeltaNetLoad(:,1),'Color',winter_color);
hold on
for day = size(fall_DeltaNetLoad,2):-1:2
    plot(1:24,fall_DeltaNetLoad(:,day),'Color',winter_color);
end
plot(1:24,fall_DeltahourlyGHG(:,1),'Color',spring_color);
for day = size(fall_DeltahourlyGHG,2):-1:2
    plot(1:24,fall_DeltahourlyGHG(:,day),'Color',spring_color);
end
xline(16)
yline(16)
hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
text(1,-4000,'Δ Thermal generation (MWh/h)','Fontsize',15,'Color',winter_color)
text(1,-6000,'Δ Emissions(tCO2e/h)','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
% ylim([40000 120000])
saveas(gcf,strcat(Plotpath,region,'_','deltas_thermalgen_emissions.png'));
axis([14 18 -2000 2000])
saveas(gcf,strcat(Plotpath,region,'_','deltas_thermalgen_emissions_closeup.png'));
elseif regionn == 2
plot(1:24,spring_DeltaNetLoad(:,1),'Color',winter_color);
hold on
for day = size(spring_DeltaNetLoad,2):-1:2
    plot(1:24,spring_DeltaNetLoad(:,day),'Color',winter_color);
end
% yyaxis right
plot(1:24,spring_DeltahourlyGHG(:,1),'Color',spring_color);
for day = size(spring_DeltahourlyGHG,2):-1:2
    plot(1:24,spring_DeltahourlyGHG(:,day),'Color',spring_color,'LineStyle', '-','Marker', 'none');
end
xline(2)
yline(0)
hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
text(1,2800,'Δ Thermal generation (MWh/h)','Fontsize',15,'Color',winter_color)
text(1,-2800,'Δ Emissions(tCO2e/h)','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
% ylim([40000 120000])
saveas(gcf,strcat(Plotpath,region,'_','deltas_thermalgen_emissions.png'));
% yyaxis left
axis([1 5 -2000 2000])
saveas(gcf,strcat(Plotpath,region,'_','deltas_thermalgen_emissions_closeup.png'));
% close all
end
%% Δ Renewable generation vs Δ Emissions for the fall
if regionn == 1
plot(1:24,fall_Delta_Renewable_output(:,1),'Color',summer_color);
hold on
for day = size(fall_Delta_Renewable_output,2):-1:2
    plot(1:24,fall_Delta_Renewable_output(:,day),'Color',summer_color);
end
plot(1:24,fall_DeltahourlyGHG(:,1),'Color',spring_color);
for day = size(fall_DeltahourlyGHG,2):-1:2
    plot(1:24,fall_DeltahourlyGHG(:,day),'Color',spring_color);
end
xline(16)
yline(16)
hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
text(1,-3800,'Δ Renewable generation (MWh/h)','Fontsize',15,'Color',summer_color)
text(1,-4500,'Δ Emissions(tCO2e/h)','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
% ylim([40000 120000])
saveas(gcf,strcat(Plotpath,region,'_','deltas_renewablegen_emissions.png'));
axis([14 18 -2500 2500])
saveas(gcf,strcat(Plotpath,region,'_','deltas_renewablegen_emissions_closeup.png'));
elseif regionn == 2
plot(1:24,fall_Delta_Renewable_output(:,1),'Color',summer_color);
hold on
for day = size(fall_Delta_Renewable_output,2):-1:2
    plot(1:24,fall_Delta_Renewable_output(:,day),'Color',summer_color);
end
plot(1:24,fall_DeltahourlyGHG(:,1),'Color',spring_color);
for day = size(fall_DeltahourlyGHG,2):-1:2
    plot(1:24,fall_DeltahourlyGHG(:,day),'Color',spring_color);
end
xline(2)
yline(0)
hold off
box off
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 300 300])
text(6,-700,'Δ Renewable generation (MWh/h)','Fontsize',15,'Color',summer_color)
text(6,-850,'Δ Emissions(tCO2e/h)','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
% ylim([40000 120000])
saveas(gcf,strcat(Plotpath,region,'_','deltas_renewablegen_emissions.png'));
axis([1 5 -500 1000])
saveas(gcf,strcat(Plotpath,region,'_','deltas_renewablegen_emissions_closeup.png'));
end
%% Consumption MEFs (didn't use this plot)
% CMEF = DeltahourlyGHG ./ DeltaLoad;
% 
% spring = 78*24+1:170*24;            % 92 days
% summer = 170*24+1:264*24;           % 94 days
% fall = 264*24+1:354*24;             % 90 days
% winter = [1:78*24,354*24+1:8760];   % 89 days
% 
% spring_CMEF = reshape(CMEF(spring),24,[]);
% summer_CMEF = reshape(CMEF(summer),24,[]);
% fall_CMEF = reshape(CMEF(fall),24,[]);
% winter_CMEF = reshape(CMEF(winter),24,[]);
% 
% %               R           G       B           alpha
% spring_color =  [1,         0,      1,          0.2];
% summer_color =  [0.929,     0.694,  0.125,      .2];
% fall_color =    [0.,        1,      0,          .2];
% winter_color =  [0,         0,      1,          .2];
% 
% plot(1:24,spring_CMEF(:,1),'Color',spring_color);
% hold on
% for day = size(spring_CMEF,2):-1:2
%     plot(1:24,spring_CMEF(:,day),'Color',spring_color);
% end
% 
% plot(1:24,summer_CMEF(:,1),'Color',summer_color);
% for day = size(summer_CMEF,2):-1:2
%     plot(1:24,summer_CMEF(:,day),'Color',summer_color);
% end
% 
% plot(1:24,winter_CMEF(:,1),'Color',winter_color);
% for day = size(winter_CMEF,2):-1:2
%     plot(1:24,winter_CMEF(:,day),'Color',winter_color);
% end
% 
% plot(1:24,fall_CMEF(:,1),'Color',fall_color);
% for day = size(fall_CMEF,2):-1:2
%     plot(1:24,fall_CMEF(:,day),'Color',fall_color);
% end
% 
% hold off
% box off
% set(gca,'FontSize',15)
% % set(gcf,'Position',[1300 1000 300 300])
% title('Seasonal emissions (tCO2e)')
% text(3,35000,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
% text(15,76350,'summer','Fontsize',15,'Color',summer_color)
% text(20,45000,'fall','Fontsize',15,'Color',fall_color)
% text(2,61000,'winter','Fontsize',15,'Color',winter_color)
% % ylim([40000 120000])
% saveas(gcf,strcat(Plotpath,region,'_','Seasonal_emissions.png'));
%% Scatter of Δ Emissions vs Δ Total generation (didn't use this plot)

spring = 78*24+1:170*24;            % 92 days
summer = 170*24+1:264*24;           % 94 days
fall = 264*24+1:354*24;             % 90 days
winter = [1:78*24,354*24+1:8760];   % 89 days

spring_DeltaLoad = reshape(DeltaLoad(spring),24,[]);
summer_DeltaLoad = reshape(DeltaLoad(summer),24,[]);
fall_DeltaLoad = reshape(DeltaLoad(fall),24,[]);
winter_DeltaLoad = reshape(DeltaLoad(winter),24,[]);

% no alpha for scatter
spring_color =  [1,         0,      1];
summer_color =  [0.929,     0.694,  0.125];
fall_color =    [0.,        1,      0];
winter_color =  [0,         0,      1];
% 
% scatter(spring_DeltaLoad(:,1),spring_DeltahourlyGHG(:,1),[],'MarkerFaceColor',spring_color,'MarkerEdgeColor',spring_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
% hold on
% for day = size(spring_DeltaLoad,2):-1:2
%     scatter(spring_DeltaLoad(:,day),spring_DeltahourlyGHG(:,day),[],'MarkerFaceColor',spring_color,'MarkerEdgeColor',spring_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
% end
% 
% scatter(summer_DeltaLoad(:,1),summer_DeltahourlyGHG(:,1),[],'MarkerFaceColor',summer_color,'MarkerEdgeColor',summer_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
% for day = size(summer_DeltaLoad,2):-1:2
%     scatter(summer_DeltaLoad(:,day),summer_DeltahourlyGHG(:,day),[],'MarkerFaceColor',summer_color,'MarkerEdgeColor',summer_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
% end
% 
% scatter(winter_DeltaLoad(:,1),winter_DeltahourlyGHG(:,1),[],'MarkerFaceColor',winter_color,'MarkerEdgeColor',winter_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
% for day = size(winter_DeltaLoad,2):-1:2
%     scatter(winter_DeltaLoad(:,day),winter_DeltahourlyGHG(:,day),[],'MarkerFaceColor',winter_color,'MarkerEdgeColor',winter_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
% end
% 
% scatter(fall_DeltaLoad(:,1),fall_DeltahourlyGHG(:,1),[],'MarkerFaceColor',fall_color,'MarkerEdgeColor',fall_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
% for day = size(fall_DeltaLoad,2):-1:2
%     scatter(fall_DeltaLoad(:,day),fall_DeltahourlyGHG(:,day),[],'MarkerFaceColor',fall_color,'MarkerEdgeColor',fall_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
% end
% 
% xline(0)
% yline(0)
% 
% hold off
% box off
% set(gca,'FontSize',15)
% % set(gcf,'Position',[1300 1000 300 300])
% ylabel('Δ Emissions [tCO_2e/h]')
% xlabel('Δ Total Load [MWh/h]')
% text(3,55000,'spring','Fontsize',15,'Color',spring_color) % uncomment to use; commented in case we loop-produce many plots
% text(16,115000,'summer','Fontsize',15,'Color',summer_color)
% text(16,65000,'fall','Fontsize',15,'Color',fall_color)
% text(3,85000,'winter','Fontsize',15,'Color',winter_color)
% ylim([40000 120000])
% saveas(gcf,strcat(Plotpath,region,'_','Scatter_GHGvsTotalload.png'));
% 
% % plot only hour 16 of fall for MEF2 vs MEF3
if regionn == 1
scatter(fall_DeltaLoad(16,:),fall_DeltahourlyGHG(16,:),[],'MarkerFaceColor',fall_color,'MarkerEdgeColor',fall_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
xline(0)
yline(0)
hold on
scatter(fall_DeltaNetLoad(16,:),fall_DeltahourlyGHG(16,:),[],'MarkerFaceColor',winter_color,'MarkerEdgeColor',winter_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
ylim(xlim)
hold off
box off
set(gca,'FontSize',15)
ylabel('Δ Emissions [tCO_2e/h]')
xlabel('Δ Load [MWh/h]')
title('Hour 16, fall')
text(100,-1000,'total load','Fontsize',15,'Color',fall_color)
text(-1500,-1000,'net load','Fontsize',15,'Color',winter_color)
saveas(gcf,strcat(Plotpath,region,'_','hour16fall_netloadvstotalload.png'));
elseif regionn == 2
% plot only hour 2 of spring for MEF2 vs MEF3
scatter(spring_DeltaLoad(2,:),spring_DeltahourlyGHG(2,:),[],'MarkerFaceColor',fall_color,'MarkerEdgeColor',fall_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
xline(0)
yline(0)
hold on
scatter(spring_DeltaNetLoad(2,:),spring_DeltahourlyGHG(2,:),[],'MarkerFaceColor',winter_color,'MarkerEdgeColor',winter_color,'MarkerFaceAlpha',.2,'MarkerEdgeAlpha',.2);
% ylim(xlim)
hold off
box off
set(gca,'FontSize',15)
ylabel('Δ Emissions [tCO_2e/h]')
xlabel('Δ Load [MWh/h]')
title('Hour 2, spring')
text(-700,280,'total load','Fontsize',15,'Color',fall_color)
text(-800,-400,'net load','Fontsize',15,'Color',winter_color)
saveas(gcf,strcat(Plotpath,region,'_','hour2spring_netloadvstotalload.png'));
end



ondemand =1;
%% Plot renewables

plant_tb = plant_data;

% Find renewables
H = find(strncmp(plant_tb.Category,'HYDRO',4));
S = find(strncmp(plant_tb.Category,'SOLAR',4));
W = find(strncmp(plant_tb.Category,'WIND',4));
% Deducting renewables from load
% var_energy = (plant_tb.Capacity_MW(H).*Var_Energy.Hydro)+(plant_tb.Capacity_MW(S).*Var_Energy.Solar)+(plant_tb.Capacity_MW(W).*Var_Energy.Wind);   

Thermal_plus_hydro = (plant_tb.Capacity_MW(H).*Var_Energy.Hydro)' + Netload;
Thermal_hydro_plus_solar = (plant_tb.Capacity_MW(S).*Var_Energy.Solar)' + Thermal_plus_hydro;

plot(1:8760,Thermal_hydro_plus_solar);
hold on
plot(1:8760,Thermal_plus_hydro);
plot(1:8760,Netload);
plot(1:8760,Load_1styear);
hold off
% show area of interest
axis([0 8760 ylim]) % all year
axis([0 25 ylim]) % January 1st
axis([(24*181+24*20) (24*181+24*21) ylim]) % July 21st
axis([(24*90+24*20) (24*90+24*21) ylim]) % April 21st
xline(24*90+24*20+2) % line at 2am

% plot detailed renewable output
hydro_generation = (plant_tb.Capacity_MW(H).*Var_Energy.Hydro)';
solar_generation = (plant_tb.Capacity_MW(S).*Var_Energy.Solar)';
wind_generation = (plant_tb.Capacity_MW(W).*Var_Energy.Wind)';

plot(1:8760,hydro_generation);
hold on
plot(1:8760,solar_generation);
plot(1:8760,wind_generation);
hold off
axis([0 8760 0 6100]) % all year

% Hydro too large; better to plot cumulative sums (like areas)
hydro_plus_solar_generation = hydro_generation + solar_generation;
hydro_solar_plus_wind_generation = wind_generation + hydro_plus_solar_generation;

plot(1:8760,hydro_solar_plus_wind_generation);
hold on
plot(1:8760,hydro_plus_solar_generation);
plot(1:8760,hydro_generation);
hold off
axis([0 8760 ylim]) % all-year
axis([0 8760 0 max(hydro_solar_plus_wind_generation)*1.1]) % zero-baseline

%% when are we using penalizing plant
plot(1:8760,dispatch(end,:));
