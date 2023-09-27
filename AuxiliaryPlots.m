% Auxiliary plots for more in-depth analysis

%% Plots to show before and after imputation
% Export MISO data
    MISO_Old_MAC1 = MAC1;
    MISO_Old_MAC2 = MAC2;
    MISO_Old_MAC3 = MAC3;
    MISO_Old_MAC40 = MAC40;
    MISO_Old_MAC4 = MAC4;
    MISO_Old_MAC50 = MAC50;
    MISO_Old_MAC5 = MAC5;
    MISO_Old_MAC6 = MAC6;
    MISO_Old_Abatement1 = TotalAbatement1;
    MISO_Old_Abatement2 = TotalAbatement2;
    MISO_Old_Abatement3 = TotalAbatement3;
    MISO_Old_Abatement40 = TotalAbatement40;
    MISO_Old_Abatement4 = TotalAbatement4;
    MISO_Old_Abatement50 = Abatement50;
    MISO_Old_Abatement5 = Abatement5;
    MISO_Old_Abatement6 = Abatement6;
    MISO_Old_NetCost1 = NetCost1;
    MISO_Old_NetCost2 = NetCost2;
    MISO_Old_NetCost3 = NetCost3;
    MISO_Old_NetCost40 = NetCost40;
    MISO_Old_NetCost4 = NetCost4;
    MISO_Old_NetCost50 = NetCost50;
    MISO_Old_NetCost5 = NetCost5;
    MISO_Old_NetCost6 = NetCost6;
    MISO_Old_DTSC0050 = DTSC0050;
    MISO_Old_DTSC50 = DTSC50;
    MISO_Old_DTSC00 = DTSC00;
    MISO_Old_DTSC5 = DTSC5;
    MISO_Old_DTSC_OPT = DTSC_OPT;
    MISO_Old_DTSC6 = DTSC6;
    MISO_Old_GHG0050 = GHG0050;
    MISO_Old_GHG50 = GHG50;
    MISO_Old_GHG00 = GHG00;
    MISO_Old_GHG5 = GHG5;
    MISO_Old_GHG_OPT = GHG_OPT;
    MISO_Old_GHG6 = GHG6;
    save('MISO_Old_outputs.mat','MISO_Old_MAC1','MISO_Old_MAC2','MISO_Old_MAC3','MISO_Old_MAC40','MISO_Old_MAC4','MISO_Old_MAC50','MISO_Old_MAC5','MISO_Old_MAC6','MISO_Old_Abatement1','MISO_Old_Abatement2','MISO_Old_Abatement3','MISO_Old_Abatement40','MISO_Old_Abatement4','MISO_Old_Abatement50','MISO_Old_Abatement5','MISO_Old_Abatement6','MISO_Old_NetCost1','MISO_Old_NetCost2','MISO_Old_NetCost3','MISO_Old_NetCost40','MISO_Old_NetCost4','MISO_Old_NetCost50','MISO_Old_NetCost5','MISO_Old_NetCost6','MISO_Old_DTSC0050','MISO_Old_DTSC50','MISO_Old_DTSC00','MISO_Old_DTSC5','MISO_Old_DTSC_OPT','MISO_Old_DTSC6','MISO_Old_GHG0050','MISO_Old_GHG50','MISO_Old_GHG00','MISO_Old_GHG5','MISO_Old_GHG_OPT','MISO_Old_GHG6')
% Export NYISO data
    NYISO_Old_MAC1 = MAC1;
    NYISO_Old_MAC2 = MAC2;
    NYISO_Old_MAC3 = MAC3;
    NYISO_Old_MAC40 = MAC40;
    NYISO_Old_MAC4 = MAC4;
    NYISO_Old_MAC50 = MAC50;
    NYISO_Old_MAC5 = MAC5;
    NYISO_Old_MAC6 = MAC6;
    NYISO_Old_Abatement1 = TotalAbatement1;
    NYISO_Old_Abatement2 = TotalAbatement2;
    NYISO_Old_Abatement3 = TotalAbatement3;
    NYISO_Old_Abatement40 = TotalAbatement40;
    NYISO_Old_Abatement4 = TotalAbatement4;
    NYISO_Old_Abatement50 = Abatement50;
    NYISO_Old_Abatement5 = Abatement5;
    NYISO_Old_Abatement6 = Abatement6;
    NYISO_Old_NetCost1 = NetCost1;
    NYISO_Old_NetCost2 = NetCost2;
    NYISO_Old_NetCost3 = NetCost3;
    NYISO_Old_NetCost40 = NetCost40;
    NYISO_Old_NetCost4 = NetCost4;
    NYISO_Old_NetCost50 = NetCost50;
    NYISO_Old_NetCost5 = NetCost5;
    NYISO_Old_NetCost6 = NetCost6;
    NYISO_Old_DTSC0050 = DTSC0050;
    NYISO_Old_DTSC50 = DTSC50;
    NYISO_Old_DTSC00 = DTSC00;
    NYISO_Old_DTSC5 = DTSC5;
    NYISO_Old_DTSC_OPT = DTSC_OPT;
    NYISO_Old_DTSC6 = DTSC6;
    NYISO_Old_GHG0050 = GHG0050;
    NYISO_Old_GHG50 = GHG50;
    NYISO_Old_GHG00 = GHG00;
    NYISO_Old_GHG5 = GHG5;
    NYISO_Old_GHG_OPT = GHG_OPT;
    NYISO_Old_GHG6 = GHG6;
    save('NYISO_Old_outputs.mat','NYISO_Old_MAC1','NYISO_Old_MAC2','NYISO_Old_MAC3','NYISO_Old_MAC40','NYISO_Old_MAC4','NYISO_Old_MAC50','NYISO_Old_MAC5','NYISO_Old_MAC6','NYISO_Old_Abatement1','NYISO_Old_Abatement2','NYISO_Old_Abatement3','NYISO_Old_Abatement40','NYISO_Old_Abatement4','NYISO_Old_Abatement50','NYISO_Old_Abatement5','NYISO_Old_Abatement6','NYISO_Old_NetCost1','NYISO_Old_NetCost2','NYISO_Old_NetCost3','NYISO_Old_NetCost40','NYISO_Old_NetCost4','NYISO_Old_NetCost50','NYISO_Old_NetCost5','NYISO_Old_NetCost6','NYISO_Old_DTSC0050','NYISO_Old_DTSC50','NYISO_Old_DTSC00','NYISO_Old_DTSC5','NYISO_Old_DTSC_OPT','NYISO_Old_DTSC6','NYISO_Old_GHG0050','NYISO_Old_GHG50','NYISO_Old_GHG00','NYISO_Old_GHG5','NYISO_Old_GHG_OPT','NYISO_Old_GHG6')
% plot all data in same graph, make them easy to compare 1) before and
% after imputed data, and 2) between methods

