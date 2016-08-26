%% Code Generation Verification Workflow with Simulink Test
% 
% Copyright 2015 The MathWorks, Inc.

%%
% This example shows how to perform code generation verification (CGV) for a
% model using test harnesses, Test Sequence blocks and the test manager.
% Switch to a directory with write permissions.
%
mdl = 'sltestFuelRateControlExample';
open_system(mdl);

%%
% This example uses a model of a fuel-rate controller for a gasoline 
% engine. The example is based closely on a shipping Simulink(R) example called 
% sldemo_fuelsys. For details, see <matlab:showdemo('sldemo_fuelsys') sldemo_fuelsys>.
%

%% Description of the Model
% The controller uses four sensors from the system to determine the fuel 
% rate which gives a stoichiometric air-fuel mixture. This mixture represents the 
% ideal ratio that results in complete combustion of the fuel without any residue. 
% The four sensors used from the system are throttle angle, speed, EGO and manifold 
% absolute pressure [MAP].
% 
% The model uses three subsystems to calculate the fuel rate using the sensor inputs: 
% |control logic|, |airflow calc|, and |fuel_calc|. The core control logic is implemented
% in the Stateflow(R) chart named |control_logic|. The control logic handles single 
% sensor failures and engine overspeed protection. If a single sensor fails, 
% operation continues but the air/fuel mixture is richer to allow smoother running 
% at the cost of higher emissions. If more than one sensor has failed, the engine 
% shuts down as a safety measure, since the air/fuel ratio cannot be controlled reliably.
%
% The model estimates the airflow rate and multiplies the estimate by the reciprocal 
% of the desired ratio to give the fuel rate. 

%% Opening the Test Harness
% A Test Harness named |fuel_rate_control_cgv| has been created for the entire model. 
% The harness can be opened by clicking on the perspectives pullout icon in the bottom-right
% corner of the model canvas and choosing the |fuel_rate_control_cgv| thumbnail. Ensure that 
% the top level of the model is in view before you click on the icon.
% Alternately, the harness can be opened using the following API:
sltest.harness.open(mdl,'fuel_rate_control_cgv');

%% Modeling the Plant
% The test harness has been modeled as a closed-loop test with a Test Sequence
% block to drive fuel-rate controller. The computed |fuel_rate| from the output of the controller 
% is used to drive a model of the gasoline engine. The fuel rate combines with the 
% actual air flow in the |Engine Gas Dynamics| subsystem to determine the resulting mixture 
% ratio as sensed at the exhaust. Feedback from the oxygen sensor to the Test Sequence 
% block provides a closed-loop adjustment of the rate estimation in order to maintain 
% the ideal mixture ratio.
%
% Notice that the plant has been modeled in the test harness instead of the main model. 
% The main model is free of extraneous clutter so that code can be easily built for an 
% ECU with minimal changes to the model.

%% Modeling Sensor Failures
% The Test Sequence block named |Sequence Sensor Failures| models various
% sensor failure and engine overspeed scenarios. It accepts feedback from the plant
% and drives the controller with sensor data. This modeling pattern allows the
% Test Sequence block to control the feedback signals received by the Controller block and
% function as a canvas for authoring test cases.
% Open the Test Sequence block to see the modeled test scenarios.
open_system('fuel_rate_control_cgv/Sequence Sensor Failures');

%% Test Scenarios
% For the first 10 seconds of simulation, the test is in stabilization mode, where
% the closed loop inputs from the plant is passed through to the controller.
% The throttle and speed inputs are set to nominal values that are within
% the normal operating envelope of the controller. The |Stabilize_Engine| step
% models this state.
%
% The Test then steps through the following modes:

%%
% # |Test_Overspeed|: The throttle is ramped from 30 to 700
% # |Reset_To_Normal_Speed|: The throttle is ramped down to 400
% # |Test_EGO_Fault|: Simulate failure for 3 sec, then return to normal state
% # |Test_Throttle_Fault|: Simulate failure for 3 sec, then return to normal state
% # |Test_Speed_Fault|: Simulate failure for 3 sec, then return to normal state
% # |Test_Map_Fault|: Simulate failure for 3 sec, then return to normal state
% # |Test_Multi_Fault|: Simulate MAP and EGO failure for 3 sec
% # |Reset_MAP|: Normalize MAP sensor, and simulate just EGO failure for 3 sec
% # |Reset_To_Normal|: Terminate the test

%% Test Assessments
% The Test Sequence block |Assess Controller| verifies the controller 
% output for the various test cases modeled by the |Sequence Sensor Failures| block.
% The following assessments are modeled:

%%
% # Assert that the fueling mode is in |Warmup| mode for the first 4.8 seconds
% # Assert that fueling mode switches to |Overspeed| mode when the actual speed exceeds 628
% # Assert that the fueling mode is not in |Single_Failure| mode when multiple sensors have failed.
open_system('fuel_rate_control_cgv/Assess Controller');

%% Running a Simulation
% Simulate the test harness and observe the fuel_rate and air-fuel ratio signals.
% Notice that no assertions trigger during the simulation, which indicate that 
% all assessments modeled in |Assess Controller| pass.
open_system('fuel_rate_control_cgv/Scope');
sim('fuel_rate_control_cgv');

%% Configuring a back-to-back Test in the Test Manager
% As part of code generation verification (CGV) for the controller system, it is
% important to assert that the functional behavior of the controller is
% same during normal and software-in-the-loop (SIL) simulation modes. The test
% manager is used to perform this verification.

%%
% Use the function |sltestmgr| to open the test manager. 

%%
% Load the example test suite that models the CGV test:

%%
sltest.testmanager.load(fullfile(matlabroot, ...
                                'toolbox', 'simulinktest', 'simulinktestdemos', ...
                                'sltestFuelRateControlComparisonTestSuite.mldatx'));

%% Modeling the Test Case
% The equivalence test has been configured in the test manager so that
% the controller is simulated in normal and SIL mode and the
% numerical results are compared between these two runs. Explore the structure of the
% test case by clicking on different nodes of the test hierarchy in the *Test Browser*.

%% Running the Test Case
% Run the test in the test manager.

cgvresult = sltest.testmanager.run;

%%
% Alternately, In the test manager, select the |CGV Test1| node in the *Test Browser* 
% pane and click *Run* in the toolstrip. The pass/fail result is available in the *Results and Artifacts* pane.

%% Creating the Report
% A report can then be generated to view the result of the equivalence
% test. Use the following commands to generate the report. You can also
% launch the report after creation using the API with the |LaunchReport| 
% option set to |true|.

sltest.testmanager.report(cgvresult,'cgvresult.zip', 'LaunchReport', false,...
                          'IncludeTestResults',int32(0));

%%
%

close_system(mdl, 0);
clear mdl;
sltest.testmanager.clear;
sltest.testmanager.clearResults;

displayEndOfDemoMessage(mfilename)
