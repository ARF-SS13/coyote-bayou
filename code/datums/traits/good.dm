GLOBAL_LIST_INIT(chemwhiz_recipes, list(
	/datum/crafting_recipe/jet,
	/datum/crafting_recipe/turbo,
	/datum/crafting_recipe/psycho,
	/datum/crafting_recipe/medx,
	/datum/crafting_recipe/medx/chemistry,
	/datum/crafting_recipe/stimpak,
	/datum/crafting_recipe/stimpak/chemistry,
	/datum/crafting_recipe/stimpak5,
	/datum/crafting_recipe/stimpak5/chemistry,
	/datum/crafting_recipe/superstimpak,
	/datum/crafting_recipe/superstimpak5,
	/datum/crafting_recipe/buffout,
	/datum/crafting_recipe/steady))

GLOBAL_LIST_INIT(basic_explosive_recipes, list(
	/datum/crafting_recipe/frag_shrapnel,
	/datum/crafting_recipe/stinger,
	/datum/crafting_recipe/flashbang,
	/datum/crafting_recipe/smokebomb,
	/datum/crafting_recipe/rocket_base,
	/datum/crafting_recipe/weakrocket))

GLOBAL_LIST_INIT(adv_explosive_recipes, list(
	/datum/crafting_recipe/incendiary,
	/datum/crafting_recipe/concussion,
	/datum/crafting_recipe/radgrenade,
	/datum/crafting_recipe/empgrenade,
	/datum/crafting_recipe/incendiaryrocket,
	/datum/crafting_recipe/strongrocket))

GLOBAL_LIST_INIT(weaponcrafting_gun_recipes, list(
	/datum/crafting_recipe/ninemil,
	/datum/crafting_recipe/huntingrifle,
	/datum/crafting_recipe/n99,
	/datum/crafting_recipe/huntingrifle,
	/datum/crafting_recipe/m1911,
	/datum/crafting_recipe/varmintrifle,
	/datum/crafting_recipe/autoaxe,
	/datum/crafting_recipe/steelsaw,
	/datum/crafting_recipe/tools/forged/entrenching_tool,
	/datum/crafting_recipe/chainsaw,
	/datum/crafting_recipe/steeltower,
	/datum/crafting_recipe/durathread_vest))


//predominantly positive traits
//this file is named weirdly so that positive traits are listed above negative ones

/datum/quirk/alcohol_tolerance
	name = "Alcohol Tolerance"
	desc = "You become drunk more slowly and suffer fewer drawbacks from alcohol."
	value = 1
	mob_trait = TRAIT_ALCOHOL_TOLERANCE
	gain_text = span_notice("You feel like you could drink a whole keg!")
	lose_text = span_danger("You don't feel as resistant to alcohol anymore. Somehow.")
	medical_record_text = "Patient demonstrates a high tolerance for alcohol."

/datum/quirk/horrifying_tastes
	name = "Cannibal"
	desc = "You eat people. Consuming human flesh doesn't bother you, and dishes such as longpork stew will heal you. Probably don't tell your neighbor."
	mob_trait = TRAIT_LONGPORKLOVER
	value = 1
	gain_text = span_notice("You have an insatiable hunger for the flesh of your fellow man.")
	lose_text = span_notice("The terrible hunger fades - you feel peace at last.")
	medical_record_text = "Patient refuses to comment on their dietary preferences."

/datum/quirk/horrifying_tastes/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food |= LONGPORK
	species.disliked_food &= ~LONGPORK

/datum/quirk/horrifying_tastes/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food &= ~LONGPORK
		species.disliked_food |= LONGPORK

/datum/quirk/tribal
	name = "Former Tribal"
	desc = "You used to be part of one of the tribes scattered throughout the wasteland. You may have some additional skills as a result. Allowing you to make some tribal medical supplies. Advanced tech still confuses you though."
	value = 1
	gain_text = span_notice("You remember the old ways of your tribe..")
	lose_text = span_notice("You've forgotten the ways of your ancestors..")

/datum/quirk/tribal/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_MACHINE_SPIRITS, "Former Tribal")
	ADD_TRAIT(H, TRAIT_TRIBAL, "Former Tribal")

