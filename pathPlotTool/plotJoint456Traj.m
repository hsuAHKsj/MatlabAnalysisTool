% 读取关节角度，进行绘�?
function plotJoint456Traj(path)
    data=csvread(path);
    data(:,4:6) = data(:,4:6);
    
    % 读取�?1�?2�?3列，
    j4 = data(:,4);
    j5 = data(:,5);
    j6 = data(:,6);
   
    figure;
    rotate3d off 
    plot(j4,'LineWidth',1.0);
    hold on;
    plot(j5,'LineWidth',1.0);
    plot(j6,'LineWidth',1.0);
    
    legend('j4', 'j5', 'j6');
    title('Joint State (rad)');
    grid on
    
%     % 绘制关节速度
    jd4 = diff(j4)/0.004;
    jd5 = diff(j5)/0.004;
    jd6 = diff(j6)/0.004;
%     
%     figure;
%     hold on
%     plot(jd4,'LineWidth',1.0);
%     plot(jd5,'LineWidth',1.0);
%     plot(jd6,'LineWidth',1.0);
%     
%     legend('j4', 'j5', 'j6');
%     title('The 1st order drevitive of joint state (rad/s)');
%     grid on
    
        % 绘制关节速度
    jdd4 = diff(jd4)/0.004;
    jdd5 = diff(jd5)/0.004;
    jdd6 = diff(jd6)/0.004;
    jdd4(1) = jdd4(2);
    jdd5(1) = jdd5(2);
    jdd6(1) = jdd6(2);
    
%     figure;
%     hold on
%     plot(jdd4,'LineWidth',1.0);
%     plot(jdd5,'LineWidth',1.0);
%     plot(jdd6,'LineWidth',1.0);
%     
%     legend('j4', 'j5', 'j6');
%     title('The 2st order drevitive of joint state (rad/s^2)');
%     grid on
    
    figure;
    yyaxis left;
    hold on;
    plot(jd4,'LineWidth',1.0);
    plot(jd5,'LineWidth',1.0);
    plot(jd6,'LineWidth',1.0);
    ylabel('The 1st Order Derivative(rad/s)');
    
    yyaxis right;
    hold on
    plot(jdd4,'LineWidth',1.0);
    plot(jdd5,'LineWidth',1.0);
    plot(jdd6,'LineWidth',1.0);
    ylabel('The 2rd Order Derivative(rad^2/s)');
    
    legend('j4', 'j5', 'j6', 'jd4', 'jd5', 'jd6');
    title('The 1st/2rd Order Derivative of Joint State');
    grid on
end