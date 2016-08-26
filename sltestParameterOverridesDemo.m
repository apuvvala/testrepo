%% Overriding Model Parameters in a Test Case
%
% Copyright 2015 The MathWorks, Inc.

%%
% This example shows how to override a parameter defined in a model
% workspace using the test manager and viewing its effect on model
% output compared to a baseline. The example model used is a modified
% version of a shipping Simulink(R) example that models the Van Der Pol 
% Oscillator. For more information, see <matlab:open_system('vdp') vdp>.

%% Open model
mdl = 'sltestParameterOverridesExample';
open_system(mdl);

%% Open the Test File 
% Open test manager using the function |sltestmgr|.
% Load the example test file named |sltestParameterOverridesTestSuite.mldatx| using the commands:
%
%   exampleFile = fullfile(matlabroot, ...
%      'toolbox', 'simulinktest', 'simulinktestdemos', ...
%      'sltestParameterOverridesTestSuite.mldatx');
%   sltest.testmanager.load(exampleFile);

%% Overriding a Model Parameter
% Expand the test suite in the *Test Browser* pane and double-click the
% test case named |Test Override|. Scroll down to the
% *Baseline Criteria* section and click *Capture*.

%%
% <<sltestParamOverrides1Pix.png>>

%%
% Save the baseline file to a convenient location.

%%
% <<sltestParamOverrides2Pix.png>>

%%
% Expand the *Parameter Overrides* section in the test case and click *Add*.

%%
% <<sltestParamOverrides3_1Pix.png>>

%%
% New dialog box appears to help choose available parameters.

%%
% <<sltestParamOverrides3Pix.png>>

%%
% Click the *Refresh* button to display a list of available parameters.
% Select parameter |a| as shown and press OK.

%%
% <<sltestParamOverrides4Pix.png>>

%%
% The parameter |a| will be overridden with the *Override Value* when the test case runs.

%%
% <<sltestParamOverrides5Pix.png>>

%%
% Double-click the *Override Value* |1| and give it a new override value of
% |1.1|.

%%
% <<sltestParamOverrides6Pix.png>>

%% Execution and Results
% Select the test file in the *Test Browser* pane and click *Run*.
% In the *Results and Artifacts* pane, expand the results to see the *Baseline Criteria Result*
% and *Sim Output*.

%%
% <<sltestParamOverrides7Pix.png>>

%%
% Select |Mux: 1[1]| inside *Baseline Criteria Result* to see how overriding
% the parameter |a| affected the mux signal when compared to the captured
% baseline. The comparison output shows a maximum difference of approximately *0.6*.

%%
% <<sltestParamOverrides8Pix.png>>

%%
% To see a summary of results and parameter overrides, double-click the test
% case result |Test Override| in the *Result and Artifacts* pane.

%%
% <<sltestParamOverrides9Pix.png>>

%% Overriding Parameters using Data Files
% Navigate to the example folder directory:
cd(fullfile(matlabroot,'toolbox','simulinktest','simulinktestdemos'));

%% 
% Return to the test case and scroll to the *Parameter Overrides* section. Click the
% *Add* arrow.

%%
% <<sltestParameterOverrideArrow.png>>

%% 
% Select *Add File* option from drop down.

%%
% <<sltestParamOverrides10Pix.png>>

%%
% Select |sltestParametersOverrideData.mat| file. This file contains data that can be
% used by the test case to override the parameters. When the test case runs, the file is
% loaded and the parameter values contained in the file are used.

%%
% <<sltestParamOverrides11Pix.png>>

%%
% Select a row, right-click, and select *Export*. This exports the variable to the 
% MATLAB(R) base workspace. You can see the value of the variable in the base workspace.

%%
% <<sltestParamOverrides12Pix.png>>

%% Cleanup
close_system(mdl, 0);
clear mdl;

displayEndOfDemoMessage(mfilename)
