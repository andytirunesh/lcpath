program define lcpath
    version 18
    syntax varlist(min=3 max=3 numeric), start(numlist) end(numlist) [SLOpe(real 1.0) SAVing(string)]

    // Load elevation data into Mata
    mata: Z = st_data(., tokens("`varlist'"))
    mata: start_coord = strtoreal(tokens("`start'"))
    mata: end_coord = strtoreal(tokens("`end'"))

    // Compute cost matrix and path
    mata: cost_grid = elevation_to_cost(Z, `slope')
    mata: path = astar_lcp(cost_grid, start_coord[1], start_coord[2], end_coord[1], end_coord[2])

    // Save output
    clear
    mata: st_matrix("path_coords", path)
    svmat path_coords, names(x y)
    if "`saving'" != "" save "`saving'", replace
end
