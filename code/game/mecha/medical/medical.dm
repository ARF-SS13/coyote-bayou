/obj/mecha/medical
	exit_delay = 25
	enter_delay = 25
	deflect_chance = 0
	light_power = 9
	light_range = 10
	max_equip = 4

/obj/mecha/medical/mechturn(direction)
	setDir(direction)
	playsound(src,'sound/mecha/mechmove01.ogg',40,1)
	return 1

/obj/mecha/medical/mechstep(direction)
	var/result = step(src,direction)
	if(result)
		playsound(src,'sound/mecha/mechstep.ogg',25,1)
	return result

/obj/mecha/medical/mechsteprand()
	var/result = step_rand(src)
	if(result)
		playsound(src,'sound/mecha/mechstep.ogg',25,1)
	return result
