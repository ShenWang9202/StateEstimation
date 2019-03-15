clear
clc

[Q23,Q34] = meshgrid(-1000:10:1000,-1000:10:1000);
R23=1.145323502901834e-05;
R34=1.145323502901834e-05;

R23_2=0.845323502901834e-05;
R34_2=1.85323502901834e-05;

Z =  R23.*Q23.*abs(Q23).^(0.852) +  R34.*Q34.*abs(Q34).^(0.852);
Z_2 =  R23_2.*Q23.*abs(Q23).^(0.852) +  R34_2.*Q34.*abs(Q34).^(0.852);
CO(:,:,1) = zeros(25); % red
CO(:,:,2) = ones(25).*linspace(0.5,0.6,25); % green
CO(:,:,3) = ones(25).*linspace(0,1,25); % blue
figure2 = figure;
% Create axes
axes1 = axes('Parent',figure2);
surf(Q23,Q34,Z,'FaceColor','r','FaceAlpha',0.7,'EdgeColor','none')
hold on
surf(Q23,Q34,Z_2,'FaceColor','g','FaceAlpha',0.7,'EdgeColor','none')

fontsize = 32;
set(gca, 'TickLabelInterpreter', 'latex','fontsize',fontsize);
xlabel('$q_{23}$','FontSize',fontsize,'interpreter','latex')
ylabel('$q_{34}$','FontSize',fontsize,'interpreter','latex')
zlabel('$\Delta h_{24}$','Rotation',0,'FontSize',fontsize,'interpreter','latex')

%% mass conservation
hold on
Q1_B = 300 + Q34;
surf(Q1_B,Q34,Z_2,'FaceColor','b','FaceAlpha',0.7,'EdgeColor','none')
Q1_B = 100 + Q34;
surf(Q1_B,Q34,Z_2,'FaceColor','b','FaceAlpha',0.7,'EdgeColor','none')


 hold on
Z =  0 + zeros(size(Q23));
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.3,'EdgeColor','none')
hold on
Z = Z+2;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.3,'EdgeColor','none')
hold on
Z = Z+2;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.3,'EdgeColor','none')
hold on
Z = Z+2;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.3,'EdgeColor','none')

