%1.1 plot theta1, theta 2 and theta 3 over n

% a) find theta1
mean_val = 2;
stand_dev_val = 1;

% n1= 10, 100, 1000, 10000
%n= linspace(10,100000,100);
%n = [10,100,200,300,400,500,600,700,800,900,1000,2000,3000,4000,5000,6000,10000];
n = 10.^[1:7];
theta1_hat_all = zeros(length(n),1);
for i = 1:length(n)
    n1 = n(i);
    %samples_x = mean_val + (stand_dev_val * randn(n1,1));
    %samples_y = mean_val + (stand_dev_val * randn(n1,1));

    samples_x = normrnd(mean_val,stand_dev_val,1,n1);
    samples_y = normrnd(mean_val,stand_dev_val,1,n1);

    theta1_hat = (1/n1)*sum(sqrt((samples_x.^2)+(samples_y.^2)));
    theta1_hat_all(i) = theta1_hat;
end

% a) find theta2
mean_val = 0;
stand_dev_val = 1;

% n1= 10, 100, 1000, 10000
%n= linspace(10,100000,100);
theta2_hat_all = zeros(length(n),1);
ess2_val = zeros(length(n),1);

for i = 1:length(n)
    n1 = n(i);
    %samples_x = mean_val + (stand_dev_val * randn(n1,1));
    %samples_y = mean_val + (stand_dev_val * randn(n1,1));

    samples_x = normrnd(mean_val,stand_dev_val,1,n1);
    samples_y = normrnd(mean_val,stand_dev_val,1,n1);

    
    tmp_pi = (samples_x - 2).^2 + (samples_y - 2).^2;
    tmp_g = (samples_x).^2 + (samples_y).^2;
    
    pi_val = (exp(tmp_pi.*(-1/2))).*(1/(2*pi));
    g_val = (exp(tmp_g.*(-1/2))).*(1/(2*pi));
    weight_vec = pi_val./g_val;
    
    weight_mean = mean(weight_vec);
    var_weight = sum((weight_vec - weight_mean).^2) / (n1-1);
    ess2_val(i) = n1/(1+var_weight);
    
    
    theta2_hat = (1/n1)*sum(weight_vec .* sqrt((samples_x.*samples_x)+(samples_y.*samples_y)));
    theta2_hat_all(i) = theta2_hat;
end

% a) find theta3
mean_val = 0;
stand_dev_val = 4;

% n1= 10, 100, 1000, 10000
%n= linspace(10,100000,100);
theta3_hat_all = zeros(length(n),1);
ess3_val = zeros(length(n),1);

for i = 1:length(n)
    n1 = n(i);
    %samples_x = mean_val + (stand_dev_val * randn(n1,1));
    %samples_y = mean_val + (stand_dev_val * randn(n1,1));

    samples_x = normrnd(mean_val,stand_dev_val,1,n1);
    samples_y = normrnd(mean_val,stand_dev_val,1,n1);
    
    tmp_pi = (samples_x - 2).^2 + (samples_y - 2).^2;
    tmp_g = (samples_x).^2 + (samples_y).^2;
    
    pi_val = (exp(tmp_pi.*(-1/2))).*(1./(2*pi));
    g_val = (exp(tmp_g.*(-1/32))).*(1./(2*pi*stand_dev_val));
    weight_vec = pi_val./g_val;
    
    weight_mean = mean(weight_vec);
    var_weight = sum((weight_vec - weight_mean).^2) / (n1-1);
    ess3_val(i) = n1/(1+var_weight);
    
    theta3_hat = (1/n1)*sum(weight_vec .* sqrt((samples_x.*samples_x)+(samples_y.*samples_y)));
    theta3_hat_all(i) = theta3_hat;
end

%plot(n,log(theta1_hat_all),n,log(theta2_hat_all),n,log(theta3_hat_all))
figure;
semilogx(n,theta1_hat_all,n,theta2_hat_all,n,theta3_hat_all);
xlabel('n'); ylabel('theta value');
legend('theta 1','theta 2','theta 3')

%plot(n,theta1_hat_all,n,theta2_hat_all,n,theta3_hat_all)
figure;
plot(n,ess2_val);
xlabel('ess*(theta 2)'); ylabel('ess(theta 2)');
figure;
plot(n,ess3_val);
xlabel('ess*(theta 3)'); ylabel('ess(theta 3)');