/datum/quirk/tribal/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_MACHINE_SPIRITS, "Former Tribal")
		REMOVE_TRAIT(H, TRAIT_TRIBAL, "Former Tribal")

/datum/quirk/apathetic
	name = "Apathetic"
	desc = "You just don't care as much as other people. That's nice to have in a place like this, I guess."
	value = 1
	mood_quirk = TRUE
	medical_record_text = "Patient was administered the Apathy Evaluation Scale but did not bother to complete it."

/datum/quirk/apathetic/add()
	var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
	if(mood)
		mood.mood_modifier = 0.8

/datum/quirk/apathetic/remove()
	if(quirk_holder)
		var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
		if(mood)
			mood.mood_modifier = 1 //Change this once/if species get their own mood modifiers.

/datum/quirk/drunkhealing
	name = "Drunken Resilience"
	desc = "Nothing like a good drink to make you feel on top of the world. Whenever you're drunk, you slowly recover from damage. Not wounds or bloodloss though."
	value = 1
	mob_trait = TRAIT_DRUNK_HEALING
	gain_text = span_notice("You feel like a drink would do you good.")
	lose_text = span_danger("You no longer feel like drinking would ease your pain.")
	medical_record_text = "Patient has unusually efficient liver metabolism and can slowly regenerate wounds by drinking alcoholic beverages."

/datum/quirk/empath
	name = "Empath"
	desc = "Whether it's a sixth sense or careful study of body language, it only takes you a quick glance at someone to understand how they feel. This lets you see their mood, damage, and intent. As well as seeing if they're experience oxyloss/toxloss and if they're in a high or low mood."
	value = 1
	mob_trait = TRAIT_EMPATH
	gain_text = span_notice("You feel in tune with those around you.")
	lose_text = span_danger("You feel isolated from others.")
	medical_record_text = "Patient is highly perceptive of and sensitive to social cues, or may possibly have ESP. Further testing needed."

/datum/quirk/freerunning
	name = "Freerunning"
	desc = "You're great at quick moves! You climb tables more quickly and land gracefully when falling from one floor up."
	value = 1
	mob_trait = TRAIT_FREERUNNING
	gain_text = span_notice("You feel lithe on your feet!")
	lose_text = span_danger("You feel clumsy again.")
	medical_record_text = "Patient scored highly on cardio tests."

/datum/quirk/friendly
	name = "Friendly"
	desc = "You give the best hugs. When you're in the right mood your squeezes can cheer up those around you. Unless they don't, but that's okay. :)"
	value = 1
	mob_trait = TRAIT_FRIENDLY
	gain_text = span_notice("You want to hug someone.")
	lose_text = span_danger("You no longer feel compelled to hug others.")
	mood_quirk = TRUE
	medical_record_text = "Patient demonstrates low-inhibitions for physical contact and well-developed arms. Requesting another doctor take over this case."

/datum/quirk/jolly
	name = "Mood - Sanguine"
	desc = "You sometimes just feel happy, for no reason at all. Gives mood buffs, occasionally."
	value = 2
	mob_trait = TRAIT_JOLLY
	mood_quirk = TRUE
	medical_record_text = "Patient demonstrates constant euthymia irregular for environment. It's a bit much, to be honest."

/datum/quirk/jolly/on_process()
	if(prob(0.05))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "jolly", /datum/mood_event/jolly)

/datum/quirk/optimist
	name = "Mood - Optimist"
	desc = "You sometimes just feel kind of happy, for no reason at all. Gives small mood buffs, occasionally."
	value = 1
	mob_trait = TRAIT_OPTIMIST
	mood_quirk = TRUE
	medical_record_text = "Patient demonstrates occasional euthymia irregular for environment. Lucky them."

/datum/quirk/optimist/on_process()
	if(prob(0.05))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "optimist", /datum/mood_event/optimism)


/datum/quirk/light_step
	name = "Light Step"
	desc = "You walk with a gentle step; stepping on sharp objects is quieter, less painful and you won't leave footprints behind you."
	value = 1
	mob_trait = TRAIT_LIGHT_STEP
	gain_text = span_notice("You walk with a little more litheness.")
	lose_text = span_danger("You start tromping around like a barbarian.")
	medical_record_text = "Patient's dexterity belies a strong capacity for stealth."


