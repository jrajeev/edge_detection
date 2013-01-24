function J=commute2()
    [I,Gx,Gy,Delx,Dely]=initialize();
    T=conv2(Gx,Gy);
    J=conv_2D(I,T);
end
