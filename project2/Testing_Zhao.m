% MCEN 5125
% Project 2
% Hand-Written Character Recognition
% Hanwen Zhao
% MEID: 650-703

% load data
%load('0.00005.mat')
% create container for classified label
classifiedLabels = zeros(10000,1);
% uncomment for boarder cutting
%images_test = images_test_play1;
%A = Ap1; B = Bp1;
% uncomment for filters
images_test = images_test_play2;
A = Ap2; B = Bp2;
% uncomment for resizing
%images_test = images_test_play3;
%A = Ap3; B = Bp3;
% use classifer to identify the label
for i = 1:10000
   p = 1; q = 10;
   for n = 1:9
      if double(images_test(i,:)) * A{p,q} - B{p,q} >= 0
         q = q - 1;
         if n == 9
             classifiedLabels(i) = p - 1;
         end
      else
          p = p + 1;
          if n == 9
              classifiedLabels(i) = q - 1;
          end
      end
   end
end

% allocate memory to store numbers of image
test_numbers = zeros(1,10);
% calculate numbers of each "number"
 for i = 1:10000
    test_numbers(labels_test(i)+1) =  test_numbers(labels_test(i)+1) + 1;
 end
 % allocate memory for accuracy
accuracy = zeros(1,10);
% calcuate accuracy
for i = 1:10000
   if labels_test(i) == classifiedLabels(i)
       accuracy(labels(i)+1) = accuracy(labels(i)+1) + 1;
   end
end
fprintf('The accuracy for each number is ')
accuracy = (accuracy./test_numbers)'
fprintf('The total accuracy is % 4.6f.\n', mean(accuracy))
