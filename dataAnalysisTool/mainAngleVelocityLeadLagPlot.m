

close all;
indexPath = 'outIndex.csv';
[vec_down, vec_up, rot_down, rot_up] = CartisianVelLeadLagRead(indexPath);

% 格式是 table 以及一个 vector, vector 表示的是数据摆放的位置

Table = [rot_down, rot_up];

figure;
notBoxPlot(Table, [1:2], 'markMedian',true)
title('笛卡尔空间角速度（1,2）超前滞后 箱型图（%）')
