function [DelJ theta Jx Jy]=imageGrad(I1)
    sz=size(I1);
    if (numel(sz)==3) I2=rgb2gray(I1);
    else I2=I1;
    end
    I=double(I2);
    imagesc(I);colormap(gray)
    title('Grayscale image');
    %imshow(I);
    [Sx Sy]=imFilter();
    Jx=conv2(double(I),Sx,'same');
    Jy=conv2(double(I),Sy,'same');
    DelJ=sqrt((Jx.*Jx) + (Jy.*Jy));
    theta=atan(Jy./Jx);
    figure,imagesc(DelJ);colormap(gray)
    title('image gradient');
    %figure,imagesc(Jx);colormap(gray)
    %figure,imagesc(Jy);colormap(gray)
end