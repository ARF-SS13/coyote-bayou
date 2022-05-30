
/*
Conk creet baybee!
Should be able to be made without needing a chem machine!

Ground up sand/glass -> Silicon
Ground up limestone chunks -> Calcium carbonate (CaCO3)

Cement = Calcium carbonate (CaCO3) 6u + Silicon 3u + Iron 1u

Concrete = Cement 1u + Water 2u + Silicon 7u
*/

/////////////////////////////////
//Limestone (calcium carbonate)//
/////////////////////////////////
/datum/chemical_reaction/calciumcarbonate
	name = "calcium carbonate"
	id = "calciumcarbonate"
	results = list(/datum/reagent/calciumcarbonate = 5)
	required_reagents = list(/datum/reagent/consumable/milk = 1, /datum/reagent/carbon = 1, /datum/reagent/oxygen = 3,)
	required_temp = 375

/datum/reagent/calciumcarbonate
	name = "Calcium Carbonate"
	description = "Limestone's made out of this stuff!"
	color = "#E2D8CE"

/obj/item/stack/sheet/mineral/limestone
	name = "limestone chunks"
	icon_state = "sheet-limestone"
	singular_name = "limestone chunk"
	layer = LOW_ITEM_LAYER
	novariants = FALSE
	merge_type = /obj/item/stack/sheet/mineral/limestone
	grind_results = list(/datum/reagent/calciumcarbonate = 20)

/obj/item/stack/sheet/mineral/limestone/fifty
	amount = 50

/obj/item/stack/sheet/mineral/limestone/twenty
	amount = 20

/obj/item/stack/sheet/mineral/limestone/ten
	amount = 10

/obj/item/stack/sheet/mineral/limestone/five
	amount = 5


//////////
//Cement//
//////////
/datum/chemical_reaction/cement
	name = "cement"
	id = "cement"
	results = list(/datum/reagent/cement = 10)
	required_reagents = list(/datum/reagent/calciumcarbonate = 6, /datum/reagent/silicon = 3, /datum/reagent/iron = 1,)
	required_temp = 750 //Apparently cement clinker needs a ton of heat to be made. Adjust this maybe?

/datum/reagent/cement
	name = "Cement Powder"
	description = "One of the needed ingrediants to make concrete and concrete shakes!"
	color = "#A79E92"
	taste_description = "cement"

/datum/reagent/cement/on_mob_life(mob/living/carbon/M)
//Don't eat cement, kids!
	M.adjustOrganLoss(ORGAN_SLOT_STOMACH, 1*REAGENTS_EFFECT_MULTIPLIER, 150)
	M.adjustToxLoss(0.2*REAGENTS_EFFECT_MULTIPLIER, 0)
	M.adjustFireLoss(0.2*REAGENTS_EFFECT_MULTIPLIER, 0)
	..()

//////////////////
//Concrete Shake//
//////////////////
/datum/chemical_reaction/concreteshake
	name = "Concrete Shake"
	id = "concrete_shake"
	results = list(/datum/reagent/consumable/concreteshake = 5)
	required_reagents = list(/datum/reagent/consumable/milk = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/cement = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/cream = 1,)

/datum/reagent/consumable/concreteshake
	name = "Concrete Shake"
	description = "A mixture of icecream, milk and sugar along with... real cement powder?"
	color = "#A79E92"
	taste_description = "a bad idea"
	glass_icon_state = "concrete_shake"
	glass_name = "Concrete Shake"
	glass_desc = "A thickshake served with a straw and a spoon. The spoon seems stuck and drinking through the straw takes serious effort."


/datum/reagent/consumable/concreteshake/on_mob_life(mob/living/carbon/M)
//Don't eat cement, kids!
	M.adjustOrganLoss(ORGAN_SLOT_STOMACH, 1*REAGENTS_EFFECT_MULTIPLIER, 150)
	M.adjustToxLoss(0.2*REAGENTS_EFFECT_MULTIPLIER, 0)
	M.adjustFireLoss(0.2*REAGENTS_EFFECT_MULTIPLIER, 0)
	..()


////////////
//Concrete//
////////////
/datum/reagent/concrete
	name = "Concrete"
	description = "Concrete"
	color = "#A49483"

/datum/chemical_reaction/concrete
	name = "concrete"
	id = "concrete"
	required_reagents = list(/datum/reagent/cement = 1, /datum/reagent/water = 2, /datum/reagent/silicon = 7,)

/datum/chemical_reaction/concrete/on_reaction(datum/reagents/holder, multiplier)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to multiplier)
		new /obj/item/stack/sheet/mineral/concrete(location)
//Makes one concrete sheet

/datum/material/concrete
	name = "concrete"
	desc = "Concrete"
	color = "#A49483"
	sheet_type = /obj/item/stack/sheet/mineral/concrete

/obj/item/stack/sheet/mineral/concrete
	name = "concrete"
	icon_state = "sheet-concrete"
	singular_name = "concrete"
	layer = LOW_ITEM_LAYER
	novariants = FALSE
	merge_type = /obj/item/stack/sheet/mineral/concrete
	walltype = /turf/closed/wall/mineral/concrete

