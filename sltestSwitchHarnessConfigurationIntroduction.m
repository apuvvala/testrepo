%% Switching between Harness Configurations
%
% Copyright 2015 The MathWorks, Inc.

%%
% This example shows how to switch between various harness configurations
% during incremental component development.
% The example model counts the number of ticks and outputs the count. 
mdl = 'sltestSwitchHarnessConfigurationExample';
open_system(mdl);
sim(mdl);

%%
% Open the test harness |Counter_harness| attached to the |Counter| subsystem. 
% This test harness has been created using the *Prototyping* harness
% configuration.
% Open the test harness.
sltest.harness.open([mdl '/Counter'],'Counter_harness');

%%
% The test harness |Counter_harness| is not configured for the correct
% datatypes used in the main model. This can cause simulation errors. 
% Rebuild the test harness to ensure that the datatypes used in
% the test harness are the same as that used in the main model.
%
% Click the test harness badge in the test harness
% window. This opens the test harness properties dialog. 
% Set these properties:

%% 
% * Initial harness configuration:    Refinement/Debugging

%% 
% Click *OK*. The properties take effect the next time you open the test harness. 
% 
% To manually rebuild the test harness select *Analysis > Test Harness >
% Rebuild Harness from Main Model* or enter:
sltest.harness.set([mdl '/Counter'],'Counter_harness','RebuildWithoutCompile',false);
sltest.harness.rebuild([mdl '/Counter'],'Counter_harness');

%%
% The test harness now simulates without errors. To rebuild each time you open 
% the model, update the harness configuration using the test harness properties dialog or enter:
sltest.harness.set([mdl '/Counter'],'Counter_harness','RebuildOnOpen',true);

%%
% Close the test harness.
sltest.harness.close([mdl '/Counter'],'Counter_harness');

%%
% The counter modeled in the component under test can be reset with an external
% signal. Enter the following commands to create reset logic in the model.
open_system([mdl,'/Counter'],'window');
delete_line([mdl,'/Counter'],'Previous Output/1','Add/2');
h1 = add_block('simulink/Sources/In1',[mdl,'/Counter/reset']);
set_param(h1,'Position',[65   148    95   162]);
h2 = add_block('built-in/Constant',[mdl,'/Counter/C1']);
set_param(h2,'Value','0');
set_param(h2,'Position',[40    86   120   114]);
h3 = add_block('simulink/Signal Routing/Switch',[mdl,'/Counter/Switch']);
set_param(h3,'Position',[185    91   205   139]);
add_line([mdl,'/Counter'],'C1/1','Switch/1','autorouting','on');
add_line([mdl,'/Counter'],'Previous Output/1','Switch/3','autorouting','on');
add_line([mdl,'/Counter'],'reset/1','Switch/2','autorouting','on');
add_line([mdl,'/Counter'],'Switch/1','Add/2','autorouting','on');
clear h1 h2 h3;

%%
% Enter the following commands to connect the inputs of the |Counter|
% subsystem to a root-level Inport.
h4 = add_block('simulink/Sources/In1',[mdl,'/reset']);
set_param(h4,'Position',[50   305    70   325]);
set_param(h4,'OutDataTypeStr','boolean');
set_param(h4,'SampleTime','T');
set_param(h4,'PortDimensions','1');
set_param([mdl,'/ticks_to_count'],'Position',[50   250    70   270]);
set_param([mdl,'/ticks_to_count'],'Position',[50   250    70   270]);
set_param([mdl,'/count'],'Position',[480   280   500   300]);
add_line(mdl,'reset/1','Counter/2','autorouting','on');
close_system([mdl,'/Counter']);
clear h4;

%% 
% Load external data to the model with the following commands:
set_param(mdl,'ExternalInput','ticks_to_count, reset');

%% 
% Open the test harness. Notice that the conversion subsystems are rebuilt.
sltest.harness.open([mdl '/Counter'],'Counter_harness');

%%
% Add a Pulse Generator block to drive the |Counter| reset port.
h5 = add_block(sprintf('simulink/Sources/Repeating\nSequence Stair'),'Counter_harness/Reset');
set_param(h5,'Position',[230   240   260   270]);
set_param(h5,'OutValues','[1 0 1 0]');
set_param(h5,'OutDataTypeStr','boolean');
add_line('Counter_harness','Reset/1',sprintf('Input\nConversion\nSubsystem/2'));
clear h5;

%%
% The test harness simulates without any errors or warnings.
sim('Counter_harness');

%% Cleanup
%
sltest.harness.close([mdl '/Counter'],'Counter_harness');
close_system(mdl, 0);

%%
clear mdl logsOut;

displayEndOfDemoMessage(mfilename)
