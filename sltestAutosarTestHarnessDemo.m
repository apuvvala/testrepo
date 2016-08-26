%% Test Models that use Export Functions for AUTOSAR-Compliant Code
%
% This model demonstrates a test harness built for function-call
% subsystems and Simulink functions driven by root-level Inport blocks.
% You can use such models to generate AUTOSAR-compliant code.
% Test harnesses built for function-call
% subsystems and Simulink functions driven by root-level Inport blocks
% drive the function-call triggers
% with function-call outputs of a Test Sequence block, and call
% Simulink functions from the Test Sequence block.  For other subsystem
% inputs and outputs, you can choose the sources and sinks when you create
% the test harness.

%% Open the Model and Test Harness
% 
% Open the model and the test harness.  The top-level model contains four
% subsystems that count the number of times each subsystem is called. Two
% are Simulink functions and two are function-call subsystems. 
filePath = fullfile(matlabroot,'toolbox','simulinktest','simulinktestdemos');
open_system(fullfile(filePath,'sltestAutosarTestHarnessExample'));

%%
%
% The test harness uses a test sequence block to call each of the functions
% sequentially, for a varying amount of time each.  The counts for each
% successive called function increase correspondingly.
% 
sltest.harness.open('sltestAutosarTestHarnessExample','CounterTest');

%% Test Harnesses for Export Functions
%
% When you create a test harness for a model that is configured to export
% functions, the test harness will contain a Test Sequence block that is
% configured to call each root-level Simulink Function block and send a
% trigger event to each function-call subsystem in the model.
%
% * Function-call outputs from the Test Sequence block drive Function-Call
% subsystems using the |send| operator:
%%
%   send(fncall_count1);
%%
% * Simulink functions are called with the function name in the test
% sequence action, using local variables to define arguments to the function.
%%
%   slcount(u1,u2);

%% 
% The test sequence in this example calls each of the functions in
% succession.
%
% <<sltestAutosarTestSequence.png>>

%% Run the Test

open_system('CounterTest/Scope');
sim('CounterTest');

%%

sltest.harness.close('sltestAutosarTestHarnessExample','CounterTest');
close_system('sltestAutosarTestHarnessExample',0);
clear a;
clear filePath;
