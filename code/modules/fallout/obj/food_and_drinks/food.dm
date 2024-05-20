//Fallout 13 general food directory

//WASTELAND MEATS

/obj/item/reagent_containers/food/snacks/meat/slab/gecko
	name = "gecko fillet"
	desc = "A tasty fillet of gecko meat.<br>If you cook it, it tastes like chicken!"
	icon_state = "fishfillet"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/toxin = 1,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	bitesize = 2 //Smaller animal
	filling_color = "#FA8072"
	tastes = list("meat" = 4, "scales" = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/gecko
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/chicken
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/molerat
	name = "giant rat meat"
	desc = "A slab of smelly giant rat meat."
	icon_state = "bearmeat"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	bitesize = 3
	filling_color = "#FA8072"
	tastes = list("meat" = 4, "whiskers" = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/molerat
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/bear
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/wolf
	name = "dog meat"
	desc = "Chewy."
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	bitesize = 4 //Average animal
	filling_color = "#FA8072"
	tastes = list("meat" = 3)
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/wolf
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/deathclaw
	name = "deathclaw meat"
	desc = "A slab of hard but delicious deathclaw meat."
	icon_state = "goliathmeat"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/nutriment/vitamin = 9,
		/datum/reagent/medicine/tricordrazine = 5
	)
	bitesize = 6 //Big slabs of meat from a massive creature
	filling_color = "#FA8072"
	tastes = list("chewy meat" = 3, "scales" = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/deathclaw
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/bear
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk
	name = "mirelurk meat"
	desc = "Meat from a mirelurk, still inside its shell.  Going to need pliers for this..."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "mirelurk_meat"
	bitesize = 4 //Big animal, small part of it
	filling_color = "#406618" //Very dark green.
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/mirelurk
	tastes = list("crab" = 1)
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/chicken
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/squirrel
	name = "squirrel meat"
	desc = "Squirrel meat, the staple of many wasteland dishes when you can catch one."
	icon_state = "meat"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	bitesize = 2
	tastes = list("rodent" = 3, "chicken" = 1)
	filling_color = "#FA8072"
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/squirrel
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/chicken
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/radroach_meat
	name = "radroach meat"
	desc = "A hunk of still quivering radroach meat, gross."
	icon_state = "mothmeat"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	filling_color = "#e5b73b" //Meat brown associated to "mothmeat"
	bitesize = 2
	tastes = list("insect guts" = 3)
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/radroach_meat
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/ant_meat
	name = "ant meat"
	desc = "A sizable portion of ant flesh taken from the abdomen, almost looks appetizing, almost."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "antmeat"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	filling_color = "#e5b73b"
	bitesize = 3
	tastes = list("insect guts" = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/ant_meat
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/fireant_meat
	name = "fireant meat"
	desc = "A sizable portion of fire-ant flesh taken from the abdomen, it smellls slightly spicy."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "fireant_meat"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/capsaicin = 0.5,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	bitesize = 3
	tastes = list("insect guts" = 2, "spicyness" = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/ant_meat
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/bloatfly_meat
	name = "bloatfly meat"
	desc = "A slab of black-brown flesh from the abdomen of a bloatfly, disgusting."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "bloatfly_meat"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	filling_color = "#1c352d" // Medium jungle green
	bitesize = 2
	tastes = list("insect guts" = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/bloatfly_meat
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain
	foodtype = RAW | MEAT

/obj/item/reagent_containers/food/snacks/meat/slab/cazador_meat
	name = "cazador meat"
	desc = "Meat extracted from the lean hide of cazador wasp."
	icon_state = "mothmeat"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/toxin/carpotoxin = 3
	)
	filling_color = "#e5b73b"
	bitesize = 2
	tastes = list("insect guts" = 3, "sweet tangy liquid" = 1) //google says toxin is sweet anyway.
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/cazador_meat
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain
	foodtype = RAW | MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/meat/slab/radscorpion_meat
	name = "radscorpion meat"
	desc = "Meat from a radscorpion, still inside its chitin.  Going to need pliers for this."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "radscorpion_meat"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/toxin = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	filling_color = "#e5b73b"
	bitesize = 4
	tastes = list("insect guts" = 3, "sweet tangy liquid" = 2) //google says toxin is sweet anyway.
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/radscorpion_meat
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain
	foodtype = RAW | MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/meat/slab/human/ghoul
	name = "ghoul meat"
	desc = "Nothing says tasty like necrotic, radioactive mutant flesh"
	icon_state = "flymeat"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/radium = 6
	)
	tastes = list("rotting flesh" = 3)
	filling_color = "#7c1104" //Dark Red
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/ghoul
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain/human
	foodtype = RAW | MEAT | GROSS

/obj/item/reagent_containers/food/snacks/meat/slab/human/centaur
	name = "centaur meat"
	icon_state = "flymeat"
	desc = "Absolutely disgusting"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/radium = 10
	)
	tastes = list("abomination" = 2, "mutatated flesh" = 1)
	filling_color = "#7c1104"
	cooked_type = /obj/item/reagent_containers/food/snacks/meat/steak/centaur
	slice_path = /obj/item/reagent_containers/food/snacks/meat/rawcutlet/plain/human
	foodtype = RAW | MEAT | GROSS

//WASTELAND STEAKS

/obj/item/reagent_containers/food/snacks/meat/steak/gecko
	name = "gecko steak"
	desc = "A delicious steak made of finest gecko meat.<br>Tastes like chicken!"

/obj/item/reagent_containers/food/snacks/meat/steak/molerat
	name = "molerat steak"
	desc = "A smelly molerat steak.<br>What did you expect from roasted mutant rodent meat?"

/obj/item/reagent_containers/food/snacks/meat/steak/wolf
	name = "dog steak"
	desc = "A dog steak does not look attractive, but some people eat worse things when it comes to survival.<br>What did you expect from roasted dog?"

/obj/item/reagent_containers/food/snacks/meat/steak/radroach_meat
	name = "mutant pillbug steak"
	desc = "A off-color radroach steak.<br>you could have sworn you saw it still twitch."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "moth_steak"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	filling_color = "#967117" //Mode Beige
	tastes = list("bug protein" = 3)

/obj/item/reagent_containers/food/snacks/meat/steak/bloatfly_meat
	name = "baked bloatfly"
	desc = "A thoroughly blitzed bloatfly steak, eat it with your eyes closed."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "baked_bloatfly"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	filling_color = "#1c352d" // Medium jungle green
	tastes = list("baked insect" = 1)

/obj/item/reagent_containers/food/snacks/meat/steak/ant_meat
	name = "fried ant"
	desc = "A chunk of fried ant flesh."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "cookedantmeat"
	filling_color = "#967117"
	tastes = list("bug protein" = 1)

/obj/item/reagent_containers/food/snacks/meat/steak/fireant_meat
	name = "fried fire-ant"
	desc = "A chunk of spicy fried fireant flesh."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "cooked_fireant_meat"
	filling_color = "#967117"
	tastes = list("bug protein" = 1,"spicyness" = 1)

/obj/item/reagent_containers/food/snacks/meat/steak/cazador_meat
	name = "cazador steak"
	desc = "A off-color cazador steak, braized in its own venomous juices."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "moth_steak"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/toxin  = 1
	)
	tastes = list("bug protein" = 3, "sweet tangy liquid" = 1)
	filling_color = "#967117"

/obj/item/reagent_containers/food/snacks/meat/steak/radscorpion_meat
	name = "radscorpion roast"
	desc = "Meat from a radscorpion's chitin, cracked open and carefully roasted to perfection in its own posion."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "mirelurk_roast"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/toxin  = 2
	)
	tastes = list("bug protein" = 3, "sweet tangy liquid" = 1)

