//supposedly the fastest way to do this according to https://gist.github.com/Giacom/be635398926bb463b42a
#define RANGE_TURFS(RADIUS, CENTER) \
	block( \
		locate(max(CENTER.x-(RADIUS),1),          max(CENTER.y-(RADIUS),1),          CENTER.z), \
		locate(min(CENTER.x+(RADIUS),world.maxx), min(CENTER.y+(RADIUS),world.maxy), CENTER.z) \
	)

#define Z_TURFS(ZLEVEL) block(locate(1,1,ZLEVEL), locate(world.maxx, world.maxy, ZLEVEL))
#define CULT_POLL_WAIT 2400

/proc/get_area_name(atom/X, format_text = FALSE, get_base_area = FALSE)
	var/area/A = get_base_area ? get_base_area(X) : get_area(X)
	if(!A)
		return null
	return format_text ? format_text(A.name) : A.name

/proc/get_areas_in_range(dist=0, atom/center=usr)
	if(!dist)
		var/turf/T = get_turf(center)
		return T ? list(T.loc) : list()
	if(!center)
		return list()

	var/list/turfs = RANGE_TURFS(dist, center)
	var/list/areas = list()
	for(var/V in turfs)
		var/turf/T = V
		areas |= T.loc
	return areas

/proc/get_adjacent_areas(atom/center)
	. = list(get_area(get_ranged_target_turf(center, NORTH, 1)),
			get_area(get_ranged_target_turf(center, SOUTH, 1)),
			get_area(get_ranged_target_turf(center, EAST, 1)),
			get_area(get_ranged_target_turf(center, WEST, 1)))
	listclearnulls(.)

/proc/get_open_turf_in_dir(atom/center, dir)
	var/turf/open/T = get_ranged_target_turf(center, dir, 1)
	if(istype(T))
		return T

/proc/get_adjacent_open_turfs(atom/center)
	. = list(get_open_turf_in_dir(center, NORTH),
			get_open_turf_in_dir(center, SOUTH),
			get_open_turf_in_dir(center, EAST),
			get_open_turf_in_dir(center, WEST))
	listclearnulls(.)

/proc/get_adjacent_open_areas(atom/center)
	. = list()
	var/list/adjacent_turfs = get_adjacent_open_turfs(center)
	for(var/I in adjacent_turfs)
		. |= get_area(I)

/**
 * Get a bounding box of a list of atoms.
 *
 * Arguments:
 * - atoms - List of atoms. Can accept output of view() and range() procs.
 *
 * Returns: list(x1, y1, x2, y2)
 */
/proc/get_bbox_of_atoms(list/atoms)
	var/list/list_x = list()
	var/list/list_y = list()
	for(var/_a in atoms)
		var/atom/a = _a
		list_x += a.x
		list_y += a.y
	return list(
		min(list_x),
		min(list_y),
		max(list_x),
		max(list_y))

// Like view but bypasses luminosity check

/proc/get_hear(range, atom/source)

	var/lum = source.luminosity
	source.luminosity = 6

	var/list/heard = view(range, source)
	source.luminosity = lum

	return heard

/proc/alone_in_area(area/the_area, mob/must_be_alone, check_type = /mob/living/carbon)
	var/area/our_area = get_area(the_area)
	for(var/C in GLOB.alive_mob_list)
		if(!istype(C, check_type))
			continue
		if(C == must_be_alone)
			continue
		if(our_area == get_area(C))
			return 0
	return 1

//We used to use linear regression to approximate the answer, but Mloc realized this was actually faster.
//And lo and behold, it is, and it's more accurate to boot.
/proc/cheap_hypotenuse(Ax,Ay,Bx,By)
	return sqrt(abs(Ax - Bx)**2 + abs(Ay - By)**2) //A squared + B squared = C squared

/proc/circlerange(center=usr,radius=3)

	var/turf/centerturf = get_turf(center)
	var/list/turfs = new/list()
	var/rsq = radius * (radius+0.5)

	for(var/atom/T in range(radius, centerturf))
		var/dx = T.x - centerturf.x
		var/dy = T.y - centerturf.y
		if(dx*dx + dy*dy <= rsq)
			turfs += T

	//turfs += centerturf
	return turfs

