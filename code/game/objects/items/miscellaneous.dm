/obj/item/caution
	desc = "Caution! Wet Floor!"
	name = "wet floor sign"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "caution"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	force = 1
	throwforce = 3
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("warned", "cautioned", "smashed")

/obj/item/choice_beacon
	name = "choice beacon"
	desc = "Hey, why are you viewing this?!! Please let Centcom know about this odd occurance."
	icon = 'icons/obj/device.dmi'
	icon_state = "gangtool-blue"
	inhand_icon_state = "radio"
	var/list/stored_options
	var/force_refresh = FALSE //if set to true, the beacon will recalculate its display options whenever opened

/obj/item/choice_beacon/attack_self(mob/user)
	if(canUseBeacon(user))
		generate_options(user)

/obj/item/choice_beacon/proc/generate_display_names() // return the list that will be used in the choice selection. entries should be in (type.name = type) fashion. see choice_beacon/hero for how this is done.
	return list()

/obj/item/choice_beacon/proc/canUseBeacon(mob/living/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return TRUE
	else
		playsound(src, 'sound/machines/buzz-sigh.ogg', 40, 1)
		return FALSE

/obj/item/choice_beacon/proc/generate_options(mob/living/M)
	if(!stored_options || force_refresh)
		stored_options = generate_display_names()
	if(!stored_options.len)
		return
	var/choice = input(M,"Which item would you like to order?","Select an Item") as null|anything in stored_options
	if(!choice || !M.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	spawn_option(stored_options[choice],M)
	qdel(src)

/obj/item/choice_beacon/proc/create_choice_atom(atom/choice, mob/owner)
	return new choice()

/obj/item/choice_beacon/proc/spawn_option(atom/choice,mob/living/M)
	var/obj/new_item = create_choice_atom(choice, M)
	var/obj/structure/closet/supplypod/bluespacepod/pod = new()
	pod.explosionSize = list(0,0,0,0)
	new_item.forceMove(pod)
	var/msg = span_danger("After making your selection, you notice a strange target on the ground. It might be best to step back!")
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(istype(H.ears, /obj/item/radio/headset))
			msg = "You hear something crackle in your ears for a moment before a voice speaks.  \"Please stand by for a message from Central Command.  Message as follows: <span class='bold'>Item request received. Your package is inbound, please stand back from the landing site.</span> Message ends.\""
	to_chat(M, msg)

	new /obj/effect/abstract/DPtarget(get_turf(src), pod)

/obj/item/choice_beacon/ingredients
	name = "ingredient box delivery beacon"
	desc = "Summon a box of ingredients from a wide selection!"
	icon_state = "gangtool-red"

/obj/item/choice_beacon/ingredients/generate_display_names()
	var/static/list/ingredientboxes
	if(!ingredientboxes)
		ingredientboxes = list()
		var/list/templist = typesof(/obj/item/storage/box/ingredients)
		for(var/V in templist)
			var/obj/item/storage/box/ingredients/A = V
			ingredientboxes[initial(A.theme_name)] = A
	return ingredientboxes

/obj/item/choice_beacon/hero
	name = "heroic beacon"
	desc = "To summon heroes from the past to protect the future."

/obj/item/choice_beacon/hero/generate_display_names()
	var/static/list/hero_item_list
	if(!hero_item_list)
		hero_item_list = list()
		var/list/templist = typesof(/obj/item/storage/box/hero) //we have to convert type = name to name = type, how lovely!
		for(var/V in templist)
			var/atom/A = V
			hero_item_list[initial(A.name)] = A
	return hero_item_list

/obj/item/storage/box/hero
	name = "Courageous Tomb Raider - 1940's."

/obj/item/storage/box/hero/PopulateContents()
	new /obj/item/clothing/head/fedora/curator(src)
	new /obj/item/clothing/suit/curator(src)
	new /obj/item/clothing/under/rank/civilian/curator/treasure_hunter(src)
	new /obj/item/clothing/shoes/workboots/mining(src)

/obj/item/storage/box/hero/astronaut
	name = "First Man on the Moon - 1960's."

/obj/item/storage/box/hero/astronaut/PopulateContents()
	new /obj/item/clothing/suit/space/nasavoid(src)
	new /obj/item/clothing/head/helmet/space/nasavoid(src)
	new /obj/item/tank/internals/emergency_oxygen/double(src)
	new /obj/item/gps(src)

/obj/item/storage/box/hero/scottish
	name = "Braveheart, the Scottish rebel - 1300's."

/obj/item/storage/box/hero/scottish/PopulateContents()
	new /obj/item/clothing/under/costume/kilt(src)
	new /obj/item/claymore/weak/ceremonial(src)
	new /obj/item/toy/crayon/spraycan(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/choice_beacon/hosgun
	name = "personal weapon beacon"
	desc = "Use this to summon your personal Head of Security issued firearm!"

/obj/item/choice_beacon/hosgun/generate_display_names()
	var/static/list/hos_gun_list
	if(!hos_gun_list)
		hos_gun_list = list()
		var/list/templist = subtypesof(/obj/item/storage/secure/briefcase/hos/) //we have to convert type = name to name = type, how lovely!
		for(var/V in templist)
			var/atom/A = V
			hos_gun_list[initial(A.name)] = A
	return hos_gun_list

/obj/item/choice_beacon/augments
	name = "augment beacon"
	desc = "Summons augmentations."

/obj/item/choice_beacon/augments/generate_display_names()
	var/static/list/augment_list
	if(!augment_list)
		augment_list = list()
		var/list/templist = list(
		/obj/item/organ/cyberimp/brain/anti_drop,
		/obj/item/organ/cyberimp/arm/toolset,
		/obj/item/organ/cyberimp/chest/nutriment/plus,
		/obj/item/organ/cyberimp/arm/esword, //adding for a possible dungeon loot choice
		/obj/item/organ/cyberimp/arm/surgery,
		/obj/item/organ/lungs/cybernetic,
		/obj/item/organ/liver/cybernetic) //cyberimplants range from a nice bonus to fucking broken bullshit so no subtypesof
		for(var/V in templist)
			var/atom/A = V
			augment_list[initial(A.name)] = A
	return augment_list

/obj/item/choice_beacon/augments/spawn_option(atom/choice,mob/living/M)
	new choice(get_turf(M))
	to_chat(M, "<span class='hear'>You hear something crackle from the beacon for a moment before a voice speaks. \"Please stand by for a message from S.E.L.F. Message as follows: <b>Item request received. Your package has been transported, use the autosurgeon supplied to apply the upgrade.</b> Message ends.\"</span>")

/obj/item/choice_beacon/pet //donator beacon that summons a small friendly animal
	name = "pet beacon"
	desc = "Straight from the outerspace pet shop to your feet."
	var/list/pets = list(
"Brahmin" = /mob/living/simple_animal/cow/brahmin,
"Chicken" = /mob/living/simple_animal/chicken,
"Corgi" = /mob/living/simple_animal/pet/dog/corgi,
"Pug" = /mob/living/simple_animal/pet/dog/pug,
"Fox" = /mob/living/simple_animal/pet/fox,
"Red Panda" = /mob/living/simple_animal/pet/redpanda,
"Mouse" = /mob/living/simple_animal/mouse,
"Cat" = /mob/living/simple_animal/pet/cat
)
	var/pet_name

/obj/item/choice_beacon/pet/generate_display_names()
	return pets

/obj/item/choice_beacon/pet/create_choice_atom(atom/choice, mob/owner)
	var/mob/living/simple_animal/new_choice = new choice()
	new_choice.butcher_results = null //please don't eat your pet, chef
	var/obj/item/pet_carrier/donator/carrier = new() //a donator pet carrier is just a carrier that can't be shoved in an autolathe for metal
	carrier.add_occupant(new_choice)
	/// this is all classic SS13 code, where pearl clutching devs sand off all the corners on a 'free' thing, so it can't be used against the antag
	// new_choice.mob_size = MOB_SIZE_TINY //yeah we're not letting you use this roundstart pet to hurt people / knock them down
	// new_choice.pass_flags = PASSTABLE | PASSMOB //your pet is not a bullet/person shield
	// new_choice.density = FALSE
	// new_choice.blood_volume = 0 //your pet cannot be used to drain blood from for a bloodsucker
	new_choice.desc = "A pet [initial(choice.name)], owned by [owner]!"
	// new_choice.can_have_ai = FALSE //no it cant be sentient damnit
	if(pet_name)
		new_choice.name = pet_name
		new_choice.unique_name = TRUE
	new_choice.quit_stealing_my_bike = TRUE // damn geckohearders stealing peoples's mounts
	return carrier

/obj/item/choice_beacon/pet/spawn_option(atom/choice,mob/living/M)
	pet_name = input(M, "What would you like to name the pet? (leave blank for default name)", "Pet Name")
	..()

//choice boxes (they just open in your hand instead of making a pod)
/obj/item/choice_beacon/box
	name = "choice box (default)"
	desc = "Think really hard about what you want, and then rip it open!"
	icon = 'icons/obj/storage.dmi'
	icon_state = "deliverypackage3"
	inhand_icon_state = "deliverypackage3"

/obj/item/choice_beacon/box/spawn_option(atom/choice,mob/living/M)
	var/choice_text = choice
	if(ispath(choice_text))
		choice_text = initial(choice.name)
	to_chat(M, span_hear("The box opens, revealing the [choice_text]!"))
	playsound(src.loc, 'sound/items/poster_ripped.ogg', 50, 1)
	M.temporarilyRemoveItemFromInventory(src, TRUE)
	M.put_in_hands(new choice)
	qdel(src)

/obj/item/choice_beacon/box/plushie/spawn_option(choice,mob/living/M)
	if(ispath(choice, /obj/item/toy/plush))
		..() //regular plush, spawn it naturally
	else
		//snowflake plush
		var/obj/item/toy/plush/snowflake_plushie = new(get_turf(M))
		snowflake_plushie.set_snowflake_from_config(choice)
		M.temporarilyRemoveItemFromInventory(src, TRUE)
		M.put_in_hands(new choice)
		qdel(src)


/obj/item/choice_beacon/pet/mountable //beacon for spawning mounts!
	name = "mount beacon"
	desc = "Straight from the outerspace mount shop to your feet."
	pets = list(
		"Brahmin" = /mob/living/simple_animal/cow/brahmin,
		"Molerat" = /mob/living/simple_animal/cow/brahmin/molerat,
		"Horse" = /mob/living/simple_animal/cow/brahmin/horse,
		"Honse" = /mob/living/simple_animal/cow/brahmin/horse/honse,
		"Motorbike?" = /mob/living/simple_animal/cow/brahmin/motorbike,
		"Fennec" = /mob/living/simple_animal/cow/brahmin/horse/fennec,
		"Nightstalker" = /mob/living/simple_animal/cow/brahmin/nightstalker,
		"Hunter Spider" = /mob/living/simple_animal/cow/brahmin/nightstalker/hunterspider,
		"Yellow Snipe" = /mob/living/simple_animal/cow/brahmin/horse/choco,
		"Black Snipe" = /mob/living/simple_animal/cow/brahmin/horse/choco/black,
		"Blue Snipe" = /mob/living/simple_animal/cow/brahmin/horse/choco/blue,
		"White Snipe" = /mob/living/simple_animal/cow/brahmin/horse/choco/white,
		"Purple Snipe" = /mob/living/simple_animal/cow/brahmin/horse/choco/purple,
		"Red Snipe" = /mob/living/simple_animal/cow/brahmin/horse/choco/red,
		"Green Snipe" = /mob/living/simple_animal/cow/brahmin/horse/choco/green,
		"thrumbo" = /mob/living/simple_animal/cow/brahmin/thrumbo,
		"tamed triceratops" = /mob/living/simple_animal/cow/brahmin/molerat/trike,
		"tamed yaoguai" = /mob/living/simple_animal/cow/brahmin/nightstalker/yaoguai,
		"tractor" = /mob/living/simple_animal/cow/brahmin/motorbike/tractor
	)

/obj/item/choice_beacon/box/carpet //donator carpet beacon
	name = "choice box (carpet)"
	desc = "Contains 50 of a selected carpet inside!"
	var/static/list/carpet_list = list(
		"Carpet Carpet" = /obj/item/stack/tile/carpet/fifty,
		"Black Carpet" = /obj/item/stack/tile/carpet/black/fifty,
		"Black & Red Carpet" = /obj/item/stack/tile/carpet/blackred/fifty,
		"Monochrome Carpet" = /obj/item/stack/tile/carpet/monochrome/fifty,
		"Blue Carpet" = /obj/item/stack/tile/carpet/blue/fifty,
		"Cyan Carpet" = /obj/item/stack/tile/carpet/cyan/fifty,
		"Green Carpet" = /obj/item/stack/tile/carpet/green/fifty,
		"Orange Carpet" = /obj/item/stack/tile/carpet/orange/fifty,
		"Purple Carpet" = /obj/item/stack/tile/carpet/purple/fifty,
		"Red Carpet" = /obj/item/stack/tile/carpet/red/fifty,
		"Royal Black Carpet" = /obj/item/stack/tile/carpet/royalblack/fifty,
		"Royal Blue Carpet" = /obj/item/stack/tile/carpet/royalblue/fifty
		)

/obj/item/choice_beacon/box/carpet/generate_display_names()
	return carpet_list

/obj/item/choice_beacon/box/weapons_trash
	name = "well packed trash weapon"
	desc = "Contains your choice of weapon inside!"
	var/static/list/weapon_list = list(
		"rockwell SMG" = /obj/item/gun/ballistic/automatic/smg/mini_uzi/rockwell,
		"bushmaster arm gun" = /obj/item/gun/ballistic/automatic/varmint/bushmaster_arm_gun,
		"hand shotgun" = /obj/item/gun/ballistic/revolver/shotpistol,
		"zipgun" = /obj/item/gun/ballistic/automatic/hobo/zipgun,
		"pipe gun" = /obj/item/gun/ballistic/revolver/hobo/piperifle,
		"pepperbox" = /obj/item/gun/ballistic/revolver/hobo/pepperbox,
		"shotgun bat" = /obj/item/gun/ballistic/revolver/hobo/single_shotgun,
		"knife gun" = /obj/item/gun/ballistic/revolver/hobo/knifegun,
		"knuckle gun" = /obj/item/gun/ballistic/revolver/hobo/knucklegun,
		"autopipe rifle" = /obj/item/gun/ballistic/automatic/autopipe,
		"rebored winchester" = /obj/item/gun/ballistic/revolver/winchesterrebored,
		"dirty cosmic knife" = /obj/item/melee/onehanded/knife/cosmicdirty,
		"tire iron" = /obj/item/melee/onehanded/club/tireiron,
		"bumper sword" = /obj/item/twohanded/fireaxe/bmprsword,
		"pipe" = /obj/item/melee/onehanded/club,
		"scrap spear" = /obj/item/twohanded/spear/scrapspear,
		"shishkebab" = /obj/item/shishkebabpack,
		)

/obj/item/choice_beacon/box/weapons_trash/generate_display_names()
	return weapon_list

/obj/item/choice_beacon/box/weapons_common
	name = "well packed common weapon"
	desc = "Contains your choice of weapon inside!"
	var/static/list/weapon_list = list(
		"worn 10mm SMG" = /obj/item/gun/ballistic/automatic/smg/smg10mm/worn,
		"9mm uzi" = /obj/item/gun/ballistic/automatic/smg/mini_uzi,
		"owen gun" = /obj/item/gun/ballistic/automatic/smg/mini_uzi/owengun,
		".22 uzi" = /obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22,
		"mac-10" = /obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10,
		"M1 carbine" = /obj/item/gun/ballistic/automatic/m1carbine,
		"deslisle carbine" = /obj/item/gun/ballistic/automatic/delisle,
		"sport carbine" = /obj/item/gun/ballistic/automatic/sportcarbine,
		"varmint rifle" = /obj/item/gun/ballistic/automatic/varmint,
		"police rifle" = /obj/item/gun/ballistic/automatic/assault_carbine/policerifle,
		"silenced pistol" = /obj/item/gun/ballistic/automatic/pistol/pistol22,
		"tec-22" = /obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/tec22,
		"9mm pistol" = /obj/item/gun/ballistic/automatic/pistol/ninemil,
		"9mm Borchardt" = /obj/item/gun/ballistic/automatic/pistol/ninemil/c93,
		"9mm Luger" = /obj/item/gun/ballistic/automatic/pistol/ninemil/c93/luger,
		"9mm pocket pistol" = /obj/item/gun/ballistic/automatic/pistol/ninemil/ruby,
		"9mm autopistol" = /obj/item/gun/ballistic/automatic/pistol/ninemil/auto,
		"9mm beretta" = /obj/item/gun/ballistic/automatic/pistol/beretta,
		"9mm carbine" = /obj/item/gun/ballistic/automatic/pistol/beretta/carbine,
		"10mm pistol" = /obj/item/gun/ballistic/automatic/pistol/n99,
		"type-17" = /obj/item/gun/ballistic/automatic/pistol/type17,
		"sig P220" = /obj/item/gun/ballistic/automatic/pistol/sig,
		"M1911" = /obj/item/gun/ballistic/automatic/pistol/m1911,
		"hunting rifle" = /obj/item/gun/ballistic/rifle/hunting,
		"gras rifle" = /obj/item/gun/ballistic/rifle/antique/gras,
		"mosin rifle" = /obj/item/gun/ballistic/rifle/mosin,
		"enfield rifle" = /obj/item/gun/ballistic/rifle/enfield,
		"hunting shotgun" = /obj/item/gun/ballistic/shotgun/hunting,
		"machete" = /obj/item/melee/onehanded/machete,
		"forged machete" = /obj/item/melee/onehanded/machete/forgedmachete,
		"scrap sabre" = /obj/item/melee/onehanded/machete/scrapsabre,
		"throwing spear" = /obj/item/throwing_star/spear,
		"hunting knife" = /obj/item/melee/onehanded/knife/hunting,
		"survival knife" = /obj/item/melee/onehanded/knife/survival,
		"bayonet" = /obj/item/melee/onehanded/knife/bayonet,
		"bowie knife" = /obj/item/melee/onehanded/knife/bowie,
		"switchblade" = /obj/item/melee/onehanded/knife/switchblade,
		"throwing knife" = /obj/item/melee/onehanded/knife/throwing,
		"brass knuckles" = /obj/item/melee/unarmed/brass,
		"spiked knuckles" = /obj/item/melee/unarmed/brass/spiked,
		"sappers" = /obj/item/melee/unarmed/sappers,
		"fire axe" = /obj/item/twohanded/fireaxe,
		"spear" = /obj/item/twohanded/spear,
		"baseball bat" = /obj/item/twohanded/baseball,
		"spiked baseball bat" = /obj/item/twohanded/baseball/spiked,
		"gold club" = /obj/item/twohanded/baseball/golfclub,
		"sledgehammer" = /obj/item/twohanded/sledgehammer,
		"chainsaw" = /obj/item/twohanded/chainsaw,
		"plasma slicer celestia" = /obj/item/melee/transforming/plasmacutter/regular/celestia,
		"plasma slicer eve" = /obj/item/melee/transforming/plasmacutter/regular/eve,
		"plasma slicer" = /obj/item/melee/transforming/plasmacutter/regular,
		"yaoguai gauntlet" = /obj/item/melee/unarmed/yaoguaigauntlet,
		"frying pan" = /obj/item/melee/onehanded/club/fryingpan,
		"trench shovel" = /obj/item/shovel/trench,
		"wattz laser pistol" = /obj/item/gun/energy/laser/wattz,
		"wattz-s laser pistol" = /obj/item/gun/energy/laser/wattzs,
		"aep7 laser pistol" = /obj/item/gun/energy/laser/pistol,
		"compliance regulator" = /obj/item/gun/energy/laser/complianceregulator,
		"compact RCW" = /obj/item/gun/energy/laser/auto,
	)

/obj/item/choice_beacon/box/weapons_common/generate_display_names()
	return weapon_list

/obj/item/choice_beacon/box/weapons_uncommon
	name = "well packed uncommon weapon"
	desc = "Contains your choice of weapon inside!"
	var/static/list/weapon_list = list(
		"American 180" = /obj/item/gun/ballistic/automatic/smg/american180,
		"Mini DP-27" = /obj/item/gun/ballistic/automatic/smg/american180/dp27,
		"10mm SMG" = /obj/item/gun/ballistic/automatic/smg/smg10mm,
		"M2 carbine" = /obj/item/gun/ballistic/automatic/m1carbine/m2,
		"MP5-SD" = /obj/item/gun/ballistic/automatic/smg/mp5sd,
		"multicaliber carbine" = /obj/item/gun/ballistic/automatic/smg/sidewinder,
		"combat carbine" = /obj/item/gun/ballistic/automatic/combat,
		"service rifle" = /obj/item/gun/ballistic/automatic/service,
		"marksman carbine" = /obj/item/gun/ballistic/automatic/marksman,
		"police rifle" = /obj/item/gun/ballistic/automatic/marksman/policerifle,
		"assault carbine" = /obj/item/gun/ballistic/automatic/assault_carbine,
		"armalite rifle" = /obj/item/gun/ballistic/automatic/armalite,
		"L1A1 rifle" = /obj/item/gun/ballistic/automatic/l1a1,
		"Beretta M93R" = /obj/item/gun/ballistic/automatic/pistol/beretta/automatic,
		"Skorpion 9mm" = /obj/item/gun/ballistic/automatic/pistol/ninemil/skorpion,
		"Mauser M712" = /obj/item/gun/ballistic/automatic/c96auto,
		"schmeisser classic" = /obj/item/gun/ballistic/automatic/pistol/schmeisser,
		"mk.23 pistol" = /obj/item/gun/ballistic/automatic/pistol/mk23,
		"trench shotgun" = /obj/item/gun/ballistic/shotgun/trench,
		"browning auto-5" = /obj/item/gun/ballistic/shotgun/automatic/combat/auto5,
		"hobo destroyer" = /obj/item/gun/ballistic/automatic/hobo/destroyer,
		"obrez" = /obj/item/gun/ballistic/rifle/hunting/obrez,
		"spatha" = /obj/item/melee/onehanded/machete/spatha,
		"tigerclaw gauntlet" = /obj/item/melee/unarmed/tigerclaw,
		"lacerator" = /obj/item/melee/unarmed/lacerator,
		"maceglove" = /obj/item/melee/unarmed/maceglove,
		"punch dagger" = /obj/item/melee/unarmed/punchdagger,
		"loidville slugger" = /obj/item/twohanded/baseball/louisville,
		"wattz 2000 laser rifle" = /obj/item/gun/energy/laser/wattz2k,
		"AER9 laser rifle" = /obj/item/gun/energy/laser/aer9,
		"plasma pistol" = /obj/item/gun/energy/laser/plasma/pistol,
	)

/obj/item/choice_beacon/box/weapons_uncommon/generate_display_names()
	return weapon_list

/obj/item/choice_beacon/box/plushie
	name = "choice box (plushie)"
	desc = "Using the power of quantum entanglement, this box contains every plush, until the moment it is opened!"
	icon = 'icons/obj/plushes.dmi'
	icon_state = "box"
	inhand_icon_state = "box"

/obj/item/choice_beacon/box/plushie/generate_display_names()
	var/list/plushie_list = list()
	//plushie set 1: just subtypes of /obj/item/toy/plush
	var/list/plushies_set_one = subtypesof(/obj/item/toy/plush) - list(/obj/item/toy/plush/narplush, /obj/item/toy/plush/awakenedplushie, /obj/item/toy/plush/random_snowflake, /obj/item/toy/plush/plushling) //don't allow these special ones (you can still get narplush/hugbox)
	for(var/V in plushies_set_one)
		var/atom/A = V
		plushie_list[initial(A.name)] = A
	//plushie set 2: snowflake plushies
	var/list/plushies_set_two = CONFIG_GET(keyed_list/snowflake_plushies)
	for(var/V in plushies_set_two)
		plushie_list[V] = V //easiest way to do this which works with how selecting options works, despite being snowflakey to have the key equal the value
	return plushie_list

/obj/item/choice_beacon/weapon
	name = "weapon crate"
	desc = "choose your weapon."
	icon = 'icons/obj/crates.dmi'
	icon_state = "weaponcrate"
	inhand_icon_state = "syringe_kit"

/obj/item/choice_beacon/weapon/follower
	name = "Follower of the Apocalpyse standard issue self-defense weapon crate"
	desc = "Has that weapon you ordered"
	var/static/list/follower_guns = list("non-lethal" = /obj/item/gun/energy/laser/complianceregulator,
	"lethal, energy" = /obj/item/gun/energy/laser/wattz,
	"lethal, ballistics" = /obj/item/gun/ballistic/revolver/colt357,
	)

/obj/item/choice_beacon/weapon/follower/generate_display_names()
	return follower_guns

/obj/item/choice_beacon/weapon/wastelander
	name = "personal weapon stash"
	desc = "contains your personal weapon, whatever it may be"
	var/static/list/follower_guns = list("M1911" = /obj/item/gun/ballistic/automatic/pistol/m1911,
	"M1911" = /obj/item/gun/ballistic/automatic/pistol/m1911,
	"N99, 10mm" = /obj/item/gun/ballistic/automatic/pistol/n99,
	".357 Police Pistol" = /obj/item/gun/ballistic/revolver/police,
	".357 Single Action Revolver" = /obj/item/gun/ballistic/revolver/colt357,
	"5.56mm Varmint Rifle" = /obj/item/gun/ballistic/automatic/varmint
	)
