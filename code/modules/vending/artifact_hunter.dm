/obj/machinery/vending/artifact
	name = "\improper Anomaly Hunter Supply"
	desc = "Vixen Labs FoxEye anomaly detection and retrieval gear, home made in the US of Nash."
	icon_state = "tool"
	icon_deny = "tool-deny"
	products = list(/obj/item/pinpointer/validball_finder = 10,
					/obj/item/artifact_finder = 10,
					/obj/item/storage/box/artifactcontainer/metal = 10,)
	armor = ARMOR_VALUE_HEAVY
	refill_canister = /obj/item/vending_refill/tool
	resistance_flags = FIRE_PROOF
	default_price = PRICE_REALLY_CHEAP
	extra_price = PRICE_EXPENSIVE
	payment_department = ACCOUNT_ENG
	cost_multiplier_per_dept = list(ACCOUNT_ENG = 0)

/obj/item/vending_refill/artifact
	icon_state = "refill_engi"
