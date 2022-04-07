function [vec_down, vec_up, rot_down, rot_up] = CartisianVelLeadLagRead(path)

    % 选择读取一组数据轨迹，然后进行绘制
    
%     const pathIndex& pIndex = pIVector[i];
%     oFileM << pIndex.maxVelErrOut << "," << pIndex.maxRotErrOut << ",";
%     oFileM << pIndex.vecPair.first << "," << pIndex.vecPair.second << ",";
%     oFileM  << pIndex.rotPair.first << "," << pIndex.rotPair.second << ",";
%     for (int j = 0; j < 6; j++)
%     {
%         oFileM << pIndex.maxJointAcc[j] << ",";
%     }
%     oFileM << std::endl;
    data = csvread(path);
    vec_down = data(:,3);
    vec_up =  data(:,4);
    
    rot_down = data(:,5);
    rot_up =  data(:,6);
    
end

