%Load and voxelize a point cloud from a ply file
ptCloud = pcread('teapot.ply');
voxCloud = pcvoxelize(ptCloud,9);
pcshow(voxCloud)

%The point cloud can be voxelized directly from file
voxCloud = pcvoxelize('teapot.ply',9);
pcshow(voxCloud)

%Another option is voxelizing from mat files
ptCloud = pcread('teapot.ply');
V = ptCloud.Location;
C = ptCloud.Color;
voxCloud = pcvoxelize(V,C,9);
pcshow(voxCloud)

%It is also possible to obtain the geometry and color matrices directly
[V,C] = pcvoxelize('teapot.ply',9);

%If the object is off-center, pcvoxelize has the option to centralize it in
%the 2^L x 2^L x 2^L grid formed
voxCloud = pcvoxelize('teapot.ply',9,'center');
pcshow(voxCloud)