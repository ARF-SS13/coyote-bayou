//This one's from bay12
/obj/machinery/vending/plasmaresearch
	name = "\improper Abraxodyne Chemicals"
	desc = "Abraxodyne Chemical (commonly shortened to Abraxodyne or Abraxo) was a pre-War company which produced detergents and other cleaning-related products and a fully owned subsidiary of RobCo Industries."
	products = list(/obj/item/clothing/under/rank/rnd/scientist = 6,
					/obj/item/clothing/suit/bio_suit = 6,
					/obj/item/clothing/head/bio_hood = 6,
					/obj/item/transfer_valve = 6,
					/obj/item/assembly/timer = 6,
					/obj/item/assembly/signaler = 6,
					/obj/item/assembly/prox_sensor = 6,
					/obj/item/assembly/igniter = 6)
	contraband = list(/obj/item/assembly/health = 3)
	default_price = PRICE_EXPENSIVE
	extra_price = PRICE_REALLY_EXPENSIVE
	payment_department = ACCOUNT_SCI
	cost_multiplier_per_dept = list(ACCOUNT_SCI = 0)
