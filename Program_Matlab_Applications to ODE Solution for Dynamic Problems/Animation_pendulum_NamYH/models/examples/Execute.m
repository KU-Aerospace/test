% clear all;close all;clc;

package_setup;

%Results_Long_Loop_Simulation;
%Results_Linear_Simulation;
%Results_Slalom_Simulation;
%Nocp_out_HV;

% load('RTO_10hor_10seg.mat');

%Data Selection
xpos=17;
ypos=18;
zpos=19;
piepos=14;
thepos=15;
psipos=16;
% xpos=10+2;
% ypos=11+2;
% zpos=12+2;
% piepos=7+2;
% thepos=8+2;
% psipos=9+2;
%a=CTOV40H20;
% a=Result;
% a(:,psipos)=a(:,psipos)-90
d2r=pi/180;
aa=[0:5:180];
data(1:37,1)=0.0;
data(1:37,2)=0.0;
data(1:37,3)=0.0;
data(1:37,4)= 0.0;
data(1:37,5)= (aa*d2r);
data(1:37,6)= 0.0;

%  Model Import('pendulum.obj');
%    model_import('pendulum.obj','output','pendulum.mat');
%    model_show('pendulum.mat','output','model.png','dpi',600); %Model Print Out
%    model_show('pendulum.mat','animate','on','output','pendulum.gif'); %Model Animate

% new_object('tbm.mat',data,...
%     'model','pendulum.mat','scale',1.0,...
%     'path','on','pathcolor',[.89 .0 .27],'face',[.16 0.10 .10]);

flypath('tbm.mat',... 
    'animate','on','step',1.0,...
    'axis','on','axiscolor',[0 0 0],'color',[1 1 1],...
    'font','Georgia','fontsize',14,...
    'view',[0 90],'window',[480 480],...
    'xlim',[-30 30],'ylim',[-30 30],'zlim',[0 10],...
    'output','pendulum.gif','dpi',2000);