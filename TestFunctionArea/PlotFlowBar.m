% plot flow bar for C-TOWN result in WFP journal, the .mat file is in Ctown
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
% CaredFlow = {'J511' 'J411' 'J226' 'J55' 'J431' 'J232' 'J68' 'J441' 'J249' 'J78' 'J154' 'J369' 'J165'};
CaredFlow = {  'P21' 'P98' 'P96'  'P113' 'P118' 'P443' 'P524' 'P787' 'P892' 'P992'  'PU6' 'V47'};
[~,n] = size(CaredFlow);
varIndex = [];
% find the index of CaredElements
for  i = 1:n
var_index = find(strcmp(Variable_Symbol_Table,CaredFlow{i}))
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
figure2 = figure;

% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

% Create multiple lines using matrix input to bar
bar2 = bar([GPselect EPANETselect]);
set(bar2(2),'DisplayName','\boldmath $\xi_{\mathrm{GP}}$');
set(bar2(1),'DisplayName','\boldmath ${\xi}_{\mathrm{EPANET}}$');

box(axes2,'on');
% Set the remaining axes properties
[~,n] = size(CaredFlow);
set(axes2,'FontSize',fontsize,'XTick',1:n,'XTickLabel',...
    CaredFlow);
% Create legend
legend1 = legend(axes2,'show');
xlim([0.5 n+0.5])
set(legend1,'Interpreter','latex','FontSize',fontsize,'Orientation','horizontal','Location','north');
xlabel('Elements ID','FontSize',fontsize+3,'interpreter','latex');
ylabel('Flow($\mathrm{LPS}$)','FontSize',fontsize+2,'interpreter','latex');

set(gca, 'TickLabelInterpreter', 'latex','fontsize',fontsize);

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 24 8])
print(figure2,'flowcompare','-depsc2','-r300');
 


