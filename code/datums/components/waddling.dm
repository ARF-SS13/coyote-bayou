// Base Waddle - The most 'normal' waddle
/datum/component/waddling
	var/waddle_amount = 4 //Upwards waddle amount.  Side to side is number times two.
	var/up_waddle_time = 1 //How fast the mob wobbles upwards.
	var/side_waddle_time = 2 //How fast the mob wobbles side to side.
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/waddling/Initialize(amount_to_waddle, amount_to_bob_up, amount_to_bob_side)
	if(!ismovableatom(parent))
		return COMPONENT_INCOMPATIBLE
	if(!isnull(amount_to_waddle))
		waddle_amount = amount_to_waddle
	if(!isnull(amount_to_bob_up))
		up_waddle_time = amount_to_bob_up
	if(!isnull(amount_to_bob_side))
		side_waddle_time = amount_to_bob_side
	RegisterSignal(parent, list(COMSIG_MOVABLE_MOVED), .proc/Waddle)

/datum/component/waddling/proc/Waddle()
	if(isliving(parent))
		var/mob/living/L = parent
		if(L.incapacitated() || L.lying)
			return
	animate(parent, pixel_z = waddle_amount, time = up_waddle_time) //Upwards wobbling
	animate(pixel_z = 0, transform = turn(matrix(), pick(-waddle_amount*2, 0, waddle_amount*2)), time=side_waddle_time) //sideways wobbling  Format Left, where to recenter, right.  Then time in deciseconds
	animate(pixel_z = 0, transform = matrix(), time = 0) //Reset point when mob stops moving
