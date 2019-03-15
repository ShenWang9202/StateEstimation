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
surf(Q1_B,Q34,Z,'FaceColor','b','FaceAlpha',0.5,'EdgeColor','none')


 hold on
Z =  -6 + zeros(size(Q23));
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.1,'EdgeColor','none')
hold on
Z = Z+3;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.1,'EdgeColor','none')
hold on
Z = Z+3;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.1,'EdgeColor','none')
hold on
Z = Z+3;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.1,'EdgeColor','none')
hold on
Z = Z+3;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.1,'EdgeColor','none')
fontsize = 36
set(gca, 'TickLabelInterpreter', 'latex','fontsize',fontsize);
xlabel('$q_{23}$','FontSize',fontsize,'interpreter','latex')
ylabel('$q_{34}$','FontSize',fontsize,'interpreter','latex')
zlabel('$\Delta h$','Rotation',0,'FontSize',fontsize,'interpreter','latex')
%% initial surface
hold on
% intial point(100,3)
q23 = 100;
q34 = 3;
b = 1.01;
delta_h = 1;
c_23 = b^(R23*q23*abs(q23)^(0.852)-q23);
c_34 = b^(R34*q34*abs(q34)^(0.852)-q34);
res =  R23*q23*abs(q23).^(0.852) -  R34*q34*abs(q34).^(0.852);
% plot inital point
plot3(q23,q34,res,'Marker','s','MarkerSize',10,'Color',[0 0 0]);

% plot the surf through initial point
delta_h - log(c_23/c_34)/log(b)
Q1_B = Q34 + delta_h - log(c_23/c_34)/log(b);
surf(Q1_B,Q34,Z,'FaceColor','g','FaceAlpha',0.8,'EdgeColor','none')

% Change a intial point (-100,300)
q23 = -100;
q34 = 300;
c_23 = b^(R23*q23*abs(q23)^(0.852)-q23);
c_34 = b^(R34*q34*abs(q34)^(0.852)-q34);
res =  R23*q23*abs(q23).^(0.852) -  R34*q34*abs(q34).^(0.852);
% plot inital point
plot3(q23,q34,res,'Marker','s','MarkerSize',10,'Color',[0 0 0]);
%
hold on
delta_h - log(c_23/c_34)/log(b)
Q1_B = Q34 + delta_h - log(c_23/c_34)/log(b);
surf(Q1_B,Q34,Z,'FaceColor','g','FaceAlpha',0.5,'EdgeColor','none')

% Change a intial point (100,-200)
q23 = 100;
q34 = -200;
c_23 = b^(R23*q23*abs(q23)^(0.852)-q23);
c_34 = b^(R34*q34*abs(q34)^(0.852)-q34);
res =  R23*q23*abs(q23).^(0.852) -  R34*q34*abs(q34).^(0.852);
% plot inital point
plot3(q23,q34,res,'Marker','s','MarkerSize',10,'Color',[0 0 0]);
%
hold on
delta_h - log(c_23/c_34)/log(b)
Q1_B = Q34 + delta_h - log(c_23/c_34)/log(b);
surf(Q1_B,Q34,Z,'FaceColor','g','FaceAlpha',0.5,'EdgeColor','none')

q23 = 310;
q34 = 400;
c_23 = b^(R23*q23*abs(q23)^(0.852)-q23);
c_34 = b^(R34*q34*abs(q34)^(0.852)-q34);
res =  R23*q23*abs(q23).^(0.852) -  R34*q34*abs(q34).^(0.852);
% plot inital point
plot3(q23,q34,res,'Marker','s','MarkerSize',15,'Color',[0 0 0]);
%
hold on
delta_h - log(c_23/c_34)/log(b)
Q1_B = Q34 + delta_h - log(c_23/c_34)/log(b);
surf(Q1_B,Q34,Z,'FaceColor','g','FaceAlpha',0.5,'EdgeColor','none')

%%
 hold on
Z =  -0 + zeros(size(Q23));
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.15,'EdgeColor','none')
hold on
Z = Z+2;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.15,'EdgeColor','none')
hold on
Z = Z+2;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.15,'EdgeColor','none')
hold on
Z = Z+2;
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.15,'EdgeColor','none')







