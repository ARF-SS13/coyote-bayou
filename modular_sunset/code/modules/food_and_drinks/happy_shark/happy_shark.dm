// CUSTOM FLUFF FOOD FOR HAPPY SHARK JERKY //

/obj/item/reagent_containers/food/snacks/sunset/happyshark/jerky
	name = "Happy Sharky Jerky"
	desc = "Specially prepared and well seasoned jerky, brought to you by Happy Sharky Co."
	icon = 'modular_sunset/icons/obj/food/happy_shark.dmi'
	icon_state = "shark_jerky"
	bonus_reagents = list(/datum/reagent/consumable/honey = 1, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/nutriment = 5, /datum/reagent/drug/happiness = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/honey = 1)
	tastes = list("meat" = 2, "salt" = 1, "honey" = 1)
	filling_color = "#B22222"
	foodtype = MEAT


/obj/item/reagent_containers/food/snacks/sunset/happyshark/candybar
	name = "Happy Sharky Sweet Bar"
	desc = "A sweet and nutritious candy bar brought to you by Happy Sharky Co."
	icon = 'modular_sunset/icons/obj/food/happy_shark.dmi'
	icon_state = "shark_candy"
	bonus_reagents = list(/datum/reagent/consumable/yuccajuice = 1, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/drug/happiness = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/sugar = 10)
	tastes = list("chocolate" = 2, "pine nuts" = 1, "sweet potato" = 1)
	filling_color = "#BD4AD72"
	foodtype = SUGAR | GRAIN


/obj/item/reagent_containers/food/drinks/sunset/happyshark/bittercola
	name = "Happy Sharky Bittercola"
	desc = "A uniquely mixed cola brought to you by Happy Sharky Co. - Ice not included."
	icon = 'modular_sunset/icons/obj/food/happy_shark.dmi'
	icon_state = "shark_drink"
	list_reagents = list(/datum/reagent/consumable/nuka_cola = 15, /datum/reagent/consumable/sodawater = 15, /datum/reagent/medicine/healing_powder = 10)


//Happy Sharky Jerky: 1 cutlet, 1 unit of tablesalt, 1 coyote tobacco leaf, 1 mesquite pod

//Happy Sharky Sweet Bar: 1 Chocolate Bar, Two Banana Yucca Fruit, 1 Pinion Nuts

//Happy Sharky Bittercola: 2 parts Healing Powder, 2 Parts Nuka Cola, 1 Part Soda water, 1 part sugar
//Happy Sharky Bittercola: 1 broc flower, 1 xander root, 2 Parts Nuka Cola, 1 Part Soda water, 1 part sugar
