% MCEN 5125
% Project 2
% Hand-Written Character Recognition
% Hanwen Zhao
% MEID: 650-703

% load training data
load('mnist.mat')
% allocate memory
images_play1 = int32(zeros(60000, 576));
images_play2 = int32(zeros(60000, 784*3));
images_play3 = int32(zeros(60000, 400));
images_test_play1 = int32(zeros(10000, 576));
images_test_play2 = int32(zeros(10000, 784*3));
images_test_play3 = int32(zeros(10000, 400));
% reduce images and images_test size to 24*24
for i = 1:60000
   temp = reshape(images(i,:),28,28);
   temp = temp(3:end-2,3:end-2);
   temp = reshape(temp,1,24*24);
   images_play1(i,:) = temp;
end
for i = 1:10000
   temp = reshape(images_test(i,:),28,28);
   temp = temp(3:end-2,3:end-2);
   temp = reshape(temp,1,24*24);
   images_test_play1(i,:) = temp;
end
% use image resize to reduce the size to 20*20
% reduce images and images_test size to 24*24
for i = 1:60000
   temp = reshape(images(i,:),28,28);
   temp = imresize(temp,0.7);
   temp = reshape(temp,1,20*20);
   images_play3(i,:) = temp;
end
for i = 1:10000
   temp = reshape(images_test(i,:),28,28);
   temp = imresize(temp,0.7);
   temp = reshape(temp,1,20*20);
   images_test_play3(i,:) = temp;
end
% increase image and image_test size by applying low pass and high pass
% filter
for i = 1:60000
   temp = reshape(images(i,:),28,28);
   % Low-Pass filter(Gaussian Filter)
   tempLow = imgaussfilt(temp);
   % High-Pass filter can be achieved by originalImage - lowPassImage
   tempHigh = temp - tempLow;
   % reshape to original size
   temp = reshape(temp,1,784);
   tempHigh = reshape(tempHigh,1,784);
   tempLow = reshape(tempLow,1,784);
   tempHigh = reshape(tempHigh,1,784);
   % concatenate features
   tempF = [temp,tempLow,tempHigh];
   images_play2(i,:) = tempF;
end
for i = 1:10000
   temp = reshape(images_test(i,:),28,28);
   % Low-Pass filter(Gaussian Filter)
   tempLow = imgaussfilt(temp);
   % High-Pass filter can be achieved by originalImage - lowPassImage
   tempHigh = temp - tempLow;
   % reshape to original size
   temp = reshape(temp,1,784);
   tempLow = reshape(tempLow,1,784);
   tempHigh = reshape(tempHigh,1,784);
   % concatenate features
   tempF = [temp,tempLow,tempHigh];
   images_test_play2(i,:) = tempF;
end
