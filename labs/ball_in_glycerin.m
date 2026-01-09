
% Simulation of a ball falling through a viscous fluid (glycerin)
%
% This script models the motion of a sphere under the influence of gravity,
% buoyancy, and viscous drag. It calculates the position, velocity, and
% acceleration over time and provides an animated visualization of the process.

% --- Initialization ---
clear all;
close all;
clc;

% --- Physical Constants and Parameters ---
% Environment
g = 9.81; % Acceleration due to gravity (m/s^2)

% Fluid Properties (Glycerin at approx. 20°C)
rho_fluid = 1261; % Density of glycerin (kg/m^3)
eta = 1.41;       % Dynamic viscosity of glycerin (Pa·s or kg/(m·s))

% Ball Properties (Glass Marble)
r = 0.01;         % Radius of the ball (m)
rho_ball = 2500;  % Density of glass (kg/m^3)
V = (4/3)*pi*r^3; % Volume of the ball (m^3)
m = rho_ball * V; % Mass of the ball (kg)

% --- Simulation Setup ---
t_max = 15;       % Maximum simulation time (s), increased for slower fall
dt = 0.02;        % Time step (s)
t = 0:dt:t_max;   % Time vector

% Pre-allocate arrays for efficiency
y = zeros(size(t)); % Position (y=0 at the top)
v = zeros(size(t)); % Velocity
a = zeros(size(t)); % Acceleration

% --- Initial Conditions ---
y(1) = 0; % Initial position (m)
v(1) = 0; % Initial velocity (m/s)

% --- Forces ---
% These forces are constant throughout the simulation
Fg = m * g;              % Force of gravity (downwards)
Fb = rho_fluid * V * g;  % Buoyant force (upwards)

% --- Numerical Simulation (Euler's Method) ---
% This loop calculates the state of the ball at each time step.
for i = 1:length(t)-1
    % 1. Calculate the net force
    % The drag force depends on the current velocity
    Fd = 6 * pi * eta * r * v(i); % Stokes' drag force (upwards)
    
    % Net force (positive direction is downwards)
    F_net = Fg - Fb - Fd;
    
    % 2. Calculate acceleration from Newton's 2nd Law (F=ma)
    a(i) = F_net / m;
    
    % 3. Update velocity for the next time step
    v(i+1) = v(i) + a(i) * dt;
    
    % 4. Update position for the next time step
    % Stop the ball if it hits the bottom of the cylinder (1m)
    if y(i) >= 1.0
        y(i+1) = 1.0;
        v(i+1) = 0;
    else
        y(i+1) = y(i) + v(i) * dt;
    end
end
% Calculate acceleration for the last time step for plotting
a(end) = (Fg - Fb - 6*pi*eta*r*v(end)) / m;


% --- Visualization ---

% Animation of the falling ball
figure('Name', 'Lab Simulation: Ball in Graduated Cylinder');
% Define plot update frequency to speed up animation
plot_step = 5; % Update plot every 5th simulation step to speed up animation

% Arrow scaling factors for better visualization
vel_scale = 1.2;
accel_scale = 0.02;
cylinder_height = 1.0; % 1 meter tall cylinder
cylinder_width = 0.1;

for i = 1:plot_step:length(t)
    clf; % Clear the figure for the new frame
    hold on;
    
    % Set up the plot to look like a graduated cylinder
    axis([-cylinder_width cylinder_width -cylinder_height-0.05 0.05]);
    set(gca, 'XTick', []); % Hide x-axis ticks
    ylabel('Depth (m)');
    title(sprintf('Time: %.2f s', t(i)));
    grid on;
    
    % Draw the cylinder filled with glycerin
    rectangle('Position', [-cylinder_width/2, -cylinder_height, cylinder_width, cylinder_height], 'FaceColor', [0.9 0.95 1.0], 'EdgeColor', 'k');
    
    % Draw measurement markings on the cylinder
    for mark = 0:0.1:cylinder_height
        plot([-cylinder_width/2, cylinder_width/2], [-mark, -mark], 'Color', [0.6 0.6 0.8], 'LineWidth', 0.5);
        text(cylinder_width/2 + 0.01, -mark, sprintf('%.1f', mark), 'VerticalAlignment', 'middle');
    end
    
    % Draw the ball
    plot(0, -y(i), 'o', 'MarkerSize', 12, 'MarkerFaceColor', [0.2 0.8 0.2], 'MarkerEdgeColor', 'k');
    
    % Draw the velocity vector arrow (blue)
    h_vel = quiver(0.03, -y(i), 0, -v(i)*vel_scale, 0, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.5);
    
    % Draw the acceleration vector arrow (red)
    h_accel = quiver(-0.03, -y(i), 0, -a(i)*accel_scale, 0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.5);
    
    % Add a legend
    legend([h_vel, h_accel], ...
           sprintf('Velocity: %.3f m/s', v(i)), ...
           sprintf('Acceleration: %.3f m/s^2', a(i)), ...
           'Location', 'SouthEast');
    
    hold off;
    
    % Force the plot to draw
    drawnow;
    
    % Pause to create animation effect
    pause(dt);
end

% Static plots for analysis
figure('Name', 'Simulation Results');

% Subplot 1: Position vs. Time
subplot(3,1,1);
plot(t, y, 'b-', 'LineWidth', 2);
title('Position vs. Time');
xlabel('Time (s)');
ylabel('Position (m)');
grid on;

% Subplot 2: Velocity vs. Time
subplot(3,1,2);
plot(t, v, 'g-', 'LineWidth', 2);
title('Velocity vs. Time');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
grid on;
% Draw a line for terminal velocity
hold on;
terminal_velocity = (Fg - Fb) / (6 * pi * eta * r);
plot([t(1), t(end)], [terminal_velocity, terminal_velocity], 'r--', 'LineWidth', 1.5);
legend('Velocity', 'Terminal Velocity');
hold off;

% Subplot 3: Acceleration vs. Time
subplot(3,1,3);
plot(t, a, 'm-', 'LineWidth', 2);
title('Acceleration vs. Time');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
grid on;

