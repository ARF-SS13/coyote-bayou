/obj/machinery/vending/donksofttoyvendor
	name = "\improper Wilson Atomatoys"
	desc = "Ages 8 and up approved vendor that dispenses toys."
	icon_state = "syndi"
	//product_slogans = "Get your cool toys today!;Every girl's fantasy now made a reality!;Quality toys for cheap prices!;Give those commies the o' rock sock em kid!"
	product_ads = "Feel like a real soldier with your Red Ryder BB Gun!;Express your inner child today!;Don't shoot your eye out!;Slash and slay like Grognak!;Who needs responsibilities when you have toy weapons?;Make your next game of cops and commies FUN!"
	vend_reply = "Come back for more!"
	circuit = /obj/item/circuitboard/machine/vending/donksofttoyvendor
	products = list(/obj/item/tattoo_gun = 5,
		/obj/item/tattoo_holder/blank = 20,
		/obj/item/tattoo_holder/blank/temporary = 20,
		/obj/item/gun/ballistic/automatic/toy/unrestricted = 10,
		/obj/item/gun/ballistic/automatic/toy/pistol/unrestricted = 10,
		/obj/item/gun/ballistic/shotgun/toy/unrestricted = 10,
		/obj/item/toy/sword = 10,
		/obj/item/ammo_box/foambox = 20,
		/obj/item/toy/foamblade = 10,
		/obj/item/toy/syndicateballoon = 10,
		/obj/item/clothing/suit/syndicatefake = 5,
		/obj/item/clothing/head/syndicatefake = 5)
	contraband = list(
		/obj/item/gun/ballistic/shotgun/toy/crossbow = 10,
		/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted = 10,
		/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted = 10,
		/obj/item/toy/katana = 10,
		/obj/item/dualsaber/toy = 5)
	armor = ARMOR_VALUE_HEAVY
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/donksoft
	default_price = PRICE_ABOVE_NORMAL
	extra_price = PRICE_EXPENSIVE
	payment_department = ACCOUNT_SRV

/obj/item/vending_refill/donksoft
	machine_name = "Wilson Atomatoys"
	icon_state = "refill_donksoft"


/obj/machinery/vending/kink
	name = "\improper Kink Vendor"
	desc = "A place to get all your lewd needs!"
	//product_slogans = "This is where the dildo's are! Come get you one!"
	product_ads = "Don't have a partner? We got you covered!"
	icon_state = "kink"
	vend_reply = "Have fun!"
	products = list(
		/obj/item/toy/lewd/dildo/avian = 8,
		/obj/item/toy/lewd/dildo/canine = 8,
		/obj/item/toy/lewd/dildo/dragon = 8,
		/obj/item/toy/lewd/dildo/equine = 8,
		/obj/item/toy/lewd/dildo/human = 8,
		/obj/item/toy/lewd/dildo/tentacle = 8,
		/obj/item/toy/lewd/dildo/double = 8,
		/obj/item/toy/lewd/fleshlight/green =8,
		/obj/item/toy/lewd/fleshlight/teal = 8,
		/obj/item/toy/lewd/fleshlight/pink = 8,
		/obj/item/toy/lewd/fleshlight/red = 8,
		/obj/item/toy/lewd/fleshlight/yellow =8)

	default_price = PRICE_REALLY_CHEAP
	extra_price = PRICE_PRETTY_CHEAP
	payment_department = ACCOUNT_SRV

/obj/machinery/vending/lewdpillz
	name = "\improper Pillz Vendor"
	desc = "A dubious looking medicine dispenser, covered in graffiti and ad-hoc modifications."
	//product_slogans = "Pillz here!"
	product_ads = "Need some 'Fun Enhancers'? We got 'em here!"
	icon_state = "kink"
	vend_reply = "Have fun!"
	products = list(/obj/item/tattoo_gun = 5,
		/obj/item/tattoo_holder/blank = 20,
		/obj/item/tattoo_holder/blank/temporary = 20,
		/obj/item/storage/pill_bottle/breast_enlarger = 5,
		/obj/item/storage/pill_bottle/butt_enlarger = 5,
		/obj/item/storage/pill_bottle/penis_enlarger = 5,
		/obj/item/storage/pill_bottle/belly_enlarger = 5,
		/obj/item/storage/pill_bottle/random = 10)

	default_price = PRICE_REALLY_CHEAP
