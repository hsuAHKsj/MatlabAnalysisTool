function plotParam(path)
    data=csvread(path);

    % ��ȡ��1��2��3�У�
    state =data(:,4);
    damp = data(:,1);
    w = data(:,2);
    energy = data(:,3);

    % ��ͼ
    figure;
    subplot(2,2,1)
    hold on
    plot(state,'LineWidth',1.0);
    legend('state');
    title('��������������״̬��state = 0,1,2��');
    grid on
    
    subplot(2,2,2)
    hold on
    plot(damp,'LineWidth',1.0);
    legend('damp');
    title('����������ϵ��');
    grid on
    
    % 
    subplot(2,2,3)
    hold on
    plot(w,'LineWidth',1.0);
    legend('w');
    title('�������Զ��徫�Ȳ���');
    grid on
    
    subplot(2,2,4)
    hold on
    plot(energy,'LineWidth',1.0);
    legend('err energy');
    title('������������');
    grid on
end
