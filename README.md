# Voxelization
Voxelized point cloud generation

function [ varargout ] = pcvoxelize( varargin )
%pcvoxelize Voxelized downsampling of point cloud file.
%
%   ptCloudOut = pcvoxelize(ptCloudIn, desiredLevels) returns a voxelized
%   point cloud with a geometric resolution of 2^desiredLevels voxels in
%   each dimension. The return value ptCloud is a pointCloud object.
%
%   ptCloudOut = pcvoxelize(filename, desiredLevels) reads a point cloud file with name
%   'filename' and voxelizes it using desiredLevels levels. The return value ptCloud is a
%   pointCloud object.
%   
%   ptCloudOut = pcvoxelize(Vin, Cin, desiredLevels) returns a pointcloud with
%   geometry defined by a N-by-3 numeric array Vin and color information in another
%   N-by-3 array Cin.
%
%   [Vout, Cout] = pcvoxelize(___) instead returns the geometry array Vout
%   and the color array Cout of the voxelized point cloud.
%
%   [___] = pcvoxelize(___, desiredLevels, 'center') additionally centers the voxelized
%   pointcloud so that its geometric center is at position
%   2^(desiredLevels-1) in each dimension.
