/obj/machinery/vending/snack
	name = "\improper Dine-o-Matic"
	desc = "A snack machine courtesy of the Port-a-Diner Vending Corporation."
	product_slogans = "Try our new nougat bar!;Twice the calories for half the price!"
	product_ads = "The healthiest!;Award-winning chocolate bars!;Mmm! So good!;Oh my god it's so juicy!;Have a snack.;Snacks are good for you!We love chocolate!;Try our new jerky!"
	icon_state = "snack"
	products = list(/obj/item/reagent_containers/food/snacks/f13/blamco = 4,
					/obj/item/reagent_containers/food/snacks/f13/bubblegum = 3,
					/obj/item/reagent_containers/food/snacks/f13/cram = 4,
					/obj/item/reagent_containers/food/snacks/f13/crisps = 4,
					/obj/item/reagent_containers/food/snacks/f13/dandyapples = 3,
					/obj/item/reagent_containers/food/snacks/f13/sugarbombs = 3,
					/obj/item/reagent_containers/food/snacks/f13/fancylads = 3,
					/obj/item/reagent_containers/food/snacks/f13/instamash = 5,
					/obj/item/reagent_containers/food/snacks/f13/mechanic = 3,
					/obj/item/reagent_containers/food/snacks/f13/steak = 5,
					/obj/item/reagent_containers/food/snacks/f13/yumyum = 3)
	contraband = list(
					/obj/item/reagent_containers/food/snacks/cracker = 2,
					/obj/item/reagent_containers/food/snacks/honeybar = 2,
					/obj/item/reagent_containers/food/snacks/beans = 4)
	premium = list(
					/obj/item/reagent_containers/food/snacks/lollipop = 4,
					/obj/item/reagent_containers/food/snacks/f13/specialapples = 2,
					/obj/item/reagent_containers/food/snacks/chococoin = 1,
					/obj/item/storage/box/marshmallow = 1,
					/obj/item/storage/box/donkpockets = 1)

	refill_canister = /obj/item/vending_refill/snack
	canload_access_list = list(ACCESS_KITCHEN)
	default_price = PRICE_REALLY_CHEAP
	extra_price = PRICE_ALMOST_CHEAP
	payment_department = ACCOUNT_SRV
	cost_multiplier_per_dept = list(ACCOUNT_SRV = 0)
	input_display_header = "Chef's Food Selection"

/obj/item/vending_refill/snack
	machine_name = "Getmore Chocolate Corp"

/obj/machinery/vending/snack/random
	name = "\improper Random Snackies"
	icon_state = "random_snack"
	desc = "Uh oh!"

/obj/machinery/vending/snack/random/Initialize()
	..()
	var/T = pick(subtypesof(/obj/machinery/vending/snack) - /obj/machinery/vending/snack/random)
	new T(loc)
	return INITIALIZE_HINT_QDEL

/obj/machinery/vending/snack/blue
	icon_state = "snackblue"

/obj/machinery/vending/snack/orange
	icon_state = "snackorange"

/obj/machinery/vending/snack/green
	icon_state = "snackgreen"

/obj/machinery/vending/snack/teal
	icon_state = "snackteal"
