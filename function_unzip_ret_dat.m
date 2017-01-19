function ret_dat = rle_decode(in_dat, lines, cols, dat_type) % Run length decoding 
% Uncompress an image which is encoded by using run-length-encoding algorithm. 
% BY: mayadong7349 2011-12-10   
ret_dat = int32([]); 
[height, width] = size(in_dat);
if height ~= 1, 
    error('Unsupported input data type.'); 
elseif mod(width, 2) ~= 0, 
    error('Unsupported input data type.'); 
end; 
  
if ~strcmp(dat_type, 'uint8') && ~strcmp(dat_type, 'logical'),     error('Cannot recognise the input data type.'); end 
  
c = 1; 
for index = 1:2:width 
    pix_count = in_dat(index + 1);
    for n = 1:pix_count 
        ret_dat(c) = in_dat(index);
         c = c + 1; 
    end 
end 
  
ret_dat = reshape(ret_dat, cols, lines); 
ret_dat = ret_dat'; 
  
switch dat_type 
    case 'uint8' 
        ret_dat = uint8(ret_dat);
    case 'logical' 
        ret_dat = logical(ret_dat); end 
  
end % end of function rle_decode

