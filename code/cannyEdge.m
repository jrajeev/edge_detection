function E=cannyEdge(Iin)
    [J,theta,Jx,Jy]=imageGrad(Iin);
    [dimy dimx]=size(J);
    [X,Y]= meshgrid(1:max(dimx,dimy));
    X=X(1:dimy,1:dimx);
    Y=Y(1:dimy,1:dimx);
    %Jsz=size(J)
    %thetasz=size(theta)
    %Xsz=size(X)
    %Ysz=size(Y);
    thresh_high=30; thresh_low=25;    thr=2;
    edgedir=zeros(size(J));
    edgenorm=zeros(size(J));
    for i=1:dimy
        for j=1:dimx
            if (theta(i,j)>(-1*pi/8) && theta(i,j)<=(pi/8)) edgedir(i,j)=90; edgenorm(i,j)=0;
            elseif (theta(i,j)>(pi/8) && theta(i,j)<=(3*pi/8)) edgedir(i,j)=45; edgenorm(i,j)=-45;
            elseif (theta(i,j)>(3*pi/8) && theta(i,j)<=(pi/2)) edgedir(i,j)=0; edgenorm(i,j)=90;
            elseif (theta(i,j)<(-1*pi/8) && theta(i,j)>=(-3*pi/8)) edgedir(i,j)=-45; edgenorm(i,j)=45;
            else edgedir(i,j)=0; edgenorm(i,j)=90;
            end
        end
    end
    Jnew1=zeros(size(J));
    %thresh=1;
    %J=(J>thresh)*255;
    Jnew1=zeros(size(J));
    cnt0=0;
    cnt45=0;
    cnt90=0;
    cnt45_=0;
    tcnt0=0;
    tcnt45=0;
    tcnt90=0;
    tcnt45_=0;
    for i=2:dimy-1
        for j=2:dimx-1 
                %direction 0
                if (edgenorm(i,j)==0)
                    tcnt0=tcnt0+1;
                   if (J(i,j)>=J(i,j+1) && J(i,j)>=J(i,j-1)) Jnew1(i,j)=J(i,j);cnt0=cnt0+1;
                   end
                end
                if (edgenorm(i,j)==90)
                    tcnt90=tcnt90+1;
                    if (J(i,j)>=J(i+1,j) && J(i,j)>=J(i-1,j)) Jnew1(i,j)=J(i,j);cnt90=cnt90+1;
                    end
                end
               if (edgenorm(i,j)==45)
                   tcnt45=tcnt45+1;
                    if (J(i,j)>=J(i-1,j-1) && J(i,j)>=J(i+1,j+1)) Jnew1(i,j)=J(i,j);cnt45=cnt45+1;
                    end
               end
               if (edgenorm(i,j)==-45)
                   tcnt45_=tcnt45_+1;
                    if (J(i,j)>=J(i-1,j+1) && J(i,j)>=J(i+1,j-1)) Jnew1(i,j)=J(i,j);cnt45_=cnt45_+1;
                    end
               end
        end
    end 
    figure,imagesc(Jnew1);colormap(gray) 
    title('edge in grayscale');
    %Edge linking
    
    Jnew=zeros(size(J));
    J=Jnew1;

    for i=1:dimy
        for j=1:dimx
            if (J(i,j)>=thresh_high) 
                Jnew(i,j)=255;
                %direction 0
                cnt=0;
                if (edgedir(i,j)==0)
                    for k=j:-1:1
                        if (J(i,k)==edgedir(i,j) && J(i,k)>=thresh_low) Jnew(i,k)=255; cnt=0;
                        elseif (J(i,k)==edgedir(i,j) && cnt<thr) cnt=cnt+1; Jnew(i,k)=255;
                        end
                    end
                    for k=j:dimx
                        if (J(i,k)==edgedir(i,j) && J(i,k)>=thresh_low) Jnew(i,k)=255; cnt=0;
                        elseif (J(i,k)==edgedir(i,j) && cnt<thr) cnt=cnt+1; Jnew(i,k)=255;
                        end
                    end
                %direction 90
                elseif (edgedir(i,j)==90)
                    for k=i:-1:1
                        if (J(k,j)==edgedir(i,j) && J(k,j)>=thresh_low) Jnew(k,j)=255; cnt=0;
                        elseif (J(k,j)==edgedir(i,j) && cnt<thr) cnt=cnt+1; Jnew(i,k)=255;
                        end
                    end
                    for k=j:dimy
                        if (J(k,j)==edgedir(i,j) && J(k,j)>=thresh_low) Jnew(k,j)=255; cnt=0;
                        elseif (J(k,j)==edgedir(i,j) && cnt<thr) cnt=cnt+1; Jnew(k,j)=255;
                        end
                    end
                %direction 0
                elseif (edgedir(i,j)==45)
                    k=i; m=j;
                    while (k>=1 && m>=1)
                        if (J(k,m)==edgedir(i,j) && J(k,m)>=thresh_low) Jnew(k,m)=255; cnt=0;
                        elseif (J(k,m)==edgedir(i,j) && cnt<thr) cnt=cnt+1; Jnew(k,m)=255;
                        end
                        k=k-1; m=m-1;
                    end
                    k=i; m=j;
                    while (k<=dimy && m<=dimx)
                        if (J(k,m)==edgedir(i,j) && J(k,m)>=thresh_low) Jnew(k,m)=255; cnt=0;
                        elseif (J(k,m)==edgedir(i,j) && cnt<thr) cnt=cnt+1; Jnew(k,m)=255;
                        end
                        k=k+1; m=m+1;
                    end
                %direction 0
                elseif (edgedir(i,j)==-45)
                    k=i; m=j;
                    while (k>=1 && m<=dimx)
                        if (J(k,m)==edgedir(i,j) && J(k,m)>=thresh_low) Jnew(k,m)=255; cnt=0;
                        elseif (J(k,m)==edgedir(i,j) && cnt<thr) cnt=cnt+1; Jnew(k,m)=255;
                        end
                        k=k-1; m=m+1;
                    end
                    k=i; m=j;
                    while (k<=dimy && m>=1)
                        if (J(k,m)==edgedir(i,j) && J(k,m)>=thresh_low) Jnew(k,m)=255; cnt=0;
                        elseif (J(k,m)==edgedir(i,j) && cnt<thr) cnt=cnt+1; Jnew(k,m)=255;
                        end
                        k=k+1; m=m-1;
                    end
                end
            end
        end
    end
    E=Jnew;
    
    figure,imagesc(Jnew);colormap(gray)
    title('edge linked output');
end