/datum/quirk/quick_step
	name = "Speed Walker"
	desc = "You walk with determined strides, and out-pace most people, at least, if you're both walking."
	value = 1
	mob_trait = TRAIT_SPEEDY_STEP
	gain_text = span_notice("You feel determined. No time to lose.")
	lose_text = span_danger("You feel less determined. What's the rush, man?")
	medical_record_text = "Patient scored highly on racewalking tests."


/datum/quirk/musician
	name = "Musician"
	desc = "You can tune instruments to play melodies that clear certain negative effects and soothe the soul and even get one of your choice for free!"
	value = 1
	mob_trait = TRAIT_MUSICIAN
	gain_text = span_notice("You know everything about musical instruments.")
	lose_text = span_danger("You forget how musical instruments work.")
	medical_record_text = "Patient brain scans show a highly-developed auditory pathway."

/datum/quirk/musician/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/choice_beacon/music/B = new(get_turf(H))
	H.put_in_hands(B)
	H.equip_to_slot_if_possible(B, SLOT_IN_BACKPACK)
	var/obj/item/musicaltuner/musicaltuner = new(get_turf(H))
	H.put_in_hands(musicaltuner)
	H.equip_to_slot_if_possible(musicaltuner, SLOT_IN_BACKPACK)
	H.regenerate_icons()

/datum/quirk/photographer
	name = "Photographer"
	desc = "You know how to handle a camera, shortening the delay between each shot."
	value = 0
	mob_trait = TRAIT_PHOTOGRAPHER
	gain_text = span_notice("You know everything about photography.")
	lose_text = span_danger("You forget how photo cameras work.")
	medical_record_text = "Patient mentions photography as a stress-relieving hobby."

/datum/quirk/photographer/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/camera/camera = new(get_turf(H))
	H.put_in_hands(camera)
	H.equip_to_slot(camera, SLOT_NECK)
	H.regenerate_icons()

/datum/quirk/selfaware
	name = "Self-Aware"
	desc = "You know your body well, and can accurately assess the extent of your wounds. Sort of like being a medical scanner for yourself."
	value = 1
	mob_trait = TRAIT_SELF_AWARE
	medical_record_text = "Patient demonstrates an uncanny knack for self-diagnosis."

/datum/quirk/skittish
	name = "Skittish"
	desc = "You can conceal yourself in danger. Ctrl-shift-click a closed locker to jump into it, as long as you have access."
	value = 1
	mob_trait = TRAIT_SKITTISH
	medical_record_text = "Patient demonstrates a high aversion to danger and has described hiding in containers out of fear."

/datum/quirk/spiritual
	name = "Spiritual"
	desc = "You're in tune with the gods, and your prayers may be more likely to be heard. Or not."
	value = 0
	mob_trait = TRAIT_SPIRITUAL
	gain_text = span_notice("You feel a little more faithful to the gods today.")
	lose_text = span_danger("You feel less faithful in the gods.")
	medical_record_text = "Patient reports a belief in a higher power."

/datum/quirk/tagger
	name = "Tagger"
	desc = "You're an experienced artist. While drawing graffiti, you can get twice as many uses out of drawing supplies."
	value = 0
	mob_trait = TRAIT_TAGGER
	gain_text = span_notice("You know how to tag walls efficiently.")
	lose_text = span_danger("You forget how to tag walls properly.")
	medical_record_text = "Patient was recently seen for possible paint huffing incident."

/datum/quirk/tagger/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/toy/crayon/spraycan/spraycan = new(get_turf(H))
	H.put_in_hands(spraycan)
	H.equip_to_slot(spraycan, SLOT_IN_BACKPACK)
	H.regenerate_icons()

/datum/quirk/technophreak
	name = "Technophreak"
	desc = "You're skilled at breaking down old-war rubble more precisely and therefor you gain more salvage from cars and piles than before."
	value = 2
	mob_trait = TRAIT_TECHNOPHREAK
	gain_text = span_notice("Old-War rubble seems considerably more generous to you.")
	lose_text = span_danger("Old-War rubble suddenly seems less generous to you.")

/datum/quirk/gunsmith
	name = "Weaponsmith"
	desc = "You know how to make various weapons and protective vests. The list is too large to try and put here."
	value = 2
	gain_text = span_notice("You are adept at crafting makeshift weapons.")
	lose_text = span_danger("You seem less adept at crafting makeshift weapons.")

