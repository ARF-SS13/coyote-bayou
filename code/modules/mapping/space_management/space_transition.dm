/datum/space_level/proc/set_linkage(new_linkage)
	linkage = new_linkage
	if(linkage == SELFLOOPING)
		neigbours = list(TEXT_NORTH,TEXT_SOUTH,TEXT_EAST,TEXT_WEST,TEXT_UP,TEXT_DOWN)
		for(var/A in neigbours)
			neigbours[A] = src

/datum/space_level/proc/set_neigbours(list/L)
	for(var/datum/space_transition_point/P in L)
		if(P.x == xi && P.y == yi) // Checking for z levels up or down on the same grid.
			if(P.z == zi+1) // if it's above
				neigbours[TEXT_UP] = P.spl
				P.spl.neigbours[TEXT_DOWN] = src
			else if(P.z == zi-1) //below
				neigbours[TEXT_DOWN] = P.spl
				P.spl.neigbours[TEXT_UP] = src
		
		if(P.x == xi) // checking east and west
			if(P.y == yi+1 && P.z == zi)
				neigbours[TEXT_NORTH] = P.spl
				P.spl.neigbours[TEXT_SOUTH] = src
			else if(P.y == yi-1 && P.z == zi)
				neigbours[TEXT_SOUTH] = P.spl
				P.spl.neigbours[TEXT_NORTH] = src
		else if(P.y == yi) // checking north and south
			if(P.x == xi+1 && P.z == zi)
				neigbours[TEXT_EAST] = P.spl
				P.spl.neigbours[TEXT_WEST] = src
			else if(P.x == xi-1 && P.z == zi)
				neigbours[TEXT_WEST] = P.spl
				P.spl.neigbours[TEXT_EAST] = src

/datum/space_transition_point          //this is explicitly utilitarian datum type made specially for the space map generation and are absolutely unusable for anything else
	var/list/neigbours = list()
	var/x
	var/y
	var/z
	var/datum/space_level/spl

/datum/space_transition_point/New(nx, ny, nz, list/point_grid)
	if(!point_grid)
		qdel(src)
		return
	var/list/L = point_grid[1]
	if(nx > point_grid.len || ny > L.len)
		qdel(src)
		return
	x = nx
	y = ny
	z = nz
	if(point_grid[x][y][z])
		return
	point_grid[x][y][z] = src

/datum/space_transition_point/proc/set_neigbours(list/grid)
	var/max_X = grid.len
	var/list/max_Y = grid[1]
	var/list/max_Z = grid[2]
	max_Y = max_Y.len
	max_Z = max_Z.len
	neigbours.Cut()
	if(x+1 <= max_X)
		neigbours |= grid[x+1][y][z]
	if(x-1 >= 1)
		neigbours |= grid[x-1][y][z]
	if(y+1 <= max_Y)
		neigbours |= grid[x][y+1][z]
	if(y-1 >= 1)
		neigbours |= grid[x][y-1][z]
	if(z+1 <= max_Z)
		neigbours |= grid[x][y][z+1]
	if(z-1 >= 1)
		neigbours |= grid[x][y][z-1]

