%% Generating a Test Results Report
%
% Copyright 2015 The MathWorks, Inc.

%%
% This example shows how to generate a test results report from the 
% test manager using a baseline test case. The model used for
% this example is |sltestTestManagerReportsExample|, which is 
% a modified version of a shipping Simulink(R) demo called |sldemo_absbrake|.
% See <matlab:showdemo('sldemo_absbrake') sldemo_absbrake> for details.
% Switch to a directory with write permissions.

%% Load and run the test file
% Load and run the test file programmatically using the test manager.
% The test file contains a baseline test case that fails when it is
% run. The baseline criteria specified in the baseline test case
% does not match the model simulation, which makes the test case fail.

exampleFile = fullfile(matlabroot, ...
                       'toolbox', 'simulinktest', 'simulinktestdemos', ...
                       'sltestTestManagerReportsTestSuite.mldatx');
sltest.testmanager.load(exampleFile);
baselineObj = sltest.testmanager.run;

%% Generate the report
% Generate a report of the test case results using the results set object.
% The report is saved as a ZIP and will show all test results. 
% The report opens when it is completed.

%%

sltest.testmanager.report(baselineObj,'baselineReport.zip','IncludeTestResults',0, 'IncludeComparisonSignalPlots', true);

%%
% View the report when it is finished generating. Notice that the overall
% baseline test case fails. The signals in baseline criteria do not match,
% which causes the test failure. You can view the signal
% comparison plots in the report to verify the failure.

%%
%

sltest.testmanager.clear;
sltest.testmanager.clearResults;
displayEndOfDemoMessage(mfilename)