/datum/quirk/gunsmith/add()
	var/mob/living/carbon/human/H = quirk_holder
	// I made the quirks add the same recipes as the trait books. Feel free to nerf this
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.weaponcrafting_gun_recipes

/datum/quirk/gunsmith/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.mind.learned_recipes -= GLOB.weaponcrafting_gun_recipes

/datum/quirk/voracious
	name = "Bottomless Stomach"
	desc = "Nothing gets between you and your food. You eat twice as fast as everyone else!"
	value = 1
	mob_trait = TRAIT_VORACIOUS
	gain_text = span_notice("You feel HONGRY.")
	lose_text = span_danger("You no longer feel HONGRY.")
	medical_record_text = "Patient demonstrates a disturbing capacity for eating."

/datum/quirk/bloodpressure
	name = "Extra Blood"
	desc = "You've a treated form of Polycythemia vera that increases the total blood volume inside of you as well as the rate of replenishment!"
	value = 2 //I honeslty dunno if this is a good trait? I just means you use more of medbays blood and make janitors madder, but you also regen blood a lil faster.
	mob_trait = TRAIT_HIGH_BLOOD
	gain_text = span_notice("You feel full of blood!")
	lose_text = span_notice("You feel like your blood pressure went down.")
	medical_record_text = "Patient's blood tests report an abnormal concentration of red blood cells in their bloodstream."

/datum/quirk/bloodpressure/add()
	quirk_holder.blood_ratio = 1.2
	quirk_holder.blood_volume += 150

/datum/quirk/bloodpressure/remove()
	if(quirk_holder)
		quirk_holder.blood_ratio = 1

/datum/quirk/tribal_tech
	name = "Primitive Tech"
	desc = "You're able to use primitive technology."
	value = 1
	mob_trait = TRAIT_MACHINE_SPIRITS
	gain_text = span_notice("You are now able to use primitive technology.")
	lose_text = span_danger("You are no longer able to use primitive technology.")
	locked = TRUE

/datum/quirk/night_vision
	name = "Night Vision"
	desc = "You can see slightly more clearly in full darkness than most people by one more whole tile."
	value = 1
	mob_trait = TRAIT_NIGHT_VISION
	gain_text = span_notice("The shadows seem a little less dark.")
	lose_text = span_danger("Everything seems a little darker.")


/datum/quirk/night_vision/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.update_sight()

/datum/quirk/nukalover
	name = "Nuka Fiend"
	desc = "You are a fan of America's most popular pre-war soft drink. Your body simply loves the sugary drink so much, it rejects healthier alternatives. Nuka Cola heals you, sort of."
	value = 1
	mob_trait = TRAIT_NUKA_LOVER
	gain_text = span_notice("You want to buy the whole world a nuka-cola!")
	lose_text = span_danger("What's the big deal about nuka-cola?")
	medical_record_text = "Patient has an addiction to the soft drink Nuka-Cola. Somehow, their metabolism has adapted to the sugars and artifical flavorings."

/datum/quirk/nukalover/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food |= NUKA
	species.disliked_food |= VEGETABLES

/datum/quirk/nukalover/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food = initial(species.liked_food)
		species.disliked_food = initial(species.disliked_food)

/datum/quirk/trapper
	name = "Trapper"
	desc = "As an experienced hunter and trapper you know your way around butchering animals for their products, and are able to get twice the usable materials by eliminating waste."
	value = 1
	mob_trait = TRAIT_TRAPPER
	gain_text = span_notice("You learn the secrets of butchering!")
	lose_text = span_danger("You forget how to slaughter animals.")
	locked = FALSE

/datum/quirk/bigleagues
	name = "Melee - Big Leagues"
	desc = "Swing for the fences! You deal even more additional damage with melee weapons."
	value = 3
	mob_trait = TRAIT_BIG_LEAGUES
	gain_text = span_notice("You feel like swinging for the fences!")
	lose_text = span_danger("You feel like bunting.")
	locked = FALSE

/datum/quirk/littleleagues
	name = "Melee - Little Leagues"
	desc = "Swing for the outfield! You deal additional damage with melee weapons."
	value = 1
	mob_trait = TRAIT_LITTLE_LEAGUES
	gain_text = span_notice("You feel like swinging for the outfield!")
	lose_text = span_danger("You feel like skipping practice.")
	locked = FALSE

