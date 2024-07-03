% Define the function representing the system of equations
fun = @(T) [
    (T(2) + T(3) + 2865)/7 - T(1);
    (T(1) + 2*T(4) + 2865)/8 - T(2);
    (T(1) + 2*T(4) + T(6))/4 - T(3);
    (T(2) + T(3) + T(5) + T(7))/4 - T(4);
    (2*T(4) + 2*T(8))/4 - T(5);
    (T(2) + T(3) + 456.2 - 0.3645 * 10^(-9) * T(6)^(4))/3.5 - T(6);
    (2*T(4) + T(6) + T(8) + 912.4 - 0.729 * 10^(-9) * T(7)^(4))/7 - T(7);
    (2*T(5) + T(7) + T(9) + 912.4 - 0.729 * 10^(-9) * T(8)^(4))/7 - T(8);
    (T(8) + 456.2 - 0.3645 * 10^(-9) * T(9)^(4))/2.5 - T(9)
];

% Initial guess
T0 = zeros(9, 1);
% Iteration options
options = optimoptions('fsolve', 'Display', 'iter');
% Solve the system of equations
T = fsolve(fun, T0, options);
% Display the solutions
fprintf('T1 = %.1f K = %.1f°C\n', T(1), T(1) - 273.15);
fprintf('T2 = %.1f K = %.1f°C\n', T(2), T(2) - 273.15);
fprintf('T3 = %.1f K = %.1f°C\n', T(3), T(3) - 273.15);
fprintf('T4 = %.1f K = %.1f°C\n', T(4), T(4) - 273.15);
fprintf('T5 = %.1f K = %.1f°C\n', T(5), T(5) - 273.15);
fprintf('T6 = %.1f K = %.1f°C\n', T(6), T(6) - 273.15);
fprintf('T7 = %.1f K = %.1f°C\n', T(7), T(7) - 273.15);
fprintf('T8 = %.1f K = %.1f°C\n', T(8), T(8) - 273.15);
fprintf('T9 = %.1f K = %.1f°C\n', T(9), T(9) - 273.15);

% Constants
hi = 70; % W/m^2*K
ho = 21; % W/m^2*K
epsilon = 0.9;
sigma = 5.67e-8; % W/m^2*K^4
To = 293;
Tw_out = (0.5 * T(6) + T(7) + T(8) + 0.5 * T(9)) / 3;
% Average temperature at the outer surface of the chimney
T_wall_out_avg = Tw_out;
fprintf('Average temperature at the outer surface of the chimney: %.2f K\n', T_wall_out_avg);
% Area calculations
Ai = 4 * 0.2 * 1; % Inner wall area
Ao = 4 * 0.6 * 1; % Outer wall area
Aosk = 4 * 0.6 * 1; % Outer wall area for outer surface heat transfer

% Rate of heat loss through the 1-m-long section of the chimney
Q_chimney = ho * Ao * (Tw_out - To);

% Display the results
fprintf('Rate of heat loss through the chimney: %.2f W\n', Q_chimney);
