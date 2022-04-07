close all;
% 读取文本文件
data=csvread('singularityPath2.csv');
data(:,4:6) = data(:,4:6)*pi/180;

% 读取�?1�?2�?3列，
x = data(:,1);
y = data(:,2);
z = data(:,3);

data2=csvread('CartisienTrajOutput.csv');
data2(:,4:6) = data2(:,4:6)*pi/180;

% 读取�?1�?2�?3列，
x2 = data2(:,1);
y2 = data2(:,2);
z2 = data2(:,3);

figure(2)
hold on
plot3(x,y,z,'LineWidth',1.0);
plot3(x2,y2,z2,'LineWidth',1.0);
legend('����ǰ�켣','������켣');
title('����������ǰ��ԭ��켣�Ƚ�');
grid on
axis equal
rotate3d on

figure;
for i = 1:1:size(data2,1)
   T = poseToMatrix(data2(i,:));
   plotframe(T,15);
end
axis equal % 等轴绘制
grid on % 画图
rotate3d on % 允许3D旋转

% % ԭģ��ikֵ
% plotJoint456Traj('OriginIK.csv');
% % ������ikֵ
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
legend('����ǰ�켣','������켣');
title('�ѿ����ռ����ٶȸ�������ͼ');
grid on

figure;
hold on
plot(angle_orig,'LineWidth',1.0);
plot(angle_mod,'LineWidth',1.0);
legend('����ǰ�켣','������켣');
title('�ѿ����ռ���ٶȸ�������ͼ');
grid on

% 
figure;
hold on
plot(Acc_vel_orig,'LineWidth',1.0);
plot(Acc_vel_mod,'LineWidth',1.0);
legend('����ǰ�켣','������켣');
title('�ѿ����ռ��߼��ٶȸ�������ͼ');
grid on

% 
figure;
hold on
plot(Acc_rot_orig,'LineWidth',1.0);
plot(Acc_rot_mod,'LineWidth',1.0);
legend('����ǰ�켣','������켣');
title('�ѿ����ռ�Ǽ��ٶȸ�������ͼ');
grid on

plotParam('Param.csv');
% compareJoint456('jointOutput1.csv','jointOutput.csv');
% compareTwistErr( 'CartisienTrajOutput1.csv', 'CartisienTrajOutput.csv', 'scanDataModify.csv')