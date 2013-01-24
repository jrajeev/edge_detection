function [Ig,Ix,Iy]=imGradient()
    [I,Gx,Gy,Delx,Dely]=initialize();
    T=conv_2D(I,conv2(Gx,Gy))
    Ix=conv2(T,Delx,'same');
    Iy=conv2(T,Dely,'same');
    Ig=[Ix.*Ix + Iy.*Iy];
end