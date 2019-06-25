% MCEN 5125
% Homework #1 Brute Force
% Hanwen Zhao
% MEID: 650-703
clear all
close all
clc
% Input the number of cities
m = 9;
% Generate a new figure
figure
hold on
% Set figure boundary
xlim([0 15])
ylim([0 15])
% Generate m random locations
%location = randi([2 8],m,2);
location = [randperm(14,m)',randperm(14,m)'];
% Draw location on figure
plot(location(:,1),location(:,2),'r.','MarkerSize',18)
% Use ginput to take user input
input = ginput(m);
% Correct the user input to actual point
input = round(input);
errorIndex = [];
% Loop throught all input to find any mismatch coordinates
for ii = 1:m
    flag = 0;
    for jj = 1:m
        if input(ii,:) == location(jj,:)
            flag = 1;
        end
    end
    if flag == 0
        errorIndex(end+1) = ii;
    end
end
% if there is any location user did not click right on
if length(errorIndex) ~= 0
    %fprintf('There were %d locations you did not click right on the dots, be careful next time.\n', length(errorIndex))
end
% for user inputs not right on the dots, find the nearest location and
% replace the value
for jj = 1:length(errorIndex)
    for ii = 1:m
        dist(ii) = norm(input(errorIndex(jj),:)-location(ii,:));
    end
    input(errorIndex(jj),:) = location(find(dist==min(dist)),:);
end
% print the number text right to dot 
text1 = ['1';'2';'3';'4';'5';'6';'7';'8';'9'];
for ii = 1:m
    text(input(ii,1)+0.2,input(ii,2)+0.2,text1(ii));
end
% Draw soild arrow lines to indicate the guessed path
for ii = 1:m-1
    p1 = input(ii,:); p2 = input(ii+1,:); dp = p2 - p1;
    quiver(p1(1),p1(2),dp(1),dp(2),0,'LineWidth',1)
end
p1 = input(end,:); p2 = input(1,:); dp = p2 - p1;
quiver(p1(1),p1(2),dp(1),dp(2),0,'LineWidth',1)
% calculate the guessed path distance
guessDis = 0;
for ii = 1:m-1
    guessDis = guessDis + norm(input(ii,:)-input(ii+1,:));
end
guessDis = guessDis + norm(input(1,:)-input(end,:));
fprintf('The total distance for guessed path is %4.2f.\n',guessDis)
% use perms to find all possible paths
allPaths = perms(1:m);
curDis = 0;
minDis = guessDis;
minIndex = 0;
for ii = 1:length(allPaths)
    for jj = 1:m-1
        curDis = curDis + norm(location(allPaths(ii,jj),:)-location(allPaths(ii,jj+1),:));
    end
    curDis = curDis + norm(location(allPaths(ii,1),:)-location(allPaths(ii,m),:));
    if curDis <= minDis
        minDis = curDis;
        minIndex = ii;
    end
    curDis = 0;
end
optPath = zeros(m,2);
indexOrder = allPaths(minIndex,:);
for ii = 1:m
    optPath(ii,:) = location(indexOrder(ii),:); 
end
% calculate the optimal distance
optDis = 0;
for ii = 1:m-1
    optDis = optDis + norm(optPath(ii,:)-optPath(ii+1,:));
end
optDis = optDis + norm(optPath(1,:)-optPath(end,:));
fprintf('The total distance for optimal path is %4.2f.\n',optDis)
% Draw dashed arrow lines to indicate the optimal path
for ii = 1:m-1
    p1 = optPath(ii,:); p2 = optPath(ii+1,:); dp = p2 - p1;
    quiver(p1(1),p1(2),dp(1),dp(2),0,'LineWidth',1,'LineStyle','--')
end
p1 = optPath(end,:); p2 = optPath(1,:); dp = p2 - p1;
quiver(p1(1),p1(2),dp(1),dp(2),0,'LineWidth',1,'LineStyle','--')
% print order for optimal path
for ii = 1:m
    text(optPath(ii,1)+0.2,optPath(ii,2)-0.25,text1(ii),'Color','r');
end