% plots 1-2
    % abatement - MISO
        plot(AddPower/1000,TotalAbatement1/10^9,'b','LineWidth',2)
        hold on
        plot(AddPower/1000,MISO_Old_Abatement1/10^9,'--b','LineWidth',2)
        plot(AddPower/1000,TotalAbatement2/10^9,'r','LineWidth',2)
        plot(AddPower/1000,MISO_Old_Abatement2/10^9,'--r','LineWidth',2)
        hold off
        box off
        ylim([0 max([TotalAbatement1/10^9,TotalAbatement2/10^9,MISO_Old_Abatement1/10^9,MISO_Old_Abatement2/10^9],[],'All')*1.1])
        legend({'AEF adjusted data','AEF old','MEF fixed, adjusted data','MEF fixed, old'},'Location','best')
        title('Abatement estimated with different methods')
        xlabel('Additional solar [GW]')
        ylabel('Abatement [billion tCO_2e]')
        xtickformat('%.3g')
        saveas(gcf,strcat(Plotpath,'MISO_ImputedData_Abatements1-2.png'));
    % abatement - NYISO
        plot(AddPower/1000,TotalAbatement1/10^9,'b','LineWidth',2)
        hold on
        plot(AddPower/1000,NYISO_Old_Abatement1/10^9,'--b','LineWidth',2)
        plot(AddPower/1000,TotalAbatement2/10^9,'r','LineWidth',2)
        plot(AddPower/1000,NYISO_Old_Abatement2/10^9,'--r','LineWidth',2)
        hold off
        box off
        ylim([0 max([TotalAbatement1/10^9,TotalAbatement2/10^9,NYISO_Old_Abatement1/10^9,NYISO_Old_Abatement2/10^9],[],'All')*1.1])
        legend({'AEF adjusted data','AEF old','MEF fixed, adjusted data','MEF fixed, old'},'Location','best')
        title('Abatement estimated with different methods')
        xlabel('Additional solar [GW]')
        ylabel('Abatement [billion tCO_2e]')
        xtickformat('%.3g')
        saveas(gcf,strcat(Plotpath,'MISO_ImputedData_Abatements1-2.png'));
%% Missing emissions data
% NaN's in plant data, imputing data
sum(ismissing(MISO_2020))
histogram(MISO_2015.CO2eq_lbMWh)
MISO_2015_gas = MISO_2015(strcmp(MISO_2015.Category(:),'GAS'),:);
histogram(MISO_2015_gas.CO2eq_lbMWh(6:end))
scatter(MISO_2015_gas.Capacity_MW,MISO_2015_gas.CO2eq_lbMWh)
nanmean(MISO_2015_gas.CO2eq_lbMWh)
mode(MISO_2015_gas.CO2eq_lbMWh)

% comparing when solar generates to determine relevant hours
SolarGen = reshape(CapFactor,[24,365]);
plot(1:24,SolarGen(:,1))
hold on
for d = 2:365
plot(1:24,SolarGen(:,d))
end
hold off

% comparing delta GHGs at different hours of the day
plot(1:8760/24,DeltaGHG(3,:))
hold on
for t = 10:18
plot(1:8760/24,DeltaGHG(t,:))
end
hold off

% comparing delta Load at different hours of the day
plot(1:8760/24,DeltaLoad(8,:))
hold on
for t = 9:18
plot(1:8760/24,DeltaLoad(t,:))
end
hold off

% comparing delta Load divided by delta GHG to account for both of their
% seasonal variation (not only GHGs variation)
DLoadDGHG = DeltaGHG./DeltaLoad;
plot(1:8760/24,DLoadDGHG(8,:))
hold on
for t = 9:18
plot(1:8760/24,DLoadDGHG(t,:))
end
hold off

% comparing delta GHGs with corresponding delta Loads at different hours of the day
plot(1:8760/24,DeltaLoad(10,:))
hold on
plot(1:8760/24,DeltaLoad(17,:))
yyaxis right
plot(1:8760/24,DeltaGHG(10,:))
plot(1:8760/24,DeltaGHG(17,:))
hold off

% comparing emissions rate of marginal plant at different hours of the day
ER_marginal_plant = reshape(Emissions_rate,[24,365]);

plot(1:8760/24,ER_marginal_plant(1,:)*(0.000453522))
hold on
plot(1:8760/24,ER_marginal_plant(2,:)*(0.000453522))
plot(1:8760/24,ER_marginal_plant(3,:)*(0.000453522))
plot(1:8760/24,ER_marginal_plant(4,:)*(0.000453522))
plot(1:8760/24,ER_marginal_plant(5,:)*(0.000453522))
plot(1:8760/24,ER_marginal_plant(6,:)*(0.000453522))
hold off
%% Solving weird MEFs
% run this before the reshape of 24x365
% over 1 year
plot(1:8760,Load2(1,:))
plot(1:8760,hourlyGHG)
% over 1 day
plot(1:24,Load2(1,1:24))
plot(1:24,hourlyGHG(1:24))
% differences
plot(1:8760,DeltaLoad)
plot(1:8760,DeltaGHG)
% regression line plot 
scatter(DeltaLoad(1,:),DeltaGHG(1,:))
% run this after the reshape
% time of day MEFs regression plots
for t = 24:-1:1
scatter(DeltaGeneration(t,:),DeltaGHG(t,:))
hold on
scatter(DeltaGeneration(t,:),DeltaGeneration(t,:)*(TimeofDayMEFs(1,t)/0.000453522))
hold off
hour = string(t);
title(strcat('Hour ',hour))
xlabel('DeltaGeneration [MWh/h]')
ylabel('DeltaGHG [lbsCO2e/h]')
saveas(gcf,strcat(Plotpath,'DeltaGHG~DeltaLoad hour ',hour,'.png'));
end
% further inspect specific emissions rates
reshaped_Last_dispatched = reshape(Last_dispatched,[24,365]);
plot(1:365,reshaped_Last_dispatched(17,:))
reshaped_ER = reshape(Emissions_rate,[24,365]);
plot(1:365,reshaped_ER(17,:))
reshaped_hourlyGHG = reshape(hourlyGHG,[24,365]);
plot(1:365,reshaped_hourlyGHG(16,:))
hold on
plot(1:365,reshaped_hourlyGHG(17,:))
hold off

plot(1:365,DeltaLoad(16,:))
hold on
plot(1:365,DeltaLoad(17,:))
hold off

plot(1:365,DeltaGHG(16,:))
hold on
plot(1:365,DeltaGHG(17,:))
hold off

generation = sum(Dispatch,1);
plot(1:8760,Load2(1,:))
hold on
plot(1:8760,generation)
hold off

DeltaGeneration = diff(generation);
DeltaGeneration(1,8760) = generation(1)-generation(8760);

plot(1:8760,DeltaLoad)
hold on
plot(1:8760,DeltaGeneration)
hold off

WindCF = Var_Energy.Wind;
WindCF = WindCF';
plot(1:8760,WindCF)

