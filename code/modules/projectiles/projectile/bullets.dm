/obj/item/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	stamina = BULLET_STAMINA_PISTOL_LIGHT
	damage = BULLET_DAMAGE_PISTOL_LIGHT
	spread = BULLET_SPREAD_BASE

	wound_bonus = BULLET_WOUND_PISTOL_LIGHT
	bare_wound_bonus = BULLET_WOUND_PISTOL_LIGHT * BULLET_NAKED_WOUND_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_BASE
	range = INFINITY // ha ha this cant go badly
	damage_type = BRUTE
	nodamage = FALSE
	candink = TRUE
	flag = "bullet"
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	sharpness = SHARP_POINTY

/obj/item/projectile/bullet/smite
	name = "divine retribution"
	damage = 10

////////////////////////
// AMMUNITION CLASSES //
////////////////////////
/* * *
 * LIGHT PISTOL
 * - .22, 9mm, .38, needler
 * 
 * MEDIUM PISTOL
 * - 10mm, .45.
 * 
 * HEAVY PISTOL (basically revolvers)
 * - .357 mag, .44 mag, 14mm
 * 
 * LIGHT RIFLE
 * - 5.56mm, 4.73mm caseless, 5mm
 * 
 * MEDIUM RIFLE
 * - 7.62mm
 * 
 * HEAVY RIFLE
 * - .50, 2mm EC, .45-70
 * 
 * SHOT SHELLS
 * - Buck
 * 
 * SLUG SHELLS
 * - Slug, Trainshot, etc
 * 
 * * *
 */

//////////////////////
// AMMUNITION TYPES //
//////////////////////
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Surplus / Civilian / Sport
 * - Baseline
 * - Comes from ammofabs, well made, not perfect
 * 
 * Handload / Improvised / Trash
 * + Cheap and easy to make, just find a handloader and craft anywhere
 * - Less damage, less accuracy, less able to wound
 * 
 * Match / Military
 * + More damage, more wounding, more speed, more accuracy
 * + Generally better overall
 * - Rare, source TBD
 * 
 * Rubber / Beanbag / Less Than lethal
 * + Breaks bones with ease, lots of stamina damage, good at disabling people
 * - Difficult to actually kill people, useless against mobs, medbay will hate you (or love you)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

*** Most of these are unused for now~ ***
	+P/+P+ = used by simplemobs
	SHOCK = low-severity emp, -damage base, bonus burn damage (5-10)
	Incin = -damage, sets target on fire
	Acid = Heavy -damage, coats target in small amount of acid (1-5u)
	Uranium = Irradiates, high AP, lower damage - unused
	Micro-Shrapnel = Wound bonus, embed bonus, high falloff for both
	Contaminated = -damage, spawns a gas cloud that heavily reduces healing efficiency

*/
