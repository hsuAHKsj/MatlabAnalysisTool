close all;
% 璇诲彇鏂囨湰鏂囦欢
data=csvread('singularityPath2.csv');
data(:,4:6) = data(:,4:6)*pi/180;

% 璇诲彇绗?1锛?2锛?3鍒楋紝
x = data(:,1);
y = data(:,2);
z = data(:,3);

data2=csvread('CartisienTrajOutput.csv');
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

% % 原模块ik值
% plotJoint456Traj('OriginIK.csv');
% % 修正后ik值
% plotJoint456Traj('jointOutput.csv');

plotJoint123456Traj('OriginIK.csv');

plotErr('Err.csv');
[vel_orig, angle_orig, Acc_vel_orig, Acc_rot_orig] = plotCartisenVel('singularityPath2.csv');
[vel_mod, angle_mod, Acc_vel_mod, Acc_rot_mod] =plotCartisenVel('CartisienTrajOutput.csv');
% 
figure;
hold on
plot(vel_orig,'LineWidth',1.0);
plot(vel_mod,'LineWidth',1.0);
legend('修正前轨迹','修正后轨迹');
title('笛卡尔空间线速度跟踪曲线图');
grid on

figure;
hold on
plot(angle_orig,'LineWidth',1.0);
plot(angle_mod,'LineWidth',1.0);
legend('修正前轨迹','修正后轨迹');
title('笛卡尔空间角速度跟踪曲线图');
grid on

% 
figure;
hold on
plot(Acc_vel_orig,'LineWidth',1.0);
plot(Acc_vel_mod,'LineWidth',1.0);
legend('修正前轨迹','修正后轨迹');
title('笛卡尔空间线加速度跟踪曲线图');
grid on

% 
figure;
hold on
plot(Acc_rot_orig,'LineWidth',1.0);
plot(Acc_rot_mod,'LineWidth',1.0);
legend('修正前轨迹','修正后轨迹');
title('笛卡尔空间角加速度跟踪曲线图');
grid on

plotParam('Param.csv');
% compareJoint456('jointOutput1.csv','jointOutput.csv');
% compareTwistErr( 'CartisienTrajOutput1.csv', 'CartisienTrajOutput.csv', 'scanDataModify.csv')