/proc/circleview(center=usr,radius=3)

	var/turf/centerturf = get_turf(center)
	var/list/atoms = new/list()
	var/rsq = radius * (radius+0.5)

	for(var/atom/A in view(radius, centerturf))
		var/dx = A.x - centerturf.x
		var/dy = A.y - centerturf.y
		if(dx*dx + dy*dy <= rsq)
			atoms += A

	//turfs += centerturf
	return atoms


/proc/circlerangeturfs(center=usr,radius=3)

	var/turf/centerturf = get_turf(center)
	var/list/turfs = new/list()
	var/rsq = radius * (radius+0.5)

	for(var/turf/T in range(radius, centerturf))
		var/dx = T.x - centerturf.x
		var/dy = T.y - centerturf.y
		if(dx*dx + dy*dy <= rsq)
			turfs += T
	return turfs

/proc/circleviewturfs(center=usr,radius=3)		//Is there even a diffrence between this proc and circlerangeturfs()?

	var/turf/centerturf = get_turf(center)
	var/list/turfs = new/list()
	var/rsq = radius * (radius+0.5)

	for(var/turf/T in view(radius, centerturf))
		var/dx = T.x - centerturf.x
		var/dy = T.y - centerturf.y
		if(dx*dx + dy*dy <= rsq)
			turfs += T
	return turfs

/** recursive_organ_check
 * inputs: O (object to start with)
 * outputs:
 * description: A pseudo-recursive loop based off of the recursive mob check, this check looks for any organs held
 *				 within 'O', toggling their frozen flag. This check excludes items held within other safe organ
 *				 storage units, so that only the lowest level of container dictates whether we do or don't decompose
 */
/proc/recursive_organ_check(atom/O)

	var/list/processing_list = list(O)
	var/list/processed_list = list()
	var/index = 1
	var/obj/item/organ/found_organ

	while(index <= length(processing_list))

		var/atom/A = processing_list[index]

		if(istype(A, /obj/item/organ))
			found_organ = A
			found_organ.organ_flags ^= ORGAN_FROZEN

		else if(istype(A, /mob/living/carbon))
			var/mob/living/carbon/Q = A
			for(var/organ in Q.internal_organs)
				found_organ = organ
				found_organ.organ_flags ^= ORGAN_FROZEN

		for(var/atom/B in A)	//objects held within other objects are added to the processing list, unless that object is something that can hold organs safely
			if(!processed_list[B] && !istype(B, /obj/structure/closet/crate/freezer) && !istype(B, /obj/structure/closet/secure_closet/freezer))
				processing_list+= B

		index++
		processed_list[A] = A

	return


// Better recursive loop, technically sort of not actually recursive cause that sh1t is stupid, enjoy.
//No need for a recursive limit either
/proc/recursive_mob_check(atom/O,client_check=1,sight_check=1,include_radio=1)

	var/list/processing_list = list(O)
	var/list/processed_list = list()
	var/list/found_mobs = list()

	while(processing_list.len)

		var/atom/A = processing_list[1]
		var/passed = 0

		if(ismob(A))
			var/mob/A_tmp = A
			passed=1

			if(client_check && !A_tmp.client)
				passed=0

			if(sight_check && !isInSight(A_tmp, O))
				passed=0

		else if(include_radio && istype(A, /obj/item/radio))
			passed=1

			if(sight_check && !isInSight(A, O))
				passed=0

		if(passed)
			found_mobs |= A

		for(var/atom/B in A)
			if(!processed_list[B])
				processing_list |= B

		processing_list.Cut(1, 2)
		processed_list[A] = A

	return found_mobs

/obj/soundblocker
	name = "Sound Blocker"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "tdome_admin" // trust me it makes sense
	invisibility = INVISIBILITY_ABSTRACT
	var/flag = BLOCK_SOUND_COMPLETE

/obj/soundblocker/partial
	name = "Partial Sound Blocker"
	icon_state = "tdome_observer"
	flag = BLOCK_SOUND_PARTIAL

