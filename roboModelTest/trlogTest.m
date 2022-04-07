Tr1 = SE3(SO3.rpy(pi/4*180/pi, 0, 0).R, [ 0, -0.070, -0.132]);

DelteaT = SE3(SO3.rpy(pi/4*180/pi, 0, 0).R, [ 0, 0, 0]);

Tr2 = Tr1*DelteaT;

[theta, w] = trlog(Tr2.R'*Tr1.R);

% 理论值应该是 pi/4
if(abs(theta - pi/4) < 0.000001)
   disp('trlog True'); 
else
   disp('err happen');
end