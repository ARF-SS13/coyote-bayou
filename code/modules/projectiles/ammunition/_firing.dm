/* A few definitions of terms
 * spread - Inaccuracy of the mob firing it, usually recoil
 * distro - Inaccuracy of the gun being fired, added to spread
 * variance - Inaccuracy of the cartridge being fired, added to spread
 *          - Unless it has more than 1 pellet, then its the width of the spray and doesnt contribute to base inaccuracy. Yeah I know its fucked, deal with it
 * BB.spread - Inaccuracy of the projectile being fired, also added to spread
 * Final spread out, for shotguns, is the angle that the spray pattern will be centered on
 */
/obj/item/ammo_casing/proc/fire_casing(
	atom/target,
	mob/living/user,
	params,
	distro,
	quiet,
	zone_override,
	spread,
	damage_multiplier = 1,
	penetration_multiplier = 1,
	projectile_speed_multiplier = 1,
	atom/fired_from
)
	var/angle_out = calc_spread(user, spread, distro, (pellets == 1 ? variance : 0), fired_from)

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
		var/varaiance_multiplier = 1
		if(HAS_TRAIT(user, TRAIT_NICE_SHOT))
			varaiance_multiplier = 0.65
		SEND_SIGNAL(
			src,\
			COMSIG_PELLET_CLOUD_INIT,\
			target,\
			user,\
			fired_from,\
			randomspread,\
			angle_out,\
			zone_override,\
			params,\
			(variance * varaiance_multiplier)) // great googly moogly Ive had this backwards for HOW many years?

	if(istype(user))
		user.DelayNextAction(considered_action = TRUE, immediate = FALSE)
		user.newtonian_move(get_dir(target, user))
	update_icon()
	return 1

/obj/item/ammo_casing/proc/calc_spread(mob/living/user, spread = 0, distro = 0, variance = 0, atom/fired_from)
	. = 0
	if(!randomspread) // usually true
		return 0
	if(!isliving(user))
		return 0
	var/gun_bullet_spread = 0
	gun_bullet_spread += BB?.spread || 0 // bullet's inherent inaccuracy
	gun_bullet_spread += distro || 0 // gun's inaccuracy
	gun_bullet_spread += variance || 0 // cartridge's inaccuracy
	if(!user.client) // ai
		return rand(-gun_bullet_spread, gun_bullet_spread)
	. = SSrecoil.get_output_offset(gun_bullet_spread, user, fired_from)

/obj/item/ammo_casing/proc/ready_proj(atom/target, mob/living/user, quiet, zone_override = "", damage_multiplier = 1, penetration_multiplier = 1, projectile_speed_multiplier = 1, fired_from, damage_threshold_penetration = 0)
	if (!BB)
		return
	BB.original = target
	BB.firer = user
	var/shooter_living = istype(user)
	var/am_player = isplayer(user)
	if(shooter_living)
		if((am_player && !user.enabled_combat_indicator) || !am_player)
			BB.factionize(user.faction)
			BB.safety_switch = TRUE // disabled the factionize after it range from shooterd
			BB.is_player_projectile = TRUE
	else if(isliving(user) || istype(user, /obj/machinery/porta_turret))
		BB.factionize(user.faction) // 'faction' is on both types, but arent eh same var, thanks for telling me that that works (and to never use it), Pali!
	BB.fired_from = fired_from
	if (zone_override)
		BB.def_zone = zone_override
	else if (shooter_living)
		BB.def_zone = user.zone_selected
	else
		BB.def_zone = BODY_ZONE_CHEST
	BB.suppressed = quiet
	BB.damage_threshold_penetration = damage_threshold_penetration
	if(shooter_living && HAS_TRAIT(user,TRAIT_PANICKED_ATTACKER))
		BB.damage_mod *= 0.2 // lol

	if(isgun(fired_from))
		var/obj/item/gun/G = fired_from
		G.post_modify_projectile(BB)
		//BB.damage *= G.damage_multiplier
		BB.damage_mod = G.damage_multiplier
		BB.armour_penetration *= G.penetration_multiplier
		BB.pixels_per_second *= G.projectile_speed_multiplier
		if(BB.zone_accuracy_type == ZONE_WEIGHT_GUNS_CHOICE)
			BB.zone_accuracy_type = G.get_zone_accuracy_type()
		//SEND_SIGNAL(src, COMSIG_GUN_SHOT, BB, G) // time to modify it more uwu
		/* if(HAS_TRAIT(user, TRAIT_CRIT_SHOT)) // imma spend 12 points to shoot myself in the face
			BB.ricochets_max = max(BB.ricochets_max, 10) //bouncy!
			BB.ricochet_chance = max(BB.ricochet_chance, 100) //it wont decay so we can leave it at 100 for always bouncing
			BB.ricochet_auto_aim_range = max(BB.ricochet_auto_aim_range, 3)
			BB.ricochet_auto_aim_angle = max(BB.ricochet_auto_aim_angle, 360) //it can turn full circle and shoot you in the face because our aim? is insane.
			BB.ricochet_decay_chance = 0
			BB.ricochet_decay_damage = max(BB.ricochet_decay_damage, 0.1)
			BB.ricochet_incidence_leeway = 0 */

	if(reagents && BB.reagents)
		reagents.trans_to(BB, reagents.total_volume) //For chemical darts/bullets
		qdel(reagents)

/obj/item/ammo_casing/proc/throw_proj(atom/target, turf/targloc, mob/living/user, params, spread)
	var/turf/curloc = get_turf(user) || get_turf(src)
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
		BB.preparePixelProjectile(target, (user || src), params, spread)
	var/angle = text2num(params2list(params)["angle"])
	BB.fire(angle, direct_target, spread)
	BB = null
	spend_casing()
	return 1

/obj/item/ammo_casing/proc/spread(turf/target, turf/current, distro)
	var/dx = abs(target.x - current.x)
	var/dy = abs(target.y - current.y)
	return locate(target.x + round(gaussian(0, distro) * (dy+2)/8, 1), target.y + round(gaussian(0, distro) * (dx+2)/8, 1), target.z)

/obj/item/ammo_casing/proc/factionize(list/faction)
	if(!BB || !LAZYLEN(faction))
		return
	BB.factionize(faction)
