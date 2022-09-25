/obj/machinery/vending/wallmed
	name = "\improper Med-Tek Dispenser"
	desc = "Wall-mounted Medical Equipment dispenser."
	icon_state = "wallmed"
	icon_deny = "wallmed-deny"
	density = FALSE
	products = list(/obj/item/reagent_containers/syringe = 3,
					/obj/item/reagent_containers/pill/patch/styptic = 5,
					/obj/item/reagent_containers/pill/patch/silver_sulf = 5,
					/obj/item/reagent_containers/medspray/styptic = 2,
					/obj/item/reagent_containers/medspray/silver_sulf = 2,
					/obj/item/reagent_containers/pill/charcoal = 2,
					/obj/item/reagent_containers/medspray/sterilizine = 1,
					/obj/item/healthanalyzer/wound = 2,
					/obj/item/stack/medical/bone_gel = 2,
					/obj/item/reagent_containers/syringe/dart = 10)
	contraband = list(/obj/item/reagent_containers/pill/tox = 2,
					/obj/item/reagent_containers/pill/morphine = 2)
	premium = list(/obj/item/reagent_containers/medspray/synthflesh = 2)
	armor = ARMOR_VALUE_HEAVY
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/wallmed
	default_price = PRICE_FREE
	extra_price = PRICE_NORMAL
	payment_department = ACCOUNT_MED
	cost_multiplier_per_dept = list(ACCOUNT_MED = 0)
	tiltable = FALSE

/obj/item/vending_refill/wallmed
	machine_name = "NanoMed"
	icon_state = "refill_medical"

/obj/machinery/vending/wallmed/pubby
	products = list(/obj/item/reagent_containers/syringe = 3,
					/obj/item/reagent_containers/pill/patch/styptic = 1,
					/obj/item/reagent_containers/pill/patch/silver_sulf = 1,
					/obj/item/reagent_containers/medspray/sterilizine = 1)
	premium = list(/obj/item/reagent_containers/medspray/synthflesh = 2)
