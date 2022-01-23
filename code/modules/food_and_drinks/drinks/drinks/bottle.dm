

///////////////////////////////////////////////Alchohol bottles! -Agouri //////////////////////////
//Functionally identical to regular drinks. The only difference is that the default bottle size is 100. - Darem
//Bottle knockdown is cancer. - Scheveningen

/obj/item/reagent_containers/food/drinks/bottle
	amount_per_transfer_from_this = 10
	volume = 100
	force = 15
	throwforce = 15
	item_state = "broken_beer" //Generic held-item sprite until unique ones are made.
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	var/knockdown_duration = 0 // Don't change this back, ever.
	isGlass = TRUE
	foodtype = ALCOHOL

/obj/item/reagent_containers/food/drinks/bottle/attack(mob/living/target, mob/living/user)

	if(!target)
		return

	if(user.a_intent != INTENT_HARM || !isGlass)
		return ..()

	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, "<span class='warning'>You don't want to harm [target]!</span>")
		return

	var/obj/item/bodypart/affecting = user.zone_selected //Find what the player is aiming at

	var/headarmor = 0 // Target's head armor
	var/armor_block = min(90, target.run_armor_check(affecting, "melee", null, null,armour_penetration)) // For normal attack damage

	//If they have a hat/helmet and the user is targeting their head.
	if(affecting == BODY_ZONE_HEAD)
		var/obj/item/I = target.get_item_by_slot(SLOT_HEAD)
		if(I)
			headarmor = I.armor.melee

	//Calculate the knockdown duration for the target.
	var/armor_duration = (knockdown_duration - headarmor) + force

	//Apply the damage!
	target.apply_damage(force, BRUTE, affecting, armor_block)

	// You are going to knock someone out for longer if they are not wearing a helmet.
	var/head_attack_message = ""
	if(affecting == BODY_ZONE_HEAD && iscarbon(target))
		head_attack_message = " on the head"
		//Knockdown the target for the duration that we calculated and divide it by 5.
		//if(armor_duration)
		//	target.DefaultCombatKnockdown(min(armor_duration, 200)) // What the fuck were tg coders thinking

	//Display an attack message.
	if(target != user)
		target.visible_message("<span class='danger'>[user] has hit [target][head_attack_message] with a bottle of [src.name]!</span>", \
				"<span class='userdanger'>[user] has hit [target][head_attack_message] with a bottle of [src.name]!</span>")
	else
		user.visible_message("<span class='danger'>[target] hits [target.p_them()]self with a bottle of [src.name][head_attack_message]!</span>", \
				"<span class='userdanger'>[target] hits [target.p_them()]self with a bottle of [src.name][head_attack_message]!</span>")

	//Attack logs
	log_combat(user, target, "attacked", src)

	//The reagents in the bottle splash all over the target, thanks for the idea Nodrak
	SplashReagents(target)

	//Finally, smash the bottle. This kills (del) the bottle.
	smash(target, user)

	return

//Keeping this here for now, I'll ask if I should keep it here.
/obj/item/broken_bottle
	name = "broken bottle"
	desc = "A shattered glass container with sharp edges."
	icon = 'icons/obj/drinks.dmi'
	icon_state = "broken_bottle"
	force = 9
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	item_state = "beer"
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("stabbed", "slashed", "attacked")
	var/icon/broken_outline = icon('icons/obj/drinks.dmi', "broken")
	sharpness = SHARP_EDGED

/obj/item/broken_bottle/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 200, 55)

/obj/item/reagent_containers/food/drinks/bottle/gin
	name = "Griffeater gin"
	desc = "A bottle of high quality gin, produced in the New London Space Station."
	icon_state = "ginbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/gin = 100)

/obj/item/reagent_containers/food/drinks/bottle/gin/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/whiskey
	name = "Uncle Git's special reserve"
	desc = "A premium single-malt whiskey, gently matured inside the tunnels of a nuclear shelter. TUNNEL WHISKEY RULES."
	icon_state = "whiskeybottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 100)

