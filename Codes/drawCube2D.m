function drawCube2D(Points)
%% DRAWCUBE2D shows the Cube Projected onto Camera Plane.

%   Input
%       Points - Points projected onto the Camera Plane(N x 3) [The Z-axis is the Camera Plane]
%
%   Output
%       ####### - Figure showing the 2D Plot of a Cube on the Camera Plane

%% Function starts here

% Connectivity to Draw a Perfect Cube
Lines = [Points(1,:);
        Points(2,:);
        Points(6,:);
        Points(2,:);
        Points(3,:);
        Points(7,:);
        Points(3,:);
        Points(4,:);
        Points(8,:);
        Points(4,:);
        Points(1,:);
        Points(5,:);
        Points(6,:);
        Points(7,:);
        Points(8,:);
        Points(5,:)];

% Draw the Cube
plot3(Lines(:,1), Lines(:,2), Lines(:,3));

end