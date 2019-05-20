function Points2D = project2D(P, Points3D)
%% PROJECT2D computes Projection of 3D Point onto a Virtual Camera Plane along the Z-axis.

%   Input
%       P       - Projection Matrix of size (3 x 4)
%       Points3D - Matrix containing 'N' Points in 3D Space as Row Vectors (N x 3)
%
%   Output
%       Points2D - Matrix containing 'N' Points in 2D Camera Plane as Row Vectors (N x 2)

%% Function starts here

% Make Homogeneous 3D Point Coordinates
Points3DH = [Points3D ones(size(Points3D,1),1)];

% Projection of 3D Points onto Camera Plane
Points2DH = P * Points3DH';

% Make the 2D Points Homogeneous
Points2DH = Points2DH ./repmat(Points2DH(3,:),3,1);

% Consider only the 2D Points (u,v)
Points2D = Points2DH(1:2,:)';

end