/datum/controller/subsystem/mapping/proc/setup_map_transitions() //listamania
	var/list/SLS = list()
	var/list/cached_z_list = z_list
	var/conf_set_len = 0
	for(var/A in cached_z_list)
		var/datum/space_level/D = A
		if (D.linkage == CROSSLINKED)
			SLS.Add(D)
		conf_set_len++
	var/list/point_grid[conf_set_len*2+1][conf_set_len*2+1][conf_set_len*2+1]
	var/list/grid = list()
	var/datum/space_transition_point/P
	var/gridSize = conf_set_len*2+1
	for(var/x in 1 to gridSize)
		for(var/y in 1 to gridSize)
			for(var/z in 1 to gridSize)
				P = new/datum/space_transition_point(x, y, z, point_grid)
				point_grid[x][y][z] = P
				grid.Add(P)
	for(var/datum/space_transition_point/pnt in grid)
		pnt.set_neigbours(point_grid)

	var/datum/space_level/DO = LAZYACCESS(SLS, 1)
	if(!DO)
		return

	P = point_grid[level_trait(DO.z_value, Z_FORCE_X) + 1][level_trait(DO.z_value, Z_FORCE_Y) + 1][level_trait(DO.z_value, Z_FORCE_Z) + 1] // cursed yes, I know, but this hasn't been touched in 5 years and the original coder couldn't spell neighbour so a bit of spaghetti will help a little. Mentally. I'm unsure though honestly I could rant for days about why spaghettification is a great thing and shouldn't just be a term used for black holes, honestly. Anyways yeah I've made the meme spam comment now as I usually do with every feature I add/change so there we go!
	
	var/list/possible_points = list()
	var/list/used_points = list()
	grid.Cut()
	
	if(SLS.len)
		DO.xi = P.x
		DO.yi = P.y
		DO.zi = P.z
		P.spl = DO
		possible_points |= P.neigbours
		used_points |= P
		possible_points.Remove(used_points)
		SLS.Remove(DO)

		for(var/datum/space_level/DN in SLS)
			var/stpX = level_trait(DN.z_value, Z_FORCE_X) + 1
			var/stpY = level_trait(DN.z_value, Z_FORCE_Y) + 1
			var/stpZ = level_trait(DN.z_value, Z_FORCE_Z) + 1
			
			P = point_grid[stpX][stpY][stpZ]
			
			if(P.spl)
				message_admins("ERROR: P already contains spl")
				continue

			DN.xi = stpX
			DN.yi = stpY
			DN.zi = stpZ

			P.spl = DN
			used_points |= P
			possible_points.Remove(used_points)
			DN.set_neigbours(used_points)
			SLS.Remove(DN)
			CHECK_TICK	

	

	//Lists below are pre-calculated values arranged in the list in such a way to be easily accessable in the loop by the counter
	//Its either this or madness with lotsa math

	var/list/x_pos_beginning = list(1, 1, world.maxx - TRANSITIONEDGE, 1)  //x values of the lowest-leftest turfs of the respective 4 blocks on each side of zlevel
	var/list/y_pos_beginning = list(world.maxy - TRANSITIONEDGE, 1, 1 + TRANSITIONEDGE, 1 + TRANSITIONEDGE)  //y values respectively
	var/list/x_pos_ending = list(world.maxx, world.maxx, world.maxx, 1 + TRANSITIONEDGE) //x values of the highest-rightest turfs of the respective 4 blocks on each side of zlevel
	var/list/y_pos_ending = list(world.maxy, 1 + TRANSITIONEDGE, world.maxy - TRANSITIONEDGE, world.maxy - TRANSITIONEDGE) //y values respectively
	var/list/x_pos_transition = list(1, 1, TRANSITIONEDGE + 2, world.maxx - TRANSITIONEDGE - 1) //values of x for the transition from respective blocks on the side of zlevel, 1 is being translated into turfs respective x value later in the code
	var/list/y_pos_transition = list(TRANSITIONEDGE + 2, world.maxy - TRANSITIONEDGE - 1, 1, 1) //values of y for the transition from respective blocks on the side of zlevel, 1 is being translated into turfs respective y value later in the code

	for(var/I in cached_z_list)
		var/datum/space_level/D = I
		if(!D.neigbours.len)
			continue
		var/zlevelnumber = D.z_value
		for(var/side in 1 to 4)
			var/turf/beginning = locate(x_pos_beginning[side], y_pos_beginning[side], zlevelnumber)
			var/turf/ending = locate(x_pos_ending[side], y_pos_ending[side], zlevelnumber)
			var/list/turfblock = block(beginning, ending)
			var/dirside = 2**(side-1)
			var/zdestination = null
			if(D.neigbours["[dirside]"] && D.neigbours["[dirside]"] != D)
				D = D.neigbours["[dirside]"]
				zdestination = D.z_value
			// This does weird things with the coordinate system, particularly with the way we want to use the maploader
			// 
			// else
			// 	dirside = turn(dirside, 180)
			// 	while(D.neigbours["[dirside]"] && D.neigbours["[dirside]"] != D)
			// 		D = D.neigbours["[dirside]"]
			// 	zdestination = D.z_value
			D = I
			for(var/turf/closed/indestructible/f13/matrix/transition/S in turfblock)
				S.destination_x = x_pos_transition[side] == 1 ? S.x : x_pos_transition[side]
				S.destination_y = y_pos_transition[side] == 1 ? S.y : y_pos_transition[side]
				S.destination_z = zdestination
