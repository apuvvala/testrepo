function [ticks_to_count, reset] = sltestSwitchHarnessConfigurationGenData(T)
% Copyright 2015 The MathWorks, Inc.
%
% Abstract:
%   Data for sltestSwitchHarnessConfigurationExample.slx
    
ticks_to_count.time = (0:100)'*T;
ticks_to_count.signals.values = boolean((floor( (0:100)/2)==(0:100)/2)');
ticks_to_count.signals.dimensions = 1;
reset.time = (0:100)'*T;
reset_values = boolean(zeros(101,1)); reset_values(90)=true;
reset.signals.values = reset_values;
reset.signals.dimensions = 1;