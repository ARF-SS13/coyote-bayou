// why wasn't this a thing. all other items

// medicine

/datum/export/item/radaway
	cost = 200
	unit_name = "radaway"
	export_types = list(/obj/item/reagent_containers/blood/radaway)

/datum/export/item/stimpak
	cost = 40
	unit_name = "stimpak"
	export_types = list(/obj/item/reagent_containers/hypospray/medipen/stimpak)

/datum/export/item/superstimpak
	cost = 80
	unit_name = "super stimpak"
	export_types = list(/obj/item/reagent_containers/hypospray/medipen/stimpak/super)

/datum/export/item/tenmmpistol
	cost = 80
	unit_name = "n99 semiautomatic pistol"
	export_types = list(/obj/item/gun/ballistic/automatic/pistol/n99)

/datum/export/item/tenmmpistolchinese
	cost = 70
	unit_name = "type 17 semiautomatic pistol"
	export_types = list(/obj/item/gun/ballistic/automatic/pistol/type17)

/datum/export/item/ninemmpistol
	cost = 80
	unit_name = "browning hi-power"
	export_types = list(/obj/item/gun/ballistic/automatic/pistol/ninemil)

/datum/export/item/browningmnineteen
	cost = 50
	unit_name = "m1911"
	export_types = list(/obj/item/gun/ballistic/automatic/)

/datum/export/item/zipgunslist
	cost = 30
	unit_name = "improvised firearm"
	export_types = list(/obj/effect/spawner/bundle/f13/pepperbox,
				/obj/effect/spawner/bundle/weapon/piperifle,
				/obj/effect/spawner/bundle/f13/zipgun,
				/obj/item/gun/ballistic/revolver/hobo/knifegun,
				/obj/item/gun/ballistic/revolver/hobo/knucklegun,
				/obj/effect/spawner/bundle/f13/autopipe)

/datum/export/item/energycell
	cost = 250
	unit_name = "energy cell"
	export_types = list(/obj/item/stock_parts/cell/ammo/ec)

/datum/export/item/traitbookslow
	cost = 300
	unit_name = "low-quality technical manual"
	export_types = list(/obj/item/book/granter/trait/lowsurgery,
				/obj/item/book/granter/trait/chemistry,
				/obj/item/book/granter/crafting_recipe/scav_one,
				/obj/item/book/granter/crafting_recipe/scav_two,
				/obj/item/book/granter/trait/explosives,
				/obj/item/book/granter/trait/techno,
				/obj/item/book/granter/crafting_recipe/ODF,
				/obj/item/book/granter/action/drink_fling,
				/obj/item/book/granter/crafting_recipe/gunsmith_one)

/datum/export/item/traitbooks
	cost = 450
	unit_name = "high-quality technical manual"
	export_types = list(/obj/item/book/granter/trait/lowsurgery,
				/obj/item/book/granter/trait/chemistry,
				/obj/item/book/granter/trait/trekking,
				/obj/item/book/granter/trait/pa_wear,
				/obj/item/book/granter/trait/explosives,
				/obj/item/book/granter/trait/explosives_advanced,
				/obj/item/book/granter/trait/rifleman,
				/obj/item/book/granter/crafting_recipe/gunsmith_two,
				/obj/item/book/granter/crafting_recipe/gunsmith_three,
				/obj/item/book/granter/crafting_recipe/gunsmith_four)
