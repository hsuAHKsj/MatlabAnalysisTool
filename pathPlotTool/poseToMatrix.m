function T=poseToMatrix(x)
% X-Y-Z Euler angles模式

% % 将位姿转为末端的齐次变换矩阵 
    gama=x(4);  beta=x(5);  alpha=x(6);
%     gama=x(6);  beta=x(5);  alpha=x(4);
    R=[cos(alpha)*cos(beta) cos(alpha)*sin(beta)*sin(gama)-sin(alpha)*cos(gama) cos(alpha)*sin(beta)*cos(gama)+sin(alpha)*sin(gama);
        sin(alpha)*cos(beta) sin(alpha)*sin(beta)*sin(gama)+cos(alpha)*cos(gama) sin(alpha)*sin(beta)*cos(gama)-cos(alpha)*sin(gama);
        -sin(beta) cos(beta)*sin(gama) cos(beta)*cos(gama)];
    
    T=[R x(1:3)';    0 0 0 1];

 end