function DATA = h5read( fn, dset,  FIELD )
% Reads from HDF5 filetypes. This function was specifically made to support partial reading of composite datatypes. 
% 
% INPUTS:
% fn - file name where the data is written to.
% dset - name of the dataset in the HDF5 that the data is being stored as
% FIELD - Name or Index of the composite field to be read from the datasset
% dset

fid = H5F.open( fn );


did = H5D.open(fid,dset);
tid = H5D.get_type(did);
tid2 = H5T.create('H5T_COMPOUND',H5T.get_size( tid ) );
N = H5T.get_nmembers(tid);
if nargin == 3
    if isnumeric(FIELD)
        index = FIELD;
        index_on = true;
    else
        if ischar( FIELD)
            FIELD = {FIELD};
        end
        nm = arrayfun(@(x)H5T.get_member_name(tid,x),[1:N]-1,'UniformOutput',false);
        
        index = find( ismember( nm, FIELD) );
    end
    for ii = index-1
        H5T.insert( tid2, nm{ii+1}, H5T.get_member_offset( tid, ii ),'H5T_NATIVE_DOUBLE');
    end
else
    index = 1:N;
    tid2 = 'H5ML_DEFAULT';
end

%


DATA = H5D.read(did, tid2 , 'H5S_ALL', 'H5S_ALL', 'H5P_DEFAULT' );

H5D.close( did )
H5T.close( tid )
if nargin == 3
    H5T.close( tid2 )
end
H5F.close(fid);