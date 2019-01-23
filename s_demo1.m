% Script to make files for 3D printing brains with retinotopy

% Set these variables

subjid = 'wlsubj042';

hemi = 'r'; % 'r' 'l'

surf = 'mid'; % 'white' 'pial' 'inflated' 'sphere' 'mid'

depvar = 'varea'; % 'eccen' 'angle' 'varea'

%% Read in the mesh  
fsdir = getenv('SUBJECTS_DIR');


fname = sprintf('%sh.%s', hemi, surf);

pth = fullfile(fsdir, subjid, 'surf');

[vertices, faces] = freesurfer_read_surf(fullfile(pth, fname));

% make sure it's 0-indexed, not 1-indexed
if min(faces(:)) == 1, faces = faces - 1; end

%% Read in the color overlays
tmp = MRIread(fullfile(pth, sprintf('%sh.inferred_eccen.mgz', hemi)));
data.eccen = squeeze(tmp.vol);
tmp = MRIread(fullfile(pth, sprintf('%sh.inferred_angle.mgz', hemi)));
data.angle = squeeze(tmp.vol);
tmp = MRIread(fullfile(pth, sprintf('%sh.inferred_varea.mgz', hemi)));
data.varea = squeeze(tmp.vol);

[cm_varea, cm_angle, cm_eccen] = cmBenson();

ok = data.varea <= 3 & data.varea > 0;

switch depvar
    case 'eccen'
        mxdata = 90; 
        cmap = cm_eccen;
    case 'angle'
        mxdata = 180; 
        cmap = cm_angle; 
    case 'varea'
        mxdata = 12;
        cmap = cm_varea;
        ok = data.varea > 0;

end

sz = size(cmap, 1);

inds = uint8(data.(depvar)/mxdata*sz);

colors = squeeze(ind2rgb(inds, cmap));

colors(~ok,:) = 0.5;

savefilename = sprintf('%s_%s_%s_%sh.wrl', subjid, surf, depvar, hemi);

%% Make the wrl file
makeWrl(vertices, faces, colors, fullfile(print3dRoot, 'files', savefilename));