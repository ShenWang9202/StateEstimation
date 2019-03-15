CaredHead = {'J3' 'J5' 'T8'};


[~,n] = size(CaredHead);
varIndex = [];
% find the index of CaredElements
for  i = 1:n
var_index = find(strcmp(Variable_Symbol_Table,CaredHead{i}))
varIndex = [varIndex;var_index];
end

[n,~] = size(varIndex);

SelectedHead = BarSolution(varIndex,:)

fontsize = 65;
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
%Create legend and only plot the first 2 bar

SelectedHeadMakeLasttwoas0= zeros(size(SelectedHead))
SelectedHeadMakeLasttwoas0(:,1:2) = SelectedHead(:,1:2);

% plot bar1
bar1= bar(SelectedHeadMakeLasttwoas0);

set(bar1(1),'DisplayName','\boldmath ${\xi}_{\mathrm{EPANET}}$');
set(bar1(2),'DisplayName','\boldmath $\xi_{\mathrm{SE}}$ under scenario 1');


box(axes1,'off');
% Set the remaining axes properties
[~,n] = size(CaredHead);
set(axes1,'FontSize',fontsize,'XTick',1:n,'XTickLabel',...
    CaredHead);
% Create legend and only plot the first 2 bar
legend1 = legend([bar1(1) bar1(2)]);
set(legend1,'Interpreter','latex','FontSize',fontsize,'Location','Northeast');
legend boxoff 
legend1_position = get(legend1,'Position');


xlabel('Element ID','FontSize',fontsize+3,'interpreter','latex');
ylabel('Head($\mathrm{ft}$)','FontSize',fontsize+2,'interpreter','latex');

xlim([0.5 n+0.5])
ylim([min(min(SelectedHead))-2 max(max(SelectedHead))+2])
set(gca, 'TickLabelInterpreter', 'latex','fontsize',fontsize);


% Name the first axis ax1 and create a second axis on top of the first
ax1position=get(axes1,'Position')
axes2 = axes('Position',get(axes1,'Position'));
% Plot the second two sets of data on ax2
bar2= bar(SelectedHead);

set(bar2(3),'DisplayName','\boldmath ${\xi}_{\mathrm{EPANET}}$');
set(bar2(4),'DisplayName','\boldmath $\xi_{\mathrm{SE}}$ under scenario 1');


box(axes2,'off');
% Set the remaining axes properties
[~,n] = size(CaredHead);
set(axes2,'FontSize',fontsize,'XTick',1:n,'XTickLabel',...
    CaredHead);
% Create legend and only plot the first 2 bar
legend2 = legend([bar2(3) bar2(4)]);
set(legend2,'Interpreter','latex','FontSize',fontsize,'Location','Best');
legend boxoff 

xlabel('Element ID','FontSize',fontsize+3,'interpreter','latex');
ylabel('Head($\mathrm{ft}$)','FontSize',fontsize+2,'interpreter','latex');

xlim([0.5 n+0.5])
ylim([min(min(SelectedHead))-2 max(max(SelectedHead))+2])
set(gca, 'TickLabelInterpreter', 'latex','fontsize',fontsize);



% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 24 12])
% print(figure1,'Scenariocompare','-depsc2','-r300');
 


