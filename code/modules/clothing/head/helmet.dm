/obj/item/clothing/head/helmet
	name = "helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "helmet"
	item_state = "helmet"
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list()
	flags_inv = HIDEEARS | HIDEHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	strip_delay = 60
	resistance_flags = NONE
	flags_cover = HEADCOVERSEYES
	var/list/protected_zones = list(BODY_ZONE_HEAD)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


	dog_fashion = /datum/dog_fashion/head/helmet

	var/can_flashlight = FALSE //if a flashlight can be mounted. if it has a flashlight and this is false, it is permanently attached.
	var/obj/item/flashlight/seclite/attached_light
	var/datum/action/item_action/toggle_helmet_flashlight/alight


/obj/item/clothing/head/helmet/Initialize()
	. = ..()
	if(attached_light)
		alight = new(src)

/obj/item/clothing/head/helmet/Destroy()
	var/obj/item/flashlight/seclite/old_light = set_attached_light(null)
	if(old_light)
		qdel(old_light)
	return ..()


/obj/item/clothing/head/helmet/examine(mob/user)
	. = ..()
	if(attached_light)
		. += "It has \a [attached_light] [can_flashlight ? "" : "permanently "]mounted on it."
		if(can_flashlight)
			. += "<span class='info'>[attached_light] looks like it can be <b>unscrewed</b> from [src].</span>"
	else if(can_flashlight)
		. += "It has a mounting point for a <b>seclite</b>."

/obj/item/clothing/head/helmet/handle_atom_del(atom/A)
	if(A == attached_light)
		set_attached_light(null)
		update_helmlight()
		update_icon()
		QDEL_NULL(alight)
		qdel(A)
	return ..()


///Called when attached_light value changes.
/obj/item/clothing/head/helmet/proc/set_attached_light(obj/item/flashlight/seclite/new_attached_light)
	if(attached_light == new_attached_light)
		return
	. = attached_light
	attached_light = new_attached_light
	if(attached_light)
		attached_light.set_light_flags(attached_light.light_flags | LIGHT_ATTACHED)
		if(attached_light.loc != src)
			attached_light.forceMove(src)
	else if(.)
		var/obj/item/flashlight/seclite/old_attached_light = .
		old_attached_light.set_light_flags(old_attached_light.light_flags & ~LIGHT_ATTACHED)
		if(old_attached_light.loc == src)
			old_attached_light.forceMove(get_turf(src))

/obj/item/clothing/head/helmet/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(SLOT_HEAD))

/obj/item/clothing/head/helmet/sec
	can_flashlight = TRUE

/obj/item/clothing/head/helmet/sec/attackby(obj/item/I, mob/user, params)
	if(issignaler(I))
		var/obj/item/assembly/signaler/S = I
		if(attached_light) //Has a flashlight. Player must remove it, else it will be lost forever.
			to_chat(user, span_warning("The mounted flashlight is in the way, remove it first!"))
			return

		if(S.secured)
			qdel(S)
			var/obj/item/bot_assembly/secbot/A = new
			user.put_in_hands(A)
			to_chat(user, span_notice("You add the signaler to the helmet."))
			qdel(src)
			return
	return ..()

/obj/item/clothing/head/helmet/alt
	name = "bulletproof helmet"
	desc = "A bulletproof combat helmet that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	icon_state = "helmetalt"
	item_state = "helmetalt"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2)
	can_flashlight = 1
	dog_fashion = null