DeltaWindCF = diff(WindCF);
DeltaWindCF(1,8760) = WindCF(1)-WindCF(8760);
plot(1:8760,DeltaWindCF)

reshaped_WindCF = reshape(WindCF,[24,365]);
plot(1:365,reshaped_WindCF(17,:))
hold on
plot(1:365,reshaped_WindCF(16,:))
hold off

reshaped_DeltaWindCF = reshape(DeltaWindCF,[24,365]);
plot(1:365,reshaped_DeltaWindCF(17,:))
hold on
plot(1:365,reshaped_DeltaWindCF(16,:))
plot(1:365,reshaped_DeltaWindCF(15,:))
plot(1:365,reshaped_DeltaWindCF(18,:))
plot(1:365,reshaped_DeltaWindCF(19,:))
hold off

DeltaLoad = diff(Load2(1,:));
DeltaLoad(1,8760) = Load2(1,1)-Load2(1,8760);
DeltaLoad = reshape(DeltaLoad,[24,365]);

plot(1:365,reshaped_DeltaWindCF(4,:))
hold on
yyaxis right
plot(1:365,DeltaLoad(4,:))
hold off
% Hours 1-7
scatter(DeltaLoad(1,:),reshaped_DeltaWindCF(1,:),10,[0,0.4470,0.7410],'*','LineWidth',1)
hold on
scatter(DeltaLoad(2,:),reshaped_DeltaWindCF(2,:),10,[0.8500, 0.3250, 0.0980],'*','LineWidth',1)
scatter(DeltaLoad(3,:),reshaped_DeltaWindCF(3,:),10,[0.9290, 0.6940, 0.1250],'*','LineWidth',1)
scatter(DeltaLoad(4,:),reshaped_DeltaWindCF(4,:),10,[0.4940, 0.1840, 0.5560],'*','LineWidth',1)
scatter(DeltaLoad(5,:),reshaped_DeltaWindCF(5,:),10,[0.4660, 0.6740, 0.1880],'*','LineWidth',1)
scatter(DeltaLoad(6,:),reshaped_DeltaWindCF(6,:),10,[0.3010, 0.7450, 0.9330],'*','LineWidth',1)
scatter(DeltaLoad(7,:),reshaped_DeltaWindCF(7,:),10,[0.6350, 0.0780, 0.1840],'*','LineWidth',1)
hold off
legend({'Hour 1','Hour 2','Hour 3','Hour 4','Hour 5','Hour 6','Hour 7'},'Location','bestoutside')
ylabel('Change in wind hourly capacity factor')
xlabel('Change in hourly load')
% Hours 8-14
scatter(DeltaLoad(8,:),reshaped_DeltaWindCF(8,:),10,[0,0.4470,0.7410],'*','LineWidth',1)
hold on
scatter(DeltaLoad(9,:),reshaped_DeltaWindCF(9,:),10,[0.8500, 0.3250, 0.0980],'*','LineWidth',1)
scatter(DeltaLoad(10,:),reshaped_DeltaWindCF(10,:),10,[0.9290, 0.6940, 0.1250],'*','LineWidth',1)
scatter(DeltaLoad(11,:),reshaped_DeltaWindCF(11,:),10,[0.4940, 0.1840, 0.5560],'*','LineWidth',1)
scatter(DeltaLoad(12,:),reshaped_DeltaWindCF(12,:),10,[0.4660, 0.6740, 0.1880],'*','LineWidth',1)
scatter(DeltaLoad(13,:),reshaped_DeltaWindCF(13,:),10,[0.3010, 0.7450, 0.9330],'*','LineWidth',1)
scatter(DeltaLoad(14,:),reshaped_DeltaWindCF(14,:),10,[0.6350, 0.0780, 0.1840],'*','LineWidth',1)
hold off
legend({'Hour 8','Hour 9','Hour 10','Hour 11','Hour 12','Hour 13','Hour 14'},'Location','bestoutside')
ylabel('Change in wind hourly capacity factor')
xlabel('Change in hourly load')
% Hours 15-21
scatter(DeltaLoad(15,:),reshaped_DeltaWindCF(15,:),10,[0,0.4470,0.7410],'*','LineWidth',1)
hold on
scatter(DeltaLoad(16,:),reshaped_DeltaWindCF(16,:),10,[0.8500, 0.3250, 0.0980],'*','LineWidth',1)
scatter(DeltaLoad(17,:),reshaped_DeltaWindCF(17,:),10,[0.9290, 0.6940, 0.1250],'*','LineWidth',1)
scatter(DeltaLoad(18,:),reshaped_DeltaWindCF(18,:),10,[0.4940, 0.1840, 0.5560],'*','LineWidth',1)
scatter(DeltaLoad(19,:),reshaped_DeltaWindCF(19,:),10,[0.4660, 0.6740, 0.1880],'*','LineWidth',1)
scatter(DeltaLoad(20,:),reshaped_DeltaWindCF(20,:),10,[0.3010, 0.7450, 0.9330],'*','LineWidth',1)
scatter(DeltaLoad(21,:),reshaped_DeltaWindCF(21,:),10,[0.6350, 0.0780, 0.1840],'*','LineWidth',1)
hold off
legend({'Hour 8','Hour 9','Hour 10','Hour 11','Hour 12','Hour 13','Hour 14'},'Location','bestoutside')
ylabel('Change in wind hourly capacity factor')
xlabel('Change in hourly load')

% One plot per hour
for t = 24:-1:1
scatter(DeltaLoad(t,:),reshaped_DeltaWindCF(t,:))
hold on
scatter(DeltaLoad(t,:),DeltaLoad(t,:)*(DeltaLoad(t,:)'\reshaped_DeltaWindCF(t,:)'))
hold off
hour = string(t);
title(strcat('Hour ',hour))
xlabel('DeltaLoad [MWh/h]')
ylabel('DeltaWindCF [%/h]')
saveas(gcf,strcat(Plotpath,'DeltaWindCF~DeltaLoad hour ',hour,'.png'));
end

plot(1:24,reshaped_WindCF(:,365))
hold on
for t = 364:-1:1
    plot(1:24,reshaped_WindCF(:,t))
end
hold off

reshaped_Load = reshape(Load2(1,:),[24,365]);

plot(1:24,reshaped_Load(:,365))
hold on
for t = 364:-1:1
    plot(1:24,reshaped_Load(:,t))
end
hold off

plot(1:24,reshaped_DeltaWindCF(:,365))
hold on
for t = 364:-1:1
    plot(1:24,reshaped_DeltaWindCF(:,t))
end
hold off

plot(1:24,DeltaLoad(:,365))
hold on
for t = 364:-1:1
    plot(1:24,DeltaLoad(:,t))
