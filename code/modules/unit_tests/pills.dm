/datum/unit_test/pills/Run()
	var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human)
	var/obj/item/reagent_containers/pill/charcoal/pill = allocate(/obj/item/reagent_containers/pill/charcoal)

	TEST_ASSERT_EQUAL(human.has_reagent(/datum/reagent/medicine/charcoal), FALSE, "Human somehow has charcoal before taking pill")

	pill.attack(human, human)
	human.Life()

	TEST_ASSERT(human.has_reagent(/datum/reagent/medicine/charcoal), "Human doesn't have charcoal after taking pill")