/datum/quirk/chemwhiz
	name = "Chem Whiz"
	desc = "You've been playing around with chemicals all your life. You know how to use chemistry machinery."
	value = 3
	mob_trait = TRAIT_CHEMWHIZ
	gain_text = span_notice("The mysteries of chemistry are revealed to you.")
	lose_text = span_danger("You forget how the periodic table works.")
	locked =  FALSE

/datum/quirk/chemwhiz/add()
	var/mob/living/carbon/human/H = quirk_holder
	// I made the quirks add the same recipes as the trait books. Feel free to nerf this
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.chemwhiz_recipes

/datum/quirk/chemwhiz/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.mind.learned_recipes -= GLOB.chemwhiz_recipes


/datum/quirk/pa_wear
	name = "Power Armor Training"
	desc = "You've been around the wastes and have learned the wonders of wearing high tech armor from somewhere or something."
	value = 2
	mob_trait = TRAIT_PA_WEAR
	gain_text = span_notice("You realize how to use Power Armor.")
	lose_text = span_danger("You forget how Power Armor works.")
	locked = FALSE

/datum/quirk/hard_yards
	name = "Mobility - Wasteland Trekker"
	desc = "You've spent a lot of time wandering the wastes, and for your hard work you out pace most folks when travelling across them."
	value = 3
	mob_trait = TRAIT_HARD_YARDS
	gain_text = span_notice("Rain or shine, nothing slows you down.")
	lose_text = span_danger("You walk with a less sure gait, the ground seeming less firm somehow.")
	locked = FALSE

/datum/quirk/soft_yards
	name = "Mobility - Wasteland Wanderer"
	desc = "You've spent some time in the wastes, and can move a bit better around them for it."
	value = 2
	mob_trait = TRAIT_SOFT_YARDS
	gain_text = span_notice("Rain or shine only slow you down a little.")
	lose_text = span_danger("You walk with a less sure gait, the ground seeming less firm somehow.")
	locked = FALSE

/datum/quirk/lifegiver
	name = "Health - Tough"
	desc = "You embody wellness! Instantly gain +10 maximum Health."
	value = 1
	mob_trait = TRAIT_LIFEGIVER
	gain_text = span_notice("You feel more healthy than usual.")
	lose_text = span_danger("You feel less healthy than usual.")
	medical_record_text = "Patient has higher capacity for injury."
	locked = FALSE

/datum/quirk/lifegiver/on_spawn()
	var/mob/living/carbon/human/mob_tar = quirk_holder
	mob_tar.maxHealth += 10
	mob_tar.health += 10

/datum/quirk/lifegiverplus
	name = "Health - Tougher"
	desc = "You embody wellness to the MAX! Instantly gain +20 maximum Health."
	value = 3
	mob_trait = TRAIT_LIFEGIVERPLUS
	gain_text = span_notice("You feel much more healthy than usual.")
	lose_text = span_danger("You feel much less healthy than usual.")
	medical_record_text = "Patient has much higher capacity for injury."
	locked = FALSE

/datum/quirk/lifegiver/on_spawn()
	var/mob/living/carbon/human/mob_tar = quirk_holder
	mob_tar.maxHealth += 20
	mob_tar.health += 20

/datum/quirk/iron_fist
	name = "Fists of Iron"
	desc = "You have fists of kung-fury! Increases unarmed damage."
	value = 1
	mob_trait = TRAIT_IRONFIST
	gain_text = span_notice("Your fists feel furious!")
	lose_text = span_danger("Your fists feel calm again.")
	locked = FALSE

/datum/quirk/iron_fist/on_spawn()
	var/mob/living/carbon/human/mob_tar = quirk_holder
	mob_tar.dna.species.punchdamagelow = 6
	mob_tar.dna.species.punchdamagehigh = 12

/datum/quirk/steel_fist
	name = "Fists of Steel"
	desc = "You have MASSIVE fists of kung-fury! Even MORE increases unarmed damage."
	value = 2
	mob_trait = TRAIT_STEELFIST
	gain_text = span_notice("Your fists feel MASSIVELY furious!")
	lose_text = span_danger("Your fists feel calm again, what a relief.")
	locked = FALSE

