
/obj/machinery/vending/cola
	name = "\improper Nuka-Cola vending machine"
	icon = 'icons/obj/f13vending.dmi'
	desc = "The Nuka-Cola Corporation was a corporation, best known for its flagship product, Nuka-Cola. The soda is considered to be the most popular drink in the United States both before and after the war."
	icon_state = "nuka_vending"
	product_slogans = "Take the leap... enjoy a Quantum!"
	product_ads = "Refreshing!;Hope you're thirsty!;Over 1 million drinks sold!;Thirsty? Nothing beats the taste, the taste that'll knock you out!;Please, have a drink!;Drink up!;The best drinks in America."
	products = list(/obj/item/reagent_containers/food/drinks/bottle/f13nukacola/radioactive = 20)
	contraband = list(/obj/item/reagent_containers/food/drinks/bottle/f13nukacola = 4)
	premium = list(/obj/item/reagent_containers/food/drinks/drinkingglass/filled/nuka_cola = 1) //REAl nuka cola
	refill_canister = /obj/item/vending_refill/cola

/obj/item/vending_refill/cola
	machine_name = "Nuka-Cola vending machine"
	icon_state = "refill_cola"

/obj/machinery/vending/cola/random
	name = "\improper Random Drinkies"
	icon_state = "random_cola"
	desc = "Uh oh!"

/obj/machinery/vending/cola/random/Initialize()
	..()
	var/T = pick(subtypesof(/obj/machinery/vending/cola) - /obj/machinery/vending/cola/random)
	new T(loc)
	return INITIALIZE_HINT_QDEL

/obj/machinery/vending/cola/red
	icon_state = "red_cola"
	name = "\improper Vim Soda Vending Machine"
	desc = "A pre-war Vim Soda Vending Machine. You've got Vim!"
	product_slogans = "Get some Vim and Vigour in you!"
	products = list(/obj/item/reagent_containers/food/drinks/bottle/vim = 30)

/obj/machinery/vending/cola/space_up
	icon_state = "space_up"
	name = "\improper Sunset Sarsparilla Vending Machine"
	desc = "The Wests most Popular Soda Drink Vending Machine!"
	product_slogans = "Freshen Up with Sunset Sarsparilla!"
	products = list(/obj/item/reagent_containers/food/drinks/bottle/sunset = 30)

/obj/machinery/vending/cola/starkist
	icon_state = "starkist"
	name = "\improper Balls Guarana Vending Machine"
	desc = "A pre-war Balls Guarana Vending Machine. For that Bounce! To keep you going!"
	product_slogans = "The Drink to Keep you Going! Balls Guarana! Bounce!"
	products = list(/obj/item/reagent_containers/food/drinks/bottle/bawls = 30)