/obj/item/reagent_containers/food/drinks/bottle/whiskey/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/vodka
	name = "Tunguska triple distilled"
	desc = "Aah, vodka. Prime choice of drink AND fuel by Russians worldwide."
	icon_state = "vodkabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 100)

/obj/item/reagent_containers/food/drinks/bottle/vodka/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/vodka/badminka
	name = "Badminka vodka"
	desc = "The label's written in Cyrillic. All you can make out is the name and a word that looks vaguely like 'Vodka'."
	icon_state = "badminka"

/obj/item/reagent_containers/food/drinks/bottle/tequila
	name = "Caccavo guaranteed quality tequila"
	desc = "Made from premium petroleum distillates, pure thalidomide and other fine quality ingredients!"
	icon_state = "tequilabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/tequila = 100)

/obj/item/reagent_containers/food/drinks/bottle/tequila/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/f13nukacola
	name = "Nuka-Cola"
	desc = "The most popular flavored soft drink in the United States before the Great War."
	icon = 'icons/obj/f13vending.dmi'
	icon_state = "nukacola"
	list_reagents = list(/datum/reagent/consumable/nuka_cola = 25, /datum/reagent/radium = 5)
	foodtype = SUGAR
	isGlass = TRUE

/obj/item/reagent_containers/food/drinks/bottle/f13nukacola/radioactive
	desc = "The most popular flavored soft drink in the United States before the Great War.<br>It was preserved in a fairly pristine state.<br>The bottle is slightly glowing."
	list_reagents = list(/datum/reagent/consumable/nuka_cola = 15, /datum/reagent/radium = 5)

/obj/item/reagent_containers/food/drinks/bottle/sunset
	name = "Sunset Sarsparilla"
	desc = "The most popular flavored root beer in the West!"
	icon = 'icons/obj/f13vending.dmi'
	icon_state = "sunset"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 1, /datum/reagent/consumable/sunset = 15, /datum/reagent/medicine/salglu_solution = 5)
	foodtype = SUGAR
	isGlass = TRUE


/obj/item/reagent_containers/food/drinks/bottle/patron
	name = "Wrapp Artiste Patron"
	desc = "Silver laced tequila, served in space night clubs across the galaxy."
	icon_state = "patronbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/patron = 100)

/obj/item/reagent_containers/food/drinks/bottle/patron/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/rum
	name = "Captain Pete's Cuban spiced rum"
	desc = "This isn't just rum, oh no. It's practically GRIFF in a bottle."
	icon_state = "rumbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/rum = 100)

/obj/item/reagent_containers/food/drinks/bottle/rum/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/holywater
	name = "flask of holy water"
	desc = "A flask of the chaplain's holy water."
	icon_state = "holyflask"
	list_reagents = list(/datum/reagent/water/holywater = 100)
	foodtype = NONE

/obj/item/reagent_containers/food/drinks/bottle/holywater/hell
	desc = "A flask of holy water...it's been sitting in the Necropolis a while though."
	list_reagents = list(/datum/reagent/hellwater = 100)

/obj/item/reagent_containers/food/drinks/bottle/holyoil
	name = "flask of zelus oil"
	desc = "A brass flask of Zelus oil, a viscous fluid scenting of brass. Can be thrown to deal damage from afar."
	icon_state = "zelusflask"
	list_reagents = list(/datum/reagent/fuel/holyoil = 30)
	volume = 30
	foodtype = NONE
	force = 18
	throwforce = 18
	knockdown_duration = 0

/obj/item/reagent_containers/food/drinks/bottle/holyoil/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/vermouth
	name = "Goldeneye vermouth"
	desc = "Sweet, sweet dryness~"
	icon_state = "vermouthbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/vermouth = 100)

/obj/item/reagent_containers/food/drinks/bottle/vermouth/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/kahlua
	name = "Robert Robust's coffee liqueur"
	desc = "A widely known, Mexican coffee-flavoured liqueur. In production since 1936, HONK."
	icon_state = "kahluabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/kahlua = 100)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/drinks/bottle/kahlua/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/goldschlager
	name = "College Girl goldschlager"
	desc = "Because they are the only ones who will drink 100 proof cinnamon schnapps."
	icon_state = "goldschlagerbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/goldschlager = 100)

