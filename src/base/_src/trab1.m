clear all
close all
clc
% metodo 'naive' :D

% trabalho 1 de reconhecimento de padroes

% le o arquivo csv
ret = cstrdataread('Xf3.csv',';','normal');

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
hold on
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

hold on

%a = N(:,16:18);
%b = F(:,16:18);
%scatter3(a(:,1), a(:,2), a(:,3), 4);
%scatter3(b(:,1), b(:,2), b(:,3),4, 'r');
%grid on;
%legend('Normal','Falha 3');
%scatter(F(301:,17),Y(301:,18),'r');

t2 = [];
inv_lamb = inv(lamb);
for i = 1 : length(Y)
    novo_elem = Y(i,:) * inv_lamb * Y(i,:)';
    t2 = [t2; novo_elem];
end
