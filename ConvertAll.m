data_dir = './Data'
dictdir = '~/Work/tonyfast.github.io/_data/dictionary22.yml'
dd = dir( data_dir );
todir = './Data/';
postdir = '~/Work/tonyfast.github.io/_posts';

imdir = '~/Work/tonyfast.github.io/assets';
vizdata = '~/Work/tonyfast.github.io/_data/viz.yml';


dictexist = false;
for ii = 1 : numel( dd)
    if dd(ii).isdir & dd(ii).name(1) ~= '.'
        dd(ii).name
        
        ff = dir( fullfile( data_dir, dd(ii).name ));
        for jj = 1 : numel( ff )
            if ~ff(jj).isdir & numel( strfind( ff(jj).name, 'git')) ==0 ...
                    & numel( strfind( ff(jj).name, 'h5')) ==0
                dl = fullfile( data_dir, dd(ii).name, ff(jj).name );
                [ DATA ] = Structure_Output_Data( dl );
                h5nm = BatchWrite( dl, DATA, todir);
                if ~dictexist
                    H5toDictMD( h5nm, dictdir )
                    dictexist = true;
                end
                newpost = H5toYAML( h5nm, dictdir, postdir );
                CreateThumbnails( vizdata, h5nm, postdir, imdir);
            end
        end
    end
end