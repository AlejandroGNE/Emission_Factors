function [plant] = read_data (plant,NG, Coal, Nuc,Oil,Bio, cap1,name1,Cap_cost2,num_tech)
warning off
plant=struct2table(plant);

% convert to categorical data types
Cap_cost2.Fuel          = categorical(Cap_cost2.Fuel);  
Cap_cost2.Prime_Mover   = categorical(Cap_cost2.Prime_Mover);
% add emissions of new power plants
Cap_cost2.CO2eq_lbMWh(Cap_cost2.Fuel == 'COAL') = 0.09552 * 1/1000000 * Cap_cost2.HR_btuKWh(Cap_cost2.Fuel == 'COAL') * 1000 * 2204.62;
Cap_cost2.CO2eq_lbMWh(Cap_cost2.Fuel == 'GAS') = 0.05306 * 1/1000000 * Cap_cost2.HR_btuKWh(Cap_cost2.Fuel == 'GAS') * 1000 * 2204.62;
Cap_cost2.CO2eq_lbMWh(Cap_cost2.Fuel == 'OIL') = 0.07315 * 1/1000000 * Cap_cost2.HR_btuKWh(Cap_cost2.Fuel == 'OIL') * 1000 * 2204.62;

%% add new plants
for cc = 1:num_tech

%Adding new plants
 plant.Plant_Name(end+1)=name1(cc);
 plant.Category(end)=Cap_cost2.Fuel(cc);                %% to categorical
 plant.Heatrate_BtukWh(end)=Cap_cost2.HR_btuKWh(cc);
 plant.Prime_Mover(end)=Cap_cost2.Prime_Mover(cc);      %% to categorical
 plant.UB(end)=Cap_cost2.UB(cc);
 plant.LB(end)=Cap_cost2.LB(cc);
 plant.OnM_dolkW(end)=Cap_cost2.OnM_dolkW(cc);
 plant.Var_dolMWh(end)=Cap_cost2.Var_dolMWh(cc);
 plant.CO2eq_lbMWh(end)=Cap_cost2.CO2eq_lbMWh(cc);
end

plant.Capacity_MW(end-num_tech+1:end)=cap1(1:num_tech,1);

%% estimate marginal costs for new plants
    x = plant.Category == 'GAS';
    plant.MC(x) = NG * plant.Heatrate_BtukWh(x)* 10^-3;

    x = plant.Category == 'COAL';
    plant.MC(x) = Coal * plant.Heatrate_BtukWh(x)* 10^-3;

    x = plant.Category == 'NUCLEAR';
    plant.MC(x) = Nuc * plant.Heatrate_BtukWh(x)* 10^-3;

    x = plant.Category == 'OIL';
    plant.MC(x) = Oil * plant.Heatrate_BtukWh(x)* 10^-3;

    x = plant.Category == 'BIOMASS';
    plant.MC(x) = Bio * plant.Heatrate_BtukWh(x)* 10^-3;

    plant.TC = plant.MC + plant.Var_dolMWh; % variable O&M costs taken from EIA AEO

    x = plant.Category == 'OWN';
    plant.TC(x)=10000;   

%sorting
plant = sortrows(plant,'TC');
%         x = isnan(plant.TC);
%         plant(x,:)=[];
plant = table2struct(plant,'ToScalar',true);  
        
end
