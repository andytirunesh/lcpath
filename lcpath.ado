program define lcpath
    version 16
    syntax varlist(min=3 max=3 numeric), start(numlist) end(numlist) [SLOpe(real 1.0) SAVing(string)]

    // Parse input variables: x, y, z
    tokenize `varlist'
    local xvar `1'
    local yvar `2'
    local zvar `3'

    // Load elevation data into Mata
    mata: Z = st_data(., "`zvar'")
    mata: start_coord = strtoreal(tokens("`start'"))
    mata: end_coord = strtoreal(tokens("`end'"))

    // Run A* algorithm
    mata: path = astar_lcp(Z, `slope', start_coord[1], start_coord[2], end_coord[1], end_coord[2])

    // Save output
    clear
    mata: st_matrix("path_coords", path)
    svmat path_coords, names(col)
    ren path_coords1 row
    ren path_coords2 col

    // Merge with original coordinates
    merge m:1 row col using "original_data.dta", keep(match) nogen
    keep `xvar' `yvar'

    if "`saving'" != "" save "`saving'", replace
end
