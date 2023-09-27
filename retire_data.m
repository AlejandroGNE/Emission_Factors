function [plant_retire_data] = retire_data (plant_retire_data,retire_this_much_of,retire_cost)
warning off
plant_retire_data=struct2table(plant_retire_data); % Convert from structure to table
retire_cost.Fuel = categorical(retire_cost.Fuel); % Convert fuel data from string to categorical
plant_retire_data = sortrows(plant_retire_data,'TC','descend'); % Sort plants by descending order of total cost
categories_being_retired = retire_cost.Fuel; % list of categories being retired
for technology = 1:length(categories_being_retired) % for all categories being retired
    retireable_generators = plant_retire_data(plant_retire_data.Category ==  categories_being_retired(technology),:); % extract all generators 
    cumulative_retireable_capacity = cumsum(retireable_generators.Capacity_MW,1); % get the cumuluative sum of the capacities (previously sorted from most to least costly)
    ind = find(cumulative_retireable_capacity>=-retire_this_much_of(technology),1); % locate row of cumulative capacities that is greater than the capacity being retired
    if ind>1 % if we must retire 2 plants or more...
        retireable_generators.Capacity_MW(1:ind) = 0; % from located plants, make zero the capacity of all plants but the last one
        retireable_generators.Capacity_MW(ind) = retireable_generators.Capacity_MW(ind)+(retire_this_much_of(technology)+cumulative_retireable_capacity(ind-1)); % retire remaining capacity
        retireable_generators(1:ind-1,:)=[]; % from located plants, erase all of them but the last one
    else
        retireable_generators.Capacity_MW(ind) = retireable_generators.Capacity_MW(ind)+retire_this_much_of(technology);
    end
    plant_retire_data(plant_retire_data.Category ==  categories_being_retired(technology),:) = [];
    plant_retire_data = [plant_retire_data;retireable_generators];
end
plant_retire_data=table2struct(plant_retire_data,'ToScalar',true);    
