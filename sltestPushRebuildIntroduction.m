%% Synchronizing Data between a Model and a Test Harness
%
% Copyright 2015 The MathWorks, Inc.

%% 
% This example shows how to synchronize parameters and data from a test harness 
% to the main model. It also shows how to rebuild a test harness from the main model.
% Open the model.
mdl = 'sltestPushRebuildExample';
open_system(mdl);

%%
% Open the test harness attached to the |Controller subsystem|. 
sltest.harness.open([mdl '/Controller'],'Controller_Harness1');

%%
% The test harness contains a copy of required variables
% from the main model workspace.
% 
% Update the value of a variable in the test harness model workspace.
ws = get_param('Controller_Harness1', 'ModelWorkspace'); 
evalin(ws, 'Ka = 0.7'); 
clear ws;

%%
% The model workspace in the test harness is now out-of-sync with the main
% model. To synchronize, 'push' changes back to the main model.
% Select *Analysis > Test Harness > Push Parameters to main model*
% or enter:
sltest.harness.push([mdl '/Controller'], 'Controller_Harness1');

%%
% Close the test harness.
sltest.harness.close([mdl '/Controller'], 'Controller_Harness1');

%% 
% The main model workspace has been updated. Confirm this
% by opening the *Model Explorer* and browsing to the *Model Workspace* node
% for the main model.

%% 
% Next, change a variable in the main model workspace. Also 
% change the solver in the main model configuration to 'ode23'.
ws = get_param(mdl, 'ModelWorkspace'); 
evalin(ws, 'Kf = -1.71');
set_param(mdl, 'Solver', 'ode23'); 
clear ws; 

%%
% Open the test harness
sltest.harness.open([mdl '/Controller'],'Controller_Harness1');

%% 
% The test harness is now out-of-sync with the main model. To synchronize, 
% rebuild the harness with these new settings. Select *Analysis > Test Harness > Rebuild harness from main model* or
% enter:
sltest.harness.rebuild([mdl '/Controller'],'Controller_Harness1');

%%
% The test harness has been updated with the new model workspace values and
% a new active *Configuration Set*. Confirm this by opening
% the *Model Explorer* and browsing to the *Model Workspace* node for the test harness
% model.
sltest.harness.close([mdl '/Controller'],'Controller_Harness1');

%%
% Close the test harness and the model.
close_system(mdl, 0);

%%
clear mdl;

displayEndOfDemoMessage(mfilename)
