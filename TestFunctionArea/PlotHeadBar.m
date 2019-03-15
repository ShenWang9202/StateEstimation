% plot head bar for C-TOWN result in WFP journal, the .mat file is in Ctown
% branch not here.
clear;
load('Ctown_500_1000.mat')

GP =[];

GP(IndexInVar.JunctionHeadIndex) = X(IndexInVar.JunctionHeadIndex,end)/M2FT;
GP(IndexInVar.ReservoirHeadIndex) = X(IndexInVar.ReservoirHeadIndex,end)/M2FT;
GP(IndexInVar.TankHeadIndex) = X(IndexInVar.TankHeadIndex,end)/M2FT;
GP(IndexInVar.PumpFlowIndex) = X(IndexInVar.PumpFlowIndex,end)/LPS2GMP;
GP(IndexInVar.PipeFlowIndex) = X(IndexInVar.PipeFlowIndex,end)/LPS2GMP;
GP(IndexInVar.ValveFlowIndex) = X(IndexInVar.ValveFlowIndex,end)/LPS2GMP;
GP(IndexInVar.PumpSpeedIndex) = X(IndexInVar.PumpSpeedIndex,end);

GP = GP';

headindex = max(IndexInVar.TankHeadIndex);
flowindex = max(IndexInVar.ValveFlowIndex);

EPANET = Solution(:,1);
%'J366' 'J159' 'J82'
CaredHead = {'J55' 'J68' 'J78' 'J154'  'J226'  'J232' 'J249'  'J369' 'J411'  'J431' 'J441' 'J511'};

[~,n] = size(CaredHead);
varIndex = [];
% find the index of CaredElements
for  i = 1:n
var_index = find(strcmp(Variable_Symbol_Table,CaredHead{i}))
varIndex = [varIndex;var_index];
end

[n,~] = size(varIndex);
epanet_solution = [];
GPselect=[];
EPANETselect = [];
for i = 1:n
    GPselect = [GPselect; GP(varIndex(i))];
    EPANETselect = [ EPANETselect ;Solution(varIndex(i),1)];
end
fontsize = 44;
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to bar
bar1 = bar([GPselect EPANETselect]);
set(bar1(2),'DisplayName','\boldmath $\xi_{\mathrm{GP}}$');
set(bar1(1),'DisplayName','\boldmath ${\xi}_{\mathrm{EPANET}}$');

box(axes1,'on');
% Set the remaining axes properties
[~,n] = size(CaredHead);
set(axes1,'FontSize',fontsize,'XTick',1:n,'XTickLabel',...
    CaredHead);
% Create legend
legend1 = legend(axes1,'show');
xlim([0.5 n+0.5])
set(legend1,'Interpreter','latex','FontSize',fontsize,'Orientation','horizontal','Location','north');
xlabel('Junction ID','FontSize',fontsize+3,'interpreter','latex');
ylabel('Head($\mathrm{m}$)','FontSize',fontsize+2,'interpreter','latex');

set(gca, 'TickLabelInterpreter', 'latex','fontsize',fontsize);

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 24 8])
print(figure1,'headcompare','-depsc2','-r300');
 