/obj/soundblocker/corner
	name = "Corner Sound Blocker"
	icon_state = "tdome_corner"
	flag = BLOCK_SOUND_PARTIAL | SOUND_BLOCK_CORNER

/obj/soundblocker/Initialize()
	. = ..()
	RegisterSignal(get_turf(src), COMSIG_UPDATE_SOUND_BLOCKERS, PROC_REF(UpdateSoundBlockers))
	RegisterSignal(get_turf(src), COMSIG_CHECK_SOUND_BLOCKERS,  PROC_REF(CheckSoundBlockers))

/obj/soundblocker/proc/UpdateSoundBlockers()

/obj/soundblocker/proc/CheckSoundBlockers()



/proc/get_hearers_in_view(R, atom/source, exclude_players)
	var/turf/T = get_turf(source)
	. = list()
	if(!T)
		return
	var/list/processing = list()
	if(R == 0)
		processing += T.contents
	else
		var/lum = T.luminosity
		T.luminosity = 6
		var/list/cached_view = view(R, T)
		for(var/mob/M in cached_view)
			processing += M
		for(var/obj/O in cached_view)
			processing += O
		T.luminosity = lum
	var/i = 0
	while(i < length(processing))
		var/atom/A = processing[++i]
		processing += A.contents
		if(exclude_players && istype(A, /mob))
			var/mob/M = A
			if(M.client)
				continue // we'll get to them
		if(A.flags_1 & HEAR_1)
			. += A
			SEND_SIGNAL(A, COMSIG_ATOM_HEARER_IN_VIEW, processing, .)

GLOBAL_LIST_EMPTY(chat_chuds)

/proc/get_chatchud(atom/source)
	for(var/i in 1 to LAZYLEN(GLOB.chat_chuds))
		var/datum/chatchud/chud = GLOB.chat_chuds[i]
		if(chud.ready)
			return chud
	var/datum/chatchud/chud = new /datum/chatchud()
	GLOB.chat_chuds += chud
	return chud

/datum/chatchud
	var/list/visible_close = list()
	var/list/visible_far = list()
	var/list/hidden_pathable = list()
	var/list/hidden_inaccessible = list()
	var/ready = TRUE

/datum/chatchud/proc/putback()
	visible_close.Cut()
	visible_far.Cut()
	hidden_pathable.Cut()
	ready = TRUE // snip snip no jutsu wuz here

/obj/effect/temp_visual/debug_heart
	name = "love heart"
	icon = 'icons/effects/effects.dmi'
	icon_state = "heart"
	duration = 2 SECONDS

/obj/effect/temp_visual/numbers
	name = "numberwang"
	icon = 'icons/effects/numbers.dmi'
	icon_state = "blank"
	duration = 2 SECONDS

/obj/effect/temp_visual/numbers/backgrounded
	name = "numberwang"
	icon = 'icons/effects/numbers.dmi'
	icon_state = "blank_ish"
	duration = 3 SECONDS

/obj/effect/temp_visual/numbers/Initialize(mapload, numb, coler)
	. = ..()
	numericate(numb, coler)

/obj/effect/temp_visual/numbers/proc/numericate(numb, coler)
	if(numb > 99999999)
		numb = 99999999
	var/list/splitnumbers = list()
	/// splits numb into its digits, from most to least significant
	if(numb <= 0)
		splitnumbers += 0
	else
		var/tries = 10
		while(numb > 0 && tries-- > 0)
			splitnumbers += numb % 10
			numb /= 10
			numb = floor(numb)
	/// now we have to reverse the list
	splitnumbers = reverseList(splitnumbers)
	var/offset = 0
	/// now we can display the numbers
	for(var/i in 1 to LAZYLEN(splitnumbers))
		var/digy = clamp(LAZYACCESS(splitnumbers, i), 0, 9)
		var/image/numbie = image('icons/effects/numbers.dmi', src, "[digy]")
		numbie.pixel_x = offset
		overlays += numbie
		offset += 9
	if(coler)
		color = coler

#define IS_IN_VIEWER_RECT(turf) TURF_IN_RECTANGLE(turf, westest, northest, eastest, southest)

