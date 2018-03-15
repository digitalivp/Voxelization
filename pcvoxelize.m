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

if(nargin==2 || (nargin==3 && any(ischar(varargin{3}))))
    
    file = varargin{1};
    if(any(ischar(file)))
        ptCloud = pcread(file);
    elseif(isa(file,'pointCloud'))
        ptCloud = file;
    elseif(isnumeric(file))
        ptCloud = pointCloud(file);
    end
    V = ptCloud.Location;
    desiredLevels = varargin{2};
elseif(nargin==3 || (nargin==4 && any(ischar(varargin{4}))))
    V = varargin{1};
    C = varargin{2};
    ptCloud = pointCloud(V,'Color',C);
    desiredLevels = varargin{3};
end

center = (strcmp(varargin{end},'center'));   

if(center)
    range = max(abs([ptCloud.XLimits(2)-ptCloud.XLimits(1), ptCloud.YLimits(2)-ptCloud.YLimits(1), ptCloud.ZLimits(2)-ptCloud.ZLimits(1)]));
    
    shiftX = ptCloud.XLimits(2) + ptCloud.XLimits(1);
    shiftY = ptCloud.YLimits(2) + ptCloud.YLimits(1);
    shiftZ = ptCloud.ZLimits(2) + ptCloud.ZLimits(1);

    V(:,1) = V(:,1) -  shiftX/2;
    V(:,2) = V(:,2) -  shiftY/2;
    V(:,3) = V(:,3) -  shiftZ/2;
else
    range = max(abs([ptCloud.XLimits, ptCloud.YLimits, ptCloud.ZLimits]));
end
currentLevels = ceil(log2(range));
scale = 2^(desiredLevels-currentLevels-1);

ptCloudA = pointCloud(floor(V*scale+center*2^(desiredLevels-1)),'Color',ptCloud.Color,'Normal',ptCloud.Normal);
ptCloudB = pcdownsample(ptCloudA,'gridAverage',1);

if(nargout == 1)
    varargout{1} = ptCloudB;
elseif(nargout == 2)
    varargout{1} = ptCloudB.Location;
    varargout{2} = ptCloudB.Color;
end

end

