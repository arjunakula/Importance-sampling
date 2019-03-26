clear;clc;close all;


n = 10.^[1:7];
% n = [10:10:100,200:100:1000,2000:1000:10000, 20000:10000:100000, 200000:100000:1000000];
theta = zeros(3,length(n));

h = @(x,y) sqrt(x.^2 + y.^2);
pi_xy = @(x,y) exp(-0.5.*((x-2).^2+(y-2).^2))./(2*pi);

% theta 1
mu1 = 2; sigma1 = 1;
cnt = 1;
for i = n
    x = normrnd(mu1,sigma1,1,i);
    y = normrnd(mu1,sigma1,1,i);
    theta(1,cnt) = sum(h(x,y))/i;
    cnt = cnt+1;
end


% theta 2
mu2 = 0; sigma2 = 1;
cnt = 1;
g = @(x,y) exp(-(1/(2*sigma2^2)).*(x.^2+y.^2))./(2*pi*sigma2^2);
w = @(x,y) pi_xy(x,y)./g(x,y);
for i = n
    x = normrnd(mu2,sigma2,1,i);
    y = normrnd(mu2,sigma2,1,i);
    theta(2,cnt) = sum(w(x,y).*h(x,y)) / i;
    w_mean = mean(w(x,y));
    var_w = sum((w(x,y) - w_mean).^2 ./ mean(w(x,y).^2)) / (i-1);
    ess2(cnt) = i/(1+var_w);
    cnt = cnt+1;
end


% theta 3
mu3 = 0; sigma3 = 4;
cnt = 1;
g = @(x,y) exp(-(1./(2*sigma3^2)).*(x.^2+y.^2))./(2*pi*sigma3^2);
w = @(x,y) pi_xy(x,y)./g(x,y);
for i = n
    x = normrnd(mu3,sigma3,1,i);
    y = normrnd(mu3,sigma3,1,i);
    theta(3,cnt) = sum(w(x,y).*h(x,y)) / i;
    w_mean = mean(w(x,y));
    var_w = sum((w(x,y) - w_mean).^2 ./ mean(w(x,y).^2)) / (i-1);
    ess3(cnt) = i/(1+var_w);
    cnt = cnt+1;
    
end
figure;
semilogx(n,theta(1,:),n,theta(2,:),n,theta(3,:));
xlabel('n'); ylabel('theta');
legend('theta_1','theta_2','theta_3')

figure;
plot(n,ess2);
xlabel('ess*(theta_2)'); ylabel('ess(theta_2)');
figure;
plot(n,ess3);
xlabel('ess*(theta_3)'); ylabel('ess(theta_3)');
