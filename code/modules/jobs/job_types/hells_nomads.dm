

/datum/outfit/job/biker
	name = "Hells Nomad"
	jobtype = /datum/job/ashdown/biker
	suit = /obj/item/clothing/suit/armor/light/duster/brahmin/biker
	ears = /obj/item/radio/headset/headset_biker
	head = /obj/item/clothing/head/helmet/f13/khan/bandana
	shoes = /obj/item/clothing/shoes/f13/cowboy
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/old
	uniform = /obj/item/clothing/under/f13/khan/biker
	belt     = /obj/item/supplykit
	r_pocket = /obj/item/flashlight/flare
	box = /obj/item/storage/survivalkit
	box_two = /obj/item/storage/survivalkit/medical
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/storage/wallet/stash/low = 1,
		/obj/item/kit_spawner/tools = 1,
		/obj/item/cool_book/ashdowncit = 1
		)
	tattoos_they_get = list(/datum/tattoo/biker)

/datum/outfit/job/biker/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/gate_biker)

