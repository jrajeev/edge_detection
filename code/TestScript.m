%%CIS 581 Test Script - Fall 2011
% This script passes input similar to what will be tested to the functions
% and tests that the output is in the correct format.
% This is not a test of correctness of the operations themselves

pass = true;

I = uint8(zeros([10,10,3]));
I(3,3,1:3) = 255;
I(7,7,1:3) = 255;

%Click on the two white squares
J = myImcrop(I);
if(numel(size(J)) ~=3)
    fprintf('Image returned not RGB\n');
    pass = false;
end

%%
I = imread('101085.jpg');
E = cannyEdge(I);

szI = size(I);
szE = size(E);
if(szI(1) ~= szE(1) || szI(2) ~= szE(2))
    fprintf('Edge map not the same size as the input image\n');
    pass = false;
end
if(numel(unique(E(:))) ~= 2)
    fprintf('Edge map is not binary\n');
    pass = false;
end

if(pass)
    fprintf('Tests Passed\n');
end



