%%Look for the best model%%%%

data=importdata('data.txt'); % one dimensional data set of a size Nx1
h=histogram(data,'NumBins',101,'EdgeColor','None');
hX=h.BinEdges+h.BinWidth/2;% histogram uses bin centers when plotting!
hX=transpose(hX(1:end-1)); % last bin has both left and right edge.
hY=transpose(h.Values);

options = statset('MaxIter',1000);
NGaussians=10;
BIC = zeros(1,NGaussians);
GModel = cell(1,NGaussians);
 for k = 1:NGaussians
     GModel{k} = fitgmdist(data,k,'Options',options);
     BIC(k)= GModel{k}.BIC;
 end

[minBIC,numComponents] = min(BIC);
BestModel = GModel{numComponents}
%% 

%% display the best model according to BIC
f = pdf(BestModel,hX);
f=f*(length(data)*h.BinWidth); %un-normalize gaussian distribution
hold on
plot(hX,f,'LineWidth',2,'Color',[0,0,0])
xlim([0 1]);
xlabel('observable','Fontsize',17);
ylabel('counts','Fontsize',17);

GModel
 %% 

 %%%%%%%%1Gaussian%%%
clc
clear all
close all
 
data=importdata('data.txt'); % one dimensional data set of a size Nx1
h=histogram(data,'NumBins',101,'EdgeColor','None','FaceColor', [0.8,0.8,0.8]);
hX=h.BinEdges+h.BinWidth/2;% histogram uses bin centers when plotting!
hX=transpose(hX(1:end-1)); % last bin has both left and right edge.
hY=transpose(h.Values);
 
NGaussians=1;
options = statset('MaxIter',1000);
GModel = fitgmdist(data,NGaussians,'Options',options);
f = pdf(GModel,hX);
f=f*(length(data)*h.BinWidth); %un-normalize gaussian distribution
hold on
plot(hX,f,'LineWidth',2,'Color',[0,0,0])
text(0.05,600,sprintf('\\mu = %.4f\t x = %.2f',GModel.mu,GModel.ComponentProportion),'FontSize',12);
xlim([0 1]);
xlabel('observable','Fontsize',17);
ylabel('counts','Fontsize',17);
SEM=sqrt(GModel.Sigma(:,:,1)/length(data)); %standard error of the mean
%title(['SEM= ',num2str(SEM,'%.5f')],'FontWeight','Normal')

saveas(gcf,'GMM_fit_Ng1.png')
saveas(gcf,'GMM_fit_Ng1.svg')

 
GModel

%% 
%%%%%2Gaussians
clc
clear all
close all
 
data=importdata('data.txt'); % one dimensional data set of a size Nx1
h=histogram(data,'NumBins',101,'EdgeColor','None','FaceColor', [0.8,0.8,0.8]);
hX=h.BinEdges+h.BinWidth/2;% histogram uses bin centers when plotting!
hX=transpose(hX(1:end-1)); % last bin has both left and right edge.
hY=transpose(h.Values);

NGaussians=2;
options = statset('MaxIter',1000);
GModel = fitgmdist(data,NGaussians,'Options',options);
f = pdf(GModel,hX);
f=f*(length(data)*h.BinWidth); %un-normalize gaussian distribution
hold on
plot(hX,f,'LineWidth',2,'Color',[0,0,0])
text(0,600,sprintf('\\mu_{1} = %.4f\t   x_{1}= %.2f\n\\mu_{2} = %.4f\t   x_{2}= %.2f',GModel.mu(1),GModel.ComponentProportion(1),GModel.mu(2),GModel.ComponentProportion(2)),'FontSize',12);
xlim([0 1]);
xlabel('observable','Fontsize',17);
ylabel('counts','Fontsize',17);
hold on
g1=GModel.ComponentProportion(1)*normpdf(hX,GModel.mu(1),sqrt(GModel.Sigma(:,:,1)))*(length(data)*h.BinWidth);
plot(hX,g1,'r--','LineWidth',2)
g2=GModel.ComponentProportion(2)*normpdf(hX,GModel.mu(2),sqrt(GModel.Sigma(:,:,2)))*(length(data)*h.BinWidth);
plot(hX,g2,'b--','LineWidth',2)
legend('Data','GMM','Gaussian1','Gaussian2');
SEM_g1=sqrt(GModel.Sigma(:,:,1)/length(data)); %standard error of the mean
SEM_g2=sqrt(GModel.Sigma(:,:,2)/length(data));
% title({['SEM (Gaussian1)= ',num2str(SEM_g1,'%.5f')]
%       ['SEM (Gaussian2)= ',num2str(SEM_g2,'%.5f')]},'FontWeight','Normal')

saveas(gcf,'GMM_fit_Ng2.png')
saveas(gcf,'GMM_fit_Ng2.svg')


GModel

%% 

%%%3gaussians
clc
clear all
close all

data=importdata('data.txt'); % one dimensional data set of a size Nx1
h=histogram(data,'NumBins',101,'EdgeColor','None', 'FaceColor', [0.8,0.8,0.8]);
hX=h.BinEdges+h.BinWidth/2;% histogram uses bin centers when plotting!
hX=transpose(hX(1:end-1)); % last bin has both left and right edge.
hY=transpose(h.Values);

NGaussians=3;
options = statset('MaxIter',1000);
GModel = fitgmdist(data,NGaussians,'Options',options);
f = pdf(GModel,hX);
f=f*(length(data)*h.BinWidth); %un-normalize gaussian distribution
hold on
plot(hX,f,'LineWidth',2,'Color',[0,0,0])
text(0.05,600,sprintf('\\mu_{1} = %.4f\t   x_{1}= %.2f\n\\mu_{2} = %.4f\t   x_{2}= %.2f\n\\mu_{3} = %.4f\t   x_{3}= %.2f',GModel.mu(1),GModel.ComponentProportion(1),GModel.mu(2),GModel.ComponentProportion(2),GModel.mu(3),GModel.ComponentProportion(3)),'FontSize',12);
xlim([0 1])
xlabel('observable','Fontsize',17);
ylabel('counts','Fontsize',17);
hold on
g1=GModel.ComponentProportion(1)*normpdf(hX,GModel.mu(1),sqrt(GModel.Sigma(:,:,1)))*(length(data)*h.BinWidth);
plot(hX,g1,'r--','LineWidth',2)
g2=GModel.ComponentProportion(2)*normpdf(hX,GModel.mu(2),sqrt(GModel.Sigma(:,:,2)))*(length(data)*h.BinWidth);
plot(hX,g2,'b--','LineWidth',2)
g3=GModel.ComponentProportion(3)*normpdf(hX,GModel.mu(3),sqrt(GModel.Sigma(:,:,3)))*(length(data)*h.BinWidth);
plot(hX,g3,'g--','LineWidth',2)
legend('Data','GMM','Gaussian1','Gaussian2','Gaussian3')
legend boxoff
SEM_g1=sqrt(GModel.Sigma(:,:,1)/length(data)); %standard error of the mean
SEM_g2=sqrt(GModel.Sigma(:,:,2)/length(data));
SEM_g3=sqrt(GModel.Sigma(:,:,3)/length(data));
%title({['SEM (Gaussian1)= ',num2str(SEM_g1,'%.5f')]
%       ['SEM (Gaussian2)= ',num2str(SEM_g2,'%.5f')]
%       ['SEM (Gaussian3)= ',num2str(SEM_g3,'%.5f')]},'FontWeight','Normal')

saveas(gcf,'GMM_fit_Ng3.png')
saveas(gcf,'GMM_fit_Ng3.svg')


GModel
