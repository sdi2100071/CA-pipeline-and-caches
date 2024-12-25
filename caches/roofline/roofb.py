import matplotlib.pyplot as plt
import numpy as np

# Example Data
peak_performance = 100 * 10**6  # GFLOPS
max_bandwidth = 4   * 10**8  # GB/s

arithmetic_intensity = [0.020, 0.020, 0.020, 0.023, 0.023, 0.023, 0.016, 0.016, 0.016]  # Example AI values
performance = [1.64 * 10**3, 2.25*10**3, 2.76*10**3, 2.63*10**3, 2.97 *10**3, 30.91*10**3, 3.96*10**3, 4.44 *10**3, 4.62*10**3]  # Measured performance
dot_colors = ['#ff9999', "red", '#b30000', '#99ff99', '#33cc33', '#006600', '#ccccff', '#6666ff', '#0000cc']  # Defined colors
n_range = ["8", "16", "32", "8", "16", "32", "8", "16", "32"]
programs = ["prog1", "prog1", "prog1", "prog2", "prog2", "prog2", "prog3", "prog3", "prog3"]
# Create AI range
ai_range = np.logspace(-5, 2, 100)

# Compute Roofline limits
roofline_memory = ai_range * max_bandwidth
roofline_performance = np.minimum(roofline_memory, peak_performance)

# Plot setup
plt.figure(figsize=(12, 8))

# Plot the roofline
plt.plot(ai_range, roofline_performance, label="Roofline", color="blue", lw=2)

# Plot each performance point
for i, (ai, perf, color, prog) in enumerate(zip(arithmetic_intensity, performance, dot_colors, programs)):
    plt.scatter(ai, perf, color=color, edgecolor='black', s=35, label=f"{prog} (n={n_range[i]})", zorder=5)
    # plt.text(ai * 1.1, perf * 1.1, f"n={n_range[i]}", fontsize=10, color=color)

# Labels and Scale
plt.xscale('log', base=2)
plt.yscale('log', base=2)
plt.xlabel("Arithmetic Intensity (Multiplications/Byte - MPB)", fontsize=14)
plt.ylabel("Performance (Multiplications/Second - MPS)", fontsize=14)
plt.title("Roofline Model for MIPS-B", fontsize=16)

# Add peak performance line
plt.axhline(peak_performance, color="red", linestyle="--", label="Peak Performance", linewidth=1.5)

# Add legend and grid
plt.legend(fontsize=10, loc="lower right")
plt.grid(True, which="both", linestyle="--", linewidth=0.7, alpha=0.7)

# Show the plot
plt.show()
