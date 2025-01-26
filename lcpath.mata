mata:
// A* Algorithm for Least-Cost Path
real matrix astar_lcp(real matrix Z, real scalar slope_weight,
                      real scalar start_row, real scalar start_col,
                      real scalar end_row, real scalar end_col) {
    // Define node structure: [f, g, row, col, parent_row, parent_col]
    real matrix open_list, closed_list, path
    real scalar rows, cols, current_idx, i, found
    real scalar current_row, current_col, tentative_g, move_cost
    real scalar heuristic, dx, dy

    rows = rows(Z)
    cols = cols(Z)
    found = 0

    // Initialize open list with start node [f, g, row, col, parent_row, parent_col]
    open_list = (., 0, start_row, start_col, -1, -1)
    open_list[1, 1] = abs(end_row - start_row) + abs(end_col - start_col) // f = g + h

    closed_list = J(0, 6, .)

    while (rows(open_list) > 0 & !found) {
        // Find node with lowest f in open_list
        current_idx = selectindex(open_list[,1] :== min(open_list[,1]))[1]
        current_row = open_list[current_idx, 3]
        current_col = open_list[current_idx, 4]

        // Move current node to closed list
        closed_list = closed_list \ open_list[current_idx, .]
        open_list = open_list[|1,1 \ current_idx-1,6|] \ 
                    open_list[|current_idx+1,1 \ .,6|]

        // Check if goal reached
        if (current_row == end_row & current_col == end_col) {
            found = 1
            break
        }

        // Generate neighbors (8-direction movement)
        for (dx = -1; dx <= 1; dx++) {
            for (dy = -1; dy <= 1; dy++) {
                if (dx == 0 & dy == 0) continue // Skip current cell

                real scalar neighbor_row = current_row + dx
                real scalar neighbor_col = current_col + dy

                // Skip out-of-bounds cells
                if (neighbor_row < 1 | neighbor_row > rows |
                    neighbor_col < 1 | neighbor_col > cols) continue

                // Calculate movement cost (slope + distance)
                real scalar elevation_diff = abs(Z[neighbor_row, neighbor_col] - Z[current_row, current_col])
                real scalar distance = sqrt(dx^2 + dy^2) // 1 or sqrt(2)
                move_cost = elevation_diff * slope_weight + distance

                tentative_g = closed_list[rows(closed_list), 2] + move_cost

                // Calculate heuristic (Euclidean distance to goal)
                heuristic = sqrt((end_row - neighbor_row)^2 + (end_col - neighbor_col)^2)
                real scalar f = tentative_g + heuristic

                // Check if in closed list
                if (any(closed_list[,3] :== neighbor_row :& closed_list[,4] :== neighbor_col)) {
                    if (tentative_g >= closed_list[selectindex(closed_list[,3] :== neighbor_row :&
                        closed_list[,4] :== neighbor_col), 2][1]) continue
                }

                // Check if in open list
                real matrix open_match = open_list[,3] :== neighbor_row :& open_list[,4] :== neighbor_col
                if (any(open_match)) {
                    if (tentative_g >= open_list[selectindex(open_match), 2][1]) continue
                    open_list = open_list[|1,1 \ selectindex(open_match)-1,6|] \ 
                                open_list[|selectindex(open_match)+1,1 \ .,6|]
                }

                // Add to open list
                open_list = open_list \ (f, tentative_g, neighbor_row, neighbor_col, current_row, current_col)
            }
        }

        // Sort open list by f-score
        if (rows(open_list) > 0) {
            open_list = sort(open_list, 1)
        }
    }

    // Path reconstruction
    if (found) {
        path = J(0, 2, .)
        real scalar trace_row = end_row
        real scalar trace_col = end_col

        while (trace_row != -1) {
            path = (trace_row, trace_col) \ path
            real matrix parent = selectindex(closed_list[,3] :== trace_row :&
                                            closed_list[,4] :== trace_col)
            if (rows(parent) == 0) break
            trace_row = closed_list[parent[1], 5]
            trace_col = closed_list[parent[1], 6]
        }

        return(path)
    }
    else {
        return(J(0, 2, .)) // Return empty matrix if no path found
    }
}
end
