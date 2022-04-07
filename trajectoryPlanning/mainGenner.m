function mainGenner(num) 
    
    step = 100;
    maxJointVel = 180;
    for i = 1:num
        genSingularityTrajectoryV2(step, maxJointVel, num2str(i)); 
    end
   
end


