function [NG,Coal, Nuc,Oil, Bio] = fuel_prices(Year)

    load('database_fuel.mat');
    ind=find(fuel.Year==Year,1);
    Coal=fuel.Coal(ind);
    Nuc=fuel.Nuc(ind);
    Oil=fuel.Oil(ind);
    Bio=fuel.Biomass(ind);
    NG=fuel.NG(ind);
    
    
    
end