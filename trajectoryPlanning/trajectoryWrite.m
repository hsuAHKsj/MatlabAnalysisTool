function trajectoryWrite(traj, fileName)
    % X-Y-Z Euler angles模式
    % 
    out_vec_v = [];
    for i = 1:length(traj)
        se3 = traj(i);
        eul = se3.torpy('zyx');
        trans = se3.t;
        out_vec = [trans'*1000, eul/pi*180];
        out_vec_v = [out_vec_v; out_vec];
    end

     % 写 csv 的路径
    csvwrite(fileName, out_vec_v);
end

