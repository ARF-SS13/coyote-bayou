//////////////////////
//		Arrows!		//
//////////////////////
// Unless otherwise defined, arrows get +10 damage against all simplemobs, making them more viable.

/obj/item/projectile/bullet/reusable/arrow
	name = "arrow"
	desc = "a simple arrow."
	icon_state = "arrow"
	damage = BULLET_DAMAGE_ARROW //40
	damage_low = 39
	damage_high = 41
	stamina = BULLET_STAMINA_ARROW
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW

	wound_bonus = BULLET_WOUND_ARROW
	bare_wound_bonus = BULLET_WOUND_ARROW_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW
	damage_falloff = BULLET_FALLOFF_DEFAULT_RIFLE_LIGHT	//If you can hit a target that far away you deserve it.
	break_chance = 5
	ammo_type = /obj/item/ammo_casing/caseless/arrow
	sharpness = SHARP_POINTY

	supereffective_damage = 20
	supereffective_flags = SE_ALL_SIMPLEMOBS

/obj/item/projectile/bullet/reusable/arrow/bone
	name = "bone arrow"
	desc = "an arrow made of bone and sinew."
	break_chance = 10

/obj/item/projectile/bullet/reusable/arrow/flint
	name = "flint arrow"
	desc = "a primitive arrow with a head made of knapped flint."
	break_chance = 10
	ammo_type = /obj/item/ammo_casing/caseless/arrow/flint

/obj/item/projectile/bullet/reusable/arrow/glass
	name = "glass arrow"
	desc = "a primitive arrow with a head made of knapped glass."
	break_chance = 10
	ammo_type = /obj/item/ammo_casing/caseless/arrow/glass

/obj/item/projectile/bullet/reusable/arrow/explosive //possibly OP
	name = "explosive arrow"
	desc = "a heavy arrow containing an explosive payload."
	damage = BULLET_DAMAGE_ARROW_EXPLOSIVE
	stamina = BULLET_STAMINA_ARROW_EXPLOSIVE

	wound_bonus = BULLET_WOUND_ARROW_EXPLOSIVE
	bare_wound_bonus = BULLET_WOUND_ARROW_EXPLOSIVE_NAKED_MULT

	break_chance = 100
	ammo_type = /obj/item/ammo_casing/caseless/arrow/explosive

/obj/item/projectile/bullet/reusable/arrow/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 0, 2, 0, adminlog = FALSE, flame_range = 0) //dynamite sized explosion, no cruel flash or fire to make pvp miserable


//////////////////////
//	Broadhead Arrow	//
//////////////////////
// Wounding/Cutting Arrow
// High Damage, Low AP
/obj/item/projectile/bullet/reusable/arrow/broadhead
	name = "broadhead arrow"
	damage = 50
	damage_low = 45
	damage_high = 50
	stamina = 10
	armour_penetration = -0.2	//Made to kill large animals by creating the biggest wound possible, not to stick inside.

	wound_bonus = 10
	bare_wound_bonus = 35

	sharpness = SHARP_EDGED
	supereffective_damage = 10	//Stops broadheads being straight upgrades to default arrows in PvE.
	break_chance = 5
	ammo_type = /obj/item/ammo_casing/caseless/arrow/broadhead


//////////////////////
//	Bodkin Arrow	//
//////////////////////
// Piercing/Embedding Arrow
// Low Damage, High AP
/obj/item/projectile/bullet/reusable/arrow/bodkin
	name = "bodkin arrow"
	damage = 35
	damage_low = 35
	damage_high = 40
	stamina = 20
	armour_penetration = 0.2	//Made to punch through chainmail, limited penetration through thin plate armor.

	wound_bonus = -10
	bare_wound_bonus = 40	//Adds up to a 30 total if the target has no armor.

	sharpness = SHARP_EDGED
	break_chance = 5
	ammo_type = /obj/item/ammo_casing/caseless/arrow/bodkin
	embedding = list(
		embed_chance= 40,
		fall_chance= 15,
		jostle_chance= 10,
		ignore_throwspeed_threshold=FALSE,
		pain_stam_pct= 0.2,
		pain_mult= 2,
		jostle_pain_mult= 1,
		rip_time= 3 SECONDS,
		projectile_payload = /obj/item/projectile/bullet/reusable/arrow/bodkin
		) 


