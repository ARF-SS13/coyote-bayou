/obj/item/projectile/bullet/reusable/arrow
	name = "metal arrow"
	desc = "a simple arrow with a metal head."
	damage = 40
	armour_penetration = 5
	icon_state = "arrow"
	ammo_type = /obj/item/ammo_casing/caseless/arrow

//CIT ARROWS
/obj/item/projectile/bullet/reusable/arrow/ash
	name = "ashen arrow"
	desc = "Fire harderned arrow."
	damage = 25
	ammo_type = /obj/item/ammo_casing/caseless/arrow/ash

/obj/item/projectile/bullet/reusable/arrow/bone //AP for ashwalkers
	name = "bone arrow"
	desc = "Arrow made of bone and sinew."
	damage = 35
	armour_penetration = 40
	ammo_type = /obj/item/ammo_casing/caseless/arrow/bone

/obj/item/projectile/bullet/reusable/arrow/bronze //Just some AP shots
	name = "bronze arrow"
	desc = "Bronze tipped arrow."
	armour_penetration = 10
	ammo_type = /obj/item/ammo_casing/caseless/arrow/bronze

//FO13 ARROWS
/obj/item/projectile/bullet/reusable/arrow/ap
	name = "sturdy arrow"
	desc = "A reinforced arrow with a metal shaft and heavy duty head."
	damage = 45
	armour_penetration = 35
	icon_state = "arrow"
	ammo_type = /obj/item/ammo_casing/caseless/arrow/ap

/obj/item/projectile/bullet/reusable/arrow/ap/on_hit(atom/target, blocked)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/targetHuman = target
		targetHuman.adjustStaminaLoss(25) //I imagine getting hit by one of these would really, REALLY, sting; actual damage and stamina damage

/obj/item/projectile/bullet/reusable/arrow/poison
	name = "poison arrow"
	desc = "A simple arrow, tipped in a poisonous paste."
	damage = 10 //really gotta balance this, holy cow
	armour_penetration = 5
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
	damage = 10 //gotta balance it!
	armour_penetration = 5
	icon_state = "arrow"
	ammo_type = /obj/item/ammo_casing/caseless/arrow/burning

/obj/item/projectile/bullet/reusable/arrow/burning/on_hit(atom/target, blocked)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/targetHuman = target
		targetHuman.adjust_fire_stacks(5)
		targetHuman.IgniteMob() //you just got burned!
