%% Requirements-Based Testing for Model Development
%
% This example demonstrates testing a subsystem against a requirement,
% using the test manager, test harness, Test Sequence block, and Test
% Assessment block. The requirements document links to the test case and
% test harness, and |verify| statements assess the component under test.
%
% As you build your model, you can add test cases to verify the model
% against requirements. Subsequent users can run the same test cases, then
% add test cases to accomplish further verification goals such as achieving
% 100% coverage or verifying generated code.
%
% This example tests the |Roll Reference| subsystem against a
% requirement using three scenarios. A Test Sequence block provides inputs,
% and a Test Assessment block evaluates the component. The |Roll Reference|
% subsystem is one component of an autopilot control
% system. |Roll Reference| controls the reference angle of the aircraft's
% roll control system. The subsystem fails one
% assessment, prompting a design change that limits the subsystem output at
% high input angles.

%% Paths and Example Files
% 
% Enter the following to store paths and file names for the example:
%
filePath = fullfile(matlabroot,'toolbox','simulinktest','simulinktestdemos');
topModel = 'TestAndVerificationAutopilotExample';
reqDoc = 'RollAutopilotRequirements.txt';
rollModel = 'RollAutopilotMdlRef';
testHarness = 'RollReference_Requirement1_3';
testFile = 'AutopilotTestFile.mldatx';
harnessLink = 'http://localhost:31415/matlab/feval/rmiobjnavigate?arguments=[%22RollAutopilotMdlRef:urn:uuid:523e5d2d-bb86-43b2-a187-43c52a2bc174.slx%22,%22GIDa_3fe26a28_ee1e_4aff_b1cd_3303ca12539c%22]';

%% Run the Test Against the Requirement
% 
% Open the |RollAutopilotMdlRef| model. The full control system
% |TestAndVerificationAutopilotExample| references this model.
%
open_system(fullfile(filePath,rollModel));

%% 
%
% Open the test file. In the model, select *Analysis > Test Manager* to
% open the test manager.
% Open the test file |AutopilotTestFile.mldatx|, located in |filePath|. You
% can also enter:
%
%    open(fullfile(filePath,testFile));
 
%%
%
% Open the requirements document. In the test browser, expand
% *AutopilotTestFile* and *Basic Design Test
% Cases* in the tree, and click *Requirement 1.3 test*. In the Requirement 1.3 test
% tab, expand *Requirements* and click the link to open the requirement file.

%%
% <<reqlink.png>>

%%
% In the document, requirement 1.3 states:  "When roll hold mode becomes
% the active mode,
% the roll hold reference shall be set to the actual roll attitude of the
% aircraft, except under the following conditions:
%
% * The roll hold reference shall be set to zero if the actual roll angle
% is less than 6 degrees in either direction, at the time of roll hold
% engagement.
% * The roll hold reference shall be set to 30 degrees in the same
% direction as the actual roll angle if the actual roll angle is greater
% than 30 degrees at the time of roll hold engagement.
% * The roll reference shall be set to the cockpit turn knob command, up to
% a 30 degree limit, if the turn knob is commanding 3 degrees or more in
% either direction.
%
% The test case creates three scenarios to test the normal conditions and
% exceptions in the requirement.

%%
% The requirements document traces to the test harness using URL's
% that map to the Test Sequence block and test steps. Open the test harness
% using the command
%
%   web(harnessLink)

%%
%
% The Test Sequence block, Test Assessment block, and component under test
% link to the requirements document. Highlight requirements links by
% selecting *Analysis > Requirements Traceability > Highlight Model* in the
% Simulink editor, or clicking the *Toggle Requirements Links* button in
% the Test Sequence
% Editor toolstrip.
%

%%
sltest.harness.open([rollModel '/Roll Reference'],testHarness)
rmi('highlightModel','RollReference_Requirement1_3')

%% The Test Sequence
%
% Open the Test Sequence block.
%
open_system('RollReference_Requirement1_3/Test Sequence')

%%
% <<AutopilotTestSeqReq1-3.png>>

%%
% The Test Sequence block creates test inputs for three scenarios:
%
% In each test, the test sequence sets a signal level, then engages the
% autopilot. The test sequence checks that |PhiRef| is stable for a minimum
% time |DurationLimit| before it transitions to the next signal level. For
% the first two
% scenarios, the test sequence sets the |EndTest| local variable to |1|,
% triggering the transition to the next scenario.
%
% These scenarios check basic component function, but do not
% necessarily achieve objectives such as 100% coverage.

%% Test Assessments
%
% Open the Test Assessment block.
%
open_system('RollReference_Requirement1_3/Test Assessment')

%%
% <<AutopilotTestAssessReq1-3.png>>

%%
%
% The Test Assessment block evaluates |Roll
% Reference|. The assessment block is a library linked subsystem, which
% facilitates test assessment reuse between multiple test harnesses. The
% block contains |verify| statements covering:
%
% * The requirement that |PhiRef| = |Phi| when |Phi| operates inside the low and
% high limits.
% * The requirement that |PhiRef = 0| when |Phi < 6| degrees.
% * The requirement that |PhiRef = 30| when |Phi > 30| degrees.
% * The requirement that when |TurnKnob| is engaged, |PhiRef = TurnKnob| if 
% |TurnKnob >= 3| degrees.
% 

%% Verify the Subsystem
%
% Run the test. In the test manager, right-click *Requirement 1.3 Test* and
% click *Run*.
%
% The simulation returns |verify| statement results and simulation output in
% the Test Manager. The first |verify_high| statement fails.
%
%  Warning: Test verification failed at t = 10.125 : PhiRef must equal 30
%  for high pos angle operation.
%
% # Click *Results and Artifacts* in the test manager.
% # In the results tree, expand *Verify Statements*. Click *Simulink:
% verify_high*. The trace shows when the statement fails.

%%
%
% <<rollref_req_testing_verify_fail.png>>

%%
% # In the results tree, expand *Results*, *Requirement 1.3
% Test*, and *Sim Output*.
% # Select |PhiRef| and |Phi|. Observe that |PhiRef| exceeds 30 degrees
% when |Phi| exceeds 30 degrees.

%%
% <<rollref_req_testing_output.png>>

%% 
%
% Update |RollReference| to limit the |PhiRef| signal. Add a Saturation
% block as shown. Set the lower limit to |-30| and the upper limit to |30|.

%%
% <<autopilotHighLimitAdd.png>>

%%
% Run the test again. The |verify| statement passes,
% and the output in the test manager shows that |PhiRef| does not exceed 30
% degrees.

%%
% <<rollref_req_testing_output_revised.png>>

%%
%

close_system(rollModel,0);
close_system(topModel,0);
close_system('RollRefAssessLib',0);
close_system('RollRefAssess_Req1_3',0);
sltest.testmanager.clear;
sltest.testmanager.clearResults;
clear filePath topModel reqDoc rollModel testHarness testFile harnessLink
displayEndOfDemoMessage(mfilename)
