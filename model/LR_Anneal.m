function [LR2]=LR_Anneal(LR1,pop_old,pop_new,Periods,Year,num_tech)

Alpha= log(1-LR1)/log(2);
initial_pop=repmat(pop_old(:,1)-pop_new(:,1),1,Periods);
Learning = (pop_old(:,1:Periods)./initial_pop).^repmat(Alpha,1,Periods); %2016$/Kw

%Learning=cumprod(Learning,2); %(?)

%Extrapolating values
year2=Year:(Year)+(Periods*5);
year2([1 5:5:(Periods)*5])=[];
year2(end)=[];
LR2=zeros(num_tech,Periods*5);
LR2(:,5:5:(Periods)*5)=Learning;
year=[Year Year+4:5:(Periods)*5+(Year)]; %to include the starting year
LR2(:,1)=1;
for j=1:num_tech
LR2(j,(LR2(j,:)==0))=interp1(year,[1 Learning(j,:)],year2,'linear');
end

% Function named 'LR_Anneal' outputs 'LR2' w/ inputs: LR1, pop_old,
% Periods, Year, & num_tech

% This is the learning model