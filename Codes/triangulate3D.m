 function Points3D = triangulate3D(P1, x1, P2, x2)
%% TRIANGULATE3D computes Projection of 3D Point onto a Virtual Camera Plane along the Z-axis.

%   Input
%       P1        - Projection Matrix of Camera 1 (3 x 4)
%       Points2D1 - Set of 2D Points for Camera plane 1 (2 x N)
%       P2        - Projection Matrix of Camera 2 (3 x 4)
%       Points2D2 - Set of 2D Points for Camera plane 1 (2 x N)
%
%   Output
%       P3D - Triangulated 3D Points (N x 3)

%% Function starts here

% Number of Points
[r1,c1] = size(x1);
[r2,c2] = size(x2);

% Show Warning if Points are not of Same Size
if r1 ~= r2 || c1 ~= c2
    warinig('Input Points must be of Same Size');
end

P = zeros(4,c1);

for i=1:c1
    % Create the (3 x 3) Triangulation Matrix for a Point in both Planes
    X1 = [0 1 -x1(2,i); -1 0 x1(1,i); x1(2,i) -x1(1,i) 0];
    X2 = [0 1 -x2(2,i); -1 0 x2(1,i); x2(2,i) -x2(1,i) 0];
    
    % Multiply with Projection Matrices
    D = [X1*P1; X2*P2];
    
    % Compute SVDto get Eigen Vectors
    [~,~,V] = svd(D);
    
    % Consider the last Eigen Vector of Matrix V
    z = V(:,end);
    
    % Make the 3D Points Homogeneous
    P(:,i) = z/z(4);
end

% Consider only the 3D Points (X,Y,Z)
Points3D = P(1:3,:)';

end