//////////////////////
//	Field	Arrow	//
//////////////////////
// Low Tier Arrow
// Low Damage, Cheap, Low Break Chance
/obj/item/projectile/bullet/reusable/arrow/field
	name = "field arrow"
	desc = "a simple arrow with a small, sturdy head."
	damage = 30
	damage_low = 30
	damage_high = 35
	stamina = 15

	wound_bonus = 0
	bare_wound_bonus = 5

	break_chance = 1
	ammo_type = /obj/item/ammo_casing/caseless/arrow/field


//////////////////////
//	Ion		Arrow	//
//////////////////////
// Anti-Robot Arrow
// Useless against non-robots, rewards players for specifically prepping against robot foes
/obj/item/projectile/bullet/reusable/arrow/ion  //the original was written strangely for some reason. think it was a simple mimicry of ion gun projectile
	name = "ion arrow"
	desc = "An arrow containing an EMP device. Pretty uselss against "
	damage = 15
	damage_low = 10
	damage_high = 20
	stamina = 25	//We do pitiful damage against anything that isn't a robot, so why not?

	wound_bonus = -100
	bare_wound_bonus = -100

	sharpness = SHARP_NONE
	supereffective_damage = 70	//You have to go well out of your way to collect electronic parts to craft these, prepare accordingly, rewarded accordingly.
	supereffective_flags = SE_ROBOTS
	break_chance = 100 //one zap and we done
	ammo_type = /obj/item/ammo_casing/caseless/arrow/ion

/obj/item/projectile/bullet/reusable/arrow/ion/on_hit(atom/target, blocked = FALSE)
	..()
	target.emp_act(15)//5 severity is very, very low

//////////////////////
//	Split Arrow		//
//////////////////////

/obj/item/projectile/bullet/reusable/arrow/split
	name = "split arrow"
	desc = "an arrow that splits apart after firing."
	break_chance = 100 // Don't want people getting 2 back for shooting 1
	spread = 15 // Whats the downside? Not much, but it requires good metal parts to make + is hard to hit things with
	ammo_type = /obj/item/ammo_casing/caseless/arrow/split
	

//	Bludgeon Arrow	//
//////////////////////
// Stamina Arrow
// No damage, exclusively for stamina attacks. Hits very hard, but don't forget your fire rate ain't gonna be so great.
/obj/item/projectile/bullet/reusable/arrow/bludgeon
	name = "bludgeoning arrow"
	desc = "Good at killing small game and birds without skewering them. Good at giving you nasty bruises and cracking your ribs."
	damage = 0
	stamina = 60

	wound_bonus = 0
	bare_wound_bonus = 0

	sharpness = SHARP_NONE
	ammo_type = /obj/item/ammo_casing/caseless/arrow/bludgeon

