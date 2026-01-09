import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

# --- Define the Domain ---
# Define the range and resolution for x and y axes
x = np.arange(-3, 3, 0.1)
y = np.arange(-10, 10, 0.2)

# Create a 2D grid from the x and y ranges
X, Y = np.meshgrid(x, y)

# --- Evaluate the Function ---
# Calculate Z = f(X,Y)
Z = X**2 * np.sin(Y) + Y * np.exp(-X**2)

# --- Create the 3D Plot ---
# Create a figure and a 3D subplot
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

# Plot the surface using a color map for visual appeal
surf = ax.plot_surface(X, Y, Z, cmap='viridis', edgecolor='none')

# --- Enhance the Plot ---
# Add a title and axis labels
ax.set_title('f(x,y) = x^2*sin(y) + y*exp(-x^2)', fontsize=14)
ax.set_xlabel('x', fontsize=12)
ax.set_ylabel('y', fontsize=12)
ax.set_zlabel('z', fontsize=12)

# Add a color bar to show the mapping of color to z-values
fig.colorbar(surf, shrink=0.6, aspect=10)

# Adjust the view angle for a better perspective
ax.view_init(elev=30, azim=135)

# --- Show the Plot ---
# This command opens the plot window and keeps it open
plt.show()
