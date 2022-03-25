classdef roboKin < handle
    %ROBO_KIN 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        % 定义机器人DH参数
        m_d1;
        m_d4;
        m_d6;
        m_a2;
        
        rob;
        
        m_toolFrame;
    end
    
    methods
        function obj = roboKin(m_d1,m_d4,m_d6,m_a2)
            
            obj.m_d1 = m_d1;
            obj.m_d4 = m_d4;
            obj.m_d6 = m_d6;
            obj.m_a2 = m_a2;
            % 机器人连杆的构建
            L1=Link([0       m_d1     0         pi/2       0     0],   'standard');
            L2=Link([0       0        m_a2      pi         0     pi/2],'standard');
            L3=Link([0       0        0         pi/2       0     pi/2],'standard');
            L4=Link([0       m_d4     0         -pi/2      0     0],   'standard');
            L5=Link([0       0        0         pi/2       0     0],   'standard');
            L6=Link([0       m_d6     0         0          0     0],   'standard');
    
            obj.rob=SerialLink([L1 L2 L3 L4 L5 L6],'name','Elfin5'); 
            obj.rob.ikineType = 'puma';
            obj.m_toolFrame = SE3(eye(4));
        end
        
        function carPath = forKinematic(obj, jointTraj)
            % 正向运动学
            carPath = fkine(obj.rob, jointTraj);
            for i = 1:length(carPath)
                carPath(i) = carPath(i)* obj.m_toolFrame;
            end
        end
        
        function setEE2Tool(obj, Tr_EE2tool)
            % 设置工具坐标系
            obj.m_toolFrame = Tr_EE2tool;
        end
        
        function [ret,q123] = mk2Solve4Theta23(obj, wrist_p_vector, q_ref)
            % 根据 wrist_p_vector 求解q123，并选择和q_ref 最近的一个
            L2 = obj.m_a2;
            L3 = obj.m_d4;
            
            % 求解 q1 并进行比较
            q1_1 = atan2(wrist_p_vector(2), wrist_p_vector(1));
            q1_2 = q1_1+ pi;
            
            q1 = q1_1;
            % 比较哪个q1 更接近 q_ref(1)
            if(abs(q1_1-q_ref(1)) > abs(q1_2-q_ref(1))) 
                q1 = q1_2;
            end
            
            T01 = SE3([cos(q1), 0, sin(q1); sin(q1), 0, -cos(q1); 0, 1, 0], [0,0,obj.m_d1]);
%             T01.R = ;
%             T01.t = ;
            
            % 得到在关节1坐标中表示的腕关节矢量
            p1_vector = T01.inv()*wrist_p_vector;
            
            % 得到腕关节中心点到关节1原点的长度
            r = sqrt(p1_vector(1)*p1_vector(1) + p1_vector(2)*p1_vector(2));
            
            % 求解 beta角度
            beta = atan2(p1_vector(2), p1_vector(1));
            elem1 = (L2*L2 + r*r - L3*L3) / (2 * r*L2);
            elem2 = (L2*L2 + L3*L3 - r*r) / (2 * L2*L3);
            
            % 如果 发现求解异常，退出程序
            if (abs(elem1)>1 || abs(elem2)>1)
                ret = 1;
                q123 = [];
                return
            end
            
            % 求解 gama 角度，求解 q2 角度
            gama = acos(elem1);
            omega = acos(elem2);
            
            q2_1 = beta + gama - pi / 2;
            q2_2 = beta - gama - pi / 2;
            
            % 判断两个 q2 哪个更加接近 q_ref(2)
            q2 = q2_1;
            q3 = -omega + pi;
            if(abs(q2_1-q_ref(2)) > abs(q2_2-q_ref(2))) 
                q2 = q2_2;
                q3 = omega - pi;
            end
                
            q123 = [q1, q2, q3];
            ret = 0;
            return
        end
        
        function Tr_wp = getWristPointFrame(obj, q)
            % 求解腕关节中心点位置
            
            Tr_EE = fkine(obj.rob, q);
            j6z_vector = Tr_EE.a;
            t_wp = Tr_EE.t - obj.m_d6*j6z_vector;
            Tr_wp = SE3(Tr_EE.R, t_wp);
        end
    end
end

