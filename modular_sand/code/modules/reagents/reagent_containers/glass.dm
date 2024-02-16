/obj/item/reagent_containers/glass/beaker/ultimate
	name = "ultimate beaker"
	desc = "An ultimate beaker, made by extrapolating on bluespace technology \
		with dark matter combined. Can hold up to \
		900 units! And can withstand reagents of an extreme pH, \
		\nLiterally a chemist's dream."
	icon = 'modular_sand/icons/obj/chemical.dmi'
	icon_state = "beakerultimate"
	custom_materials = list(/datum/material/glass = 5000, /datum/material/plasma = 3000, /datum/material/diamond = 1000, /datum/material/bluespace = 1000)
	volume = 900
	possible_transfer_amounts = list(5,10,15,20,25,30,50,100,300,450,600,900)
	container_flags = APTFT_ALTCLICK|APTFT_VERB
	container_HP = 10
