% Script to analyze accelerometer data and find the natural frequency of a building

% --- Initialization ---
clear all;
close all;
clc;

% --- Load Data ---
% The script expects the CSV file to be in the parent directory.
file_path = './Copy of QuakeData_ShortNoSnow35% - Copy of QuakeData_ShortNoSnow35%.csv';

% Use dlmread to skip the header row
try
    data = dlmread(file_path, ',', 1, 0);
catch
    error('Could not read the CSV file. Make sure it is in the correct directory: %s', file_path);
end

% Extract columns
time = data(:, 1);       % Time (s)
accel_a = data(:, 2);    % Accelerometer A output (g or m/s^2)

% --- Time-Domain Analysis ---

% Plot the raw accelerometer data
figure('Name', 'Accelerometer Time-Series Data');
plot(time, accel_a, 'b-');
title('Building Vibration Over Time');
xlabel('Time (s)');
ylabel('Acceleration (arbitrary units)');
grid on;
% Save the figure as a PNG file
print('timeseries.png', '-dpng', '-r150');

% --- Frequency-Domain Analysis (FFT) ---

% Determine sampling frequency from the data
Fs = 1 / (time(2) - time(1)); % Sampling frequency (Hz)

% Detrend the signal (remove DC offset)
signal = accel_a - mean(accel_a);
L = length(signal); % Length of signal

% Perform Fast Fourier Transform
Y = fft(signal);

% Compute the two-sided spectrum P2, then the single-sided spectrum P1
P2 = abs(Y/L);
P1 = P2(1:floor(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);

% Define the frequency domain f
f = Fs*(0:floor(L/2))/L;

% --- Find the Natural Frequency ---

% Find the peak frequency in the relevant range (e.g., > 0.1 Hz to avoid DC noise)
search_range = f > 0.1;
[max_power, index] = max(P1(search_range));

% Get the corresponding frequency
valid_f = f(search_range);
natural_frequency = valid_f(index);

% --- Plot Frequency Spectrum ---
figure('Name', 'Frequency Spectrum Analysis');
plot(f, P1, 'r-');
title('Single-Sided Amplitude Spectrum of Acceleration Data');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;

% Mark the natural frequency on the plot
hold on;
% Draw a vertical line using plot, as xline is not in Octave
plot([natural_frequency, natural_frequency], ylim, '--k', 'LineWidth', 1.5);
% Add a text label for the line
text(natural_frequency, max_power, sprintf('  Natural Frequency: %.3f Hz', natural_frequency), 'VerticalAlignment', 'middle');
% Zoom into a relevant frequency range for better visibility
if natural_frequency > 1
    xlim([0, natural_frequency * 4]);
else
    xlim([0, 5]); % Default zoom for low frequencies
end
hold off;
% Save the figure as a PNG file
print('spectrum.png', '-dpng', '-r150');

% --- Display Result ---
fprintf('\nAnalysis Complete.\n');
fprintf('Sampling Frequency (Fs): %.1f Hz\n', Fs);
fprintf('Estimated Natural Frequency of the Building: %.3f Hz\n', natural_frequency);
