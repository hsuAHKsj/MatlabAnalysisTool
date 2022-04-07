
close all;
indexPath = 'outIndex.csv';
[maxTransErr, maxRotErr] = CartisianErrIndexRead(indexPath);

% 格式是 table 以及一个 vector, vector 表示的是数据摆放的位置

figure;
notBoxPlot(maxTransErr','markMedian',true)
title('笛卡尔位置误差箱型图（mm）')

