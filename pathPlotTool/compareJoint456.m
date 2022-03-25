% 读取关节角度，进行绘�?
function compareJoint456(path1, path2)
    data1=csvread(path1);
    data1(:,4:6) = data1(:,4:6)*pi/180;
    
    data2=csvread(path2);
    data2(:,4:6) = data2(:,4:6)*pi/180;
    
    j456 = data1(:,4:6);
    jd456 = diff(j456)/0.004;
    jdd456 = diff(jd456)/0.004;
    
    j456_2 = data2(:,4:6) ;
    jd456_2 = diff(j456_2)/0.004;
    jdd456_2 = diff(jd456_2)/0.004;
    
    figure;
    subplot(1,2,1);
    rotate3d off 
    plot(j456(:,1),'LineWidth',1.0);
    hold on;
    plot(j456(:,2),'LineWidth',1.0);
    plot(j456(:,3),'LineWidth',1.0);
    legend('j4', 'j5', 'j6');
    title('Joint position (rad)');
    grid on;
    
    subplot(1,2,2);
    rotate3d off 
    plot(j456_2(:,1),'LineWidth',1.0);
    hold on;
    plot(j456_2(:,2),'LineWidth',1.0);
    plot(j456_2(:,3),'LineWidth',1.0);
    legend('j4', 'j5', 'j6');
    title('Joint position (rad)');
    grid on;
    
    figure;
    subplot(1,2,1);
    hold on;
    plot(jd456(:,1),'LineWidth',1.0);
    plot(jd456(:,2),'LineWidth',1.0);
    plot(jd456(:,3),'LineWidth',1.0);
    legend('j4', 'j5', 'j6');
    title('The 1st order drevitive of joint state (rad/s)');
    grid on
    
    subplot(1,2,2);
    rotate3d off 
    plot(jd456_2(:,1),'LineWidth',1.0);
    hold on;
    plot(jd456_2(:,2),'LineWidth',1.0);
    plot(jd456_2(:,3),'LineWidth',1.0);
    legend('j4', 'j5', 'j6');
    title('The 1st order drevitive of joint state (rad/s)');
    grid on;
    
    
    figure;
    subplot(1,2,1);
    hold on
    plot(jdd456(:,1),'LineWidth',1.0);
    plot(jdd456(:,2),'LineWidth',1.0);
    plot(jdd456(:,3),'LineWidth',1.0);
    legend('j4', 'j5', 'j6');
    title('The 2st order drevitive of joint state (rad/s^2)');
    grid on;
    subplot(1,2,2);
    rotate3d off 
    plot(jdd456_2(:,1),'LineWidth',1.0);
    hold on;
    plot(jdd456_2(:,2),'LineWidth',1.0);
    plot(jdd456_2(:,3),'LineWidth',1.0);
    legend('j4', 'j5', 'j6');
    title('The 2st order drevitive of joint state (rad/s^2)');
    grid on;
    
end