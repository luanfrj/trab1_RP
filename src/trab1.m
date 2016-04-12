
% metodo 'naive' :D

% trabalho 1 de reconhecimento de padroes

% le o arquivo csv
cstrdataread('X.csv',';','normal');

% gera o vetor X
X = ans.X

% centraliza
Xc = X-repmat(mean(X),size(X,1),1);

% covariancia
sigma = cov(Xc);

% autovalores
[phi,lamb] = eig(sigma);

% encontra o Y
Y = Xc * phi;

% plota os pontos 2D
scatter(Y(:,17),Y(:,18));