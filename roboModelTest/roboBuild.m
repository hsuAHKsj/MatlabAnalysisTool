function roboBuild
qs = [0.647351,0.398775,-1.51109,1.80517,1.48919,1.41065];

% 定义机器人DH参数
m_d1 = 0.208;
m_d4 = 0.495;
m_d6 = 0.1605;
m_a2 = 0.455;

L1=Link([0       m_d1     0         pi/2       0     0],   'standard');
L2=Link([0       0        m_a2      pi         0     pi/2],'standard');
L3=Link([0       0        0         pi/2       0     pi/2],'standard');
L4=Link([0       m_d4     0         -pi/2      0     0],   'standard');
L5=Link([0       0        0         pi/2       0     0],   'standard');
L6=Link([0       m_d6     0         0          0     0],   'standard');

mod=SerialLink([L1 L2 L3 L4 L5 L6],'name','Elfin5'); 
Ts_out = fkine(mod, qs)

mod.ikineType = 'puma'
q_iter = mod.ikine(Ts_out, 'q0', qs)

q_an = mod.ikine6s(Ts_out, 'q0', qs)

mod.plot(qs,'workspace',[-1 1 -1 1 -0.2 1.8],'tilesize',2)%机械臂图
end