/obj/item/clothing/head/helmet/alt/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/head/kevlarhelmet
	name = "Base for kevlar helmets of various degrees"
	desc = "Base for Kevlar helmets 2.0 electric boogaloo"
	armor_tokens = list( ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_LIGHT
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT

/obj/item/clothing/head/kevlarhelmet/rus1
	name = "Modern Russian helmet"
	desc = "A modern Russian 6b47. Saw use Pre-Fall by the Russian military. Mainly in use by slavic based wastelanders, it finds itself now in the bayou."
	icon_state = "6b47rus"
	item_state = "6b47rus"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/rus2
	name = "KGB Russian Helmet"
	desc = "A STSh-81 Helmet. Instead of being made of titanium alloys, it's made of the normal materials one would find in a ballistic helmet. Somehow, it's found itself in the bayou. It's far from its original home."
	icon_state = "kgbhelmet"
	item_state = "kgbhelmet"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/canadian
	name = "Canadian Helmet"
	desc = "A Canadian CG634 standard issue helmet. It saw use in the Canadian army. Now it ends up in this region. Far from the North it seems."
	icon_state = "canadiancg634"
	item_state = "canadiancg634"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/unitednation
	name = "U.N Helmet"
	desc = "A United Nations helmet. It sees use by U.N PeaceKeepers during Pre-Fall times. Bright blue, perfect for sky camo and keeping peace."
	icon_state = "unhelmet"
	item_state = "unhelmet"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/unitednation/medical
	name = "U.N Medical Helmet"
	desc = "A United Nations helmet. It sees use by U.N PeaceKeepers during Pre-Fall times. Bright blue with a green medical cross"
	icon_state = "unmedical"
	item_state = "unmedical"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/newshelmet
	name = "War Press helmet"
	desc = "A war press helmet. This helmet saw use by Pre-Fall War correspondents. Lets any shooters know you're just there to take a news and footage...if you have any cameras on you."
	icon_state = "warpress"
	item_state = "warpress"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/americandesert
	name = "American desert helmet"
	desc = "An desert themed PASGT American helmet. This saw heavy use in the Gulf War during Pre-Fall times. This helmet's cover was repaired to pristine condition"
	icon_state = "pasgtdesert"
	item_state = "pasgtdesert"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/china1
	name = "Modern Chinese helmet"
	desc = "A QGF03 Chinese helmet. This helmet saw primary usage in the People's Liberation Army during Pre-Fall times. The cover's been restored."
	icon_state = "qgf03china"
	item_state = "qgf03china"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/hueypilot
	name = "Aircrew Helmet"
	desc = "A aircrewmen helmet. This helmet is outfitted for pilot's and comes with a cool cosmetic microphone. As a pilot once said 'I love the smell of vertibird fuel in the evening'."
	icon_state = "pilothelmet"
	item_state = "pilothelmet"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/ghillie
	name = "Ghillie helmet"
	desc = "A steel helmet covered in the user's own macabre of leaves, grass, and flora patterns. Meant to disguise the wearer's head in grassy regions"
	icon_state = "ghillie"
	item_state = "ghillie"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/ukhelmet
	name = "MK6 Helmet"
	desc = "A British MK6 helmet. It was outphased by the MK7, but the MK6 saw extensive use by the British military, PMCs, and foreign countries. Reliable, hardy, and cool looking. Who dares wins."
	icon_state = "mk6"
	item_state = "mk6"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'


/obj/item/clothing/head/cossackgear
	name = "Black bearskin hat"
	desc = "A very warm and well made bearskin hat. The black fur is commonly seen across the world from Kuban cossacks to the Queen's guard. The hat is remarkable soft and very useful for the winter. Take out that sabre and charge forth!"
	icon_state = "cossack"
	item_state = "cossack"
	armor_tokens = list( ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_LIGHT
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDEEARS

/obj/item/clothing/head/cossackgear/white
	name = "White bearskin hat"
	desc = "A very warm and well made bearskin hat. The white fur is uncommonly seen across the world from cossacks to other groups across the world. The hat is remarkable soft and very useful for the winter. Take out that sabre and charge forth!"
	icon_state = "wcossack"
	item_state = "wcossack"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDEEARS

/obj/item/clothing/head/cossackgear/papakhacossack
	name = "Black Papahka hat"
	desc = "A very warm and well made papakha hat. Made of wool, this hat was used throughout the Caucasus regions."
	icon_state = "papakha"
	item_state = "papakha"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDEEARS

/obj/item/clothing/head/cossackgear/papakhawhitecossack
	name = "White bearskin hat"
	desc = "A very warm and well made papakha hat. Made of wool, this hat was used throughout the Caucasus regions. This one is white"
	icon_state = "papakhaw"
	item_state = "papakhaw"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDEEARS

/obj/item/clothing/head/cossackgear/papakhakubancossack
	name = "White bearskin hat"
	desc = "A very warm and well made papakha hat. Made of wool, this hat was used throughout the Caucasus regions. This one is based off the hats used by the Kuban Cossacks."
	icon_state = "papakhakuban"
	item_state = "papakhakuban"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDEEARS


/obj/item/clothing/head/kevlarhelmet/steelgerman
	name = "Biker helmet"
	desc = "A biker's steel helmet. Good on style and kicking ass at the bar. 'What did you say about my mother?'-some biker probably."
	icon_state = "1919german"
	item_state = "1919german"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/ww1steelgerman
	name = "Outdated steel helmet"
	desc = "An outdated steel helmet design. The design and documents long lost to time. Now and days it's used as a nifty biker helmet. Just this one needs some new paint."
	icon_state = "oldgerm"
	item_state = "oldgerm"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/steelww2soviet
	name = "WW2 Soviet helmet"
	desc = "A outdated yet functional soviet helmet from WW2. It is a plain, cut, simple, and simple-designed helmet that offers the same protection as any else steel helmet."
	icon_state = "sovhelm"
	item_state = "sovhelm"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/pilotka
	name = "Armored Pilotka hat"
	desc = "A ballistic weaved pilotka hat. The hat originated during WW2 and saw extensive use by the Red Army in WW2. After the 1980s, the pilotka was used during the summer time. It still finds use in post-war and Pre-Fall modern times."
	icon_state = "pilotka"
	item_state = "pilotka"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/ww1capseries
	name = "Armored British Cap"
	desc = "A ballistic weaved British WW1 cap. This cap was used before helmets were a thing in the Great war."
	icon_state = "brittcap"
	item_state = "brittcap"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/ww1capseries/german
	name = "Armored East German Cap"
	desc = "A ballistic weaved East German cap. This cap was modeled after the cap used by Imperial German soldiers in WW1, which was used before helmets were a thing in the Great war."
	icon_state = "germcap"
	item_state = "germcap"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'


/obj/item/clothing/head/kevlarhelmet/warhammerhatsandhelmets
	name = "Armored Ancient West German cap"
	desc = "A ballistic weaved West German cap. This cap is of a very ancient design it seems!"
	icon_state = "comissar"
	item_state = "comissar"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/warhammerhatsandhelmets/imperiumhelmet
	name = "Ancient American ballistic helmet"
	desc = "A ballistic helmet of an ancient American design. Very old design but might prove handy!"
	icon_state = "guard"
	item_state = "guard"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'


/obj/item/clothing/head/kevlarhelmet/ww1capseries/french
	name = "Armored French Cap"
	desc = "A ballistic weaved French WW1 cap. This cap was used before helmets were a thing in the Great war."
	icon_state = "frenchcap"
	item_state = "frenchcap"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/ww2usa
	name = "M1 battle helmet"
	desc = "A M1 helmet. This helmet was extensively used by the U.S during WW2. It came with a bountiful set of options and customization features..like a painted cross! Or netting! Or even a nifty camo cover! This specific helmet has none of that. A clean cut made helmet, go out and make it well worn!"
	icon_state = "m1helm"
	item_state = "m1helm"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'


/obj/item/clothing/head/kevlarhelmet/ww1russiancap
	name = "Armored Imperial Russian cap"
	desc = "A clean pressed and finely made Imperial Russian cap. This cap was used throughout the Great War by Imperial Russian officers and soldiers. Don the bayonets and get the trench whistle ready to blow, you're up!"
	icon_state = "ww1rus"
	item_state = "ww1rus"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'


/obj/item/clothing/head/kevlarhelmet/ww237jap
	name = "Old Japanese helmet"
	desc = "A old styled Japanese helmet. This helmet was introduced during the old wars from Japan in the Pacific. Usually came with a flag. Pick a bush and wait patiently for the enemy to fall into your trap."
	icon_state = "japhelm"
	item_state = "japhelm"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/rusadrian
	name = "Russian Adrian helmet"
	desc = "A Adrian helmet, but instead of it being French, it's Russian. Used by Russian during the Great War, these helmets were the go-to of the army. Donning a red star, it was more olive in appearance."
	icon_state = "adrianir"
	item_state = "adrianir"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'


/obj/item/clothing/head/armoredushanka
	name = "Ballistic Soviet Union Ushanka"
	desc = "A Ushanka made with ballistic weave and kevlar in mind. Now you can rock the motherland's style while having that head of yours be protected. Still comfortable if not a shy bit more comfortable than your usual ushanka."
	icon_state = "newushanka"
	item_state = "newushanka"
	armor_tokens = list( ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_LIGHT
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDEEARS

/obj/item/clothing/head/evaspartan
	name = "M-87 'EVA' assault helmet"
	desc = "An assault helmet produced by Leo Armaments. The helmet is specifically made for E.V.A enviroments. Aftermarket military designs can claim to have spun off as many sub-variants as the EVA M-87 design. However the enduring popularity of the design is a testament to its reliability, ergonomics, modularity, and militaristic craftsmanship by Leo Armaments. "
	icon_state = "eva"
	item_state = "eva"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2 ,ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_DOWN_LASER_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_MEDIUM
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT | HIDEHAIR

/obj/item/clothing/head/evaspartan2
	name = "M-87 'EVA' assault helmet 'Icebreaker' "
	desc = "An assault helmet produced by Leo Armaments. The helmet is specifically made for E.V.A enviroments. Aftermarket military designs can claim to have spun off as many sub-variants as the EVA M-87 design. However the enduring popularity of the design is a testament to its reliability, ergonomics, modularity, and militaristic craftsmanship by Leo Armaments. This one has a winter-polarized coating."
	icon_state = "eva2"
	item_state = "eva2"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2 ,ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_DOWN_LASER_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_MEDIUM
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT | HIDEHAIR

/obj/item/clothing/head/evaspartan3
	name = "M-87 'EVA' assault helmet 'Leo Patriot' "
	desc = "An assault helmet produced by Leo Armaments. The helmet is specifically made for E.V.A enviroments. Aftermarket military designs can claim to have spun off as many sub-variants as the EVA M-87 design. However the enduring popularity of the design is a testament to its reliability, ergonomics, modularity, and militaristic craftsmanship by Leo Armaments. This one has a Leo Armaments paint scheme to it."
	icon_state = "eva3"
	item_state = "eva3"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2 ,ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_DOWN_LASER_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_MEDIUM
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT | HIDEHAIR


/obj/item/clothing/head/gungnirspartan
	name = "M-87 'Odin' assault helmet"
	desc = "An assault helmet produced by Leo Armaments. The helmet has a facial attachment is akin to the sniper plates one would find in WW1 trenches. The facial plate comes with a camera that can allow one to see through the faceplate. Aftermarket military designs can claim to have spun off as many sub-variants as the EVA M-87 design. However the enduring popularity of the design is a testament to its reliability, ergonomics, modularity, and militaristic craftsmanship by Leo Armaments."
	icon_state = "gungnir"
	item_state = "gungnir"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2 ,ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_DOWN_LASER_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_MEDIUM
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT | HIDEHAIR

/obj/item/clothing/head/gungnirspartan2
	name = "M-87 'Odin' assault helmet 'Icebreaker' "
	desc = "An assault helmet produced by Leo Armaments. The helmet has a facial attachment is akin to the sniper plates one would find in WW1 trenches. The facial plate comes with a camera that can allow one to see through the faceplate. Aftermarket military designs can claim to have spun off as many sub-variants as the EVA M-87 design. However the enduring popularity of the design is a testament to its reliability, ergonomics, modularity, and militaristic craftsmanship by Leo Armaments. This one comes in a artic finish."
	icon_state = "gungnir2"
	item_state = "gungnir2"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2 ,ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_DOWN_LASER_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_MEDIUM
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT | HIDEHAIR


/obj/item/clothing/head/droptrooper
	name = "M-87 UNMC DropTrooper assault helmet"
	desc = "An assault helmet produced by Leo Armaments. The helmet is esteemed and well known amongst Drop Troopers of the UNMC. Heavily favored for its reliable nature and downright sleek nature. It's quite the modular helmet and eventually became the baseline for the M-87 Assault Helmet modular system. The helmet is nicknamed 'Drop Trooper's best friend' by some branches of the UNMC."
	icon_state = "odst"
	item_state = "odst"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2 ,ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_DOWN_LASER_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_MEDIUM
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT | HIDEHAIR

/obj/item/clothing/head/droptrooper/ice
	name = "M-87 Luchtmobiele Brigade assault helmet"
	desc = "An assault helmet produced by Leo Armaments. The helmet is esteemed and well known amongst Drop Troopers of the UNMC. However, this helmet seems to have been upgraded to fit and be equipped with Mark XI assault armor. It retains the same appearance, but dons but a stripe and polar finish. It seems it was made in collaboration between the Royal Netherlands military and Leo Armaments."
	icon_state = "odst3"
	item_state = "odst3"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2 ,ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_DOWN_LASER_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_MEDIUM
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT | HIDEHAIR

/obj/item/clothing/head/droptrooper/special
	name = "M-87 HellTrooper assault helmet"
	desc = "An assault helmet produced by Leo Armaments. The helmet is esteemed and well known amongst Drop Troopers of the UNMC. However, this helmet seems to have been upgraded to fit and be equipped with Mark XI assault armor. It retains the same appearance, but dons but a stripe and Leo Armaments. finish. It seems it was made in collaboration between the UNMC special forces and Leo Armaments."
	icon_state = "odst3"
	item_state = "odst3"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2 ,ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_DOWN_LASER_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_MEDIUM
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT | HIDEHAIR

/obj/item/clothing/head/droptrooper/arghelmet
	name = "ARG ATLAS Helmet"
	desc = "ATLAS, meaning Armor - Tactical Lead Assault Suite, is an extensively modified and reinforced rendition of the M-87 'Thor' helmet. This helmet includes a primitive target-acquisition program designed to help the user both deal with threats to themselves and their ward, simple user biometrics, omni-directional internal speakers for more situational awareness, ballistic reinforcements to the visor, extra helmet padding and an 'anomaly-resistant coating,' whatever that means. The helmet is developed and produced by the Augur Research Group."
	icon_state = "argmkvi"
	item_state = "argmkvi"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2 ,ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_DOWN_LASER_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_MEDIUM
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT | HIDEHAIR

/obj/item/clothing/head/droptrooper/custompahelmet
	name = "Custom fitted MidWestern B.O.S helmet"
	desc = "A custom fitted B.O.S themed helmet. Fitted to resemble that of medium ballistic helmets."
	icon_state = "midwestpa"
	item_state = "midwestpa"
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_MEDIUM
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT | HIDEHAIR
	var/requires_training = FALSE

/obj/item/clothing/head/droptrooper/arghelmet/two
	name = "ARG ARES Helmet"
	desc = "ARES, meaning Armor - Research Enhancement Suite, is an extensively modified and computerized rendition of the M-87 'Odin' assault helmet. An additional camera has been added to the faceplate to give the user better depth perception, as well as the ability to broadcast video feed through encrypted channels. The heads-up display within the helmet now includes simple user biometrics and an analysis mode, giving real-time updates concerning objects and creatures in view of the cameras. It has extra helmet padding and an 'anomaly-resistant coating,' whatever that means. The helmet is developed and produced by the Augur Research Group."
	icon_state = "arggungnir"
	item_state = "arggungnir"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2 ,ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_DOWN_LASER_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_MEDIUM
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT | HIDEHAIR

/obj/item/clothing/head/kevlarhelmet/steelfrench
	name = "French Adrian helmet"
	desc = "A French, albeit outdated, Adrian helmet. It was the first helmet used by the French military during the great war. In WW2, the helmet was used again but named the M26. Adjust that helmet and get back to the frontlines!"
	icon_state = "adrian"
	item_state = "adrian"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/toxtestinghelmet
	name = "VeturrHjalmur"
	desc = "A custom Icelandic steel helmet adorned with a baby blue cross. This helmet is padded and really meant for looks than actual combative purposes. Made of the finest materials to grace the wasteland. Which is fine steel, padded interior, and adjustable ballistic silk straps."
	icon_state = "germed"
	item_state = "germed"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'


/obj/item/clothing/head/toxbattlehelmet
	name = "Holy Void Priestess Hjalmur"
	desc = "A custom X99 skull-carapace also knowna as a full plated helmet. The helmet is made to fit the smaller snouts of anthros, mainly feline or flat faced onces. The helmet bears icelandic runes on the interior while the exterior is engraved with Void sigils. The tag on the padded and comfortable inside reads 'Tox Mckit' "
	icon_state = "sistertoxhelm"
	item_state = "sistertoxhelm"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	armor_tokens = list( ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_LIGHT
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	speechspan = SPAN_ROBOT

//medieval and old helmets

/obj/item/clothing/head/medievalhelmets
	name = "Base for old helmets"
	desc = "Base for old helmets 2.0 electric boogaloo"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1 ,ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_DOWN_BULLET_T2)
	armor = ARMOR_VALUE_LIGHT
	dog_fashion = null
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT

/obj/item/clothing/head/medievalhelmets/oldgerman
	name = "German sallet helmet"
	desc = "A German based sallet helmet. Renowned and one of many famous helmet designs during the medieval era. It was a very popular design before being outphased and killed off by the burgonet helmet."
	icon_state = "gersallet"
	item_state = "gersallet"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/medievalhelmets/oldspain
	name = "Spainard Morion helmet"
	desc = "An extremely popular design from Spain, this is the Morion helmet. It was famously used by Spanish Conquisitidors and made popular in Pre-Fall films and medieval like Pre-Fall video games. Usually comes with a loving plume."
	icon_state = "spanishhelm"
	item_state = "spanishhelm"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/helmet/merekcustom
	name = "salvaged battle helmet"
	desc = "A salvaged bullet resistant helmet. It's made of a much weaker material."
	icon_state = "helmetalt"
	item_state = "helmetalt"
	armor = ARMOR_VALUE_LIGHT
	can_flashlight = FALSE


/obj/item/clothing/head/helmet/old
	name = "degrading helmet"
	desc = "Standard issue security helmet. Due to degradation the helmet's visor obstructs the users ability to see long distances."
	tint = 2

/obj/item/clothing/head/helmet/blueshirt
	name = "Vault-Tec security helmet"
	desc = "A light, open-faced helmet commonly worn by Vault-Tec security personnel."
	icon_state = "blueshift"
	item_state = "blueshift"

/obj/item/clothing/head/helmet/riot
	name = "riot helmet"
	desc = "It's a helmet specifically designed to protect against close range attacks."
	icon_state = "riot"
	item_state = "helmet"
	toggle_message = "You pull the visor down on"
	alt_toggle_message = "You push the visor up on"
	can_toggle = 1
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2)
	flags_inv = HIDEEARS|HIDEFACE
	strip_delay = 80
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_inv = HIDEFACE
	toggle_cooldown = 0
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	dog_fashion = null
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/head/helmet/attack_self(mob/user)
	if(can_toggle && !user.incapacitated(allow_crit = TRUE))
		if(world.time > cooldown + toggle_cooldown)
			cooldown = world.time
			up = !up
			flags_1 ^= visor_flags
			flags_inv ^= visor_flags_inv
			flags_cover ^= visor_flags_cover
			icon_state = "[initial(icon_state)][up ? "up" : ""]"
			to_chat(user, "[up ? alt_toggle_message : toggle_message] \the [src]")

			user.update_inv_head()
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.head_update(src, forced = 1)

			if(active_sound)
				while(up)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(15)

/obj/item/clothing/head/helmet/justice
	name = "helmet of justice"
	desc = "WEEEEOOO. WEEEEEOOO. WEEEEOOOO."
	icon_state = "justice"
	toggle_message = "You turn off the lights on"
	alt_toggle_message = "You turn on the lights on"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	can_toggle = 1
	toggle_cooldown = 20
	active_sound = 'sound/items/weeoo1.ogg'
	dog_fashion = null

/obj/item/clothing/head/helmet/justice/escape
	name = "alarm helmet"
	desc = "WEEEEOOO. WEEEEEOOO. STOP THAT MONKEY. WEEEOOOO."
	icon_state = "justice2"
	toggle_message = "You turn off the light on"
	alt_toggle_message = "You turn on the light on"

/obj/item/clothing/head/helmet/swat
	name = "\improper SWAT helmet"
	desc = "An extremely robust, space-worthy helmet in a nefarious red and black stripe pattern."
	icon_state = "swatsyndie"
	item_state = "swatsyndie"
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	clothing_flags = STOPSPRESSUREDAMAGE
	strip_delay = 80
	dog_fashion = null

/obj/item/clothing/head/helmet/swat/nanotrasen
	name = "\improper SWAT helmet"
	desc = "An extremely robust, space-worthy helmet with the US Government logo emblazoned on the top."
	icon_state = "swat"
	item_state = "swat"

/obj/item/clothing/head/helmet/thunderdome
	name = "\improper Thunderdome helmet"
	desc = "<i>'Let the battle commence!'</i>"
	flags_inv = HIDEEARS|HIDEHAIR
	icon_state = "thunderdome"
	item_state = "thunderdome"
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	strip_delay = 80
	dog_fashion = null

/obj/item/clothing/head/helmet/roman
	name = "\improper Roman helmet"
	desc = "An ancient helmet made of bronze and leather."
	flags_inv = HIDEEARS|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	resistance_flags = FIRE_PROOF
	icon_state = "roman"
	item_state = "roman"
	strip_delay = 100
	dog_fashion = null

/obj/item/clothing/head/helmet/roman/fake
	desc = "An ancient helmet made of plastic and leather."
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T2, ARMOR_MODIFIER_DOWN_MELEE_T2)

/obj/item/clothing/head/helmet/roman/legionnaire
	name = "\improper Roman legionnaire helmet"
	desc = "An ancient helmet made of bronze and leather. Has a red crest on top of it."
	icon_state = "roman_c"
	item_state = "roman_c"

/obj/item/clothing/head/helmet/roman/legionnaire/fake
	desc = "An ancient helmet made of plastic and leather. Has a red crest on top of it."
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T2, ARMOR_MODIFIER_DOWN_MELEE_T2)

