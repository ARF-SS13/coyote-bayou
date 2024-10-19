/obj/machinery/vending/hydronutrients
	name = "\improper Greenway Hydroponics NutriMax"
	desc = "Greenway Hydroponics was a company founded by Derek Greenway following his departure from Poseidon Energy, focusing on pacifist applications on technology, making a killing through their state-of-the-art inventions in farming."
	//product_slogans = "Aren't you glad you don't have to fertilize the natural way?;Now with 50% less stink!;Plants are people too!"
	product_ads = "We like plants!;Don't you want some?;The greenest thumbs ever.;We like big plants.;Soft soil..."
	icon_state = "nutri"
	icon_deny = "nutri-deny"
	products = list(/obj/item/reagent_containers/glass/bottle/nutrient/ez = 30,
					/obj/item/reagent_containers/glass/bottle/nutrient/l4z = 20,
					/obj/item/reagent_containers/glass/bottle/nutrient/rh = 10,
					/obj/item/reagent_containers/spray/pestspray = 20,
					/obj/item/reagent_containers/syringe = 5,
					/obj/item/storage/bag/plants = 5,
					/obj/item/cultivator = 3,
					/obj/item/shovel/spade = 3,
					/obj/item/plant_analyzer = 4)
	contraband = list(/obj/item/reagent_containers/glass/bottle/ammonia = 10,
					/obj/item/reagent_containers/glass/bottle/diethylamine = 5)
	armor = ARMOR_VALUE_HEAVY
	resistance_flags = FIRE_PROOF
	default_price = PRICE_REALLY_CHEAP
	extra_price = PRICE_CHEAP
	payment_department = ACCOUNT_SRV
	cost_multiplier_per_dept = list(ACCOUNT_SRV = 0)

/obj/item/vending_refill/hydronutrients
	icon_state = "refill_hydro"