/obj/item/stack/sheet/mineral/concrete/fifty
	amount = 50

/obj/item/stack/sheet/mineral/concrete/ten
	amount = 10

/obj/item/stack/sheet/mineral/concrete/five
	amount = 5

/obj/item/stack/sheet/mineral/concrete/get_main_recipes()
	. = ..()
	. += GLOB.concrete_recipes

GLOBAL_LIST_INIT(concrete_recipes, list ( \
	new/datum/stack_recipe("concrete barricade", /obj/structure/barricade/concrete, 2, time = 30, one_per_turf = 1, on_floor = 1), \
	))

/////////
//WALLS//
/////////

//Supermart -> concrete on girder
//Store wall -> concrete on concrete barricade
//Barricade can't be removed with hands unlike sandbags, needs a welder

/turf/closed/wall/mineral/concrete
	name = "supermart wall"
	desc = "A pre-War supermart wall made of reinforced concrete. This one looks newly built"
	icon = 'icons/turf/walls/f13superstore.dmi'
	icon_state = "supermart"
	icon_type_smooth = "supermart"
	hardness = 90
	explosion_block = 2
	smooth = SMOOTH_TRUE
	sheet_type = /obj/item/stack/sheet/mineral/concrete
	canSmoothWith = list(/turf/closed/wall/f13/supermart, /turf/closed/wall/mineral/concrete, /turf/closed/wall,)

/turf/closed/wall/mineral/concrete/blastproof
	name = "fortified supermart wall"
	desc = "A pre-War supermart that has been coated with plastic to reduce cracking from overpressure."
	hardness = 80
	explosion_block = 5
	slicing_duration = 150 //50% longer than usual

/turf/closed/wall/mineral/concrete/attackby(obj/item/I, mob/user)
	if(istype(I,/obj/item/stack/sheet/plastic))
		var/obj/item/stack/sheet/plastic/C = I
		if(C.amount < 3)
			to_chat(user, "<span class='warning'>You need at least three plastic sheets to sheathe the wall!</span>")
			return
		to_chat(user, "<span class='notice'>You start adding [I] to [src]...</span>")
		if(do_after(user, 50, target=src))
			C.use(3)
			var/turf/T = get_turf(src)
			T.PlaceOnTop(/turf/closed/wall/mineral/concrete/blastproof)
			qdel(src)
		return
	else if(istype(I, /obj/item/weldingtool))
		if(!I.tool_start_check(user, amount=0))
			return

		if(I.use_tool(src, user, 60, volume=50))
			user.visible_message("[user] welds the [src] apart.", "You start to weld the [src] apart...")
			to_chat(user, "<span class='notice'>You weld the [src] apart.</span>")
			qdel(src)
			return
	return ..()
	
/obj/structure/barricade/concrete
	name = "concrete barricade"
	desc = "A small concrete barricade. Could be turned into a concrete wall with some more concrete."
	icon = 'icons/obj/fallout/concretebarricade.dmi'
	icon_state = "concrete_barricade"
	obj_integrity = 450
	max_integrity = 450 //170 integ stronger than sandbags.
	proj_pass_rate = 20
	pass_flags = LETPASSTHROW
	climbable = TRUE
	smooth = SMOOTH_TRUE

/obj/structure/barricade/concrete/attackby(obj/item/I, mob/user)
	if(istype(I,/obj/item/stack/sheet/mineral/concrete))
		var/obj/item/stack/sheet/mineral/concrete/C = I
		if(C.amount < 2)
			to_chat(user, "<span class='warning'>You need at least two concrete bags to make a wall!</span>")
			return
		to_chat(user, "<span class='notice'>You start adding [I] to [src]...</span>")
		if(do_after(user, 50, target=src))
			C.use(2)
			var/turf/T = get_turf(src)
			T.PlaceOnTop(/turf/closed/wall/f13/store/constructed)
			qdel(src)
		return
	else if(istype(I, /obj/item/weldingtool))
		if(!I.tool_start_check(user, amount=0))
			return

		if(I.use_tool(src, user, 60, volume=50))
			user.visible_message("[user] welds the [src] apart.", "You start to weld the [src] apart...")
			to_chat(user, "<span class='notice'>You weld the [src] apart.</span>")
			qdel(src)
			return

	return ..()

/turf/closed/wall/f13/store/constructed
	name = "store wall"
	desc = "A pre-War store wall made of solid concrete. This one looks newly built."
	icon = 'icons/turf/walls/f13store.dmi'
	icon_state = "store"
	icon_type_smooth = "store"
	hardness = 80
	smooth = SMOOTH_TRUE
	girder_type = /obj/structure/barricade/concrete
	sheet_type = null
	canSmoothWith = list(/turf/closed/wall/f13/store, /turf/closed/wall/f13/store/constructed, /turf/closed/wall,)
