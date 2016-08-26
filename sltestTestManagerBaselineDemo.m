%% Creating Baseline Tests
%
% Copyright 2015 The MathWorks, Inc.

%%
% This example shows you how to create baselines tests for a model.  
% The example uses the model |sltestBaselineBasicExample| to generate a baseline dataset  
% of expected results by simulating the model. The baseline test case checks that the simulation 
% results produce the same output as the baseline dataset, which determines the pass/fail
% criteria of the test case.  
%

%% Open the Model and Test Manager
% Open the model.
mdl = 'sltestBaselineBasicExample';
open_system(mdl);

%%
% From the model, select *Analysis > Test Manager* to open the test manager.

%% 
% To create a new test file, in the test manager toolstrip, click *New > Test File > Blank Test File*.

%%
% <<sltestCreateNewBlankTestFilePix.png>>

%%
% Name the test file |ExampleTestFile|, and save it in a folder where
% you have write permissions.

%%
% <<sltestNewTestFileAfterCreationPix.png>>

%% Capture baseline
% Now that you have a baseline test case to work with, populate the
% relevant fields. Under *System Under Test*, enter |sltestBaselineBasicExample| for the *Model*.
% To capture a baseline for the test case, click *Capture*
% in the *Baseline Criteria* section. Save the file in a directory
% that has write permissions.

%%
% <<sltestBaselineTestCaseAfterSetupPix.png>>

%% 
% Click *Run* from the toolstrip to execute the test.

%%
% <<sltestBaselineTestCaseJustBeforeRunningPix.png>>

%% Expanding Results 
% After the test completes, expand all rows in the *Results and Artifacts* pane. The test case passes 
% because no changes were made to the model and the signals were identical.

%%
% <<sltestResultsAfterExpansionPix.png>>

%% Visualize Comparison Results
% Select the option button for |Out2| under *Baseline Criteria Result* to visualize 
% comparison results.

%%
% <<sltestResultsComparisonPlotted1Pix.png>>

%% Visualize Simulation Outputs 
% Select the check boxes for |Out1| and |Out2| under *Sim Output* to
% visualize the outputs from the simulation.

%%
% <<sltestResultsOutputsPlotted1Pix.png>>

%%
% Change the value of |gain2_var| in MATLAB command prompt.
gain2_var = 6;

%%
% In the test manager, switch to the *Test Browser* pane. Select the test case, and click *Run* to run the test again. 
% Notice that the test fails because the simulation results do not match
% the baseline criteria due to the change in the |gain2_var| parameter value. 

%%
% <<sltestResultsComparisonPlotted2Pix.png>>

%%
% <<sltestResultsOutputsPlotted2Pix.png>>

%% 
close_system(mdl, 0);
clear mdl;


displayEndOfDemoMessage(mfilename)
