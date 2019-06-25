clear all
close all
clc


N=9;
NN = N*N; % Number Cells 

%NOTE: each cell has 9 possible numbers that can
%      be chosen.  So the first 9 variables refer
%      to cell (1,1).  If for example the (1,1) cell
%      is a 4, than x(1:9)=[0 0 0 1 0 0 0 0 0] etc
NNN = N*N*N; %Total number of binary variables x

%%%%%%%%%%%%%%%%% EXAMPLE PROBLEMS %%%%%%%%%%%%%%%%%%%
% MEDIUM LEVEL
% MatrixInitial = [0 5 0 0 2 0 3 7 0;
%                  0 3 0 9 4 0 0 0 1;
%                  0 0 0 7 0 0 0 0 0;
%                  0 0 5 8 0 0 9 2 0;
%                  3 0 0 0 0 0 0 0 5;
%                  0 7 8 0 0 9 1 0 0;
%                  0 0 0 0 0 2 0 0 0;
%                  8 0 0 0 7 6 0 5 0;
%                  0 2 1 0 8 0 0 6 0];

% EVIL LEVEL
% MatrixInitial = [0 6 9 7 0 0 4 3 0;
%                  0 1 0 0 0 0 0 7 0;
%                  3 0 0 0 0 5 0 0 2;
%                  0 3 0 0 0 0 0 0 1;
%                  0 0 0 0 9 0 0 0 0;
%                  6 0 0 0 0 0 0 2 0;
%                  7 0 0 2 0 0 0 0 3;
%                  0 9 0 0 0 0 0 4 0;
%                  0 4 2 0 0 3 5 1 0];

% %EVIL LEVEL
% MatrixInitial = [0 9 0 4 0 8 5 0 0;
%                  0 0 0 0 0 0 0 0 6;
%                  2 0 1 0 7 0 9 0 0;
%                  5 0 0 0 8 0 0 0 7;
%                  0 0 7 9 0 4 1 0 0;
%                  8 0 0 0 2 0 0 0 9;
%                  0 0 2 0 3 0 4 0 5;
%                  4 0 0 0 0 0 0 0 0;
%                  0 0 5 8 0 7 0 9 0]
%              
%Hardest Sudoku Ever
MatrixInitial = [8 0 0 0 0 0 0 0 0;
                 0 0 3 6 0 0 0 0 0;
                 0 7 0 0 9 0 2 0 0;
                 0 5 0 0 0 7 0 0 0;
                 0 0 0 0 4 5 7 0 0;
                 0 0 0 1 0 0 0 3 0;
                 0 0 1 0 0 0 0 6 8;
                 0 0 8 5 0 0 0 1 0;
                 0 9 0 0 0 0 4 0 0]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
[MatrixFinal x] = Suduoku_Zhao(MatrixInitial);
toc
