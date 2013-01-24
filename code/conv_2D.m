function J=conv_2D(I,G)
    I1=padarray(I,floor(size(G)/2),'symmetric');
    J=conv2(I1,G,'same');
    [dimy dimx]=size(I);
    dim=floor(size(G)/2);
    J=J((dim(1)+1):(dim(1)+dimy), (dim(2)+1):(dim(2)+dimx));
end