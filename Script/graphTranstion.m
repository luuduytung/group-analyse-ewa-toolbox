clear all;
close all;
addpath('../Utils');
addpath('../EWA');
% Reconstruct the figure 1 in the paper.

% Create the transition matrices.
G0 = 1; G = 1; mattransition11 = matTransition(G0,G);
G0 = 1; G = 4; mattransition14 = matTransition(G0,G);
G0 = 4; G = 1; mattransition41 = matTransition(G0,G);
G0 = 4; G = 4; mattransition44 = matTransition(G0,G);

% Create the examples of estimation.
n = 64; M = 128; nb = 1; problem = '1D'; 
Linit = zeros(M,1); LMCParam = struct('T',3500,'Linit',Linit,'method','FBLMC');
S = 4; G0 = 1; tabtheta0 = simulateSignal(M,S,nb,G0); theta0 = tabtheta0{1};
LMCParam.G = 1; options = settings(theta0,LMCParam,n,problem); thetahat11 = EWA(options);
LMCParam.G = 4; options = settings(theta0,LMCParam,n,problem); thetahat14 = EWA(options);
S = 8; G0 = 4; tabtheta0 = simulateSignal(M,S,nb,G0); theta0 = tabtheta0{1};
LMCParam.G = 1; options = settings(theta0,LMCParam,n,problem); thetahat41 = EWA(options);
LMCParam.G = 4; options = settings(theta0,LMCParam,n,problem); thetahat44 = EWA(options);

% Display phase diagrams.
set(0,'defaulttextinterpreter','latex')
colormap('gray');
figure(1)
subplot(4,8,[1 2 9 10]);
pcolor(S/M,n/M,mattransition11');shading interp; axis image;
hold on
[c,h]=contour(S/M,n/M,mattransition11',[0.45 0.55]);
set(h,'Visible','off')
plot(c(1,2:end/2),polyval(polyfit(c(1,2:end/2),c(2,2:end/2),1),c(1,2:end/2)),'b','LineWidth',2);
axis([S(1)/M 1 n(1)/M 1])
hold off
hx=xlabel('$S/M$');ylabel('$n/M$');
pos=hx.Position;
text(pos(1),2*pos(2),'(a)')
set(gca,'FontSize',5)
h=title('$G_{\theta_0}=1$, $G=1$');
set(h,'FontSize',8);
hc=colorbar;
set(hc,'Location','NorthOutside','Position',[0.21 0.475 0.1758 0.05]);
text(0.85,-0.25,'$\pi_{S,n}$')

subplot(4,8,[3 4 11 12]);
pcolor(S/M,n/M,mattransition14');shading interp; axis image;
hold on
[c,h]=contour(S/M,n/M,mattransition14',[0.45 0.55]);
set(h,'Visible','off')
plot(c(1,2:end/2),polyval(polyfit(c(1,2:end/2),c(2,2:end/2),1),c(1,2:end/2)),'b','LineWidth',2);
axis([S(1)/M 1 n(1)/M 1])
hold off
hx=xlabel('$S/M$');ylabel('$n/M$');
pos=hx.Position;
text(pos(1),2*pos(2),'(b)')
set(gca,'FontSize',5)
h=title('$G_{\theta_0}=1$, $G=4$');
set(h,'FontSize',8);

subplot(4,8,[17 18 25 26]);
pcolor(S/M,n/M,mattransition41');shading interp; axis image;
hold on
[c,h]=contour(S/M,n/M,mattransition41',[0.45 0.55]);
set(h,'Visible','off')
plot(c(1,2:end/2),polyval(polyfit(c(1,2:end/2),c(2,2:end/2),1),c(1,2:end/2)),'b','LineWidth',2);
axis([S(1)/M 1 n(1)/M 1])
hold off
hx=xlabel('$S/M$');ylabel('$n/M$');
pos=hx.Position;
text(pos(1),2*pos(2),'(c)')
set(gca,'FontSize',5)
h=title('$G_{\theta_0}=4$, $G=1$');
set(h,'FontSize',8);

subplot(4,8,[19 20 27 28]);
pcolor(S/M,n/M,mattransition44');shading interp; axis image;
hold on
[c,h]=contour(S/M,n/M,mattransition44',[0.45 0.55]);
set(h,'Visible','off')
plot(c(1,2:end/2),polyval(polyfit(c(1,2:end/2),c(2,2:end/2),1),c(1,2:end/2)),'b','LineWidth',2);
axis([S(1)/M 1 n(1)/M 1])
hold off
hx=xlabel('$S/M$');ylabel('$n/M$');
pos=hx.Position;
text(pos(1),2*pos(2),'(d)')
set(gca,'FontSize',5)
h=title('$G_{\theta_0}=4$, $G=4$');
set(h,'FontSize',8);

% Display examples.
subplot(4,8,[5 6 7 8]);
stem([thetahat11],'.','k');axis([1 M -0.2 1])
set(gca,'FontSize',5)
xlabel('(a'')','FontSize',10)
h=title('$S=4$, $G_{\theta_0}=1$, $G=1$');
set(h,'FontSize',8);

subplot(4,8,[13 14 15 16]);
stem([thetahat14],'.','k');axis([1 M -0.2 1])
set(gca,'FontSize',5)
xlabel('(b'')','FontSize',10)
h=title('$S=4$, $G_{\theta_0}=1$, $G=4$');
set(h,'FontSize',8);

subplot(4,8,[21 22 23 24]);
stem([thetahat41],'.','k');axis([1 M -0.2 1])
set(gca,'FontSize',5)
xlabel('(c'')','FontSize',10)
h=title('$S=8$, $G_{\theta_0}=4$, $G=1$');
set(h,'FontSize',8);

subplot(4,8,[29 30 31 32]);
stem([thetahat44],'.','k');axis([1 M -0.2 1])
set(gca,'FontSize',5)
xlabel('(d'')','FontSize',10)
h=title('$S=8$, $G_{\theta_0}=4$, $G=4$');
set(h,'FontSize',8);



