function P_dlt = dltCalibrate(P3D, P2D)
%% PROJECT2D computes Projection of 3D Point onto a Virtual Camera Plane along the Z-axis.

%   Input
%       P3D - Matrix containing 'N' Points in 3D Space as Row Vectors (N x 3)
%       P2D - Matrix containing 'N' Points in 2D Camera Plane as Row Vectors (N x 2)
%
%   Output
%       P_dlt   - Projection Matrix of size (3 x 4)
%% Function starts here

D = [];

for i = 1: size(P3D,1)
    % Create DLT Matrix with a single 3D Point and Corresponding 2D Point in the Camera Plane
    DP = [-P3D(i,1) -P3D(i,2) -P3D(i,3) -1 0 0 0 0 P2D(i,1)*P3D(i,1) P2D(i,1)*P3D(i,2) P2D(i,1)*P3D(i,3) P2D(i,1);
          0 0 0 0 -P3D(i,1) -P3D(i,2) -P3D(i,3) -1 P2D(i,2)*P3D(i,1) P2D(i,2)*P3D(i,2) P2D(i,2)*P3D(i,3) P2D(i,2)];
    
    % Append the Matrix for all Points
    D = [D; DP];  
end

% Compute SVD to get Eigen Vectors
[~,~,V] = svd(D);

% Consider the last Eigen Vector of Matrix V
P_dlt = reshape(V(:,end),4,3)';

end

