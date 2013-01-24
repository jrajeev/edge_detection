function J=commute1()
    [I,Gx,Gy,Delx,Dely]=initialize();
    T=conv_2D(I,Gx);
    J=conv_2D(T,Gy);
end