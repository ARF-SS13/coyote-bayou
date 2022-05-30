//////////////////////////Sushi Components///////////////////////

/obj/item/reagent_containers/food/snacks/sushi_rice
	name = "Sushi Rice"
	desc = "A bowl of sticky rice for making sushi."
	icon_state = "sushi_rice"
	list_reagents = list(/datum/reagent/consumable/sodiumchloride = 5)
	tastes = list("rice" = 5, "salt" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/sea_weed
	name = "Sea Weed Sheet"
	desc = "A thin, light salt sheet of plant mater. Used in sushi recipes,"
	icon_state = "sea_weed"
	list_reagents = list(/datum/reagent/consumable/sodiumchloride = 2)
	tastes = list("plants" = 2, "salt" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/tuna
	name = "Canned Tuna"
	desc = "A small can of tuna fish."
	icon_state = "tuna_can"
//trash = /obj/item/trash/tuna_used //I dont know if I like this idea - A Masked Cat
	list_reagents = list(/datum/reagent/consumable/sodiumchloride = 5, /datum/reagent/mercury = 2)
	tastes = list("tuna" = 15, "mercury" = 1, "salt" = 3)
	foodtype = MEAT

//////////////////////////Sushi/////////////////////////////////
/obj/item/reagent_containers/food/snacks/sushie_basic
	name = "Funa Hosomaki"
	desc = "A small cylindrical filled with rice and fish."
	icon_state = "sushie_basic"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	bitesize = 1
	filling_color = "#F2EEEA" //rgb(242, 238, 234)
	tastes = list("fish" = 1, "rice" = 1, "salt" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/sushie_adv
	name = "Funa Nigiri"
	desc = "A piece of carp lightly placed on some rice."
	icon_state = "sushie_adv"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 1
	filling_color = "#F2EEEA" //rgb(242, 238, 234)
	tastes = list("fish" = 1, "rice" = 1, "salt" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/sushie_pro
	name = "Funa Nigiri"
	desc = "A well prepared piece of the best of the carp fillet placed on rice. Looks fancy and fresh!"
	icon_state = "sushie_pro"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 8, /datum/reagent/consumable/nutriment/vitamin = 1)
	bitesize = 1
	filling_color = "#F2EEEA" //rgb(242, 238, 234)
	tastes = list("fish" = 1, "rice" = 1, "salt" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/tobiko
	name = "Tobiko"
	desc = "Spider eggs wrapped in a thin salted seaweed sheet."
	icon_state = "sushie_egg"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "#FF3333" // R225 G051 B051
	tastes = list("seaweed" = 1, "salty" = 2)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/riceball
	name = "Onigiri"
	desc = "A ball of rice with some light salt and a wrap of seaweed."
	icon_state = "riceball"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/sodiumchloride = 2)
	tastes = list("rice" = 4, "salt" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/sashimi
	name = "carp sashimi"
	desc = "Celebrate surviving attacks from super mutants by hospitalising yourself."
	icon_state = "sashimi"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/capsaicin = 4, /datum/reagent/consumable/nutriment/vitamin = 4)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/capsaicin = 5)
	filling_color = "#FA8072"
	tastes = list("fish" = 1, "hot peppers" = 1)
	foodtype = MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/fishing_sushi
	icon = 'icons/obj/fish/seafood.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/sodiumchloride = 2)
	tastes = list("rice" = 4, "salt" = 2, "seaweed" = 2, "fish" = 2)
	foodtype = GRAIN | MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/fishing_sushi/sake_sushi //salmon
	name = "sake sushi"
	desc = "Sushi that has been made with salmon."
	icon_state = "sushi_Sake"

/obj/item/reagent_containers/food/snacks/fishing_sushi/sake_cookedsalmon
	name = "cooked salmon sushi"
	desc = "Rather than wanting raw fish, you ordered a cooked salmon sushi."
	icon_state = "sushi_SmokedSalmon"

/obj/item/reagent_containers/food/snacks/fishing_sushi/ebi_sushi //cooked shrimp
	name = "ebi sushi"
	desc = "Sushi that has been made with cooked shrimp."
	icon_state = "sushi_Ebi"

/obj/item/reagent_containers/food/snacks/fishing_sushi/ikura_sushi //salmon roe
	name = "ikura sushi"
	desc = "Sushi that has been made with salmon roe."
	icon_state = "sushi_Ikura"

/obj/item/reagent_containers/food/snacks/fishing_sushi/maguro_sushi //tuna
	name = "maguro sushi"
	desc = "Sushi that has been made with tuna."
	icon_state = "sushi_Maguro"

/obj/item/reagent_containers/food/snacks/fishing_sushi/masago_sushi //any roe(?)
	name = "masago sushi"
	desc = "Sushi that has been made with some kind of roe?"
	icon_state = "sushi_Masago"
