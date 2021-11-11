%-------------------------------------------------------------------------
function [y] = ODE_System1_C_Exact_solution(t)
%-------------------------------------------------------------------------
        c1 = exp(-t)*cos(sqrt(15)*t);
        s1 = exp(-t)*sin(sqrt(15)*t);
% Displacement                    
        y(1) = -(1.5/221)*c1+(219.3*sqrt(15)/(15*221))*s1+(1.5*cos(t)+0.2*sin(t))/221;% displacement
% Velocity                    
        v =  (1.5/221)*c1-(219.3*sqrt(15)/(15*221))*s1        ; 
        v =  v + sqrt(15)*(1.5/221)*s1+(219.3*15/(15*221))*c1 ;
        v =  v + (-1.5*sin(t)+0.2*cos(t))/221                 ;
%
        y(2) = v ;
%-------------------------------------------------------------------------