end
hold off
%% Temporary
                                            %% Plots MEF fixed Siler, MEF fixed Thind, True MEF
    % Abatement
        plot(AddPower/1000,TotalAbatement2/10^9,'LineWidth',2)
        hold on
        plot(AddPower/1000,TotalAbatement2_Thind/10^9,'LineWidth',2)
        plot(AddPower/1000,TotalAbatement70/10^9,'LineWidth',2)
        hold off
        box off
        legend({'MEF Emissions~Net Load (Siler-Evans)','MEF Emissions~Total Load (Thind)','MEF dispatch constrast'},'Location','best')
        title('Abatement [billion tCO_2e]')
        xlabel('Additional solar [GW]')
        xtickformat('%.3g')
        saveas(gcf,strcat(Plotpath,'Abatements_Siler-Evans_Thind_TrueMEFDispatch.png'));
    % MACC
        plot(AddPower/1000,MAC2,'LineWidth',2)
        hold on
        plot(AddPower/1000,MAC2_Thind,'LineWidth',2)
        plot(AddPower/1000,MAC70,'LineWidth',2)
        hold off
        box off
        ylim([min([0,MAC2,MAC2_Thind,MAC70],[],'All')*1.1 max([MAC2,MAC2_Thind,MAC70],[],'All')*1.1])
        legend({'MEF Emissions~Net Load (Siler-Evans)','MEF Emissions~Total Load (Thind)','MEF dispatch constrast'},'Location','best')
        title('Abatement cost [$/tCO_2e]')
        xlabel('Additional solar [GW]')
        xtickformat('%.3g')
        saveas(gcf,strcat(Plotpath,'MACs_Siler-Evans_Thind_TrueMEFDispatch.png'));
                                            %% Special plots, comparing true MEF

Delta_dispatch = zeros(size(Dispatch));
for h=8760:-1:2
Delta_dispatch(:,h) = Dispatch(:,h) - Dispatch(:,h-1);
end
Delta_dispatch(:,1) = Dispatch(:,1) - Dispatch(:,8760);
ERmatrix = repmat(plant_tb.CO2eq_lbMWh,1,8760);
ERs = zeros(size(Delta_dispatch));
ERs(find(Delta_dispatch)) = ERmatrix(find(Delta_dispatch)); % Emissions rates dispatch contrast (as opposed to capacities as we regularly see)

DeltaLoad = diff(Load2(1,:));
DeltaLoad(1,8760) = Load2(1,1)-Load2(1,8760);

% Hourly change in load over hourly change in emissions to get exact MEF per hour
DeltaGHG = ERmatrix .* Delta_dispatch;
DailyGHG = sum(DeltaGHG,1);
DailyMEF = DailyGHG ./ DeltaLoad;



plot(1:8760,DailyMEF)
hold on
yyaxis right 
plot(1:8760,DailyGHG)
hold off

Delta_dispatch = Dispatch - Dispatch70;
ERmatrix = repmat(plant_tb70.CO2eq_lbMWh,1,8760);
DeltaGHG = Delta_dispatch.*ERmatrix;
GHGDecrease = nansum(DeltaGHG(DeltaGHG>0),'all');
GHGIncrease = nansum(DeltaGHG(DeltaGHG<0),'all');
TotalAbatement70(1,n) = (GHGDecrease-GHGIncrease)*(1/2204.62)*Lifetime;

    
Grid_price = Grid_price';
Generation = Load2;
Generation(1,:) = sum(Dispatch,1);
DeltaGHG = diff(hourlyGHG);
DeltaGHG(1,8760) = hourlyGHG(1)-hourlyGHG(8760);
DeltaGeneration = diff(Generation(1,:));
DeltaGeneration(1,8760) = Generation(1,1)-Generation(1,8760);
AverageMEF = (DeltaGeneration' \ DeltaGHG') * (0.000453522);
scatter(DeltaGeneration',DeltaGHG')
hold on
scatter(DeltaGeneration',DeltaGeneration'*(AverageMEF/0.000453522))
hold off
DeltaGHG = reshape(DeltaGHG,[24,365]);
DeltaGeneration = reshape(DeltaGeneration,[24,365]);
for h = 24:-1:1
    TimeofDayMEFs(1,h) = DeltaGeneration(h,:)' \ DeltaGHG(h,:)';
