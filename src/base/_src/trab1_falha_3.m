clear all
close all
clc
% metodo 'naive' :D

% trabalho 1 de reconhecimento de padroes

% le o arquivo csv
ret = cstrdataread('X.csv',';','normal');

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
a = N(:,17:18); % as melhores caracteristicas sao a 17 e 18 para todas as amostras na classe normal
b = F(:,17:18); 
scatter(a(:,1), a(:,2), 4);
scatter(b(:,1), b(:,2), 4, 'r');
legend('Normal','Falha 3');

%calcula os outros sigma para fins de plotagem...
sig_a = cov(N);
sig_b = cov(F);

grid on;
gaussPlot2d(mean(a)',sig_a(17:18,17:18) , 'b'); % plota a gausiana distancia de mahalanobis para um certo nivel de signific ncia.
gaussPlot2d(mean(b)',sig_b(17:18,17:18) , 'r');
%title('Pontos das componentes principais');

print -dpdf figs/pontos2d.pdf 
hold off

% aqui comeca o calculo da T2

xt2 = [];
yt2 = [];

inv_lamb = inv(lamb);
for i = 1 : length(Y)
  xt2 = [xt2; i];
  yt2 = [yt2; Y(i,:) * inv_lamb * Y(i,:)'];
end

figure
plot(xt2,yt2);
xlim([min(xt2) max(xt2)])
%title('Variacao de T2 no tempo');
grid on;

print -dpdf figs/T2_tempo.pdf 

%  % t2?
%  figure
%  T2 = Y * inv (lamb) * Y';
%  image(T2);
%  
%  %scatter(F(301:,17),Y(301:,18),'r');

    
        