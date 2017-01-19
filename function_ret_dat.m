function ret_dat = rle_encode(in_dat)
 % Run length encoding  
 % PCX is a kind of image type in which RLE is widely used. 
 % Compress an image by using run-length-encoding algorithm. 
 % BY: mayadong7349 2011-12-10    
 ret_dat = int32([]);  
 if ndims(in_dat) == 3, % RGB is given  
    error('Unsupported image type.'); 
 end; % nothing to do for intensity image, indexed image    
 in_dat = in_dat'; 
 in_dat = in_dat(:);
 len = length(in_dat); 
 c = 1; 
  while c <= len,
        pix_dat = in_dat(c); 
        count = 0;
        while (c <= len) && (in_dat(c) ==pix_dat),
            count = count + 1;
            c = c + 1; 
        end;
        ret_dat = [ret_dat, pix_dat, count]; 
   end; 
end % end of function rle_encode