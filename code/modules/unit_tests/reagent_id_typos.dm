

/datum/unit_test/reagent_id_typos

/datum/unit_test/reagent_id_typos/Run()
	build_chemical_reactions_list()
	build_chemical_reagent_list()

	for(var/I in GLOB.chemical_reactions_list)
		for(var/V in GLOB.chemical_reactions_list[I])
			var/datum/chemical_reaction/R = V
			for(var/id in (R.required_reagents + R.required_catalysts))
				if(!GLOB.chemical_reagents_list[id])
					Fail("Unknown chemical id \"[id]\" in recipe [R.type]")
	
	for (var/type in subtypesof(/obj/item/reagent_containers/food/))
		var/obj/item/reagent_containers/food/item = new type()
		for(var/id in item.list_reagents)
			if(!GLOB.chemical_reagents_list[id])
				Fail("Unknown chemical id \"[id]\" in list_reagents on [type]")
		if(istype(item, /obj/item/reagent_containers/food/snacks))
			var/obj/item/reagent_containers/food/snacks/snackitem = item
			for(var/id in snackitem.bonus_reagents)
				if(!GLOB.chemical_reagents_list[id])
					Fail("Unknown chemical id \"[id]\" in bonus_reagents on [type]")
		qdel(item)
