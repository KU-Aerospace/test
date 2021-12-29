% Probelm#1 : Matlab code for NLP Graphic Method
n=50;
xmin = 0.5  ; xmax = 1.5 ; dx=(xmax-xmin)/n;
ymin = 0.5  ; ymax = 1.5 ; dy=(ymax-ymin)/n;

for i=1:n+1;
    x(i)= xmin + dx*i;
    y(i)= ymin + dy*i;
end;
a=100;b=1;
%---------------------------------------------------------
% Objective function
%---------------------------------------------------------
for i=1:n+1;
    for j=1:n+1;
        x1=x(i);
        x2=y(j);
%
        xx(i,j)=x1;
        yy(i,j)=x2;
        ff(i,j)=a*(x2-x1^2)^2 +(1-x1)^2;
    end;
end;
contour(xx,yy,ff,101)
hold on; 
%---------------------------------------------------------
% Constraints
%---------------------------------------------------------
for j=1:n+1;
        xc(j) =  x(j);
        yc(j) = -1.5 ;
end
plot(xc,yc,'-r')    