/datum/quirk/steel_fist/on_spawn()
	var/mob/living/carbon/human/mob_tar = quirk_holder
	mob_tar.dna.species.punchdamagelow = 10
	mob_tar.dna.species.punchdamagehigh = 16

/datum/quirk/light_step
	name = "Glass Walker"
	desc = "When it comes to stepping on glass, you're pretty die hard.  You'll make less noise when you do so, but it'd still suck without shoes."
	value = 1
	mob_trait = TRAIT_LIGHT_STEP
	gain_text = span_notice("You walk with a little more litheness.")
	lose_text = span_danger("You start tromping around like a barbarian.")

/datum/quirk/surgerylow
	name = "Minor Surgery"
	desc = "You are a somewhat adequate medical practicioner, capable of performing minor surgery in a pinch."
	value = 3
	mob_trait = TRAIT_SURGERY_LOW
	gain_text = span_notice("You feel yourself discovering the basics of the human body.")
	lose_text = span_danger("You forget how to perform even the simplest surgery.")
	locked = FALSE

/datum/quirk/explosive_crafting
	name = "Explosives Crafting"
	desc = "You have strong feelings about the future of industrial society."
	value = 1
	mob_trait = TRAIT_EXPLOSIVE_CRAFTING
	gain_text = span_notice("You feel like you can make a bomb out of anything.")
	lose_text = span_danger("You feel okay with the advancement of technology.")
	locked = FALSE

/datum/quirk/explosive_crafting/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	// I made the quirks add the same recipes as the trait books. Feel free to nerf this
	H.mind.learned_recipes |= GLOB.basic_explosive_recipes

/datum/quirk/explosive_crafting/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.mind.learned_recipes -= GLOB.basic_explosive_recipes

/datum/quirk/lick_heal
	name = "Soothing Saliva"
	desc = "Your saliva has a mild healing effect on burns and bruises. Use *lick to lick your injuries."
	value = 1
	mob_trait = TRAIT_HEAL_TONGUE
	gain_text = span_notice("You feel a slight tingle in your mouth.")
	lose_text = span_danger("The tingle in your mouth fades.")
	locked = FALSE

/datum/quirk/lick_heal/on_spawn()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/our_tongue = human_holder.getorganslot(ORGAN_SLOT_TONGUE)
	if(!our_tongue)
		return //welp
	our_tongue.lick_heal_brute = 1
	our_tongue.lick_heal_burn = 1

/datum/quirk/lick_heal/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/our_tongue = human_holder.getorganslot(ORGAN_SLOT_TONGUE)
	if(!our_tongue)
		return //welp
	our_tongue.lick_heal_brute = 0
	our_tongue.lick_heal_burn = 0

/datum/quirk/lick_bandage
	name = "Sanguine Saliva"
	desc = "Your saliva has a mild coagulating effect on open bleeding wounds. Use *lick to lick your lacerations."
	value = 2
	mob_trait = TRAIT_BANDAGE_TONGUE
	gain_text = span_notice("Your mouth feels a bit gummy.")
	lose_text = span_danger("The gumminess in your mouth fades.")
	locked = FALSE

/datum/quirk/lick_bandage/on_spawn()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/our_tongue = human_holder.getorganslot(ORGAN_SLOT_TONGUE)
	if(!our_tongue)
		return //welp
	our_tongue.initialize_bandage(/obj/item/stack/medical/gauze/lick)

/datum/quirk/lick_bandage/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/our_tongue = human_holder.getorganslot(ORGAN_SLOT_TONGUE)
	if(!our_tongue)
		return //welp
	QDEL_NULL(our_tongue.lick_bandage)

/datum/quirk/advanced_explosive_crafting
	name = "Advanced Explosive Crafting"
	desc = "Decades of engineering knowledge have taught you to make all kinds of horrible explosives."
	value = 1
	mob_trait = TRAIT_ADVANCED_EXPLOSIVE_CRAFTING
	gain_text = span_notice("You're on the no-fly list.'")
	lose_text = "<span class='danger'>You feel like you're allowed to fly on planes again.</span>"
	locked = TRUE

