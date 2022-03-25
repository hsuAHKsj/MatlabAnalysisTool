classdef jointPathGenner < handle
    % 生成关节空间轨迹
    
    properties
        % 关节极限
        upperbound;
        lowwerbound;
        
        upperbound456;
        lowerbound456;
    end
    
    methods
        function obj = jointPathGenner(upperbound, lowwerbound)
            
            % 我们必须保证 
            if(upperbound(5) <= 0 || lowwerbound(5) >= 0) 
                return
            end
            
            % 关节角度生成器
            obj.upperbound = upperbound;
            obj.lowwerbound = lowwerbound;
            
            obj.upperbound456 = upperbound(4:6);
            obj.lowerbound456 = lowwerbound(4:6);
            
        end
        
        function retPath = getJoint5PassWristSinglarityPath(obj, step)

            % 产生轨迹起点
            numRan_start = rand(1,3);
            numRan_end = rand(1,3);
            
            q5_start = obj.lowerbound456(2) + (obj.upperbound456(2) - obj.lowerbound456(2))*numRan_start(2);
            q5_end = 0;
            
            if(q5_start > 0) 
                q5_end = obj.lowerbound456(2)*numRan_end(2);
            else
                q5_end = obj.upperbound456(2)*numRan_end(2);
            end
            
            % 对关节4进行插值
            q4_start = obj.lowerbound456(1) + (obj.upperbound456(1) - obj.lowerbound456(1))*numRan_start(1);
            q4_end = obj.lowerbound456(1) + (obj.upperbound456(1) - obj.lowerbound456(1))*numRan_end(1);
            % 对关节6进行插值
            q6_start = obj.lowerbound456(3) + (obj.upperbound456(3) - obj.lowerbound456(3))*numRan_start(3);
            q6_end = obj.lowerbound456(3) + (obj.upperbound456(3) - obj.lowerbound456(3))*numRan_end(3);
            
            % 对轨迹进行插值
            XI =[1, step];
            Q4 =[q4_start, q4_end];
            Q5 =[q5_start, q5_end];
            Q6 =[q6_start, q6_end];
            
            % 对起始和终止位置进行插值
            xi=1:1:step;
            
            q4i=interp1(XI,Q4,xi);
            q5i=interp1(XI,Q5,xi);
            q6i=interp1(XI,Q6,xi);

            retPath = [q4i;q5i;q6i];
            retPath = retPath';
        end
        
        function retPath = pathRefine(obj, path)
            
            fp = path(1,:);
            fpSign = sign(fp(2));
            for i=2:length(path)
                vp = path(i,:);
                if(sign(vp(2))~= fpSign)
                    path(i,1) = path(i-1,1) + 1* (path(i,1)- path(i-1,1));
                    break;
                end
                
            end
            retPath = path;
        end
        
    end
end

