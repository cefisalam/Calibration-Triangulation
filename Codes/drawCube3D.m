function Points3D = drawCube3D(Xmin, Xmax, Ymin, Ymax, Zmin, Zmax)
%% DRAWCUBE shows a Cube in a 3D Plot for given Min and Max Value for all three Axes.

%   Input
%       Xmin  - Origin of Cube along X direction
%       Xmax  - Length of Cube along X direction
%       Ymin  - Origin of Cube along Y direction
%       Ymax  - Length of Cube along Y direction
%       Zmin  - Origin of Cube along Z direction
%       Zmax  - Length of Cube along Z direction
%
%   Output
%       Point3D - The 3D Coordinate points of a Cube
%       ####### - Figure showing the 3D Plot of a Cube

%% Function starts here

% Vertices of the Cube
Points3D = [Xmin Ymin Zmin;
           Xmax Ymin Zmin;
           Xmax Ymax Zmin;
           Xmin Ymax Zmin;
           Xmin Ymin Zmax;
           Xmax Ymin Zmax;
           Xmax Ymax Zmax;
           Xmin Ymax Zmax];

% Connectivity to Draw a Perfect Cube
Faces = [Xmin Ymin Zmin;
                Xmax Ymin Zmin;
                Xmax Ymin Zmax;
                Xmax Ymin Zmin;
                Xmax Ymax Zmin;
                Xmax Ymax Zmax;
                Xmax Ymax Zmin;
                Xmin Ymax Zmin;
                Xmin Ymax Zmax;
                Xmin Ymax Zmin;
                Xmin Ymin Zmin;
                Xmin Ymin Zmax;
                Xmax Ymin Zmax;
                Xmax Ymax Zmax;
                Xmin Ymax Zmax;
                Xmin Ymin Zmax];

% Draw the Cube
plot3(Faces(:,1), Faces(:,2), Faces(:,3))

end