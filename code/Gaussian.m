function G=Gaussian(sz)
    G=zeros(sz);
    sigma=1;
    for i=1:sz(1)
        for j=1:sz(2)
            G(i,j)=exp(-((i-ceil(sz(1)/2))*(i-ceil(sz(1)/2)) + (j-ceil(sz(2)/2))*(j-ceil(sz(2)/2)))/(2*sigma*sigma));
        end
    end
    G=G/(sqrt(2*pi)*sigma);
end