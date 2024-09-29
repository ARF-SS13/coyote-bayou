/obj/item/ammo_casing/caseless/arrow
	name = "arrow"
	desc = "a simple arrow with a metal head."
	icon = 'icons/obj/arrow_crafting.dmi'
	icon_state = "arrow"
	projectile_type = /obj/item/projectile/bullet/reusable/arrow
	caliber = CALIBER_ARROW
	custom_materials = list(/datum/material/iron = MINERAL_MATERIAL_AMOUNT*2)
	throwforce = 8 //good luck hitting someone with the pointy end of the arrow
	throw_speed = 3
	w_class = WEIGHT_CLASS_SMALL //why were arrows normal sized? that's cruel
	is_pickable = FALSE
	sound_properties = CSP_MISC

/obj/item/ammo_casing/caseless/arrow/bone
	name = "bone arrow"
	desc = "A primitive arrow with a head made of knapped bone."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/bone
	icon_state = "bone"
	custom_materials = list(/datum/material/bone = MINERAL_MATERIAL_AMOUNT)

/obj/item/ammo_casing/caseless/arrow/flint
	name = "flint arrow"
	desc = "A primitive arrow with a head made of knapped flint."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/flint
	icon_state = "flint"
	custom_materials = list(/datum/material/sandstone = MINERAL_MATERIAL_AMOUNT)

/obj/item/ammo_casing/caseless/arrow/glass
	name = "glass arrow"
	desc = "A primitive arrow with a head made of knapped glass."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/glass
	icon_state = "glass"
	custom_materials = list(/datum/material/glass = MINERAL_MATERIAL_AMOUNT)

/obj/item/ammo_casing/caseless/arrow/explosive
	name = "explosive arrow"
	desc = "a heavy arrow containing an explosive payload."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/explosive
	icon_state = "explosivearrow"
	custom_materials = list(/datum/material/blackpowder = MINERAL_MATERIAL_AMOUNT*5)
	w_class = WEIGHT_CLASS_NORMAL //hefty, and can't carry tons. subject to change?

/obj/item/ammo_casing/caseless/arrow/broadhead
	name = "broadhead arrow"
	desc = "An arrow made for creating large wounds, made to cut-up flesh and cause fatal bleeding."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/broadhead
	icon_state = "broadhead"
	custom_materials = list(/datum/material/iron = MINERAL_MATERIAL_AMOUNT)

/obj/item/ammo_casing/caseless/arrow/bodkin
	name = "bodkin arrow"
	desc = "Armor-piercing arrows."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/bodkin
	icon_state = "bodkin"
	custom_materials = list(/datum/material/iron = MINERAL_MATERIAL_AMOUNT)

/obj/item/ammo_casing/caseless/arrow/field
	name = "field arrow"
	desc = "Used primarily for small game and target practice, the tip is very narrow."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/field
	icon_state = "fieldarrow"
	custom_materials = list(/datum/material/iron = MINERAL_MATERIAL_AMOUNT)
	w_class = WEIGHT_CLASS_TINY //lightweight, thin tip. can stow a lot in a bag

/obj/item/ammo_casing/caseless/arrow/ion
	name = "ion arrow"
	desc = "an arrow containing an EMP warhead."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/ion
	icon_state = "ionarrow"
	custom_materials = list(/datum/material/glass = MINERAL_MATERIAL_AMOUNT)

/obj/item/ammo_casing/caseless/arrow/split
	name = "split arrow"
	desc = "An arrow that splits apart after firing."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/split
	icon_state = "splitarrow"
	pellets = 3
	custom_materials = list(/datum/material/glass = MINERAL_MATERIAL_AMOUNT)

/obj/item/ammo_casing/caseless/arrow/bludgeon
	name = "bludgeoning arrow"
	desc = "a harmless arrow with a padded, fabric tip. for practice, not for annoying people with."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/bludgeon
	icon_state = "bludgeon"
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT)

/* //FO13 arrows
/obj/item/ammo_casing/caseless/arrow
	name = "metal arrow"
	desc = "A simple arrow with a metal head."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow
	caliber = CALIBER_ARROW
	icon_state = "arrow"
	custom_materials = list(/datum/material/iron = 500)
	throwforce = 8 //good luck hitting someone with the pointy end of the arrow
	throw_speed = 3
	w_class = WEIGHT_CLASS_NORMAL
	is_pickable = FALSE

/obj/item/ammo_casing/caseless/arrow/cheap
	name = "cheap arrow"
	desc = "A cheap, small, lightweight arrow made from wood. Not as effective against armor."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/cheap
	icon_state = "cheaparrow"
	throwforce = 6
	custom_materials = list(/datum/material/wood = 500)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_casing/caseless/arrow/ap
	name = "sturdy arrow"
	desc = "A reinforced arrow with a metal shaft and heavy duty head."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/ap
	icon_state = "arrow_ap"

/obj/item/ammo_casing/caseless/arrow/poison
	name = "poison arrow"
	desc = "A simple arrow, tipped in a poisonous paste."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/poison
	icon_state = "arrow_poison"

/obj/item/ammo_casing/caseless/arrow/burning
	name = "burn arrow"
	desc = "A simple arrow slathered in a paste that burns skin on contact."
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/burning
	icon_state = "arrow_burning"

/obj/item/ammo_casing/caseless/arrow/broadhead
	name = "broadhead arrow"
	desc = "A sharp metal arrow with a broad head. Likely to stick in a wound."
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "arrow_broadhead"
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/broadhead

/obj/item/ammo_casing/caseless/arrow/serrated
	name = "serrated arrow"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	desc = "A sharp metal arrow with a wicked sharp serrated teeth. Likely to shred an artery."
	icon_state = "arrow_serrated"
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/serrated

//CIT ARROWS
/obj/item/ammo_casing/caseless/arrow/wood
	name = "wooden arrow"
	desc = "An arrow made of wood, typically fired from a bow."

/obj/item/ammo_casing/caseless/arrow/ash
	name = "ashen arrow"
	desc = "An arrow made of wood, hardened by fire."
	icon_state = "ashenarrow"
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/ash

/obj/item/ammo_casing/caseless/arrow/gold
	name = "golden arrow"
	desc = "An arrow made of gold, strengthened by devotion."
	icon_state = "goldenarrow"
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/gold

/obj/item/ammo_casing/caseless/arrow/bone
	name = "bone arrow"
	desc = "An arrow made of bone and sinew. The tip is sharp enough to pierce through aethergiest hide."
	icon_state = "bonearrow"
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/bone

/obj/item/ammo_casing/caseless/arrow/bronze
	name = "bronze arrow"
	desc = "An arrow made of wood, tipped with bronze. The tip is dense enough to provide some armor penetration."
	icon_state = "bronzearrow"
	projectile_type = /obj/item/projectile/bullet/reusable/arrow/bronze

/obj/item/ammo_casing/caseless/arrow/ion
	name = "spirit arrow"
	desc = "A heavy synthetic shaft, a payload full of spirits and dazzling light. Send payment to the Old World metallic ghosts. Slower than other arrows due to its weight."
	icon_state = "arrow_emp"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	projectile_type = /obj/item/projectile/ion/arrow
*/
