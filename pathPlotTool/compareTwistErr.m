% 璇诲彇鍏宠妭瑙掑害锛岃繘琛岀粯鍥?
function compareTwistErr(path1, path2, path_origin)
    
    [vel_orig, angle_orig] = plotCartisenVel(path_origin);
    [vel_mod, angle_mod] =plotCartisenVel(path1);
    [vel_mod2, angle_mod2] = plotCartisenVel(path2);
    
    % 画图
    figure;
    subplot(1,2,1)
    hold on
    plot(vel_orig, 'LineWidth',1.0);
    plot(vel_mod, '--','LineWidth',1.0);
    plot(vel_mod2, '--','LineWidth',1.0);

    legend('原速度曲线','参数1速度曲线','参数2速度曲线');
    title('笛卡尔空间线速度跟踪曲线图');
    grid on
    
   
    subplot(1,2,2)
    hold on
    plot(angle_orig,'LineWidth',1.0);
    plot(angle_mod, '--','LineWidth',1.0);
    plot(angle_mod2, '--','LineWidth',1.0);
    
    legend('原角速度曲线','参数1角速度曲线','参数2角速度曲线');
    title('笛卡尔空间角速度跟踪曲线图');
    grid on
end