/obj/item/reagent_containers/food/drinks/bottle/goldschlager/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/cognac
	name = "Chateau de Baton premium cognac"
	desc = "A sweet and strongly alchoholic drink, made after numerous distillations and years of maturing. You might as well not scream 'SHITCURITY' this time."
	icon_state = "cognacbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/cognac = 100)

/obj/item/reagent_containers/food/drinks/bottle/cognac/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/wine
	name = "Doublebeard's bearded special wine"
	desc = "A faint aura of unease and asspainery surrounds the bottle."
	icon_state = "winebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/wine = 100)
	foodtype = FRUIT | ALCOHOL

/obj/item/reagent_containers/food/drinks/bottle/wine/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/absinthe
	name = "extra-strong absinthe"
	desc = "An strong alcoholic drink brewed and distributed by"
	icon_state = "absinthebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/absinthe = 100)

/obj/item/reagent_containers/food/drinks/bottle/absinthe/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/absinthe/Initialize()
	. = ..()
	redact()

/obj/item/reagent_containers/food/drinks/bottle/absinthe/proc/redact()
	// There was a large fight in the coderbus about a player reference
	// in absinthe. Ergo, this is why the name generation is now so
	// complicated. Judge us kindly.
	var/shortname = pickweight(
		list("T&T" = 1, "A&A" = 1, "Generic" = 1))
	var/fullname
	var/removals = GLOB.redacted_strings.Copy()
	switch(shortname)
		if("T&T")
			fullname = "Teal and Tealer"
		if("A&A")
			fullname = "Ash and Asher"
		if("Generic")
			fullname = "Nanotrasen Cheap Imitations"
	var/chance = 50

	if(prob(chance))
		shortname = pick_n_take(removals)

	var/list/final_fullname = list()
	for(var/word in splittext(fullname, " "))
		if(prob(chance))
			word = pick_n_take(removals)
		final_fullname += word

	fullname = jointext(final_fullname, " ")

	// Actually finally setting the new name and desc
	name = "[shortname] [name]"
	desc = "[desc] [fullname] Inc."


/obj/item/reagent_containers/food/drinks/bottle/absinthe/premium
	name = "Gwyn's premium absinthe"
	desc = "A potent alcoholic beverage, almost makes you forget the ash in your lungs."
	icon_state = "absinthepremium"

/obj/item/reagent_containers/food/drinks/bottle/absinthe/premium/redact()
	return

/obj/item/reagent_containers/food/drinks/bottle/lizardwine
	name = "bottle of lizard wine"
	desc = "An alcoholic beverage originally made in China by infusing lizard tails in ethanol, now? Much the same, but with geckos. Inexplicably popular among most higher ups."
	icon_state = "lizardwine"
	list_reagents = list(/datum/reagent/consumable/ethanol/lizardwine = 100)
	foodtype = FRUIT | ALCOHOL

/obj/item/reagent_containers/food/drinks/bottle/hcider
	name = "Jian Hard Cider"
	desc = "Apple juice for adults."
	icon_state = "hcider"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/ethanol/hcider = 50)

/obj/item/reagent_containers/food/drinks/bottle/hcider/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/grappa
	name = "Phillipes well-aged Grappa"
	desc = "Bottle of Grappa."
	icon_state = "grappabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/grappa = 100)

/obj/item/reagent_containers/food/drinks/bottle/grappa/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/sake
	name = "Ryo's traditional sake"
	desc = "Sweet as can be, and burns like fire going down."
	icon_state = "sakebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/sake = 100)

/obj/item/reagent_containers/food/drinks/bottle/sake/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/sake/Initialize()
	. = ..()
	if(prob(10))
		name = "Fluffy Tail Sake"
		desc += " On the bottle is a picture of a kitsune with nine touchable tails."
		icon_state = "sakebottle_k"
	else if(prob(10))
		name = "Inubashiri's Home Brew"
		desc += " Awoo."
		icon_state = "sakebottle_i"

/obj/item/reagent_containers/food/drinks/bottle/fernet
	name = "Fernet Bronca"
	desc = "A bottle of pure Fernet Bronca, produced in Cordoba Space Station"
	icon_state = "fernetbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/fernet = 100)