/// returns a datum of players and how well they can hear the source
/proc/get_listening(datum/rental_mommy/chat/momchat)
	if(!momchat)
		CRASH("get_listening() called with null momchat!!!!!!11")
	var/atom/source = momchat.source
	var/close_range = momchat.close_message_range
	var/long_range = momchat.far_message_range
	var/cheapo = FALSE
	if(!isplayer(source) && !istype(source, /mob/living/simple_animal/debug_chatterboy))
		long_range = min(long_range, 7)
		close_range = min(close_range, 7) // raiders screamed so hard the server lagged
		cheapo = TRUE

	var/area/A = get_area(source)
	var/private = A.private
	var/datum/chatchud/CC = get_chatchud(source)
	var/turf/source_turf = get_turf(source)
	var/debug_i = 0
	dingus:
		for(var/client/C in GLOB.clients)
			var/mob/M = C.mob
			if(isnewplayer(M))
				continue dingus // quit talkin to ghosts, unless ur an admeme
			var/turf/viewer_turf = get_turf(M)
			if(source_turf.z != viewer_turf.z) // TODO: let people yell up stairs
				continue dingus
			var/am_widescreen = C.prefs.widescreenpref
			var/westest 
			if(am_widescreen)
				westest = max(viewer_turf.x - 8, 1)
			else
				westest = max(viewer_turf.x - 6, 1)
			var/eastest 
			if(am_widescreen)
				eastest = min(viewer_turf.x + 8, world.maxx)
			else
				eastest = min(viewer_turf.x + 6, world.maxx)
			var/northest 
			if(am_widescreen)
				northest = max(viewer_turf.y - 7, 1)
			else
				northest = max(viewer_turf.y - 7, 1)
			var/southest 
			if(am_widescreen)
				southest = min(viewer_turf.y + 5, world.maxy)
			else
				southest = min(viewer_turf.y + 5, world.maxy)
			var/list/things_in_viewer_los = view(7, viewer_turf)
			if(SSchat.debug_chud)
				var/turf/t_northwest = locate(westest, northest, viewer_turf.z)
				var/turf/t_southeast = locate(eastest, southest, viewer_turf.z)
				var/turf/t_northeast = locate(eastest, northest, viewer_turf.z)
				var/turf/t_southwest = locate(westest, southest, viewer_turf.z)
				/// draw a beam box!
				t_northeast.Beam(t_northwest, icon_state = "1-full", time = 3 SECONDS, show_to = list(C))
				t_northeast.Beam(t_southeast, icon_state = "1-full", time = 3 SECONDS, show_to = list(C))
				t_southeast.Beam(t_southwest, icon_state = "1-full", time = 3 SECONDS, show_to = list(C))
				t_southwest.Beam(t_northwest, icon_state = "1-full", time = 3 SECONDS, show_to = list(C))
			var/in_close_view
			if(SSchat.debug_use_cool_los_proc)
				in_close_view = isInSight(source_turf, viewer_turf)
			else
				in_close_view = (source_turf in things_in_viewer_los)
			var/in_rect = IS_IN_VIEWER_RECT(source_turf)
			if(!in_rect && get_dist(source_turf, viewer_turf) > long_range)
				continue dingus
			// basic visibility, fulfills these conditions:
			// 1. must be in the box of visibility, so we dont have to play with pathing nonsense
			// 2. must be in the line of sight of the hearer, so it shouldnt be over darkness
			// basically if they're on screen, and either of the ranges are met, they're visible and we can skip the pathing
			if(in_rect && in_close_view)
				if(get_dist(source_turf, viewer_turf) <= close_range)
					CC.visible_close[M] = TRUE
					continue dingus
				else if(get_dist(source_turf, viewer_turf) <= long_range)
					CC.visible_far[M] = TRUE
					continue dingus
			// if the source is in a Private area,
			// and the viewer is either not in the line of sight or not in the box of visibility,
			// then they're hidden, so we dont bleat out a bunch of horny moaning to the whole world
			if(private)
				continue dingus
			// if(in_rect && !quiet)
			// 	CC.hidden_pathable[M] = source_turf // close enough
			// 	continue dingus
			// now the fun begins. Try to find a path to them
			var/list/soundwalk = cheapo\
				? getline(source_turf, viewer_turf)\
				: get_path_to(source_turf, viewer_turf, long_range, use_visibility = TRUE) // yes i'm using expensive pathfinding for horny moaning, I'm an expensive date
			// they're closed off, no path to them, but they're still within long range
			if(!islist(soundwalk))
				CC.hidden_inaccessible[M] = TRUE // mark them as hidden
				continue dingus
			// the path from source to viewer is too long, so we consider them out of range
			if(!LAZYLEN(soundwalk) || LAZYLEN(soundwalk) > long_range)
				continue dingus
			// now walk through the path and find the first tile that can fulfill all of these conditions:
			// 1. must be in the box of visibility
			// 2. must be in the line of sight of the hearer
			debug_i = 0
			var/list/ccline = getline(source_turf, viewer_turf) // know that cool pathfinding stuff? throw it out, just needed it for seeing if we can reach em!
			var/cole = SSchat.debug_chud && safepick("#FF0000", "#00FF00", "#0000FF", "#FFFF00", "#FF00FF", "#00FFFF")
			for(var/turf/T as anything in ccline) // for each step we take...
				if(SSchat.debug_chud)
					new /obj/effect/temp_visual/numbers/backgrounded(T, debug_i, cole)
					debug_i++
				if(!IS_IN_VIEWER_RECT(T)) // ...check if our turf is in the viewer's box of visibility
					continue // we can't see them
				// if(!(isInSight(T, viewer_turf))) // if they're in the box but not in the line of sight,
				// 	continue // we can't see them
				// at this point, we have met these conditions
				if(SSchat.debug_chud)
					new /obj/effect/temp_visual/debug_heart(T)
				CC.hidden_pathable[M] = T
				continue dingus // move along, dingus
			// couldnt find anything! mark them as hidden
			CC.hidden_inaccessible[M] = TRUE
	return CC

