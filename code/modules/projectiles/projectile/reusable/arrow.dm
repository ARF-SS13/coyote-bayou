/obj/item/projectile/bullet/reusable/arrow
	name = "arrow"
	desc = "a simple arrow."
	icon_state = "arrow"
	damage = BULLET_DAMAGE_ARROW_METAL //40
	damage_low = 30
	damage_high = 50
	stamina = BULLET_STAMINA_ARROW_METAL
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_METAL

	wound_bonus = BULLET_WOUND_ARROW_METAL
	bare_wound_bonus = BULLET_WOUND_ARROW_METAL_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_METAL
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	break_chance = 25
	ammo_type = /obj/item/ammo_casing/caseless/arrow

/obj/item/projectile/bullet/reusable/arrow/metal
	name = "metal arrow"
	desc = "a simple arrow with a metal head."
	icon_state = "arrow"
	damage = BULLET_DAMAGE_ARROW_METAL
	damage_low = 30
	damage_high = 50
	stamina = BULLET_STAMINA_ARROW_METAL
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_METAL

	wound_bonus = BULLET_WOUND_ARROW_METAL
	bare_wound_bonus = BULLET_WOUND_ARROW_METAL_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_METAL
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	break_chance = 25
	ammo_type = /obj/item/ammo_casing/caseless/arrow/metal

/obj/item/projectile/bullet/reusable/arrow/bone
	name = "bone arrow"
	desc = "an arrow made of bone and sinew."
	icon_state = "arrow"
	damage = BULLET_DAMAGE_ARROW_BONE
	damage_low = 20
	damage_high = 45
	stamina = BULLET_STAMINA_ARROW_BONE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_BONE

	wound_bonus = BULLET_WOUND_ARROW_BONE
	bare_wound_bonus = BULLET_WOUND_ARROW_BONE_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_BONE
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	break_chance = 25
	ammo_type = /obj/item/ammo_casing/caseless/arrow/bone

/obj/item/projectile/bullet/reusable/arrow/titanium
	name = "titanium arrow"
	desc = "a durable arrow with a sturdy titanium head."
	icon_state = "arrow"
	damage = BULLET_DAMAGE_ARROW_TITANIUM
	damage_low = 40
	damage_high = 60
	stamina = BULLET_STAMINA_ARROW_TITANIUM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_TITANIUM

	wound_bonus = BULLET_WOUND_ARROW_TITANIUM
	bare_wound_bonus = BULLET_WOUND_ARROW_TITANIUM_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_TITANIUM
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	break_chance = 10  //premium material just means durable. don't need to make as many
	ammo_type = /obj/item/ammo_casing/caseless/arrow/titanium

/obj/item/projectile/bullet/reusable/arrow/flint
	name = "flint arrow"
	desc = "a primitive arrow with a head made of knapped flint."
	icon_state = "arrow"
	damage = BULLET_DAMAGE_ARROW_FLINT
	damage_low = 35
	damage_high = 75
	stamina = BULLET_STAMINA_ARROW_FLINT
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_FLINT

	wound_bonus = BULLET_WOUND_ARROW_FLINT
	bare_wound_bonus = BULLET_WOUND_ARROW_FLINT_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_FLINT
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	break_chance = 45
	ammo_type = /obj/item/ammo_casing/caseless/arrow/flint

/obj/item/projectile/bullet/reusable/arrow/glass //glass arrows behave very similar to flint irl
	name = "glass arrow"
	desc = "a primitive arrow with a head made of knapped glass."
	damage = BULLET_DAMAGE_ARROW_GLASS
	damage_low = 40
	damage_high = 65
	stamina = BULLET_STAMINA_ARROW_GLASS
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_GLASS

	wound_bonus = BULLET_WOUND_ARROW_GLASS
	bare_wound_bonus = BULLET_WOUND_ARROW_GLASS_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_GLASS
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	break_chance = 35
	ammo_type = /obj/item/ammo_casing/caseless/arrow/glass

/obj/item/projectile/bullet/reusable/arrow/explosive //possibly OP
	name = "explosive arrow"
	desc = "a heavy arrow containing an explosive payload."
	damage = BULLET_DAMAGE_ARROW_EXPLOSIVE
	stamina = BULLET_STAMINA_ARROW_EXPLOSIVE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_EXPLOSIVE

	wound_bonus = BULLET_WOUND_ARROW_EXPLOSIVE
	bare_wound_bonus = BULLET_WOUND_ARROW_EXPLOSIVE_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_EXPLOSIVE
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	break_chance = 100
	ammo_type = /obj/item/ammo_casing/caseless/arrow/explosive

/obj/item/projectile/bullet/reusable/arrow/explosive/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, 0, 0, 2, 0, adminlog = FALSE, flame_range = 0) //dynamite sized explosion, no cruel flash or fire to make pvp miserable


