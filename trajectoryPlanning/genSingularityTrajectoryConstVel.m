function genSingularityTrajectoryConstVel(velDes, maxVel, maxAngVel, index) 
    
    close all;
    fileOutputPath = 'C:\Users\Huang Yanwei\source\repos\DLS_project\inputFiles\';
    
    max_try_attampt = 100;
    
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
    
    maxJointVel = 180;
    jstep = 100;
    
    for i = 1: max_try_attampt
        
        q1 = [0.647351, 0.398775, -1.51109, 1.80517, 0.3 ,1.41065];

        maxJointVel = maxJointVel/180*pi;
        range = pi/16;

        % 生成关节角度的方法变化
        q123 = rand(1,3)*pi/16 - pi/32;
        q456 = rand(1,3)*range - range/2;
        q2 = [q123, q456] + q1;
        q2(5) = -1*sign(q1(5))*sign(q2(5))*q2(5);

        % 给定初角度，给定末角度，在关节5附近进行插值
    %     q2 = rand(1,6)*pi/4 + - pi/8;

        Tr_start = elfinKin.forKinematic(q1);
        Tr_end = elfinKin.forKinematic(q2);

        % 判断起始和末位置
        DeltaT = Tr_end.t - Tr_start.t;
        [DeltaAngle, w] = trlog(Tr_start.R'*Tr_end.R);

        % 判断轨迹的执行步数(不一定是整数)
        step = norm(DeltaT)/velDes;

        % 判断是否可以进行插值
        if(DeltaAngle < step*maxAngVel) 
            disp('found and break')
            break; 
        end
        
        if i == max_try_attampt
            disp('Fail!')
        end
    end
    
    % 对轨迹进行插值
    t_increament = (Tr_end.t - Tr_start.t)/norm(Tr_end.t - Tr_start.t)*velDes;
    Delta_increament = DeltaAngle/step;
    
%     carPath = [Tr_start];
    carPath = [];
    Gindex = floor(step);
    % 生成最终数据
    for i = 0:Gindex-1
        R_increament = SO3.angvec(Delta_increament*i, w);
        % R_increament = SO3.angvec(0, w);
        pose = SE3(Tr_start.R * R_increament.R, Tr_start.t + t_increament*i);
        carPath = [carPath, pose];
    end
    
    carPath = [carPath];
    
    % 对轨迹进行插值
    figure;
    for i = 1:5:length(carPath)
       Tr = [[carPath(i).R, carPath(i).t];[0,0,0,1]];
       plotframe(Tr,0.1);
    end
    axis equal % 绛夎酱缁樺埗
    grid on % 鐢诲浘
    rotate3d on % 鍏佽3D鏃嬭浆
    
    
    trajectoryWrite(carPath, [fileOutputPath, 'constVelocityPath', index,'.csv']);
    % 写参考关节角度
    jointTrajectoryWrite(q1, [fileOutputPath, 'constVelRefJointAngle', index,'.csv']);
    
end