/obj/item/reagent_containers/food/snacks/meat/steak/deathclaw
	name = "deathclaw steak"
	desc = "A piece of hot spicy meat, eaten by only the most worthy hunters - or the most rich clients."
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/medicine/tricordrazine = 8
	)

/obj/item/reagent_containers/food/snacks/meat/steak/squirrel
	name = "squirrel steak"
	desc = "A steak made from a small slab of squirrel meat. It is, unsurprisingly, small."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "squirrel_steak"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)

/obj/item/reagent_containers/food/snacks/meat/steak/mirelurk
	name = "mirelurk roast"
	desc = "Meat from a mirelurks shell, cracked open and roasted to perfection."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "mirelurk_roast"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4
	)
	tastes = list("meat" = 2, "crab" = 1)

/obj/item/reagent_containers/food/snacks/meat/steak/ghoul
	name = "ghoul steak"
	desc = "Twice burnt ghoul meat steak. <br>Why would you even cook this?."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "ghoul_steak"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	bonus_reagents = list(
		/datum/reagent/radium = 3,
		/datum/reagent/consumable/nutriment/vitamin = 0.5
	)
	tastes = list("atomtic baked meat" = 3)
	filling_color = "#465945" //Gray Asparagus
	foodtype = MEAT | GROSS

/obj/item/reagent_containers/food/snacks/meat/steak/centaur
	name = "centaur steak"
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "ghoul_steak"
	desc = "No matter how much you cook, it doesn't seem safe to eat."
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	bonus_reagents = list(
		/datum/reagent/radium = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	tastes = list("atomtic baked meat" = 3, "abominable writhing" = 1)
	filling_color = "#465945"
	foodtype = MEAT | GROSS

//WASTELAND JUNK FOOD

/obj/item/reagent_containers/food/snacks/f13
	name = "ERROR"
	desc = "Badmins spawn shit!"
	icon = 'icons/obj/food/food.dmi'

/obj/item/reagent_containers/food/snacks/f13/bubblegum
	name = "Bubblegum"
	desc = "A Big Pops branded bubblegum."
	icon_state = "bubblegum"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 2
	)
	filling_color = "#B22222"
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/f13/bubblegum/large
	name = "big Bubblegum"
	desc = "A large \"Extra\" Big Pops branded bubblegum."
	icon_state = "bubblegum_large"
	bonus_reagents = list(
		/datum/reagent/radium = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 4
	)
	filling_color = "#B22222"
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/f13/cram
	name = "Cram"
	desc = "A blue labeled tin of processed meat, primarily used as rations for soldiers during the pre-War times."
	icon_state = "cram"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 5
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	filling_color = "#B22222"
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/cram/large
	name = "big Cram"
	desc = "A large blue labeled tin of processed meat, primarily used as rations for soldiers during the pre-War times."
	icon_state = "cram_large"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 10
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 40)
	filling_color = "#B22222"
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/yumyum
	name = "YumYum"
	desc = "YumYum was a pre-War company in the United States, producing packaged foods.<br>YumYum Deviled Eggs was their major product."
	icon_state = "yumyum"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	filling_color = "#B22222"
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/fancylads
	name = "Fancy Lads"
	desc = "The presence of snack cakes is a nod to the urban myth that Twinkies and other similar foods would survive a nuclear war.<br>The slogan is \"A big delight in every bite\"."
	icon_state = "fancylads"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	filling_color = "#B22222"
	foodtype = JUNKFOOD | SUGAR | GRAIN

