function h5writemeta( fn, dset, attname, DATA )
% An improved version of the matlab function h5write.   Natively, h5write lacks the
% ability to write structures to HDF5 files.
%
% INPUTS:
% fn - file name where the data is written to.
% dset - name of the dataset in the HDF5 that the data is being stored as
% DATA - allows structures are all h5write native datatypes to be written.
%        if DATA is a structure then the information is written as a
%        compound datatype.  The size of each field should be the same.

if isstruct( DATA )
    if exist( fn, 'file')
        fo = H5F.open(fn,'H5F_ACC_RDWR','H5P_DEFAULT');
    else
        fo = H5F.create(fn);
    end
    fields = fieldnames(DATA);
    sz = size( getfield( DATA, fields{1}));
    
    nbytes = [ 8 50 128];
    cnb = cumsum( nbytes );
    tid = H5T.create('H5T_COMPOUND',cnb(end));
    
    ii = 1;
    H5T.insert(tid,fields{ii},0,'H5T_NATIVE_DOUBLE');
    ii = 2;
    strType = H5T.copy( 'H5T_C_S1' );
    H5T.set_size(strType, cnb(ii-1) );
    H5T.insert(tid,fields{ii},nbytes(ii),strType);
    if numel( fields ) == 3 
        ii = 3;
        strType = H5T.copy( 'H5T_C_S1' );
        H5T.set_size(strType, cnb(ii-1) );
        H5T.insert(tid,fields{ii},nbytes(ii),strType);
    elseif numel(fields) > 3
        error(sprintf('Invalid %s attribute.', attname ));
    end
%     DATA = setfield( DATA, fields{ii}, getfield( DATA, fields{ii} ) );
    
    
    
    sid = H5S.create_simple( numel(sz), fliplr(sz), fliplr(sz) );
    %     dset = horzcat(dset, num2str(round(rand(1)*1e5)));
    did = H5D.open( fo, dset);
    aid = H5A.create( did, attname, tid, sid, H5P.create('H5P_ATTRIBUTE_CREATE'));
    H5A.write( aid, tid, DATA );
    H5A.close(aid)
    H5S.close(sid)
    H5D.close(did)
    
    H5T.close(tid)
    H5F.close(fo);
else
    h5writeatt( fn,dset, attname, DATA);
end

end