/obj/item/clothing/head/helmet/gladiator
	name = "gladiator helmet"
	desc = "Ave, Imperator, morituri te salutant."
	icon_state = "gladiator"
	item_state = "gladiator"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	dog_fashion = null

/obj/item/clothing/head/helmet/redtaghelm
	name = "red laser tag helmet"
	desc = "They have chosen their own end."
	icon_state = "redtaghelm"
	flags_cover = HEADCOVERSEYES
	item_state = "redtaghelm"
	// Offer about the same protection as a hardhat.
	dog_fashion = null

/obj/item/clothing/head/helmet/unmchelmet
	name = "Standard issue UNMC helmet"
	desc = "A standard issued UNMC Helmet. The flashlight mount doesn't work and it has no visor. Despite that, it seems to be in good condition. Don't lose your head now, soldier."
	icon_state = "unmch"
	item_state = "unmch"
	flags_inv = HIDEHAIR
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_BOMB_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/kevlarhelmet/toxinfil
	name = "Gen 3 Leo MIRAGE Helmet"
	desc = "A third generation Leo Armaments MIRAGE Helmet. This helmet has no visor due to the fact the visor was not 'anthromorphic' friendly. The area around the eyes allows the installiation of gun-spec, or G.S, eyewear."
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)
	icon_state = "custominfil"
	item_state = "custominfil"

