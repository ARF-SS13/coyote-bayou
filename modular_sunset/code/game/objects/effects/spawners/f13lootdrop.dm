// Only green GWTB-like outfit for now. Hopefully could be expaned further later.
// 2/12/2024 Update: EXPANSION TIME - Boredom is Dangerous Edition.

/obj/effect/spawner/lootdrop/f13/gasmask_goner
	name = "full gas mask working chance"
	loot = list(
		/obj/item/clothing/mask/gas/goner/aesthetic = 8,
		/obj/item/clothing/mask/gas/goner = 2
	)

// A low chance to find officer cap of respective Arm-- Uh, color.
/obj/effect/spawner/lootdrop/f13/helmet_goner_red
	name = "red peaked cap chance"
	loot = list(
		/obj/item/clothing/head/helmet/f13/goner/red = 9,
		/obj/item/clothing/head/helmet/f13/goner/officer/red = 1
	)

/obj/effect/spawner/lootdrop/f13/helmet_goner_green
	name = "green peaked cap chance"
	loot = list(
		/obj/item/clothing/head/helmet/f13/goner/green = 9,
		/obj/item/clothing/head/helmet/f13/goner/officer/green = 1
	)

/obj/effect/spawner/lootdrop/f13/helmet_goner_blue
	name = "blue peaked cap chance"
	loot = list(
		/obj/item/clothing/head/helmet/f13/goner/blue = 9,
		/obj/item/clothing/head/helmet/f13/goner/officer/blue = 1
	)

/obj/effect/spawner/lootdrop/f13/helmet_goner_yellow
	name = "yellow peaked cap chance"
	loot = list(
		/obj/item/clothing/head/helmet/f13/goner/yellow = 9,
		/obj/item/clothing/head/helmet/f13/goner/officer/yellow = 1
	)

// The ones that were Gone with the Blastwave now have their respective outfits thrown about.
/obj/effect/spawner/lootdrop/f13/armor/tier1/Initialize(mapload)
	var/list/loot_extra = list(
		/obj/effect/spawner/bundle/f13/armor/goner/red,
		/obj/effect/spawner/bundle/f13/armor/goner/green,
		/obj/effect/spawner/bundle/f13/armor/goner/blue,
		/obj/effect/spawner/bundle/f13/armor/goner/yellow
	)
	LAZYADD(loot, loot_extra)
	. = ..()

/obj/effect/spawner/bundle/f13/armor/goner/red
	name = "red trencher outfit spawner"
	items = list(
		/obj/item/clothing/suit/armor/light/duster/goner/red,
		/obj/effect/spawner/lootdrop/f13/gasmask_goner,
		/obj/effect/spawner/lootdrop/f13/helmet_goner_red
	)

/obj/effect/spawner/bundle/f13/armor/goner/green
	name = "green trencher outfit spawner"
	items = list(
		/obj/item/clothing/suit/armor/light/duster/goner/green,
		/obj/effect/spawner/lootdrop/f13/gasmask_goner,
		/obj/effect/spawner/lootdrop/f13/helmet_goner_green
	)

/obj/effect/spawner/bundle/f13/armor/goner/blue
	name = "blue trencher outfit spawner"
	items = list(
		/obj/item/clothing/suit/armor/light/duster/goner/blue,
		/obj/effect/spawner/lootdrop/f13/gasmask_goner,
		/obj/effect/spawner/lootdrop/f13/helmet_goner_blue
	)

/obj/effect/spawner/bundle/f13/armor/goner/yellow
	name = "yellow trencher outfit spawner"
	items = list(
		/obj/item/clothing/suit/armor/light/duster/goner/yellow,
		/obj/effect/spawner/lootdrop/f13/gasmask_goner,
		/obj/effect/spawner/lootdrop/f13/helmet_goner_yellow
	)
