function [total_operation_cost,GHG,plant_tb,dispatch,hourlyGHG,clearing_price,plant_main,residual_load]=EDGHG(plant_tb,demand,Var_Energy) % Each column corresponds to each period
%% run without function call
% plant_tb = plant_struct(1,:);
% demand = Load2(1,:);
%% load data; remove renewables from load & dispatcheable capacity
plant_tb=struct2table(plant_tb);
plant_tb=sortrows(plant_tb,'TC');
H = plant_tb.Category == 'HYDRO';
S = plant_tb.Category == 'SOLAR';
W = plant_tb.Category == 'WIND';
hydro_generation = sum(plant_tb.Capacity_MW(H))*Var_Energy.Hydro;
solar_generation = sum(plant_tb.Capacity_MW(S))*Var_Energy.Solar;
wind_generation = sum(plant_tb.Capacity_MW(W))*Var_Energy.Wind;
var_energy = hydro_generation + solar_generation + wind_generation;
residual_load=demand'-var_energy; % residual load = total load - renewable generation
plant_main=plant_tb; % keep all plants apart
H = find(H); S = find(S); W = find(W);
plant_tb([H;S;W],:)=[]; % dispatcheable plants = all plants - renewable plants
plant_renewables = plant_main([H;S;W],:);
annual_renewable_generation = table(unique(plant_renewables.Category),[sum(hydro_generation);sum(solar_generation);sum(wind_generation)],'VariableNames',{'Category','Annual_generation_MWh'});
%% Set up dispatch variables; run for hour zero
UB_Cap=plant_tb.UB.*plant_tb.Capacity_MW; % upper bound or maximum capacity dispatcheable
LB_Cap=plant_tb.LB.*plant_tb.Capacity_MW; % lower bound or minimum capacity shed
clearing_price=zeros(8760,1);
dispatch=zeros(size(plant_tb.Capacity_MW,1),8760);
cap = plant_tb.Capacity_MW;
capacity=cumsum(cap,1);
Ind=find(capacity>=residual_load(8760),1);
dispatch(1:Ind,1)=cap(1:Ind);
if (Ind>2)
    dispatch(Ind,1)=residual_load(8760)-capacity(Ind-1);
end
P_used=dispatch(:,1);
%% Run dispatch for all hours of the year
for k=1:8760
    UBlimit = min(plant_tb.Capacity_MW,(P_used+UB_Cap)); % upper bound is the plant's full capacity, or its capacity in previous hour + its ramp up rate, whatever is less
    LBlimit = zeros(size(LB_Cap));
    ind = find(LB_Cap);
    LBlimit(ind)=max(0,P_used(ind)-LB_Cap(ind)); % lower bound is zero (turn plant off), or its capacity in previous hour - its ramp down rate, whatever is more
    capup=UBlimit-LBlimit; % maximum capacity dispatcheable per plant
    LoadU=residual_load(k)-sum(LBlimit); % remove the must-dispatch from residual load
    capacityU=cumsum(capup,1); % stack maximum capacity dispatcheable per plant (they're already sorted by ascending marginal cost)
    IndU=find(capacityU>=LoadU,1); % find where the stack is greater than the residual load
    genU=zeros(size(LB_Cap));
    genL=LBlimit;
    genU(1:IndU)= capup(1:IndU);
    if (IndU>1)
        genU(IndU)=LoadU-capacityU(IndU-1); % removes excess capacity from last plant dispatched
    end
    dispatch(:,k)=round(genL+genU,8); % sum must-dispatch generation with meet-residual-load generation
    P_used=dispatch(:,k);
    clearing_price(k) = plant_tb.TC(find(dispatch(:,k), 1, 'last' ));
end
clearing_price=clearing_price';
%% Get total costs of operating the grid; emissions
fixed_cost = sum(plant_main.Capacity_MW.*plant_main.OnM_dolkW *1000); % to make sure renewables are taken into account
variable_cost_fossils = (sum(dispatch,2).* plant_tb.TC);
variable_cost_renewables = ...
    sum(Var_Energy.Solar) * sum(plant_main.Capacity_MW(S)) * mean(plant_main.TC(S)) +...
    sum(Var_Energy.Wind) * sum(plant_main.Capacity_MW(W)) * mean(plant_main.TC(W)) +...
    sum(Var_Energy.Hydro) * sum(plant_main.Capacity_MW(H)) * mean(plant_main.TC(H));
% rev=sum(gen.*repmat(y',size(plant_tb.Capacity_MW,1),1),2)-Cost1;
total_operation_cost = sum(variable_cost_fossils) + fixed_cost + variable_cost_renewables; % total cost of operating the grid = fixed costs + variable csots
GHG = nansum(sum(dispatch,2).* plant_tb.CO2eq_lbMWh); % Multiply yearly generation by respective emissions factors in CO2eq
hourlyGHG = nansum(dispatch .* repmat(plant_tb.CO2eq_lbMWh,1,8760),1);
emissions_per_plant = dispatch .* repmat(plant_tb.CO2eq_lbMWh,1,8760);

%% Export summary of generation per technology
annual_generation_summary = table(categorical(plant_tb.Category),sum(dispatch,2),'VariableNames',{'Category','Annual_generation_MWh'}); % thermal plants annual generation
annual_generation_summary = [annual_generation_summary;annual_renewable_generation]; % all plants

MWh_per_technology = table(unique(annual_generation_summary.Category),'VariableNames',{'Technology'});
for i = 1:length(MWh_per_technology.Technology)
    MWh_per_technology.Annual_generation_MWh(MWh_per_technology.Technology == MWh_per_technology.Technology(i)) =  sum(annual_generation_summary.Annual_generation_MWh(annual_generation_summary.Category == MWh_per_technology.Technology(i)));
end
MWh_per_technology = sortrows(MWh_per_technology,"Annual_generation_MWh","descend"); % summary of installed capacities for all technologies
MWh_per_technology.Technology(end+1) = 'TOTAL'; MWh_per_technology.Annual_generation_MWh(end) = sum(MWh_per_technology.Annual_generation_MWh);
for i = 1:length(MWh_per_technology.Technology)
    MWh_per_technology.Percent_Share_of_Generation(i) = (MWh_per_technology.Annual_generation_MWh(i) / MWh_per_technology.Annual_generation_MWh(end))*100;
end
MWh_per_technology.Annual_generation_MWh = round(MWh_per_technology.Annual_generation_MWh(:),2);

data_str = string(MWh_per_technology.Percent_Share_of_Generation);
for i = 1:numel(data_str)
    data_str(i) = sprintf('%.2f',data_str(i));
end
MWh_per_technology.Percent_Share_of_Generation = data_str;

MWh_per_technology;
