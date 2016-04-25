clear all
close all
clc
% metodo 'naive' :D

% trabalho 1 de reconhecimento de padroes

% le o arquivo csv
ret = cstrdataread('X_normal.csv',';','normal');

% gera o vetor X
X = ret.X;

% centraliza
Xc = X-repmat(mean(X),size(X,1),1);

% covariancia
sigma = cov(Xc);

% autovalores
[phi,lamb] = eig(sigma);

% encontra o Y
Y = Xc * phi;

% plota os pontos 2D
%scatter(Y(:300,17),Y(:300,18));
%scatter(Y(301:,17),Y(301:,18),'r');

N = [];
F = [];

for i = 1 : length(X)
    if( strcmp(ret.clss(i),'normal') )
        N = [N; Y(i,:)];
    else
        F = [F; Y(i,:)];
    end
end

figure
hold on
a = N(:,17:18); % as melhores características são a 17 e 18 para todas as amostras na classe normal
% b = F(:,17:18);  não ha falhas
scatter(a(:,1), a(:,2), 4);
% scatter(b(:,1), b(:,2), 4, 'r');
grid on;
gaussPlot2d(mean(a)',lamb(17:18,17:18) , 'b'); % plota a gausiana distancia de mahalanobis para um certo nível de significância.
title('Pontos das componentes principais');
legend('Normal');
print -dpdf pontos2d_normal.pdf 
hold off

% aqui começa o cálculo da T2

xt2 = [];
yt2 = [];

for i = 1 : length(Y)
  xt2 = [xt2; i];
  yt2 = [yt2; Y(i,:) * inv(lamb) * Y(i,:)'];
end

figure
plot(xt2,yt2);
title('Variação de T2 no tempo');
grid on;
print -dpdf T2_tempo_normal.pdf 

%  % t2?
%  figure
%  T2 = Y * inv (lamb) * Y';
%  image(T2);
%  
%  %scatter(F(301:,17),Y(301:,18),'r');

    
        