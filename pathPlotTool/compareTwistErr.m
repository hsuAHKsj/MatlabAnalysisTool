% 读取关节角度，进行绘�?
function compareTwistErr(path1, path2, path_origin)
    
    [vel_orig, angle_orig] = plotCartisenVel(path_origin);
    [vel_mod, angle_mod] =plotCartisenVel(path1);
    [vel_mod2, angle_mod2] = plotCartisenVel(path2);
    
    % ��ͼ
    figure;
    subplot(1,2,1)
    hold on
    plot(vel_orig, 'LineWidth',1.0);
    plot(vel_mod, '--','LineWidth',1.0);
    plot(vel_mod2, '--','LineWidth',1.0);

    legend('ԭ�ٶ�����','����1�ٶ�����','����2�ٶ�����');
    title('�ѿ����ռ����ٶȸ�������ͼ');
    grid on
    
   
    subplot(1,2,2)
    hold on
    plot(angle_orig,'LineWidth',1.0);
    plot(angle_mod, '--','LineWidth',1.0);
    plot(angle_mod2, '--','LineWidth',1.0);
    
    legend('ԭ���ٶ�����','����1���ٶ�����','����2���ٶ�����');
    title('�ѿ����ռ���ٶȸ�������ͼ');
    grid on
end