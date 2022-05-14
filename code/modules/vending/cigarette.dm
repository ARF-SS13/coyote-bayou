/obj/machinery/vending/cigarette
	name = "\improper Big Boss Vending Machine"
	desc = "Big Boss cigarettes were a popular brand before the Great War, being found in and around major cities including Las Vegas, Pittsburgh, and Washington, D.C."
	product_slogans = "Grey Tortoise taste good like a cigarette should.;For the smoker who knows what he wants taste.;Longer than King Size so much more to enjoy!;After all, if smoking isn't a pleasure, why bother?!"
	product_ads = "Big Boss cigarettes. Great american taste;Unexpected flavor. Wild & free.;Perfectly aged tobacco.;No additives - True taste - No bull.;American matches for American Homes;Fine American blend also in menthol.;A rewarding experience.;Tastes as good as it looks."
	icon_state = "cigs"
	products = list(/obj/item/storage/fancy/cigarettes/cigpack_bigboss = 5,
					/obj/item/storage/fancy/cigarettes/cigpack_pyramid = 5,
					/obj/item/storage/fancy/cigarettes/cigpack_greytort = 5,
					/obj/item/storage/box/matches = 10,
					/obj/item/lighter/greyscale = 4,
					/obj/item/storage/fancy/rollingpapers = 5)
	contraband = list(/obj/item/lighter = 3)
	premium = list(/obj/item/storage/fancy/cigarettes/cigpack_robustgold = 3,
					/obj/item/storage/fancy/cigarettes/cigars = 1,
					/obj/item/storage/fancy/cigarettes/cigars/havana = 1,
					/obj/item/storage/fancy/cigarettes/cigars/cohiba = 1)
	refill_canister = /obj/item/vending_refill/cigarette
	default_price = PRICE_ALMOST_CHEAP
	extra_price = PRICE_ABOVE_NORMAL
	payment_department = ACCOUNT_SRV

/obj/machinery/vending/cigarette/syndicate
	products = list(/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 7,
					/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_robust = 2,
					/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_midori = 1,
					/obj/item/storage/box/matches = 10,
					/obj/item/lighter/greyscale = 4,
					/obj/item/storage/fancy/rollingpapers = 5)
	payment_department = NO_FREEBIES

/obj/machinery/vending/cigarette/syndicate/Initialize()
	. = ..()
	cost_multiplier_per_dept = list("[ACCESS_SYNDICATE]" = 0)

/obj/machinery/vending/cigarette/beach //Used in the lavaland_biodome_beach.dmm ruin
	name = "\improper Big Boss Vending Machine"
	desc = "Even after the War, their products are still a favorite and used, if they can be found at least, by American wastelanders."
	product_slogans = "Grey Tortoise taste good like a cigarette should.;For the smoker who knows what he wants taste.;Longer than King Size so much more to enjoy!;After all, if smoking isn't a pleasure, why bother?!"
	product_ads = "Big Boss cigarettes. Great american taste;Unexpected flavor. Wild & free.;Perfectly aged tobacco.;No additives - True taste - No bull.;American matches for American Homes;Fine American blend also in menthol.;A rewarding experience.;Tastes as good as it looks."
	products = list(/obj/item/storage/fancy/cigarettes = 5,
					/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_robust = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_midori = 3,
					/obj/item/storage/fancy/cigarettes/cigpack_cannabis = 5,
					/obj/item/storage/box/matches = 10,
					/obj/item/lighter/greyscale = 4,
					/obj/item/storage/fancy/rollingpapers = 5)
	premium = list(/obj/item/storage/fancy/cigarettes/cigpack_mindbreaker = 5,
					/obj/item/clothing/mask/vape = 5,
					/obj/item/lighter = 3)

/obj/item/vending_refill/cigarette
	machine_name = "Big Boss Vending Machine"
	icon_state = "refill_smoke"

/obj/machinery/vending/cigarette/pre_throw(obj/item/I)
	if(istype(I, /obj/item/lighter))
		var/obj/item/lighter/L = I
		L.set_lit(TRUE)