/datum/quirk/advanced_explosive_crafting/add()
	var/mob/living/carbon/human/H = quirk_holder
	// I made the quirks add the same recipes as the trait books. Feel free to nerf this
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.basic_explosive_recipes
	H.mind.learned_recipes |= GLOB.adv_explosive_recipes

/datum/quirk/advanced_explosive_crafting/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.mind.learned_recipes -= GLOB.basic_explosive_recipes
		H.mind.learned_recipes -= GLOB.adv_explosive_recipes


/datum/quirk/whitelegstraditions
	name = "White Legs traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 1
	mob_trait = TRAIT_WHITELEGS_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/deadhorsestraditions
	name = "Dead Horses traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 1
	mob_trait = TRAIT_DEADHORSES_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/rustwalkerstraditions
	name = "Rust Walkers traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 1
	mob_trait = TRAIT_RUSTWALKERS_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/eightiestraditions
	name = "Eighties traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 1
	mob_trait = TRAIT_EIGHTIES_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/sorrowstraditions
	name = "Sorrows traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 1
	mob_trait = TRAIT_SORROWS_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/wayfarertraditions
	name = "Wayfarer traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 1
	mob_trait = TRAIT_WAYFARER_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/bonedancertraditions
	name = "Bone Dancer traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 1
	mob_trait = TRAIT_BONEDANCER_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/brickwall
	name = "Brick wall"
	desc = "You just don't move when people try to push you out of the way, for whatever reason."
	value = 1
	mob_trait = TRAIT_PUSHIMMUNE
	gain_text = span_notice("You feel stronger than a brick wall.")
	lose_text = span_danger("Your feel like you could get thrown down again.")
	locked =  FALSE

/datum/quirk/heatresist
	name = "Heat Resistant"
	desc = "Heat doesn't bother you too much."
	value = 1
	mob_trait = TRAIT_RESISTHEAT
	gain_text = span_notice("It could be a little warmer in here.")
	lose_text = span_danger("You know? Being hot kind of sucks actually.")
	locked =  FALSE

/datum/quirk/coldresist
	name = "Cold Resistant"
	desc = "Cold doesn't bother you too much."
	value = 1
	mob_trait = TRAIT_RESISTCOLD
	gain_text = span_notice("It could be a little colder in here.")
	lose_text = span_danger("You know? Being cold kind of sucks actually.")
	locked =  FALSE

/datum/quirk/radimmune
	name = "Radiation - Immune"
	desc = "Gieger Counters are for suckers."
	value = 5
	mob_trait = TRAIT_RADIMMUNE
	gain_text = span_notice("You've decided radiation just doesn't matter.")
	lose_text = span_danger("You no longer feel like you could probably live in a microwave while its on.")
	locked =  FALSE

/datum/quirk/radimmuneish
	name = "Radiation - Mostly Immune"
	desc = "Gieger Counters are for suckers, mostly."
	value = 4
	mob_trait = TRAIT_75_RAD_RESIST
	gain_text = span_notice("You've decided radiation just doesn't matter much.")
	lose_text = span_danger("You no longer feel like you could roll around in a rad puddle for a while.")
	locked =  FALSE

/datum/quirk/radimmunesorta
	name = "Radiation - Sorta Immune"
	desc = "Gieger Counters are for suckers, sorta."
	value = 3
	mob_trait = TRAIT_50_RAD_RESIST
	gain_text = span_notice("You've decided radiation only kind of matters.")
	lose_text = span_danger("You no longer think you should hang out next to rad puddles.")
	locked =  FALSE

/datum/quirk/nohunger
	name = "Does not Eat"
	desc = "You don't need to eat to live, lucky you."
	value = 4
	mob_trait = TRAIT_NOHUNGER
	gain_text = span_notice("Your need for food has left you.")
	lose_text = span_danger("GOD YOU WANT A BURGER SO BAD.")
	locked =  FALSE

/datum/quirk/thickskin
	name = "Thick Skin"
	desc = "You just don't get splinters, or shrapnel for that matter.  MASSIVE UNINTENDED EFFECTS, BEING REWORKED~TK"
	value = 3
	mob_trait = TRAIT_PIERCEIMMUNE
	gain_text = span_notice("Your skin feels way stronger.")
	lose_text = span_danger("You feel like your skin is about as tough as tissue paper.")
	locked =  TRUE

