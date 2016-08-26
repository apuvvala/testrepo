%% Using Custom Source and Sink Blocks
%
% Copyright 2015 The MathWorks, Inc.

%% 
% This example shows how to create a test harness using custom source and 
% custom sink blocks. 
model = 'sltestCustomSourceSinkExample';
testHarness = 'sltestCustomSourceSinkExample_Harness1';

%% 
% Open the model.
open_system(model);

%% 
% Create a test harness for the entire model. Open 
% the Create test harness dialog (*Analysis > Test Harness > Create Test Harness*).
% Make sure that no blocks are selected before opening the dialog.
%
% Drive the model with Sine Wave blocks as the source and 
% Display blocks as sinks. To configure the source, select *Custom* and 
% enter |simulink/Sources/Sine Wave|. For the sink, select 
% *Custom* and enter |simulink/Sinks/Display|. 
%
% Here is a quick way to determine the correct path to use for a library block:
%
% # Open the library model (for built-in sources, use open_system('simulink')
% # Navigate the block of interest and select it
% # Switch to the MATLAB(R) command window and type |gcs|. The output path can be
%    copied into the dialog.
% 
% The following code shows the equivalent method using the command line API:
sltest.harness.create(model, ...
    'Source','Custom', 'CustomSourcePath','simulink/Sources/Sine Wave',...
    'Sink','Custom','CustomSinkPath','simulink/Sinks/Display');

%%
% Open the test harness.
sltest.harness.open(model, testHarness);

%% 
% After opening the test harness, specify the Sine Wave parameters 
% |Amplitude|, |Frequency| and |Sample Time| parameter values as follows:
% In1:
%   Amplitude = 0.1 Frequency = pi/3
% In2:
%   Amplitude = 2.0 Frequency = 1
% In3:
%   Amplitude = 0.3 Frequency = pi/6
% Sample Time = 0.01 for all three blocks.
% 
% Specify the parameters by double-clicking each block 
% and entering the values in the dialog. The following set_param
% API can also be used:
set_param('sltestCustomSourceSinkExample_Harness1/In1', ...
    'Amplitude', '0.1', 'Frequency', 'pi/3', 'SampleTime', '0.01');
set_param('sltestCustomSourceSinkExample_Harness1/In2', ...
    'Amplitude', '2.0', 'Frequency', '1', 'SampleTime', '0.01');
set_param('sltestCustomSourceSinkExample_Harness1/In3', ...
    'Amplitude', '0.3', 'Frequency', 'pi/6', 'SampleTime', '0.01');

%%
% Simulate the test harness to observe the outputs in the Display blocks.
sim(testHarness);

%% 
% Close the test harness.
sltest.harness.close(model, testHarness);

%% 
% Close the model.
close_system(model, 0);

%% 
clear model testHarness;

displayEndOfDemoMessage(mfilename)