/obj/item/clothing/head/helmet/unmchelmet/medic
	name = "Standard issue UNMC Medical Helmet"
	desc = "A standard issued UNMC Helmet, this one seems to be resembling that of a medical personal's color scheme with a white paint and a green cross."
	icon_state = "unmcmh"
	item_state = "unmcmh"
	flags_inv = HIDEHAIR
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
/obj/item/clothing/head/helmet/retrohazmathelmet
	name = "Old Hazmat helmet"
	desc = "A old style hazmat helmet. It's a bit well worn and the visor has a crack on it. But other than that, it seems to still work."
	icon_state = "rhazhelm"
	item_state = "rhazhelm"
	flags_inv = HIDEHAIR
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T4)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/helmet/unmcstealthhelmet
	name = "American infiltrator helmet"
	desc = "A helmet belonging, albeit dysfunctional, to the American stealth suit. Now when you get to look cool while chanting 'USA' from the shadows"
	icon_state = "usainfilhelm"
	item_state = "usainfilhelm"
	flags_inv = HIDEHAIR|HIDESNOUT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/helmet/chinastealthhelm
	name = "Chinese Stealth helmet"
	desc = "A helmet belonging, albeit dysfunctional, to the Chinese stealth armor. Once belonging to a feared Chinese Crimson Dragoon."
	icon_state = "chinastealthhelm"
	item_state = "chinastealthhelm"
	flags_inv = HIDEHAIR|HIDESNOUT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/helmet/unmcwinterhelmet
	name = "Winter UNMC Helmet"
	desc = "A standard issued UNMC Helmet.This version seems to have white paint all over it, a type of camoflauge. As an added bonus, it seems a bit more sturdy to laser based weaponary. The flashlight mount doesn't work and it has no visor. Despite that, it seems to be in good condition. Don't lose your head now, soldier."
	icon_state = "unmcwh"
	item_state = "unmcwh"
	flags_inv = HIDEHAIR
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_BOMB_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'

