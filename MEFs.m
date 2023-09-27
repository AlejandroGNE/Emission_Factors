%% Comparing marginal emissions factors
thisDir= pwd;
Plotpath= strcat(pwd,'\PlotsMEF\');
saver= strcat('MEF_',date);
%% Get MEFs for MISO & NYISO (v4)
grids = 2;
for region = grids:-1:1
    [MEF_data{region},Dispatch_data{region},hourlyGHG0{region},powerplants{region}] = MEF_function(region);
end
%% Hourly MEF plots
for region = 1:grids
    hourly_MEF_plots(region,Plotpath,MEF_data{region})
end
%% Apply MEFs to case studies(v4)
load('Case_Studies.mat','Case_Studies')
techs = size(Case_Studies,1);
parfor casestudy = 1:techs
    for region = 1:grids
        [Emissions{casestudy}{region},...
            Dispatch1{casestudy}{region},...
            hourly_GHG1{casestudy}{region}] = GHG_casestudy(region,Case_Studies(casestudy,:),hourlyGHG0{region},MEF_data{region});
    end
end
save(saver,'Emissions','MEF_data')
%% Compare between methods and data aggregations
% Bar plots of approximations vs true emissions
parfor casestudy = 1:techs
    for region = 1:grids
[barplots{casestudy}{region}] = MEF_plots(casestudy,region,Emissions{casestudy}{region},Plotpath);
    end
end
%% Subplots (values)
runs = 0;
for casestudy = 1:techs
    for region = 1:grids
        counter = runs + 1;
        Emissions_data = Emissions{casestudy}{region};
        subplot(techs,grids,counter) %temporary; regions will be flipped; later remove the -1, when we drop Srujana's old MISO data and region=1 actually means MISO data
        Approximations = Emissions_data(1:5,1:4);
        Actual_value = Emissions_data(6,1);
        b = bar(Approximations);
        hold on
        c = plot(xlim,[Actual_value Actual_value],'--k','LineWidth',1.5);
        hold off
        ylabel('Change in emissions (tCO_2e)')
        set(gca,'XTickLabel',{'Incremental','Costliest','Thermal','Demand','AEF'})
        set(gca,'FontSize',12)
        set(gcf,'Position',[100 100 550 500])
        if counter == 2
            h = [b(1);b(2);b(3);b(4);c];
            legend(h,{'Hourly','24-hour season','24-hour yearly','Yearly','Simulated'},'Location','Best')
            legend boxoff
        end
        runs = counter;
    end
end

set(gcf,'Position',[100 0 800 1500])

saveas(gcf,strcat(Plotpath,'subplots','_','bar_plot.png'));

%% Subplots (values; trim outliers)
extra_space = 1.5;
runs = 0;
for casestudy = 1:techs
    for region = 1:grids
        counter = runs + 1;
        Emissions_data = Emissions{casestudy}{region};
        subplot(techs,grids,counter)
        Approximations = Emissions_data(1:5,1:4);
        Actual_value = Emissions_data(6,1);
        b = bar(Approximations);
        hold on
        c = plot(xlim,[Actual_value Actual_value],'--k','LineWidth',1.5);
        hold off
        ylabel('Change in emissions (tCO_2e)')
        set(gca,'XTickLabel',{'Incremental','Costliest','Thermal','Demand','AEF'})
        set(gca,'FontSize',12)
        set(gcf,'Position',[100 100 550 500])
        abs_aprx = abs(Approximations);
        b_max = max(abs_aprx);  % max value of each column (of each temporal resolution)
        b_max = maxk(b_max,2);  % choose the 2 highest values
        b_max1 = b_max(1);      % outlier
        b_max2 = b_max(2);      % highest non-outlier
        if b_max1 > b_max2*2
            [row,col] = find(abs_aprx==b_max2);
            yl = [min(0,b(col).YData(row)*extra_space) max(0,b(col).YData(row)*extra_space)];
            axis([xlim yl])
            [row2,col2] = find(abs_aprx==b_max1);
            xtips = b(col2).XData(row2)-0.16;   % change for XEndPoints(row2) to place right on bar
            b_max_1_nonabsolute = Approximations(row2,col2);
            if b_max_1_nonabsolute < 0
                ytips = yl(1)*0.91;
            elseif b_max_1_nonabsolute > 0
                ytips = yl(2)*0.98;
            end
            if counter == 1
                axis([xlim [yl(1)*1.5 yl(2)]])
                ytips = yl(1)*1.5*0.91;
                h = [b(1);b(2);b(3);b(4);c];
                legend(h,{'Hourly','24-hour season','24-hour yearly','Yearly','Simulated'},'Location','Southwest')
                legend boxoff
            end
            outlier_label = string(round(b(col2).YData(row2)));
            labels = strcat(outlier_label,' tCO_2e');
            text(xtips,ytips,labels,'HorizontalAlignment','left',...
                'VerticalAlignment','cap','Fontsize',15)
        end

        
        runs = counter;
    end
end

set(gcf,'Position',[100 0 800 1500])

saveas(gcf,strcat(Plotpath,'subplots','_','bar_plot_TRIMMED.png'));

%% Subplots (error percentages)
runs = 0;
for casestudy = 1:techs
    for region = 1:grids
        counter = runs + 1;
        Emissions_data = Emissions{casestudy}{region};
        subplot(techs,grids,counter)
        Approximations = Emissions_data(1:5,1:4);
        Actual_value = Emissions_data(6,1);
        Percent_error = ((Approximations - Actual_value)/Actual_value)*100;
        b = bar(Percent_error);
        set(gca,'XTickLabel',{'Incremental','Costliest','Thermal','Demand','AEF'})
        ylabel('Estimation error (%)')
        set(gca,'FontSize',12)
        set(gcf,'Position',[100 100 550 500])
        if counter == 4
            h = [b(1);b(2);b(3);b(4)];
            legend(h,{'Hourly','24-hour season','24-hour yearly','Yearly'},'Location','Best')
            legend boxoff
        end
        runs = counter;
    end
end

set(gcf,'Position',[100 0 800 1500])

saveas(gcf,strcat(Plotpath,'subplots','_','error_bar_plot.png'));

%% Subplots (error percentages; trim outliers)
extra_space = 1.5;
runs=0;
for casestudy = 1:techs
    for region = 1:grids
        counter = runs + 1;
        Emissions_data = Emissions{casestudy}{region};
        subplot(techs,grids,counter) %temporary; regions will be flipped; later remove the -1, when we drop Srujana's old MISO data and region=1 actually means MISO data
        Approximations = Emissions_data(1:5,1:4);
        Actual_value = Emissions_data(6,1);
        Percent_error = ((Approximations - Actual_value)/Actual_value)*100;
        b = bar(Percent_error);
        ylabel('Estimation error (%)')
        set(gca,'XTickLabel',{'Incremental','Costliest','Thermal','Demand','AEF'})
        set(gca,'FontSize',12)
        set(gcf,'Position',[100 100 550 500])
        positive_approximations = Percent_error(Percent_error>=0);
        negative_approximations = Percent_error(Percent_error<=0);
        if find(positive_approximations) > 0
        b_max_positive = maxk(positive_approximations,2);
        b_max1_positive = b_max_positive(1);
        b_max2_positive = b_max_positive(2);
        trim_positives = b_max1_positive > b_max2_positive*2;
        end
        if find(negative_approximations) > 0
        b_max_negative = mink(negative_approximations,2);
        b_max1_negative = b_max_negative(1);
        b_max2_negative = b_max_negative(2);
        trim_negatives = b_max1_negative < b_max2_negative*2;
        end
        
        if trim_positives==1 && trim_negatives==1
            yl = [b_max2_negative*extra_space b_max2_positive*extra_space];
            axis([xlim yl])
            [row,col] = find(Percent_error==b_max2_positive);
            [row2,col2] = find(Percent_error==b_max1_positive);
            xtips = b(col2).XData(row2)-0.16;   % change for XEndPoints(row2) to place right on bar
            ytips = yl(2)*0.98;
            outlier_label = string(round(b(col2).YData(row2)));
            labels = strcat(outlier_label,' %');
            text(xtips,ytips,labels,'HorizontalAlignment','left',...
            'VerticalAlignment','cap','Fontsize',15)
            [row,col] = find(Percent_error==b_max2_negative);
            [row2,col2] = find(Percent_error==b_max1_negative);
            xtips = b(col2).XData(row2)-0.16;   % change for XEndPoints(row2) to place right on bar
            ytips = yl(1)*0.91;
            outlier_label = string(round(b(col2).YData(row2)));
            labels = strcat(outlier_label,' %');
            text(xtips,ytips,labels,'HorizontalAlignment','left',...
                'VerticalAlignment','cap','Fontsize',15)
        elseif trim_positives==1 && trim_negatives==0
            yl = [b_max1_negative*extra_space b_max2_positive*extra_space];
            if counter == 5
                yl = [b_max1_negative*extra_space b_max2_positive+15];          
            end
            axis([xlim yl])
            [row,col] = find(Percent_error==b_max2_positive);
            [row2,col2] = find(Percent_error==b_max1_positive);
            xtips = b(col2).XData(row2)-0.16;   % change for XEndPoints(row2) to place right on bar
            ytips = yl(2)*0.98;
            if counter == 1
                axis([xlim [yl(1) yl(2)*1.5]])
                ytips = yl(2)*1.5*0.98;
                h = [b(1);b(2);b(3);b(4)];
                legend(h,{'Hourly','24-hour season','24-hour yearly','Yearly'},'Location','Southwest')
                legend boxoff
            end
            outlier_label = string(round(b(col2).YData(row2)));
            labels = strcat(outlier_label,' %');
            text(xtips,ytips,labels,'HorizontalAlignment','left',...
                'VerticalAlignment','cap','Fontsize',15)
        elseif trim_positives==0 && trim_negatives==1
            axis([xlim b_max2_negative*extra_space b_max1_positive*extra_space])
        elseif trim_positives==0 && trim_negatives==0
        end
        runs = counter;
    end
end

set(gcf,'Position',[100 0 800 1500])

saveas(gcf,strcat(Plotpath,'subplots','_','error_bar_plot_TRIMMED.png'));
close all
%% Plot load profiles

% PV
PV_spaghettis = reshape(Case_Studies(1,:),24,365)*(1000);
plot(1:24,PV_spaghettis(:,1),'Color',[1,0.647,0,0.2]);
hold on
for day = 365:-1:2
    plot(1:24,PV_spaghettis(:,day),'Color',[1,0.647,0,0.2]);
end
hold off
box off
set(gca,'FontSize',15)
set(gcf,'Position',[100 100 300 300])
title('(a) PV')
axis([1 24 ylim])
saveas(gcf,strcat(Plotpath,'loadprofile_PV.png'));

% EV
EV_loadprofile = Case_Studies(2,1:24)*(1000);
plot(1:24,EV_loadprofile,'LineWidth',1.5);
box off
set(gca,'FontSize',15)
set(gcf,'Position',[100 100 300 300])
title('(b) EV')
axis([1 24 ylim])
saveas(gcf,strcat(Plotpath,'loadprofile_EV.png'));

% Heat pump
HP_spaghettis = reshape(Case_Studies(3,:),24,365)*(1000);
plot(1:24,HP_spaghettis(:,1),'Color',[1,0,0,0.2]);
hold on
for day = 365:-1:2
    plot(1:24,HP_spaghettis(:,day),'Color',[1,0,0,0.2]);
end
hold off
box off
set(gca,'FontSize',15)
set(gcf,'Position',[100 100 300 300])
title('(c) HP')
axis([1 24 ylim])
saveas(gcf,strcat(Plotpath,'loadprofile_HP.png'));
close all