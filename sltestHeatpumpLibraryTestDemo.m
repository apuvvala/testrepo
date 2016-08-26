%% Testing a Library and a Linked Block
%
% This example demonstrates a test case that confirms a library block meets
% a short set of requirements. After testing the library block, you execute
% a baseline test of a linked block and capture the baseline results. You
% then promote the baseline test harness to the library.
%
% The library block controls a simple heatpump system by
% supplying on/off signals to a fan and compressor, and specifying the
% heatpump mode (heating or cooling).

%% Open the Test File
% 
% Enter the following to store paths and filenames for the example, and to
% open the test file. The test file contains a test case for the library
% block and for the block instance in a closed-loop model.

filePath = fullfile(matlabroot,'toolbox','simulinktest','simulinktestdemos');
testFile = 'sltestHeatpumpLibraryTests.mldatx';
library = 'sltestHeatpumpLibraryExample';
system = 'sltestHeatpumpLibraryLinkExample';
open(fullfile(filePath,testFile));

%%
%
% <<sltestHeatpumpLibraryTestCases.png>>

%%
% 
% Expand the *Library Block Test* test suite, and
% highlight the *Requirements Scenarios* test case in
% the test browser. Expand the *Test Harness* section of
% *System Under Test*, and click the arrow to open the test harness for the
% library block.
% 
%%
open_system(library);
sltest.harness.open([library '/Controller'],'Requirements_Tests');

%% 
% The Test Sequence block sets three scenarios for the controller:
%
% * The controller at idle
% * The controller activating the fan only
% * The controller activating the heating anc cooling system

%%
% The Test Assessment block in the test harness checks the signals 
% for each scenario. Since the test inputs and assessments
% are contained in the test harness, and no baseline data is being
% captured, the test case is a simulation test.

%% Run the Requirements-Based Test
%
% In the test manager, run the Requirements Scenarios test case. 
% The |verify| statement results show that the |control_out|
% signals pass.
%
% <<sltestHeatpumpLibraryVerifyOutput.png>>

%% Open the Linked Block Model
%
% In the test manager, expand *Instance Test*. Highlight the *Baseline Test* 
% test case. In the *System Under Test*, click the arrow next to the *Model* field
% to open the model.

sltest.harness.close([library '/Controller'], 'Requirements_Tests');
open_system(system);
sim(system);

%%
%
% The controller is a linked block to the library. It is associated with a 
% test harness *Baseline Test* that compares simulation results of the instance against
% baseline data. In your workflow, successful baseline testing for an
% instances of a library block can show that the linked block simulates 
% correctly in the containing model. The test harness supplies a sine wave
% temperature and captures the controller output.

%% Run the Baseline Test and Observe Results
%
% In the test manager, click *Run* to execute the test. The results show
% that the baseline test passes.
%
% <<sltestHeatpumpLibraryLinkOutput.png>>

%% Move the Test Harness to the Library
%
% If you develop a particularly useful test for a linked block, you can
% promote the test harness from
% a linked block to the source library block.  The test harness then 
% copies to all future instances of the library block.
%
% Move the *Baseline_controller_tests* test harness to the library block:
%
% 1. In the sltestHeatpumpLibraryLinkExample model, click the harness badge
% and hover over the *Baseline_controller_tests* test harness.
%
% 2. Click the harness operations icon 
%
% <<button_harness_operations.png>>

%%
% 3. Select *Move to Library*. A dialog informs you that the operation
% deletes the test harness from the instance and adds it to the library.
% Click *Yes*.
%
% 4. The test harness moves to the Controller library block.
%
% <<sltestHeatpumpLibraryPromotedHarness.png>>

%%
%
close_system(library,0);
close_system(system,0);
clear(filePath,library,system,testFile);
sltest.testmanager.clear;
sltest.testmanager.clearResults;

displayEndOfDemoMessage(mfilename)

