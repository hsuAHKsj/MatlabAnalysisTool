function plotCartisianVel(velNorm_orig, velNorm_mod, rotAngleNorm_orig, rotAngleNorm_mod)
    
    velNorm_mod(1) = velNorm_mod(2);
    rotAngleNorm_mod(1) = rotAngleNorm_mod(2);
    
    figure;
    yyaxis left;
    hold on;
    plot(velNorm_orig,'LineWidth',1.0);
    plot(velNorm_mod,'LineWidth',1.0);
    ylabel('Velocity of Translation(mm/s)');
    
    yyaxis right;
    hold on
    plot(rotAngleNorm_orig,'LineWidth',1.0);
    plot(rotAngleNorm_mod,'LineWidth',1.0);
    ylabel('Angle Velocity in Rotation(rad/s)');
    
    legend('velOrigin', 'velModified', 'avelOrigin', 'avelModified');
    title('(Velocity) The Velocity & Angle Velocity in C space');
    grid on
end

