%% Projector Controller Testing Using |verify| and Real-Time Tests
%
% This example demonstrates testing a projector control system using model
% simulation and real-time execution on a target computer. The tests verify
% the controller against its requirements using test sequences that
% exercise the top-level controller model. The controller uses a push button
% input and a temperature sensor input, and outputs signals controlling the
% fan, fan speed, and projector lamp.
% 
%%
% This example uses Simulink(R) Real-Time(TM). Before beginning, review the
% Simulink Real-Time
% <http://www.mathworks.com/products/availability/index.html#XP system
% requirements>. This example also uses a requirements document in
% Microsoft(R) Word format.
%
%%
%
% Set the model and path names for the example:
filePath = fullfile(matlabroot,'toolbox','simulinktest','simulinktestdemos');
testFile = 'sltestProjectorCtrlTests.mldatx';
testHarness = 'Req_scenario_4';
model = 'sltestProjectorController';

%%
%
% Open the model:
open_system(fullfile(filePath,model))

%% View Requirements Links
%
% The model, test harnesses, test sequences, and test suites
% link to functional requirements specified in
% |sltestProjectorCtrlReqs.docx|. Highlight requirements in the
% test harness and test sequence editor to view the linked items.
%
sltest.harness.open(model,testHarness)
rmi('highlightModel',testHarness)

%%
%
close_system(fullfile(filePath,model),0)

%% Open the Test File and Configure the Real-Time Target Computer
%
% Open the test file by entering:
%
%   open(fullfile(filePath,testFile))

%%
%
% The test file contains two test suites, each of which tests four
% scenarios. One suite simulates the model, while the second executes tests
% on a real-time target computer. The test harnesses use a linked Test
% Assessment block which
% tests high-level requirements. Before running
% the example:
%
% # Configure your target computer using the Simulink Real-Time Explorer.
% # Connect to your target computer.
% # If your target computer is not the default target, update *Target
% Computer* in each test case's *System Under Test* section.

%%
%
% For more information on real-time configuration see
% <matlab:helpview(fullfile(docroot,'xpc','gs','setup-and-configuration.html'))
% Setup and Configuration> in Simulink(R) Real-Time(TM).
% 

%% Run the Model Simulation Tests
% 
% Run the model simulation test suite. After simulation completes, click
% the *Results and Artifacts* pane in the test manager.
%
% Expand the *Req_scenario_4* results and expand the *Verify Statements*
% section. The |verify| statements demonstrate fail, pass, and
% untested results:
%
% * The controller does not operate in high-temperature or overheat mode,
% so the associated |verify| statements are untested.
% * The controller passes the requirement that if the lamp is on, the fan
% is also on: |verify_lamp_implies_fan|.
% * The controller passes the test that the system stays off if the on_off
% button is pressed when the temperature is above a limit:
% |verify_sc4_on|.
% * The controller fails the test that the system shuts off if the on_off
% button is pressed when the temperature is above a limit:
% |verify_sc4_off|. Resolving this failure requires modifying the
% |OnOff Check| subsystem in the main model.
%
%%
%
% For more information, see
% <matlab:helpview(fullfile(docroot,'sltest','ug','assess-simulation-using-logical-statements.html'))
% Assess Simulation Using Logical Statements>.
%
% Select the |verify_sc4_off| and |verify_lamp_implies_fan| results to
% visualize the |verify| statement results.
%
% <<sltestProjectorControllerVerifyResults.png>>

%% Execute the Real-Time Tests and Review the Results
%
% The real-time test suite verifies that real-time execution results 
% match model simulation results, and that the |verify| statements
% pass. The test harnesses log data using file scopes.
%
% <<sltestProjectorControllerRTHarness.png>>

%%
%
% Set the current working directory to a writable directory. In the test
% manager, run the real-time test suite.
%
%%
% 
% The *Baseline Criteria Result* section shows comparisons of real-time 
% logged data to data captured from the model simulation. The results are
% identical.
% 
% The *Verify Statements* section shows similar results to the model
% simulation.

%%
% <<sltestProjectorControllerRealTimeVerifyResults.png>>

%%
close_system(model,0)
sltest.testmanager.clear;
sltest.testmanager.clearResults;
clear filePath testFile testHarness model;
displayEndOfDemoMessage(mfilename)