/obj/item/reagent_containers/food/drinks/bottle/fernet/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/applejack
	name = "Buckin' Bronco's Applejack"
	desc = "Kicks like a horse, tastes like an apple!"
	custom_price = PRICE_CHEAP
	icon_state = "applejack_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/applejack = 100)
	foodtype = FRUIT

/obj/item/reagent_containers/food/drinks/bottle/applejack/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/champagne
	name = "Lead Champagne"
	desc = "Finely sourced from only the most pretentious Appalachian vineyards."
	icon_state = "champagne_bottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/champagne = 100)

/obj/item/reagent_containers/food/drinks/bottle/champagne/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/blazaam
	name = "Ginbad's Blazaam"
	desc = "You feel like you should give the bottle a good rub before opening."
	icon_state = "blazaambottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/blazaam = 100)

/obj/item/reagent_containers/food/drinks/bottle/blazaam/empty
	list_reagents = null

/obj/item/reagent_containers/food/drinks/bottle/trappist
	name = "Mont de Requin Trappistes Bleu"
	desc = "Brewed in Belgium. Fancy!"
	custom_premium_price = PRICE_ABOVE_NORMAL
	icon_state = "trappistbottle"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/ethanol/trappist = 50)

/obj/item/reagent_containers/food/drinks/bottle/trappist/empty
	list_reagents = null
	
/obj/item/reagent_containers/food/drinks/bottle/rotgut
	name = "Rotgut"
	desc = "a bottle of noxious homebrewed alcohol, it has the name Rotgut etched on its side"
	icon = 'icons/fallout/objects/food&drinks/drinks.dmi'
	icon_state = "rotgut"
	list_reagents = list(/datum/reagent/consumable/ethanol/rotgut = 100)

/obj/item/reagent_containers/food/drinks/bottle/tequila/empty
	list_reagents = null	

//////////////////////////JUICES AND STUFF ///////////////////////

/obj/item/reagent_containers/food/drinks/bottle/orangejuice
	name = "orange juice"
	desc = "Full of vitamins and deliciousness!"
	custom_price = PRICE_CHEAP
	icon_state = "orangejuice"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/orangejuice = 100)
	foodtype = FRUIT| BREAKFAST

/obj/item/reagent_containers/food/drinks/bottle/bio_carton
	name = "small carton box"
	desc = "A small biodegradable carton box made from plant biomatter."
	icon_state = "eco_box"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	volume = 50
	isGlass = FALSE

/obj/item/reagent_containers/food/drinks/bottle/cream
	name = "milk cream"
	desc = "It's cream. Made from milk. What else did you think you'd find in there?"
	custom_price = PRICE_CHEAP
	icon_state = "cream"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/cream = 100)
	foodtype = DAIRY


/obj/item/reagent_containers/food/drinks/bottle/bawls
	name = "Balls Guarana"
	desc = "To give you that Bounce!"
	icon = 'icons/obj/f13vending.dmi'
	icon_state = "bawls"
	list_reagents = list(/datum/reagent/consumable/coffee = 10, /datum/reagent/consumable/bawls = 15)
	foodtype = SUGAR
	isGlass = TRUE

/obj/item/reagent_containers/food/drinks/bottle/lemonjuice
	name = "Lemon Juice"
	desc = "Whew! Thats some sour pre-war lemon juice! You know what they say about..."
	icon_state = "lemonjuice"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = TRUE
	list_reagents = list(/datum/reagent/consumable/limejuice = 100)
	foodtype = FRUIT

/obj/item/reagent_containers/food/drinks/bottle/instatea
	name = "Silician Instatea"
	desc = "Pre-war powerdered canned tea powder."
	icon_state = "instatea"
	list_reagents = list(/datum/reagent/toxin/teapowder = 98, /datum/reagent/radium = 2)

/obj/item/reagent_containers/food/drinks/soda_cans/cream
	name = "canned cream"
	desc = "It's a can of cream. Made from milk. What else did you think you'd find in there?"
	icon_state = "cream"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/cream = 100)
	foodtype = DAIRY


