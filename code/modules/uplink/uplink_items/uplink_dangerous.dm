
// Dangerous Items

/*
	Uplink Items:
	Unlike categories, uplink item entries are automatically sorted alphabetically on server init in a global list,
	When adding new entries to the file, please keep them sorted by category.
*/


/datum/uplink_item/dangerous/bioterror
	name = "Biohazardous Chemical Sprayer"
	desc = "A handheld chemical sprayer that allows a wide dispersal of selected chemicals. Especially tailored by the Tiger \
			Cooperative, the deadly blend it comes stocked with will disorient, damage, and disable your foes... \
			Use with extreme caution, to prevent exposure to yourself and your fellow operatives."
	item = /obj/item/reagent_containers/spray/chemsprayer/bioterror
	cost = 20
	surplus = 0
	include_modes = list(/datum/game_mode/nuclear)

/datum/uplink_item/dangerous/throwingweapons
	name = "Box of Throwing Weapons"
	desc = "A box of shurikens and reinforced bolas from ancient Earth martial arts. They are highly effective \
			throwing weapons. The bolas can knock a target down and the shurikens will embed into limbs."
	item = /obj/item/storage/box/syndie_kit/throwing_weapons
	cost = 3

/datum/uplink_item/dangerous/rapier
	name = "Rapier"
	desc = "An elegant plastitanium rapier with a diamond tip and coated in a specialized knockout poison. \
			The rapier comes with its own sheath, and is capable of puncturing through almost any defense. \
			However, due to the size of the blade and obvious nature of the sheath, the weapon stands out as being obviously nefarious."
	item = /obj/item/storage/belt/sabre/rapier
	cost = 8
	exclude_modes = list(/datum/game_mode/traitor/internal_affairs)


/datum/uplink_item/dangerous/rapid
	name = "Bands of the North Star"
	desc = "These armbands let the user punch people very fast and with the lethality of a legendary martial artist. \
			Does not improve weapon attack speed or the meaty fists of a hulk, but you will be unmatched in martial power. \
			Combines with all martial arts, but the user will be unable to bring themselves to use guns, nor remove the armbands."
	item = /obj/item/clothing/gloves/fingerless/pugilist/rapid
	cost = 30
	include_modes = list(/datum/game_mode/nuclear)

/datum/uplink_item/dangerous/guardian
	name = "Holoparasites"
	desc = "Though capable of near sorcerous feats via use of hardlight holograms and nanomachines, they require an \
			organic host as a home base and source of fuel. Holoparasites come in various types and share damage with their host."
	item = /obj/item/storage/box/syndie_kit/guardian
	cost = 15
	limited_stock = 1 // you can only have one holopara apparently?
	refundable = TRUE
	cant_discount = TRUE
	surplus = 0
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/traitor/internal_affairs)
	player_minimum = 25
	restricted = TRUE
	refund_path = /obj/item/guardiancreator/tech/choose/traitor

/datum/uplink_item/dangerous/nukieguardian // just like the normal holoparasites but without the support or deffensive stands because nukies shouldnt turtle
	name = "Holoparasites"
	desc = "Though capable of near sorcerous feats via use of hardlight holograms and nanomachines, they require an \
			organic host as a home base and source of fuel. Holoparasites come in various types and share damage with their host."
	item = /obj/item/storage/box/syndie_kit/nukieguardian
	cost = 15
	refundable = TRUE
	surplus = 50
	refund_path = /obj/item/guardiancreator/tech/choose/nukie
	include_modes = list(/datum/game_mode/nuclear)


/datum/uplink_item/dangerous/powerfist
	name = "Power Fist"
	desc = "The power-fist is a metal gauntlet with a built-in piston-ram powered by an external gas supply.\
		Upon hitting a target, the piston-ram will extend forward to make contact for some serious damage. \
		Using a wrench on the piston valve will allow you to tweak the amount of gas used per punch to \
		deal extra damage and hit targets further. Use a screwdriver to take out any attached tanks."
	item = /obj/item/melee/powerfist
	cost = 8
	exclude_modes = list(/datum/game_mode/traitor/internal_affairs)
