clear
clc

[Q23,Q34] = meshgrid(-1000:10:1000,-1000:10:1000);
R23=1.145323502901834e-05;
R34=1.145323502901834e-05;
Z =  R23.*Q23.*abs(Q23).^(0.852) +  R34.*Q34.*abs(Q34).^(0.852);
CO(:,:,1) = zeros(25); % red
CO(:,:,2) = ones(25).*linspace(0.5,0.6,25); % green
CO(:,:,3) = ones(25).*linspace(0,1,25); % blue
figure2 = figure;
% Create axes
axes1 = axes('Parent',figure2);
surf(Q23,Q34,Z,'FaceColor','r','FaceAlpha',0.7,'EdgeColor','none')

%% mass conservation
hold on
Q1_B = 200 + Q34;
surf(Q1_B,Q34,Z,'FaceColor','b','FaceAlpha',0.7,'EdgeColor','none')


 hold on
Z =  -4 + zeros(size(Q23));
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.3,'EdgeColor','none')
hold on
Z = Z+3;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.3,'EdgeColor','none')
hold on
Z = Z+3;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.3,'EdgeColor','none')
hold on
Z = Z+3;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.3,'EdgeColor','none')
% hold on
% Z = Z+3;
% surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.5,'EdgeColor','none')

%  view(axes1,[-90 90]);

fontsize = 66;
set(gca, 'TickLabelInterpreter', 'latex','fontsize',fontsize);
xlabel('$q_{23}$','FontSize',fontsize,'interpreter','latex')
ylabel('$q_{34}$','FontSize',fontsize,'interpreter','latex')
zlabel('$\Delta h_{24}$','Rotation',0,'FontSize',fontsize,'interpreter','latex')
axes('pos',[.54 .65 .5 .25])
imshow('pic_new.png')


hold on
annotation(figure2,'textbox',...
    [0.889128094725508 0.663406780992165 0.0578191226241546 0.0673978052491087],...
    'String',{'$q_{34}$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',fontsize);

% Create textbox
annotation(figure2,'textbox',...
    [0.714747039827771 0.796008974411907 0.0578191226241546 0.0673978052491087],...
    'String',{'$q_{23}$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',fontsize);

% Create textbox
annotation(figure2,'textbox',...
    [0.787944025834225 0.906676970423866 0.215716237676657 0.0673978052491087],...
    'String',{'$\mathrm{Viewed\ from\ top}$'},...
    'LineStyle','none',...
    'Interpreter','latex',...
    'FontSize',fontsize,...
    'FitBoxToText','off');
% view(axes1,[-90 90]);

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 9])
print(figure2,'3nodes3DPipeOnly','-depsc2','-r300');