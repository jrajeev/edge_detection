function W=keeprange(A,range)
    B=(A>range)*range;
    Z=((A<=range).*A)+B;
    W=(Z<1)+((Z>=1).*Z);
end