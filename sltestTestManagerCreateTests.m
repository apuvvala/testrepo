%% Generating Test Cases from a Model
%
% Copyright 2015 The MathWorks, Inc.

%%
% This example shows how to generate test cases based on the components in your model.
% This example uses the model |sltestTestManagerCreateTestsExample|, which has been
% pre-configured with the following:
%
% * Signal Builder group in the top model
% * Test harnesses in the top model 
% * Signal Builder group at the top level of a test harness

%% Open the Model and Test Manager
%
% Execute the following code to open the model configured with different components such as Signal
% Builder groups and test harnesses.
mdl = 'sltestTestManagerCreateTestsExample';
open_system(mdl);

%%
% Open the test manager. Enter |sltestmgr| in the MATLAB command prompt.

%% Generate Test Cases From the Model
% In the test manager, click the *New* arrow and select *Test File > Test File from Model*.

%%
% <<sltestTestManagerCreateTestsFromModelPix.png>>

%%
% # In the *New Test File* dialog box, click the *Use current model* button.
% to specify |sltestTestManagerCreateTestsExample| as the *Model*.
% # Specify the *Location* of the test file.
% # Select the |Baseline| from the *Test Type* dropdown. All test cases generated will be of the test type specified here. 
% # Click *Create*. 

%%
% <<sltestTestManagerNewTestFileDialogPix.png>>

%%
% The test manager creates a test case for each of the following:
%
% * Signal Builder groups in the top model
% * Test harnesses in the top model 
% * Signal Builder group at the top level of a test harnesses

%% 
% In each generated test case, you need to specify the comparison criteria,
% equivalence or baseline, before you run the test.

%%
% <<sltestTestManagerTestsCreatedFromModelPix.png>>

%%
close_system(mdl, 0);
clear mdl;

displayEndOfDemoMessage(mfilename)