end
TimeofDayMEFs = TimeofDayMEFs * (0.000453522);                    % tCO2e/MWh
MEF =  repmat(TimeofDayMEFs',365,Lifetime);

%% Hittinger's MEF
scatter(1:8760,Emissions_rate80,50,'.');
title('Hourly emissions rate of plant at the margin [lbsCO2e/MWh]')
xlabel('Hour of the year')

Reshaped_Emissions_rate80 = reshape(Emissions_rate80,[24,365]);
plot(1:365,Reshaped_Emissions_rate80(1,:));
hold on
for h = 2:24
    plot(1:365,Reshaped_Emissions_rate80(h,:));
end
hold off % this graph looks bad, no insight possible

ER_plantatmargin_MEF = mean(Reshaped_Emissions_rate80,2,'omitnan')* (0.000453522);

plot(1:24, ER_plantatmargin_MEF,'-*b','MarkerSize',10,'LineWidth',1)
hold on
plot(1:24, TimeofDayMEFs,'-*r','MarkerSize',10,'LineWidth',1)
hold off
box off
axis([0 25 0 max(ER_plantatmargin_MEF)*1.1])
ylabel('[tCO2e/MWh]')
xlabel('Time of the day [hours]')

%% Test grid evolution with 4 vs 7 periods

periods = 4;
for region = 2:-1:1
[Optimal_DeltaMW_4periods{region}] = genetic_algorithm(region,periods);
end

periods = 7;
for region = 2:-1:1
[Optimal_DeltaMW_7periods{region}] = genetic_algorithm(region,periods);
end

Optimal_DeltaMW_4periods{2,1} = reshape(Optimal_DeltaMW_4periods{1,1},7,4);
Optimal_DeltaMW_4periods{2,2} = reshape(Optimal_DeltaMW_4periods{1,2},7,4);

Optimal_DeltaMW_7periods{2,1} = reshape(Optimal_DeltaMW_7periods{1,1},7,7);
Optimal_DeltaMW_7periods{2,2} = reshape(Optimal_DeltaMW_7periods{1,2},7,7);

%% Test grid evolution for 2020 only

periods = 1;
region = 1;
[MISO_grid_in_2020] = genetic_algorithm(region,periods);

% check remaining unserved energy
Periods = 1;
region = 1; 
% run all lines of genetic_algortihm.m before optimal capacities
x = MISO_grid_in_2020;
[~,~,Dispatch] = CFAv4(BPeriods,Periods,Year,x,P0,plant,Var_Energy,interest,Load_monte,num_tech,name1,Cap_cost,NG_iter,monte);
unserved_energy_hours = find(Dispatch(end,:));
unserved_energy = sum(Dispatch(end,:))
plot(1:8760,Dispatch(end,:))
axis([4838 4842 ylim])

%% Run pieces of MACCmethods.m

load('MISO_RafaPC_27-Jan-2021.mat')

Periods40 = 1;
BPeriods40 = Periods40 + 4;
x = zeros(num_tech*Periods40,1);                                                  % zeros R&A's matrix to run dispatch of current grid
%     lr = 0; hr = 150000;
steps40 = steps;
AddPower40 = AddPower;
%     AddPower4 = (hr-lr)/(steps4):(hr-lr)/(steps4):hr;
CapFactor40 = CapFactor;
MEF40 = MEF;    % use constant MEFs (as opposed to recalculating them after installing every solar addition)
Load40 = Load_monte;
Load40(2:end,:) = repmat(Load_monte(1,:),6,1);  % constant load
n=1;
DirectCosts40(1,n) = SolarCapex * AddPower40(1,n);
OffsetMWh40(:,n) = AddPower40(1,n) * CapFactor40;
Load400 = Load40 - repmat(OffsetMWh40(:,n),1,7)';
Load400(Load400<0)=0;
[Grid_Price,Emissions_Rate] = CFAv4(BPeriods40,Periods40,Year,x,P0,plant,Var_Energy,interest,Load400,num_tech,name1,Cap_cost,NG_iter,monte); 
TotalOffsetMWh40 = repmat(OffsetMWh40(:,n),1,Lifetime);
RWgeneration40(1,n) = sum(TotalOffsetMWh40,'all');
ER40(:,n) = Emissions_Rate / 2202.62;
%             MEF40 = repmat(Emissions_Rate,1,Lifetime);
%             MEF40 = MEF40 / 2202.62;
Abatement40 = MEF40 .* TotalOffsetMWh40;
TotalAbatement40(1,n) = nansum(Abatement40,'all');
GridPrice40(:,n) = Grid_Price;
GridPriceNew40 = repmat(Grid_Price,1,Lifetime);
Revenue40 = TotalOffsetMWh40 .* GridPriceNew40;
Revenue40 =  Revenue40 .* Discounter;
TotalRevenue40(1,n) = nansum(Revenue40,'all');
NetCost40(1,n) = DirectCosts40(1,n) - TotalRevenue40(1,n);
MAC40(1,n) = NetCost40(1,n) / TotalAbatement40(1,n);

x = zeros(num_tech*Periods,1);                                                  % zeros R&A's matrix to run dispatch of current grid
%     lr = 0; hr = 150000;
steps4 = steps;
AddPower4 = AddPower;
%     AddPower4 = (hr-lr)/(steps4):(hr-lr)/(steps4):hr;
CapFactor4 = CapFactor;
Discounter4 = Discounter(1,:);
MEF4 = MEF;
DirectCosts4(1,n) = SolarCapex * AddPower4(1,n);
OffsetMWh4(:,n) = AddPower4(1,n) * CapFactor4;
Load4 = Load_monte - repmat(OffsetMWh4(:,n),1,7)';
Load4(Load4<0)=0;
[Grid_price,Emissions_rate] = CFAv4(BPeriods,Periods,Year,x,P0,plant,Var_Energy,interest,Load4,num_tech,name1,Cap_cost,NG_iter,monte); % Add "Dispatch04(:,:,n)" as output if desired
TotalOffsetMWh4 = repmat(OffsetMWh4(:,n),1,Lifetime);
RWgeneration4(1,n) = sum(TotalOffsetMWh4,'all');
ER4(:,:,n) = Emissions_rate / 2202.62;
%             MEF4 = repmat(Emissions_rate,1,Lifetime/Periods);
%             MEF4 = MEF4 / 2202.62;
Abatement4 = MEF4 .* TotalOffsetMWh4;
TotalAbatement4(1,n) = nansum(Abatement4,'all');
Revenue = TotalOffsetMWh4(:,length(Grid_price(1,:))) .* Grid_price;
Revenue = sum(Revenue,1);                                               % sum over columns (periods)
year2=Year1:(Year1)+((Periods-1)*PeriodSize);
year2(1:PeriodSize:(Periods)*PeriodSize)=[];
Revenue4 = zeros(1,Periods*PeriodSize);
Revenue4(:,1:PeriodSize:(Periods)*PeriodSize) = Revenue;
Revenue4(find(Revenue4,1,'last'):end) = Revenue(end);
year=Year1:PeriodSize:Year1+(Periods-1)*PeriodSize;
Revenue4(Revenue4==0) = interp1(year,Revenue,year2);
%             GridPrice4(:,:,n) = Grid_price;
%             GridPriceNew4 = repmat(Grid_price,1,Lifetime);
Revenue4 =  Revenue4 .* Discounter4;
TotalRevenue4(1,n) = nansum(Revenue4,'all');
NetCost4(1,n) = DirectCosts4(1,n) - TotalRevenue4(1,n);
MAC4(1,n) = NetCost4(1,n) / TotalAbatement4(1,n);

plot(1:8760,Grid_Price')
hold on
plot(1:8760,Grid_price(:,1)') %identical to MEF constant load since there is no load growth yet
plot(1:8760,Grid_price(:,2)')
plot(1:8760,Grid_price(:,3)')
plot(1:8760,Grid_price(:,4)')
hold off

unserved_energy_00 = sum(Dispatch00(318,:));

%run ESM5
k=1;
pop2=ESMx((k*num_tech)-num_tech+1:k*num_tech,:);
MISO = plant;
Load_monte = Load50;

%% run cash_flow_anneal.m line by line:
Periods = 1;
region = 1; 
% run all lines of genetic_algortihm.m before optimal capacities
x=randi(10000,Periods*num_tech,1); % assign random integers with maximum of 10,000 MW 
pop2=x;
MISO = plant;
% now you can run cah_flow_Anneal line by line

%% Test grid evolution with 8 different optimization algorithms

periods = 7;
for optimizer = 8:-1:1
for region = 2:-1:1
tic
[Optimal_DeltaMW_no_ramping{optimizer}{region},unserved_energy_hours{optimizer}{region},unserved_energy{optimizer}{region},fval{optimizer}{region},stopping_criteria{optimizer}{region}] = genetic_algorithm(region,periods,optimizer);
runtime(optimizer,region) = toc;
end
end
saver = strcat('test_8_algorithms','BOXX_',date);
save(saver)

%MISO
eight_algorithms_summary_table_MISO = table({...
    'Genetic Algorithm (GA)';...
    'GA hybrid with PS';...
    'Particle Swarm (PSO)';...
    'PSO hybrid with PS';...
    'Simulated Annealing (SA)';...
    'SA hybrid with PS';...
    'Surrogate Optimization';...
    'Pattern Search (PS)';...
    },'VariableNames',{'Algorithm'});
for i = 1:8
eight_algorithms_summary_table_MISO.Best_Value_billion_USD(i) = fval{i}{1};
end
runtime4 = seconds(runtime);
runtime4.Format = 'hh:mm'; 
eight_algorithms_summary_table_MISO.Runtime_hours_minutes = runtime4(:,1);
for i= 1:8
eight_algorithms_summary_table_MISO.Unserved_Energy_MWh(i) = unserved_energy{i}{1};
end
for i= 1:8
eight_algorithms_summary_table_MISO.Unserved_Energy_hours(i) = length(unserved_energy_hours{i}{1});
end

% NYISO
eight_algorithms_summary_table_NYISO = eight_algorithms_summary_table_MISO;
for i = 1:8
eight_algorithms_summary_table_NYISO.Best_Value_billion_USD(i) = fval{i}{2};
end
eight_algorithms_summary_table_NYISO.Runtime_hours_minutes = runtime4(:,2);
for i= 1:8
eight_algorithms_summary_table_NYISO.Unserved_Energy_MWh(i) = unserved_energy{i}{2};
end
for i= 1:8
eight_algorithms_summary_table_NYISO.Unserved_Energy_hours(i) = length(unserved_energy_hours{i}{2});
end

eight_algorithms_summary_table_MISO.Algorithm = string(eight_algorithms_summary_table_MISO.Algorithm);
eight_algorithms_summary_table_NYISO.Algorithm = string(eight_algorithms_summary_table_NYISO.Algorithm);

save(saver)

%% generate subplots
load('test_8_algorithmsBOXX_19-Jun-2021.mat')
for algorithm = 1:8
x(algorithm,:) = Optimal_DeltaMW_no_ramping{algorithm}{1};
x(algorithm+8,:) = Optimal_DeltaMW_no_ramping{algorithm}{2};
end
PeriodSize = 5;
Periods = 7;
num_tech = 7;

    %% MISO
for algorithm = 1:8
subplot(2,4,algorithm)
bar((2020:PeriodSize:2020+PeriodSize*(Periods-1)),reshape(x(algorithm,:),num_tech,Periods)','stacked')
title(eight_algorithms_summary_table_MISO.Algorithm(algorithm))
end
legend({'Coal CC','Gas CC','Gas CT','Biomass','Wind','Solar','Nuclear'},'Location','best')
sgtitle('Optimal additions and retirements of capacities per technology [MW]')
Plotpath = 'C:\Users\AlexBootCamp\Google Drive\RIT\Research\Stochastic_Model-BOXX\Results\';
saveas(gcf,strcat(Plotpath,'MISO_8_algorithms.png'));
    %% NYISO
for algorithm = 1:8
subplot(2,4,algorithm)
bar((2020:PeriodSize:2020+PeriodSize*(Periods-1)),reshape(x(algorithm+8,:),num_tech,Periods)','stacked')
title(eight_algorithms_summary_table_MISO.Algorithm(algorithm))
end
legend({'Coal CC','Gas CC','Gas CT','Biomass','Wind','Solar','Nuclear'},'Location','best')
sgtitle('Optimal additions and retirements of capacities per technology [MW]')
Plotpath = 'C:\Users\AlexBootCamp\Google Drive\RIT\Research\Stochastic_Model-BOXX\Results\';
saveas(gcf,strcat(Plotpath,'NYISO_8_algorithms.png'));

for region = 2:-1:1
[Optimal_DeltaMW_with_ramping{region}] = genetic_algorithm_ramping(region,periods);
end

[Optimal_DeltaMW_with_ramping{1}] = genetic_algorithm_ramping(1,7); % FALSE PARALLEL ISSUE: when using GAramping, parallel run cripples, some workers stop working an eventually ends up with only one

MISO_ramping = reshape(Optimal_DeltaMW_with_ramping{1,1},7,7);
NYISO_ramping = reshape(Optimal_DeltaMW_with_ramping{1,2},7,7);
MISO_no_ramping = reshape(Optimal_DeltaMW_no_ramping{1,1},7,7);
NYISO_no_ramping = reshape(Optimal_DeltaMW_no_ramping{1,2},7,7);

save('Ramp_vs_NoRamp.mat','MISO_ramping','NYISO_ramping','MISO_no_ramping','NYISO_no_ramping')

%% Test grid evolution with schedule optimization
saver = strcat('test_schedule_optimization','BOXX_',date);
[Optimal_DeltaMW_NYISO,system_cost_NYISO,runtimes_NYISO] = genetic_algorithm_2_steps(2);
save(saver)
myCluster = parcluster('local')
delete(myCluster.Jobs)
[Optimal_DeltaMW_MISO,system_cost_MISO,runtimes_MISO] = genetic_algorithm_2_steps(1);
save(saver)

saver = strcat('test_schedule_optimization','AlexPC_',date);
[Optimal_DeltaMW_NYISO,system_cost_NYISO,runtimes_NYISO] = genetic_algorithm_2_steps_PS(2);
save(saver)
myCluster = parcluster('local')
delete(myCluster.Jobs)
[Optimal_DeltaMW_MISO,system_cost_MISO,runtimes_MISO] = genetic_algorithm_2_steps_PS(1);
save(saver)

% commit changes from remote computers to bootcamp

two_step_optimization_summary_table_MISO = table({...
    'step 1 - optimize capacities';...
    'step 2 - optimize schedule';...
    'step 3 - optimize capacities';...
    'step 4 - optimize schedule';...
    },'VariableNames',{'Optimization_steps'});

runtimes_MISO = seconds(runtimes_MISO);
runtimes_MISO.Format = 'hh:mm'; 

for i = 1:4
    two_step_optimization_summary_table_MISO.Best_Value_billion_USD(i) = system_cost_MISO(i,:);
    two_step_optimization_summary_table_MISO.Runtime_hours_minutes(i) = runtimes_MISO(i,:);
end

two_step_optimization_summary_table_NYISO = table({...
    'step 1 - optimize capacities';...
    'step 2 - optimize schedule';...
    'step 3 - optimize capacities';...
    'step 4 - optimize schedule';...
    },'VariableNames',{'Optimization_steps'});

runtimes_NYISO = seconds(runtimes_NYISO);
runtimes_NYISO.Format = 'hh:mm'; 

for i = 1:4
    two_step_optimization_summary_table_NYISO.Best_Value_billion_USD(i) = system_cost_NYISO(i,:);
    two_step_optimization_summary_table_NYISO.Runtime_hours_minutes(i) = runtimes_NYISO(i,:);
end

save(saver)

%% MEF code - Check if demand is met at all times

load('NYISO_BOXX_28-Jan-2021.mat')
plot(1:8760,Last_dispatched)
unserved_energy = sum(Dispatch(227,:));
max_load = max(Load2(1,:));
max_load
thermal_capacity = sum(plant_tb.Capacity_MW(1:317));
renewable_capacity = sum(plant.Capacity_MW(1:3));
nominal_capacity = thermal_capacity + renewable_capacity;
thermal_capacity = sum(plant_tb.Capacity_MW(1:226));
renewable_capacity = sum(plant.Capacity_MW(1:3));
nominal_capacity = thermal_capacity + renewable_capacity;
renewable_capacity = sum(plant.Capacity_MW(225,226,229));
thermal_capacity = sum(plant_tb.Capacity_MW(1:226));
renewable_capacity = sum(plant.Capacity_MW(225)) + sum(plant.Capacity_MW(226)) +sum(plant.Capacity_MW(229));
nominal_capacity = thermal_capacity + renewable_capacity;
nominal_capacity
thermal_capacity
renewable_capacity
clear
load('MISO_RafaPC_27-Jan-2021.mat')
unserved_energy_hours = find(Dispatch(318,:));
unserved_energy_hours
unserved_energy = sum(Dispatch(318,:));
unserved_energy
max_load = max(Load2(1,:))
nominal_capacity = sum(plant_tb.Capacity_MW(1:317));
renewable_capacity = sum(plant.Capacity_MW(1:3));
nominal_capacity = thermal_capacity + renewable_capacity;
thermal_capacity = sum(plant_tb.Capacity_MW(1:317));
renewable_capacity = sum(plant.Capacity_MW(1:3));
nominal_capacity = thermal_capacity + renewable_capacity;
clear

%% MEF paper

%% 8760 demand MEF zoom-ins to study protruding blue bars

% start from 8760 demand MEF plot

axis([9 20 -2 2]);

% boxplot of 8760 MEF may be easier to compare demand vs thermal

boxplot(Reshaped_MEF4_8760'); 
hold on; 
axis([0 25 0 1.4]);
scatter(1:24,mean(Reshaped_MEF4_8760'),50,'*','LineWidth',1); 
hold off;
title('8760 demand MEF (tCO2e/MWh)'); 

boxplot(Reshaped_MEF3_8760'); 
hold on; 
axis([0 25 0 1.4]);
scatter(1:24,mean(Reshaped_MEF3_8760'),50,'*','LineWidth',1); 
hold off;
title('8760 thermal MEF (tCO2e/MWh)'); 

Reshaped_MEF_PV_NYISO = Reshaped_deltaGHG_8760 ./ Reshaped_MWh_new_tech;

% see where most of the mitigation comes from for PV & HP
demand_MEF_MISO_8760 = MEF_data{1,1}{4,1};
Reshaped_demandMEF_MISO = reshape(demand_MEF_MISO_8760,24,365);

marker = '-d';
color = [0 ,       0.4470, 0.7410, 0.2];

plot(1:24,Reshaped_demandMEF_MISO(:,1),marker,'Color',color);
hold on
for day = size(Reshaped_demandMEF_MISO,2):-1:2
    plot(1:24,Reshaped_demandMEF_MISO(:,day),marker,'Color',color);
end
hold off
box off
set(gca,'FontSize',15)
title(strcat('Demand MEF in MISO (tCO2e/MWh)'))
saveas(gcf,strcat(Plotpath,'demand_MEF_MISO_8760.png'));

ind = find(demand_MEF_MISO_8760 == max(demand_MEF_MISO_8760));
days = round(ind/24);
hours = ind - days*24;
days = days+1;
days = string(days);
hours = string(hours);
strcat('Hour',{' '},hours,' of day',{' '},days)

load('Load2.mat','Load2')
hourly_demand_MISO = Load2(1,:);
hourly_emissions_MISO = hourlyGHG0{1,1} * (0.000453522);

plot(1:24,hourly_demand_MISO(ind-10:ind+13))
hold on
yyaxis right
plot(1:24,hourly_emissions_MISO(ind-10:ind+13))
hold off

delta_hourly_demand_MISO = diff(hourly_demand_MISO);
delta_hourly_emissions_MISO = diff(hourly_emissions_MISO);
hourly_generation_MISO = sum(Dispatch_data{1,1}{1,1});
delta_hourly_generation_MISO = diff(hourly_generation_MISO);

plot(1:24,delta_hourly_demand_MISO(ind+1-10:ind+1+13),'LineWidth',2)
hold on
plot(1:24,delta_hourly_generation_MISO(ind+1-10:ind+1+13),'LineWidth',2)
yyaxis right
plot(1:24,delta_hourly_emissions_MISO(ind+1-10:ind+1+13),'LineWidth',2)
hold off

%% find load reduction that leads to 0 unserved energy

Load_monte = Load2;
MISO_nominal_capacity = sum(plant.Capacity_MW(1:end-1))
MISO_nominal_thermal_capacity = sum(plant.Capacity_MW(4:end-1))
MISO_nominal_renewable_capacity = MISO_nominal_capacity - MISO_nominal_thermal_capacity
MISO_max_load = max(Load_monte(1,:),[],'all')
Unserved_load = MISO_max_load - MISO_nominal_thermal_capacity

Unserved_energy = sum(Dispatch(318,:))
Hours_with_unserved_energy = Dispatch(318,find(Dispatch(318,:)))

reshaped_load2 = reshape(Load2(1,:),24,365);

plot(1:24,reshaped_load2(:,1));
hold on
for n = 365:-1:2
    plot(1:24,reshaped_load2(:,n),'Color',[1,0,0,0.2]);
end
hold off

ind = find(Load2>MISO_max_load);

for i = 1:(size(plant.Category,1)-1)
gas = strcmp(plant.Category{i}, 'GAS');
if gas == 1
MISO_gas_plants(i,:) = plant(i,:);
end
end

MISO_gas_plants(MISO_gas_plants.Capacity_MW<=0,:)=[];
gas_capacity = sum(MISO_gas_plants.Capacity_MW)

get_installed_capacity(plant)
%% find out why are load growth MACC still negative

load('C:\Users\AlexBootCamp\Google Drive\RIT\Research\Stochastic_Model-BOXX\Results\MACC_MISO_BOXX_17-May-2021.mat')
k=1
unserved_energy = sum(Dispatch5_100(318,:))

counter=1

    for k = 8760:-1:1
        if ~isempty(find(Dispatch5_100(:,k),1,'last'))
        Last_dispatched(k) = find(Dispatch5_100(:,k),1,'last');
        else
        Last_dispatched(k) = 0;
        end
    end
    for k = 8760:-1:1
        if ~isempty(find(Dispatch5_100(:,k),1,'last'))
        Grid_price(k,counter) = plant_tb5_100.TC(Last_dispatched(1,k));
        else
        Grid_price(k,counter) = 0;
        end
    end
    for k = 8760:-1:1
        if ~isempty(find(Dispatch5_100(:,k),1,'last'))
        Emissions_rate(k,counter) = plant_tb5_100.CO2eq_lbMWh(Last_dispatched(1,k));
        else
        Emissions_rate(k,counter) = 0;
        end
    end
    
    max(Last_dispatched)
    
%% temporary script to see cost impact of retiring inexistent coal
function [Max_area,NG,Load_monte]=cash_flow_Anneal(BPeriods,Periods,Year,pop2,P0,MISO,Var_Energy,interest,Load_monte,num_tech,name1,Cap_cost,NG,monte)

% run without function call
load('test_8_algorithmsBOXX_19-Jun-2021.mat')
for algorithm = 1:8
x(algorithm,:) = Optimal_DeltaMW_no_ramping{algorithm}{1};
x(algorithm+8,:) = Optimal_DeltaMW_no_ramping{algorithm}{2};
end

pop2=x(11,:);
NG=NG_iter;
MISO=plant;
Periods=7; %check if Periods =! Periods0

pop2=reshape(pop2,num_tech,Periods);
%initializing cashflows using empty matrices
cashflow= zeros(num_tech,BPeriods*5); %Each page capital cost,fixed cost for natural gas and wind
Popbuild= zeros(num_tech,BPeriods*5 ); %Each row represents capital cost of building power plants without learning rates
peryear=pop2/5;
Popbuild(:,1:Periods*5) = repelem(peryear,1,5); %repeating each element 5 times 

%*******Exogenous Learning Rates
pop_old=P0(:,2:end); %P0 is the cumulative capacity
pop_new=diff(P0,[],2); %Per year additions
Learning=LR_Anneal(Cap_cost.LR,pop_old,pop_new,Periods,Year,num_tech);


%****************Capital costs after learning rate
cap_cost=repmat(Cap_cost.Capital_cost_dolKW,1,Periods*5);
cap_cost(Popbuild(:,1:Periods*5)<0)=0; %to ensure there are no capital costs during retirements
cashflow(:,1:Periods*5)=cap_cost.* Learning; %this provides per KW value and first column of cost is capital cost

%***********************Capital cost value per MW
cashflow=cashflow.*Popbuild*1000;


%*****retirement/addition of power plants
Ind=5:5:Periods*5; %ind is index
year=Year+4:5:(Periods)*5+(Year);
plant_struct(1:monte,1)=repmat(table2struct(MISO,'ToScalar',true),monte,1);
plant_original = plant_struct;
for counter1=1:monte
    for counter2=1:Periods
        if (counter2~=1) %i.e not equals 2020
        plant_struct(counter1,counter2)=plant_struct(counter1,counter2-1);
        end
        A=find(pop2(:,counter2)>0); %find the capacity additions
        %***adding power plants
         [~,Coal, Nuc,Oil, Bio] = fuel_prices(year(counter2));
         plant_struct(counter1,counter2)= read_data (plant_struct(counter1,counter2),NG(counter1,Ind(counter2)),...
             Coal, Nuc,Oil,Bio, pop2(A,counter2),...
             name1(A),Cap_cost(A,:),size(A,1));
         %*****Retiring power plants
         B=find(pop2(:,counter2)<0);
         plant_struct(counter1,counter2) = retire_data (plant_struct(counter1,counter2),...
              pop2(B,counter2),...
             Cap_cost(B,:));
    end
end
plant_struct=plant_struct';
Load_d = reshape(permute(Load_monte, [2 1 3]), size(Load_monte, 2), [])'; %best way to reshape!
plant_struct=reshape(plant_struct,Periods*monte,1);

% plant struct in first period has 192 power plants, instead of 230 as the original; what type were these 28 plants, what were their capacities?

plant_struct_first_period = plant_struct(1,:);
plant_original = struct2table(plant_original);
plant_struct_first_period = struct2table(plant_struct_first_period);
plant_original.Plant_ID = string(plant_original.Plant_ID);
plant_struct_first_period.Plant_ID = string(plant_struct_first_period.Plant_ID); 
plants_in_original_not_in_new = plant_original(~ismember(plant_original.Plant_ID,plant_struct_first_period.Plant_ID),:);
plants_in_new_not_in_original = plant_struct_first_period(~ismember(plant_struct_first_period.Plant_ID,plant_original.Plant_ID),:);

% all plants are gas; most are gas turbines, but some are steam turbines; which brings me to the question:
% when retiring existing plants, how do we know if we're retiring CC or GT? I don't think we ever use prime mover to decide which plants to retire, we only look at category...
% as for new plants, the model adds a small gas plant (0.8 MW). But model doesn't retire any coal (??).


sum(plant_original.Capacity_MW(string(plant_original.Category) == 'COAL'))
sum(plant_struct_first_period.Capacity_MW(string(plant_struct_first_period.Category) == 'COAL'))
% the model does retire coal; it just doesn't erase whole plants, but reduces their capacity instead
% but, what happens in the following periods, when more coal than exists is retired?

plant_struct_second_period = plant_struct(2,:);
plant_struct_second_period = struct2table(plant_struct_second_period);
plant_struct_second_period.Plant_ID = string(plant_struct_second_period.Plant_ID);
plants_in_original_not_in_new = plant_original(~ismember(plant_original.Plant_ID,plant_struct_second_period.Plant_ID),:);
plants_in_new_not_in_original = plant_struct_first_period(~ismember(plant_struct_second_period.Plant_ID,plant_original.Plant_ID),:);
sum(plants_in_original_not_in_new.Capacity_MW(string(plants_in_original_not_in_new.Category) == 'COAL'))
% While the model has asked to retire 36,000 MW of coal, the grid only has 930.8 of coal ICAP, and it only retires that
% So the rest of "coal retired" doesn't mean anything mathematically
% In that case, a system cost with 930 MW of coal retired in the first period, has the same value as a system cost with that plus 36,000 MW of coal retired in each subsequent period
% How do we prevent the model from exploring such meaningless scenarios?
% We could add inequalitis to the ga function! 

%calculating variable cost
Variable_cost = zeros(1,Periods*monte);
for counter=1:Periods*monte
    Variable_cost(counter)=dispatch_noramp(plant_struct(counter,1),Load_d(counter,:),Var_Energy);
end


%Rehsaping variables and calculating the final cost
Variable_cost=reshape(Variable_cost,Periods,monte);
%Actual cashflow
year2=Year:(Year)+(Periods*5);
year2([Ind,end])=[];
Variable2=zeros(BPeriods*5,monte);
Variable2(Ind,1:monte)=Variable_cost;
Variable2((Periods*5+1):end,1:monte)= repmat(Variable2(Periods*5,:),20,1);%Copying same value for rest of the years
Variable2(Variable2==0)=interp1(year(1:Periods)',Variable_cost,year2','linear');
Variable2(1:4,:)=interp1(year(1:Periods)',Variable_cost,year2(1:4),'linear','extrap');
Cost= repmat(sum(sum(cashflow,3),1)',1,monte)+Variable2;
real=(1/(1+interest)).^(0:BPeriods*5-1);
Total=sum(Cost.*repmat(real',1,monte));


%The part of finding the CVaR value to feed into genetic algorithm
Max_area=max_area_CVAR(Total);

%% OTHER
