% Technologies MEF plots (INCOMPLETE)

function hourly_tech_MEF_plots(regionn,Plotpath,GHG_no_new_tech,GHG_with_new_tech,MWh_new_tech)
%% Uncomment to run without function call
% regionn = 1;
% techn = 1;
% GHG_no_new_tech = hourlyGHG0{1,regionn};
% GHG_with_new_tech = hourly_GHG1{1,techn}{1,regionn};
% MWh_new_tech = Case_Studies(techn,:);

%% Name files
if regionn == 1
    region = 'MISO';
elseif regionn == 2
        region = 'NYISO';
end

if techn == 1
    tech = 'PV';
elseif techn == 2
    tech = 'EV';
elseif techn == 3
    tech = 'HP';
end

%% Hourly GHG of the technology

deltaGHG = (GHG_with_new_tech - GHG_no_new_tech) * (0.000453522);
Reshaped_deltaGHG_8760 = reshape(deltaGHG,24,365);

marker = '-d';
color = [0 ,       0.4470, 0.7410, 0.2];

plot(1:24,Reshaped_deltaGHG_8760(:,1),marker,'Color',color);
hold on
for day = size(Reshaped_deltaGHG_8760,2):-1:2
    plot(1:24,Reshaped_deltaGHG_8760(:,day),marker,'Color',color);
end
hold off
box off
set(gca,'FontSize',15)
title(strcat('Emissions of',{' '},tech,' in',{' '},region,{' '},'(tCO2e)'))
saveas(gcf,strcat(Plotpath,region,'_',tech,'_','GHG_8760.png'));

%% Hourly MEF of the technology

MEF_new_tech = deltaGHG ./ MWh_new_tech;
Reshaped_MEF_new_tech_8760 = reshape(MEF_new_tech,24,365);

marker = '-d';
color = [0 ,       0.4470, 0.7410, 0.2];

plot(1:24,Reshaped_MEF_new_tech_8760(:,1),marker,'Color',color);
hold on
for day = size(Reshaped_MEF_new_tech_8760,2):-1:2
    plot(1:24,Reshaped_MEF_new_tech_8760(:,day),marker,'Color',color);
end
hold off
box off
set(gca,'FontSize',15)
title(strcat('MEF of',{' '},tech,' in',{' '},region,{' '},'(tCO2e)'))
saveas(gcf,strcat(Plotpath,region,'_',tech,'_','MEF_8760.png'));
axis([0 25 -5 5])
saveas(gcf,strcat(Plotpath,region,'_',tech,'_','MEF_8760_yaxis_-5_to_5.png'));
axis([0 25 0 1.5])
saveas(gcf,strcat(Plotpath,region,'_',tech,'_','MEF_8760_yaxis_0_to_1.5.png'));
    
boxplot(Reshaped_MEF_new_tech_8760'); 
hold on; 
scatter(1:24,mean(Reshaped_MEF_new_tech_8760','omitnan'),50,'*','LineWidth',1); 
hold off;
box off
set(gca,'FontSize',13)
title(strcat('MEF of',{' '},tech,' in',{' '},region,{' '},'(tCO2e)'))
saveas(gcf,strcat(Plotpath,region,'_',tech,'_','MEF_boxplot_8760.png'));
axis([0 25 -5 5])
saveas(gcf,strcat(Plotpath,region,'_',tech,'_','MEF_boxplot_8760_yaxis_-5_to_5.png'));
axis([0 25 0 1.5])
saveas(gcf,strcat(Plotpath,region,'_',tech,'_','MEF_boxplot_8760_yaxis_0_to_1.5.png'));

%% why Nan's and Inf's ?

Reshaped_MWh_new_tech = reshape(MWh_new_tech,24,365);

Dispatch_no_new_tech = Dispatch_data{1,2}{1,1};
Dispatch_with_new_tech = Dispatch1{1,1}{1,2};

Dispatch_difference = Dispatch_with_new_tech - Dispatch_no_new_tech;

Dispatch_no_new_tech_difference = diff(Dispatch_no_new_tech,1,2);

if regionn == 1
load('Load2');                          % Electricity Load data MISO
elseif regionn== 2
load('Load_NY_deter');                 % Electricity Load data NYISO
Load2=Load_NY_deter;
end
    
Load2 = Load2(1,:);
delta_load = diff(Load2);
