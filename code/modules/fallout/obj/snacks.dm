/obj/item/reagent_containers/food/snacks/rawbrahmintongue
	name = "Raw Brahmin Tongue"
	desc = "The raw tongue of a brahmin, a wastelander favorite"
	icon_state = "BrahminTongue"
	bitesize = 3
	filling_color = "#CD853F"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	cooked_type = /obj/item/reagent_containers/food/snacks/cookedbrahmintongue
	tastes = list("beef" = 4, "tender meat" = 1)
//	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/cookedbrahmintongue
	name = "Brahmin Tongue"
	desc = "A brahmin tongue slow roasted over an open fire and topped with a large amount of thick brown gravy"
	icon_state = "stewedsoymeat"
	bitesize = 3
	filling_color = "#CD853F"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	cooked_type = /obj/item/reagent_containers/food/snacks/cookedbrahmintongue
	tastes = list("top quality beef" = 4, "tender meat" = 1, "tasty gravy" = 1)
//	foodtype = MEAT


/obj/item/reagent_containers/food/snacks/rawbrahminliver
	name = "Raw Brahmin Liver"
	desc = "The raw liver of a brahmin, a wastelander favorite"
	icon_state = "Brahmin Liver"
	bitesize = 3
	filling_color = "#CD853F"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	cooked_type = /obj/item/reagent_containers/food/snacks/cookedbrahminliver
	tastes = list("beef" = 4, "tender meat" = 1)
//	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/cookedbrahminliver
	name = "Charred Brahmin Liver"
	desc = "A fatty brahmin liver roasted in a cast iron pan over mesquite wood."
	icon_state = "Charred Brahmin Liver"
	bitesize = 3
	filling_color = "#CD853F"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("slow cooked liver" = 4, "delicious crunch" = 1)
//	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/rawantbrain
	name = "Raw Ant Brain"
	desc = "Goppy reddish-grey flesh dug out of the brain case of a giant ant."
	icon_state = "AntBrain"
	bitesize = 3
	filling_color = "#CD853F"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("fat" = 4, "bitter meat" = 1)
//	foodtype = MEAT
