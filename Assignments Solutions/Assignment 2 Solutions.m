% Constants
L = 1; % length of the pipe in meters
T1 = 100; % temperature of the outer surface of the pipe in degrees Celsius
T_inf = 25; % temperature of the surrounding medium in degrees Celsius
h = 10; % convection heat transfer coefficient in W/(m^2*K)
k = 0.5; % thermal conductivity of the insulation in W/(m*K)
r1 = 3.5 * 10^(-2); % outer radius of the pipe in meters
r2 = 7.0 * 10^(-2); % maximum outer radius of the insulation in meters
% Range of r values from r1 to some r2
r_values = linspace(r1, r2, 100);
% Calculate heat transfer for each radius value
Q_values = zeros(size(r_values));
for i = 1:length(r_values)
    Q_values(i) = heat_transfer_vs_radius(r_values(i), r1, k, h, T1, T_inf, L);
end
% Find the critical insulation thickness point
[Qmax, index] = max(Q_values);
critical_thickness = r_values(index);
% Plotting Q dot vs r
plot(r_values, Q_values, 'LineWidth', 2.5,'Color', "g");
hold on;
scatter(critical_thickness,Qmax,100,"magenta","filled");
hold off;
xlabel('Radius (metres)');
ylabel('Heat Transfer (Wattts)');
title('Heat Transfer vs. Radius');
grid on;
legend('Heat Transfer', ['Critical Radius Of Insulation:' num2str(critical_thickness) 'm'], 'Location', 'northwest');
function Q = heat_transfer_vs_radius(r, r1, k, h, T1, T_inf, L)
    % Calculate thermal resistances
    R_insulation = log(r / r1) / (2 * pi * L * k);
    R_convective = 1 / (h * 2 * pi * r * L);
    % Total thermal resistance
    R_total = R_insulation + R_convective;
    % Heat transfer
    Q = (T1 - T_inf) / R_total;
end