/obj/item/reagent_containers/food/drinks/bottle/instacocoa
	name = "Silician Instacocoa"
	desc = "Pre-war powerdered canned dried chocolate mix."
	icon_state = "instachoc"
	list_reagents = list(/datum/reagent/consumable/coco = 98, /datum/reagent/radium = 2)

/obj/item/reagent_containers/food/drinks/bottle/instacoffee
	name = "Silician Instacoffee"
	desc = "Pre-war powerdered canned coffee."
	icon_state = "instacoffee"
	list_reagents = list(/datum/reagent/toxin/coffeepowder = 98, /datum/reagent/radium = 2)

/obj/item/reagent_containers/food/drinks/bottle/vim
	name = "Vim"
	desc = "You've got Vim!"
	icon = 'icons/obj/f13vending.dmi'
	icon_state = "vim"
	list_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/vim = 15)
	foodtype = SUGAR
	isGlass = TRUE

/obj/item/reagent_containers/food/drinks/bottle/tomatojuice
	name = "tomato juice"
	desc = "Well, at least it LOOKS like tomato juice. You can't tell with all that redness."
	custom_price = PRICE_CHEAP
	icon_state = "tomatojuice"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/tomatojuice = 100)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/drinks/bottle/limejuice
	name = "lime juice"
	desc = "Sweet-sour goodness."
	custom_price = PRICE_CHEAP
	icon_state = "limejuice"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/limejuice = 100)
	foodtype = FRUIT

/obj/item/reagent_containers/food/drinks/bottle/pineapplejuice
	name = "pineapple juice"
	desc = "Extremely tart, yellow juice."
	icon_state = "pineapplejuice"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/pineapplejuice = 100)
	foodtype = FRUIT | PINEAPPLE

/obj/item/reagent_containers/food/drinks/bottle/strawberryjuice
	name = "strawberry juice"
	desc = "Slushy, reddish juice."
	icon_state = "strawberryjuice"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/strawberryjuice = 100)
	foodtype = FRUIT

/obj/item/reagent_containers/food/drinks/bottle/menthol
	name = "menthol"
	desc = "Tastes naturally minty, and imparts a very mild numbing sensation."
	custom_price = PRICE_CHEAP
	icon_state = "mentholbox"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/menthol = 100)

/obj/item/reagent_containers/food/drinks/bottle/grenadine
	name = "Jester Grenadine"
	desc = "Contains 0% real cherries!"
	custom_price = PRICE_CHEAP
	icon_state = "grenadine"
	isGlass = TRUE
	list_reagents = list(/datum/reagent/consumable/grenadine = 100)
	foodtype = FRUIT

/obj/item/reagent_containers/food/drinks/bottle/grenadine/empty
	list_reagents = null

/obj/item/export/bottle
	name = "Report this please"
	desc = "A sealed bottle of alcohol, ready to be exported"
	icon = 'icons/obj/drinks.dmi'
	force = 0
	throwforce = 0
	throw_speed = 0
	throw_range = 0
	w_class = WEIGHT_CLASS_TINY
	item_state = "beer"
	attack_verb = list("boop", "thunked", "shown")

/obj/item/export/bottle/gin
	icon_state = "ginbottle"
	name = "Sealed Gin"

/obj/item/export/bottle/wine
	icon_state = "winebottle"
	name = "Sealed Wine"

/obj/item/export/bottle/whiskey
	icon_state = "whiskeybottle"
	name = "Sealed Whiskey"

/obj/item/export/bottle/vodka
	icon_state = "vodkabottle"
	name = "Sealed Vodka"

/obj/item/export/bottle/tequila
	icon_state = "tequilabottle"
	name = "Sealed Tequila"

/obj/item/export/bottle/patron
	icon_state = "patronbottle"
	name = "Sealed Patron"

/obj/item/export/bottle/rum
	icon_state = "rumbottle"
	name = "Sealed Rum"

/obj/item/export/bottle/vermouth
	icon_state = "vermouthbottle"
	name = "Sealed Vermouth"

/obj/item/export/bottle/kahlua
	icon_state = "kahluabottle"
	name = "Sealed Kahlua"

