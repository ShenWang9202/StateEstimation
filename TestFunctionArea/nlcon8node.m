% create file nlcon.m for nonlinear constraints
function [c,ceq] = nlcon8node(R,x)
  c = [];
  ceq = [];
  select=[1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 1 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 1 0 -1 0 0 0 0 0 0 0 0 0 0;];
  Pumpequation= [393.700800000000,-3.82951361803227e-06,2.59000000000000];
  h0 = Pumpequation(1);
  r = -Pumpequation(2);
  mu = Pumpequation(3);
  for i=9:16
    ceq = [ceq;pipeloss(R(i-8),x(i))-select(i-8,:)*x(1:18)];
  end
  ceq = [ceq;x(1) - x(7) - x(18)^2*(h0-r*(x(17)/x(18))^mu)];
  