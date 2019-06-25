% MCEN 5125
% Project 2
% Hand-Written Character Recognition
% Hanwen Zhao
% MEID: 650-703
tic
% load training data
load('mnist.mat')
% uncomment for less features(boarder cutting)
images = images_play1;
% uncomment for less features(resizing)
%images = images_play3;
% uncomment for more features
%images = images_play2;
% allocate memory to store numbers of image
numbers = zeros(1,10);
% calculate numbers of images for each "number"
 for i = 1:60000
    numbers(labels(i)+1) =  numbers(labels(i)+1) + 1;
 end
% allocate memoery
[~,n] = size(images);
for i = 1:10
   x{1,i} = zeros(numbers(i), n); 
end
% store all features into cell array
cindex = ones(1,10);
for i = 1:60000
    x{1,labels(i)+1}(cindex(labels(i)+1),:) = images(i,:);
    cindex(labels(i)+1) = cindex(labels(i)+1) + 1;
end
% Weighting paramater
gamma = 0.00005;
% initilize cell arrays for A B
A = cell(9,10);
B = cell(9,10);
% setup cvx to solve LP problems
% loop through all 45 classifier
for i = 1:9
    for j = i+1:10
        cvx_begin
            variables a(n,1) b u(numbers(i),1) v(numbers(j),1);
            minimize(norm(a)+gamma*(ones(1,numbers(i))*u+ones(1, numbers(j))*v));
            subject to
            x{1,i}*a - b*ones(numbers(i),1) >= ones(numbers(i),1) - u;
            x{1,j}*a - b*ones(numbers(j),1) <= -ones(numbers(j),1) - v;
            u > 0;
            v > 0;
        cvx_end
        % save A and B in upper triangle format
        A{i,j} = a;
        B{i,j} = b;
    end
end
toc