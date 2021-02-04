#define ARMORID "armor-[linemelee]-[linebullet]-[linelaser]-[energy]-[bomb]-[bio]-[rad]-[fire]-[acid]-[magic]-[wound]-[melee]-[bullet]-[laser]-[tier]"

/proc/getArmor(linemelee = 0, linebullet = 0, linelaser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0, magic = 0, wound = 0, melee = 0, bullet = 0, laser = 0, tier = 0,)
	. = locate(ARMORID)
	if (!.)
		. = new /datum/armor(linemelee, linebullet, linelaser, energy, bomb, bio, rad, fire, acid, magic, wound, melee, bullet, laser, tier)

/datum/armor
	datum_flags = DF_USE_TAG
	var/tier  //1 to 11. Tier 1 - thin clothing, 2 - thick clothing , 3 - armored jackets, 4 - low quality/light armor, 5 - medium qual armor, 6 - medium high, 7 - high, 8 - exceptional/low qual PA, 9 - t45, 10 - t51, 11 - t60
	var/linemelee
	var/linebullet
	var/linelaser 
	var/energy
	var/bomb
	var/bio
	var/rad
	var/fire
	var/acid
	var/magic
	var/wound
	var/melee
	var/bullet
	var/laser
	var/tierline = list(10, 20, 45, 60, 75, 90, 105, 125, 150, 175, 200)

/datum/armor/New(linemelee = 0, linebullet = 0, linelaser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0, magic = 0, wound = 0, melee = 0, bullet = 0, laser = 0, tier = 0)
	
	if(tier) //ASSIGNS ARMOR VALUES BASED ON TIER, IT WILL USE ARMOR VALUES INSTEAD OF THE TIER FOR THAT VALUE IF THE ARMOR VALUE IS PRESENT
		if(!linemelee)
			linemelee = tierline[tier]
		if(!linebullet)
			linebullet = tierline[tier]
		if(!linelaser)
			linelaser = tierline[tier]

	src.linemelee = linemelee
	src.linebullet = linebullet
	src.linelaser = linelaser
	src.energy = energy
	src.bomb = bomb
	src.bio = bio
	src.rad = rad
	src.fire = fire
	src.acid = acid
	src.magic = magic
	src.wound = wound
//DESERT ROSE 2 LINEARMOR EXPLAINED: Heavily influenced by this Skyrim mod https://www.nexusmods.com/skyrim/mods/15860 % damage reduction is exponential (E.G. 90 doubles the effective health increase of 80).
//Linearmor is linear (so 100 armor is twice 50). Linearmor will never equal 100 armor. If a mob were to have 100 health, each point of linearmor would be the equivalent to +1 effective health. For example, 100 linearmor = 200 effective health or 50% damage reduction.
	src.melee = 100*linemelee/(abs(linemelee)+100) || melee
	src.bullet = 100*linebullet/(abs(linebullet)+100) || bullet
	src.laser = 100*linelaser/(abs(linelaser)+100) || laser

	src.tier = 0
	tag = ARMORID

/datum/armor/proc/modifyRating(linemelee = 0, linebullet = 0, linelaser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0, magic = 0, wound = 0)
	return getArmor(src.linemelee+linemelee, src.linebullet+linebullet, src.linelaser+linelaser, src.energy+energy, src.bomb+bomb, src.bio+bio, src.rad+rad, src.fire+fire, src.acid+acid, src.magic+magic, src.wound+wound)

/datum/armor/proc/modifyAllRatings(modifier = 0)
	return getArmor(linemelee+modifier, linebullet+modifier, linelaser+modifier, energy+modifier, bomb+modifier, bio+modifier, rad+modifier, fire+modifier, acid+modifier, magic+modifier, wound+modifier)

/datum/armor/proc/setRating(linemelee, linebullet, linelaser, energy, bomb, bio, rad, fire, acid, magic, wound, melee, bullet, laser, tier)
	return getArmor((isnull(linemelee) ? src.linemelee : linemelee),\
					(isnull(linebullet) ? src.linebullet : linebullet),\
					(isnull(linelaser) ? src.linelaser : linelaser),\
					(isnull(energy) ? src.energy : energy),\
					(isnull(bomb) ? src.bomb : bomb),\
					(isnull(bio) ? src.bio : bio),\
					(isnull(rad) ? src.rad : rad),\
					(isnull(fire) ? src.fire : fire),\
					(isnull(acid) ? src.acid : acid),\
					(isnull(magic) ? src.magic : magic),\
					(isnull(wound) ? src.wound : wound),\
					(isnull(melee) ? src.melee : melee),\
					(isnull(bullet) ? src.bullet : bullet),\
					(isnull(laser) ? src.laser : laser),\
					(isnull(tier) ? src.tier : tier))

/datum/armor/proc/getRating(rating)
	return vars[rating]

/datum/armor/proc/getList()
	return list("linemelee" = linemelee, "linebullet" = linebullet, "linelaser" = linelaser, "energy" = energy, "bomb" = bomb, "bio" = bio, "rad" = rad, "fire" = fire, "acid" = acid, "magic" = magic, "wound" = wound, "melee" = melee, "bullet" = bullet, "laser" = laser, "tier" = tier)

/datum/armor/proc/attachArmor(datum/armor/AA)
	return getArmor(linemelee+AA.linemelee, linebullet+AA.linebullet, linelaser+AA.linelaser, energy+AA.energy, bomb+AA.bomb, bio+AA.bio, rad+AA.rad, fire+AA.fire, acid+AA.acid, magic+AA.magic, wound+AA.wound, melee, bullet, laser, tier)

/datum/armor/proc/detachArmor(datum/armor/AA)
	return getArmor(linemelee-AA.linemelee, linebullet-AA.linebullet, linelaser-AA.linelaser, energy-AA.energy, bomb-AA.bomb, bio-AA.bio, rad-AA.rad, fire-AA.fire, acid-AA.acid, magic-AA.magic, wound-AA.wound, melee, bullet, laser, tier)

/datum/armor/vv_edit_var(var_name, var_value)
	if (var_name == NAMEOF(src, tag))
		return FALSE
	. = ..()
	tag = ARMORID // update tag in case armor values were edited

#undef ARMORID
