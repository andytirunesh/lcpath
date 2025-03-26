{smcl}
{title:lcpath}

{title:Title}

{p 4 4 2}
{bf:lcpath} - Calculate least-cost paths using grid coordinates and elevation data.

{title:Syntax}

{p 8 8 2}
{cmd:lcpath} {it:xvar yvar zvar}, {bf:start}({it:numlist}) {bf:end}({it:numlist}) [{bf:slope}({it:real 1.0}) {bf:saving}({it:string})]

{synoptset 20 tabbed}{...}
{synopthdr:Options}
{synoptline}
{synopt:{opt start}(numlist)}Grid coordinates (row, column) of the starting point.{p_end}
{synopt:{opt end}(numlist)}Grid coordinates (row, column) of the target point.{p_end}
{synopt:{opt slope}(real)}Weight for elevation change penalty (default = 1.0).{p_end}
{synopt:{opt saving}(string)}Save output path coordinates to the specified .dta file.{p_end}
{synoptline}

{title:Description}

{p 4 4 2}
{cmd:lcpath} calculates least-cost paths across a grid using elevation data. It implements the A* algorithm with a cost function that penalizes elevation changes and Euclidean distance. The command outputs path coordinates and optionally saves them to a dataset.

{title:Options}

{phang}
{opt start}(numlist) specifies the starting grid cell coordinates (row, column).

{phang}
{opt end}(numlist) specifies the target grid cell coordinates (row, column).

{phang}
{opt slope}(real) sets the weight for elevation change penalties. Higher values prioritize flatter paths.

{phang}
{opt saving}(string) saves the path coordinates to a Stata dataset.

{title:Examples}

{p 4 4 2}
{hline}
{bf:Example 1: Basic usage}

{phang2}{cmd:. use "elevation_grid.dta", clear}{p_end}
{phang2}{cmd:. lcpath x y z, start(1 1) end(100 100) slope(2.0) saving("path_output.dta")}{p_end}

{bf:Example 2: Visualize path}

{phang2}{cmd:. use "path_output.dta", clear}{p_end}
{phang2}{cmd:. twoway contour z x y || line path_y path_x, lcolor(red)}{p_end}
{hline}

{title:References}

{p 4 4 2}
- A* algorithm: Hart, P. E., Nilsson, N. J., & Raphael, B. (1968). A Formal Basis for the Heuristic Determination of Minimum Cost Paths. {it:IEEE Transactions on Systems Science and Cybernetics}, 4(2), 100-107.

{title:Author}

{p 4 4 2}
Andu Berha, {browse "mailto:aberha@ualberta.ca":aberha@ualberta.ca}
