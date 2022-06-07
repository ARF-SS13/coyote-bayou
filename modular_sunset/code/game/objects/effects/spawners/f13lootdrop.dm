// Only green GWTB-like outfit for now. Hopefully could be expaned further later.
/obj/effect/spawner/lootdrop/f13/gasmask_goner
	name = "full gas mask working chance"
	loot = list(
		/obj/item/clothing/mask/gas/goner/aesthetic = 8,
		/obj/item/clothing/mask/gas/goner = 2
	)

/obj/effect/spawner/lootdrop/f13/armor/tier1/Initialize(mapload)
	var/list/loot_extra = list(
		/obj/effect/spawner/bundle/f13/armor/goner/green
	)
	LAZYADD(loot, loot_extra)
	. = ..()

/obj/effect/spawner/bundle/f13/armor/goner/green
	name = "green trencher outfit spawner"
	items = list(
		/obj/item/clothing/suit/f13/goner/green,
		/obj/effect/spawner/lootdrop/f13/gasmask_goner,
		/obj/item/clothing/head/helmet/f13/goner/green
	)
