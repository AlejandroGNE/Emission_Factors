function [Installed_capacity] = get_installed_capacity(plant)

% plant = NYISO;
plant_data = plant;
plant_data.Category = categorical(plant_data.Category);
technologies = unique(plant_data.Category); % check all technology categories
number_of_technologies = size(technologies,1);
technology_capacity = zeros(1,number_of_technologies);

for k=1:number_of_technologies
    plants_of_technology = plant(plant.Category==technologies(k,1),:);
    plants_of_technology(plants_of_technology.Capacity_MW<=0,:) = [];
    technology_capacity(k) = sum(plants_of_technology.Capacity_MW);
end

Installed_capacity = array2table(technologies);
Installed_capacity.installed_capacity_MW = technology_capacity';

Installed_capacity.technologies(end+1) = 'TOTAL';
ind = find(Installed_capacity.technologies=='OWN');
Installed_capacity.installed_capacity_MW(end) = sum(Installed_capacity.installed_capacity_MW)-(Installed_capacity.installed_capacity_MW(ind));
Installed_capacity(ind,:) = [];