clear, close all;

G = zpk([], [0, -0.4], 1);

z = -0.35;
p = -5;
D = zpk(z, p, 1);

rlocus(D*G)
hold on

% Plot requirements
figure(1)
theta_min = 0.4668;
omega_n_min = 3.6;
x = 0:-1:-100;
theta = linspace(pi/2, 3*pi/2, 100);

plot(x, -cot(theta_min)*x, 'k')
plot(x, cot(theta_min)*x, 'k')
plot(omega_n_min * cos(theta), omega_n_min * sin(theta), 'k')
hold off

% Decide on a gain from root locus
K = 20;

% Convert G(s) to G(z)
sample_rate = 4; % Sample rate in Hz
T = 1 / sample_rate;
discrete_plant = c2d(G, T);

% Convert D(s) to D(z)
continuous_compensator = K * D;
discrete_compensator = c2d(continuous_compensator, T, 'mapped')

% Calculate closed loop TFs
H_continuous = (K*D*G)/(1+K*D*G); % Closed loop TF
H_discrete = (discrete_compensator*discrete_plant) / (1 + discrete_compensator*discrete_plant);

figure(2);
step(H_continuous, H_discrete);
hold on
xline(0.5)