/obj/item/reagent_containers/food/snacks/f13/sugarbombs
	name = "Sugar Bombs"
	desc = "Sugar Bombs is a pre-War breakfast cereal that can be found all around the wasteland, packaged in white and blue boxes with a red ovoid logo at the top, fully labeled as \"Sugar Bombs breakfast cereal\"."
	icon_state = "sugarbombs"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/sugar = 10
	)
	filling_color = "#B22222"
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/f13/crisps
	name = "Crisps"
	desc = "Potato Crisps are packaged in a small red and green box, with a yellow bubble encouraging the purchaser to \"See Moon Map Offer on Back!\"."
	icon_state = "crisps"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#B22222"
	foodtype = JUNKFOOD

/obj/item/reagent_containers/food/snacks/f13/steak
	name = "Salisbury Steak"
	desc = "A worn, red box displaying a picture of steak with the words \"Salisbury Steak\" at the top and \"now with Gravy!\" at the bottom."
	icon_state = "steak"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 5
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 50)
	filling_color = "#B22222"
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/specialapples
	name = "Dandy Apples Special"
	desc = "Dandy Apples Special are a product from the pre-War company Dandy Boy. On the sides of the box there is some sort of apple mascot with a bowler hat, monocle and mustache."
	icon_state = "specialapples"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/medicine/tricordrazine = 10
	)
	filling_color = "#B22222"
	foodtype = DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/f13/dandyapples
	name = "Dandy Boy Apples"
	desc = "Dandy Boy Apples are a product from the pre-War company Dandy Boy, consisting of candied apples packaged in a red cardboard box."
	icon_state = "dandyapples"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/sugar = 10
	)
	filling_color = "#B22222"
	foodtype = DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/f13/blamco
	name = "BlamCo"
	desc = "BlamCo was a pre-War company in the United States, producing packaged foods.<br>BlamCo Mac & Cheese was their major product.<br>Unlike other foods, like apples or eggs, wheat cannot be freeze-dried. How the macaroni remains edible is unclear."
	icon_state = "blamco"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	filling_color = "#B22222"
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/f13/blamco/large
	name = "big BlamCo"
	desc = "BlamCo was a pre-War company in the United States, producing packaged foods.<br>BlamCo Mac & Cheese was their major product.<br>Unlike other foods, like apples or eggs, wheat cannot be freeze-dried. How the macaroni remains edible is unclear."
	icon_state = "blamco_large"
	bonus_reagents = list(
		/datum/reagent/radium = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	filling_color = "#B22222"
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/f13/mechanic
	name = "MechaMash"
	desc = "MechaMash is packaged in a white box with blue highlights, and a wrench logo printed on the front.<br>It appears to be a form of instant potatoes that smells like WD-40..."
	icon_state = "mechanist"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	filling_color = "#B22222"
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/f13/instamash
	name = "InstaMash"
	desc = "InstaMash is packaged in a white box with blue highlights.<br>It appears to be a form of instant potatoes."
	icon_state = "instamash"
	bonus_reagents = list(
		/datum/reagent/radium = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 15)
	filling_color = "#B22222"
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/f13/mre
	name = "MRE"
	desc = "The Meal, Ready-to-Eat : commonly known as the MRE - is a self-contained, individual field ration in lightweight packaging.<br>It's commonly used by military groups for service members to use in combat or other field conditions where organized food facilities are not available."
	icon_state = "mre"
	bonus_reagents = list(
		/datum/reagent/medicine/silver_sulfadiazine = 10,
		/datum/reagent/medicine/tricordrazine = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	filling_color = "#B22222"

/obj/item/reagent_containers/food/snacks/f13/galette
	name = "dehydrated pea soup"
	desc = "A piece of military food ration.<br>Faded label on the front says: \"Dehydrated peas. Chew well, take with water. 60g.\""
	icon_state = "galette"
	bonus_reagents = list(
		/datum/reagent/consumable/sodiumchloride = 2,
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/medicine/tricordrazine = 2
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	filling_color = "#B22222"
	foodtype = VEGETABLES

//WASTELAND EGGS

/obj/item/reagent_containers/food/snacks/f13/deathclawegg
	name = "deathclaw egg"
	desc = "A deathclaw egg. It has a brownish-red shell. Look at this thing, it's as big as your torso!"
	icon_state = "deathclawegg"
	bonus_reagents = list(/datum/reagent/toxin = 30)
	list_reagents = list(/datum/reagent/consumable/eggyolk = 40)
	filling_color = "#F0E68C"
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/deathclawegg/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..()) //was it caught by a mob?
		var/turf/T = get_turf(hit_atom)
		new/obj/effect/decal/cleanable/egg_smudge(T)
		reagents.reaction(hit_atom, TOUCH)
		qdel(src)

/obj/item/reagent_containers/food/snacks/f13/giantantegg
	name = "giant ant egg"
	desc = "A giant ant egg.<br>You'd thought it be bigger but its white and squishy to the touch."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "antegg"
	bonus_reagents = list(/datum/reagent/toxin = 10)
	list_reagents = list(/datum/reagent/consumable/eggyolk = 15)
	filling_color = "#F0E68C"
	foodtype = MEAT

//WASTELAND PREPARED MEALS

/obj/item/reagent_containers/food/snacks/meatsalted
	name = "salted meat"
	desc = "Slab of meat preserved in salt. Makes you thirsty."
	icon_state = "meatsalted"
	bitesize = 5
	filling_color = "#800000"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	tastes = list("meat" = 2, "salt" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/meatsmoked
	name = "smoked meat"
	desc = "Slab of meat dried by smoking. Leathery consistency."
	icon_state = "meatsmoked"
	bitesize = 5
	filling_color = "#800000"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	tastes = list("meat" = 2, "smoke" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/breadhard
	name = "hard bread"
	desc = "Flat dried bread, stores well."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "breadhard"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 7)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	bitesize = 5
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("bread" = 1, "smoke" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/f13/molejerky
	name = "molerat wondermeat"
	desc = "Molerat meat cured with wonderglue. Has a nutty aftertaste."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "wondermeat"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 12)
	filling_color = "#B22222"
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/caravanlunch
	name = "caravan lunch"
	desc = "A collection of food conveniently assembled into a lunchbox with the radiation removed. Simple, fast and filling. Often eaten by merchants."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "caravanlunch"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 50)
	filling_color = "B#22222"
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/f13/wastelandwellington
	name = "wasteland wellington"
	desc = "Meat from wasteland critters wrapped in puffy pastry. Delicious, rich and certainly high class."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "wasteland_wellington"
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/medicine/tricordrazine = 5
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 30)
	filling_color = "B#22222"
	foodtype = MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/f13/deathclawomelette
	name = "deathclaw omelette"
	desc = "A delicious omelette made from one big deathclaw egg. Hope you're not allergic."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "deathclawomlette"
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/medicine/omnizine = 40,
		/datum/reagent/medicine/dexalin = 10
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 60)
	filling_color = "B#22222"
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/crispysquirrel
	name = "crispy squirrel bits"
	desc = "Bits of squirrel meat roasted on a skewer. Tasty."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "squrrielbits"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12)
	filling_color = "B#22222"
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/squirrelstick
	name = "squirrel on a stick"
	desc = "It's a whole squirrel roasted on a stick. Tastes of home on the wastes."
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "squrrielstick"
	list_reagents = list(/datum/reagent/consumable/nutriment = 24)
	filling_color = "B#22222"
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/mirelurkcake
	name = "mirelurk cake"
	desc = "A savory cake made from the meat of a Mirelurk.  A popular dish from the coastlines."
	bitesize = 5
	icon = 'icons/fallout/objects/food&drinks/food.dmi'
	icon_state = "Mirelurk_cake"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 9
	)
	tastes = list("cake" = 1, "crab" = 5)
	filling_color = "#406618"
	foodtype = MEAT

