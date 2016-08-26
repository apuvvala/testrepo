%% Test Two Simulations for Equivalence
%
% Copyright 2015 The MathWorks, Inc.

%%
%
% This example shows how to test for equivalence between two models using
% test harnesses and the test manager. One model runs in normal mode, and 
% a test harness model created from a subsystem runs in software-in-the-loop 
% (SIL) mode. 
%
% The equivalence test case in the test manager compares signal output
% between two simulations to determine equivalence. Signals from the
% main model and the test harness are set up for logging in this example.
% The logged signals are used as the equivalence criteria between normal
% and SIL mode.
%

%% Configure the Model
% Open the |sltestNormalSILEquivalenceExample| model.
mdl = 'sltestNormalSILEquivalenceExample';
harnessOwner = 'sltestNormalSILEquivalenceExample/Controller';
open_system(mdl);

%%
% Turn on signal logging in the model.
set_param(mdl,'SignalLogging','on','SignalLoggingName', 'SIL_signals');

%%
% Mark the Controller subsystem output and input signals for logging.
ph_controller_in = get_param('sltestNormalSILEquivalenceExample/Controller/In1','PortHandles');
ph_controller_out = get_param('sltestNormalSILEquivalenceExample/Controller','PortHandles');

set_param(ph_controller_in.Outport(1),'DataLogging','on');
set_param(ph_controller_out.Outport(1),'DataLogging','on');
clear ph_controller_in ph_controller_out;

%%
% Simulate the model and output the logged signals. The signal data is used
% as input for the test harness.
out = sim(mdl);

%%
% Get the logged signal data.
out_data = out.get('SIL_signals');
control_in1 = out_data.get(2);

%% Create a Test Harness for SIL Verification. 
% The command to create the harness will generate code. Switch to a directory with write permissions.

origDir = pwd;
cd(tempdir);
cleanup = onCleanup(@()cd(origDir));
sltest.harness.create(harnessOwner,'Name','SIL_Harness','VerificationMode','SIL');

%%
% Open the test harness.
sltest.harness.open(harnessOwner,'SIL_Harness');

%% Set Up Logging in the Test Harness
% Turn on signal logging in the test harness.
set_param('SIL_Harness','SignalLogging','on','SignalLoggingName', 'SIL_signals');

%%
% Mark the test harness outport for signal logging to use in the equivalence test case.
ph_harness_out = get_param('SIL_Harness/Controller','PortHandles');
set_param(ph_harness_out.Outport(1),'DataLogging','on');
clear ph_harness_out;

%%
% Assign the input data from the simulation to the test harness.
set_param('SIL_Harness','LoadExternalInput','on',...
    'ExternalInput','control_in1.Values');

%% Create an Equivalence Test Case in the Test Manager
% Open the test manager by selecting *Analysis > Test Manager* or the
% command
%
%   sltestmgr

%%
% <<sltestNewTestManagerWindowPix.png>>

%%
% Create an equivalence test case.  
% 
% # From the test manager toolstrip, click the *New* arrow and select *Test File > Blank Test File*.
% # Specify the test file as |testHarnessEquivalence.mldatx|. The test manager creates the test file with a
% new test suite and baseline test case by default.
% # In the *Test Browser* pane, select the baseline test case, |New Test Case 1|, and click *Delete*.
% # Select |New Test Suite 1|.
% # From the toolstrip, click the *New* arrow and select *Equivalence Test*.
% # In the *Test Browser* pane, right-click the new equivalence test case and select |Rename|. Name the new equivalence test case |SIL Equivalence Test|.

%%
% <<sltestNamedTestCasePix.png>>

%%
% Assign the test harness to the equivalence test case *Simulation 1*.

%%
% # Expand *Simulation 1* and *System Under Test*.
% # Click the *Use current model* button to assign |sltestNormalSILEquivalenceExample| to *Model*.
% # Expand *Test Harness*.
% # Click the *Refresh* button to get an up-to-date list of
% available test harnesses.
% # Select SIL_Harness from the *Harness* menu to use as the *System Under Test*.

%%
% <<sltestAssignTestHarnessPix.png>>

%%
% Assign the |sltestNormalSILEquivalenceExample| model as *Simulation 2*.

%%
% # Collapse *Simulation 1*.
% # Expand *Simulation 2* and *System Under Test*.
% # Click the *Use current model* button to assign |sltestNormalSILEquivalenceExample| to *Model*.
% # Collapse *Simulation 2*.
%

%%
% Capture the equivalance criteria. Under *Equivalence Criteria*, click
% *Capture* to run the test harness in *Simulation 1* and identify the
% equivalence signal.
%

%%
% <<sltestEquivalenceCriteriaPix.png>>

%% Run the Test Case and View the Results
%
% Select |SIL Equivalence Test| in the *Test Browser* pane and click *Run*
% in the toolstrip. The test manager switches to the *Results and Artifacts* 
% pane and runs the equivalence test case.
% The test case passes because the signal comparison between the model and
% the test harness matches. Expand the results set and select the |Controller:1| 
% option button to plot the signal comparison.

%%
% <<sltestSelectComparisonPlotPix.png>>

%%
% <<sltestComparisonPlotResultPix.png>>

%%
% 
close_system(mdl, 0);
clear mdl harnessOwner cleanup control_in1 origDir out out_data;


displayEndOfDemoMessage(mfilename)
