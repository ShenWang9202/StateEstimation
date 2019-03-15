function [CvxExp,DemandVector] = FlowConstLinear(X,MassMatrixCell,Demand,IndexInVar)
% variable =
% [ head of Junction;
%   head of reservior;
%   head of tank;
%   flow of pipe;
%   flow of pump;
%   flow of valve;
%   speed of pump;]

% For nodes like source or tanks shouldn't have mass equations.
% getting start index of flow in var
q_start_index = min(IndexInVar.PipeFlowIndex);
% getting end index of flow in var
if(~isempty(IndexInVar.ValveFlowIndex))
    q_end_index = max(IndexInVar.ValveFlowIndex);
else % without valves
    if (~isempty(IndexInVar.PumpFlowIndex))
        q_end_index = max(IndexInVar.PumpFlowIndex);
    else % without pumps
        q_end_index = max(IndexInVar.PipeFlowIndex);
    end
end
% getting GP variables
Q = X(q_start_index:q_end_index);
[m,~] = size(MassMatrixCell);
CvxExp = [];
DemandVector = [];
for i = 1:m
    monomial_temp = 0;
    PostiveMatrixIndex = cell2mat(MassMatrixCell(i,1));
    [~,n] = size(PostiveMatrixIndex);
    for j = 1:n
        monomial_temp = monomial_temp + Q(PostiveMatrixIndex(j));
    end
    NegativeMatrixIndex = cell2mat(MassMatrixCell(i,2));
    [~,n] = size(NegativeMatrixIndex);
    for j = 1:n
        monomial_temp = monomial_temp - Q(NegativeMatrixIndex(j));
    end
    CvxExp = [CvxExp;  monomial_temp] ;
    DemandVector = [DemandVector; Demand(i)];
end

end