clc;
clear;
close all;

%% Camera Calibration (To find Real Intrinsic Parameters)
% Load the Images of Checkerboard Patterns
imageFileNames = {'./Checkerboard/1.png',...
                  './Checkerboard/10.png',...
                  './Checkerboard/11.png',...
                  './Checkerboard/12.png',...
                  './Checkerboard/2.png',...
                  './Checkerboard/3.png',...
                  './Checkerboard/4.png',...
                  './Checkerboard/5.png',...
                  './Checkerboard/6.png',...
                  './Checkerboard/7.png',...
                  './Checkerboard/8.png',...
                  './Checkerboard/9.png',...
                 };

% Checkerboard Size
squareSize = 25;  % in units of 'millimeters'

% Calibrate the Camera
cameraParams = calibration(imageFileNames,squareSize);
K = cameraParams.IntrinsicMatrix';
disp('Intrinsic Matrix')
disp(K)

%% Simulation of Camera-1 and 3D Scene

% Simulate a Cube in 3D
figure,
P3D = drawCube3D(20, 100, 10, 50, 800, 900);
axis([-200 200 -100 100 0 1000])
hold on;
grid on;
disp('Simulated 3D Points')
disp(P3D)

% Give the Extrinsic Parameters for Camera-1
R1 = eye(3); % Rotation Matrix
t1 = [ 0 0 0]'; % Translation Vector

% Compute Projection Matrix
P1 = getProjectionMatrix(K, R1, t1);

% Simulate the camera
plot3(t1(1),t1(3),t1(2),'o','MarkerSize',10,'Color','r','Linewidth',1);

%% Projection of 3D Point onto the Camera(1) Plane

% Compute Projection
P2D = project2D(P1,P3D);

% To show the Points in Camera Plane
C1 = camstruct('PM',P1); % To construct camera structure (to be used by imagept2plane function)

% Convert Image Points into Plane Points
Pt1 = imagept2plane(C1, P2D', [0 0 K(1,1)], [0 0 1]);

% Define a Plane at Focal Length
min1 = min(Pt1(1:2,:),[],2);
max1 = max(Pt1(1:2,:),[],2);
XL = [min1(1,1)-100 max1(1,1)+100];
YL = [min1(2,1)-100 max1(2,1)+100];
Zplane = K(1,1);
patch(XL([1 2 2 1 1]), YL([1 1 2 2 1]), Zplane * ones(1,5), [0 .5 .5], 'FaceAlpha', 0.1);

% Plot the Points on the Plane
plot3(Pt1(1,:),Pt1(2,:), Pt1(3,:),'.','MarkerSize',10, 'LineWidth', 1,'Color','r');

% Draw the Cube onto the Plane
drawCube2D(Pt1')

% To Show the Projection Lines from 3D Points to Camra
 for i = 1:size(P3D,1)
     plot3([P3D(i,1) 0],[P3D(i,2) 0],[P3D(i,3) 0], 'LineWidth', 0.00005, 'Color', 'g');
 end
hold off;

%% Implementation of Direct Linear Transformation

% Compute Projection Matrix using DLT
P_dlt = dltCalibrate(P3D, P2D);

% Decompose Projection Matrix
[K_dlt, Rc_w, Pc, pp, pv] = decomposecamera(P_dlt);
disp('Intrinsic Matrix computed with DLT')
disp(K_dlt)

% Rescale Intrinsic Matrix
K_dlt = (1/K_dlt(3,3))*K_dlt;
disp('Intrinsic Matrix computed with DLT (Rescaled)')
disp(K_dlt)

%% Simulation of Camera-2

% Simulate a Cube in 3D
figure,
P3D = drawCube3D(20, 100, 10, 50, 800, 900);
axis([-200 200 -100 100 0 1000])
hold on;
grid on;

% Give the Extrinsic Parameters for Camera-1
R2 = eye(3); % Rotation Matrix
tx = 50;
t2 = [-tx 0 0]'; % Translation Vector 

% Compute Projection Matrix
P2 = getProjectionMatrix(K, R2, t2);

% Simulate the camera
tplot = [tx 0 0];
plot3(tplot(1),tplot(3),tplot(2),'o','MarkerSize',10,'Color','r','Linewidth',1);

%% Projection of 3D Point onto the Camera(2) Plane

% Compute Projection
P2D1 = project2D(P2,P3D);

% To show the Points in Camera Plane
C2 = camstruct('PM', P2); % To construct camera structure (to be used by imagept2plane function)

% Convert Image Points into Plane Points
Pt2 = imagept2plane(C2, P2D1', [0 0 K(1,1)], [0 0 1]);

% Define a Plane at Focal Length
min1 = min(Pt2(1:2,:),[],2);
max1 = max(Pt2(1:2,:),[],2);
XL = [min1(1,1)-100 max1(1,1)+100];
YL = [min1(2,1)-100 max1(2,1)+100];
Zplane = K(1,1);
patch(XL([1 2 2 1 1]), YL([1 1 2 2 1]), Zplane * ones(1,5), [0 .5 .5], 'FaceAlpha', 0.1);

% Plot the Points on the Plane
plot3(Pt2(1,:),Pt2(2,:), Pt2(3,:),'.','MarkerSize',10, 'LineWidth', 1,'Color','r');

% Draw the Cube onto the Plane
drawCube2D(Pt2')

% To Show the Projection Lines from 3D Points to Camra
 for i = 1:size(P3D,1)
     plot3([P3D(i,1) tx],[P3D(i,2) 0],[P3D(i,3) 0], 'LineWidth', 0.00005, 'Color', 'g');
 end
hold off;

%% Triangulation

Points3D = triangulate3D(P1, P2D', P2, P2D1');
disp('Triangulated 3D Points')
disp(Points3D)