//WASTELAND SOUPS

/obj/item/reagent_containers/food/snacks/soup/moleratstew
	name = "molerat stew"
	desc = "A nice and warm stew. Healthy and strong."
	icon = 'icons/fallout/objects/food&drinks/soupsalad.dmi'
	icon_state = "molerat_stew"
	volume = 35
	list_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/medicine/oculine = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5
	)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/vitamin = 5
	)
	tastes = list("gamey meat" = 1, "filling stew" = 1)
	foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/soup/buffalogourd
	name = "buffalo gourd soup"
	desc = "A tasty soup made with roasted gourd."
	icon = 'icons/fallout/objects/food&drinks/soupsalad.dmi'
	icon_state = "buffalo_soup"
	volume = 40
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6
	)
	tastes = list("buttery flesh" = 1, "creamy soup" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/squirrelstew
	name = "squirrel stew"
	desc = "Stewed squirrel meat with veggies. There's more vegetable than meat."
	icon = 'icons/fallout/objects/food&drinks/soupsalad.dmi'
	icon_state = "squrrielsoup"
	bitesize = 4
	volume = 25
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 32)
	filling_color = "B#22222"
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/longpork_stew
	name = "longpork stew"
	desc = "A thick, oily stew that tastes and smells weird. Has small pieces of raw, chewy meat."
	icon = 'icons/fallout/objects/food&drinks/soupsalad.dmi'
	icon_state = "molerat_stew"
	bitesize = 4
	volume = 30
	list_reagents = list(/datum/reagent/medicine/longpork_stew = 30)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/medicine/longpork_stew = 5
	)
	filling_color = "#a7510b"
	tastes = list("oily broth" = 5, "chewy meat" = 1)
	foodtype = MEAT | LONGPORK

