

close all;
indexPath = 'outIndex.csv';
[maxTransErr, maxRotErr] = CartisianErrIndexRead(indexPath);

[vec_down, vec_up, rot_down, rot_up] = CartisianVelLeadLagRead(indexPath);

% 格式是 table 以及一个 vector, vector 表示的是数据摆放的位置

Table = [maxTransErr, maxRotErr];

figure;
notBoxPlot(Table, [1:2], 'markMedian',true)
title('笛卡尔空间误差箱型图（mm / deg）')
