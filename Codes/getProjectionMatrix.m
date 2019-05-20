function P = getProjectionMatrix(K, R, t)
%% GETPROJECTIONMATRIX computes (3 x 4) Projection Matrix for given Intrinsic and Extrinsic Parameters. 

%   Input
%       K  - Intrinsic Matrix of size (3 x 3)
%       R  - Rotation Matrix of size (3 x 3)
%       t  - Translation Vector of size (3 x 1)
%
%   Output
%       P - Projection Matrix of size (3 x 4)

%% Function starts here

% Create Normalsised Camera Matrix of size (3 x 4)
C = [eye(3) zeros(3,1)];

% Compute Projection Matrix
P = K * C * [R t; zeros(1,3) 1];

end

