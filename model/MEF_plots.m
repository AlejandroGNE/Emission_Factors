function [b] = MEF_plots(case_study,regionn,Emissions_data,Plotpath)
% case_study = 1; % uncomment to run without function call
% regionn = 1;
% Emissions_data = Emissions{case_study}{regionn};

%% define case study and region to name plots accordingly
if case_study == 1
    casestudy = 'PV';
    if regionn == 1 || 3
        region = 'MISO';
    elseif regionn == 2
            region = 'NYISO';
    end
elseif case_study == 2
    casestudy = 'EV';
    if regionn == 1 || 3
        region = 'MISO';
    elseif regionn == 2
            region = 'NYISO';
    end
elseif case_study == 3
    casestudy = 'HeatPump';
    if regionn == 1 || 3
        region = 'MISO';
    elseif regionn == 2
            region = 'NYISO';
    end
end

%% Bar plot of Approximations vs Simulated changes in emissions
Approximations = Emissions_data(1:5,1:4);
Actual_value = Emissions_data(6,1);

b = bar(Approximations);
hold on
c = plot(xlim,[Actual_value Actual_value],'--k','LineWidth',1.5);
hold off
set(gca,'XTickLabel',{'+1kWh','Costliest','Thermal','Demand','AEF'})
set(gca,'FontSize',15)
set(gcf,'Position',[100 100 550 500])
saveas(gcf,strcat(Plotpath,casestudy,'_',region,'_','bar_plot.png'));

abs_aprx = abs(Approximations);
b_max = max(abs_aprx);
b_max = maxk(b_max,2);
b_max1 = b_max(1);
b_max2 = b_max(2);
if b_max1 > b_max2*2
    [row,col] = find(abs_aprx==b_max2);
    axis([xlim min(0,b(col).YData(row)*1.1) max(0,b(col).YData(row)*1.1)])
    [row2,col2] = find(abs_aprx==b_max1);
    xtips = b(col2).XData(row2);   % change for XEndPoints(row2) to place right on bar
    ytips = b(col2).YData(row);
    labels = string(round(b(col2).YData(row2)));
    text(xtips,ytips,labels,'HorizontalAlignment','center',...
    'VerticalAlignment','cap','Fontsize',15)
    saveas(gcf,strcat(Plotpath,casestudy,'_',region,'_','bar_plot_TRIMMED.png'));
end

% h = [b(1);b(2);b(3);b(4);c];
% legend(h,{'Hourly','24-hour season','24-hour yearly','Yearly','Simulated'},'Location','west')
% legend boxoff
% saveas(gcf,strcat(Plotpath,casestudy,'_',region,'_','bar_plot_LEGEND.png'));
%% Bar plots of error of approximations wrt to simulation
Percent_error = ((Approximations - Actual_value)/Actual_value)*100;

b = bar(Percent_error);

set(gca,'XTickLabel',{'+1kWh','Costliest','Thermal','Demand','AEF'})
% box off
% set(gca,'XTick',[])
set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 350 350])
set(gcf,'Position',[100 100 550 500])
% set(gca,'XColor','none')
saveas(gcf,strcat(Plotpath,casestudy,'_',region,'_','error_bar_plot.png'));

abs_aprx = abs(Percent_error);
b_max = max(abs_aprx);
b_max = maxk(b_max,2);
b_max1 = b_max(1);
b_max2 = b_max(2);
if b_max1 > b_max2*2
    [row,col] = find(abs_aprx==b_max2);
    axis([xlim min(0,b(col).YData(row)*1.1) max(0,b(col).YData(row)*1.1)])
    [row2,col2] = find(abs_aprx==b_max1);
    xtips = b(col2).XData(row2);
    ytips = b(col2).YData(row);
    labels = string(round(b(col2).YData(row2)));
    text(xtips,ytips,labels,'HorizontalAlignment','center',...
    'VerticalAlignment','cap','Fontsize',15)
    saveas(gcf,strcat(Plotpath,casestudy,'_',region,'_','error_bar_plot_TRIMMED.png'));
end

%% Archive
% Approximations = Emissions_data(1:4,1:4);
% Actual_value = Emissions_data(5,1);
% Percent_error = (Approximations - Actual_value)/Actual_value;
% 
% scatter(1,Actual_value)
% hold on
% scatter(1,Approximations(1,1))
% scatter(1,Approximations(2,1))
% scatter(1,Approximations(3,1))
% scatter(1,Approximations(4,1))
% hold off
% 
% bar_x = categorical({   '8760','24SA','24YA','YA',...
%                         '8760','24SA','24YA','YA',...
%                         '8760','24SA','24YA','YA',...
%                         '8760','24SA','24YA','YA'});
% bar_x = reordercats(bar_x,{    '8760','24SA','24YA','YA',...
%                                 '8760','24SA','24YA','YA',...
%                                 '8760','24SA','24YA','YA',...
%                                 '8760','24SA','24YA','YA'});
% 
% bar_x = 1:16;
% 
% bar_x = categorical({   'Emissions rate of costliest plant',...
%                         'Slope of regressing change in load over change in emissions',...
%                         'Slope of regressing change in thermal generation over change in emissions',...
%                         'Change in system emissions of dispatching 1 more MW'});
% bar_x = reordercats(bar_x,{ 'Emissions rate of costliest plant',...
%                             'Slope of regressing change in load over change in emissions',...
%                             'Slope of regressiin change in thermal generation over change in emissions',...
%                             'Change in system emissions of dispatching 1 more MW'}); % too long for a plot that'll be repeated so many times
% 
% bar_x = categorical({'Method 1','Method 2','Method 3','Method 4'});
% bar_x = reordercats(bar_x,{'Method 1','Method 2','Method 3','Method 4'});   
% 
% bar_y = [   Approximations(1,1),    Approximations(1,2),    Approximations(1,3),    Approximations(1,4);...
%             Approximations(2,1),    Approximations(2,2),    Approximations(2,3),    Approximations(2,4);...
%             Approximations(3,1),    Approximations(3,2),    Approximations(3,3),    Approximations(3,4);...
%             Approximations(4,1),    Approximations(4,2),    Approximations(4,3),    Approximations(4,4);...
%             ];
%         
% b = bar(bar_x,bar_y);
% hold on
% plot(xlim,[Actual_value Actual_value],'r'); % good but can't plot horizontal line that spans all the width
% hold off
% 
% bar(bar_y);
% hold on
% plot(xlim,[Actual_value Actual_value],'--k','LineWidth',1.5);
% hold off
% box off
% set(gca,'XTick',[])
% set(gca,'FontSize',15)
% set(gcf,'Position',[1300 1000 350 350])
% set(gca,'XColor','w')
% saveas(gcf,strcat(Plotpath,casestudy,'_',region,'_','bar_plot.png'));
% 
% horizontal version
% barh(bar_y);    % add an "h" after bar in bar function
% hold on
% plot([Actual_value Actual_value],ylim,'--k','LineWidth',1.5); % change xlim to ylim, then flip x & y values
% hold off