//viewers() but with a signal, for blacklisting.
/proc/fov_viewers(depth = world.view, atom/center)
	if(!center)
		return
	. = viewers(depth, center)
	for(var/k in .)
		var/mob/M = k
		SEND_SIGNAL(M, COMSIG_MOB_FOV_VIEWER, center, depth, .)

/proc/get_mobs_in_radio_ranges(list/obj/item/radio/radios)
	. = list()
	// Returns a list of mobs who can hear any of the radios given in @radios
	for(var/obj/item/radio/R in radios)
		if(R)
			. |= get_hearers_in_view(R.canhear_range, R)


#define SIGNV(X) ((X<0)?-1:1)

/proc/inLineOfSight(X1,Y1,X2,Y2,Z=1,PX1=16.5,PY1=16.5,PX2=16.5,PY2=16.5)
	var/turf/T
	if(X1==X2)
		if(Y1==Y2)
			return 1 //Light cannot be blocked on same tile
		else
			var/s = SIGN(Y2-Y1)
			Y1+=s
			while(Y1!=Y2)
				T=locate(X1,Y1,Z)
				if(T.opacity)
					return 0
				Y1+=s
	else
		var/m=(32*(Y2-Y1)+(PY2-PY1))/(32*(X2-X1)+(PX2-PX1))
		var/b=(Y1+PY1/32-0.015625)-m*(X1+PX1/32-0.015625) //In tiles
		var/signX = SIGN(X2-X1)
		var/signY = SIGN(Y2-Y1)
		if(X1<X2)
			b+=m
		while(X1!=X2 || Y1!=Y2)
			if(round(m*X1+b-Y1))
				Y1+=signY //Line exits tile vertically
			else
				X1+=signX //Line exits tile horizontally
			T=locate(X1,Y1,Z)
			if(T.opacity)
				return 0
	return 1
#undef SIGNV


/proc/isInSight(atom/A, atom/B)
	var/turf/Aturf = get_turf(A)
	var/turf/Bturf = get_turf(B)

	if(!Aturf || !Bturf)
		return 0

	if(inLineOfSight(Aturf.x,Aturf.y, Bturf.x,Bturf.y,Aturf.z))
		return 1

	else
		return 0


