function T=poseToMatrix(x)
% X-Y-Z Euler anglesģʽ

% % ��λ��תΪĩ�˵���α任���� 
    gama=x(4);  beta=x(5);  alpha=x(6);
%     gama=x(6);  beta=x(5);  alpha=x(4);
    R=[cos(alpha)*cos(beta) cos(alpha)*sin(beta)*sin(gama)-sin(alpha)*cos(gama) cos(alpha)*sin(beta)*cos(gama)+sin(alpha)*sin(gama);
        sin(alpha)*cos(beta) sin(alpha)*sin(beta)*sin(gama)+cos(alpha)*cos(gama) sin(alpha)*sin(beta)*cos(gama)-cos(alpha)*sin(gama);
        -sin(beta) cos(beta)*sin(gama) cos(beta)*cos(gama)];
    
    T=[R x(1:3)';    0 0 0 1];

 end