/obj/item/projectile/bullet/reusable/arrow/jagged //oldcode serrated and broadhead combined
	name = "jagged arrow"
	desc = "a mean looking arrow made to shed blood and infection. it tends to stay stuck in the target and snap off, so good luck recovering it."
	damage = BULLET_DAMAGE_ARROW_BARBED
	damage_low = 10
	damage_high = 30
	stamina = BULLET_STAMINA_ARROW_BARBED
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_BARBED

	wound_bonus = BULLET_WOUND_ARROW_BARBED
	bare_wound_bonus = BULLET_WOUND_ARROW_BARBED_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_BARBED
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_EDGED
	supereffective_damage = BULLET_BANE_DAMAGE_ARROW_BARBED
	supereffective_flags = BULLET_BANE_FLAGS_ARROW_BARBED
	break_chance = 100 //high power, costly
	ammo_type = /obj/item/ammo_casing/caseless/arrow/jagged
	embedding = list(
		embed_chance= 60, 
		fall_chance= 5, 
		jostle_chance= 40, 
		ignore_throwspeed_threshold=FALSE, 
		pain_stam_pct= 0.2, 
		pain_mult= 2, 
		jostle_pain_mult= 1, 
		rip_time= 3 SECONDS, 
		projectile_payload = /obj/item/projectile/bullet/reusable/arrow/jagged
		) 

/obj/item/projectile/bullet/reusable/arrow/field
	name = "field arrow"
	desc = "a simple arrow with a small, sturdy head."
	damage = BULLET_DAMAGE_ARROW_FIELD
	damage_low = 15
	damage_high = 45
	stamina = BULLET_STAMINA_ARROW_FIELD
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_FIELD

	wound_bonus = BULLET_WOUND_ARROW_FIELD
	bare_wound_bonus = BULLET_WOUND_ARROW_FIELD_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_FIELD
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	break_chance = 5 //real sturdy. this is the easy to make and supply "handload" of the arrow world
	ammo_type = /obj/item/ammo_casing/caseless/arrow/field

/* I...don't really wanna touch this till nonlethal ammo is looked at, or I understand it. but should be sorta equivalent to a .308?
*/
/obj/item/projectile/bullet/reusable/arrow/blunt
	name = "blunt arrow"
	desc = "an arrow with a wrapped leather tip, made for bruising."
	damage = BULLET_DAMAGE_ARROW_BLUNT
	stamina = BULLET_STAMINA_ARROW_BLUNT
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_BLUNT

	wound_bonus = BULLET_WOUND_ARROW_BLUNT
	bare_wound_bonus = BULLET_WOUND_ARROW_BLUNT_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_BLUNT
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	sharpness = SHARP_NONE
	break_chance = 20
	ammo_type = /obj/item/ammo_casing/caseless/arrow/blunt

/obj/item/projectile/bullet/reusable/arrow/ion  //the original was written strangely for some reason. think it was a simple mimicry of ion gun projectile
	name = "ion arrow"
	desc = "an arrow containing an EMP warhead."
	damage = BULLET_DAMAGE_ARROW_ION
	damage_low = 5
	damage_high = 15
	stamina = BULLET_STAMINA_ARROW_ION
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_ION

	wound_bonus = BULLET_WOUND_ARROW_ION
	bare_wound_bonus = BULLET_WOUND_ARROW_ION_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_ION
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	sharpness = SHARP_NONE
	supereffective_damage = BULLET_BANE_DAMAGE_ARROW_ION //lets try something new
	supereffective_flags = BULLET_BANE_FLAGS_ARROW_ION
	break_chance = 100 //one zap and we done
	ammo_type = /obj/item/ammo_casing/caseless/arrow/ion

/obj/item/projectile/bullet/reusable/arrow/ion/on_hit(atom/target, blocked = FALSE)
	..()
	target.emp_act(15)//5 severity is very, very low

/obj/item/projectile/bullet/reusable/arrow/practice
	name = "practice arrow"
	desc = "a harmless arrow with a padded, fabric tip. for practice, not for annoying people with."
	damage = BULLET_DAMAGE_ARROW_PRACTICE
	damage_list = list("1" = 99.999, "92745" = 0.001) //haha poke your eye out kid ~TK
	stamina = BULLET_STAMINA_ARROW_PRACTICE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_ARROW_PRACTICE

	wound_bonus = BULLET_WOUND_ARROW_PRACTICE
	bare_wound_bonus = BULLET_WOUND_ARROW_PRACTICE_NAKED_MULT
	
	pixels_per_second = BULLET_SPEED_ARROW_PRACTICE
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT
	sharpness = SHARP_NONE
	break_chance = 5 //simple and sturdy
	ammo_type = /obj/item/ammo_casing/caseless/arrow/practice

/obj/item/projectile/bullet/reusable/arrow/practice/sticky
	name = "sticky practice arrow"
	desc = "a harmless arrow with soft tip made from layers of tape. for annoying people with."
	ammo_type = /obj/item/ammo_casing/caseless/arrow/sticky
	break_chance = 0
	embedding = list(
		embed_chance = 100, 
		fall_chance = 10, 
		pain_mult = 0, 
		jostle_pain_mult = 0, 
		ignore_throwspeed_threshold = TRUE,
		)


/* 

/obj/item/projectile/bullet/reusable/arrow
	name = "metal arrow"
	desc = "a simple arrow with a metal head."
	damage = 40
	armour_penetration = 0.2
	icon_state = "arrow"
	ammo_type = /obj/item/ammo_casing/caseless/arrow

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

/obj/item/projectile/bullet/reusable/arrow/blunt
	name = "knockout arrow"
	desc = "An arrow with a thick cloth sack at the end, filled with rocks."
	wound_bonus = 0
	bare_wound_bonus = 0
	wound_falloff_tile = 0
	armour_penetration = 0.10
	damage = 15
	stamina = 70
	ammo_type = /obj/item/ammo_casing/caseless/arrow/blunt

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
