function genSingularityTrajectoryV2(step, maxJointVel, index) 
    
    fileOutputPath = 'C:\Users\Huang Yanwei\source\repos\DLS_project\inputFiles\';

    % 定义机器人连杆参数
    m_d1 = 0.208;
    m_d4 = 0.495;
    m_d6 = 0.1605;
    m_a2 = 0.455;
    
    % 使用的是关节角度作为初值，不好
    elfinKin = roboKin(m_d1,m_d4,m_d6,m_a2);
% 	e2t.p = { 0, -0.070, -0.132 };
% 	e2t.M = KDL::Rotation::RPY(KDL::PI / 4, 0, 0);
     
    Tr_EE2tool = SE3(SO3.rpy(pi/4*180/pi, 0, 0).R, [ 0, -0.070, -0.132]);

    elfinKin.setEE2Tool(Tr_EE2tool); 
    
    q1 = [0.647351,0.398775,-1.51109,1.80517, 0.1 ,1.41065];
    
    
    maxJointVel = maxJointVel/180*pi;
    range = 0.4*maxJointVel*step*0.004;
    
    % 生成关节角度的方法变化
    q123 = rand(1,3)*pi/16 - pi/32;
    q456 = rand(1,3)*range - range/2;
    q2 = [q123, q456] + q1;
    q2(5) = -1*sign(q1(5))*sign(q2(5))*q2(5);
    
    % 给定初角度，给定末角度，在关节5附近进行插值
%     q2 = rand(1,6)*pi/4 + - pi/8;
%     
%     
    Tr_start = elfinKin.forKinematic(q1);
    Tr_end = elfinKin.forKinematic(q2);
    
    % 对轨迹进行插值
    carPath = ctraj(Tr_start, Tr_end, step);
    
    trajectoryWrite(carPath, [fileOutputPath, 'singularityPath', index,'.csv']);
    % 写参考关节角度
    jointTrajectoryWrite(q1, [fileOutputPath, 'refJointAngle', index,'.csv']);
    
%     % 关节轨迹 
%     close all;
%     figure;
%     plot(q123_traj(:,1),'LineWidth',1.0);
%     hold on;
%     plot(q123_traj(:,2),'LineWidth',1.0);
%     plot(q123_traj(:,3),'LineWidth',1.0);
%     legend('j1', 'j2', 'j3');
%     title('Joint position (rad)');
%     grid on;
%     
%     
%     % 关节轨迹 
%     figure;
%     plot(q456_traj(:,1),'LineWidth',1.0);
%     hold on;
%     plot(q456_traj(:,2),'LineWidth',1.0);
%     plot(q456_traj(:,3),'LineWidth',1.0);
%     legend('j4', 'j5', 'j6');
%     title('Joint position (rad)');
%     grid on;

end


