% 读取关节角度，进行绘�?
function plotJoint123456Traj(path)
    data=csvread(path);
    
    figure;
    plot(data(:,1),'LineWidth',1.0);
    hold on;
    plot(data(:,2),'LineWidth',1.0);
    plot(data(:,3),'LineWidth',1.0);
    
    legend('j1', 'j2', 'j3');
    title('Joint position 123(rad)');
    grid on
    
    
    figure;
    plot(data(:,4),'LineWidth',1.0);
    hold on;
    plot(data(:,5),'LineWidth',1.0);
    plot(data(:,6),'LineWidth',1.0);
    
    legend('j4', 'j5', 'j6');
    title('Joint position 456 (rad)');
    grid on

end