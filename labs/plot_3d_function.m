% Script to visualize a 3D function f(x,y)

% --- Initialization ---
clear all;
close all;
clc;

% --- Define the Domain ---
% Define the range and resolution for x and y axes
x_range = -3:0.1:3;
y_range = -10:0.2:10;

% Create a 2D grid from the x and y ranges
[X, Y] = meshgrid(x_range, y_range);

% --- Evaluate the Function ---
% Calculate Z = f(X,Y) using element-wise operators (.^, .*) 
Z = X.^2 .* sin(Y) + Y .* exp(-X.^2);

% --- Create the 3D Plot ---
figure('Name', '3D Surface Plot');

% Use the surf command to create the surface plot
surf(X, Y, Z);

% --- Enhance the Plot ---

% Use interpolated shading for a smoother color transition
shading interp;

% Add a title and axis labels
title('f(x,y) = x^2*sin(y) + y*e^{-x^2}', 'FontSize', 14);
xlabel('x', 'FontSize', 12);
ylabel('y', 'FontSize', 12);
zlabel('z', 'FontSize', 12);

% Add a color bar to show the mapping of color to z-values
colorbar;

% Adjust the view angle for a better perspective
view(135, 30);

grid on;

% --- Pause for Viewing ---
fprintf('\nPlot window is open. Press any key in the terminal to close.\n');
pause;
