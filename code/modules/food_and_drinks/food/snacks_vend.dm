////////////////////////////////////////////SNACKS FROM VENDING MACHINES////////////////////////////////////////////
//in other words: junk food
//don't even bother looking for recipes for these

/obj/item/reagent_containers/food/snacks/candy
	name = "expired candy bar"
	desc = "The package may be illegible but the sugar rich chocolate confection inside that despite a touch of mold remains as edible as ever."
	icon_state = "candy"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/coco = 3)
	junkiness = 25
	filling_color = "#D2691E"
	tastes = list("candy" = 1)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/sosjerky
	name = "\improper Beef Jerky"
	icon_state = "sosjerky"
	desc = "Through the power of preservatives and desert heat this package of beef strips remains edible."
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sodiumchloride = 2)
	junkiness = 25
	filling_color = "#8B0000"
	tastes = list("dried meat" = 1)
	foodtype = JUNKFOOD | MEAT | SUGAR

/obj/item/reagent_containers/food/snacks/sosjerky/healthy
	name = "homemade beef jerky"
	desc = "These smoked and dried chunks of beast-flesh remain chewy and even somewhat nutritious for years, and years."
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	junkiness = 0

/obj/item/reagent_containers/food/snacks/sosjerky/ration
	name = "brahmin jerky"
	desc = "Brahmin jerky strips in a sealed package."
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	junkiness = 0
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/chips
	name = "potato chips"
	desc = "A bag of salted or flavored potato chips, sealed in an inert environment for freshness. A common snack pre-War, you can still find the odd pack of these in most places where people lived or worked."
	icon_state = "chips"
	bitesize = 1
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/sodiumchloride = 1)
	junkiness = 20
	filling_color = "#FFD700"
	tastes = list("salt" = 1, "crisps" = 1)
	foodtype = JUNKFOOD | FRIED

/obj/item/reagent_containers/food/snacks/no_raisin
	name = "Spring Vally"
	icon_state = "4no_raisins"
	desc = "Still fresh after all these years. Nobody is really sure why."
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 4)
	junkiness = 25
	filling_color = "#8B0000"
	tastes = list("dried raisins" = 1)
	foodtype = JUNKFOOD | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/no_raisin/healthy
	name = "homemade raisins"
	desc = "Homemade raisins, the best in the entire wasteland."
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	junkiness = 0
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/spacetwinkie
	name = "twinkie"
	icon_state = "space_twinkie"
	desc = "Guaranteed to survive longer than you will."
	list_reagents = list(/datum/reagent/consumable/sugar = 4)
	junkiness = 25
	filling_color = "#FFD700"
	foodtype = JUNKFOOD | GRAIN | SUGAR
	custom_price = PRICE_CHEAP_AS_FREE

/obj/item/reagent_containers/food/snacks/cheesiehonkers
	name = "cheesie curls"
	desc = "Bite sized cheesie snacks that will honk all over your mouth."
	icon_state = "cheesie_honkers"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3)
	junkiness = 25
	filling_color = "#FFD700"
	tastes = list("cheese" = 5, "crisps" = 2)
	foodtype = JUNKFOOD | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/syndicake
	name = "preservative laden snack cakes"
	icon_state = "syndi_cakes"
	desc = "An extremely moist snack cake that tastes just as good after being nuked."
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/doctor_delight = 5)
	filling_color = "#F5F5DC"
	tastes = list("sweetness" = 3, "cake" = 1)
	foodtype = GRAIN | FRUIT | VEGETABLES | ANTITOXIC
	custom_price = PRICE_CHEAP

/obj/item/reagent_containers/food/snacks/energybar
	name = "High-power energy bars"
	icon_state = "energybar"
	desc = "An energy bar with a lot of punch."
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/liquidelectricity = 3)
	filling_color = "#97ee63"
	tastes = list("pure electricity" = 3, "fitness" = 2)
	foodtype = TOXIC