/obj/item/clothing/head/helmet/blbandit
	name = "bandit mask"
	desc = "A modified hockey mask sporting an in-built set of goggles."
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	icon_state = "banditmask"
	item_state = "banditmask"
	flags_inv = HIDESNOUT
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/head/helmet/blpsycho
	name = "psycho mask"
	desc = "A hockey mask with an upside down, golden 'V' painted on the front."
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	icon_state = "psychomask"
	item_state = "psychomask"
	flags_inv = HIDESNOUT
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/head/helmet/borderlandshelm
	name = "borderlands helmet template"
	desc = "If you're seeing this, something has gone horribly wrong."
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDEMASK | HIDEEYES | HIDEHAIR | HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	armor = ARMOR_VALUE_MEDIUM

/obj/item/clothing/head/helmet/borderlandshelm/bandit
	name = "bandit helmet"
	desc = "A standard helmet that entirely covers the wearer's head. This one comes in a deep red and navy blue."
	icon_state = "bandithelm"
	item_state = "bandithelm"

/obj/item/clothing/head/helmet/borderlandshelm/banditv
	name = "looter bandit helmet"
	desc = "A red and blue helmet sporting an upside down, silver 'V' on the front."
	icon_state = "vbandithelm"
	item_state = "vbandithelm"

/obj/item/clothing/head/helmet/borderlandshelm/banditstripe
	name = "striped bandit helmet"
	desc = "A red and blue helmet with a silver stripe running down the center."
	icon_state = "stripebandithelm"
	item_state = "stripebandithelm"

