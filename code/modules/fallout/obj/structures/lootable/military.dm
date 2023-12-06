/obj/structure/lootable/ammo
	name = "ammo crate"
	random_name_list = "ammo box"
	desc = "Looks like some kind of ammo crate. I can probably restock here."
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "weaponcrate1"
	icon_state_open = "weaponcrate1open"
	loot_type = LOOT_AMMO
/obj/structure/lootable/ammo/dynamic
	dynamic_loot_tier = TRUE

/obj/structure/lootable/ammo/trash
	loot_tier = LOOT_TIER_LOWEST
	icon_state = "weaponcrate1"
	icon_state_open = "weaponcrate1open"

/obj/structure/lootable/ammo/common
	loot_tier = LOOT_TIER_LOW
	icon_state = "weaponcrate2"
	icon_state_open = "weaponcrate2open"

/obj/structure/lootable/ammo/uncommon
	loot_tier = LOOT_TIER_MID
	icon_state = "weaponcrate3"
	icon_state_open = "weaponcrate3open"

/obj/structure/lootable/ammo/rare
	loot_tier = LOOT_TIER_HIGH

/obj/structure/lootable/ammo/veryrare
	loot_tier = LOOT_TIER_HIGHEST

