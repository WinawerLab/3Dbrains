function rootPath=print3dRoot()
% Return the path to the root 3dprint directory
%
% This function must reside in the directory at the base of the print3dRoot
% directory structure.  
% 
% Example:
%   fullfile(print3dRoot)

rootPath=which('print3dRoot');

rootPath=fileparts(rootPath);

return
