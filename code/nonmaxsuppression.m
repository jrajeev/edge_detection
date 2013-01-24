function Jnew=nonmaxsuppression(Iin)
    [J,theta,Jx,Jy]=imageGrad(Iin);
    [dimy dimx]=size(J);
    [X,Y]= meshgrid(1:max(dimx,dimy));
    X=X(1:dimy,1:dimx);
    Y=Y(1:dimy,1:dimx);
    %Jsz=size(J)
    %thetasz=size(theta)
    %Xsz=size(X)
    %Ysz=size(Y);
    Xnew1=round(X+(sin(theta)));
    Xnew1=keeprange(Xnew1,dimx);
    Ynew1=round(Y+(cos(theta)));
    Ynew1=keeprange(Ynew1,dimy);
    Xnew2=round(X-(sin(theta)));
    Xnew2=keeprange(Xnew2,dimx);
    Ynew2=round(Y-(cos(theta)));
    Ynew2=keeprange(Ynew2,dimy);
    Jnew1=sub2ind(size(X),Ynew1,Xnew1);
    Jnew2=sub2ind(size(Y),Ynew2,Xnew2);
    Jnew=ones(size(J));
    for i=1:dimy
        for j=1:dimx
            if(J(i,j)>Jnew2(i,j))
                Jnew(Xnew2(i,j),Ynew2(i,j))=0;
            elseif (J(i,j)<Jnew2(i,j))
                Jnew(i,j)=0;
            end
            if(J(i,j)>Jnew1(i,j))
                Jnew(Xnew1(i,j),Ynew1(i,j))=0;
            elseif (J(i,j)<Jnew1(i,j))
                Jnew(i,j)=0;
            end    
        end
    end
    figure,imagesc(Jnew);colormap(gray)
end