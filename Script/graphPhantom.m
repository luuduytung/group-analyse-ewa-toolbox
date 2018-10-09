clear all;
close all;
addpath('../Utils');
addpath('../AnalysisOp2D');
addpath('../EWA');
% Reconstruct the figure 2 in the paper.

% 2D Image.
theta0 = phantom;
theta0 = theta0(49:208,49:208);

% LMC Parameters.
% For semiFBLMC.
h=1e-5; Linit = []; LMCParam = struct('G',2,'h',h,'gamma',h/2,'T',1000,'Linit',Linit,'method','semiFBLMC');
% For FBLMC.
% h=2e-8; Linit = zeros(size(D(theta0))); LMCParam = struct('G',2,'h',h,'gamma',h/2,'T',1000,'Linit',Linit,'method','FBLMC');

% Construct the problem of estimation and set the posterior paramaters.
problem = '2D'; n = 9*numel(theta0)/16;
options = settings(theta0,LMCParam,n,problem);

% Estimate by EWA.
thetahat = EWA(options);

% Display.
set(0,'defaulttextinterpreter','latex')
figure(1)
colormap('gray');
subplot(1,2,1);
imagesc(theta0);axis image;axis off
set(gca,'FontSize',5)
h=title('(a) Original image');
set(h,'FontSize',10);
subplot(1,2,2);
imagesc(thetahat(:,:,1));axis image;axis off
set(gca,'FontSize',5)
h=title('(b) EWA estimated image');
set(h,'FontSize',10);

