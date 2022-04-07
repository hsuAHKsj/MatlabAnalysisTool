function [maxTransErr, maxRotErr] = CartisianErrIndexRead(path)

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
    
    data=csvread(path);
    maxTransErr = data(:,1);
    maxRotErr = data(:,2);
        
end

