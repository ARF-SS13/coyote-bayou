/obj/item/storage/briefcase
	name = "briefcase"
	desc = "It's made of AUTHENTIC faux-leather and has a price-tag still attached. Its owner must be a real professional."
	icon_state = "briefcase"
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 8
	hitsound = "swing_hit"
	throw_speed = 2
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "whacked")
	resistance_flags = FLAMMABLE
	max_integrity = 150
	var/folder_path = /obj/item/folder //this is the path of the folder that gets spawned in New()

/obj/item/storage/briefcase/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 21

/obj/item/storage/briefcase/PopulateContents()
	new /obj/item/pen(src)
	var/obj/item/folder/folder = new folder_path(src)
	for(var/i in 1 to 6)
		new /obj/item/paper(folder)

/obj/item/storage/briefcase/crafted
	desc = "Hand crafted suitcase made of leather and cloth."
	force = 6
	max_integrity = 50

/obj/item/storage/briefcase/crafted/PopulateContents()
	return //So we dont spawn items

/obj/item/storage/briefcase/lawyer
	folder_path = /obj/item/folder/blue

/obj/item/storage/briefcase/lawyer/family
	name = "battered  briefcase"
	icon_state = "gbriefcase"
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	desc = "An old briefcase with a golden trim. It's clear they don't make them as good as they used to. Comes with an added belt clip!"
	slot_flags = ITEM_SLOT_BELT

/obj/item/storage/briefcase/lawyer/family/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 14

/obj/item/storage/briefcase/lawyer/family/PopulateContents()
	new /obj/item/stamp/law(src)
	new /obj/item/pen/fountain(src)
	new /obj/item/paper_bin(src)
	new /obj/item/storage/box/evidence(src)
	new /obj/item/storage/box/lawyer(src)
	
/obj/item/storage/briefcase/secretary
	name = "fancy briefcase"
	desc = "a gecko-skin briefcase with nickel-plated hinges and carrying handle, the height of post-war business fashion."
	force = 12 //oasis made it better

/obj/item/storage/briefcase/secretary/PopulateContents()
	new /obj/item/suppressor(src)
	new /obj/item/gun/ballistic/automatic/pistol/sig(src)
	new /obj/item/paper_bin/bundlenatural(src)
	new /obj/item/clothing/under/suit/black/skirt(src)
	new /obj/item/pen(src)
	new /obj/item/storage/box/funds(src)
	
/obj/item/storage/box/funds
	name = "Oasis operating funds"
	desc = "A box filled with both local and foreign currency, to cover unexpected purchases"

// Secretary spawns with all 3 types of money for negotatiating with any side. ~225 caps worth
/obj/item/storage/box/funds/PopulateContents()
		new /obj/item/stack/f13Cash/random/ncr/med(src)
		new /obj/item/stack/f13Cash/random/denarius/med(src)
		new /obj/item/stack/f13Cash/random/ncr/med(src)

/obj/item/storage/box/lawyer
	name = "Box of lawyer tools"
	desc = "A custom made box, full of items used by a Lawyer, all packed into one box!"

/obj/item/storage/box/lawyer/PopulateContents()
		new /obj/item/clothing/gloves/color/white(src)
		new /obj/item/folder/white(src)
		new /obj/item/clothing/glasses/regular(src)
		new /obj/item/folder/red(src)
		new /obj/item/gavelhammer(src)
		new /obj/item/stack/sheet/cloth(src)
		new /obj/item/reagent_containers/glass/beaker/waterbottle(src)

/obj/item/storage/briefcase/lawyer/PopulateContents()
	new /obj/item/stamp/law(src)
	..()

/obj/item/storage/briefcase/sniperbundle
	desc = "Its label reads \"genuine hardened Captain leather\", but suspiciously has no other tags or branding. Smells like L'Air du Temps."
	force = 10
/obj/item/storage/briefcase/sniperbundle/PopulateContents()
	..() // in case you need any paperwork done after your rampage
	new /obj/item/clothing/neck/tie/red(src)
	new /obj/item/clothing/under/syndicate/sniper(src)
	new /obj/item/suppressor/specialoffer(src)


/obj/item/storage/briefcase/modularbundle
	desc = "Its label reads \"genuine hardened Captain leather\", but suspiciously has no other tags or branding."
	force = 10

/obj/item/storage/briefcase/modularbundle/PopulateContents()
	new /obj/item/suppressor(src)
	new /obj/item/clothing/under/suit/black(src)
	new /obj/item/clothing/accessory/waistcoat(src)
	new /obj/item/clothing/suit/toggle/lawyer/black/syndie(src)

/obj/item/storage/briefcase/medical
	name = "medical briefcase"
	icon_state = "medbriefcase"
	desc = "A white with a blue cross brieface, this is meant to hold medical gear that would not be able to normally fit in a bag."

/obj/item/storage/briefcase/medical/PopulateContents()
	new /obj/item/clothing/neck/stethoscope(src)
	new /obj/item/healthanalyzer(src)
	..() //Incase of paperwork

