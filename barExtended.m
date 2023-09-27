function barExtended(varargin) 
% Create a stacked bar graph of both negative and positive values. 
% 
% Syntax. 
% barExtended(Y) 
%   Create a new figure window and place the bar plot within it. 
% 
% barExtended(axes_handle,Y) 
%   Place the bar plot with the axes pointed to be axes_handle. 

% Parse input. 
if nargin == 1 
  Y = varargin{1}; 
else 
  Y = varargin{2}; 
end 

% Positive components. 
fh(1) = figure; 
hP    = bar(gca,Y.*(Y>0),'stacked'); 
ahP   = gca; 

% Negative components. 
fh(2) = figure; 
hN    = bar(Y.*(Y<0),'stacked'); 

% Clean up. 
if nargin == 1 
  set([hP,hN],'parent',ahP); 
  close(fh(2));
 

else 
  set([hP,hN],'parent',varargin{1}); 
  close(fh);
   
  
end 

end 