/obj/item/reagent_containers/food/snacks/soup/mirelurkstew
	name = "mirelurk stew"
	desc = "A hearty stew made from de-shelled mirelurk meat, onions, butter, and other such delights."
	icon = 'icons/fallout/objects/food&drinks/soupsalad.dmi'
	icon_state = "mirelurk_stew"
	bitesize = 6
	volume = 50
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/medicine/tricordrazine = 5
	)
	tastes = list("crab" = 5, "onions" = 1)
	filling_color = "#406618"
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/soup/rubycasserole
	name = "ruby's radscorpion casserole"
	desc = "A flavorsome casserole made from from radscorpion meat, chillipeppers, molerat meat, and love."
	icon = 'icons/fallout/objects/food&drinks/soupsalad.dmi'
	icon_state = "radscorpion_casserole"
	bitesize = 6
	volume = 50
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/medicine/tricordrazine = 5,
		/datum/reagent/consumable/capsaicin = 2.5
	)
	tastes = list("casserole" = 5, "meat" = 2, "peppers" = 2)
	filling_color = "#406618"
	foodtype = MEAT | VEGETABLES

// Canned Items

/obj/item/reagent_containers/food/snacks/f13/canned
	name = "canned food item"
	desc = "If you see this, call an admin."
	var/is_open = FALSE

