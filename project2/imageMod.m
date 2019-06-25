% load dataset
load('mnist.mat')

nHold = 1;
IMAGE = reshape(images(nHold,:),28,28)';
labels(nHold)
IMAGE2 = imgaussfilt(IMAGE);
IMAGE3 = IMAGE-IMAGE2;
figure
subplot(1,3,1)
imagesc(IMAGE)
colormap(flipud(gray(256)))
axis equal
set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Fontsize', 12)
axis off
title('Orignal')
subplot(1,3,2)
imagesc(IMAGE2)
colormap(flipud(gray(256)))
axis equal
set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Fontsize', 12)
axis off
title('Low Pass Filtered')
subplot(1,3,3)
imagesc(IMAGE3)
colormap(flipud(gray(256)))
axis equal
set(gca, 'XTick', [])
set(gca, 'YTick', [])
set(gca, 'Fontsize', 12)
axis off
title('High Pass Filtered')

%imwrite(uint8(255)-uint8(IMAGE), 'databaseExample.png')