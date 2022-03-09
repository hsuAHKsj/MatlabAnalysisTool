% 读取文本文件
data=csvread('scanDataModify.csv');
data(:,4:6) = data(:,4:6)*pi/180;

% 读取第1，2，3列，
x = data(:,1);
y = data(:,2);
z = data(:,3);

for i = 1:5:size(data,1)
   T = poseToMatrix(data(i,:));
   plotframe(T,15);
end
axis equal % 等轴绘制
grid on % 画图

rotate3d on % 允许3D旋转

figure(2)
hold on
plot3(x,y,z,'LineWidth',1.0);
grid on
axis equal
rotate3d on