/proc/get_cardinal_step_away(atom/start, atom/finish) //returns the position of a step from start away from finish, in one of the cardinal directions
	//returns only NORTH, SOUTH, EAST, or WEST
	var/dx = finish.x - start.x
	var/dy = finish.y - start.y
	if(abs(dy) > abs (dx)) //slope is above 1:1 (move horizontally in a tie)
		if(dy > 0)
			return get_step(start, SOUTH)
		else
			return get_step(start, NORTH)
	else
		if(dx > 0)
			return get_step(start, WEST)
		else
			return get_step(start, EAST)


/proc/try_move_adjacent(atom/movable/AM)
	var/turf/T = get_turf(AM)
	for(var/direction in GLOB.cardinals)
		if(AM.Move(get_step(T, direction)))
			break

/proc/get_mob_by_key(key)
	var/ckey = ckey(key)
	for(var/i in GLOB.player_list)
		var/mob/M = i
		if(M.ckey == ckey)
			return M
	return null

/proc/considered_alive(datum/mind/M, enforce_human = TRUE)
	if(M && M.current)
		if(enforce_human)
			var/mob/living/carbon/human/H
			if(ishuman(M.current))
				H = M.current
			return M.current.stat != DEAD && !issilicon(M.current) && !isbrain(M.current) && (!H || H.dna.species.id != "memezombies")
		else if(isliving(M.current))
			return M.current.stat != DEAD
	return FALSE

/proc/considered_afk(datum/mind/M)
	return !M || !M.current || !M.current.client || M.current.client.is_afk()

/proc/ScreenText(obj/O, maptext="", screen_loc="CENTER-7,CENTER-7", maptext_height=480, maptext_width=480)
	if(!isobj(O))
		O = new /atom/movable/screen/text()
	O.maptext = maptext
	O.maptext_height = maptext_height
	O.maptext_width = maptext_width
	O.screen_loc = screen_loc
	return O

/// Removes an image from a client's `.images`. Useful as a callback.
/proc/remove_image_from_client(image/image, client/remove_from)
	remove_from?.images -= image

/proc/remove_images_from_clients(image/I, list/show_to)
	for(var/client/C in show_to)
		C.images -= I

/proc/flick_overlay(image/I, list/show_to, duration)
	for(var/client/C in show_to)
		C.images += I
	addtimer(CALLBACK(usr, GLOBAL_PROC_REF(remove_images_from_clients), I, show_to), duration, TIMER_CLIENT_TIME)

/proc/flick_overlay_global(image/I, list/show_to, duration)
	if(!show_to || !length(show_to) || !I)
		return
	for(var/client/add_to in show_to)
		add_to.images += I
	addtimer(CALLBACK(usr, GLOBAL_PROC_REF(remove_images_from_clients), I, show_to), duration, TIMER_CLIENT_TIME)

/proc/flick_overlay_view(image/I, atom/target, duration) //wrapper for the above, flicks to everyone who can see the target atom
	var/list/viewing = list()
	for(var/m in viewers(target))
		var/mob/M = m
		if(M.client)
			viewing += M.client
	flick_overlay(I, viewing, duration)

/proc/get_active_player_count(alive_check = 0, afk_check = 0, human_check = 0)
	// Get active players who are playing in the round
	var/active_players = 0
	for(var/i = 1; i <= GLOB.player_list.len; i++)
		var/mob/M = GLOB.player_list[i]
		if(M && M.client)
			if(alive_check && M.stat)
				continue
			else if(afk_check && M.client.is_afk())
				continue
			else if(human_check && !ishuman(M))
				continue
			else if(isnewplayer(M)) // exclude people in the lobby
				continue
			else if(isobserver(M)) // Ghosts are fine if they were playing once (didn't start as observers)
				var/mob/dead/observer/O = M
				if(O.started_as_observer) // Exclude people who started as observers
					continue
			active_players++
	return active_players

