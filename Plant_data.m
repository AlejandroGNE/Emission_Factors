function [plant,Var_Energy] = Plant_data(region)

if region==1

load('MISO_generators_data_2020_NEEDS.mat','MISO_generators_data_2020_NEEDS')
plant=MISO_generators_data_2020_NEEDS;
load('MISO_plant_2015.mat','Var_Energy')

elseif region==2
    
load('NYISO_generators_data_2020_NEEDS.mat','NYISO_generators_data_2020_NEEDS')
plant=NYISO_generators_data_2020_NEEDS;
load('NYISO_2018.mat','Var_Energy')

end

