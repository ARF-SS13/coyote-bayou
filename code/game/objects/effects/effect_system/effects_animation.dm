
/atom/proc/Shake(pixelshiftx = 15, pixelshifty = 15, duration = 250)
	var/initialpixelx = pixel_x
	var/initialpixely = pixel_y
	var/shiftx = rand(-pixelshiftx,pixelshiftx)
	var/shifty = rand(-pixelshifty,pixelshifty)
	animate(src, pixel_x = pixel_x + shiftx, pixel_y = pixel_y + shifty, time = 0.2, loop = duration)
	pixel_x = initialpixelx
	pixel_y = initialpixely

/atom/proc/do_jiggle(targetangle = 45, timer = 20)
	var/matrix/OM = matrix(transform)
	var/matrix/M = matrix(transform)
	var/halftime = timer * 0.5
	M.Turn(pick(-targetangle, targetangle))
	animate(src, transform = M, time = halftime, easing = ELASTIC_EASING)
	animate(transform = OM, time = halftime, easing = ELASTIC_EASING)

/atom/proc/do_squish(squishx = 1.2, squishy = 0.6, timer = 20)
	var/matrix/OM = matrix(transform)
	var/matrix/M = matrix(transform)
	var/halftime = timer * 0.5
	M.Scale(squishx, squishy)
	animate(src, transform = M, time = halftime, easing = BOUNCE_EASING)
	animate(transform = OM, time = halftime, easing = BOUNCE_EASING)

/atom/proc/do_directional_tilt(degrees = 5, full_duration = 0.5 SECONDS)
	var/matrix/m1 = matrix(transform)
	var/matrix/og = matrix(transform)
	switch(dir)
		if(EAST)
			m1.Turn(degrees)
		if(WEST)
			m1.Turn(-degrees)
		if(NORTH, SOUTH)
			m1.Turn(degrees * pick(1, -1))
	animate(src, transform = m1, time = (full_duration * 0.5), easing = BOUNCE_EASING)
	animate(transform = og, time = (full_duration * 0.5), easing = BOUNCE_EASING)

/atom/proc/do_double_bounce(move_1 = 3, move_2 = -1, move_3 = 2, move_4 = -2, full_duration = 1 SECONDS)
	var/matrix/m1 = matrix(transform)
	var/matrix/m2 = matrix(transform)
	var/matrix/m3 = matrix(transform)
	var/matrix/m4 = matrix(transform)
	var/matrix/og = matrix(transform)
	m1.Translate(0, move_1)
	m2.Translate(0, move_2)
	m3.Translate(0, move_3)
	m4.Translate(0, move_4)
	animate(src, transform = m1, time = (full_duration * 0.20), easing = BOUNCE_EASING)
	animate(transform = m2, time = (full_duration * 0.30), easing = BOUNCE_EASING)
	animate(transform = m3, time = (full_duration * 0.30), easing = BOUNCE_EASING)
	animate(transform = m4, time = (full_duration * 0.20), easing = BOUNCE_EASING)
	animate(transform = og, time = (full_duration * 0.20), easing = BOUNCE_EASING)

/proc/flash_color(mob_or_client, flash_color="#960000", flash_time=20)
	var/client/C
	if(ismob(mob_or_client))
		var/mob/M = mob_or_client
		if(M.client)
			C = M.client
		else
			return
	else if(istype(mob_or_client, /client))
		C = mob_or_client

	if(!istype(C))
		return

	var/animate_color = C.color
	C.color = flash_color
	animate(C, color = animate_color, time = flash_time)

#define RANDOM_COLOUR (rgb(rand(0,255),rand(0,255),rand(0,255)))