/obj/item/clothing/head/helmet/borderlandshelm/merc
	name = "mercenary helmet"
	desc = "A professional-looking helmet that completely covers the head."
	icon_state = "merchelm"
	item_state = "merchelm"

/obj/item/clothing/head/helmet/borderlandshelm/promerc
	name = "professional mercenary helmet"
	desc = "A tactical-looking, matte black helmet -- complete with red visors!"
	icon_state = "promerchelm"
	item_state = "promerchelm"

/obj/item/clothing/head/helmet/bluetaghelm
	name = "blue laser tag helmet"
	desc = "They'll need more men."
	icon_state = "bluetaghelm"
	flags_cover = HEADCOVERSEYES
	item_state = "bluetaghelm"
	// Offer about the same protection as a hardhat.
	dog_fashion = null

/obj/item/clothing/head/helmet/knight
	name = "medieval helmet"
	desc = "A classic metal helmet worn by all ranks of knights and horsemen of the Old Era."
	icon_state = "knight_green"
	item_state = "knight_green"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	strip_delay = 80
	dog_fashion = null
	mutantrace_variation = STYLE_MUZZLE


/obj/item/clothing/head/helmet/knight/Initialize(mapload)
	. = ..()
	var/datum/component = GetComponent(/datum/component/wearertargeting/earprotection)
	qdel(component)

