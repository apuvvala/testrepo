% This script plots the thermal response data from the example
% sltestProjectorFanSpeedExample
%%
figure(1), hold on
axis([0 70 20 80]);

LampX = 0:80:80;
LampY = [45,45];
MaxX = 0:80:80;
MaxY = [65,65];

xlabel('Time (s)');
ylabel('Temperature (C)');

plot(ComparisonData.Fan800.Time,ComparisonData.Fan800.Temp);
plot(ComparisonData.Fan1300.Time,ComparisonData.Fan1300.Temp);
plot(ComparisonData.Fan1800.Time,ComparisonData.Fan1800.Temp);
plot(ComparisonData.Fan2300.Time,ComparisonData.Fan2300.Temp);
plot(LampX,LampY,'k--');
plot(MaxX,MaxY,'r--');

legend('800','1300','1800','2300','location','northwest');
