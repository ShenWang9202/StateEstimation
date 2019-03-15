clc
clear
R23=1.145323502901834e-05;
R34=1.145323502901834e-05;
b = 1.01;
q23 = 300;
q34 = 200;

d3 = 200;
delta_h= 0.3;
delta_h2 = 0.25
solution = [];
solution = [solution;q23 q34];
C_es = [];
JumpPoints = [];
index = 0;
for i=1:100
c_23 = (R23*q23*abs(q23)^(0.852)-q23);
c_34 = (R34*q34*abs(q34)^(0.852)-q34);
C_es = [C_es; c_23 c_34;];
cvx_begin
  variables Q23 Q34 x y
  % objective function is the box volume
  minimize( 0.002*x * x + y*y) % suppose delta_h2  is much more accurate.
  subject to
    Q23 + Q34 == delta_h - (c_23+c_34) + x
    Q23  == delta_h2 - (c_23) + y
    Q23 - Q34 == d3
cvx_end
q23 = Q23 ;
q34 =  Q34 ;
solution = [solution;q23 q34];
if(mod(i,4)==0)
    JumpPoints = [JumpPoints;q23 q34];
    index = index + 1;
    tendency = solution(i,:) - solution(i-2,:);
    q23 = solution(i,1) + 50 * tendency(1,1);
    q34 = solution(i,2) + 50 * tendency(1,2);
end
end


%% Plot figure.
q23 = solution(:,1);
q34 = solution(:,2);

fontsize = 24;
[Q23,Q34] = meshgrid(-100:10:400,-300:10:200);
Z =  R23.*Q23.*abs(Q23).^(0.852) +  R34.*Q34.*abs(Q34).^(0.852);
CO(:,:,1) = zeros(25); % red
CO(:,:,2) = ones(25).*linspace(0.5,0.6,25); % green
CO(:,:,3) = ones(25).*linspace(0,1,25); % blue
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'on');
surf(Q23,Q34,Z,'FaceColor','r','FaceAlpha',0.8,'EdgeColor','none')
%% mass conservation
hold on
Q1_B = d3 + Q34;
surf(Q1_B,Q34,Z,'FaceColor','b','FaceAlpha',0.8,'EdgeColor','none')
%
hold on
Q1_B = delta_h - (C_es(1,1)+C_es(1,2)) - Q34 ;
surf(Q1_B,Q34,Z,'FaceColor','g','FaceAlpha',0.4,'EdgeColor','none')
% 
% hold on
% Q1_B = delta_h - log(C_es(200,1)*C_es(200,2))/log(b) - Q34 ;
% surf(Q1_B,Q34,Z,'FaceColor','g','FaceAlpha',0.4,'EdgeColor','none')

%%
 hold on
Z = delta_h + zeros(size(Q23));
surf(Q23,Q34,Z,'FaceColor','k','FaceAlpha',0.4,'EdgeColor','none')


set(gca, 'TickLabelInterpreter', 'latex','fontsize',fontsize);
xlabel('$q_{23}$','FontSize',36,'interpreter','latex')
ylabel('$q_{34}$','FontSize',36,'interpreter','latex')
zlabel('$\Delta h$','Rotation',0,'FontSize',fontsize+10,'interpreter','latex')

z_f = R23 .* q23 .* abs(q23).^(0.852) + R34 .*  q34 .* abs(q34).^(0.852);
hold on
dot=[q23 q34 z_f];
plot3(dot(:,1),dot(:,2),dot(:,3),'Marker','s','MarkerSize',15,'Color',[0 1 0]);

view(axes1,[-127.5 22.8000000000002]);
