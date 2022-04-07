close all; 
clc;
clear;

inputFileName = 'constVelocityPath1.csv';
outputFileName = 'outFramesCartisian.csv';
% outputFileName = 'outFramesCartisian.csv';
outputJointFileName = 'outJoints.csv';

data=csvread(inputFileName);
data(:,4:6) = data(:,4:6)*pi/180;

% 璇诲彇绗?1锛?2锛?3鍒楋紝
x = data(:,1);
y = data(:,2);
z = data(:,3);

data2=csvread(outputFileName);
data2(:,4:6) = data2(:,4:6)*pi/180;

% 璇诲彇绗?1锛?2锛?3鍒楋紝
x2 = data2(:,1);
y2 = data2(:,2);
z2 = data2(:,3);

figure(2)
hold on
plot3(x,y,z,'LineWidth',1.0);
plot3(x2,y2,z2,'LineWidth',1.0);
legend('修正前轨迹','修正后轨迹');
title('机器人修正前后原点轨迹比较');
grid on
axis equal
rotate3d on

figure;
for i = 1:1:size(data2,1)
   T = poseToMatrix(data2(i,:));
   plotframe(T,15);
end
axis equal % 绛夎酱缁樺埗
grid on % 鐢诲浘
rotate3d on % 鍏佽3D鏃嬭浆

plotJoint456Traj(outputJointFileName);

[velNorm_orig, rotAngleNorm_orig, velDNorm_orig, rotAngleDNorm_orig] = getCartisenVelAcc(inputFileName);
[velNorm_mod, rotAngleNorm_mod, velDNorm_mod, rotAngleDNorm_mod] = getCartisenVelAcc(outputFileName);

% 画图
plotCartisianVel(velNorm_orig, velNorm_mod, rotAngleNorm_orig, rotAngleNorm_mod);
plotCartisianAcc(velDNorm_orig, velDNorm_mod, rotAngleDNorm_orig, rotAngleDNorm_mod);

plotParam('outParam.csv');