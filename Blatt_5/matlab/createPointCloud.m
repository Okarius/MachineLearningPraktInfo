function [ pointCloud ] = createPointCloud( numPoints, variance, stretchFactor, alpha)
% Creates a point cloud, centered around the origin.
% 
% numPoints = number of points, at least 10.
% variance = variance for the first component.
% stretchFactor = used as weight which influences how strong the second
%  component is. For big values, the second component can thereby have a
%  stronger variance than the first one.
% alpha = degree(not radian) of rotation around the origin.
%
if numPoints < 10
    numPoints = 10;
end
 
% create X vector
X = sort(normrnd(0, variance, numPoints, 1));
numPoints = size(X, 1);

% create Y vector
Y = zeros(size(X));
peakOneX = round(numPoints / 2);
for i = 1 : numPoints
    val = abs(abs(i-1 - peakOneX) - peakOneX) / peakOneX;
    val = val * stretchFactor;
    Y(i, 1) = Y(i, 1) + normrnd(0, val);
end

% rotation
rotation = [cosd(alpha), -sind(alpha); sind(alpha), cosd(alpha)];
pointCloud = rotation * [X';Y'];

pointCloud = pointCloud';

end

