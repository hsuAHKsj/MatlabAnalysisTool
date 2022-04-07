function jointTrajectoryWrite(qTraj, fileName)
    % X-Y-Z Euler angles模式
    %
     % 写 csv 的路径
%     csvwrite(fileName, qTraj);
    dlmwrite(fileName, qTraj, 'precision', 20);
end