/mob/living/silicon/robot/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	adjustOxyLoss(-10) //we're a robot!
	handle_robot_hud_updates()
	handle_robot_cell()

/mob/living/silicon/robot/proc/handle_robot_cell()
	if(stat != DEAD)
		if(low_power_mode)
			if(cell && cell.charge)
				low_power_mode = 0
				update_headlamp()
		else if(stat == CONSCIOUS)
			use_power()

/mob/living/silicon/robot/proc/use_power()
	if(cell && cell.charge)
		if(cell.charge <= 100)
			uneq_all()
		var/amt = clamp((lamp_intensity - 2) * 2,1,cell.charge) //Always try to use at least one charge per tick, but allow it to completely drain the cell.
		cell.use(amt) //Usage table: 1/tick if off/lowest setting, 4 = 4/tick, 6 = 8/tick, 8 = 12/tick, 10 = 16/tick
	else
		uneq_all()
		low_power_mode = 1
		update_headlamp()
	diag_hud_set_borgcell()

/mob/living/silicon/robot/proc/handle_robot_hud_updates()
	if(!client)
		return

	update_cell_hud_icon()

/mob/living/silicon/robot/update_health_hud()
	if(!client || !hud_used)
		return
	if(hud_used.healths)
		if(stat != DEAD)
			if(!health)
				health = health
			if(health >= maxHealth)
				hud_used.healths.icon_state = "health0"
			else if(health > maxHealth*0.95)
				hud_used.healths.icon_state = "health1"
			else if(health > maxHealth*0.9)
				hud_used.healths.icon_state = "health2"
			else if(health > maxHealth*0.85)
				hud_used.healths.icon_state = "health3"
			else if(health > maxHealth*0.80)
				hud_used.healths.icon_state = "health4"
			else if(health > maxHealth*0.75)
				hud_used.healths.icon_state = "health5"
			else if(health > maxHealth*0.70)
				hud_used.healths.icon_state = "health6"
			else if(health > maxHealth*0.65)
				hud_used.healths.icon_state = "health7"
			else if(health > maxHealth*0.60)
				hud_used.healths.icon_state = "health8"
			else if(health > maxHealth*0.55)
				hud_used.healths.icon_state = "health9"
			else if(health > maxHealth*0.50)
				hud_used.healths.icon_state = "health10"
			else if(health > maxHealth*0.45)
				hud_used.healths.icon_state = "health11"
			else if(health > maxHealth*0.40)
				hud_used.healths.icon_state = "health12"
			else if(health > maxHealth*0.35)
				hud_used.healths.icon_state = "health13"
			else if(health > maxHealth*0.30)
				hud_used.healths.icon_state = "health14"
			else if(health > maxHealth*0.25)
				hud_used.healths.icon_state = "health15"
			else if(health > maxHealth*0.20)
				hud_used.healths.icon_state = "health16"
			else if(health > maxHealth*0.15)
				hud_used.healths.icon_state = "health17"
			else if(health > maxHealth*0.10)
				hud_used.healths.icon_state = "health18"
			else if(health > maxHealth*0.05)
				hud_used.healths.icon_state = "health19"
			else if(health > 0)
				hud_used.healths.icon_state = "health19"
			else
				hud_used.healths.icon_state = "health20"
		else
			hud_used.healths.icon_state = "health21"

/mob/living/silicon/robot/proc/update_cell_hud_icon()
	if(cell)
		var/cellcharge = cell.charge/cell.maxcharge
		switch(cellcharge)
			if(0.75 to INFINITY)
				clear_alert("charge")
			if(0.5 to 0.75)
				throw_alert("charge", /atom/movable/screen/alert/lowcell, 1)
			if(0.25 to 0.5)
				throw_alert("charge", /atom/movable/screen/alert/lowcell, 2)
			if(0.01 to 0.25)
				throw_alert("charge", /atom/movable/screen/alert/lowcell, 3)
			else
				throw_alert("charge", /atom/movable/screen/alert/emptycell)
	else
		throw_alert("charge", /atom/movable/screen/alert/nocell)

//Robots on fire
/mob/living/silicon/robot/handle_fire()
	if(..())
		return
	if(fire_stacks > 0)
		fire_stacks--
		fire_stacks = max(0, fire_stacks)
	else
		ExtinguishMob()

	//adjustFireLoss(3)
	return

/mob/living/silicon/robot/update_fire()
	var/mutable_appearance/fire_overlay = mutable_appearance('icons/mob/OnFire.dmi', "Generic_mob_burning")
	if(on_fire)
		add_overlay(fire_overlay)
	else
		cut_overlay(fire_overlay)
