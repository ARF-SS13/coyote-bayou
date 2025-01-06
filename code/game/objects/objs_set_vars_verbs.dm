GLOBAL_LIST_INIT(obj_vars_allowed_to_modify, list(
	//"None" 			= 0,
	"Pixel Offset"	= 1,
	"Rotate" 		= 2,
	"Layer" 		= 3))


/mob/living/verb/objs_edit_vars(atom/A as obj in view(1))
	set name = "Adjust Object (Shift, Rotate, Layer)."
	set category = "Object"

	//Blacklist of stuff that isn't allowed to be modified, such as trees
	if(	istype(A, /obj/structure/flora) || \
		istype(A, /obj/machinery/door/poddoor))

		to_chat(src, span_danger("I can't move that!"))
		return

	var/do_after_delay 			= 1 SECONDS
	var/playsound_volume 		= 50
	var/playsound_audio 		= 'sound/effects/stonedoor_openclose.ogg'
	var/max_pixel_shift_allowed = 16
	var/max_tilt_shift_allowed	= 180
	var/max_layer_shift_allowed = 40

	var/input = input("Choose the variable you would like to edit", "Edit Variables: [src]") as null|anything in GLOB.obj_vars_allowed_to_modify
	if(input)
		input = GLOB.obj_vars_allowed_to_modify[input]

	switch(input)
		if(0)
			return

		if(1)  //Edit pixel shift
			input = input("Choose between coordinate X or Y", "Pixel Shift of: [src]") as null|anything in list("Edit X", "Edit Y", "Reset to initial")

			if(input == "Edit X")
				input = input("Insert new pixel offset (-[max_pixel_shift_allowed] to +[max_pixel_shift_allowed]) \nCurrent X: [A.pixel_x]", "[input]:") as null|num
				if(input && (input >= -max_pixel_shift_allowed && input <= max_pixel_shift_allowed))
					playsound(A.loc, playsound_audio, playsound_volume, TRUE)
					if(do_after(src, do_after_delay, target = A))
						visible_message(span_notice("[src] pushes \the [A] to off-center it to the perfect spot!"))
						A.pixel_x = input
				else if(input < -max_pixel_shift_allowed || input > max_pixel_shift_allowed)
					to_chat(src, span_danger("Selected value is out of allowed bounds!"))
					return
				return

			else if(input == "Edit Y")
				input = input("Insert new pixel offset (-[max_pixel_shift_allowed] to +[max_pixel_shift_allowed]) \nCurrent Y: [A.pixel_y]", "[input]:") as null|num
				if(input && (input >= -max_pixel_shift_allowed && input <= max_pixel_shift_allowed))
					playsound(A.loc, playsound_audio, playsound_volume, TRUE)
					if(do_after(src, do_after_delay, target = A))
						visible_message(span_notice("[src] pushes \the [A] to off-center it to the perfect spot!"))
						A.pixel_y = input
				else if(input < -max_pixel_shift_allowed || input > max_pixel_shift_allowed)
					to_chat(src, span_danger("Selected value is out of allowed bounds!"))
					return
				return
			
			else if(input == "Reset to initial")				
				playsound(A.loc, playsound_audio, playsound_volume, TRUE)
				if(do_after(src, do_after_delay, target = A))
					visible_message(span_notice("[src] pushes \the [A] to its original place!"))
					A.pixel_x = initial(A.pixel_x)
					A.pixel_y = initial(A.pixel_y)
				return

		if(2)  //Edit rotation
			if(istype(A, /obj))  //let's actually be super sure this is an object
				var/obj/O = A
				input = input("What angle would you like to rotate \the [O] to? (-[max_tilt_shift_allowed] to +[max_tilt_shift_allowed]) \nCurrent rotation: [O.is_tilted]", "Rotation of: [src]") as null|num
				if(input >= -max_tilt_shift_allowed && input <= max_tilt_shift_allowed)
					playsound(O.loc, playsound_audio, playsound_volume, TRUE)
					if(do_after(src, do_after_delay, target = O))
						visible_message(span_notice("[src] rotates [O] [input] degrees."))
						O.transform = O.transform.Turn(-O.is_tilted)
						O.transform = O.transform.Turn(input)
						O.is_tilted = input
				else if(input < -max_tilt_shift_allowed || input > max_tilt_shift_allowed)
					to_chat(src, span_danger("Selected value is out of allowed bounds!"))
					return

		if(3)  //Edit Layer
			input = input("Choose if you'd like to change layer value or reset:", "Layer of: [src]") as null|anything in list("Change Layer", "Reset to initial")

			if(input == "Change Layer")
				input = input("Insert new layer offset (-[max_layer_shift_allowed] to +[max_layer_shift_allowed]) \nCurrent layer: [A.layer]", "[input]:") as null|num
				if(input && (input >= -max_layer_shift_allowed && input <= max_layer_shift_allowed))
					playsound(A.loc, playsound_audio, playsound_volume, TRUE)
					if(do_after(src, do_after_delay, target = A))
						visible_message(span_notice("[src] shifts \the [A] to the perfect spot!"))
						A.layer = initial(A.layer)
						A.layer += input
				else if(input < -max_layer_shift_allowed || input > max_layer_shift_allowed)
					to_chat(src, span_danger("Selected value is out of allowed bounds!"))
					return
				return

			else if(input == "Reset to initial")				
				playsound(A.loc, playsound_audio, playsound_volume, TRUE)
				if(do_after(src, do_after_delay, target = A))
					visible_message(span_notice("[src] pushes \the [A] to its original layer!"))
					A.layer = initial(A.layer)
				return

