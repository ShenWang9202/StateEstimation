% create file nlcon.m for nonlinear constraints
function headloss = pipeloss(r,x)
headloss = r*x*abs(x)^(0.852);