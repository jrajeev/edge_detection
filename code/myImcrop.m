function J=myImcrop(I)
    imshow(I);
    [x,y]=ginput(2);
    x=round(x);
    y=round(y);
    xst=min(x); xwid=max(x)-xst; yst=min(y); ylen=max(y)-yst;
    J=I(yst:(yst+ylen),xst:(xst+xwid),:);
    imshow(J);
end