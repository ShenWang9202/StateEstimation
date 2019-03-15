%% Plot pump curve
set(0,'defaultTextInterpreter','latex'); %trying to set the default
PumpEquation = [393.7008 -3.828806522496852e-06 2.59;];
fontsize = 34;
linewidth = 5;
h0 = PumpEquation(1);
r = PumpEquation(2);
w = PumpEquation(3);
q = 0:1250;
s = 1;
headincrease1 = s^2.*(h0 + r.*(q./s).^w);
h = figure
plot(q,headincrease1,'LineWidth',linewidth);
set(gca,'fontsize',fontsize,'FontName', 'sans-serif')
xlim([0,1300])
ylim([0,400])
xlabel('Flow: $q$ (GPM)','FontSize',fontsize+3,'interpreter','latex');
ylabel('Head increase','FontSize',fontsize+2,'interpreter','latex');
lgd = legend('$s=1.0$','Location','Best','Interpreter','Latex');
lgd.FontSize = fontsize+7;
title('$h^{M} = s^2 (h_0 - r (q/s)^{\nu})$','interpreter','latex','FontSize',fontsize+7)
set(lgd,'box','off')
set(lgd,'Interpreter','Latex');
%Variable-Speed Pump Curve
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 7 4])
print(h,'PumpHeadIncrease','-depsc2','-r300');

% plot convergence and C_P
fontsize = 40;
h = figure;
yyaxis left
plot(log10(Error),'LineWidth',2);
xlabel('Iteration','FontSize',fontsize,'interpreter','latex');
ylabel('$\log(\mathrm{error})$','FontSize',fontsize,'interpreter','latex');
%title('Monthly Climate Data')
yyaxis right
plot(C_estimate','LineWidth',2)
ylabel('$C^{P}$','FontSize',fontsize,'interpreter','latex')
%legend('Precipitation','Temperature','Low','High')
set(gca, 'TickLabelInterpreter', 'latex','fontsize',fontsize);
hold off
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 12 4])
print(h,'ConvergenceAndCestimation','-depsc2','-r300');
 