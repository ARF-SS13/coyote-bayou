/datum/unit_test/stomach/Run()

	// Pause natural mob life so it can be handled entirely by the test
	SSmobs.pause()

	var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human)
	var/obj/item/reagent_containers/food/snacks/hotdog/fooditem = allocate(/obj/item/reagent_containers/food/snacks/hotdog)
	var/obj/item/organ/stomach/belly = human.getorganslot(ORGAN_SLOT_STOMACH)
	var/obj/item/reagent_containers/pill/pill = allocate(/obj/item/reagent_containers/pill)
	var/datum/reagent/medicine/stimulants/stim = /datum/reagent/medicine/stimulants

	TEST_ASSERT_EQUAL(human.has_reagent(/datum/reagent/consumable/ketchup), FALSE, "Human somehow has ketchup before eating")

	fooditem.attack(human, human)

	TEST_ASSERT(belly.reagents.has_reagent(/datum/reagent/consumable/ketchup), "Stomach doesn't have ketchup after eating")
	TEST_ASSERT_EQUAL(human.reagents.has_reagent(/datum/reagent/consumable/ketchup), FALSE, "Human body has ketchup after eating it should only be in the stomach")

	//Give them stimulants and let it kick in
	pill.reagents.add_reagent(stim, initial(stim.metabolization_rate) * 1.9)
	pill.attack(human, human)
	human.Life()

	TEST_ASSERT(human.reagents.has_reagent(stim), "Human body does not have stim after life tick")
	TEST_ASSERT(human.has_movespeed_modifier(/datum/movespeed_modifier/reagent/stimulants), "Human consumed stim, but did not gain movespeed modifier")

	belly.Remove(human)
	human.reagents.remove_all(human.reagents.total_volume)

	TEST_ASSERT_EQUAL(human.has_reagent(/datum/reagent/consumable/ketchup), FALSE, "Human has reagents after clearing")

	fooditem.attack(human, human)

	TEST_ASSERT_EQUAL(human.has_reagent(/datum/reagent/consumable/ketchup), FALSE, "Human has ketchup without a stomach")



/datum/unit_test/stomach/Destroy()
	SSmobs.ignite()
	return ..()
