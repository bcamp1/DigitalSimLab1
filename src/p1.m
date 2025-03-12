clear, close all;

G = zpk([], [0, -0.4], 1);

z = -4;
p = -30;
k = 1;

D = zpk(z, p, k);

OpenLoop = D*G;

rlocus(OpenLoop)
hold on

% Plot requirements
theta_min = 0.4668;
omega_min = 3.6;
x = 0:-1:-100;
theta = linspace(pi/2, 3*pi/2, 100);

plot(x, -cot(theta_min)*x, 'k')
plot(x, cot(theta_min)*x, 'k')
plot(omega_min * cos(theta), omega_min * sin(theta), 'k')
hold off

% Convert G(s) to G(z)
sample_rate = 10; % Sample rate in Hz
T = 1 / sample_rate;
exp_term = exp(-0.4*T);
num = [6.25 + 6.25*exp_term + 2.5*T - 13.5, 6.25-2.5*T*exp_term-6.25*exp_term];
denom = [1, -exp_term - 1, exp_term];
G_z = tf(num, denom, T)
G_z2 = c2d(G, T)

step(G, G_z2)