/obj/item/clothing/head/helmet/knight/blue
	name = "blue medieval helmet"
	desc = "A classic metal helmet worn by all ranks of knights and horsemen of the Old Era.<br>This one is painted blue."
	icon_state = "knight_blue"
	item_state = "knight_blue"

/obj/item/clothing/head/helmet/knight/yellow
	name = "yellow medieval helmet"
	desc = "A classic metal helmet worn by all ranks of knights and horsemen of the Old Era.<br>This one is painted yellow."
	icon_state = "knight_yellow"
	item_state = "knight_yellow"

/obj/item/clothing/head/helmet/knight/templar
	name = "crusader helmet"
	desc = "Deus Vult."
	icon_state = "knight_templar"
	item_state = "knight_templar"

/obj/item/clothing/head/helmet/knight/greyscale
	name = "knight helmet"
	desc = "A classic medieval helmet, if you hold it upside down you could see that it's actually a bucket."
	icon_state = "knight_greyscale"
	item_state = "knight_greyscale"
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS //Can change color and add prefix

/obj/item/clothing/head/helmet/skull
	name = "skull helmet"
	desc = "An intimidating tribal helmet, it doesn't look very comfortable."
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	flags_cover = HEADCOVERSEYES
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2)
	icon_state = "skull"
	item_state = "skull"
	strip_delay = 100
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/head/helmet/infiltrator
	name = "insidious helmet"
	desc = "An insidious armored combat helmet signed with Syndicate insignia. The visor is coated with a resistant paste guaranteed to withstand bright flashes perfectly."
	icon_state = "infiltrator"
	item_state = "infiltrator"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	flash_protect = 2
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	strip_delay = 80
	mutantrace_variation = STYLE_MUZZLE