/* 
//CIT ARROWS
/obj/item/projectile/bullet/reusable/arrow/ash
	name = "ashen arrow"
	desc = "Fire harderned arrow."
	damage = 0.5
	ammo_type = /obj/item/ammo_casing/caseless/arrow/ash

/obj/item/projectile/bullet/reusable/arrow/gold
	name = "golden arrow"
	desc = "Arrow made with gold and wood."
	damage = 25
	armour_penetration = 0.15
	supereffective_damage = 40
	supereffective_faction = list("hostile","supermutant", "raider", "china")
	ammo_type = /obj/item/ammo_casing/caseless/arrow/gold

/obj/item/projectile/bullet/reusable/arrow/bone //extra mob damage
	name = "bone arrow"
	desc = "Arrow made of bone and sinew."
	damage = 20
	armour_penetration = 0.10
	supereffective_damage = 40
	supereffective_faction = list("hostile", "ant", "supermutant", "deathclaw", "cazador", "raider", "china", "gecko", "wastebot", "radscorpion")
	ammo_type = /obj/item/ammo_casing/caseless/arrow/bone

/obj/item/projectile/bullet/reusable/arrow/bronze //Just some AP shots
	name = "bronze arrow"
	desc = "Bronze tipped arrow."
	damage = 30
	armour_penetration = 0.35
	ammo_type = /obj/item/ammo_casing/caseless/arrow/bronze

//FO13 ARROWS
/obj/item/projectile/bullet/reusable/arrow/cheap
	name = "lightweight arrow"
	desc = "A cheap, lightweight wooden arrow. Not as effective against armor."
	damage = 40
	armour_penetration = -0.25
	icon_state = "arrow"
	ammo_type = /obj/item/ammo_casing/caseless/arrow/cheap

/obj/item/projectile/bullet/reusable/arrow/ap
	name = "sturdy arrow"
	desc = "A reinforced arrow with a metal shaft and heavy duty head."
	damage = 35
	armour_penetration = 0.66
	icon_state = "arrow"
	ammo_type = /obj/item/ammo_casing/caseless/arrow/ap

/obj/item/projectile/bullet/reusable/arrow/poison
	name = "poison arrow"
	desc = "A simple arrow, tipped in a poisonous paste."
	damage = 20 //really gotta balance this, holy cow
	armour_penetration = 0.1
	icon_state = "arrow"
	ammo_type = /obj/item/ammo_casing/caseless/arrow/poison

/obj/item/projectile/bullet/reusable/arrow/poison/on_hit(atom/target, blocked)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/targetHuman = target
		targetHuman.reagents.add_reagent(/datum/reagent/toxin, 10) //so you get some toxin damage! around 30

/obj/item/projectile/bullet/reusable/arrow/burning
	name = "burn arrow"
	desc = "A sumple arrow slathered in a paste that burns skin on contact."
	damage = 20 //gotta balance it!
	armour_penetration = 0.1
	icon_state = "arrow"
	ammo_type = /obj/item/ammo_casing/caseless/arrow/burning

/obj/item/projectile/bullet/reusable/arrow/burning/on_hit(atom/target, blocked)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/targetHuman = target
		targetHuman.adjust_fire_stacks(5)
		targetHuman.IgniteMob() //you just got burned!


/obj/item/projectile/bullet/reusable/arrow/broadhead
	name = "broadhead arrow"
	desc = "An arrow that sticks in wounds. Badly."
	armour_penetration = 0.1
	damage = 20
	sharpness = SHARP_EDGED
	ammo_type = /obj/item/ammo_casing/caseless/arrow/broadhead
	embedding = list(embed_chance=50, fall_chance=60, jostle_chance=3, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.2, pain_mult=2, jostle_pain_mult=1, rip_time=25, projectile_payload = /obj/item/ammo_casing/caseless/arrow/broadhead)

/obj/item/projectile/bullet/reusable/arrow/broadhead/on_hit(atom/target, blocked)
	if(iscarbon(target))
		dropped = TRUE
	..()

/obj/item/projectile/bullet/reusable/arrow/serrated
	name = "serrated arrow"
	desc = "An arrow that can sever arteries!"
	wound_bonus = 25
	bare_wound_bonus = 20
	sharpness = SHARP_EDGED
	armour_penetration = 0.05
	damage = 30
	ammo_type = /obj/item/ammo_casing/caseless/arrow/serrated

// Special Arrows

/obj/item/projectile/ion/arrow //im sorry but this is TECHNICALLY an arrow SOOO
	name = "ion arrow"
	desc = "An arrow that created an EMP where it lands."
	icon_state = "arrow"
	damage = 28
	armour_penetration = 0.75
	damage_type = BURN
	flag = "energy"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/ion

/obj/item/projectile/ion/arrow/on_hit(atom/target, blocked = FALSE)
	..()
	empulse_using_range(target, emp_radius)
	return BULLET_ACT_HIT

/obj/item/projectile/ion/arrow/weak
	emp_radius = 1
	damage = 20
	armour_penetration = 0.5
 */
