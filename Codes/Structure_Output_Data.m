function [StructuredData SpatialData] = Structure_Output_Data( fn, capture_iter )
% This function converts the output files of Polymer Molecular Dynamics
% simulations generated by Xin Dong in Karl Jacobs group at Georgia Tech.
% The flat files are converted into a structure than can be easily written
% to HDF5. The HDF5 and are available on Tony Fast's public Dropbox for 
% consumption.
%
% The output files are unstructured flat files containing
% # Timestep
% # Number of Atoms
% # Simulation Boundaries
% # Atom Index
% # Chain Index - the individual polymer chain that an atom belongs to
% # Terminus/Interior - Whether an atom appears at the end of a chain <2>
% or in the middle <1>
% # X,Y,Z - position of the atom within the boundaries of the simulation

% Open the unstructured data for read.
fo = fopen( fn, 'r' );

ct = 0;
while ~feof( fo )  & ct <=10
    ct = ct + 1;
    
    s = fgetl( fo ); % Ignore line
    if numel( s ) > 0
        StructuredData.Aggregate(ct).timestep = fscanf( fo, '%i\n',1);
        fgetl( fo ); % Ignore line
        StructuredData.Aggregate(ct).Natoms = fscanf( fo, '%i\n',1);
        fgetl( fo ); % Ignore line
        bounds = fscanf( fo, '%f %f\n',[ 2 3])';
        StructuredData.Aggregate(ct).Xlo = bounds(1,1);
        StructuredData.Aggregate(ct).Xhi = bounds(1,2);
        StructuredData.Aggregate(ct).Ylo = bounds(2,1);
        StructuredData.Aggregate(ct).Yhi = bounds(2,2);
        StructuredData.Aggregate(ct).Zlo = bounds(3,1);
        StructuredData.Aggregate(ct).Zhi = bounds(3,2);
        
        fgetl( fo ); % Ignore line
        SpatialData = fscanf( fo, '%i %i %i %f %f %f\n', [ 6 StructuredData.Aggregate(ct).Natoms])';
        [~, order] = sort( SpatialData(:,1));
        [ StructuredData.Spatial(ct).chainid, ...
            StructuredData.Spatial(ct).terminus, ...
            StructuredData.Spatial(ct).X, ...
            StructuredData.Spatial(ct).Y,  ...
            StructuredData.Spatial(ct).Z ] = deal( ....
            SpatialData(order,2)',SpatialData(order,3)',SpatialData(order,4)',SpatialData(order,5)',SpatialData(order,6)' );
        
        StructuredData.Aggregate(ct).Nchain = numel( unique(  StructuredData.Spatial(ct).chainid ));
    end
end

fclose( fo );