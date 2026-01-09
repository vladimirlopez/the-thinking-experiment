% Script to find the extrema of f(x,y) subject to a circular constraint

% --- Initialization ---
clear all;
close all;
clc;

% --- Problem Definition ---
% Define the function f(x,y)
f = @(x, y) x.^3 - 3*x.*y + y.^2;

% --- Parametrize the Constraint ---
% The constraint is x^2 + y^2 = 4, a circle of radius 2.
% We can parametrize it with an angle t.
t = linspace(0, 2*pi, 1000); % Angle from 0 to 2*pi
x_c = 2 * cos(t); % x-coordinates on the circle
y_c = 2 * sin(t); % y-coordinates on the circle

% --- Reduce to 1D and Find Extrema ---
% Evaluate f(x,y) along the constraint circle
f_on_constraint = f(x_c, y_c);

% Find the maximum value and its index
[max_val, max_idx] = max(f_on_constraint);
x_max = x_c(max_idx);
y_max = y_c(max_idx);

% Find the minimum value and its index
[min_val, min_idx] = min(f_on_constraint);
x_min = x_c(min_idx);
y_min = y_c(min_idx);

% --- Display Results ---
fprintf('Analysis of f(x,y) = x^3 - 3xy + y^2 subject to x^2 + y^2 = 4\n');
fprintf('--------------------------------------------------------------------\n');
fprintf('Maximum value: %.4f at (x, y) = (%.4f, %.4f)\n', max_val, x_max, y_max);
fprintf('Minimum value: %.4f at (x, y) = (%.4f, %.4f)\n', min_val, x_min, y_min);

% --- Visualization ---

% 1. Plot f(t) vs t to show the 1D view of the problem
figure('Name', 'Function Value on Constraint Circle');
plot(t, f_on_constraint, 'b-', 'LineWidth', 2);
hold on;
plot(t(max_idx), max_val, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot(t(min_idx), min_val, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
title('f(t) along the constraint circle x=2cos(t), y=2sin(t)');
xlabel('Angle t (radians)');
ylabel('f(t)');
legend('f(t)', 'Maximum', 'Minimum');
grid on;

% 2. Plot the 3D surface and the constraint path
figure('Name', '3D View of Constrained Extrema');

% Create a grid for the surface plot
[X, Y] = meshgrid(-2.5:0.1:2.5, -2.5:0.1:2.5);
Z = f(X, Y);

% Plot the surface
surf(X, Y, Z, 'FaceAlpha', 0.7, 'EdgeColor', 'none');
hold on;

% Plot the constraint circle path on the surface
plot3(x_c, y_c, f_on_constraint, 'k-', 'LineWidth', 3);

% Plot the found extrema points
plot3(x_max, y_max, max_val, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
plot3(x_min, y_min, min_val, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');

% Enhance the plot
title('f(x,y) with extrema on constraint x^2+y^2=4');
xlabel('x'); ylabel('y'); zlabel('f(x,y)');
legend('', 'Constraint Path', 'Maximum', 'Minimum', 'Location', 'NorthWest');
axis equal;
view(135, 30);
grid on;

% --- Pause for Viewing ---
fprintf('\nPlot windows are open. Press any key in the terminal to close them.\n');
pause;
