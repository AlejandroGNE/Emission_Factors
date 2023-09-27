% CFA - CashFlows Accounting, detailed dispatch
function [Grid_price,Emissions_rate,Dispatch,hourlyGHG,plant_tb,Last_dispatched,plant_main,residual_load]=CFAv4(BPeriods,Periods,Year,pop2,P0,MISO,Var_Energy,interest,Load_monte,num_tech,name1,Cap_cost,NG,monte)
%% 1 - Setup major variables
pop2=reshape(pop2,num_tech,Periods);                % pop2 is the capacities (MW) R&A of each technology; for MAC project, we only add renewables and leave the rest empty      % rows are techs, columns are periods
cashflow= zeros(num_tech,BPeriods*5);               % Empty matrix that'll host yearly cashflows 
Popbuild= zeros(num_tech,BPeriods*5);               % Popbuild has annualized pop2 (pop2/5)
peryear=pop2/5;                                     % Divide capacities by number of years per period i.e. Annualize capacities (currently they're 5-year periods)
Popbuild(:,1:Periods*5) = repelem(peryear,1,5);     % Repeat each element of peryear in all rows and 1st 35 columns 
%% 2 - Learning Rates Variables
pop_old=P0(:,2:end);                                %Cumulative capacity before present year    % Selects all but first column of P0 (WHY?)     % P0 is the cumulative capacity up to a given year
pop_new=diff(P0,[],2);                              %Capacity additions per year (delta P0)     % Returns P0 in differences, i.e. cumulative capacity of period y, minus cumulative capacity of period y-1, which is the new capacity of period y-1
Learning=LR_Anneal(Cap_cost.LR,pop_old,pop_new,Periods,Year,num_tech);      % Call Learning Model   % This creates matrix with learning multipliers (rows are techs columns are years)
%% 3 - Capital costs with learning
cap_cost=repmat(Cap_cost.Capital_cost_dolKW,1,Periods*5);   % Call current capital costs per tech from data, repeat them 34 times 
cap_cost(Popbuild(:,1:Periods*5)<0)=0;                      % To ensure there are no capital costs during retirements
cashflow(:,1:Periods*5)=cap_cost.* Learning;                % Capital costs times learning multipliers (costs with learning)    % Here cashflow is the new unit capital costs [$/kW] affected by learning
cashflow=cashflow.*Popbuild*1000;                           % These are the total capital costs     % Unit capital costs [$/kW] times 1000 kW/MW, times adoption (MW) = Total capital costs for each tech ($)
%% 4 - Retirements & additions (R&A)
Ind=5:5:Periods*5;                                                              % ind is index for list of years with R&A, indexes every fifth year since 2025 (no R&A in between)
year=Year+4:5:(Periods)*5+(Year);                                               % year for list of R&A (2020-2051), in steps of 5 years
plant_struct(1:monte,1)=repmat(table2struct(MISO,'ToScalar',true),monte,1);     % Convert data from MISO into structure called plant_structure (take existing plants, copy in new database, from which we'll add/retire)
for counter1=1:monte                                                            % ID for each Monte Carlo iteration
    for counter2=1:Periods                                                      % ID for each period (1,2,...,7)
        if (counter2~=1)                                                        % For every period except the first one (i.e. not equals 2020)...
        plant_struct(counter1,counter2)=plant_struct(counter1,counter2-1);      % Replace ID for each period with ID of previous period
        end
         [~,Coal, Nuc,Oil, Bio] = fuel_prices(year(counter2));                  % Load fuel_prices for every year there's R&A (2020-2051)
            % Adding new plants to existing grid and writing data on fuel prices, TC & MC
             A=find(pop2(:,counter2)>0);                                        % Find additions
             plant_struct(counter1,counter2)= read_data (plant_struct(counter1,counter2),NG(counter1,Ind(counter2)),...
                 Coal, Nuc,Oil,Bio, pop2(A,counter2),...
                 name1(A),Cap_cost(A,:),size(A,1));                             % Create new plants and add them to database
            % Retiring plants
             B=find(pop2(:,counter2)<0);                                        % Find retirements
             plant_struct(counter1,counter2) = retire_data (plant_struct(counter1,counter2),...
                  pop2(B,counter2),...
                 Cap_cost(B,:));                                                % Retire plants and remove them from database
    end
end
plant_struct=plant_struct';                                                     % From 1x7 (1 MC iteration by 7 periods) to 7x1
Load_d = reshape(permute(Load_monte, [2 1 3]), size(Load_monte, 2), [])';       % Best way to reshape! (Nothing happens in deterministic)
plant_struct=reshape(plant_struct,Periods*monte,1);                             % New & optimized grid design (Nothing happens in deterministic)
%% 5 - Calculating variable cost & emissions

for counter = 1:Periods
[~,~,plant_tb,Dispatch,hourlyGHG,~,plant_main,residual_load] = EDGHG(plant_struct(counter,1),Load_d(counter,:),Var_Energy);
    for k = 8760:-1:1
        if ~isempty(find(Dispatch(:,k),1,'last'))
        Last_dispatched(k) = find(Dispatch(:,k),1,'last');
        else
        Last_dispatched(k) = 0;
        end
    end
    for k = 8760:-1:1
        if ~isempty(find(Dispatch(:,k),1,'last'))
        Grid_price(k,counter) = plant_tb.TC(Last_dispatched(1,k));
        else
        Grid_price(k,counter) = 0;
        end
    end
    for k = 8760:-1:1
        if ~isempty(find(Dispatch(:,k),1,'last'))
        Emissions_rate(k,counter) = plant_tb.CO2eq_lbMWh(Last_dispatched(1,k));
        else
        Emissions_rate(k,counter) = 0;
        end
    end
end
%% Reshape & annualize variable cost which is currently per every 5 years
% Variable_cost=reshape(Variable_cost,Periods,monte);                                     % Reshape VC from row to column vector
% year2=Year:(Year)+(Periods*5);                                                          % List of years from first to last in steps of 1 (2016 to 2051) (1x36 row vector)
% year2([Ind,end])=[];                                                                    % Same but omit elements of "Ind" defined above (multiples of 5) AND last year 2051 (1x28 row vector)
% Variable2=zeros(BPeriods*5,monte);                                                      % Zeroes matrix (55xmonte)
% Variable2(Ind,1:monte)=Variable_cost;                                                   % Paste Variable_cost values in every fifth row of "Variable2"
% Variable2((Periods*5+1):end,1:monte)= repmat(Variable2(Periods*5,:),20,1);              % Copy last data value from Variable_cost (35th row) to remaining rows below it
% Variable2(Variable2==0)=interp1(year(1:Periods)',Variable_cost,year2','linear');        % Interpolate linearly years with no values (non-multiples of 5); doesn't work for 1st 4 rows
% Variable2(1:4,:)=interp1(year(1:Periods)',Variable_cost,year2(1:4),'linear','extrap');  % Extrapolate 1st 4 rows
% Cost= repmat(sum(sum(cashflow,3),1)',1,monte)+Variable2;                                % Adds total capital cost to variable cost
% %% Apply social discount rate
% real=(1/(1+interest)).^(0:BPeriods*5-1);                                                % Discounting: present value multiplier
% Total=sum(Cost.*repmat(real',1,monte));                                                 % DTSC (Discounted Total System Cost)