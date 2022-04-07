function plotCartisianAcc(velDNorm_orig, velDNorm_mod, rotAngleDNorm_orig, rotAngleDNorm_mod)
    
    velDNorm_mod(1) = velDNorm_mod(2);
    rotAngleDNorm_mod(1) = rotAngleDNorm_mod(2);
    
    figure;
    yyaxis left;
    hold on;
    plot(velDNorm_orig,'LineWidth',1.0);
    plot(velDNorm_mod,'LineWidth',1.0);
    ylabel('Acceleration of Translation(mm/s^2)');
    
    yyaxis right;
    hold on
    plot(rotAngleDNorm_orig,'LineWidth',1.0);
    plot(rotAngleDNorm_mod,'LineWidth',1.0);
    ylabel('Angle Acceleration in Rotation(rad/s^2)');
    
    legend('accOrigin', 'accModified', 'aaccOrigin', 'aaccModified');
    title('(Acceleration) The Acceleration & Angle Acceleration in C space');
    grid on
end

