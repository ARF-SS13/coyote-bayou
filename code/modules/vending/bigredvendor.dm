/obj/machinery/vending/bigredvend
	name = "\improper Atomic Red vending machine"
	desc = "A still-working Atomic Red vending machine! Full of that Atomic Red taste!"
	icon = 'icons/obj/f13vending.dmi'
	icon_state = "bigred_vending"
	icon_deny = "bigred_vending"
	//product_slogans = "Take a ride on a Atomic Red!"
	products = list(
		/obj/item/reagent_containers/glass/beaker/big_red/full = 20
		)
	contraband = list(
		/obj/item/reagent_containers/glass/beaker/big_red/full = 20
		)
	premium = list(
		/obj/item/reagent_containers/glass/beaker/big_red/full = 20
		)
	refill_canister = /obj/item/vending_refill/bigredvend

/obj/item/vending_refill/bigredvend
	machine_name = "Atomic Red vending machine"
	icon_state = "refill_cola"
//	charges = list(30, 8, 4)
//	init_charges = list(20, 4, 1)
