/obj/machinery/vending/boozeomat
	name = "\improper Platinum Inebriater"
	desc = "A technological marvel, supposedly able to mix just the mixture you'd like to drink the moment you ask for one."
	icon_state = "boozeomat"
	icon_deny = "boozeomat-deny"
	products = list(/obj/item/reagent_containers/food/drinks/drinkingglass = 30,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass = 12,
					/obj/item/reagent_containers/food/drinks/bottle/gin = 4,
					/obj/item/reagent_containers/food/drinks/bottle/whiskey = 4,
					/obj/item/reagent_containers/food/drinks/bottle/tequila = 4,
					/obj/item/reagent_containers/food/drinks/bottle/vodka = 4,
					/obj/item/reagent_containers/food/drinks/bottle/vermouth = 4,
					/obj/item/reagent_containers/food/drinks/bottle/rum = 4,
					/obj/item/reagent_containers/food/drinks/bottle/wine = 4,
					/obj/item/reagent_containers/food/drinks/bottle/cognac = 4,
					/obj/item/reagent_containers/food/drinks/bottle/kahlua = 4,
					/obj/item/reagent_containers/food/drinks/bottle/hcider = 4,
					/obj/item/reagent_containers/food/drinks/bottle/absinthe = 4,
					/obj/item/reagent_containers/food/drinks/bottle/grappa = 4,
					/obj/item/reagent_containers/food/drinks/bottle/sake = 4,
					/obj/item/reagent_containers/food/drinks/bottle/sake2 = 3,
					/obj/item/reagent_containers/food/drinks/bottle/rotgut = 3,
					/obj/item/reagent_containers/food/drinks/ale = 6,
					/obj/item/reagent_containers/food/drinks/bottle/orangejuice = 3,
					/obj/item/reagent_containers/food/drinks/bottle/tomatojuice = 3,
					/obj/item/reagent_containers/food/drinks/bottle/limejuice = 3,
					/obj/item/reagent_containers/food/drinks/bottle/grenadine = 3,
					/obj/item/reagent_containers/food/drinks/bottle/menthol = 3,
					/obj/item/reagent_containers/food/drinks/bottle/cream = 3,
					/obj/item/reagent_containers/glass/beaker/big_red/full = 10,
					/obj/item/reagent_containers/food/drinks/soda_cans/tonic = 4,
					/obj/item/reagent_containers/food/drinks/soda_cans/cola = 8,
					/obj/item/reagent_containers/food/drinks/soda_cans/sodawater = 15,
					/obj/item/reagent_containers/food/drinks/ice = 5,
					/obj/item/reagent_containers/food/drinks/flask = 3,
					/obj/item/reagent_containers/food/drinks/beer = 5,
					/obj/item/book/manual/nuka_recipes = 1)
	contraband = list(/obj/item/reagent_containers/food/drinks/mug/tea = 12,
					/obj/item/clothing/suit/armor/outfit/overalls/sexymaid = 5,
					/obj/item/clothing/head/maid = 5,
					/obj/item/clothing/neck/apron/bartender = 2,
					/obj/item/reagent_containers/food/drinks/bottle/fernet = 5)
	premium = list(/obj/item/reagent_containers/glass/bottle/ethanol = 4,
					/obj/item/reagent_containers/food/drinks/bottle/champagne = 5,
					/obj/item/reagent_containers/food/drinks/bottle/trappist = 5)
	//product_slogans = "Beantown Brown, because no one likes a snob.;Take the edge off Jack;Your key to hospitality;Quite delighted to serve you!;Care to wet your whistle?"
	product_ads = "Drink up!;Booze is good for you!;Alcohol is humanity's best friend.;Quite delighted to serve you!;Care for a nice, cold beer?;Nothing cures you like booze!;Have a sip!;Have a drink!;Have a beer!;Beer is good for you!;Only the finest alcohol!;Best quality booze since 2053!;Award-winning wine!;Maximum alcohol!;Man loves beer.;A toast for progress!"
	refill_canister = /obj/item/vending_refill/boozeomat
	default_price = PRICE_ALMOST_CHEAP
	extra_price = PRICE_EXPENSIVE
	payment_department = ACCOUNT_SRV
	cost_multiplier_per_dept = list(ACCOUNT_SRV = 0)

/obj/machinery/vending/boozeomat/pubby_maint //abandoned bar on Pubbystation
	products = list(/obj/item/reagent_containers/food/drinks/bottle/whiskey = 1,
			/obj/item/reagent_containers/food/drinks/bottle/absinthe = 1,
			/obj/item/reagent_containers/food/drinks/bottle/limejuice = 1,
			/obj/item/reagent_containers/food/drinks/bottle/cream = 1,
			/obj/item/reagent_containers/food/drinks/soda_cans/tonic = 1,
			/obj/item/reagent_containers/food/drinks/drinkingglass = 10,
			/obj/item/reagent_containers/food/drinks/ice = 3,
			/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass = 6,
			/obj/item/reagent_containers/food/drinks/flask = 1)

/obj/machinery/vending/boozeomat/pubby_captain //Captain's quarters on Pubbystation
	products = list(/obj/item/reagent_containers/food/drinks/bottle/rum = 1,
					/obj/item/reagent_containers/food/drinks/bottle/wine = 1,
					/obj/item/reagent_containers/food/drinks/ale = 1,
					/obj/item/reagent_containers/food/drinks/drinkingglass = 6,
					/obj/item/reagent_containers/food/drinks/ice = 1,
					/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass = 4);

/obj/machinery/vending/boozeomat/pubby_captain/Initialize()
	. = ..()
	cost_multiplier_per_dept = list("[ACCESS_CAPTAIN]" = 0)

/obj/machinery/vending/boozeomat/syndicate_access
	payment_department = NO_FREEBIES

/obj/machinery/vending/boozeomat/syndicate_access/Initialize()
	. = ..()
	cost_multiplier_per_dept = list("[ACCESS_SYNDICATE]" = 0)

/obj/item/vending_refill/boozeomat
	machine_name = "Booze-O-Mat"
	icon_state = "refill_booze"