/datum/quirk/quickercarry
	name = "Quicker Carry"
	desc = "You're real good at just scooping people up."
	value = 2
	mob_trait = TRAIT_QUICKER_CARRY
	gain_text = span_notice("You feel like a MASTER fireman!")
	lose_text = span_danger("You're ability to carry folk seems massively diminished.")
	locked =  FALSE

/datum/quirk/quickcarry
	name = "Quick Carry"
	desc = "You're better than most at just scooping people up."
	value = 1
	mob_trait = TRAIT_QUICK_CARRY
	gain_text = span_notice("You feel like an ACCEPTABLE fireman!")
	lose_text = span_danger("You're ability to carry folk seems a bit diminished.")
	locked =  FALSE

/datum/quirk/builder
	name = "Experienced Builder"
	desc = "You're good at putting stuff together!"
	value = 1
	mob_trait = TRAIT_QUICK_BUILD
	gain_text = span_notice("You could throw up a house if you wanted to!")
	lose_text = span_danger("What's a two by four again?")
	locked =  FALSE

/datum/quirk/grappler
	name = "Trained Grappler"
	desc = "You've got real skills when it comes to grabbing people by the bits!"
	value = 2
	mob_trait = TRAIT_STRONG_GRABBER
	gain_text = span_notice("You could wrassle a deathclaw!!")
	lose_text = span_danger("You no longer feel like you should wrestle deathclaws.")
	locked =  FALSE

/datum/quirk/mastermartialartist
	name = "Master Martial Artist"
	desc = "Sometimes you hit so hard you're pretty sure they stop being human!"
	value = 4
	mob_trait = TRAIT_KI_VAMPIRE
	gain_text = span_notice("They are already dead.")
	lose_text = span_danger("Your fists no longer feel so powerful.")
	locked =  FALSE

/datum/quirk/surestrike
	name = "Sure Strike"
	desc = "Your technique for punching has been perfected! Your punches always do MAX damage!"
	value = 4
	mob_trait = TRAIT_PERFECT_ATTACKER
	gain_text = span_notice("They are already dead.")
	lose_text = span_danger("Your fists no longer feel so powerful.")
	locked =  FALSE

/datum/quirk/quietstep
	name = "Quiet Step"
	desc = "Your steps just don't make any noise at all."
	value = 3
	mob_trait = TRAIT_SILENT_STEP
	gain_text = span_notice("Your footsteps fade away.")
	lose_text = span_danger("You're pretty sure that's the sound of your asscheeks clapping, but it might be footsteps.")
	locked =  FALSE

/datum/quirk/deadeye
	name = "Dead Eye"
	desc = "You hit the shots you aim. No ifs, ands, or buts."
	value = 12 //WIP for sure, lmfao ~TK
	mob_trait = TRAIT_INSANE_AIM
	gain_text = span_notice("Your aim is legendary, and you know it.")
	lose_text = span_danger("Your aim could use some work...")
	locked =  FALSE

/datum/quirk/straightshooter
	name = "Straight Shooter"
	desc = "You're a better than average shot."
	value = 6
	mob_trait = TRAIT_NICE_SHOT
	gain_text = span_notice("Your aim is amazing, and you know it.")
	lose_text = span_danger("Your aim could use some work...")
	locked =  FALSE

/datum/quirk/bowtrained
	name = "Bow Trained"
	desc = "You've trained quite a bit with bows of many types, and are pretty good with them for it."
	value = 2
	mob_trait = TRAIT_AUTO_DRAW
	gain_text = span_notice("You feel like all that training with bows has paidfuzzz off.")
	lose_text = span_danger("Guns were always better...")
	locked =  FALSE

/datum/quirk/masterrifleman
	name = "Bolt Worker"
	desc = "You've spent a lot of time working the bolt of a rifle, or the pump action of a shotgun. Your skill allows you to click to work the action instead of doing it manually."
	value = 2
	mob_trait = TRAIT_FAST_PUMP
	gain_text = span_notice("In a sudden haze you realize that the Mosin Nagant was Gods gift to mankind.")
	lose_text = span_danger("After picking some 250 year old cosmoline out from under one of your nails you realize that... Uh, no, the Mosin Nagant is a piece of shit.")
	locked =  FALSE
