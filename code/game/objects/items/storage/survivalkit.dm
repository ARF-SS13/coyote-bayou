/obj/item/storage/survivalkit
	name = "survival kit"
	desc = "A robust leather pouch containing the essentials for wasteland survival."
	icon_state = "survivalkit"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/survivalkit/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/stack/medical/gauze/improvised(src)
	new /obj/item/stack/medical/mesh/aloe(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/reagent_containers/pill/radx(src)

/obj/item/storage/survivalkit_khan
	name = "survival kit"
	desc = "A robust leather pouch containing essentials a Khan might need in the wasteland."
	icon = 'icons/fallout/clothing/khans.dmi'
	icon_state = "survivalkit"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/survivalkit_khan/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/reagent_containers/hypospray/medipen/medx(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/reagent_containers/pill/radx(src)

/obj/item/storage/survivalkit_tribal
	name = "legion survival kit"
	desc = "A robust leather pouch containing the essentials for wasteland survival."
	icon_state = "survivalkit"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/survivalkit_tribal/PopulateContents() //used by legion
	. = ..()
	new /obj/item/reagent_containers/pill/patch/healingpowder(src)
	new /obj/item/stack/medical/gauze/improvised(src)
	new /obj/item/stack/medical/mesh/aloe(src)
	new /obj/item/stack/medical/suture/emergency(src)
	new /obj/item/flashlight/flare/torch(src)
	new /obj/item/tank/internals/emergency_oxygen(src)

/obj/item/storage/survivalkit_outlaw
	name = "survival kit"
	desc = "A robust leather pouch containing the essentials for wasteland survival."
	icon_state = "survivalkit"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/survivalkit_outlaw/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/flashlight/flare(src)
	new /obj/item/reagent_containers/pill/radx(src)

/obj/item/storage/survivalkit_tribal/chief

/obj/item/storage/survivalkit_tribal/chief/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/pill/patch/healingpowder(src)
	new /obj/item/reagent_containers/pill/patch/healingpowder(src)
	new /obj/item/reagent_containers/pill/patch/healpoultice(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/flashlight/flare/torch(src)

/obj/item/storage/survivalkit_adv
	name = "survival kit"
	desc = "A robust leather pouch containing the essentials for wasteland survival."
	icon_state = "survivalkit"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/survivalkit_adv/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/reagent_containers/pill/radx(src)
	new /obj/item/tank/internals/emergency_oxygen(src)

/obj/item/storage/survivalkit_aid
	name = "individual first aid kit"
	desc = "A robust leather pouch containing the essentials for trauma care."
	icon_state = "ifak"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/survivalkit_aid/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5

/obj/item/storage/survivalkit_aid/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/tank/internals/emergency_oxygen(src)

/obj/item/storage/survivalkit_aid_adv
	name = "advanced-individual first aid kit"
	desc = "A robust leather pouch containing the essentials for trauma care."
	icon_state = "ifak"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/survivalkit_aid_adv/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5

/obj/item/storage/survivalkit_aid_adv/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/hypospray/medipen/stimpak/super(src)
	new /obj/item/stack/medical/gauze/adv(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/stack/medical/mesh/advanced(src)
