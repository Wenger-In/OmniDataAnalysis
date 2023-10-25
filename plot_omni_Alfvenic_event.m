clear; close all;
file = 'E:\Research\Data\OMNI\omni_hros_1min_20100101000000_20101231000000.cdf';
info = spdfcdfinfo(file);
epoch = spdfcdfread(file,'variables','Epoch');
Bx = spdfcdfread(file,'variables','BX_GSE');
By = spdfcdfread(file,'variables','BY_GSE');
Bz = spdfcdfread(file,'variables','BZ_GSE');
Bmod = spdfcdfread(file,'variables','F');
Vx = spdfcdfread(file,'variables','Vx');
Vy = spdfcdfread(file,'variables','Vy');
Vz = spdfcdfread(file,'variables','Vz');
Vmod = spdfcdfread(file,'variables','flow_speed');
Np = spdfcdfread(file,'variables','proton_density');

Bx(abs(Bx)>1e2) = nan;
By(abs(By)>1e2) = nan;
Bz(abs(Bz)>1e2) = nan;
Vx(abs(Vx)>2e4) = nan;
Vy(abs(Vy)>2e4) = nan;
Vz(abs(Vz)>2e4) = nan;
Bmod(abs(Bmod)>3e2) = nan;
Np(Np>500) = nan;

Bx = fillmissing(Bx,"linear");
By = fillmissing(By,"linear");
Bz = fillmissing(Bz,"linear");
Vx = fillmissing(Vx,"linear");
Vy = fillmissing(Vy,"linear");
Vz = fillmissing(Vz,"linear");
Bmod = fillmissing(Bmod,'linear');
Np = fillmissing(Np,'linear');

% epoch_beg = epoch(1);
% epoch_end = epoch(end);
epoch_beg_lst = [7.3414434,7.3414336,7.3414282,7.3419194,7.3415618]*1e5;
epoch_end_lst = [7.3414452,7.3414346,7.34143,  7.3419204,7.3415628]*1e5;

for i_case = 1 : 5
    epoch_beg = epoch_beg_lst(i_case);
    epoch_end = epoch_end_lst(i_case);

    interval = floor((epoch_beg-epoch(1))/(epoch(2)-epoch(1)))+1 : ceil((epoch_end-epoch(1))/(epoch(2)-epoch(1)));
    epoch_inter = epoch(interval);
    Bx_inter = Bx(interval);
    By_inter = By(interval);
    Bz_inter = Bz(interval);
    Vx_inter = Vx(interval);
    Vy_inter = Vy(interval);
    Vz_inter = Vz(interval);
    Bmod_inter = Bmod(interval);
    Np_inter = Np(interval);

    %% figure1
    fontsize = 15;
    linewidth = 1;

    figure()
    subplot(4,1,1)
    % ax1 = nexttile;
    yyaxis left
    plot(epoch_inter,Bx_inter,'LineWidth',linewidth)
    ylabel('Bx [nT]')
    yyaxis right
    plot(epoch_inter,Vx_inter,'LineWidth',linewidth)
    ylabel('Vx [km/s]')
    datetick('x','keeplimits')
    set(gca,'FontSize',fontsize,'LineWidth',linewidth,'XMinorTick','on')

    subplot(4,1,2)
    % ax2 = nexttile;
    yyaxis left
    plot(epoch_inter,By_inter,'LineWidth',linewidth)
    ylabel('By [nT]')
    yyaxis right
    plot(epoch_inter,Vy_inter,'LineWidth',linewidth)
    ylabel('Vy [km/s]')
    datetick('x','keeplimits')
    set(gca,'FontSize',fontsize,'LineWidth',linewidth,'XMinorTick','on')

    subplot(4,1,3)
    % ax3 = nexttile;
    yyaxis left
    plot(epoch_inter,Bz_inter,'LineWidth',linewidth)
    ylabel('Bz [nT]')
    yyaxis right
    plot(epoch_inter,Vz_inter,'LineWidth',linewidth)
    ylabel('Vz [km/s]')
    datetick('x','keeplimits')
    set(gca,'FontSize',fontsize,'LineWidth',linewidth,'XMinorTick','on')

    subplot(4,1,4)
    % ax4= nexttile;
    yyaxis left
    plot(epoch_inter,Bmod_inter,'LineWidth',linewidth)
    ylabel('|B| [nT]')
    yyaxis right
    plot(epoch_inter,Np_inter,'LineWidth',linewidth)
    ylabel('Np [n/cc]')
    datetick('x','keeplimits')
    set(gca,'FontSize',fontsize,'LineWidth',linewidth,'XMinorTick','on')

    sgtitle([datestr(epoch_inter(1)),'-',datestr(epoch_inter(end))],'fontsize',fontsize)
    % linkaxes([ax1 ax2 ax3 ax4],'x')
    %% figure2
    figure()
    subplot(2,2,1)
    scatter(Bx_inter,Vx_inter,50,epoch_inter,'filled')
    xlabel('Bx [nT]')
    ylabel('Vx [km/s]')
    set(gca,'FontSize',fontsize,'LineWidth',linewidth)

    subplot(2,2,2)
    scatter(By_inter,Vy_inter,50,epoch_inter,'filled')
    xlabel('By [nT]')
    ylabel('Vy [km/s]')
    set(gca,'FontSize',fontsize,'LineWidth',linewidth)

    subplot(2,2,3)
    scatter(Bz_inter,Vz_inter,50,epoch_inter,'filled')
    xlabel('Bz [nT]')
    ylabel('Vz [km/s]')
    set(gca,'FontSize',fontsize,'LineWidth',linewidth)

    subplot(2,2,4)
    scatter(Bmod_inter,Np_inter,50,epoch_inter,'filled')
    xlabel('|B| [nT]')
    ylabel('Np [n/cc]')
    set(gca,'FontSize',fontsize,'LineWidth',linewidth)

    sgtitle([datestr(epoch_inter(1)),'-',datestr(epoch_inter(end))],'fontsize',fontsize)
end