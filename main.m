% Signal

close all;
clear all;
clc;

dT = 0.05;
F = [1 dT; 0 1];
H = [1 0];

x0 = [0;0];
sigma_a = 0.2;

Q = sigma_a^2;
R = 0.01;

N = 100;

a = rand(1, N)*sigma_a;

x_h(:,1) = x0;
P(:,1) = [Q;Q];

K(:,1) = P(:,1)*H*(H*P(:,1)*H+R)';

for t=1:N
    % update step
    x_h(:,t) = x_h(:,t) + K(:,t) * (a(t) - H*x_h(:,t));
    P(:,t) = P(:,t) - K(:,t) *H*P(:,t);
    K(:,t+1) = P(:,t)*H*(H*P(:,t)*H+R)';

    % prediction step
    x_h(:,t+1) = F*x_h(:,t);
    P(:,t+1) = F*P(:,t) + Q;    
    
end

figure;
plot(log(K(1,:)), 'r');
hold on;
plot(log(P(1,:)), 'b');
grid on;
hold off;

figure;
plot(a, 'r');
hold on;
plot(x_h(1,:), 'b');
grid on;
hold off;

