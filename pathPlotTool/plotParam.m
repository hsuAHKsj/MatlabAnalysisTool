function plotParam(path)
    data=csvread(path);

    % 读取第1，2，3列，
    state =data(:,4);
    damp = data(:,1);
    w = data(:,2);
    energy = data(:,3);
    sigma = data(:,5);

    % 画图
    figure;
    subplot(3,2,1)
    hold on
    plot(state,'LineWidth',1.0);
    legend('state');
    title('机器人奇异区域状态（state = 0,1,2）');
    grid on
    
    subplot(3,2,2)
    hold on
    plot(damp,'LineWidth',1.0);
    legend('damp');
    title('机器人阻尼系数');
    grid on
    
    % 
    subplot(3,2,3)
    hold on
    plot(w,'LineWidth',1.0);
    legend('w');
    title('机器人自定义精度参数');
    grid on
    
    subplot(3,2,4)
    hold on
    plot(energy,'LineWidth',1.0);
    legend('err energy');
    title('误差的能量上限');
    grid on
    
    subplot(3,2,5)
    hold on
    plot(sigma,'LineWidth',1.0);
    legend('sigma');
    title('sigma的值');
    grid on
end
