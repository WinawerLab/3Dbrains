function makeWrl(vertices, faces, colors, fname)
% Create and write a wrl file for 3D printing a brain

% Initialize a file
fid = fopen(fname, 'w');

% Write the header stuff
str{1} = '#VRML V2.0 utf8';
str{2} = '#Created by ZBrush VRML exporter';
str{3} = 'Shape { ';
str{4} = '  geometry IndexedFaceSet { ';
str{5} = '   coord Coordinate {';
str{6} = '      point [';

for ii= 1:length(str)
    fprintf(fid, '%s\n', str{ii});
end

  

% Write the vertices
fprintf('Writing vertices ...\n')
for ii = 1:size(vertices,1)
    fprintf(fid, '\t %f  %f  %f', vertices(ii,1), vertices(ii,2), vertices(ii,3));
    if ii < size(vertices,1), fprintf(fid, ',\n');
    else, fprintf(fid, ']\n\t}\n'); end
end


% Write the faces
fprintf('Writing faces ...\n')
 fprintf(fid, '	coordIndex [       ');
 for ii = 1:size(faces,1)
    if ii < size(faces,1)
        fprintf(fid, '\t %d, %d, %d, -1,\n', faces(ii,1), faces(ii,2), faces(ii,3));    
    else, fprintf(fid, '\t %d, %d, %d]\n\n',faces(ii,1), faces(ii,2), faces(ii,3));
    end
 end

% Write the colors
fprintf('Writing colors ...\n')
fprintf(fid, '  colorPerVertex TRUE\n');
fprintf(fid, '  color Color {\n');
fprintf(fid, '   color [\n');
for ii = 1:size(colors,1)
    if ii < size(colors,1)
        fprintf(fid, '\t %f %f %f,\n', colors(ii,1), colors(ii,2), colors(ii,3));    
    else, fprintf(fid, '\t %f %f %f]\n\t\t}\n\t}\n}',colors(ii,1), colors(ii,2), colors(ii,3));
    end
 end
% close

fclose(fid);

end