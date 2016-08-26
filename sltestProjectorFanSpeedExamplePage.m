%% Parametric Sweep for a Simscape Thermal Model
%
% Copyright 2015, The MathWorks, Inc.

%% Objective
% This example demonstrates how to test a physical system, and how to optimize a
% parameter using a test harness, test sequence, and the test manager. The
% example uses a system-level thermal model of a
% projector which includes Simscape(R) thermal blocks. Run the following to
% set paths and names for the example.
%
Model = 'sltestProjectorFanSpeedExample';
Harness = 'FanSpeedTestHarness';
Path = fullfile(matlabroot,'toolbox','simulinktest','simulinktestdemos');
TestSuite = 'sltestProjectorFanSpeedTestSuite.mldatx';
open_system(Model);

%% Test Plan and System Requirements
% This test demonstrates sweeping through several fan speeds to 
% determine the optimal value. In short, the optimal fan speed results in
% the fastest response without damaging the system. In detail, the
% optimal fan speed:
% 
% * Prevents the system from exceeding the specified maximum temperature.
% * Minimizes the time for the system to reach the temperature at which the
%   lamp emits visible light.
% 
% The document 
% |sltestProjectorFanSpeedExampleRequirements.txt| captures these detailed
% requirements and the test procedure. You can find the document in
% the folder specified by |Path| above.
% 
% Test-specific model items reside in the test harness, keeping the 
% main model free of unnecessary blocks, suitable for 
% code generation, and suitable for integration with other models.

%% Open the Test File
% Open the Test Manager to view the test suite controlling the parameter
% sweep.  From the menu click *Analysis > Test Manager*.  In the toolbar,
% select *Open* and open the test suite located on the example path.
% 
% You can also enter
%
%   open(fullfile(Path,TestSuite))

%% Description of the Test
% The test investigates the transient and steady-state thermal 
% characteristics of the system. The test sequence initializes the system to ambient 
% temperature, then powers the projector lamp.  When the system reaches a
% steady-state condition, the lamp switches off.  This test is
% modeled in a test harness using a Test Sequence block. Run the following
% to open the test harness:
%
sltest.harness.open(Model,Harness);

%% Requirements Linking
%
% The test suite contains links to the requirements document.
% You can view the requirements link by opening the test suite in the Test
% Browser, and clicking the links in the *Requirements*
% section.

%% The Test Sequence
% Double-click the Test Sequence block to open the test sequence editor.
% 
% <<sltestProjectorTestSequenceSteps.png>>
% 
% The |T0out| and |T0in| signals store the initial
% projector temperature at each test step.
% 
% |PowerOnTime| stores simulation time when the lamp signal activates. This
% facilitates subsequent data analysis.
% 
% The transition condition detects the steady-state condition. 
% At steady-state, the system temperature change is a small fraction |(Threshold)| of the
% difference between the current projector temperature and the initial
% projector temperature at each step.  This condition must hold for a
% minimum time |DurationLimit|, in this case 10 seconds.
%

%% Description of the Parameter Sweep
% The pre-load callbacks contain the command to set the fan speed for each
% test case under the |Fan Speed Parametric Study| test suite. The
% parameter overrides contain the command to recalculate fan 
% airflow from fan speed, and then override the test harness
% parameter. You can view these commands in the *Callbacks* and *Parameter Overrides*
% section of each test case.
%
% <<sltestProjectorTestCaseOverridesCallbacks.png>>

%% Run the Test
% In the *Test Browser*, highlight *Fan Speed Parametric Study* and click
% *Run*.  When the test suite simulation completes, open the results for
% each test case and select |ProjectorTemp|.
% View the results in the Test Manager.
% 
% <<sltestProjectorTestResults.png>>

%% Export the Data
% With the Test Manager you can export data for post-processing.
% In the *Results and Artifacts* pane of the Test Manager, right-click *Sim
% Output* for each test case and select *Export*.
% 
% This example includes the exported data in four MAT files, located in the
% folder specified by |Path|:
%
%   ProjectorTempFanSpeed800.mat
%   ProjectorTempFanSpeed1300.mat
%   ProjectorTempFanSpeed1800.mat
%   ProjectorTempFanSpeed2300.mat
%

%% Investigate Response Time and Maximum Projector Temperature
%
% Since the test sequence transitions execute when the system reaches
% steady-state, and the fan speed changes the system response, the lamp
% activates at different simulation times for each of the four test cases.
% Simplify the graphical results analysis by plotting each response with 
% the lamp activation at the same time.
%
% Extract the lamp activation response data, and plot the system response 
% for the four fan speeds. Evaluate the results against these
% criteria:
% 
% * The temperature shall not exceed 65 deg C.
% * The lamp emits visible light above 45 deg C.  Minimize the time to
% reach this temperature.
% 
% Load the results.  At the command line, enter
% 
DataAt800 = load('ProjectorTempFanSpeed800.mat');
DataAt1300 = load('ProjectorTempFanSpeed1300.mat');
DataAt1800 = load('ProjectorTempFanSpeed1800.mat');
DataAt2300 = load('ProjectorTempFanSpeed2300.mat');

%%
%
% The script |ArrangeProjectorData.m| arranges the temperature and power
% on data from the output for each run. You can open the file at the
% location specified by |Path| to see the details of the script.
%
ArrangeProjectorData

%%
%
% The script |PlotProjectorThermalResponse.m| plots the thermal response of
% the projector after the lamp activates, for each of the fan speeds. You
% can open the file at the location specified by |Path| to see the
% details of the script.
PlotProjectorThermalResponse

%%
% 
% <<sltestProjectorResultsFigure1.png>>
% 

%% Results Interpretation
% 
% The results show that while the highest fan speed results in the lowest
% maximum temperature, it also takes the longest time to reach the lamp
% activation temperature.  The lowest fan speed results in the fastest
% lamp activation, but the system exceeds the maximum specified
% temperature by a significant margin.
% 
% Fan speed = 1300 keeps the system under the maximum temperature spec, and
% the system also reaches lamp activation temperature approximately 3
% seconds faster than with the highest fan speed.

%%
%
close_system(Model,0);

%%
%
clear Model;
clear Harness;
close(figure(1));
displayEndOfDemoMessage(mfilename)