/proc/showCandidatePollWindow(mob/M, poll_time, Question, list/candidates, ignore_category, time_passed, flashwindow = TRUE)
	set waitfor = 0

	SEND_SOUND(M, 'sound/misc/notice2.ogg') //Alerting them to their consideration
	if(flashwindow)
		window_flash(M.client)
	switch(ignore_category ? askuser(M,Question,"Please answer in [DisplayTimeText(poll_time)]!","Yes","No","Never for this round", StealFocus=0, Timeout=poll_time) : askuser(M,Question,"Please answer in [DisplayTimeText(poll_time)]!","Yes","No", StealFocus=0, Timeout=poll_time))
		if(1)
			to_chat(M, span_notice("Choice registered: Yes."))
			if(time_passed + poll_time <= world.time)
				to_chat(M, span_danger("Sorry, you answered too late to be considered!"))
				SEND_SOUND(M, 'sound/machines/buzz-sigh.ogg')
				candidates -= M
			else
				candidates += M
		if(2)
			to_chat(M, span_danger("Choice registered: No."))
			candidates -= M
		if(3)
			var/list/L = GLOB.poll_ignore[ignore_category]
			if(!L)
				GLOB.poll_ignore[ignore_category] = list()
			GLOB.poll_ignore[ignore_category] += M.ckey
			to_chat(M, span_danger("Choice registered: Never for this round."))
			candidates -= M
		else
			candidates -= M

/proc/pollGhostCandidates(Question, jobbanType, datum/game_mode/gametypeCheck, be_special_flag = 0, poll_time = 300, ignore_category = null, flashwindow = TRUE)
	var/list/candidates = get_all_ghost_role_eligible()
	return pollCandidates(Question, jobbanType, gametypeCheck, be_special_flag, poll_time, ignore_category, flashwindow, candidates)

/proc/pollCandidates(Question, jobbanType, datum/game_mode/gametypeCheck, be_special_flag = 0, poll_time = 300, ignore_category = null, flashwindow = TRUE, list/group = null)
	var/time_passed = world.time
	if (!Question)
		Question = "Would you like to be a special role?"
	var/list/result = list()
	for(var/m in group)
		var/mob/M = m
		if(!M.key || !M.client || (ignore_category && GLOB.poll_ignore[ignore_category] && (M.ckey in GLOB.poll_ignore[ignore_category])))
			continue
		if(be_special_flag)
			if(!(M.client.prefs) || !(be_special_flag in M.client.prefs.be_special))
				continue
		if(gametypeCheck)
			if(!gametypeCheck.age_check(M.client))
				continue
		if(jobbanType)
			if(jobban_isbanned(M, jobbanType) || QDELETED(M) || jobban_isbanned(M, ROLE_SYNDICATE) || QDELETED(M))
				continue

		showCandidatePollWindow(M, poll_time, Question, result, ignore_category, time_passed, flashwindow)
	sleep(poll_time)

	//Check all our candidates, to make sure they didn't log off or get deleted during the wait period.
	for(var/mob/M in result)
		if(!M.key || !M.client)
			result -= M

	listclearnulls(result)

	return result

/proc/pollCandidatesForMob(Question, jobbanType, datum/game_mode/gametypeCheck, be_special_flag = 0, poll_time = 300, mob/M, ignore_category = null)
	var/list/L = pollGhostCandidates(Question, jobbanType, gametypeCheck, be_special_flag, poll_time, ignore_category)
	if(!M || QDELETED(M) || !M.loc)
		return list()
	return L

/proc/pollCandidatesForMobs(Question, jobbanType, datum/game_mode/gametypeCheck, be_special_flag = 0, poll_time = 300, list/mobs, ignore_category = null)
	var/list/L = pollGhostCandidates(Question, jobbanType, gametypeCheck, be_special_flag, poll_time, ignore_category)
	var/i=1
	for(var/v in mobs)
		var/atom/A = v
		if(!A || QDELETED(A) || !A.loc)
			mobs.Cut(i,i+1)
		else
			++i
	return L

/proc/poll_helper(mob/living/M)

/proc/makeBody(mob/dead/observer/G_found) // Uses stripped down and bastardized code from respawn character
	if(!G_found || !G_found.key)
		return

	//First we spawn a dude.
	var/mob/living/carbon/human/new_character = new//The mob being spawned.
	SSjob.SendToLateJoin(new_character)

	G_found.client.prefs.copy_to(new_character)
	new_character.dna.update_dna_identity()
	G_found.transfer_ckey(new_character, FALSE)

	return new_character

