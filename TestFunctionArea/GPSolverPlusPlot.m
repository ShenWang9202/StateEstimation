% this prove that c_23 is mono_increase or decrease, and because of the
% demand constraints, q23 + q45 = 100, one flow increases and another one
% decrease, this is why my GP can go on and on.
%  q23_T = -2000:2000;
% % c_23_t = R23.*q23_T .* abs(q23_T).^(0.852);
% 
%  c_23_t = (R23.* q23_T .* abs(q23_T).^(0.852)-q23_T);
%  v = R23 .* abs(q23_T).^(0.852)-1;
%  figure
%  plot(q23_T,c_23_t)
%  figure
%  plot(q23_T,v)

clc
clear
R23=1.145323502901834e-05;
R34=1.145323502901834e-05;
b = 1.01;
% q23 = -10;
% q34 = 200;
 q23 = 250;
 q34 = 100;

d3 = 200;
delta_h= 0.6; 
JumpPoint = [];


solution = [];
solution = [solution;q23 q34];
C_es = [];
% problem constants
% for i=1:200
% c_23 = b^(R23*abs(q23)^(1.852)-q23);
% c_34 = b^(R34*abs(q34)^(1.852)-q34);
% cvx_begin gp 
%   variables Q23 Q34 z
%   % objective function is the box volume
%   minimize( z )
%   subject to
%     c_23*Q23*(c_34 * Q34)^(-1) * b^(-delta_h) == 1;
%     Q23*(Q34) * b^(-d3) == 1;
%     z^(-1) <=1; 
% cvx_end
% q23 = log(Q23)/log(b);
% q34 = log(Q34)/log(b);
% solution = [solution;q23 q34];
% end
    j = 0;
for i=1:400

c_23 = b^(R23*q23*abs(q23)^(0.852)-q23);
c_34 = b^(R34*q34*abs(q34)^(0.852)-q34);
C_es = [C_es; c_23 c_34;];
cvx_begin gp 
  variables Q23 Q34 z DeltaH
  % objective function is the box volume
  minimize( z )
  subject to
    c_23*Q23*(c_34 * Q34) * DeltaH^(-1)  == 1;
    Q23*(Q34)^(-1)* b^(-d3) == 1;
    z^(-1) <=1; 
     DeltaH * b^(-delta_h) == 1;
cvx_end
q23 = log(Q23)/log(b);
q34 = log(Q34)/log(b);
solution = [solution;q23 q34];
JumpPoint = [JumpPoint;q23 q34];
j = j+ 1;
if(mod(i,4) ==0)
    tendency = solution(i,:) - JumpPoint(j,:);
    if(solution(i,1) - JumpPoint(j,1) > 0)
 
    end
end
end

% b^(delta_h)


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
Q1_B = delta_h - log(C_es(1,1)*C_es(1,2))/log(b) - Q34 ;
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
% view(axes1,[-139.5 -10.8]);
% view(axes1,[21.7 33.2000000000001]);