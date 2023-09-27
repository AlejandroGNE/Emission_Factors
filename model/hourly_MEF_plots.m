% MEF plots
function hourly_MEF_plots(regionn,Plotpath,MEF_data)

%% Uncomment to run without function call
% regionn = 2;
% MEF_data = MEF_data{1,2};

%% Name files
if regionn == 1
    region = 'MISO';
elseif regionn == 2
    region = 'NYISO';
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

%% Compare between methods, for each time resolution

%% 8760

Reshaped_MEF1_8760 = reshape(MEF1_8760,24,365);
Reshaped_MEF2_8760 = reshape(MEF2_8760,24,365);
Reshaped_MEF3_8760 = reshape(MEF3_8760,24,365);
Reshaped_MEF4_8760 = reshape(MEF4_8760,24,365);
Reshaped_MEF5_8760 = reshape(MEF5_8760,24,365);

MEF1_marker = '-o'; MEF1_color = [0 ,       0.4470, 0.7410, 0.2];
MEF2_marker = '-*'; MEF2_color = [0.8500,   0.3250, 0.0980, 0.2];
MEF3_marker = '-^'; MEF3_color = [0.9290,   0.6940, 0.1250, 0.2];
MEF4_marker = '-d'; MEF4_color = [0.4940,   0.1840, 0.5560, 0.2];
MEF5_marker = '-.'; MEF5_color = [0.4660,   0.6740, 0.1880, 0.2];

%% MEF1

plot(1:24,Reshaped_MEF1_8760(:,1),MEF1_marker,'Color',MEF1_color);
hold on
for day = size(Reshaped_MEF1_8760,2):-1:2
    plot(1:24,Reshaped_MEF1_8760(:,day),MEF1_marker,'Color',MEF1_color);
end
hold off
box off; ylabel('tCO_2e') 
set(gca,'FontSize',15)
saveas(gcf,strcat(Plotpath,region,'_','MEF1_8760.png'));
%% MEF2

plot(1:24,Reshaped_MEF2_8760(:,1),MEF2_marker,'Color',MEF2_color);
hold on
for day = size(Reshaped_MEF2_8760,2):-1:2
    plot(1:24,Reshaped_MEF2_8760(:,day),MEF2_marker,'Color',MEF2_color);
end
hold off
box off; ylabel('tCO_2e') 
set(gca,'FontSize',15)
%title('Cosliest plant MEF 8760 (tCO2e/MWh)')
saveas(gcf,strcat(Plotpath,region,'_','MEF2_8760.png'));
%% MEF3

plot(1:24,Reshaped_MEF3_8760(:,1),MEF3_marker,'Color',MEF3_color);
hold on
for day = size(Reshaped_MEF3_8760,2):-1:2
    plot(1:24,Reshaped_MEF3_8760(:,day),MEF3_marker,'Color',MEF3_color);
end
hold off
box off; ylabel('tCO_2e') 
set(gca,'FontSize',15)
%title('Thermal MEF 8760 (tCO2e/MWh)')
saveas(gcf,strcat(Plotpath,region,'_','MEF3_8760.png'));
%% MEF4

plot(1:24,Reshaped_MEF4_8760(:,1),MEF4_marker,'Color',MEF4_color);
hold on
for day = size(Reshaped_MEF4_8760,2):-1:2
    plot(1:24,Reshaped_MEF4_8760(:,day),MEF4_marker,'Color',MEF4_color);
end
hold off
box off; ylabel('tCO_2e') 
set(gca,'FontSize',15)
%title('Demand MEF 8760 (tCO2e/MWh)')
saveas(gcf,strcat(Plotpath,region,'_','MEF4_8760.png'));
%% MEF5

plot(1:24,Reshaped_MEF5_8760(:,1),MEF5_marker,'Color',MEF5_color);
hold on
for day = size(Reshaped_MEF5_8760,2):-1:2
    plot(1:24,Reshaped_MEF5_8760(:,day),MEF5_marker,'Color',MEF5_color);
end
hold off
box off; ylabel('tCO_2e') 
set(gca,'FontSize',15)
%title('AEF 8760 (tCO2e/MWh)')
saveas(gcf,strcat(Plotpath,region,'_','MEF5_8760.png'));


%% 24SA

%               R           G       B           alpha
spring_color =  [1,         0,      1,          1];
summer_color =  [0.929,     0.694,  0.125,      1];
fall_color =    [0.,        1,      0,          1];
winter_color =  [0,         0,      1,          1];
linewidth = 1;

%% MEF1

plot(1:24,MEF1_spring,'Color',spring_color,'LineWidth',linewidth);
hold on 
plot(1:24,MEF1_summer,'Color',summer_color,'LineWidth',linewidth);
plot(1:24,MEF1_fall,'Color',fall_color,'LineWidth',linewidth);
plot(1:24,MEF1_winter,'Color',winter_color,'LineWidth',linewidth);
hold off
box off; ylabel('tCO_2e') 
set(gca,'FontSize',15)
%title('Incremental MEF 24SA (tCO2e/MWh)')
legend({'spring','summer','fall','winter'},'Location','best'); legend boxoff
saveas(gcf,strcat(Plotpath,region,'_','MEF1_24SA.png'));
%% MEF2