/obj/item/reagent_containers/food/snacks/f13/canned/update_icon_state()
	if(!is_open)
		icon_state = "[icon_state]"
	else
		icon_state = "[icon_state]-op"

/obj/item/reagent_containers/food/snacks/f13/canned/attack_self(mob/user)
	if(!is_open)
		is_open = TRUE
		to_chat(user, span_notice("You open the lid of the can."))
		update_icon()
		return
	. = ..()

/obj/item/reagent_containers/food/snacks/f13/canned/attack(mob/living/M, mob/living/user)
	if(!is_open)
		to_chat(user, span_warning("You need to open [src] first."))
		return
	. = ..()

/obj/item/reagent_containers/food/snacks/f13/canned/porknbeans
	name = "can of pork n' beans"
	desc = "Pork n' Beans come in a small brown and orange tin, with a label that reads \"Greasy Prospector Improved Pork And Beans\".<br>Toward the bottom of the label is printed that the beans come \"With Hickory Smoked Pig Fat Chunks\"."
	icon_state = "porknbeans"
	bonus_reagents = list(
		/datum/reagent/radium = 1,
		/datum/reagent/consumable/nutriment/vitamin = 2
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 35)
	filling_color = "#B22222"
	tastes = list("doughy beans" = 5, "pork flavoring" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/f13/canned/borscht
	name = "canned borscht"
	desc = "A faded label says something in Cyrillic, but you can't understand a thing.<br>\"KOHCEPBA BKYCHOTA TOMAT CMETAHA MOCKBA\"<br>\"cynep cyn!\"<br>An image of a plate with some red soup explains a lot."
	icon_state = "borscht"
	bonus_reagents = list(
		/datum/reagent/radium = 1,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 35)
	filling_color = "#B22222"
	tastes = list("old beets" = 4, "vegetables" = 2, "meat broth" = 2)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/f13/canned/dog //Max Rockatansky favorite
	name = "dog food"
	desc = "A can of greasy meat with a faded cartoon dog on the label.<br>Smells bad, tastes worse, but filling.<br>Not good enough to get bitten over, though." //Mad Max: Road Warrior 1981 dog food scene reference
	icon_state = "dog"
	bonus_reagents = list(
		/datum/reagent/radium = 1,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 35)
	filling_color = "#B22222"
	tastes = list("mushy kibble" = 4, "musty meat" = 2)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/canned/ncr
	name = "canned military ration"
	desc = "If you see this, call an admin."
	filling_color = "#B22222"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 35,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	icon_state = "c_ration_1"

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/brahmin_chili
	name = "c-ration entree - 'Brahmin Meatchunks in Fava Bean Chili'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	tastes = list("brahmin" = 4, "beans" = 2, "spicy chili" = 2)
	foodtype = MEAT | VEGETABLES
	filling_color = "#38170d"

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/bighorner_sausage
	name = "c-ration entree - 'Bighorner Franks in Tato Sauce'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	tastes = list("bighorner sausage" = 4, "tato sauce" = 2)
	foodtype = MEAT | VEGETABLES
	filling_color = "#38170d"

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/igauna_bits
	name = "c-ration entree - 'Iguana Bite Tacos'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	tastes = list("crispy iguana" = 4, "corn tortilla" = 2)
	foodtype = MEAT | VEGETABLES
	filling_color = "#38230d"

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/grilled_radstag
	name = "c-ration entree - 'Grilled Radstag with Potato Puree and Gravy'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	tastes = list("grilled radstag" = 4, "potatoes and gravy" = 2)
	foodtype = MEAT | VEGETABLES
	filling_color = "#38230d"

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/molerat_stew
	name = "c-ration entree - 'Molerat Stew'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	tastes = list("molerat" = 4, "stewed vegetables" = 2)
	foodtype = MEAT | VEGETABLES
	filling_color = "#38230d"
	cooked_type = /obj/item/reagent_containers/food/snacks/soup/moleratstew

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/ham_and_eggs
	name = "c-ration entree - 'Brahmin Ham and Mirelurk Eggs'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	tastes = list("ham" = 4, "EXTREMELY fishy eggs" = 4)
	foodtype = MEAT | VEGETABLES | GROSS

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/brahmin_burger
	name = "c-ration entree - 'Brahmin Burger'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	tastes = list("a pretty damn good burger" = 4)
	foodtype = MEAT | GRAIN
	cooked_type = /obj/item/reagent_containers/food/snacks/burger/bigbite

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/vegetable_soup
	name = "c-ration entree - 'Vegetable Soup'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	tastes = list("crunchy vegetables" = 4, "stewed vegetables" = 2)
	foodtype = VEGETABLES
	cooked_type = /obj/item/reagent_containers/food/snacks/soup/vegetable

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/mirelurk_filets
	name = "c-ration entree - 'Smoked Mirelurk Filets'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	tastes = list("smoked fish" = 3)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/yaoguai_meatballs
	name = "c-ration entree - 'Yao Guai Meatballs in Tato Sauce'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	tastes = list("gamey meat" = 3, "tato sauce" = 3)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/brahmin_dogs
	name = "c-ration entree - 'Brahmin Dogs'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	tastes = list("a pretty damn good hotdog" = 4)
	foodtype = MEAT | VEGETABLES
	cooked_type = /obj/item/reagent_containers/food/snacks/hotdog

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/crackers
	name = "c-ration crackers"
	desc = "A canned food product containing crackers as part of a military combat ration. Use a knife to get the crackers out."
	tastes = list("cracker" = 4)
	foodtype = GRAIN
	slice_path = /obj/item/reagent_containers/food/snacks/cracker/c_ration
	slices_num = 4

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/candied_mutfruit
	name = "c-ration dessert - 'Candied Mutfruit'"
	desc = "A canned food product containing the dessert portion of a military combat ration."
	icon_state = "c_ration_3"
	tastes = list("mutfruit" = 3, "sugar" = 3)
	foodtype = SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/cranberry_cobbler
	name = "c-ration dessert - 'Cranberry Cobbler'"
	desc = "A canned food product containing the dessert portion of a military combat ration."
	icon_state = "c_ration_3"
	tastes = list("perfectly replicated GMO cranberries" = 3, "buttery flakey crust" = 2)
	foodtype = SUGAR | FRUIT | GRAIN

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/breakfast
	name = "k-ration entree - 'Brahmin Chorizo Con Huevos'"
	desc = "A canned food product containing the entree portion of a military combat ration."
	icon_state = "k_ration_can"
	tastes = list("rich beef" = 3, "peppers" = 3, "eggs" = 2)
	foodtype = MEAT | VEGETABLES | BREAKFAST

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/lunch
	name = "k-ration entree - 'Baja Enchiladas'"
	desc = "A canned food product containing the entree portion of a military combat ration, a star with the initials 'A.F' is stamped on the can."
	icon_state = "k_ration_can"
	tastes = list("corn tortilla" = 2, "stewed brahmin" = 3, "picante salsa" = 3)
	foodtype = MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/f13/canned/ncr/dinner
	name = "k-ration entree - 'Spiced Dinner Luncheon'"
	desc = "A canned food product containing the entree portion of a military combat ration. Better than Cram."
	icon_state = "k_ration_can"
	tastes = list("beef luncheon loaf" = 3, "jalapeno peppers and spices" = 2)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/broiled_death_claw
	name = "broiled deathclaw"
	desc = "All the flavor seared in for extra kick."
	icon_state = "broiled_death_claw"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/medicine/omnizine = 5
	)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10
	)
	tastes = list("deathclaw meat" = 3, "butter" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/fire_ant_fricassee
	name = "fire ant fricassee"
	desc = "Breaded fire ant meat soaked in cram."
	icon_state = "fire_ant_fricassee"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 12)
	tastes = list("Fire Ant Meat" = 2, "flour" = 1, "cram" = 1)
	foodtype = MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/f13/fried_brahmin_skin
	name = "brahmin cracklings"
	desc = "Cracklings are the solid material which remains after rendering animal fat and skin to produce lard, tallow, or schmaltz. It is often eaten as a snack food or made into animal feed. It is also used in cooking."
	icon_state = "fried_brahmin_skin"
	filling_color = "#CD5C5C"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	tastes = list("crispy skin" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/molerat_manicotti
	name = "molerat manicotti"
	desc = "Molerat meat wrapped in a pasta tube."
	icon_state = "molerat_manicotti"
	list_reagents = list(/datum/reagent/consumable/nutriment = 12)
	tastes = list("molerat Meat" = 2, "dough" = 1)
	foodtype = MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/f13/chitlins_con_carne
	name = "chitlins con carne"
	desc = "Uses EVERY part of the cazador!"
	icon_state = "chitlins_con_carne"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("cazador meat" = 2, "dough" = 1)
	foodtype = MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/f13/fried_molerat_lung
	name = "fried molerat lung"
	desc = "Halfway to molerat haggis."
	icon_state = "fried_molerat_lung"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 12)
	tastes = list("molerat lung" = 2)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/tato_surpise
	name = "tato suprise"
	desc = "The surprise is Tato."
	icon_state = "tato_surpise"
	bonus_reagents = list(
		/datum/reagent/medicine/antitoxin = 0.01,
		/datum/reagent/medicine/salglu_solution = 0.01,
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1
	)
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	tastes = list("tato" = 2, "xander" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/radscorpion_en_croute
	name = "radscorpion en croute"
	desc = "Radscorpion meat pie, no stingers included."
	icon_state = "radscorpion_en_croute"
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	tastes = list("cooked insect guts" = 2, "pastry dough" = 1)
	foodtype = MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/f13/deathclaw_egg_omelette
	name = "deathclaw egg omelette"
	desc = "An omelette made from a pristine deathclaw eggs."
	icon_state = "deathclaw_egg_omelette"
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 16,
		/datum/reagent/medicine/omnizine = 60,
		/datum/reagent/medicine/dexalin = 20
	)
	list_reagents = list(/datum/reagent/consumable/nutriment = 80)
	tastes = list("deathclaw eggs" = 2, "deathclaw Meat" = 2, "cheese" = 1)
	foodtype = MEAT | DAIRY

/obj/item/reagent_containers/food/snacks/f13/baked_nightstalker_tail
	name = "baked nightstalker tail"
	desc = "Shake it to hear it rattle!"
	icon_state = "baked_nightstalker_tail"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/f13/brahminpotpie
	name = "Brahmin potpie"
	icon_state = "brahmin_pot_pie"
	desc = "A pot pie is a type of pie with a top pie crust, sometimes a bottom pie crust, consisting of flaky pastry This is filled with stewed brahmin tongue"
	bonus_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment = 6
	)
	tastes = list("pie" = 1, "meat" = 1, "gravy" = 1)
	bitesize = 4
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/f13/gecko_kebab
	name = "gecko kebab"
	desc = "Would you like to buy a nice kebab?"
	icon_state = "gecko_kebab"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	foodtype = MEAT