/proc/send_to_playing_players(thing) //sends a whatever to all playing players; use instead of to_chat(world, where needed)
	for(var/M in GLOB.player_list)
		if(M && !isnewplayer(M))
			to_chat(M, thing)

/proc/window_flash(client/C, ignorepref = FALSE)
	if(ismob(C))
		var/mob/M = C
		if(M.client)
			C = M.client
	if(!C || (!C.prefs.windowflashing && !ignorepref))
		return
	winset(C, "mainwindow", "flash=5")

//Recursively checks if an item is inside a given type, even through layers of storage. Returns the atom if it finds it.
/proc/recursive_loc_check(atom/movable/target, type)
	var/atom/A = target
	if(istype(A, type))
		return A

	while(!istype(A.loc, type))
		if(!A.loc)
			return
		A = A.loc

	return A.loc

/proc/AnnounceArrival(mob/living/carbon/human/character, rank)
	if(!SSticker.IsRoundInProgress() || QDELETED(character))
		return
	var/area/A = get_area(character)
	var/message = "<span class='game deadsay'><span class='name'>\
		[character.real_name]</span> ([rank]) has entered the wasteland at \
		<span class='name'>[A.name]</span>.</span>"
	deadchat_broadcast(message, follow_target = character, message_type=DEADCHAT_ARRIVALRATTLE)
	if((!GLOB.announcement_systems.len) || (!character.mind))
		return
	if((character.mind.assigned_role == "Cyborg") || (character.mind.assigned_role == character.mind.special_role))
		return

	var/obj/machinery/announcement_system/announcer = pick(GLOB.announcement_systems)
	announcer.announce("ARRIVAL", character.real_name, rank, list()) //make the list empty to make it announce it in common

/proc/lavaland_equipment_pressure_check(turf/T)
	. = FALSE
	if(!istype(T))
		return
	var/datum/gas_mixture/environment = T.return_air()
	if(!istype(environment))
		return
	var/pressure = environment.return_pressure()
	if(pressure <= LAVALAND_EQUIPMENT_EFFECT_PRESSURE)
		. = TRUE

/proc/ispipewire(item)
	var/static/list/pipe_wire = list(
		/obj/machinery/atmospherics,
		/obj/structure/disposalpipe,
		/obj/structure/cable
	)
	return (is_type_in_list(item, pipe_wire))

/// Find a obstruction free turf that's within the range of the center. Can also condition on if it is of a certain area type.
/proc/find_obstruction_free_location(range, atom/center, area/specific_area, only_my_area, only_in_view)
	var/list/turfs = RANGE_TURFS(range, center)
	var/list/turfs_view = list()
	var/list/possible_loc = list()
	var/area/center_area
	var/turf/L
	if(only_in_view)
		L = get_turf(center)
		for(var/turf/T in view(range, L))
			turfs_view += T
	if(only_my_area)
		center_area = get_area(center)
	for(var/turf/found_turf in turfs)
		var/area/turf_area = get_area(found_turf)
		if(specific_area && !istype(turf_area, specific_area))	// We check if both the turf is a floor, and that it's actually in the area. // We also want a location that's clear of any obstructions.
			continue
		if(only_my_area && !istype(turf_area, center_area))	// We check if both the turf is a floor, and that it's actually in the area. // We also want a location that's clear of any obstructions.
			continue
		if(only_in_view && !(found_turf in turfs_view))
			continue
		if(isspaceturf(found_turf))
			continue
		if(is_blocked_turf(found_turf))
			continue
		possible_loc.Add(found_turf)
	if(possible_loc.len < 1)	// Need at least one free location.
		return FALSE
	return pick(possible_loc)

/proc/power_fail(duration_min, duration_max)
	for(var/P in GLOB.apcs_list)
		var/obj/machinery/power/apc/C = P
		if(C.cell && SSmapping.level_trait(C.z, ZTRAIT_STATION))
			var/area/A = C.area
			if(GLOB.typecache_powerfailure_safe_areas[A.type])
				continue
			C.energy_fail(rand(duration_min,duration_max))