//LightToggle

/obj/item/clothing/head/helmet/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/helmet/update_icon_state()
	var/state = "[initial(icon_state)]"
	if(attached_light)
		if(attached_light.on)
			state += "-flight-on" //"helmet-flight-on" // "helmet-cam-flight-on"
		else
			state += "-flight" //etc.

	icon_state = state
	return ..()

/obj/item/clothing/head/helmet/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_helmet_flashlight))
		toggle_helmlight()
	else
		..()

/obj/item/clothing/head/helmet/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/flashlight/seclite))
		if(can_flashlight && !attached_light)
			var/obj/item/flashlight/seclite/S = I
			if(!user.transferItemToLoc(S, src))
				return
			to_chat(user, span_notice("You click [S] into place on [src]."))
			set_attached_light(S)
			update_helmlight()
			update_icon()
			alight = new(src)
			if(loc == user)
				alight.Grant(user)
		return
	return ..()


/obj/item/clothing/head/helmet/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(can_flashlight && attached_light) //if it has a light but can_flashlight is false, the light is permanently attached.
		I.play_tool_sound(src)
		to_chat(user, span_notice("You unscrew [attached_light] from [src]."))
		attached_light.forceMove(drop_location())
		if(Adjacent(user) && !issilicon(user))
			user.put_in_hands(attached_light)

		var/obj/item/flashlight/removed_light = set_attached_light(null)
		update_helmlight()
		removed_light.update_brightness(user)
		update_icon()
		user.update_inv_head()
		QDEL_NULL(alight)
		return TRUE


/obj/item/clothing/head/helmet/proc/toggle_helmlight()
	set name = "Toggle Helmetlight"
	set category = "Object"
	set desc = "Click to toggle your helmet's attached flashlight."

	if(!attached_light)
		return

	var/mob/user = usr
	if(user.incapacitated(allow_crit = TRUE))
		return
	attached_light.on = !attached_light.on
	attached_light.update_brightness()
	to_chat(user, span_notice("You toggle the helmet light [attached_light.on ? "on":"off"]."))

	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_helmlight()


/obj/item/clothing/head/helmet/proc/update_helmlight()
	if(attached_light)
		update_icon()

	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()


/obj/item/clothing/head/helmet/durathread
	name = "makeshift helmet"
	desc = "A hardhat with strips of leather and durathread for additional blunt protection."
	icon_state = "durathread"
	item_state = "durathread"


/obj/item/clothing/head/helmet/rus_helmet
	name = "russian helmet"
	desc = "It can hold a bottle of vodka."
	icon_state = "rus_helmet"
	item_state = "rus_helmet"

/obj/item/clothing/head/helmet/rus_ushanka
	name = "battle ushanka"
	desc = "100% bear."
	icon_state = "rus_ushanka"
	item_state = "rus_ushanka"
	clothing_flags = THICKMATERIAL
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/head/helmet/police
	name = "police officer's hat"
	desc = "A police officer's Hat. This hat emphasizes that you are THE LAW."
	icon_state = "policehelm"
	dynamic_hair_suffix = ""

/obj/item/clothing/head/helmet/armyhelmet
	name = "steel helmet"
	desc = "A steel helmet, inspired by several Pre-Fall designs. It provides some protection against impacts, cuts, and medium-velocity bullets."
	icon = 'icons/fallout/clothing/helmets.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon_state = "armyhelmet"
	item_state = "armyhelmet"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1)

/obj/item/clothing/head/helmet/armyhelmet/heavy
	name = "heavy steel helmet"
	desc = "a steel helmet, inspired by several Pre-Fall designs. This one has been modified by Nash citizens to provide more protection to the face and neck."
	icon_state = "armyhelmetheavy"
	item_state = "armyhelmetheavy"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_BULLET_T3)