plot(1:24,MEF2_spring,'Color',spring_color,'LineWidth',linewidth);
hold on 
plot(1:24,MEF2_summer,'Color',summer_color,'LineWidth',linewidth);
plot(1:24,MEF2_fall,'Color',fall_color,'LineWidth',linewidth);
plot(1:24,MEF2_winter,'Color',winter_color,'LineWidth',linewidth);
hold off
box off; ylabel('tCO_2e') 
set(gca,'FontSize',15)
%title('Costliest plant MEF 24SA (tCO2e/MWh)')
legend({'spring','summer','fall','winter'},'Location','best'); legend boxoff
saveas(gcf,strcat(Plotpath,region,'_','MEF2_24SA.png'));
%% MEF3

plot(1:24,MEF3_spring,'Color',spring_color,'LineWidth',linewidth);
hold on 
plot(1:24,MEF3_summer,'Color',summer_color,'LineWidth',linewidth);
plot(1:24,MEF3_fall,'Color',fall_color,'LineWidth',linewidth);
plot(1:24,MEF3_winter,'Color',winter_color,'LineWidth',linewidth);
hold off
box off; ylabel('tCO_2e') 
set(gca,'FontSize',15)
%title('Thermal MEF 24SA (tCO2e/MWh)')
legend({'spring','summer','fall','winter'},'Location','best'); legend boxoff
saveas(gcf,strcat(Plotpath,region,'_','MEF3_24SA.png'));
%% MEF4

plot(1:24,MEF4_spring,'Color',spring_color,'LineWidth',linewidth);
hold on 
plot(1:24,MEF4_summer,'Color',summer_color,'LineWidth',linewidth);
plot(1:24,MEF4_fall,'Color',fall_color,'LineWidth',linewidth);
plot(1:24,MEF4_winter,'Color',winter_color,'LineWidth',linewidth);
hold off
box off; ylabel('tCO_2e') 
set(gca,'FontSize',15)
%title('Demand MEF 24SA (tCO2e/MWh)')
legend({'spring','summer','fall','winter'},'Location','best'); legend boxoff
saveas(gcf,strcat(Plotpath,region,'_','MEF4_24SA.png'));
%% MEF5

plot(1:24,MEF5_spring,'Color',spring_color,'LineWidth',linewidth);
hold on 
plot(1:24,MEF5_summer,'Color',summer_color,'LineWidth',linewidth);
plot(1:24,MEF5_fall,'Color',fall_color,'LineWidth',linewidth);
plot(1:24,MEF5_winter,'Color',winter_color,'LineWidth',linewidth);
hold off
box off; ylabel('tCO_2e') 
set(gca,'FontSize',15)
%title('AEF 24SA (tCO2e/MWh)')
legend({'spring','summer','fall','winter'},'Location','best'); legend boxoff
saveas(gcf,strcat(Plotpath,region,'_','MEF5_24SA.png'));


%% 24YA

MEF1_marker = '-o'; MEF1_color = [0 ,       0.4470, 0.7410, 1];
MEF2_marker = '-*'; MEF2_color = [0.8500,   0.3250, 0.0980, 1];
MEF3_marker = '-^'; MEF3_color = [0.9290,   0.6940, 0.1250, 1];
MEF4_marker = '-d'; MEF4_color = [0.4940,   0.1840, 0.5560, 1];
MEF5_marker = '-.'; MEF5_color = [0.4660,   0.6740, 0.1880, 1];

plot(1:24,MEF1_24YA,MEF1_marker,'Color',MEF1_color,'LineWidth',linewidth);
hold on
plot(1:24,MEF2_24YA,MEF2_marker,'Color',MEF2_color,'LineWidth',linewidth);
plot(1:24,MEF3_24YA,MEF3_marker,'Color',MEF3_color,'LineWidth',linewidth);
plot(1:24,MEF4_24YA,MEF4_marker,'Color',MEF4_color,'LineWidth',linewidth);
plot(1:24,MEF5_24YA,MEF5_marker,'Color',MEF5_color,'LineWidth',linewidth);
hold off; box off; ylabel('tCO_2e') ;
set(gca,'FontSize',15)
%title('All EFs 24-hour Annual Average (tCO2e/MWh)')
legend({'Incremental','Costliest','Thermal','Demand','AEF'},'Location','best'); legend boxoff
saveas(gcf,strcat(Plotpath,region,'_','MEF_all_24YA.png'));


%% YA

plot(1:24,repmat(MEF1_YA,1,24),MEF1_marker,'Color',MEF1_color,'LineWidth',linewidth);
hold on
plot(1:24,repmat(MEF2_YA,1,24),MEF2_marker,'Color',MEF2_color,'LineWidth',linewidth);
plot(1:24,repmat(MEF3_YA,1,24),MEF3_marker,'Color',MEF3_color,'LineWidth',linewidth);
plot(1:24,repmat(MEF4_YA,1,24),MEF4_marker,'Color',MEF4_color,'LineWidth',linewidth);
plot(1:24,repmat(MEF5_YA,1,24),MEF5_marker,'Color',MEF5_color,'LineWidth',linewidth);
hold off; box off; ylabel('tCO_2e') ;
set(gca,'FontSize',15)
%title('All EFs Annual Averages (tCO2e/MWh)')
legend({'Incremental','Costliest','Thermal','Demand','AEF'},'Location','east'); legend boxoff
saveas(gcf,strcat(Plotpath,region,'_','MEF_all_YA.png'));