# LCPATH: Least-Cost Path Calculation in Stata

**Author:** Andue Berha  
**Repository:** [GitHub - andytirunesh/lcpath](https://github.com/andytirunesh/lcpath)  
**License:** MIT  

## Overview

`lcpath` is a Stata package that calculates the **least-cost path (LCP)** across a grid using elevation data. It implements the **A* algorithm**, incorporating a cost function that penalizes elevation changes and Euclidean distance. This package is useful for researchers working in **spatial econometrics, transportation modeling, environmental studies, and development research** where accessibility and terrain constraints matter.

## Features

- Computes **least-cost paths** using **grid coordinates and elevation data**.
- Implements the **A* search algorithm** for efficient pathfinding.
- Allows adjustment of **slope penalties** to prioritize flatter routes.
- Outputs path coordinates and **saves results** as a Stata dataset.
- Integrates with **Stata visualization tools** for mapping the computed path.
- Designed for **large-scale geographic datasets**.
- Supports **custom cost functions** for advanced users.

---

## Installation

To install `lcpath` from GitHub, follow these steps in Stata:

### **Step 1: Install `github` package (if not already installed)**
```stata
net install github, from("https://haghish.github.io/github/")
```

### **Step 2: Install `lcpath` from GitHub**
```stata
github install andytirunesh/lcpath
```

### **Step 3: Verify Installation**
To confirm that the package was installed correctly, run:
```stata
help lcpath
```

---

## Syntax

```stata
lcpath xvar yvar zvar, start(numlist) end(numlist) [slope(real 1.0) saving(string)]
```

### **Required Arguments**
- `xvar yvar zvar` : Grid coordinate variables (X, Y) and elevation data (Z).
- `start(numlist)` : Grid coordinates **(row, column)** of the starting point.
- `end(numlist)` : Grid coordinates **(row, column)** of the target point.

### **Optional Arguments**
- `slope(real)` : Weight for elevation change penalty (default = `1.0`). Higher values prioritize flatter paths.
- `saving(string)` : Saves the path coordinates to a specified `.dta` file.

---

## Example Usage

### **Example 1: Basic Usage**
```stata
use "elevation_grid.dta", clear
lcpath x y z, start(1 1) end(100 100) slope(2.0) saving("path_output.dta")
```

### **Example 2: Visualize Path**
```stata
use "path_output.dta", clear
twoway contour z x y || line path_y path_x, lcolor(red)
```

### **Example 3: Adjusting Elevation Penalty**
```stata
lcpath x y z, start(10 10) end(50 50) slope(5.0) saving("adjusted_path.dta")
```

---

## How It Works

The `lcpath` command finds the **optimal path** from a **starting grid cell** to an **end grid cell** by minimizing travel costs. It does so using:

1. **A* Algorithm** - A heuristic-based approach that finds the shortest weighted path efficiently.
2. **Elevation Penalty** - Incorporates slope effects to penalize steep inclines.
3. **Grid-Based Navigation** - Uses raster data structure for computational efficiency.

The algorithm balances **Euclidean distance and elevation penalties**, allowing users to customize the importance of terrain constraints.

---

## Dependencies

- **Stata 15 or later**
- **Raster data in `.dta` format** (containing elevation or cost surface values)
- **Pre-processing GIS tools** (optional, if preparing raster files from external sources)

---

## Use Cases

- **Agricultural Accessibility**: Assess travel distances for farmers in hilly terrains.
- **Infrastructure Planning**: Optimize road construction routes.
- **Environmental Studies**: Model wildlife movement based on terrain.
- **Disaster Response**: Identify optimal evacuation paths in flood-prone regions.

---

## Algorithm Reference

- **A* Algorithm**: Hart, P. E., Nilsson, N. J., & Raphael, B. (1968). *A Formal Basis for the Heuristic Determination of Minimum Cost Paths.* IEEE Transactions on Systems Science and Cybernetics, 4(2), 100-107.

---

## License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## Contributions

Contributions, feature requests, and bug reports are welcome! Feel free to **open an issue** or submit a **pull request**.

---

## Contact

For questions or feedback, please reach out to:

📧 **Andue Berha** – [aberha@ualberta.ca](mailto:aberha@ualberta.ca)  
🔗 **GitHub:** [https://github.com/andytirunesh/lcpath](https://github.com/andytirunesh/lcpath)