/obj/item/export/bottle/goldschlager
	icon_state = "goldschlagerbottle"
	name = "Sealed Goldschlager"

/obj/item/export/bottle/hcider
	icon_state = "hcider"
	name = "Sealed Cider"

/obj/item/export/bottle/cognac
	icon_state = "cognacbottle"
	name = "Sealed Cognac"

/obj/item/export/bottle/absinthe
	icon_state = "absinthebottle"
	name = "Sealed Unmarked Absinthe"

/obj/item/export/bottle/grappa
	icon_state = "grappabottle"
	name = "Sealed Grappa"

/obj/item/export/bottle/sake
	icon_state = "sakebottle"
	name = "Sealed Sake"

/obj/item/export/bottle/fernet
	icon_state = "fernetbottle"
	name = "Sealed Fernet"

/obj/item/export/bottle/applejack
	icon_state = "applejack_bottle"
	name = "Sealed Applejack"

/obj/item/export/bottle/champagne
	icon_state = "champagne_bottle"
	name = "Sealed Champagne"

/obj/item/export/bottle/blazaam
	icon_state = "blazaambottle"
	name = "Sealed Blazaam"

/obj/item/export/bottle/trappist
	icon_state = "trappistbottle"
	name = "Sealed Trappist"

/obj/item/export/bottle/grenadine
	icon_state = "grenadine"
	name = "Sealed Grenadine"

/obj/item/export/bottle/minikeg
	name = "Mini-Beer Keg"
	icon_state = "keggy"
	desc = "A small wooden barrle with metal rings, untapped beer inside."

/obj/item/export/bottle/blooddrop
	icon_state = "champagne_selling_bottle"
	name = "Blood Drop"
	desc = "Large red bottle filled with a mix of wine and other named brands."

/obj/item/export/bottle/slim_gold
	name = "Slim Gold "
	icon_state = "selling_bottle_alt"
	desc = "A gold looking yellow bottle that has a mix of different named brands."

/obj/item/export/bottle/white_bloodmoon
	name = "White Bloodmoon"
	icon_state = "selling_bottle_basic"
	desc = "Rather simple bottle for this kind of drink."

/obj/item/export/bottle/greenroad
	name = "Green Road"
	icon_state = "selling_bottle"
	desc = "Ironic name as the fruit used is from ashy plants."

/obj/item/reagent_containers/food/drinks/bottle/nukashine
	name = "Nukashine"
	desc = "You've really hit rock bottom now... yet theres nothing like homebrew nukashine in times like these!"
	icon_state = "nukashine"
	list_reagents = list(/datum/reagent/consumable/ethanol/nukashine = 100)


// Empty bottles
/obj/item/reagent_containers/food/drinks/bottle/brown/white
	name = "white bottle"
	desc = "A homemade and hand-crafted white glass bottle."
	icon_state = "whitebottle"

/obj/item/reagent_containers/food/drinks/bottle/brown/green
	name = "green bottle"
	desc = "A homemade and hand-crafted green glass bottle."
	icon_state = "greenbottle"

/obj/item/reagent_containers/food/drinks/bottle/brown/beer
	name = "beer bottle"
	desc = "A homemade and hand-crafted authentic beer bottle."
	icon_state = "beerbottle"

/obj/item/reagent_containers/food/drinks/bottle/brown/darkbrown
	name = "dark brown bottle"
	desc = "A homemade and hand-crafted dark brown glass bottle."
	icon_state = "darkbrownbottle"

/obj/item/reagent_containers/food/drinks/bottle/brown/lightbrown
	name = "light brown bottle"
	desc = "A homemade and hand-crafted light brown glass bottle."
	icon_state = "lightbrownbottle"

/obj/item/reagent_containers/food/drinks/bottle/brown/wine
	name = "wine bottle"
	desc = "A homemade and hand-crafted wine glass bottle."
	icon_state = "winebottle"

/obj/item/reagent_containers/food/drinks/bottle/brown/greenwine
	name = "wine bottle"
	desc = "A homemade and hand-crafted green wine glass bottle."
	icon_state = "greenwinebottle"
