% This script arranges the thermal response data from the example
% sltestProjectorFanSpeedExample

% Extract temperature response and time when lamp was activated

  Temp800 = DataAt800.data.get('ProjectorTemp');
  Temp1300 = DataAt1300.data.get('ProjectorTemp');
  Temp1800 = DataAt1800.data.get('ProjectorTemp');
  Temp2300 = DataAt2300.data.get('ProjectorTemp');

  PowerOn800 = DataAt800.data.get('PowerOnTime');
  PowerOn1300 = DataAt1300.data.get('PowerOnTime');
  PowerOn1800 = DataAt1800.data.get('PowerOnTime');
  PowerOn2300 = DataAt2300.data.get('PowerOnTime');

% Find the corresponding lamp on time in the timeseries

  Start800 = find(Temp800.Values.Time == PowerOn800.Values.Data(1));
  Start1300 = find(Temp1300.Values.Time == PowerOn1300.Values.Data(1));
  Start1800 = find(Temp1800.Values.Time == PowerOn1800.Values.Data(1));
  Start2300 = find(Temp2300.Values.Time == PowerOn2300.Values.Data(1));

% Arrange the data for comparison on a chart, with response time = 0 at the
% lamp activation time for each run
  
  ComparisonData.Fan800.Time =...
  (Temp800.Values.Time(Start800:end)-Temp800.Values.Time(Start800));
  ComparisonData.Fan800.Temp = (Temp800.Values.Data(Start800:end));
  ComparisonData.Fan1300.Time =...
  (Temp1300.Values.Time(Start1300:end)-Temp1300.Values.Time(Start1300));
  ComparisonData.Fan1300.Temp = (Temp1300.Values.Data(Start1300:end));
  ComparisonData.Fan1800.Time =...
  (Temp1800.Values.Time(Start1800:end)-Temp1800.Values.Time(Start1800));
  ComparisonData.Fan1800.Temp = (Temp1800.Values.Data(Start1800:end));
  ComparisonData.Fan2300.Time =...
  (Temp2300.Values.Time(Start2300:end)-Temp2300.Values.Time(Start2300));
  ComparisonData.Fan2300.Temp = (Temp2300.Values.Data(Start2300:end));
