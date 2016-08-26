% PROJECTOR PARAMETERS
Lamp_Power = 300;                   % Lamp Power (Watts)
m = 0.05;                           % Mass (kg)
Cp = 1005.4;                        % Specific Heat (J/kg/ºK)
k_convection = 200;                 % Heat Transfer Coefficient (W/m^2/ºK)
Surface_Area = 1.5e-02;             % Surface Area (m^2)
Celsius_Offset = 273;               % Convert Celsius to Kelvin
Ambient_Temp = 20+Celsius_Offset;   % Ambient Temperature (ºC)
Initial_Temp = Celsius_Offset;      % Initial Temp (K)
temp_thres = 70;                    % Temperature threshold for fan

Fan_Air_Displacement = 1.8e-4;      % Fan Air Displacement (kg/rev)
Fan_Speed = 2300;                   % Fan Speed (rpm)

% CONFIGURE Fan_Flow TO BE A TUNABLE PARAMETER
Fan_Flow = Simulink.Parameter;
Fan_Flow.RTWInfo.StorageClass = 'SimulinkGlobal';
Fan_Flow.Value = Fan_Speed*(Fan_Air_Displacement/60)*Cp; % (Watts/ºK)

