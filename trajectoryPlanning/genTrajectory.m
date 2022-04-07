%% Generate and follow trajectory
% Loop through segments one at a time
trajType = 'trap';
numWaypoints = size(waypoints,2);
for w = 1:numWaypoints-1
    % Get the initial and final rotations and times for the segment
    R0 = eul2quat(orientations(:,w)');
    Rf = eul2quat(orientations(:,w+1)');
    timeInterval = waypointTimes(w:w+1);
    trajTimes = timeInterval(1):ts:timeInterval(2);

    % Cartesian Motion only
    switch trajType
        case 'trap'
            [q,qd,qdd] = trapveltraj(waypoints(:,w:w+1),numel(trajTimes), ...
                'AccelTime',waypointAccelTimes(w), ... 
                'EndTime',diff(waypointTimes(w:w+1)));

        case 'cubic'
            [q,qd,qdd] = cubicpolytraj(waypoints(:,w:w+1),waypointTimes(w:w+1),trajTimes, ... 
                'VelocityBoundaryCondition',waypointVels(:,w:w+1));

        case 'quintic'
            [q,qd,qdd] = quinticpolytraj(waypoints(:,w:w+1),waypointTimes(w:w+1),trajTimes, ... 
                'VelocityBoundaryCondition',waypointVels(:,w:w+1), ...
                'AccelerationBoundaryCondition',waypointAccels(:,w:w+1));

        case 'bspline'
            ctrlpoints = waypoints(:,idx:idx+1); % Can adapt this as needed
            [q,qd,qdd] = bsplinepolytraj(ctrlpoints,timeInterval,trajTimes);

        otherwise
            error('Invalid trajectory type! Use ''trap'', ''cubic'', ''quintic'', or ''bspline''');
    end
        
    % Find the quaternions from trajectory generation
    [R, omega, alpha] = rottraj(R0, Rf, timeInterval, trajTimes);    
    
    % Plot trajectory
    if plotMode == 1
        set(hTraj,'xdata',q(1,:),'ydata',q(2,:),'zdata',q(3,:));
    elseif plotMode == 2
        plotTransforms(q',R','FrameSize',0.05)
    end
    
    % Trajectory following loop
    for idx = 1:numel(trajTimes) 
        % Solve IK
        tgtPose = trvec2tform(q(:,idx)') * quat2tform(R(:,idx)');
    end
    
    
end