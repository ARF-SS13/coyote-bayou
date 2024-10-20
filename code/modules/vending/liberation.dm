/obj/machinery/vending/liberationstation
	name = "\improper Liberation Station"
	desc = "An overwhelming amount of <b>ancient patriotism</b> washes over you just by looking at the machine."
	icon_state = "liberationstation"
	//product_slogans = "Liberation Station: Your one-stop shop for all things second ammendment!;Be a patriot today, pick up a gun!;Quality weapons for cheap prices!;Better dead than red!"
	product_ads = "Float like an astronaut, sting like a bullet!;Express your second ammendment today!;Guns don't kill people, but you can!;Who needs responsibilities when you have guns?"
	vend_reply = "Remember the name: Liberation Station!"
	products = list(/obj/item/reagent_containers/food/snacks/burger/plain = 5, //O say can you see, by the dawn's early light
					/obj/item/reagent_containers/food/snacks/burger/baseball = 3, //What so proudly we hailed at the twilight's last gleaming
					/obj/item/reagent_containers/food/snacks/fries = 5, //Whose broad stripes and bright stars through the perilous fight
					/obj/item/reagent_containers/food/drinks/beer/light = 10 //O'er the ramparts we watched, were so gallantly streaming?
)
	premium = list(	/obj/item/reagent_containers/food/snacks/cheesyfries = 5,
					/obj/item/reagent_containers/food/snacks/burger/baconburger = 5) //Premium burgers for the premium section
	contraband = list(/obj/item/clothing/under/misc/patriotsuit = 3,
					/obj/item/bedsheet/patriot = 5,
					/obj/item/reagent_containers/food/snacks/burger/superbite = 3) //U S A
	armor = ARMOR_VALUE_HEAVY
	resistance_flags = FIRE_PROOF
	default_price = PRICE_ABOVE_NORMAL
	extra_price = PRICE_ABOVE_EXPENSIVE
	payment_department = ACCOUNT_SEC
