/mob/living/carbon/adjustStaminaLossBuffered(amount, updating_health = 1)
	if(status_flags & GODMODE)
		return 0
	if(CONFIG_GET(flag/disable_stambuffer))
		return
	var/directstamloss = (bufferedstam + amount) - stambuffer
	if(directstamloss > 0)
		adjustStaminaLoss(directstamloss)
	bufferedstam = clamp(bufferedstam + amount, 0, stambuffer)
	stambufferregentime = world.time + 10
	if(updating_health)
		update_health_hud()

/mob/living/carbon/adjustStaminaLoss(amount, updating_health = TRUE, forced = FALSE, affected_zone = BODY_ZONE_CHEST)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	var/end_mod = 1
	switch(get_stat(STAT_ENDURANCE)) // COOLSTAT IMPLEMENTATION: ENDURANCE
		if(0, 1)
			end_mod = 4
		if(2)
			end_mod = 3
		if(3)
			end_mod = 2
		if(4)
			end_mod = 1.5
		if(5)
			end_mod = 1
		if(6)
			end_mod = 0.90
		if(7)
			end_mod = 0.80
		if(8)
			end_mod = 0.65
		if(9)
			end_mod = 0.45
	amount *= end_mod
	var/obj/item/bodypart/BP = isbodypart(affected_zone)? affected_zone : (get_bodypart(check_zone(affected_zone)) || bodyparts[1])
	if(amount > 0? BP.receive_damage(0, 0, amount * incomingstammult) : BP.heal_damage(0, 0, abs(amount), FALSE, FALSE))
		update_damage_overlays()
	if(updating_health)
		updatehealth()
	update_stamina()
	if((combat_flags & COMBAT_FLAG_HARD_STAMCRIT) && amount > 20)
		incomingstammult = max(0.01, incomingstammult/(amount*0.05))
	return amount
