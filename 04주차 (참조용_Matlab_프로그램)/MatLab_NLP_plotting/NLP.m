% Matlab code for ploting
n=50;
for i=1:n+1;
    x(i)=-5+(10/n)*(i-1);
    y(i)=x(i);
end;
a=1/9;b=1/4;
%
for i=1:n+1;
    for j=1:n+1;
        x1=x(i);
        y1=y(j);
%
        xx(i,j)=x1;
        yy(i,j)=y1;
        ff(i,j)=a*x1*x1+b*y1*y1;
    end;
end;
contour(xx,yy,ff,5)
