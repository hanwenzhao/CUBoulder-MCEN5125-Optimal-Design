function [sudoku, x] = Sudoku_Zhao(inputMatrix)
% MCEN 5152
% Optimal Design
% Project #3: Sudoku
% Hanwen Zhao
% MEID: 650-703
% inputMatrix = [8 0 0 0 0 0 0 0 0;
%                  0 0 3 6 0 0 0 0 0;
%                  0 7 0 0 9 0 2 0 0;
%                  0 5 0 0 0 7 0 0 0;
%                  0 0 0 0 4 5 7 0 0;
%                  0 0 0 1 0 0 0 3 0;
%                  0 0 1 0 0 0 0 6 8;
%                  0 0 8 5 0 0 0 1 0;
%                  0 9 0 0 0 0 4 0 0]
N = 9; NN = N*N; NNN = N*N*N;
% allocate memory for row contrains matrix
A_row = zeros(NN, NNN);
for n = 1:9
    counter = 0;
    for i = 1:N
        for j = 1:N
            A_row(i+(n-1)*N,n+counter*N) = 1;
            counter = counter + 1;
        end
    end
end
% create matrix for column constains
A_col = repmat(eye(NN),1,9);
% allocate memory for subgrid constrains
A_sub = zeros(NN,NNN);
for k = 1:N
    for i = 1:N
        for j = 1:sqrt(N)
            A_sub(i+(k-1)*N,(1+floor((i-1)/3)*243)+(i-(floor((i-1)/3)*3+1))*N*3+(j-1)*N+k-1) = 1;
            A_sub(i+(k-1)*N,(1+floor((i-1)/3)*243)+(i-(floor((i-1)/3)*3+1))*N*3+NN+(j-1)*N+k-1) = 1;
            A_sub(i+(k-1)*N,(1+floor((i-1)/3)*243)+(i-(floor((i-1)/3)*3+1))*N*3+2*NN+(j-1)*N+k-1) = 1;
        end
    end
end
% calcualte total number of clues
numClue = sum(sum(inputMatrix>0));
% allocate memory for clue matrix
A_clue = zeros(numClue, NNN);
counter = 1;
for i =1:N
    for j = 1:N
        if inputMatrix(i,j)> 0
            A_clue(counter,(i-1)*NN+N*(j-1)+inputMatrix(i,j)) = 1;
            counter = counter + 1;
        end
    end
end
% allocate memory for uniqueness (each binary should only exits one)
A_uni = zeros(NN,NNN);
for i = 1:NN
    for j = 1:N
        A_uni(i,j+(i-1)*N) = 1;
    end
end
% start building final LP
A = [A_row; A_col; A_sub; A_clue; A_uni; -A_sub; -A_clue; -A_uni];
b = [ones(NN,1); ones(NN,1); ones(NN,1); ones(numClue,1); ones(NN,1); -ones(NN,1); -ones(numClue,1); -ones(NN,1)];
f = ones(NNN,1);
x = linprog(f, A, b, [], [], zeros(NNN,1), ones(NNN,1));
% convert binary solution to decimal
counter = 1;
sol = zeros(NN,1);
for i=1:NN
    for j = 1:N
        if x((i-1)*N+j,1)~=0
            sol(counter,1)=j;
            counter = counter + 1;
        end
    end
end
% display final matrix
sudoku = zeros(N,N);
counter = 1;
for i = 1:N
    for j = 1:N
        sudoku(i,j) = sol(counter,1);
        counter = counter + 1;
    end
end
sudoku
end