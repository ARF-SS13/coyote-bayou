/* A few definitions of terms
 * spread - Inaccuracy of the mob firing it, usually recoil
 * distro - Inaccuracy of the gun being fired, added to spread
 * variance - Inaccuracy of the cartridge being fired, added to spread
 *          - Unless it has more than 1 pellet, then its the width of the spray and doesnt contribute to base inaccuracy. Yeah I know its fucked, deal with it
 * BB.spread - Inaccuracy of the projectile being fired, also added to spread
 * Final spread out, for shotguns, is the angle that the spray pattern will be centered on
 */
/obj/item/ammo_casing/proc/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, damage_multiplier = 1, penetration_multiplier = 1, projectile_speed_multiplier = 1, atom/fired_from)
	var/angle_out = 0
	if(randomspread) // usually true
		if(HAS_TRAIT(user,TRAIT_INSANE_AIM))
			angle_out = 0 // nice shot
		else
			var/max_spread = spread + distro + (pellets == 1 ? variance : 0) // hooray vars doing double duty
			if(istype(BB))
				max_spread += BB.spread
			if(HAS_TRAIT(user,TRAIT_FEV)) //You really shouldn't try this at home.
				max_spread += 3 //YOU AINT HITTING SHIT BROTHA. REALLY.
			if(HAS_TRAIT(user,TRAIT_NEARSIGHT)) //Yes.
				max_spread += 0.2 //You're slightly less accurate because you can't see well - as an upside, lasers don't suffer these penalties!
			if(HAS_TRAIT(user,TRAIT_POOR_AIM)) //You really shouldn't try this at home.
				max_spread += 1.5//This is cripplingly bad. Trust me.
			if(HAS_TRAIT(user,TRAIT_NICE_SHOT)) // halves your inaccuracy!
				max_spread *= 0.5 // Nice shot!
			angle_out = clamp(rand(-max_spread, max_spread), -MAX_ACCURACY_OFFSET, MAX_ACCURACY_OFFSET)

	var/targloc = get_turf(target)
	ready_proj(target, user, quiet, zone_override, damage_multiplier, penetration_multiplier, projectile_speed_multiplier, fired_from, damage_threshold_penetration)
	if(pellets == 1)
		if(!randomspread) //Smart spread
			angle_out = round(1 - 0.5) * distro
		if(!throw_proj(target, targloc, user, params, angle_out))
			return FALSE
	else
		if(isnull(BB))
			return FALSE
		AddComponent(/datum/component/pellet_cloud, projectile_type, pellets)
		SEND_SIGNAL(src, COMSIG_PELLET_CLOUD_INIT, target, user, fired_from, randomspread, (variance * HAS_TRAIT(user,TRAIT_INSANE_AIM) ? 0.5 : 1), zone_override, params, angle_out)

	user.DelayNextAction(considered_action = TRUE, immediate = FALSE)
	user.newtonian_move(get_dir(target, user))
	update_icon()
	return 1

/obj/item/ammo_casing/proc/ready_proj(atom/target, mob/living/user, quiet, zone_override = "", damage_multiplier = 1, penetration_multiplier = 1, projectile_speed_multiplier = 1, fired_from, damage_threshold_penetration = 0)
	if (!BB)
		return
	BB.original = target
	BB.firer = user
	BB.fired_from = fired_from
	if (zone_override)
		BB.def_zone = zone_override
	else
		BB.def_zone = user.zone_selected
	BB.suppressed = quiet
	BB.damage_threshold_penetration = damage_threshold_penetration

	if(isgun(fired_from))
		var/obj/item/gun/G = fired_from
		BB.damage *= G.damage_multiplier
		BB.armour_penetration *= G.penetration_multiplier
		BB.pixels_per_second *= G.projectile_speed_multiplier
		if(BB.zone_accuracy_type == ZONE_WEIGHT_GUNS_CHOICE)
			BB.zone_accuracy_type = G.get_zone_accuracy_type()
		if(HAS_TRAIT(user, TRAIT_INSANE_AIM))
			BB.ricochets_max = max(BB.ricochets_max, 10) //bouncy!
			BB.ricochet_chance = max(BB.ricochet_chance, 100) //it wont decay so we can leave it at 100 for always bouncing
			BB.ricochet_auto_aim_range = max(BB.ricochet_auto_aim_range, 3)
			BB.ricochet_auto_aim_angle = max(BB.ricochet_auto_aim_angle, 360) //it can turn full circle and shoot you in the face because our aim? is insane.
			BB.ricochet_decay_chance = 0
			BB.ricochet_decay_damage = max(BB.ricochet_decay_damage, 0.1)
			BB.ricochet_incidence_leeway = 0

	if(reagents && BB.reagents)
		reagents.trans_to(BB, reagents.total_volume) //For chemical darts/bullets
		qdel(reagents)

/obj/item/ammo_casing/proc/throw_proj(atom/target, turf/targloc, mob/living/user, params, spread)
	var/turf/curloc = get_turf(user)
	if (!istype(targloc) || !istype(curloc) || !BB)
		return 0

	var/firing_dir
	if(BB.firer)
		firing_dir = BB.firer.dir
	if(!BB.suppressed && firing_effect_type)
		new firing_effect_type(get_turf(src), firing_dir)

	var/direct_target
	if(targloc == curloc)
		if(target) //if the target is right on our location we'll skip the travelling code in the proj's fire()
			direct_target = target
	if(!direct_target)
		BB.preparePixelProjectile(target, user, params, spread)
	BB.fire(null, direct_target, spread)
	BB = null
	deduct_powder_and_bullet_mats()
	return 1

/obj/item/ammo_casing/proc/spread(turf/target, turf/current, distro)
	var/dx = abs(target.x - current.x)
	var/dy = abs(target.y - current.y)
	return locate(target.x + round(gaussian(0, distro) * (dy+2)/8, 1), target.y + round(gaussian(0, distro) * (dx+2)/8, 1), target.z)
