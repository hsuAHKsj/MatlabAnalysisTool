classdef cartisenPathGenner < handle
    % 笛卡尔轨迹生成器
    
    properties
        % 圆心参考系的位置
        pose;
        
        % 大小 长宽高
        length;
        height;
        width;

    end
    
    methods
        function obj = cartisenPathGenner()
            
        end
        
        function setSamplingBox(obj, length, height, width, pose)
            obj.length = length;
            obj.height = height;
            obj.width = width;
            obj.pose = pose;
        end
        
        function retPath = genRandomTranslationPath(obj, step)
            % 在盒子中产生两个随机位置，然后进行插值
            pos_start = obj.genRandomPosition();
            pos_end = obj.genRandomPosition();
            
            pos_start = obj.pose* pos_start';
            pos_end = obj.pose* pos_end';
            
            % 进行等距插值
            err_pos = pos_end - pos_start;
            
            % 单位增量
            increament = err_pos/(step-1);
            
            retPath = [];
            
            for i = 0:step-1
                pose_out = pos_start + increament*i;
                retPath = [retPath; pose_out'];
            end
            
            return
        end
        
        function pos = genRandomPosition(obj)
            % 在盒子中产生随机位置,在长度范围中
            numRan = rand(1,3);
            pos(1)= -obj.length/2 + obj.length*numRan(1);
            pos(2)= -obj.height/2 + obj.height*numRan(2);
            pos(3)= -obj.width/2 + obj.width*numRan(3);
        end
    end
    
end