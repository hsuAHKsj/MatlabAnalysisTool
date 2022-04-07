

function GenVariousTrajectories()
    ts = 0.004;
    max_rot =0.5;
    genSingularityTrajectoryConstVel(0.01*ts, 1, max_rot*ts, '1');
    genSingularityTrajectoryConstVel(0.05*ts, 1, max_rot*ts, '2');
    genSingularityTrajectoryConstVel(0.1*ts, 1, max_rot*ts, '3');
    genSingularityTrajectoryConstVel(0.5*ts, 1, max_rot*ts, '4');
    genSingularityTrajectoryConstVel(1*ts, 1, max_rot*ts, '5');
end