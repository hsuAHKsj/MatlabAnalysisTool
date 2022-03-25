function genSingulairtyTrajectory(step)
    
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
    
    q = [0.647351,0.398775,-1.51109,1.80517,1.48919,1.41065];
    
    Tr_wp = elfinKin.getWristPointFrame(q);
    
    [ret, q123] = elfinKin.mk2Solve4Theta23(Tr_wp.t, [0.63,0.39,-1.52]);
    
    % 给定空间中的范围 比如10cm 生成随机轨迹
    lengtH = 0.1;
    height = 0.3;
    width = 0.1; 
    T0box = SE3(eye(4));
    T0box.t = Tr_wp.t;
    % 姿态确定为
    T0box_a_proj = [T0box.t(1), T0box.t(2), 0];
    T0box_n = T0box_a_proj/norm(T0box_a_proj);
    T0box_a = [0,0,1];
    T0box_o = cross(T0box_a, T0box_n);
    T0box.oa(T0box_o, T0box_a);
    
    % 定义步数为100
    
    carPathGenner = cartisenPathGenner();
    carPathGenner.setSamplingBox(lengtH, height, width, T0box);
    
    retPath = carPathGenner.genRandomTranslationPath(step);
    
    % 求解前3个关节的轨迹
    q123 = q(1:3);
    q123_traj = [];

    for (i=1:length(retPath))
        wp_vector = retPath(i,:);
        [ret, q123_out] = elfinKin.mk2Solve4Theta23(wp_vector', q123);
        q123_traj = [q123_traj; q123_out];
    end
    
    % 后三个关节
    upperbound = pi*ones(6);
    lowwerbound = -pi*ones(6);
    joPathGenner = jointPathGenner(upperbound, lowwerbound);

    q456_traj = joPathGenner.getJoint5PassWristSinglarityPath(step);
    
    % 轨迹修正
    q456_traj = joPathGenner.pathRefine(q456_traj);
    
    % 轨迹拼接
    q123456_traj = [q123_traj, q456_traj];
    
    carPath = elfinKin.forKinematic(q123456_traj);
    trajectoryWrite(carPath, [fileOutputPath, 'singularityPath1.csv']);
    % 写参考关节角度
    jointTrajectoryWrite(q123456_traj(1,:), [fileOutputPath, 'refJointAngle1.csv']);
    
    % 关节轨迹 
    close all;
    figure;
    plot(q123_traj(:,1),'LineWidth',1.0);
    hold on;
    plot(q123_traj(:,2),'LineWidth',1.0);
    plot(q123_traj(:,3),'LineWidth',1.0);
    legend('j1', 'j2', 'j3');
    title('Joint position (rad)');
    grid on;
    
    
    % 关节轨迹 
    figure;
    plot(q456_traj(:,1),'LineWidth',1.0);
    hold on;
    plot(q456_traj(:,2),'LineWidth',1.0);
    plot(q456_traj(:,3),'LineWidth',1.0);
    legend('j4', 'j5', 'j6');
    title('Joint position (rad)');
    grid on;

end


