/obj/machinery/vending/tool
	name = "\improper H&H Tools Company Autovender"
	desc = "H&H Tools Company, also known as H&H Tools Inc. and H&H Tool Company, was a pre-War tools manufacturer."
	icon_state = "tool"
	icon_deny = "tool-deny"
	products = list(/obj/item/stack/cable_coil/random = 10,
					/obj/item/crowbar = 5,
					/obj/item/weldingtool = 3,
					/obj/item/wirecutters = 5,
					/obj/item/wrench = 5,
					/obj/item/analyzer = 5,
					/obj/item/t_scanner = 5,
					/obj/item/screwdriver = 5,
					/obj/item/flashlight/glowstick = 3,
					/obj/item/flashlight/glowstick/red = 3,
					/obj/item/flashlight = 5,
					/obj/item/clothing/gloves/color/yellow = 3)
	contraband = list(/obj/item/weldingtool/largetank = 4,
					/obj/item/clothing/gloves/color/fyellow = 4,
					/obj/item/multitool = 2)
	premium = list(/obj/item/clothing/gloves/color/yellow = 2,
					/obj/item/weldingtool/hugetank = 1)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 70)
	refill_canister = /obj/item/vending_refill/tool
	resistance_flags = FIRE_PROOF
	default_price = PRICE_REALLY_CHEAP
	extra_price = PRICE_EXPENSIVE
	payment_department = ACCOUNT_ENG
	cost_multiplier_per_dept = list(ACCOUNT_ENG = 0)

/obj/item/vending_refill/tool
	icon_state = "refill_engi"
