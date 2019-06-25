% MCEN 5125
% Project #1: Truss Topology
% Hanwen Zhao
% MEID: 650-703

tic
clc
close all
% define some variables
% grid size 11 rows * 20 columns
m = 2;
n = 4;
% maximum strss since yield strength is 8 and area is 1
Sy = 8;
% some general variables
numNodes = m*n;
numBeams = nchoosek(numNodes,2); % 24090 possible beams
% point number counted on row-major
anchorPointNum = [1 5];
forcePointNum = [4];
forceMag = -0.2;
% create matrix to store coordinates
pNodes = fliplr(combvec(1:1:n,1:1:m)');
% allocate memory
v = strings(m*n,1);
for i = 1:length(pNodes)
    % if the number smaller than 0, add the 0 in the front ex. "1" to "01"
    if pNodes(i,1)<10
       temp1 = strcat("0",num2str(pNodes(i,1)));
    else
       temp1 = num2str(pNodes(i,1));
    end
    if pNodes(i,2)<10
       temp2 = strcat("0",num2str(pNodes(i,2)));
    else
       temp2 = num2str(pNodes(i,2));
    end
    v(i) = strcat(temp1,temp2);
end
% use matlab built in to generate coordniates for all possible beams
x = nchoosek(v,2);
% create container to store coordniates
coordniates = zeros(numBeams,4);
% separate string back to number ex "0101" to [1 1]
for i = 1:numBeams
    firstNum = convertStringsToChars(x(i,1));
    secondNum = convertStringsToChars(x(i,2));
    coordniates(i,:) = [str2num(firstNum(1:2)),str2num(firstNum(3:4)),str2num(secondNum(1:2)),str2num(secondNum(3:4))];
end
% create Aeq matrix
Aeqx = sparse(zeros(numNodes,numBeams));
Aeqy = sparse(zeros(numNodes,numBeams));
% calculate all coefficients 
beamCoeffx = zeros(1, numBeams);
beamCoeffy = zeros(1, numBeams);
weight = zeros(numBeams,1);
% calcualte force in x and y directions, as well as the distance
for i = 1:numBeams
    dy = coordniates(i,4) - coordniates(i,2);
    dx = coordniates(i,3) - coordniates(i,1);
    weight(i) = sqrt(dx^2+dy^2);
    beamCoeffx(i) = dy/sqrt(dx^2+dy^2);
    beamCoeffy(i) = dx/sqrt(dx^2+dy^2);
end
% fill the coefficients to matrix
colOffset = 1;
rowOffset = 1;
for i = fliplr(1:1:m*n-1)
    currentCoeffx = beamCoeffx(colOffset:colOffset+i-1);
    currentCoeffy = beamCoeffy(colOffset:colOffset+i-1);
    Aeqx(rowOffset:rowOffset+i,colOffset:colOffset+i-1) = [currentCoeffx;-diag(currentCoeffx)];
    Aeqy(rowOffset:rowOffset+i,colOffset:colOffset+i-1) = [currentCoeffy;-diag(currentCoeffy)];
    rowOffset = rowOffset+1;
    colOffset = colOffset+i;
end
% allocate memory for Aeq matrix, use sparse to save memory
Aeq = zeros(2*numNodes,2*numBeams);
Aeq(:,1:numBeams) = [Aeqx;Aeqy];
Aeq([anchorPointNum, anchorPointNum+numNodes],:) = 0;
beq = sparse(zeros(2*numNodes,1));
beq(forcePointNum+numNodes) = forceMag;
% built inequality matrix
Aiq = [speye(numBeams), -speye(numBeams);
       -speye(numBeams), -speye(numBeams)];
   
biq = [zeros(numBeams,1);
        zeros(numBeams,1)];
% unweighted cost function 
f = [zeros(numBeams,1);ones(numBeams,1)];
% weighted
f_weight = [zeros(numBeams,1);weight];
% call linprog for unweighted
u_unweighted = linprog(f,Aiq,biq,Aeq,beq,-Sy*ones(2*numBeams,1),Sy*ones(2*numBeams,1));
u_unweighted = u_unweighted(1:numBeams);
% filter out small forces
resultBeamIndex1 = find(abs(u_unweighted)>0.01);

% call linprog for unweighted
u_weighted = linprog(f_weight,Aiq,biq,Aeq,beq,-Sy*ones(2*numBeams,1),Sy*ones(2*numBeams,1));
u_weighted = u_weighted(1:numBeams);
% filter out small forces
resultBeamIndex2 = find(abs(u_weighted)>0.01);
%resultBeamIndex1 = resultBeamIndex2;
%u_unweighted = u_weighted;
%% run section to redraw plots
figure
hold on
for i = 1:length(resultBeamIndex1)
    index = resultBeamIndex1(i);
    width = 0.5 + abs(u_unweighted(index) * 2);
    red = 1 - abs(u_unweighted(index))*0.5*0.1;
    blue = 1 - abs(u_unweighted(index))*0.5*0.1;
    if u_unweighted(index) >= 0
        line([coordniates(index,2)-1,coordniates(index,4)-1],[coordniates(index,1)-1,coordniates(index,3)-1],'Color',[red 0 0],'LineWidth',width)
    elseif u_unweighted(index) < 0
        line([coordniates(index,2)-1,coordniates(index,4)-1],[coordniates(index,1)-1,coordniates(index,3)-1],'Color',[0 0 blue],'LineWidth',width)
    end
    
end
plot([3 3],[0 -0.7],'r','Linewidth',1)
plot([3 2.8],[-0.7 -0.5],'r','Linewidth',1)
plot([3 3.2],[-0.7 -0.5],'r','Linewidth',1)
plot([0 -.5 -.5 0],[1 0.8 1.2 1],'k','Linewidth',1)
plot([0 -.5 -.5 0],[0 -.2 0.2 0],'k','Linewidth',1)
plot([-1.2+0.5 -0.5],[-0.2 -0.1],'k','Linewidth',1)
plot([-1.2+0.5 -0.5],[-0.1 0],'k','Linewidth',1)
plot([-1.2+0.5 -0.5],[0 0.1],'k','Linewidth',1)
plot([-1.2+0.5 -0.5],[0.8 0.9],'k','Linewidth',1)
plot([-1.2+0.5 -0.5],[0.9 1],'k','Linewidth',1)
plot([-1.2+0.5 -0.5],[1 1.1],'k','Linewidth',1)
plot(pNodes(:,2)-1, pNodes(:,1)-1, 'b.', 'MarkerSize', 10)
axis equal
title('2x4 Truss Topology Problem (Unweighted)')