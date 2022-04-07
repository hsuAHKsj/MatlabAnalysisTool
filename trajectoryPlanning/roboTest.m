   
close all;
% 定义机器人连杆参数
m_d1 = 0.208;
m_d4 = 0.495;
m_d6 = 0.1605;
m_a2 = 0.455;
    
elfinKin = roboKin(m_d1,m_d4,m_d6,m_a2);
% 	e2t.p = { 0, -0.070, -0.132 };
% 	e2t.M = KDL::Rotation::RPY(KDL::PI / 4, 0, 0);

Tr_EE2tool = SE3(SO3.rpy(pi/4*180/pi, 0, 0).R, [ 0, -0.070, -0.132]);

elfinKin.setEE2Tool(Tr_EE2tool); 

refJoint = [0.647351,0.398775,-1.51109,1.80517,1.48919,1.41065];

se3 = elfinKin.forKinematic(refJoint);

eul = se3.torpy('zyx');
trans = se3.t;
out_vec = [trans'*1000, eul/pi*180]

% 写参考关节角度
jointTrajectoryWrite(refJoint, 'refJointAngle1.csv');