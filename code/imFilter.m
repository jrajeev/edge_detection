function [Sx Sy]=imFilter()
    G=Gaussian([11 11]);
    Delx=[1 -1];
    Dely=[1;-1];
    Sx=conv2(G,Delx,'same');
    Sy=conv2(G,Dely,'same');
    %[Sx Sy]=gradient(G);
end