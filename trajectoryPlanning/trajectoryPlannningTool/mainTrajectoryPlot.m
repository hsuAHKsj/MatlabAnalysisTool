%% Common parameters
toolPositionHome = [0 0 0];
% Maximum number of waypoints (for Simulink)
maxWaypoints = 20;

% Positions (X Y Z)
waypoints = toolPositionHome' + ... 
            [0 0 0.2 ; -0.1 0.2 0.4 ; -0.2 0 0.1 ; -0.1 -0.2 0.4 ; 0 0 0.2]';
         
% Euler Angles (Z Y X) relative to the home orientation    各个姿态   
orientations = [0     0    0;
                pi/8  0    0; 
                0    pi/2  0;
               -pi/8  0    0;
                0     0    0]';   
            
% Array of waypoint times
waypointTimes = 0:4:16;

% Trajectory sample time
ts = 0.2;
trajTimes = 0:ts:waypointTimes(end);

%% Additional parameters

% Boundary conditions (for polynomial trajectories)
% Velocity (cubic and quintic)
waypointVels = 0.1 *[ 0  1  0;
                     -1  0  0;
                      0 -1  0;
                      1  0  0;
                      0  1  0]';

% Acceleration (quintic only)
waypointAccels = zeros(size(waypointVels));

% Acceleration times (trapezoidal only)
waypointAccelTimes = diff(waypointTimes)/4;
