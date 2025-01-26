mata:
// Convert elevation data to a cost matrix
real matrix elevation_to_cost(real matrix Z, real scalar slope_weight) {
    real matrix cost
    cost = abs(Z[.,.] :- Z) :* slope_weight  // Slope-dependent cost
    return(cost)
}

// A* Algorithm for LCP
real matrix astar_lcp(real matrix cost_grid, real scalar start_row, start_col, end_row, end_col) {
    // Priority queue, visited nodes, and path reconstruction logic
    // (Full code omitted for brevity; see GitHub for implementation)
}
end
