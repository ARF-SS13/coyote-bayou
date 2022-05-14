
/obj/item/reagent_containers/food/snacks/spaghetti
	name = "noodles"
	desc = "Long noodles served on a ceramic plate."
	icon = 'icons/obj/food/pizzaspaghetti.dmi'
	icon_state = "spaghetti"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/boiledspaghetti
	filling_color = "#F0E68C"
	tastes = list("pasta" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/boiledspaghetti
	name = "boiled noodles"
	desc = "A plain dish of noodles."
	icon = 'icons/obj/food/pizzaspaghetti.dmi'
	icon_state = "spaghettiboiled"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	custom_food_type = /obj/item/reagent_containers/food/snacks/customizable/pasta
	filling_color = "#F0E68C"
	tastes = list("pasta" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/pastatomato
	name = "spaghetti"
	desc = "Spaghetti and crushed tomatoes."
	icon = 'icons/obj/food/pizzaspaghetti.dmi'
	icon_state = "pastatomato"
	bitesize = 4
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/tomatojuice = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#DC143C"
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/copypasta
	name = "Double helping noodles"
	desc = "Way to many noodles for one person."
	icon = 'icons/obj/food/pizzaspaghetti.dmi'
	icon_state = "copypasta"
	bitesize = 4
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 12, /datum/reagent/consumable/tomatojuice = 20, /datum/reagent/consumable/nutriment/vitamin = 8)
	filling_color = "#DC143C"
	tastes = list("pasta" = 1, "tomato" = 1)
	foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/meatballspaghetti
	name = "spaghetti and meatballs"
	desc = "Now that's a nice meatball!"
	icon = 'icons/obj/food/pizzaspaghetti.dmi'
	icon_state = "meatballspaghetti"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#F0E68C"
	tastes = list("pasta" = 1, "tomato" = 1, "meat" = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/spesslaw
	name = "spesslaw"
	desc = "A lawyers favourite."
	icon = 'icons/obj/food/pizzaspaghetti.dmi'
	icon_state = "spesslaw"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 6)
	filling_color = "#F0E68C"
	tastes = list("pasta" = 1, "tomato" = 1, "meat" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/chowmein
	name = "chow mein"
	desc = "A nice mix of noodles and fried vegetables."
	icon = 'icons/obj/food/pizzaspaghetti.dmi'
	icon_state = "chowmein"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("noodle" = 1, "tomato" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/beefnoodle
	name = "beef noodle"
	desc = "Nutritious, beefy and noodly."
	icon = 'icons/obj/food/pizzaspaghetti.dmi'
	icon_state = "beefnoodle"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/liquidgibs = 3)
	tastes = list("noodle" = 1, "meat" = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/butternoodles
	name = "butter noodles"
	desc = "Noodles covered in savory butter. Simple and slippery, but delicious."
	icon = 'icons/obj/food/pizzaspaghetti.dmi'
	icon_state = "butternoodles"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("noodle" = 1, "butter" = 1)
	foodtype = GRAIN | DAIRY
