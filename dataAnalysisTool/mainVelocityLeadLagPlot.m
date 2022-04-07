

close all;
indexPath = 'outIndex.csv';
[qAcc1, qAcc2, qAcc3, qAcc4, qAcc5, qAcc6] = JointAccelerationRead(path)

% 格式是 table 以及一个 vector, vector 表示的是数据摆放的位置

Table = [qAcc1, qAcc2, qAcc3, qAcc4, qAcc5, qAcc6] ;

figure;
notBoxPlot(Table, [1:6], 'markMedian',true)
title('关节角加速度箱型图（%）')
