%CONVMTX2SAME: Create a convolution matrix from a kernel for an n by m matrix.
%
%   conv_matrix = convmtx2same(kernel, n, m) creates the convolution matrix
%       for an n by m matrix, where the matrix is represented as a column
%       vector. The convolution is done in the style of the 'same' form from
%       conv2, where the matrix returned from the convolution is the same size
%       as the input. In this case, the elements outside of the matrix can be
%       thought of as zeros.
%
%   The kernel must be of dimension two, be square, and have an odd size.
%
%   Example
%   -------
%
%   kernel = [ 0,   1,   0, ...
%              1,  -5,   1, ...
%              0,   1,   0 ];
%
%   %% Matrix to convolve with.
%   M = rand(5,5);
%
%   %% Convolution matrix
%   C = convmtx2same(kernel, 5, 5);
%
%   %% Result
%   R = reshape(C*M(:), n, m);
%
%   %% The difference between the two is only floating point error.
%   assert(all(all(abs(R - conv2(M, kernel, 'same')) < 1e-14)));
%
%   See also CONVMTX2, CONVMTX, CONV2
function out = convmtx2same(kernel, n, m)

  if not(ndims(kernel) == 2 && size(kernel, 1) == size(kernel, 2) && ...
         mod(size(kernel,1), 2) == 1)
    error('convmtx2same:NonSquareOddMatrix', ...
          'Matrix must be a two dimensional square with odd size');
  end

  %% Kernel dimensions. Radius is the distance from the centre, whereas the
  %  padding is the total amount of padding added to parallel sides of the
  %  matrix.
  radius = floor(size(kernel,2)/2);
  padding = size(kernel,2) - 1;

  %% Generate a full convolution matrix and then remove the components that
  %  would create extra columns. These rows exist as continuous rows at the
  %  top and bottom of the convolution matrix.
  full_conv = convmtx2(kernel, n, m);
  extra_rows_conv = full_conv(1+radius*(n+padding):end-radius*(n+padding), :);

  len = size(extra_rows_conv,1);

  %% Remove the components that extra rows to the convolution matrix.
  %  Unfortunately these rows are at the top and bottom of each valuable
  %  block.
  block = n + padding;
  extraction_unit = [1+radius: n+radius];
  extract_rows = [1+radius: n+radius];
  while block < len
    extract_rows = [extract_rows, extraction_unit+block];
    block = block + (n + padding);
  end

  out = extra_rows_conv(extract_rows, :);

end
