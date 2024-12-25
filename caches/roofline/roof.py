import matplotlib.pyplot as plt
import numpy as np

# Example Data
peak_performance = 100 * 10**6  # GFLOPS
max_bandwidth = 0.0666 * 10**8  # GB/s
arithmetic_intensity = [0.48, 0.48, 0.48]  # Example AI values
performance = [0.64 * 10**6, 0.68 * 10**6, 0.73 * 10**6]  # Measured performance

# Define colors for each performance point
dot_colors = ["red", "green", "orange"]  # Different colors for each point
n_range = [8, 16, 32]
label = ["prog 1", "prog1", "prog1"]

# Create AI range
ai_range = np.logspace(-5, 2, 100)  # Covers AI from 0.01 to 100

# Compute Roofline limits
roofline_memory = ai_range * max_bandwidth  # Memory-bound line
roofline_memory = np.minimum(roofline_memory, peak_performance)

# Plot
plt.figure(figsize=(10, 6))

# Plot the roofline
plt.plot(ai_range, roofline_memory, label="Roofline", color="blue", lw=2)

# Plot each performance point with a different color
for i, (ai, perf, color, label) in enumerate(zip(arithmetic_intensity, performance, dot_colors, label)):
    plt.scatter(ai, perf, color=color, label=f"n = {n_range[i]}", zorder=5)
    plt.text(ai, perf, label, fontsize=10, ha='right', va='bottom')

# Labels and Scale
plt.xscale('log', base=2)
plt.yscale('log', base=2)
plt.xlabel("Arithmetic Intensity (Multiplications/Byte - MPB)", fontsize=12)
plt.ylabel("Performance (Multiplications/Second - MPS)", fontsize=12)
plt.title("Roofline Model MIPS-A", fontsize=14)

# Add peak performance line
plt.axhline(peak_performance, color="red", linestyle="--", label="Peak Performance")

# Add legend and grid
plt.legend()
plt.grid(True, which="both", linestyle="--", linewidth=0.5)

# Show the plot
plt.show()
