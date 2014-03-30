function [plate,plate_order]= fcs_plate_read(folder)
% FCS_PLATE_READ Reads a directory containing .FCS files
% FCS_PLATE_READ(folder) loads all wells in a plate in a directory into
% a struct array containing each well's HEADER, PARAMS and DATA.

files = dir(strcat(folder,'*.fcs'));
n = length(files);
letters = cell({'A','B','C','D','E','F','G','H'});

h = waitbar(0,'Reading wells...');

for i=1:n
file_name = strcat(folder, char(files(i).name)) ;
[DATA,PARAMS,HEADER]=fcsread(file_name) ;
plat(i) = struct('DATA',{DATA.*(DATA>0)},'PARAMS',{PARAMS},'HEADER',{HEADER}) ;
waitbar(i/n,h,strcat('Reading well number:' ,num2str(i),'/',num2str(n)));
end

close(h)

h = waitbar(0,'Sorting wells...');
for i=1:n
w_p_str = fcs_read_header(plat(i).HEADER,'TUBE NAME') ; % String containing the position of the well.
row = find(ismember(letters,w_p_str(1))==1) ; % Computes the row of the well being read
col = str2num(w_p_str(2:end)) ; % Computes the column of the well being read
plate_order(i)=col+12*(row-1);
waitbar(i/n,h,strcat('Sorting well number:' ,num2str(i),'/',num2str(n)));
end
close(h)

plate(plate_order)=plat;