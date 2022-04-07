function [qAcc1, qAcc2, qAcc3, qAcc4, qAcc5, qAcc6] = JointAccelerationRead(path)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    data=csvread(path);
    qAcc1 =  data(:,7);
    qAcc2 =  data(:,8);
    qAcc3 =  data(:,9);
    qAcc4 =  data(:,10);
    qAcc5 =  data(:,11);
    qAcc6 =  data(:,12);
end

