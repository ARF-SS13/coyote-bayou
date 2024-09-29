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

GLOBAL_LIST_INIT(minelaying_recipe, list(
	/datum/crafting_recipe/explosive/shrapnelmine,
	/datum/crafting_recipe/explosive/explomine,
	/datum/crafting_recipe/explosive/stingmine,
	/datum/crafting_recipe/explosive/pulsemine,
	/datum/crafting_recipe/explosive/stunmine))

GLOBAL_LIST_INIT(tier_three_parts, list(
	/datum/crafting_recipe/pico_manip,
	/datum/crafting_recipe/super_matter_bin,
	/datum/crafting_recipe/phasic_scanning,
	/datum/crafting_recipe/super_capacitor,
	/datum/crafting_recipe/ultra_micro_laser))

GLOBAL_LIST_INIT(energyweapon_cell_crafting, list(
	/datum/crafting_recipe/enhancedenergycell,
	/datum/crafting_recipe/enhancedmfcell,
	/datum/crafting_recipe/enhancedecp))

	// armored_hazard_suit is going to get SEVA Mk. 2 and Explorer Mk. 2 in the future. Might tie it to Hardsuits as well.
GLOBAL_LIST_INIT(armored_hazard_suit, list(
	/datum/crafting_recipe/combathazardsuit,
	/datum/crafting_recipe/combathazardhood))

GLOBAL_LIST_INIT(weaponcrafting_gun_recipes, list(
	/datum/crafting_recipe/ninemil,
	/datum/crafting_recipe/huntingrifle,
	/datum/crafting_recipe/n99,
	/datum/crafting_recipe/huntingshotgun,
	/datum/crafting_recipe/m1911,
	/datum/crafting_recipe/varmintrifle,
	/datum/crafting_recipe/salvaged_eastern_rifle,
	/datum/crafting_recipe/autoaxe,
	/datum/crafting_recipe/steelsaw,
	/datum/crafting_recipe/tools/forged/entrenching_tool,
	/datum/crafting_recipe/chainsaw,
	/datum/crafting_recipe/steeltower,
	/datum/crafting_recipe/durathread_vest,
	/datum/crafting_recipe/ecpbad,
	/datum/crafting_recipe/mfcbad,
	/datum/crafting_recipe/ecbad,
	/datum/crafting_recipe/gun/flintlock,
	/datum/crafting_recipe/gun/flintlock_laser,
	/datum/crafting_recipe/sharpener))

GLOBAL_LIST_INIT(former_tribal_recipes, list(
	///datum/crafting_recipe/tribal/bonetalisman, //broken item, unneeded
	/datum/crafting_recipe/spearfisher,
	/datum/crafting_recipe/bitterdrink,
	/datum/crafting_recipe/bitterdrink5,
	/datum/crafting_recipe/healpoultice,
	/datum/crafting_recipe/healpoultice5,
	/datum/crafting_recipe/redambrosia,
	/datum/crafting_recipe/blueambrosia,
	/datum/crafting_recipe/greenambrosia,
	/datum/crafting_recipe/food/pemmican,
	/datum/crafting_recipe/tribal/bonebag,
	/datum/crafting_recipe/warpaint,
	/datum/crafting_recipe/horsecream_good))

GLOBAL_LIST_INIT(rustwalkers_traditions_recipes, list(
	/datum/crafting_recipe/tribalwar/rustwalkers/lightarmour,
	/datum/crafting_recipe/tribalwar/rustwalkers/armour,
	/datum/crafting_recipe/tribalwar/rustwalkers/heavyarmour,
	/datum/crafting_recipe/tribalwar/rustwalkers/garb,
	/datum/crafting_recipe/tribalwar/rustwalkers/femalegarb))

GLOBAL_LIST_INIT(bonedancer_traditions_recipes, list(
	/datum/crafting_recipe/tribalwar/bone/lightarmour,
	/datum/crafting_recipe/tribalwar/bone/armour,
	/datum/crafting_recipe/tribalwar/bone/heavyarmour,
	/datum/crafting_recipe/tribalwar/bone/garb,
	/datum/crafting_recipe/tribalwar/bone/helmet))

GLOBAL_LIST_INIT(eighties_traditions_recipes, list(
	/datum/crafting_recipe/tribalwar/eighties/lightarmour,
	/datum/crafting_recipe/tribalwar/eighties/armour,
	/datum/crafting_recipe/tribalwar/eighties/heavyarmour,
	/datum/crafting_recipe/tribalwar/eighties/garb,
	/datum/crafting_recipe/tribalwar/eighties/femalegarb))

GLOBAL_LIST_INIT(energyweapon_crafting, list(
	/datum/crafting_recipe/aer9_hotwired))

GLOBAL_LIST_INIT(pa_repair, list(
	/datum/crafting_recipe/repair_t45,
	/datum/crafting_recipe/repair_t45_helm,
	/datum/crafting_recipe/scrap_pa,
	/datum/crafting_recipe/scrap_pa_helm,
	/datum/crafting_recipe/repair_t45/hotrod,
	/datum/crafting_recipe/repair_t45_helm/hotrod))


GLOBAL_LIST_INIT(weapons_of_texarkana, list(
	/datum/crafting_recipe/policepistol,
	/datum/crafting_recipe/durathread_vest,
	/datum/crafting_recipe/policerifle,
	/datum/crafting_recipe/steelbib/heavy,
	/datum/crafting_recipe/armyhelmetheavy,
	/datum/crafting_recipe/huntingshotgun))

GLOBAL_LIST_INIT(security_expert, list(
	/datum/crafting_recipe/lockpick_basic,
	/datum/crafting_recipe/lockpick_improved))


//predominantly positive traits
//this file is named weirdly so that positive traits are listed above negative ones

/datum/quirk/alcohol_tolerance
	name = "Alcohol Tolerance"
	desc = "You become drunk more slowly and suffer fewer drawbacks from alcohol."
	value = 14
	category = "Food Quirks"
	mechanics = "Booze only delivers 70% of its alcohol power."
	conflicts = list(/datum/quirk/alcohol_intolerance)
	mob_trait = TRAIT_ALCOHOL_TOLERANCE
	gain_text = span_notice("You feel like you could drink a whole keg!")
	lose_text = span_danger("You don't feel as resistant to alcohol anymore. Somehow.")
	medical_record_text = "Patient demonstrates a high tolerance for alcohol."

/datum/quirk/horrifying_tastes
	name = "Cannibal"
	desc = "You eat people. Consuming human flesh doesn't bother you, and dishes such as longpork stew will heal you. Probably don't tell your neighbor. ((This is an OOC trait and should only be found out in character and not through technology.))"
	mob_trait = TRAIT_LONGPORKLOVER
	value = 0
	category = "Food Quirks"
	mechanics = "Allows you to eat human flesh without being disgusted."
	conflicts = list(/datum/quirk/vegetarian)
	gain_text = span_notice("You have an insatiable hunger for the flesh of your fellow man.")
	lose_text = span_notice("The terrible hunger fades - you feel peace at last.")

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
	value = 22
	category = "Lifepath Quirks"
	mechanics = "Grants access to a wide variety of recipes and allows you to use primitive chemmasters with which you can make complex potions/poisons."
	conflicts = list(
		/datum/quirk/technophreak,
		/datum/quirk/tribal_tech,
		)
	gain_text = span_notice("You remember the old ways of your tribe.")
	lose_text = span_notice("You've forgotten the ways of your ancestors...")
	human_only = FALSE

/datum/quirk/tribal/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_MACHINE_SPIRITS, "Former Tribal")
	ADD_TRAIT(H, TRAIT_TRIBAL, "Former Tribal")
	ADD_TRAIT(H, TRAIT_FORMER_TRIBAL, "ex_tribal_traditions")
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.former_tribal_recipes

/datum/quirk/tribal/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_MACHINE_SPIRITS, "Former Tribal")
		REMOVE_TRAIT(H, TRAIT_TRIBAL, "Former Tribal")
		H.mind.learned_recipes -= GLOB.former_tribal_recipes

/datum/quirk/apathetic
	name = "Apathetic"
	desc = "You just don't care as much as other people. That's nice to have in a place like this, I guess."
	value = 0
	category = "Emotional Quirks"
	mechanics = "This trait forces your mood towards balance, it will make happiness and sadness last for shorter amounts of time as you return to neutral."
	conflicts = list(
		/datum/quirk/friendly,
		// /datum/quirk/jolly,
		// /datum/quirk/optimist,
		/datum/quirk/depression,
		/datum/quirk/pessimist,
		//datum/quirk/family_heirloom,
		// /datum/quirk/unstable,
		/datum/quirk/empath,
		)
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
	value = 14
	category = "Food Quirks"
	mechanics = "When drunk you slowly heal damage from all groups except wounds & bloodloss."
	conflicts = list(/datum/quirk/alcohol_intolerance)
	mob_trait = TRAIT_DRUNK_HEALING
	gain_text = span_notice("You feel like a drink would do you good.")
	lose_text = span_danger("You no longer feel like drinking would ease your pain.")
	medical_record_text = "Patient has unusually efficient liver metabolism and can slowly regenerate wounds by drinking alcoholic beverages."

/datum/quirk/empath
	name = "Empath"
	desc = "Whether it's a sixth sense or careful study of body language, it only takes you a quick glance at someone to understand how they feel. This lets you see their mood, damage, and intent. As well as seeing if they're experience oxyloss/toxloss and if they're in a high or low mood."
	value = 0
	category = "Emotional Quirks"
	mechanics = "You can read other peoples moods and see what intent they are in."
	conflicts = list(/datum/quirk/apathetic)
	mob_trait = TRAIT_EMPATH
	gain_text = span_notice("You feel in tune with those around you.")
	lose_text = span_danger("You feel isolated from others.")
	medical_record_text = "Patient is highly perceptive of and sensitive to social cues, or may possibly have ESP. Further testing needed."

/datum/quirk/freerunning
	name = "Freerunning"
	desc = "You're great at quick moves! You climb tables more quickly and land gracefully when falling from one floor up. You can also climb some walls!"
	value = 32
	category = "Movement Quirks"
	mechanics = "Allows you to alt click on certain walls to climb up them quickly. There must not be a roof in the way, of course. You can also climb over tables faster."
	conflicts = list(
		/datum/quirk/slower,
		/datum/quirk/slow,
		/datum/quirk/clumsy,
		/datum/quirk/cantrun,
		/datum/quirk/overweight,
		) //obese
	mob_trait = TRAIT_FREERUNNING
	gain_text = span_notice("You feel lithe on your feet! (Alt click walls to climb them!)")
	lose_text = span_danger("You don't seem to be able to jump as high as you used to.")
	medical_record_text = "Patient scored highly on cardio tests."

/datum/quirk/tackleradv
	name = "Advanced Leaper"
	desc = "You are able to leap long distances with ease."
	value = 22
	category = "Movement Quirks"
	mechanics = "You are able to jump long distances with throw enabled and an empty hand, though you can no longer tackle effectively."
	conflicts = list(
		/datum/quirk/clumsy,
		/datum/quirk/overweight,
		/datum/quirk/tacklerapex,
	)
	mob_trait = TRAIT_TACKLERADV
	gain_text = span_notice("Your legs feel much stronger.")
	lose_text = span_danger("Your legs feel much weaker.")
	medical_record_text = "Patient's dexterity belies a strong capacity for incredibly long distance jumping."

/datum/quirk/tackleradv/add()
	var/mob/living/carbon/human/H = quirk_holder
	H.AddComponent(/datum/component/tackler/simple, \
		stamina_cost = 20, \
		base_knockdown = 0 SECONDS, \
		range = 7, \
		speed = 2, \
		skill_mod = -2, \
		min_distance = 0 \
)


/datum/quirk/tacklerapex
	name = "Apex Leap"
	desc = "You are able to leap medium distances with ease, as well as being able to tackle people down, most of the time"
	value = 32
	category = "Movement Quirks"
	mechanics = "You are able to jump medium distances with throw enabled and an empty hand, and effectively tackle others"
	conflicts = list(
		/datum/quirk/clumsy,
		/datum/quirk/overweight,
		/datum/quirk/tackleradv
	)
	mob_trait = TRAIT_TACKLERNONCONX
	gain_text = span_notice("Your legs feel incredibly stronger.")
	lose_text = span_danger("Your legs feel incredibly weaker.")
	medical_record_text = "Patient's dexterity belies a strong capacity for street wide jumping."

/datum/quirk/tacklerapex/add()
	var/mob/living/carbon/human/H = quirk_holder
	H.AddComponent(/datum/component/tackler/simple_dunkstrong, \
		stamina_cost = 20, \
		base_knockdown = 0 SECONDS, \
		range = 5, \
		speed = 1, \
		skill_mod = 3, \
		min_distance = 0 \
)

/datum/quirk/friendly
	name = "Friendly"
	desc = "You give the best hugs. When you're in the right mood, your squeezes can cheer up those around you. Unless they don't, but that's okay. :)"
	value = 14
	category = "Emotional Quirks"
	mechanics = "Your hugs give a bonus mood boost on top of the normal boost from hugging."
	conflicts = list(
		/datum/quirk/apathetic,
		/datum/quirk/depression,
		/datum/quirk/pessimist,
	) //apathetic, and the negative emotional quirks
	mob_trait = TRAIT_FRIENDLY
	gain_text = span_notice("You feel confident in your ability to comfort others.")
	lose_text = span_danger("You no longer feel confident in your ability to comfort others.")
	mood_quirk = TRUE
	medical_record_text = "Patient demonstrates low-inhibitions for physical contact and well-developed arms. Requesting another doctor take over this case."

/*
/datum/quirk/jolly
	name = "Mood - Sanguine"
	desc = "You sometimes just feel happy, for no reason at all. Gives mood buffs, occasionally."
	value = 40
	category = "Emotional Quirks"
	mechanics = "You have a small chance every game tick to gain a massive mood boost. This can effect speed, and even how hard it is to put you down in crit."
	conflicts = list(
		/datum/quirk/apathetic,
		/datum/quirk/depression,
		/datum/quirk/pessimist,
		/datum/quirk/optimist,
	) //negative mood quirks
	mob_trait = TRAIT_JOLLY
	mood_quirk = TRUE
	medical_record_text = "Patient demonstrates constant euthymia irregular for environment. It's a bit much, to be honest."

/datum/quirk/jolly/on_process()
	if(prob(0.05))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "jolly", /datum/mood_event/jolly)

/datum/quirk/optimist
	name = "Mood - Optimist"
	desc = "You sometimes just feel kind of happy, for no reason at all. Gives small mood buffs, occasionally."
	value = 20
	category = "Emotional Quirks"
	mechanics = "You have a small chance every game tick to gain a decent mood boost. This can effect speed, and even how hard it is to put you down in crit."
	conflicts = list(
		/datum/quirk/apathetic,
		/datum/quirk/depression,
		/datum/quirk/pessimist,
		/datum/quirk/jolly,
	)
	mob_trait = TRAIT_OPTIMIST
	mood_quirk = TRUE
	medical_record_text = "Patient demonstrates occasional euthymia irregular for environment. Lucky them."

/datum/quirk/optimist/on_process()
	if(prob(0.05))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "optimist", /datum/mood_event/optimism)
*/

/datum/quirk/light_step
	name = "Light Step"
	desc = "You walk with a gentle step; stepping on sharp objects is quieter, less painful and you won't leave footprints behind you."
	value = 14
	category = "Movement Quirks"
	mechanics = "You make less noise when stepping on glass. You still take damage without shoes though."
	conflicts = list(
		/datum/quirk/clumsy,
		/datum/quirk/overweight,
	)
	mob_trait = TRAIT_LIGHT_STEP
	gain_text = span_notice("You walk with a little more litheness.")
	lose_text = span_danger("You start tromping around like a barbarian.")
	medical_record_text = "Patient's dexterity belies a strong capacity for stealth."

/*
/datum/quirk/quick_step
	name = "Speed Walker"
	desc = "You walk with determined strides, and out-pace most people, at least, if you're both walking."
	value = 20
	category = "Movement Quirks"
	mechanics = "You move faster while walking than most do while jogging."
	conflicts = list(
		/datum/quirk/clumsy,
		/datum/quirk/overweight,
		/datum/quirk/cantrun,
	)
	mob_trait = TRAIT_SPEEDY_STEP
	gain_text = span_notice("You feel determined. No time to lose.")
	lose_text = span_danger("You feel less determined. What's the rush, man?")
	medical_record_text = "Patient scored highly on racewalking tests."
*/

/*/datum/quirk/treasurehunter 
	name = "Treasure Hunter" //Used for digging up loot spawners, you can already do this with beastmaster rat, this just streamlines it
	desc = "You are skilled at digging up resources from underground, requiring nothing but your bare hands, mouth, or a trusty shovel!" 
	value = 22
	category = "Lifepath Quirks"
	mechanics = "Allows you to craft loot spawners for free in the misc catagory, at the cost of time."
	conflicts = list(

	)
	mob_trait = TRAIT_TREASURE_HUNTER
	gain_text = span_notice("You really feel like digging.")
	lose_text = span_notice("You really don't feel like digging.")
	medical_record_text = "Patient really likes to eat dirt" // Nobody reads these anyway
	human_only = FALSE*/// The crafting menu __NEEDS__ to be fixed so you cant queue up recipes multiple times first


/datum/quirk/musician
	name = "Musician"
	desc = "You can tune instruments to play melodies that clear certain negative effects and can soothe the soul, you even get one of your instruments for free!"
	value = 14
	category = "Lifepath Quirks"
	mechanics = "You spawn with an instrument & tuner. If you use a tuned instrument then you apply a healing chem to those that hear it. Over time this healing chem can build up in thei system to create an even bigger healing effect. It even stacks with other musicians!"
	conflicts = list(

	)
	mob_trait = TRAIT_MUSICIAN
	gain_text = span_notice("You know everything about musical instruments.")
	lose_text = span_danger("You forget how musical instruments work.")
	medical_record_text = "Patient brain scans show a highly-developed auditory pathway."
	human_only = FALSE

/datum/quirk/musician/on_spawn()
	var/mob/living/H = quirk_holder
	var/obj/item/choice_beacon/music/B = new(get_turf(H))
	H.put_in_hands(B)
	H.equip_to_slot_if_possible(B, SLOT_IN_BACKPACK)
	var/obj/item/musicaltuner/musicaltuner = new(get_turf(H))
	H.put_in_hands(musicaltuner)
	H.equip_to_slot_if_possible(musicaltuner, SLOT_IN_BACKPACK)
	if(ishuman(quirk_holder))
		H.regenerate_icons()
	else
		H.update_icons()

/datum/quirk/magehand
	name = "Mage hand"
	desc = "You gain the ability to use the magehand, a spell to manipulate things around you, and create sparkles!"
	value = 32
	category = "Magic Quirks"
	mechanics = "You spawn with a DNA injector that grants you the magehand ability, be sure to inject it. Remember you cant grab anything bigger than small items!"
	conflicts = list(

	)
	human_only = FALSE

/datum/quirk/magehand/on_spawn()
	var/mob/living/H = quirk_holder
	var/obj/item/dnainjector/telemut/B = new(get_turf(H))
	H.put_in_hands(B)
	H.equip_to_slot_if_possible(B, SLOT_IN_BACKPACK)
	if(ishuman(quirk_holder))
		H.regenerate_icons()
	else
		H.update_icons()

/* //placeholder test concluded
/datum/quirk/wizard
	name = "Wasteland Wizard"
	desc = "You're a wizard, Harry. Spell trained for who knows how long, or naturally inclined. You can't use guns, but you sure can do some other shit. This isn't a lisence to be a greifer or break rules. "
	value = 4
	category = ""
	mechanics = ""
	conflicts = list(

	)
	mob_trait = TRAIT_SWAMPWIZARD
	gain_text = span_notice("You know everything about magic.")
	lose_text = span_danger("You forgor how the magic.")

/datum/quirk/wizard/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/spellbook/B = new(get_turf(H))
	H.put_in_hands(B)
	H.regenerate_icons()
*/

/datum/quirk/selfaware
	name = "Self-Aware"
	desc = "You know your body well, and can accurately assess the extent of your wounds. Sort of like being a medical scanner for yourself."
	value = 14
	category = "Emotional Quirks"
	mechanics = "You know, to the number, how much damage you've taken."
	conflicts = list(

	)
	mob_trait = TRAIT_SELF_AWARE
	gain_text = span_notice("You feel deeply aware of your body.")
	lose_text = span_danger("You lose touch with yourself.")
	medical_record_text = "Patient demonstrates an uncanny knack for self-diagnosis."

/datum/quirk/skittish
	name = "Skittish"
	desc = "You are just the skittish sort. Tending to disappear when the lights turn on, or jumping when you hear a leaf crunch."
	value = 14
	category = "Movement Quirks"
	mechanics = "With ctrl + shift + click you can hop into lockers, dumpsters, and trash cans. Good for if you hear footsteps and want to not be seen."
	conflicts = list(

	)
	mob_trait = TRAIT_SKITTISH
	gain_text = span_notice("You feel like hiding all of a sudden.")
	lose_text = span_danger("You feel comfortable with the world, so much for hiding.")
	medical_record_text = "Patient demonstrates a high aversion to danger and has described hiding in containers out of fear."

/datum/quirk/spiritual
	name = "Spiritual"
	desc = "You're in tune with the gods, and your prayers may be more likely to be heard. Or not."
	value = 8
	category = "Functional Quirks"
	mechanics = "Your prayers trigger the same noise for admins that a preachers prayers would, meaning they're more likely to pay attention to them. That doesn't mean it will be positive attention though."
	conflicts = list(

	)
	mob_trait = TRAIT_SPIRITUAL
	gain_text = span_notice("You feel a little more faithful to the gods today.")
	lose_text = span_danger("You feel less faithful in the gods.")
	medical_record_text = "Patient reports a belief in a higher power."
	human_only = FALSE

/datum/quirk/tagger
	name = "Tagger"
	desc = "You're an experienced artist. Or, at least you know how to make every drop of paint count."
	value = 0
	category = "Lifepath Quirks"
	mechanics = "You get twice as many uses out of drawing supplies, like spray paint cans! Remember, we have a persistent painting system."
	conflicts = list(

	)
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
	desc = "You're skilled at breaking down old-war rubble more precisely and therefor you gain more salvage from cars and piles than before. Your time with understanding complex technology also \
	allows you to craft more complex machine parts."
	value = 32
	category = "Tech Quirks"
	mechanics = "You gain 1 to 3 extra scrap from cars and other scrapping resources, with a +1 on top of all scrap as well. As well as gaining access to a decent list of fancy recipes for crafting, like energy weapon cells."
	conflicts = list(
		/datum/quirk/tribal,
		/datum/quirk/dumb,
		/datum/quirk/luddite,
		/datum/quirk/primitive,

		)
	mob_trait = TRAIT_TECHNOPHREAK
	gain_text = span_notice("Old-War rubble seems considerably more generous to you.")
	lose_text = span_danger("Old-War rubble suddenly seems less generous to you.")
	medical_record_text = "Patient appears to really enjoy dismantling old junk."
	human_only = FALSE

/datum/quirk/technophreak/add()
	var/mob/living/carbon/human/H = quirk_holder
	// I made the quirks add the same recipes as the trait books. Feel free to nerf this
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.tier_three_parts
	H.mind.learned_recipes |= GLOB.energyweapon_cell_crafting
	H.mind.learned_recipes |= GLOB.energyweapon_crafting
	H.mind.learned_recipes |= GLOB.pa_repair
	H.mind.learned_recipes |= GLOB.armored_hazard_suit

/datum/quirk/technophreak/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.mind.learned_recipes -= GLOB.tier_three_parts
		H.mind.learned_recipes -= GLOB.energyweapon_cell_crafting
		H.mind.learned_recipes -= GLOB.energyweapon_crafting
		H.mind.learned_recipes -= GLOB.pa_repair
		H.mind.learned_recipes -= GLOB.armored_hazard_suit

/datum/quirk/crafty
	name = "Crafty"
	desc = "You are able to craft without the necessities provided by a traditional workbench."
	value = 25
	category = "Lifepath Quirks"
	mechanics = "You do not need a workbench or alchemy table when crafting."
	human_only = FALSE
/datum/quirk/crafty/on_spawn()
	var/mob/living/H = quirk_holder
	new /obj/machinery/workbench(H)
	new /obj/machinery/chem_master/primitive(H)

/datum/quirk/gunsmith
	name = "Weaponsmith - Basic"
	desc = "You know how to make various weapons, protective vests, gun mods, and can now forge weapons at an anvil. The list is too large to try and put here."
	value = 14
	category = "Crafting Quirks"
	mechanics = "You gain access to our weapon smithing system. A decent amount of recipes for things you can use, or sell!"
	conflicts = list(

	)

	mob_trait = TRAIT_WEAPONSMITH
	gain_text = span_notice("You are adept at crafting makeshift weapons.")
	lose_text = span_danger("You seem to have forgotten how to craft makeshift weapons...")
	medical_record_text = "Patient appears to enjoy tinkering with custom guns."

/datum/quirk/gunsmith/add()
	var/mob/living/carbon/human/H = quirk_holder
	// I made the quirks add the same recipes as the trait books. Feel free to nerf this
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.weaponcrafting_gun_recipes
	H.mind.learned_recipes |= GLOB.weapons_of_texarkana

/datum/quirk/gunsmith/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.mind.learned_recipes -= GLOB.weaponcrafting_gun_recipes

/datum/quirk/masterworksmith
	name = "Weaponsmith - Masterwork"
	desc = "Your smithed weapons now do extra damage. Requires Weaponsmith - Basic in order to benefit from!"
	value = 28
	category = "Crafting Quirks"
	mechanics = "You are a MASTER weapon smith, gaining access to the ability to craft masterwork weapons with our crafting system."
	conflicts = list(

	)
	mob_trait = TRAIT_MASTERWORKSMITH
	gain_text = span_notice("Your smithed weapons will now be of masterwork quality.")
	lose_text = span_danger("You seem less adept at crafting masterworks.")
	medical_record_text = "Patient appears to be a well renowned gunsmith."

/datum/quirk/voracious
	name = "Bottomless Stomach"
	desc = "Nothing gets between you and your food. You eat twice as fast as everyone else!"
	value = 0
	category = "Food Quirks"
	mechanics = "You never feel full! You can keep on eating, and eating, and eating... For better or worse."
	conflicts = list()
	mob_trait = TRAIT_VORACIOUS
	gain_text = span_notice("You feel HONGRY.")
	lose_text = span_danger("You no longer feel HONGRY.")
	medical_record_text = "Patient demonstrates a disturbing capacity for eating. Please, make sure they don't eat my lunch again."

/datum/quirk/bloodpressure
	name = "Extra Blood"
	desc = "You've a treated form of Polycythemia vera that increases the total blood volume inside of you as well as the rate of replenishment!"
	value = 20 //I honeslty dunno if this is a good trait? I just means you use more of medbays blood and make janitors madder, but you also regen blood a lil faster.
	category = "Health Quirks"
	mechanics = "You blood ratio, and volume, are both higher than average. Meaning that you will survive blood loss wounds for longer, and more comfortably."
	conflicts = list(
		/datum/quirk/blooddeficiency,
	)
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
	value = 14
	category = "Tech Quirks"
	mechanics = "You gain access to tribal chemmasters to make potions and poisons."
	conflicts = list(

	)
	mob_trait = TRAIT_MACHINE_SPIRITS
	gain_text = span_notice("You are now able to use primitive technology.")
	lose_text = span_danger("You are no longer able to use primitive technology.")
	medical_record_text = "Patient appears to have a knack for bushcraft."
	locked = TRUE
	human_only = FALSE

/datum/quirk/dna_whiz
	name = "Dna Whiz"
	desc = "You can sequence plant genomes with a snap of your fingers!"
	value = 32
	category = "Tech Quirks"
	mechanics = "You can use plant dna machines, for one reason or another."
	conflicts = list(
		/datum/quirk/tribal,
		/datum/quirk/dumb,
		/datum/quirk/luddite,
		/datum/quirk/primitive,
	)
	mob_trait = TRAIT_DNAWHIZ
	gain_text = span_notice("You know how plants work!")
	lose_text = span_danger("You forgot how plants work... somehow.")

/*
/datum/quirk/night_vision
	name = "Dark Vision - Minor"
	desc = "You can see a small distance around you in full darkness compared to most people by two whole tiles."
	value = 22
	category = "Vision Quirks"
	mechanics = "You can see two more tiles in the dark compared to others without a light source."
	conflicts = list(
		/datum/quirk/blindness,
		/datum/quirk/night_vision_greater,
	)
	mob_trait = TRAIT_NIGHT_VISION
	gain_text = span_notice("The shadows seem a little less dark.")
	lose_text = span_danger("Everything seems a little darker.")
	medical_record_text = "Patient claims they can see in the dark."
	human_only = FALSE

/datum/quirk/night_vision/on_spawn()
	quirk_holder.update_sight()

/datum/quirk/night_vision/remove()
	quirk_holder.update_sight()

/datum/quirk/night_vision_greater
	name = "Dark Vision - Greater"
	desc = "You can see a much further distance in full darkness compared to most people by four more whole tiles."
	value = 44
	category = "Vision Quirks"
	mechanics = "You can see four more tiles in the dark compared to others without a light source."
	conflicts = list(
		/datum/quirk/blindness,
		/datum/quirk/night_vision,
	)
	mob_trait = TRAIT_NIGHT_VISION_GREATER
	gain_text = span_notice("The shadows seem a a lot less dark.")
	lose_text = span_danger("Everything seems a lot darker.")
	medical_record_text = "Patient claims that they have night vision."
	human_only = FALSE

/datum/quirk/night_vision_greater/on_spawn()
	quirk_holder.update_sight()

/datum/quirk/night_vision_greater/remove()
	quirk_holder.update_sight()
*/

/datum/quirk/nukalover
	name = "Cola Fiend"
	desc = "You just can't get enough of that hyper-sweetened, tooth-rotting, waistline-widening, pancreas-pummeling sodapop! \
		So much so that your body has adapted to the sugars and artificial flavorings, processing those calories into healing energy. \
		Won't do much for that waistline, though."
	value = 22
	category = "Food Quirks"
	mechanics = "Various sodapop-derived drinks will provide (usually minor) healing, typically based on their complexity."
	conflicts = list(
		/datum/quirk/vegetarian,
		/datum/quirk/no_taste,
	)
	mob_trait = TRAIT_NUKA_LOVER
	gain_text = span_notice("You want to buy the whole world a cosmic-cola!")
	lose_text = span_danger("What's the big deal about cosmic-cola?")
	medical_record_text = "Patient has an addiction to the soft drink Cosmic-Cola. Somehow, their metabolism has adapted to the sugars and artifical flavorings."

/datum/quirk/nukalover/add()
	if(!ishuman(quirk_holder))
		to_chat(quirk_holder, span_warning("You suddenly remember an article in Cat Fancy about how sodie pop can cause liver damage and cancer of the rectum. Might be best to lay off the stuff (especially since you kinda cant actually drink it, not being a human and all)."))
		return
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food |= NUKA
	species.disliked_food |= VEGETABLES
	var/obj/item/organ/sodie_organ/gibb = new(H)
	gibb.Insert(H)

/datum/quirk/nukalover/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food = initial(species.liked_food)
		species.disliked_food = initial(species.disliked_food)
		var/obj/item/organ/sodie_organ/gibb = H.getorganslot(ORGAN_SLOT_SODIE_ORGAN)
		if(gibb)
			qdel(gibb)

/datum/quirk/prisonpocket
	name = "Sleight of Hand"
	desc = "You're really good with your hands. You can even conceal some objects on your person without them being found, kind of good."
	value = 8
	category = "Functional Quirks"
	mechanics = "You have an innate, untraceable storage that can contain up to two normal sized items."
	gain_text = span_notice("You feel like you could make a couple things... disappear!")
	lose_text = span_warning("Your hands feel a little slower.")
	conflicts = list(
	)
	mob_trait = TRAIT_SOH

/datum/quirk/prisonpocket/on_spawn()
	if(!ishuman(quirk_holder))
		to_chat(quirk_holder, span_warning("Your lack of hands makes it impossible to stealthily hide items."))
		return
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/implant/storage/soh = new(get_turf(H))
	soh.implant(H, null, TRUE)

/datum/quirk/prisonpocket/remove()
	var/obj/item/implant/storage/soh = quirk_holder.getImplant(/obj/item/implant/storage)
	if(soh)
		qdel(soh)

/datum/quirk/trapper
	name = "Trapper"
	desc = "As an experienced hunter and trapper you know your way around butchering animals for their products."
	value = 14
	category = "Lifepath Quirks"
	mechanics = "You get double the amount of usable materials when you butcher with a sharp object via harm intent."
	conflicts = list(
		/datum/quirk/nonviolent,
	)
	mob_trait = TRAIT_TRAPPER
	gain_text = span_notice("You learn the secrets of butchering!")
	lose_text = span_danger("You forget how to slaughter animals.")
	medical_record_text = "Patient often describes how they clean and skin animals."
	locked = FALSE
	human_only = FALSE

/*
/datum/quirk/bigleagues
	name = "Melee - Big Leagues"
	desc = "Swing for the fences! You deal even more additional damage with melee weapons."
	value = 65
	category = "Melee Quirks"
	mechanics = "You do an extra 25 damage with all melee attacks."
	conflicts = list( //little leagues, and the negative quriks
		/datum/quirk/nonviolent,
		/datum/quirk/littleleagues,
		/datum/quirk/gentle,
		/datum/quirk/wimpy,
	)
	mob_trait = TRAIT_BIG_LEAGUES
	gain_text = span_notice("You feel like swinging for the fences!")
	lose_text = span_danger("You feel like bunting.")
	medical_record_text = "Patient appears to have incredible upper body strength."
	locked = FALSE
	human_only = FALSE

/datum/quirk/littleleagues
	name = "Melee - Little Leagues"
	desc = "Swing for the outfield! You deal additional damage with melee weapons."
	value = 32
	category = "Melee Quirks"
	mechanics = "You do an extra 5 damage with all melee attacks."
	conflicts = list(
		/datum/quirk/nonviolent,
		/datum/quirk/bigleagues,
		/datum/quirk/gentle,
		/datum/quirk/wimpy,
	)
	mob_trait = TRAIT_LITTLE_LEAGUES
	gain_text = span_notice("You feel like swinging for the outfield!")
	lose_text = span_danger("You feel like skipping practice.")
	medical_record_text = "Patient appears to have above average upper body strength."
	locked = FALSE
	human_only = FALSE
	*/

/datum/quirk/chemwhiz
	name = "Chem Whiz"
	desc = "You've been playing around with chemicals all your life. You know how to use chemistry machinery."
	value = 32
	category = "Crafting Quirks"
	mechanics = "You gain access to normal chemistry machines."
	conflicts = list(
		/datum/quirk/tribal,
		/datum/quirk/dumb,
		/datum/quirk/luddite,
		/datum/quirk/primitive,
	)
	mob_trait = TRAIT_CHEMWHIZ
	gain_text = span_notice("The mysteries of chemistry are revealed to you!")
	lose_text = span_danger("You forget how water boils.")
	medical_record_text = "Patient appears to use pharmaceutical labels for OTC drugs."
	locked =  FALSE
	human_only = FALSE

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
	name = "Power Armor Crafting"
	desc = "You've been around the wastes and have learned the wonders of crafting high tech armor from somewhere or something."
	value = 32
	category = "Lifepath Quirks"
	mechanics = "You can craft powerarmor, anyone can wear it though."
	conflicts = list(
		/datum/quirk/dumb,
		/datum/quirk/luddite,
		/datum/quirk/primitive,
	)
	mob_trait = TRAIT_PA_WEAR
	gain_text = span_notice("You realize how to use Power Armor.")
	lose_text = span_danger("You forget how Power Armor works...")
	medical_record_text = "Patient claims to wear a powerful suit of metal."
	locked = FALSE

/*
/datum/quirk/hard_yards
	name = "Mobility - Wasteland Trekker"
	desc = "You've spent a lot of time wandering the wastes, and for your hard work you out pace most folks when travelling across them."
	value = 55
	category = "Movement Quirks"
	mechanics = "You aren't slowed at all by going off roads or paths."
	conflicts = list(
		/datum/quirk/soft_yards,
		/datum/quirk/slower,
		/datum/quirk/slow,
		/datum/quirk/paraplegic,
	)
	mob_trait = TRAIT_HARD_YARDS
	gain_text = span_notice("Rain or shine, nothing slows you down!")
	lose_text = span_danger("The world beneath your heels suddenly feels like its pinning you down...")
	medical_record_text = "Patient describes going on hikes very often."
	locked = FALSE

/datum/quirk/soft_yards
	name = "Mobility - Wasteland Wanderer"
	desc = "You've spent some time in the wastes, and can move a bit better around them for it."

	value = 22
	category = "Movement Quirks"
	mechanics = "You are only slowed somewhat by going off roads or paths."
	conflicts = list(
		/datum/quirk/hard_yards,
		/datum/quirk/slower,
		/datum/quirk/slow,
		/datum/quirk/paraplegic,
	)
	mob_trait = TRAIT_SOFT_YARDS
	gain_text = span_notice("Rain or shine only slow you down a little.")
	lose_text = span_danger("The world beneath your heels suddenly feels like tugging you down...")
	medical_record_text = "Patient describes going on walks."
	locked = FALSE
*/

/datum/quirk/lifegiver
	name = "Health - Tough"
	desc = "You embody wellness! "
	value = 32
	category = "Health Quirks"
	mechanics = "You have +20 health. What this actually means is that you need to take ten more points of damage before you go into crit."
	conflicts = list(
		/datum/quirk/lifegiverplus,
		/datum/quirk/flimsy,
		/datum/quirk/veryflimsy,
	)
	mob_trait = TRAIT_LIFEGIVER
	gain_text = span_notice("You feel more durable.")
	lose_text = span_danger("You feel flimsy once more.")
	medical_record_text = "Patient has higher capacity for injury."
	locked = FALSE
	human_only = FALSE

/datum/quirk/lifegiver/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.maxHealth += 20
	H.health += 20

/datum/quirk/lifegiverplus
	name = "Health - Tougher"
	desc = "You embody wellness to the MAX! Instantly gain +20 maximum Health."
	value = 65
	category = "Health Quirks"
	mechanics = "You have +40 health. What this actually means is you need to take 20 more points of damage before you go into crit."
	conflicts = list(
		/datum/quirk/lifegiver,
		/datum/quirk/flimsy,
		/datum/quirk/veryflimsy,
	)
	mob_trait = TRAIT_LIFEGIVERPLUS
	gain_text = span_notice("You feel incredibly durable.")
	lose_text = span_danger("You feel noodly once more.")
	medical_record_text = "Patient has shown a significantly higher capacity for injury."
	locked = FALSE
	human_only = FALSE

/datum/quirk/lifegiverplus/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.maxHealth += 40
	H.health += 40

/datum/quirk/iron_fist
	name = "Fists of Iron"
	desc = "You have fists of kung-fury! Increases unarmed damage."
	value = 18
	category = "Hand to Hand Quirks"
	mechanics = "Your punches do 6 to 12 damage."
	conflicts = list(
		/datum/quirk/nonviolent,
		/datum/quirk/steel_fist,
		/datum/quirk/noodle_fist,
	)
	mob_trait = TRAIT_IRONFIST
	gain_text = span_notice("Your fists feel furious!")
	lose_text = span_danger("Your fists feel calm again.")
	medical_record_text = "Patient has claimed to have accidentally break pencils when holding them."
	locked = FALSE

/datum/quirk/iron_fist/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.dna.species.punchdamagelow = IRON_FIST_PUNCH_DAMAGE_LOW
	H.dna.species.punchdamagehigh = IRON_FIST_PUNCH_DAMAGE_MAX

/datum/quirk/steel_fist
	name = "Fists of Steel"
	desc = "You have MASSIVE fists of kung-fury! Even MORE increases unarmed damage."
	value = 36
	category = "Hand to Hand Quirks"
	mechanics = "Your punches do 10 to 16 damage, yeowch!"
	conflicts = list(
		/datum/quirk/nonviolent,
		/datum/quirk/iron_fist,
		/datum/quirk/noodle_fist,
	)
	mob_trait = TRAIT_STEELFIST
	gain_text = span_notice("Your fists feel MASSIVELY furious!")
	lose_text = span_danger("Your fists feel calm again, what a relief.")
	medical_record_text = "Patient has accidentally destroyed the door handle to my office. A replacement is needed."
	locked = FALSE

/datum/quirk/steel_fist/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.dna.species.punchdamagelow = STEEL_FIST_PUNCH_DAMAGE_LOW
	H.dna.species.punchdamagehigh = STEEL_FIST_PUNCH_DAMAGE_MAX

/datum/quirk/surgerylow
	name = "Minor Surgery"
	desc = "You are a somewhat adequate medical practicioner, capable of performing minor surgery in a pinch."
	value = 11
	category = "Medical Quirks"
	mechanics = "You gain access to most surgeries, only being limited on brain surgery essentially."
	conflicts = list(
		/datum/quirk/surgerymid,
		/datum/quirk/surgeryhigh
	)
	mob_trait = TRAIT_SURGERY_LOW
	gain_text = span_notice("You feel yourself discovering the basics of the body.")
	lose_text = span_danger("You forget how to perform even the simplest of surgery.")
	medical_record_text = "Patient exudes some knowlegde on operation sanitation procedures."
	locked = FALSE
	human_only = FALSE

/datum/quirk/surgerymid
	name = "Advanced Surgery"
	desc = "You are a competent medical practicioner, capable of performing a larger array of surgeries."
	value = 33
	category = "Medical Quirks"
	mechanics = "You gain access to most surgeries, and advanced wound tending surgeries."
	conflicts = list(
		/datum/quirk/surgeryhigh,
		/datum/quirk/surgerylow
	)
	mob_trait = TRAIT_SURGERY_MID
	gain_text = span_notice("You feel yourself discovering the inner workings of the body.")
	lose_text = span_danger("You forget how to perform even the simplest of surgery.")
	medical_record_text = "Patient is claimed to be an competent surgeon."
	locked = FALSE
	human_only = FALSE

/datum/quirk/surgeryhigh
	name = "Expert Surgery"
	desc = "You are a well established surgeon. You can perform most, if not all, surgeries."
	value = 66
	category = "Medical Quirks"
	mechanics = "You gain access to most surgeries, particularly expert wound tending surgeries."
	conflicts = list(
		/datum/quirk/surgerylow,
		/datum/quirk/surgerymid
	)
	mob_trait = TRAIT_SURGERY_HIGH
	gain_text = span_notice("You feel yourself discovering everything about the body!")
	lose_text = span_danger("You forget how to perform even the simplest of surgery.")
	medical_record_text = "Patient is a renown surgeon."
	locked = FALSE
	human_only = FALSE

/datum/quirk/explosive_crafting
	name = "Explosives Crafting"
	desc = "You have strong feelings about the future of industrial society."
	value = 14
	category = "Crafting Quirks"
	mechanics = "You gain access to the recipes to make all sorts of explosives, including mines!"
	conflicts = list( //dumb

	)
	mob_trait = TRAIT_EXPLOSIVE_CRAFTING
	gain_text = span_notice("You feel like you can make a bomb out of anything.")
	lose_text = span_danger("You feel okay with the advancement of technology.")
	medical_record_text = "Patient claims to enjoy making pipe bombs."
	locked = FALSE
	human_only = FALSE

/datum/quirk/explosive_crafting/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	// I made the quirks add the same recipes as the trait books. Feel free to nerf this
	H.mind.learned_recipes |= GLOB.basic_explosive_recipes
	H.mind.learned_recipes |= GLOB.adv_explosive_recipes
	H.mind.learned_recipes |= GLOB.minelaying_recipe

/datum/quirk/explosive_crafting/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.mind.learned_recipes -= GLOB.basic_explosive_recipes
		H.mind.learned_recipes -= GLOB.adv_explosive_recipes

/datum/quirk/improved_heal
	name = "Improved Innate Healing"
	desc = "You have a deeper reservoir for innate healing, whether it's through magic, medical tending, or licking. Check the neutral traits for these abilities."
	value = 32
	category = "Healer Quirks"
	mechanics = "Your innate healing functions now have 25 uses instead of only 5. They will still regenerate at the same speed though."
	conflicts = list(

	)
	mob_trait = TRAIT_IMPROVED_HEALING
	gain_text = span_notice("You feel well hydrated.")
	lose_text = span_danger("You feel rather dry.")
	medical_record_text = "Patient exudes a rather invigorating aura. Further study is required."
	locked = FALSE
	human_only = FALSE

/*
/datum/quirk/lick_bandage
	name = "Sanguine Saliva"
	desc = "Your saliva has a mild coagulating effect on open bleeding wounds. Use *lick to lick your lacerations."
	value = 2
	category = ""
	mechanics = ""
	conflicts = list(

	)
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
*/
// This does the same thing as basic explosive crafting by giving basic_recipe and adv_recipe. -Possum
/*
/datum/quirk/advanced_explosive_crafting
	name = "Advanced Explosive Crafting"
	desc = "Decades of engineering knowledge have taught you to make all kinds of horrible explosives."
	value = 1
	category = ""
	mechanics = ""
	conflicts = list(

	)
	mob_trait = TRAIT_ADVANCED_EXPLOSIVE_CRAFTING
	gain_text = span_notice("You're on the no-fly list.'")
	lose_text = span_danger("You feel like you're allowed to fly on planes again.")
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
*/

/*
/datum/quirk/whitelegstraditions
	name = "Post Apocalyptic Tribal Traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 0
	category = "Crafting Quirks"
	mechanics = "You gain access to a massive amount of recipes involving numerous different Fallout tribes."
	conflicts = list()
	mob_trait = TRAIT_TRIBAL_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	medical_record_text = "Patient appears to mention their ancestors decorataive looks."
	locked =  FALSE

/datum/quirk/whitelegstraditions/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/book/granter/trait/tribaltraditions/B = new(get_turf(H))
	H.put_in_hands(B)
*/

/*
/datum/quirk/deadhorsestraditions
	name = "Dead Horses traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 0
	category = ""
	mechanics = ""
	conflicts = list(
		/datum/quirk/whitelegstraditions,
		/datum/quirk/rustwalkerstraditions,
		/datum/quirk/eightiestraditions,
		/datum/quirk/sorrowstraditions,
		/datum/quirk/wayfarertraditions,
		/datum/quirk/bonedancertraditions,
	)
	mob_trait = TRAIT_DEADHORSES_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/rustwalkerstraditions
	name = "Rust Walkers traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 0
	category = ""
	mechanics = ""
	conflicts = list(
		/datum/quirk/whitelegstraditions,
		/datum/quirk/deadhorsestraditions,
		/datum/quirk/eightiestraditions,
		/datum/quirk/sorrowstraditions,
		/datum/quirk/wayfarertraditions,
		/datum/quirk/bonedancertraditions,
	)
	mob_trait = TRAIT_RUSTWALKERS_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/rustwalkerstraditions/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_RUSTWALKERS_TRAD, "Rustwalker Traditions")
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.rustwalkers_traditions_recipes

/datum/quirk/rustwalkerstraditions/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_RUSTWALKERS_TRAD, "Rustwalker Traditions")
	H.mind.learned_recipes -= GLOB.rustwalkers_traditions_recipes

/datum/quirk/eightiestraditions
	name = "Eighties traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 0
	category = ""
	mechanics = ""
	conflicts = list(
		/datum/quirk/whitelegstraditions,
		/datum/quirk/deadhorsestraditions,
		/datum/quirk/rustwalkerstraditions,
		/datum/quirk/sorrowstraditions,
		/datum/quirk/wayfarertraditions,
		/datum/quirk/bonedancertraditions,
	)
	mob_trait = TRAIT_EIGHTIES_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/eightiestraditions/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_EIGHTIES_TRAD, "Eighties Traditions")
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.eighties_traditions_recipes

/datum/quirk/rustwalkerstraditions/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_EIGHTIES_TRAD, "Eighties Traditions")
	H.mind.learned_recipes -= GLOB.eighties_traditions_recipes

/datum/quirk/sorrowstraditions
	name = "Sorrows traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 0
	category = ""
	mechanics = ""
	conflicts = list(
		/datum/quirk/whitelegstraditions,
		/datum/quirk/deadhorsestraditions,
		/datum/quirk/rustwalkerstraditions,
		/datum/quirk/eightiestraditions,
		/datum/quirk/wayfarertraditions,
		/datum/quirk/bonedancertraditions,
	)_trait = TRAIT_SORROWS_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/wayfarertraditions
	name = "Wayfarer traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 0
	category = ""
	mechanics = ""
	conflicts = list(
		/datum/quirk/whitelegstraditions,
		/datum/quirk/deadhorsestraditions,
		/datum/quirk/rustwalkerstraditions,
		/datum/quirk/eightiestraditions,
		/datum/quirk/sorrowstraditions,
		/datum/quirk/bonedancertraditions,
	)
	mob_trait = TRAIT_WAYFARER_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE

/datum/quirk/bonedancertraditions
	name = "Bone Dancer traditions"
	desc = "You remember how to make your peoples ancient garments after all this time."
	value = 0
	category = ""
	mechanics = ""
	conflicts = list(
		/datum/quirk/whitelegstraditions,
		/datum/quirk/deadhorsestraditions,
		/datum/quirk/rustwalkerstraditions,
		/datum/quirk/eightiestraditions,
		/datum/quirk/sorrowstraditions,
		/datum/quirk/wayfarertraditions,
	)
	mob_trait = TRAIT_BONEDANCER_TRAD
	gain_text = span_notice("The mysteries of your ancestors are revealed to you.")
	lose_text = span_danger("You forget how your ancestors have created their garments.")
	locked =  FALSE */

/datum/quirk/bonedancertraditions/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_BONEDANCER_TRAD, "Bone Dancer Traditions")
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.bonedancer_traditions_recipes

/datum/quirk/bonedancertraditions/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_BONEDANCER_TRAD, "Bone Dancer Traditions")
	H.mind.learned_recipes -= GLOB.bonedancer_traditions_recipes

/datum/quirk/brickwall
	name = "Brick wall"
	desc = "You just don't move when people try to push you out of the way, for whatever reason."
	value = 14
	category = "Movement Quirks"
	mechanics = "You are treated as being in harm intent at all times when it comes to people moving through your space."
	conflicts = list( //health flimsy maybe? Maybe not though?  idk

	)
	mob_trait = TRAIT_PUSHIMMUNE
	gain_text = span_notice("You feel stronger than a brick wall.")
	lose_text = span_danger("Your feel like you could get thrown down again.")
	medical_record_text = "Patient appears to exude a personal space bubble."
	locked =  FALSE
	human_only = FALSE

/* Removed due to lack of atmos lol ~TK
/datum/quirk/heatresist
	name = "Heat Resistant"
	desc = "Heat doesn't bother you too much."
	value = 1
	category = ""
	mechanics = ""
	conflicts = list(

	)
	mob_trait = TRAIT_RESISTHEAT
	gain_text = span_notice("It could be a little warmer in here.")
	lose_text = span_danger("You know? Being hot kind of sucks actually.")
	locked =  FALSE

/datum/quirk/coldresist
	name = "Cold Resistant"
	desc = "Cold doesn't bother you too much."
	value = 1
	category = ""
	mechanics = ""
	conflicts = list(

	)
	mob_trait = TRAIT_RESISTCOLD
	gain_text = span_notice("It could be a little colder in here.")
	lose_text = span_danger("You know? Being cold kind of sucks actually.")
	locked =  FALSE
*/

/* /datum/quirk/radimmune
	name = "Radiation - Immune"
	desc = "Gieger Counters are for suckers."
	value = 5
	category = ""
	mechanics = ""
	conflicts = list(

	)
	mob_trait = TRAIT_RADIMMUNE
	gain_text = span_notice("You've decided radiation just doesn't matter.")
	lose_text = span_danger("You no longer feel like you could probably live in a microwave while its on.")
	locked =  FALSE */

/*
/datum/quirk/radimmuneish
	name = "Radiation - Mostly Immune"
	desc = "Gieger Counters are for suckers, mostly."
	value = 40
	category = "Radiation Quirks"
	mechanics = "Who needs a geiger counter? Gives 75% innate rad resist."
	conflicts = list(
		/datum/quirk/radimmunesorta,
		/datum/quirk/radweakmajor,
		/datum/quirk/radweak
	)
	mob_trait = TRAIT_75_RAD_RESIST
	gain_text = span_notice("You've decided that radiation is an afterthought.")
	lose_text = span_danger("You feel like radiation is very important to you again.")
	medical_record_text = "Patient appears to be incredibly resilient to a large amount of radiation. X-Ray scans near impossible."
	locked =  FALSE

/datum/quirk/radimmunesorta
	name = "Radiation - Sorta Immune"
	desc = "Gieger Counters are for suckers, sorta. Gives 50% innate rad resist."
	value = 20
	category = "Radiation Quirks"
	mechanics = "You only absorb half of all radiation."
	conflicts = list(
		/datum/quirk/radimmuneish,
		/datum/quirk/radweakmajor,
		/datum/quirk/radweak
	)
	mob_trait = TRAIT_50_RAD_RESIST
	gain_text = span_notice("You've decided radiation has a weaker effect on you.")
	lose_text = span_danger("You no longer think you should hang out next to rad puddles.")
	medical_record_text = "Patient appears to be resilient to some radiation. X-Ray scans are fuzzy. "
	locked =  FALSE
*/

/datum/quirk/nohunger
	name = "Does not Eat"
	desc = "You don't need to eat to live, lucky you."
	value = 14
	category = "Food Quirks"
	mechanics = "Your hunger never goes down, simple as that."
	conflicts = list( //any of the eating quirks
		/datum/quirk/voracious,
		/datum/quirk/horrifying_tastes,
	)
	mob_trait = TRAIT_NOHUNGER
	gain_text = span_notice("Your need for food has left you.")
	lose_text = span_danger("GOD YOU WANT A BURGER SO BAD.")
	medical_record_text = "Patient NEVER eats their food."
	locked =  FALSE

/*
/datum/quirk/thickskin
	name = "Thick Skin"
	desc = "You just don't get splinters, or shrapnel for that matter.  BROKEN AS OF 2/9/23, TAKE LICK HEALING TO CLOSE WOUNDS."
	value = 3
	category = ""
	mechanics = ""
	conflicts = list(

	)
	mob_trait = TRAIT_PIERCEIMMUNE
	gain_text = span_notice("Your skin feels way stronger.")
	lose_text = span_danger("You feel like your skin is about as tough as tissue paper.")
	locked =  TRUE
*/

/datum/quirk/quickercarry
	name = "Quicker Carry"
	desc = "You're better than most people when it comes to carrying people!"
	value = 18
	category = "Medical Quirks"
	mechanics = "When using the fireman carry you lift people up at a faster rate."
	conflicts = list(
		// /datum/quirk/quickcarry,
	)
	mob_trait = TRAIT_QUICKER_CARRY
	gain_text = span_notice("You feel like a ACCEPTABLE fireman!")
	lose_text = span_danger("You're ability to carry folk seems a bit diminished.")
	medical_record_text = "Patient appears to drag people around on occasion."
	locked =  FALSE

/*
/datum/quirk/quickcarry
	name = "Quick Carry"
	desc = "You're exceptionally good when it comes to carrying people!"
	value = 14
	category = "Medical Quirks"
	mechanics = "When using the fireman carry you lift people up onto your shoulders a bit faster!"
	conflicts = list(
		/datum/quirk/quickercarry,
	)
	mob_trait = TRAIT_QUICK_CARRY
	gain_text = span_notice("You feel like an MASTER fireman!")
	lose_text = span_danger("You're ability to carry folk seems massively diminished.")
	medical_record_text = "Patient appears to haul bodies around."
	locked =  FALSE
*/

/datum/quirk/builder
	name = "Experienced Builder"
	desc = "You're good at putting stuff together!"
	value = 14
	category = "Lifepath Quirks"
	mechanics = "You build structures at a much faster speed and also can use the *brick verb to magic up bricks from brickspace with no cooldown."
	conflicts = list()
	mob_trait = TRAIT_QUICK_BUILD
	gain_text = span_notice("You could throw up a house if you wanted to!")
	lose_text = span_danger("What's a two by four again?")
	medical_record_text = "Patient made comments on the building's floorplan."
	locked =  FALSE
	human_only = FALSE

/datum/quirk/grappler
	name = "Trained Grappler"
	desc = "You've got real skills when it comes to grabbing people by the bits!"
	value = 32
	category = "Hand to Hand Quirks"
	mechanics = "Any grab that you do, even just shift clicking on people, is automatically an aggressive grab. Annoying for making trains of people to move in, but great for forcing a weapon out of someones hand."
	conflicts = list()
	mob_trait = TRAIT_STRONG_GRABBER
	gain_text = span_notice("You feel like you could wrestle a aethergiest!!!")
	lose_text = span_danger("You no longer feel like you should wrestle aethergiests...")
	medical_record_text = "Patient is apparently very good at gripping things."
	locked =  FALSE
	human_only = FALSE

/datum/quirk/mastermartialartist
	name = "Master Martial Artist"
	desc = "You occasionally hit so hard that they don't even seem like themselves anymore!"
	value = 32
	category = "Hand to Hand Quirks"
	mechanics = "Your punches, when you roll max damage, inflict clone damage instead of normal brute damage on people. Which is harder to heal and generally somewhat devastating."
	conflicts = list(
		/datum/quirk/nonviolent,
		/datum/quirk/noodle_fist,
	)
	mob_trait = TRAIT_KI_VAMPIRE
	gain_text = span_notice("They are already dead.")
	lose_text = span_danger("Your fists no longer feel so powerful.")
	medical_record_text = "Patient appears to have dense muscles in their fists."
	locked =  FALSE

/datum/quirk/surestrike
	name = "Sure Strike"
	desc = "You've either trained for years, got a lucky mutation, or are naturally strong! Your punches always do MAX damage!"
	value = 32
	category = "Hand to Hand Quirks"
	mechanics = "You ALWAYS punch for MAX damage."
	conflicts = list(
		/datum/quirk/nonviolent,
		/datum/quirk/mastermartialartist,
	)
	mob_trait = TRAIT_PERFECT_ATTACKER
	gain_text = span_notice("You feel like you can punch anything!")
	lose_text = span_danger("Your fists seem to lose their punching finesse.")
	medical_record_text = "Patient appears to have incredibly dense muscles in their fist."

/datum/quirk/silentstep
	name = "Silent Step"
	desc = "Your steps just make no noise, or maybe everyone elses buttcheeks are just that loud?"
	mob_trait = TRAIT_SILENT_STEP
	value = 32
	category = "Movement Quirks"
	mechanics = "Your footsteps never make noise."
	conflicts = list(
		/datum/quirk/overweight,
		/datum/quirk/clumsy,
	)
	gain_text = span_notice("Your footsteps fade away.")
	lose_text = span_danger("You're pretty sure that's the sound of your asscheeks clapping, but it might be footsteps.")
	medical_record_text = "Patient appears to always walk on their toes."
	locked =  FALSE

/*
/datum/quirk/deadeye
	name = "Dead Eye"
	desc = "When you hit your target, you frequently hit your target's vital points more often than not."
	value = 65
	category = "Ranged Quirks"
	mechanics = "You have advantage on all random ranged damage rolls. (roll twice and take the highest). \
				On top of that your shots have better chances of hitting simple mobs on their vital spots, aiming your shots on the head, arms and legs trigger gimmicks \
				more often. Gimmicks that vary between stunning a mob temporarely to dealing more damage."
	conflicts = list(
		/datum/quirk/clumsy,
		/datum/quirk/straightshooter,
		/datum/quirk/poor_aim,
	)
	mob_trait = TRAIT_CRIT_SHOT
	gain_text = span_notice("Your aim is legendary, and you know it.")
	lose_text = span_danger("Your aim could use a lot more work...")
	medical_record_text = "Patient flicked a fly out of the air using a toothpick."
	locked =  FALSE
	human_only = FALSE
	*/

/datum/quirk/straightshooter
	name = "Straight Shooter"
	desc = "You're a better than average shot."
	value = 44
	category = "Ranged Quirks"
	mechanics = "Adjusts various accuracy equations to be more in your favor. In general, you're about twice as accurate with guns, and suffer less penalties from one-handing two-hand guns."
	conflicts = list(
		/datum/quirk/clumsy,
		// /datum/quirk/deadeye,
		/datum/quirk/poor_aim,
	)
	mob_trait = TRAIT_NICE_SHOT
	gain_text = span_notice("Your aim is amazing, and you know it.")
	lose_text = span_danger("Your aim could use a little more work...")
	medical_record_text = "Patient repeatedly scores baskets in the trashcan."
	locked =  FALSE
	human_only = FALSE

/datum/quirk/bowtrained
	name = "Bow Trained"
	desc = "You've trained quite a bit with bows of many types."
	value = 14
	category = "Ranged Quirks"
	mechanics = "You don't need to press z to pull the string back on a bow, instead you can just spam click to fire rapidly."
	conflicts = list(
		/datum/quirk/clumsy,
		/datum/quirk/masterrifleman,
	)
	mob_trait = TRAIT_AUTO_DRAW
	gain_text = span_notice("You feel like all that training with bows has paid off.")
	lose_text = span_danger("Guns were always better...")
	medical_record_text = "Patient shows aptitude for utilizing strings on sticks."
	locked =  FALSE
	human_only = FALSE

/datum/quirk/masterrifleman
	name = "Bolt Worker"
	desc = "You've spent a lot of time working the bolt of a rifle, or the pump action of a shotgun. Your skill allows you to click to work the action instead of doing it manually."
	value = 14
	category = "Ranged Quirks"
	mechanics = "You don't need to press z to rack the bolt of your rifle, instead you can just spam click to fire rapidly."
	conflicts = list(
		/datum/quirk/clumsy,
		/datum/quirk/bowtrained,
	)
	mob_trait = TRAIT_FAST_PUMP
	gain_text = span_notice("In a sudden haze you realize that the Mosin Nagant was Gods gift to mankind.")
	lose_text = span_danger("After picking some 250 year old cosmoline out from under one of your nails you realize that... Uh, no, the Mosin Nagant is a piece of shit.")
	medical_record_text = "Patient appears to really enjoy cranking bolts."
	locked =  FALSE
	human_only = FALSE

/datum/quirk/wandproficient
	name = "Magically Attuned"
	desc = "You were either born with a natural inclination for magic or were taught its secrets."
	value = 0
	category = "Ranged Quirks"
	mechanics = "You can use magical wands, staves, and other advanced magical items. However, magic has a cost -- your potential elsewhere is limited, and learning a martial art will sever your connection to magic."
	conflicts = list(
	// /datum/quirk/deadeye,
	/datum/quirk/mastermartialartist,
	)

	mob_trait = TRAIT_WAND_PROFICIENT
	gain_text = span_notice("You feel magic flowing through your veins!")
	lose_text = span_danger("The magic within you fades away.")
	medical_record_text = "Patient exudes an unknown pattern on the monitor. Further analysis required."
	locked = FALSE
	human_only = FALSE

/datum/quirk/playdead
	name = "Play Dead"
	desc = "You're good at acting!"
	value = 14
	category = "Functional Quirks"
	mechanics = "Your *deathgasp will be extra convincing to rudimentary tests, such as healthhuds and examine, doing so may deal a small quantity of toxin damage."
	conflicts = list()
	mob_trait = TRAIT_PLAY_DEAD
	gain_text = span_notice("You feel confident at playing dead.")
	lose_text = span_danger("You feel that laying down in a field of gunfire may not be such a good idea after all.")
	medical_record_text = "Patient has failed heart monitoring tests multiple times."
	locked =  FALSE

/*
/datum/quirk/packrat
	name = "Packrat"
	desc = "You are well practiced at hoarding random junk, and can carry nearly double what most others can."
	value = 34
	category = "Functional Quirks"
	mechanics = "You can carry a second backpack or duffel bag in your suit slot, for additional stuff!"
	conflicts = list()
	mob_trait = TRAIT_PACKRAT
*/

/*
/datum/quirk/ratfriend
	name = "Beast Friend - Rats"
	desc = "Rats and wild mice of all kind outright ignore you now."
	value = 14
	category = "Critter Quirks"
	mechanics = "Rats and mice share their faction with you, meaning they won't do anything about you or care at all that you exist."
	conflicts = list(
		/datum/quirk/ratmaster,
		/datum/quirk/ratphobia,
	)
	mob_trait = TRAIT_BEASTFRIEND_RAT
	gain_text = span_notice("Rats are friends!")
	lose_text = span_danger("God of rats curses your name...") // Perhaps make killing related mobs lose the quirk?
	medical_record_text = "Patient talks about rats a lot."
	locked = FALSE
	human_only = FALSE

/datum/quirk/ratfriend/add()
	var/mob/living/H = quirk_holder
	H.faction |= list("rat-friend")

/datum/quirk/ratfriend/remove()
	var/mob/living/H = quirk_holder
	if(H)
		H.faction -= list("rat-friend")

/datum/quirk/ratmaster
	name = "Beast Master - Rats"
	desc = "Whenever by psychic means or not, you gained ability to summon and control the rats of Wasteland (except giant ones).\
	<br>You also able to tame wild ones. This will make them passive toward other players and tamed fauna (but also makes them a target for wild rats)."
	value = 22
	category = "Critter Quirks"
	mechanics = "You can summon up rat nests on the fly and order them around! Your rats aren't in the same faction as wild rats though, so they'll fight each other. You can tame the wild ones though, if you're lucky.\
	<br><font color='#ff2929ff'>If you want to control giant rats, you will need Beast Master - Small Critters.</font>" // Why this sounds like DLC talk
	conflicts = list(
		/datum/quirk/ratfriend,
		/datum/quirk/ratphobia,
	)
	mob_trait = TRAIT_BEASTMASTER_RAT
	gain_text = span_notice("You feel like being a giant rat, that makes all of the rules!")
	lose_text = span_danger("You've lost your rat crown...")
	medical_record_text = "Patient REALLY loves to talk about rats."
	locked = FALSE
	var/obj/effect/proc_holder/mob_common/taming_mobs/rat/tame
	var/obj/effect/proc_holder/mob_common/summon_backup/beastmaster/rat/gather
	var/obj/effect/proc_holder/mob_common/direct_mobs/beastmaster/rat/moveto
	var/obj/effect/proc_holder/mob_common/make_nest/rat/tame/make
	var/obj/effect/proc_holder/mob_common/unmake_nest/clear
// Damn this action button code structure

/datum/quirk/ratmaster/add()
	var/mob/living/carbon/human/H = quirk_holder
	H.faction |= list("rat-friend")
	tame = new
	H.AddAbility(tame)
	gather = new
	H.AddAbility(gather)
	moveto = new
	H.AddAbility(moveto)
	make = new
	H.AddAbility(make)
	clear = new
	H.AddAbility(clear)

/datum/quirk/ratmaster/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.faction -= list("rat-friend")
		H.RemoveAbility(tame)
		QDEL_NULL(tame)
		H.RemoveAbility(gather)
		QDEL_NULL(gather)
		H.RemoveAbility(moveto)
		QDEL_NULL(moveto)
		H.RemoveAbility(make)
		QDEL_NULL(make)
		H.RemoveAbility(clear)
		QDEL_NULL(clear)

/datum/quirk/critterfriend
	name = "Beast Friend - Small Critters"
	desc = "You're basically a disney princess when it comes to some of the lesser critters of the swamplands."
	value = 14
	category = "Critter Quirks"
	mechanics = "Specifically pillbugs, geckos and young nightstalkers treat you as being a faction friend. Ignoring you outright."
	conflicts = list(
		/datum/quirk/crittermaster,
	)
	mob_trait = TRAIT_BEASTFRIEND_SMALLCRITTER
	gain_text = span_notice("Some of the wasteland critters don't seem to mind you now!")
	lose_text = span_danger("You feel as if some of the critters in the wasteland grow hostile towards you...")
	medical_record_text = "Patient seems to possess a calm aura."
	locked = FALSE
	human_only = FALSE

/datum/quirk/critterfriend/add()
	var/mob/living/H = quirk_holder
	H.faction |= list("critter-friend")

/datum/quirk/critterfriend/remove()
	var/mob/living/H = quirk_holder
	if(H)
		H.faction -= list("critter-friend")

/datum/quirk/crittermaster
	name = "Beast Master - Small Critters"
	desc = "Whenever by psychic means or not, you gained ability to control pillbugs, most geckos and giant rats (last ones will be initially hostile and needs to be tamed).\
	<br>Taming will make them passive toward other players and tamed fauna. Young and adult nightstalkers can also be tamed, but not controlled."
	value = 34
	category = "Critter Quirks"
	mechanics = "You can tame and order around pillbugs, geckos (not all of the full variety pack though) and giant rats. While unable to attack players with them, they're a great distraction for fighting other mobs with."
	conflicts = list(
		/datum/quirk/critterfriend,
	)
	mob_trait = TRAIT_BEASTMASTER_SMALLCRITTER
	gain_text = span_notice("You tapped into the potential of the critter horde!")
	lose_text = span_danger("Small critters refuse to obey your commands now.")
	medical_record_text = "Patient claims to have a telepathic connection to animals. Sounds like crazy talk."
	locked = FALSE
	var/obj/effect/proc_holder/mob_common/taming_mobs/small_critter/tame
	var/obj/effect/proc_holder/mob_common/summon_backup/beastmaster/small_critter/gather
	var/obj/effect/proc_holder/mob_common/direct_mobs/beastmaster/small_critter/moveto

/datum/quirk/crittermaster/add()
	var/mob/living/carbon/human/H = quirk_holder
	H.faction |= list("critter-friend")
	tame = new
	H.AddAbility(tame)
	gather = new
	H.AddAbility(gather)
	moveto = new
	H.AddAbility(moveto)

/datum/quirk/crittermaster/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.faction -= list("critter-friend")
		H.RemoveAbility(tame)
		QDEL_NULL(tame)
		H.RemoveAbility(gather)
		QDEL_NULL(gather)
		H.RemoveAbility(moveto)
		QDEL_NULL(moveto)

/datum/quirk/beesfriend
	name = "Beast Friend - Radbees"
	desc = "Rad-bees are not going to attack upon seeing you. Good for wasteland apiarists!"
	value = 14
	category = "Critter Quirks"
	mechanics = "Radbees share their faction with you, meaning they won't do anything about you or care at all that you exist."
	mob_trait = TRAIT_BEASTFRIEND_BEE
	gain_text = span_notice("(Rad)Bee not afraid!")
	lose_text = span_danger("(Rad)BEE AFRAID!!")
	medical_record_text = "Patient talks about bees a lot. Radiated ones, specifically."
	locked = FALSE
	human_only = FALSE

/datum/quirk/beesfriend/add()
	var/mob/living/H = quirk_holder
	H.faction |= list("bees-friend")

/datum/quirk/beesfriend/remove()
	var/mob/living/H = quirk_holder
	if(H)
		H.faction -= list("bees-friend")
*/

/datum/quirk/wildshape
	name = "Wild Shape"
	desc = "You've developed through some means the ability to adopt a lesser form. What you become was decided by yourself or mere circumstance, but you can transform back and forth at will."
	value = 15
	category = "Mutant Quirks"
	mechanics = "You gain the shapeshift spell and can cast it nearly at will! This allows you to transform into an animal and back again. Once you select a shape, it cannot be changed."
	conflicts = list(

	)
	mob_trait = TRAIT_WILDSHAPE
	gain_text = span_notice("You feel as if your spirit animal is ready to come out and play!")
	lose_text = span_danger("You no longer have any desires of changing at will.")
	medical_record_text = "Patient appears to be wild, in some form or another."
	locked = FALSE
	var/obj/effect/proc_holder/spell/targeted/shapeshift/wildshape


/datum/quirk/wildshape/add()
	var/mob/living/carbon/human/H = quirk_holder
	wildshape = new
	H.AddSpell(wildshape)

/datum/quirk/wildshape/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.RemoveSpell(wildshape)
		QDEL_NULL(wildshape)

/datum/quirk/zoomies
	name = "Zoomies"
	desc = "Physical prowess, mutation, or cybernetic enhancement, you can sprint a good deal longer than most folk. Justt don't run into things."
	value = 14
	category = "Movement Quirks"
	mechanics = "You use 25% less stamina while sprinting! Just don't run into anything or it will hurt more than normal."
	conflicts = list(
		/datum/quirk/cantrun,
		/datum/quirk/super_zoomies,
	)
	mob_trait = TRAIT_ZOOMIES
	gain_text = span_notice("You feel all pumped up!")
	lose_text = span_danger("You no longer have the zoomies...")
	medical_record_text = "Patient is incredibly giddy, full of zoomies."

/datum/quirk/super_zoomies
	name = "Zoomies - Super"
	desc = "Frenetic energy, densified leg-muscles, or cyber-organs, you can sprint way longer than most folk. Just... REALLY don't run into things. Seriously."
	value = 28
	category = "Movement Quirks"
	mechanics = "You use 50% less stamina while sprinting! Seriously, though, be careful running into things, it could break your back."
	conflicts = list(
		/datum/quirk/cantrun,
		/datum/quirk/zoomies,
	)
	mob_trait = TRAIT_SUPER_ZOOMIES
	gain_text = span_notice("You feel SUPER pumped up!")
	lose_text = span_danger("You no longer have the giga zoomies...")
	medical_record_text = "Patient is full of way too much energy, and has not stopped running around my office as of writing."

/*/datum/quirk/artifact_identify
	name = "Artifact Hunter"
	desc = "You have a keen eye for identifying magical, otherworldly trash! You can identify artifacts at a glance."
	value = 32
	category = "Lifepath Quirks"
	mechanics = "You have no wait time when it comes to identifying artifacts."
	conflicts = list()
	mob_trait = TRAIT_ARTIFACT_IDENTIFY
	gain_text = span_notice("You feel perceptive towards ancient artifacts.")
	lose_text = span_danger("You feel as if you lost the knack for identifying ancient objects.")
	medical_record_text = "Patient claims to know about alien, or some form of ancient technology."
	locked =  FALSE
	human_only = FALSE*/ // Artifacts are identified in 5 seconds, potential change in the future to let you spawn with an artifact

/datum/quirk/armblader
	name = "Arm Blader"
	desc = "Through some genetic quirk you have access to horrifying arm blades made out of bone with the *armblade verb."

	value = 32
	category = "Mutant Quirks"
	mechanics = "Your arm can turn into a horrible flesh blade."
	conflicts = list()
	mob_trait = TRAIT_ARMBLADE
	gain_text = span_notice("You feel as your arm is heavier...")
	lose_text = span_danger("Your arm feels lighter...")
	medical_record_text = "Patient appears to possess a knife, somehow."
	human_only = FALSE


/datum/quirk/mantisblade
	name = "Cybernetic Arm Blader"
	desc = "Through some cybernetic modifications, you have access to horrifying arm cyberblade with the *cyber verb."

	value = 32
	category = "Mutant Quirks"
	mechanics = "Your arm can turn into a horrifying cyberblade"
	conflicts = list()
	mob_trait = TRAIT_CYBERKNIFE
	gain_text = span_notice("You feel as your arm is heavier...")
	lose_text = span_danger("Your arm feels lighter...")
	medical_record_text = "Patient appears to possess a cybernetic armblade."
	human_only = FALSE

/datum/quirk/tentaclearm
	name = "Arm Tentacle"
	desc = "Through some genetic quirk you have access to horrifying arm tentacle to grab people and mobs with. Use *tentarm verb to summon it."
	value = 28 // You grab an item from a distance, auto-activates grenades in your hand, its not great, but not terrible.
	category = "Mutant Quirks"
	mechanics = "Your arm can turn into a horrible meat bludgeon."
	conflicts = list()
	mob_trait = TRAIT_ARMTENT
	gain_text = span_notice("You feel as your arm is wriggling...")
	lose_text = span_danger("Your arm feels lighter...")
	medical_record_text = "Patient appears to possess a club, somehow."

/datum/quirk/magegrab
	name = "Mage Grab" // Better name pending
	desc = "Through some powerful spell, you can now grab items from a distance. Effectively identical to tentacle arms, but not tentacles."
	value = 28
	category = "Magic Quirks"
	mechanics = "You can fire a beam that teleports items into your hand, or drags mobs to you."
	conflicts = list()
	mob_trait = TRAIT_MAGEGRAB

/datum/quirk/bigbiter
	name = "Biter - Big"
	desc = "Your jaws are just absolutley massive.  You *bite harder, but a bit slower."
	value = 22
	category = "Biter Quirks"
	mechanics = "When using *bite your jaws do increased damage compared to normal but with a slower attack speed."
	conflicts = list(
		/datum/quirk/fastbiter,
		/datum/quirk/playbiter,
		/datum/quirk/spicybiter,
		/datum/quirk/sabrebiter,
	)
	mob_trait = TRAIT_BIGBITE
	gain_text = span_notice("Your bite strength feels like that of a gator!")
	lose_text = span_danger("Your mouth feels incredibly sore.")
	medical_record_text = "Patient appears to chew through bone like nothing."
	human_only = FALSE

/datum/quirk/fastbiter
	name = "Biter - Fast"
	desc = "Your jaws are just UBELIEVABLY FAST.  Use *bite to bite like the WIND."
	value = 22
	category = "Biter Quirks"
	mechanics = "When using *bite your jaws do less damage compared to normal but with a faster attack speed."
	conflicts = list(
		/datum/quirk/bigbiter,
		/datum/quirk/playbiter,
		/datum/quirk/spicybiter,
		/datum/quirk/sabrebiter,
	)
	mob_trait = TRAIT_FASTBITE
	gain_text = span_notice("Your mouth feels capable of nibbling a LOT!")
	lose_text = span_danger("Your mouth feels all gunked up.")
	medical_record_text = "Patient bites. A lot."
	human_only = FALSE

/datum/quirk/playbiter
	name = "Biter - Pretend"
	desc = "Your biter is a little love nipper."
	value = 0
	category = "Biter Quirks"
	mechanics = "When using *bite you do no damage (unless you have big/small leagues!)"
	conflicts = list(
		/datum/quirk/bigbiter,
		/datum/quirk/fastbiter,
		/datum/quirk/spicybiter,
		/datum/quirk/sabrebiter,
	)
	mob_trait = TRAIT_PLAYBITE
	gain_text = span_notice("Your feel your bite strength leave your jaw...")
	lose_text = span_danger("Your bite strength returns!")
	medical_record_text = "Patient has bit me before. It did not hurt."
	human_only = FALSE

/datum/quirk/spicybiter
	name = "Biter - Venomous"
	desc = "One way or another your *bite can inject a strong paralytic venom of some kind!"
	value = 22
	category = "Biter Quirks"
	mechanics = "Your bite does stamina damage to both players and mobs, but less brute damage overall."
	conflicts = list(
		/datum/quirk/bigbiter,
		/datum/quirk/fastbiter,
		/datum/quirk/playbiter,
		/datum/quirk/sabrebiter,
	)
	mob_trait = TRAIT_SPICYBITE
	gain_text = span_notice("You feel your teeth secrete a viscous fluid.")
	lose_text = span_danger("You no longer secrete venom.")
	medical_record_text = "Patient has caused numbing in my arm. We really need a better way to test bites."
	human_only = FALSE

/datum/quirk/sabrebiter
	name = "Biter - Sabre Toothed"
	desc = "Your *bite strength is ENORMOUS, but it takes all your focus to use it."
	value = 32
	category = "Biter Quirks"
	mechanics = "Your bite is the biggest bite, and the slowest."
	conflicts = list(
		/datum/quirk/bigbiter,
		/datum/quirk/fastbiter,
		/datum/quirk/playbiter,
		/datum/quirk/spicybiter,
	)
	mob_trait = TRAIT_SABREBITE
	gain_text = span_notice("Your teeth suddenly becomes incredibly large and heavy!")
	lose_text = span_danger("Your teeth suddenly shrink and become light once more!")
	medical_record_text = "Patient has incredibly large teeth."
	human_only = FALSE

/datum/quirk/bigclawer
	name = "Clawer - Big"
	desc = "Your claws are just absolutley massive.  Your *claw attack hits harder, but a bit slower."
	value = 22
	category = "Clawer Quirks"
	mechanics = "When using *claw your claws do more damage compared to normal but with a slower attack speed."
	conflicts = list(
		/datum/quirk/fastclawer,
		/datum/quirk/playclaw,
		/datum/quirk/spicyclaw,
		/datum/quirk/razorclaw,
	)
	mob_trait = TRAIT_BIGCLAW
	gain_text = span_notice("You claws harden, they feel capable of through metal!")
	lose_text = span_danger("Your claws soften.")
	medical_record_text = "Patient is capable of shredding through a locker."
	human_only = FALSE

/datum/quirk/fastclawer
	name = "Clawer - Fast"
	desc = "Your claw swipes are nearly the speed of sound, your *claw attack hits WAY faster."
	value = 22
	category = "Clawer Quirks"
	mechanics = "When using *claw your claws do less damage than normal, but with a faster attack speed."
	conflicts = list(
		/datum/quirk/bigclawer,
		/datum/quirk/playclaw,
		/datum/quirk/spicyclaw,
		/datum/quirk/razorclaw,
	)
	mob_trait = TRAIT_FASTCLAW
	gain_text = span_notice("Your claws feel very aerodynamic!")
	lose_text = span_danger("You suddenly feel clumsy swinging your claws around...")
	medical_record_text = "Patient claims to scratch at things. A lot."
	human_only = FALSE

/datum/quirk/playclaw
	name = "Clawer - Pretend"
	desc = "Your claws are for being silly, not dangerous."
	value = 0
	category = "Clawer Quirks"
	mechanics = "Your claws, when used with the *claw verb do no damage at all unless you have big/small leagues."
	conflicts = list(
		/datum/quirk/bigclawer,
		/datum/quirk/fastclawer,
		/datum/quirk/spicyclaw,
		/datum/quirk/razorclaw,
	)
	mob_trait = TRAIT_PLAYCLAW
	gain_text = span_notice("Your claws feel almost like rubber!")
	lose_text = span_danger("Your claws suddenly return to normal.")
	medical_record_text = "Patient claims to be weak at scratching."
	human_only = FALSE

/datum/quirk/spicyclaw
	name = "Clawer - Venomous"
	desc = "Something about your claws cause weakness in those you rake, use *claw to stun mobs/players."
	value = 22
	category = "Clawer Quirks"
	mechanics = "When using *claw your claws do stamina damage on top of their normal damage, letting you stun players & mobs."
	conflicts = list(
		/datum/quirk/bigclawer,
		/datum/quirk/fastclawer,
		/datum/quirk/playclaw,
		/datum/quirk/razorclaw,
	)
	mob_trait = TRAIT_SPICYCLAW
	gain_text = span_notice("You feel a viscous fluid secrete from your claws!")
	lose_text = span_danger("You no longer feel venom drip from your claws.")
	medical_record_text = "Patient has momentarily numbed me after a bad handshake."
	human_only = FALSE

/datum/quirk/razorclaw
	name = "Clawer - Razors"
	desc = "Your *claw attack really does rend and tear huge guts."
	value = 32
	category = "Clawer Quirks"
	mechanics = "When using *claw your claws do CRAZY good damage (for claws, anyway), but a bit slower overall."
	conflicts = list(
		/datum/quirk/bigclawer,
		/datum/quirk/fastclawer,
		/datum/quirk/playclaw,
		/datum/quirk/spicyclaw,
	)
	mob_trait = TRAIT_RAZORCLAW
	gain_text = span_notice("RIP AND TEAR, your claws are now much stronger!")
	lose_text = span_danger("You no longer feel like ripping anything up.")
	medical_record_text = "Patient appears to enjoy clawing everything up."
	human_only = FALSE

//tail

/datum/quirk/bigtail
	name = "Tail - Big"
	desc = "You got that big tail, good for big wumps. Use with *tailer"
	value = 22
	category = "Tailer Quirks"
	mob_trait = TRAIT_TAILSMASH
	gain_text = span_notice("Your tail is suddenly much larger.")
	lose_text = span_danger("Your tail is suddenly smaller.")
	medical_record_text = "Patient has a large tail."
	human_only = FALSE

/datum/quirk/fasttail
	name = "Tail - Whiplike"
	desc = "You got that FAST tail, good for whipping about. Use with *tailer"
	value = 22
	category = "Tailer Quirks"
	mob_trait = TRAIT_TAILWHIP
	gain_text = span_notice("Your tail is now much lighter!")
	lose_text = span_danger("Your tail feels heavy.")
	medical_record_text = "Patient has a heavy tail."
	human_only = FALSE

/datum/quirk/playtail
	name = "Tail - Playful"
	desc = "Your tail is just a soft extension of the rest of you. use with *tailer"
	value = 0
	category = "Tailer Quirks"
	mob_trait = TRAIT_TAILPLAY
	gain_text = span_notice("Your tail feels very soft and plush.")
	lose_text = span_danger("Your tail feels rough and raggedy.")
	medical_record_text = "Patient has a very soft tail."
	human_only = FALSE

/datum/quirk/spicytail
	name = "Tail - Venomous"
	desc = "One way or another your *tailer verb is capable of inflicting venomous attacks with your tail!"
	value = 22
	category = "Tailer Quirks"
	mob_trait = TRAIT_TAILSPICY
	gain_text = span_notice("Your tail secretes a viscous fluid.")
	lose_text = span_danger("Your tail no longer produces venom.")
	medical_record_text = "Patient appears to have a paralytic tail."
	human_only = FALSE

/datum/quirk/thagotail
	name = "Tail - Thagomizer"
	desc = "A very dangerous *tailer, for beating the snot out of things."
	value = 32
	category = "Tailer Quirks"
	mob_trait = TRAIT_TAILTHAGO
	gain_text = span_notice("Your tail feels like a bludgeon!")
	lose_text = span_danger("Your tail suddenly feels weak.")
	medical_record_text = "Patient tripped me over with their tail this morning. Please be aware of it."
	human_only = FALSE

//Cantrips//
/datum/quirk/shocking
	name = "Shocking Grasp"
	desc = "You know how to cast the shocking grasp cantrip"
	value = 32
	category = "Magic Quirks"
	mechanics = "When using the *shocking emote, you summon a melee spell cantrip that strikes fast and delivers powerful shocks to your foes"
	conflicts = list(
		// /datum/quirk/littleleagues,
		// /datum/quirk/bigleagues
	)
	mob_trait = TRAIT_SHOCKINGGRASP
	gain_text = span_notice("You know how to cast shocking grasp!")
	lose_text = span_danger("You no longer know how to cast shocking grasp!.")
	human_only = FALSE

/datum/quirk/telepathy
	name = "Innate Telepathy"
	desc = "You innately have the ability to project your thoughts directly into the minds of others."
	value = 0 
	category = "Magic Quirks"
	mechanics = "You can use a telepathy spell to speak to others' minds directly. However, you and your target will glow so it's quite obvious you casted it."
	// conflicts = list(/datum/quirk/mute) // Negligibly useful quirk shouldnt cost points or slots, but also shouldnt make a big negative into free points. Also you can get telepathy through genetics, which is easier now.
	mob_trait = TRAIT_TELEPATHY
	gain_text = span_notice("You suddenly don't feel the need to talk out loud anymore.")
	lose_text = span_danger("Talking out loud suddenly feels like a much better idea.")
	medical_record_text = "Patient appears to posess the ability to speak directly to the minds of others."
	human_only = FALSE

/datum/quirk/telepathy/add()
	quirk_holder.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/telepathy/quirk)

/datum/quirk/telepathy/remove()
	if(LAZYLEN(quirk_holder?.mind?.spell_list))
		for(var/s in quirk_holder?.mind?.spell_list)
			if(istype(s, /obj/effect/proc_holder/spell/targeted/telepathy/quirk))
				quirk_holder.mind.RemoveSpell(s)

//datum/quirk/booming
	//name = "Booming Blade"
	//desc = "You know how to cast the booming blade cantrip"
	//value = 44
	//category = "Cantrips"
	//mechanics = "When using the *booming emote, you summon a magic sword able to tag foes for extra damage on the next hit."
	//conflicts = list(
		//datum/quirk/littleleagues,
		//datum/quirk/bigleagues
	//)
	//mob_trait = TRAIT_BOOMING
	//gain_text = span_notice("You know how to cast booming blade!")
	//lose_text = span_danger("You no longer know how to cast booming blade!.")


///QUIRK PACKAGES/// QUACKAGES IF YOU WILL
//Read it all, you're a big peoples, I believe in you.

//The Purpose of these quirks is to be ready made character design concepts, they will include positive and negative quirks packaged together to ease character creation.

//If the Quackage is all positive quirks then you should add the point cost of all the quirks involved and add 20% on top, this will mean that taking it is more expensive
//than to have taken the quirks individually, but it only takes up one good quirk slot.  The 20% number referenced above is really just a starting point, honestly
//follow your fucking heart, you're probably smarter than I am. ~TK420634

//If the quackage includes negative quirks, be sure to make it very clear in the mechanics variable that you have included that negative, do not jump negative quirks on players
//without properly warning them of what exactly they're getting into. Be sure also to make the conflict list include all the quirks that the trait includes, positive and negative.
//That way players don't waste precious character design points on taking quirks they already have in their quackage.

//Be wary of overloading the donkey, there really should be a hard limit to what you're thematically tyring to glue together here. These are supposed to be plug and play
//character archetypes, not entire builds that are ready made. Though, if you're willing to put in the forethought and really plan it out I can't say that there would be a problem
//with maybe making a Class category that is analgous to the Class quirks in the rp category. It would, honestly, simplify character creation some.

//What follows is the code for Former Tribal, commented out, to be used as a reference for creating Quackages that include both quirks and recipes.
/*
/datum/quirk/tribal
	name = "Former Tribal"
	desc = "You used to be part of one of the tribes scattered throughout the wasteland. You may have some additional skills as a result. Allowing you to make some tribal medical supplies. Advanced tech still confuses you though."
	value = 22
	category = "Lifepath Quirks"
	mechanics = "Grants access to a wide variety of recipes and allows you to use primitive chemmasters with which you can make complex potions/poisons."
	conflicts = list(
		/datum/quirk/technophreak,
		/datum/quirk/tribal_tech,
		)
	gain_text = span_notice("You remember the old ways of your tribe..")
	lose_text = span_notice("You've forgotten the ways of your ancestors..")

/datum/quirk/tribal/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_MACHINE_SPIRITS, "Former Tribal")
	ADD_TRAIT(H, TRAIT_TRIBAL, "Former Tribal")
	ADD_TRAIT(H, TRAIT_FORMER_TRIBAL, "ex_tribal_traditions")
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.former_tribal_recipes

/datum/quirk/tribal/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_MACHINE_SPIRITS, "Former Tribal")
		REMOVE_TRAIT(H, TRAIT_TRIBAL, "Former Tribal")
		H.mind.learned_recipes -= GLOB.former_tribal_recipes
		*/

//Use this to prototype building your Quackage, or of course reference the ones that will exist below this.

//Quackages Start Here//

/*
/datum/quirk/package/lifeoftheparty
	name = "Life of the Party"
	desc = "You were just meant to be the center of attention, and you revel when all eyes are on you!"
	value = 35
	category = "Quirk Packages"
	mechanics = "Grants access to positive Quirks Musician and Friendly!"
	conflicts = list(
		/datum/quirk/musician,
		/datum/quirk/friendly,
		)
	gain_text = span_notice("You realize you are THE life of THE party that is life!")
	lose_text = span_notice("Maybe you're really just a nobody...?")

/datum/quirk/package/lifeoftheparty/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_MUSICIAN, "Musician")
	ADD_TRAIT(H, TRAIT_FRIENDLY, "Friendly")


/datum/quirk/package/lifeoftheparty/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_MUSICIAN, "Musician")
		REMOVE_TRAIT(H, TRAIT_FRIENDLY, "Friendly")

/datum/quirk/package/lifeoftheparty/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/choice_beacon/music/B = new(get_turf(H))
	H.put_in_hands(B)
	H.equip_to_slot_if_possible(B, SLOT_IN_BACKPACK)
	var/obj/item/musicaltuner/musicaltuner = new(get_turf(H))
	H.put_in_hands(musicaltuner)
	H.equip_to_slot_if_possible(musicaltuner, SLOT_IN_BACKPACK)
	H.regenerate_icons()

/datum/quirk/package/bruiser
	name = "Bruiser"
	desc = "You're a big guy."
	value = 150
	category = "Quirk Packages"
	mechanics = "Grants access to positive Big Leagues & Health - Tougher!"
	conflicts = list(
		/datum/quirk/bigleagues,
		/datum/quirk/littleleagues,
		/datum/quirk/lifegiverplus,
		/datum/quirk/flimsy,
		/datum/quirk/veryflimsy
		)
	gain_text = span_notice("DAMN BRO YOU SWOLE!")
	lose_text = span_notice("Maybe you could skip gym day...")
	human_only = FALSE

/datum/quirk/package/bruiser/add()
	var/mob/living/H = quirk_holder
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, "Melee - Big Leagues")
	ADD_TRAIT(H, TRAIT_LIFEGIVERPLUS, "Health - Tougher")


/datum/quirk/package/bruiser/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_BIG_LEAGUES, "Melee - Big Leagues")
		REMOVE_TRAIT(H, TRAIT_LIFEGIVERPLUS, "Health - Tougher")

/datum/quirk/package/parkour
	name = "Rooftop Nomad"
	desc = "You like parkour. Like, a lot a lot."
	value = 70
	category = "Quirk Packages"
	mechanics = "Grants access to positive quirks Freerunning and Advanced Leaper!"
	conflicts = list(
		/datum/quirk/freerunning,
		/datum/quirk/tackleradv,
		/datum/quirk/slower,
		/datum/quirk/slow,
		/datum/quirk/clumsy,
		/datum/quirk/cantrun,
		/datum/quirk/overweight,
		/datum/quirk/tacklerapex,
		/datum/quirk/tackler
		)
	gain_text = span_notice("Hardcore parkour!")
	lose_text = span_notice("Parkour's just not in style anymore...")

/datum/quirk/package/parkour/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_FREERUNNING, "Freerunning")
	ADD_TRAIT(H, TRAIT_TACKLERADV, "Advanced Leaper")
	H.AddComponent(/datum/component/tackler/simple, \
		stamina_cost = 20, \
		base_knockdown = 0 SECONDS, \
		range = 7, \
		speed = 2, \
		skill_mod = -2, \
		min_distance = 0 \
)


/datum/quirk/package/parkour/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_FREERUNNING, "Freerunning")
		REMOVE_TRAIT(H, TRAIT_TACKLERADV, "Advanced Leaper")

/datum/quirk/package/hvyhitter
	name = "Heavy Hitter"
	desc = "You're well practiced in hand to hand combat."
	value = 80
	category = "Quirk Packages"
	mechanics = "Grants access to positive Sure Strike & Fists of Steel!"
	conflicts = list(
		/datum/quirk/steel_fist,
		/datum/quirk/surestrike,
		/datum/quirk/nonviolent,
		/datum/quirk/iron_fist,
		/datum/quirk/noodle_fist,
		/datum/quirk/mastermartialartist
		)
	gain_text = span_notice("Your knuckles are calloused.")
	lose_text = span_notice("Your hands feel soft again...")

/datum/quirk/package/hvyhitter/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_PERFECT_ATTACKER, "Sure Strike")
	ADD_TRAIT(H, TRAIT_STEELFIST, "Fists of Steel")


/datum/quirk/package/hvyhitter/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_PERFECT_ATTACKER, "Sure Strike")
		REMOVE_TRAIT(H, TRAIT_STEELFIST, "Fists of Steel")

/datum/quirk/package/hvyhitter/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.dna.species.punchdamagelow = STEEL_FIST_PUNCH_DAMAGE_LOW
	H.dna.species.punchdamagehigh = STEEL_FIST_PUNCH_DAMAGE_MAX

/datum/quirk/package/Ranger
	name = "Ranger"
	desc = "Bow in hand, and rat in back pocket, the swamplands is your home."
	value = 35
	category = "Quirk Packages"
	mechanics = "Grants access to positive quirks Bow Trained, and Beast Friends - Small Critters."
	conflicts = list(
		/datum/quirk/bowtrained,
		/datum/quirk/critterfriend
		)
	gain_text = span_notice("These lands are your home.")
	lose_text = span_notice("Where the heck am I????")
	human_only = FALSE

/datum/quirk/package/ranger/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_AUTO_DRAW, "Bow Trained")
	ADD_TRAIT(H, TRAIT_BEASTFRIEND_SMALLCRITTER, "Beast Friend - Small Critters")


/datum/quirk/package/ranger/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_AUTO_DRAW, "Bow Trained")
		REMOVE_TRAIT(H, TRAIT_BEASTFRIEND_SMALLCRITTER, "Beast Friend - Small Critters")

/datum/quirk/package/hunter
	name = "Big Game Hunter"
	desc = "With your trusty Thirty Aught something another you know you can down any critter you plan on hunting."
	value = 65
	category = "Quirk Packages"
	mechanics = "Grants access to positive Bolt Worker & Straight Shooter."
	conflicts = list(
		/datum/quirk/masterrifleman,
		/datum/quirk/straightshooter,
		/datum/quirk/deadeye
		)
	gain_text = span_notice("Aim just behind behind the front leg...")
	lose_text = span_notice(".223 is probably overkill for deer...")
	human_only = FALSE

/datum/quirk/package/hunter/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_FAST_PUMP, "Bolt Worker")
	ADD_TRAIT(H, TRAIT_NICE_SHOT, "Straight Shooter")


/datum/quirk/package/hunter/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_FAST_PUMP, "Bolt Worker")
		REMOVE_TRAIT(H, TRAIT_NICE_SHOT, "Straight Shooter")

/datum/quirk/package/legendarywepsm
	name = "Weaponsmith - Legendary"
	desc = "You're just that good at making weapons. Maybe you should make a career out of this?"
	value = 55
	category = "Quirk Packages"
	mechanics = "Grants access to Weaponsmith Basic and Masterwork."
	conflicts = list(
		/datum/quirk/gunsmith,
		/datum/quirk/masterworksmith,
	)

/datum/quirk/package/legendarywepsm/add()
	var/mob/living/H = quirk_holder
	ADD_TRAIT(H, TRAIT_MASTERWORKSMITH, "Weaponsmith - Masterwork")
	ADD_TRAIT(H, TRAIT_WEAPONSMITH, "Weaponsmith - Basic")
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.weaponcrafting_gun_recipes
	H.mind.learned_recipes |= GLOB.weapons_of_texarkana

/datum/quirk/package/legendarywepsm/remove()
	var/mob/living/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_MASTERWORKSMITH, "Weaponsmith - Masterwork")
		REMOVE_TRAIT(H, TRAIT_WEAPONSMITH, "Weaponsmith - Basic")
	if(H)
		H.mind.learned_recipes -= GLOB.weaponcrafting_gun_recipes

/datum/quirk/package/reformedtribal
	name = "Reformed Tribal Chemist"
	desc = "You've left your tribe and decided that science is what you seek."
	value = 55
	category = "Quirk Packages"
	mechanics = "Grants access to positive trait Primitive Tech & Chemwiz."
	conflicts = list(
		/datum/quirk/tribal_tech,
		/datum/quirk/chemwhiz,
		/datum/quirk/dumb
		)
	gain_text = span_notice("The secrets of chemistry are all laid out before you...")
	lose_text = span_notice("Sulphur?  I barely know her!")

/datum/quirk/package/reformedtribal/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_MACHINE_SPIRITS, "Primitive Tech")
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, "Chem Whiz")
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.chemwhiz_recipes


/datum/quirk/package/reformedtribal/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_MACHINE_SPIRITS, "Primitive Tech")
		REMOVE_TRAIT(H, TRAIT_CHEMWHIZ, "Chem Whiz")
	if(H)
		H.mind.learned_recipes -= GLOB.chemwhiz_recipes

/datum/quirk/package/creatureofthewildsevi
	name = "Creature of the Wilds - Eviscerator"
	desc = "You are massively in tune with your wild side. Especially the part that slices and bites like crazy."
	value = 53
	category = "Quirk Packages"
	mechanics = "Grants access to positive trait Fast Clawer & Fast Biter."
	conflicts = list(
		/datum/quirk/fastbiter,
		/datum/quirk/fastclawer
		)
	gain_text = span_notice("bitebitebitebiteclawclawclawclaw!")
	lose_text = span_notice("I could use a scone...")

/datum/quirk/package/creatureofthewildsevi/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_FASTCLAW, "Clawer - Fast")
	ADD_TRAIT(H, TRAIT_FASTBITE, "Biter - Fast")


/datum/quirk/package/creatureofthewildsevi/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_FASTCLAW, "Clawer - Fast")
		REMOVE_TRAIT(H, TRAIT_FASTBITE, "Biter - Fast")

/datum/quirk/package/creatureofthewildsspicy
	name = "Creature of the Wilds - Venomous"
	desc = "You are massively in tune with your wild side. Especially the part that lets you poison things with your fangs and claws."
	value = 53
	category = "Quirk Packages"
	mechanics = "Grants access to positive trait Spicy Claw & Spicy Biter."
	conflicts = list(
		/datum/quirk/spicybiter,
		/datum/quirk/spicyclaw,
		)
	gain_text = span_notice("bitebitebitebiteclawclawclawclaw!")
	lose_text = span_notice("He need some milk.")

/datum/quirk/package/creatureofthewildsspicy/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_SPICYCLAW, "Clawer - Venomous")
	ADD_TRAIT(H, TRAIT_SPICYBITE, "Biter - Venomous")


/datum/quirk/package/creatureofthewildsspicy/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_SPICYCLAW, "Clawer - Venomous")
		REMOVE_TRAIT(H, TRAIT_SPICYBITE, "Biter - Venomous")


/datum/quirk/package/creatureofthenightgreater
	name = "Creature of the Night - Greater"
	desc = "You are the prime definition of creature of the night, your dark vision and movement agility are greatly improved."
	value = 100
	category = "Quirk Packages"
	mechanics = "Grants access to positive trait Dark Vision - Greater & Mobility - Wasteland Trekker."
	conflicts = list(
		/datum/quirk/hard_yards,
		/datum/quirk/night_vision_greater,
		/datum/quirk/package/creatureofthenightlesser
	)
	mob_trait = TRAIT_NIGHT_VISION_GREATER
	gain_text = span_notice("Your night hunting instincts enhance!")
	lose_text = span_notice("Your night hunting instincts fade away.")
	medical_record_text = "Patient claims that they have night vision."
	human_only = FALSE

/datum/quirk/package/creatureofthenightgreater/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_NIGHT_VISION_GREATER, "Dark Vision - Greater")
	ADD_TRAIT(H, TRAIT_HARD_YARDS, "Mobility - Wasteland Trekker")

/datum/quirk/package/creatureofthenightgreater/on_spawn()
	quirk_holder.update_sight()

/datum/quirk/package/creatureofthenightgreater/remove()
	var/mob/living/carbon/human/H = quirk_holder
	quirk_holder.update_sight()
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_NIGHT_VISION_GREATER, "Dark Vision - Greater")
		REMOVE_TRAIT(H, TRAIT_HARD_YARDS, "Mobility - Wasteland Trekker")

/datum/quirk/package/creatureofthenightlesser
	name = "Creature of the Night - Lesser"
	desc = "You are a creature of the night, your dark vision and movement agility are over the average."
	value = 50
	category = "Quirk Packages"
	mechanics = "Grants access to positive trait Dark Vision - Minor & Mobility - Wasteland Wanderer."
	conflicts = list(
		/datum/quirk/night_vision,
		/datum/quirk/soft_yards,
		/datum/quirk/package/creatureofthenightgreater
	)
	mob_trait = TRAIT_NIGHT_VISION
	gain_text = span_notice("You feel more attuned in darker places.")
	lose_text = span_notice("Light and taking it slow aren't bad things afteral.")
	medical_record_text = "Patient claims they can see in the dark."
	human_only = FALSE

/datum/quirk/package/creatureofthenightlesser/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_NIGHT_VISION, "Dark Vision - Minor")
	ADD_TRAIT(H, TRAIT_SOFT_YARDS, "Mobility - Wasteland Wanderer")

/datum/quirk/package/creatureofthenightlesser/on_spawn()
	quirk_holder.update_sight()

/datum/quirk/package/creatureofthenightlesser/remove()
	var/mob/living/carbon/human/H = quirk_holder
	quirk_holder.update_sight()
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_NIGHT_VISION, "Dark Vision - Minor")
		REMOVE_TRAIT(H, TRAIT_SOFT_YARDS, "Mobility - Wasteland Wanderer")

/datum/quirk/package/tinkerer
	name = "Tinker-er"
	desc = "You are able to craft without a traditional workbench, as well as craft more and gain more from salvage"
	value = 85
	category = "Quirk Packages"
	mechanics = "You don't need a workbench or alchemy table when crafting, get more recipes, and gain 1-3 more from salvaging"
	human_only = FALSE
	conflicts = list(
		/datum/quirk/tribal,
		/datum/quirk/dumb,
		/datum/quirk/luddite,
		/datum/quirk/primitive,
		/datum/quirk/technophreak,
		/datum/quirk/crafty
		)
	mob_trait = TRAIT_TECHNOPHREAK

/datum/quirk/package/tinkerer/on_spawn()
	var/mob/living/H = quirk_holder
	new /obj/machinery/workbench(H)
	new /obj/machinery/chem_master/primitive(H)

/datum/quirk/package/tinkerer/add()
	var/mob/living/carbon/human/H = quirk_holder
	// I made the quirks add the same recipes as the trait books. Feel free to nerf this
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.tier_three_parts
	H.mind.learned_recipes |= GLOB.energyweapon_cell_crafting
	H.mind.learned_recipes |= GLOB.energyweapon_crafting
	H.mind.learned_recipes |= GLOB.pa_repair
	H.mind.learned_recipes |= GLOB.armored_hazard_suit

/datum/quirk/package/tinkerer/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.mind.learned_recipes -= GLOB.tier_three_parts
		H.mind.learned_recipes -= GLOB.energyweapon_cell_crafting
		H.mind.learned_recipes -= GLOB.energyweapon_crafting
		H.mind.learned_recipes -= GLOB.pa_repair
		H.mind.learned_recipes -= GLOB.armored_hazard_suit

/datum/quirk/package/generalmedicalpractitioner
	name = "General Medical Practitioner"
	desc = "You were a General Practiotioner at some point in your life, you probably had an office and a license to practice medicine, or... maybe this is what you kept saying to your patients..."
	value = 50
	category = "Quirk Packages"
	mechanics = "Grants access to positive trait Chem Whiz & Minor Surgery."
	conflicts = list(
		/datum/quirk/chemwhiz,
		/datum/quirk/surgerylow,
		/datum/quirk/dumb
		)
	gain_text = span_notice("Let's go practice medicine!")
	lose_text = span_notice("I really think I need a true medical license...")

/datum/quirk/package/generalmedicalpractitioner/add()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, "Chem Whiz")
	ADD_TRAIT(H, TRAIT_SURGERY_LOW, "Minor Surgery")
	if(!H.mind.learned_recipes)
		H.mind.learned_recipes = list()
	H.mind.learned_recipes |= GLOB.chemwhiz_recipes

/datum/quirk/package/generalmedicalpractitioner/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		REMOVE_TRAIT(H, TRAIT_CHEMWHIZ, "Chem Whiz")
		REMOVE_TRAIT(H, TRAIT_SURGERY_LOW, "Minor Surgery")
	if(H)
		H.mind.learned_recipes -= GLOB.chemwhiz_recipes


/datum/quirk/bruteresist
	name = "Brute Resist, Minor"
	desc = "You're more resistant to physical trauma than others."
	mob_trait = TRAIT_BRUTERESIST
	value = 22
	category = "Health Quirks"
	mechanics = "You take 10% less brute damage."
	conflicts = list(
		/datum/quirk/bruteresistmajor,
		/datum/quirk/bruteweak,
		/datum/quirk/bruteweakmajor
)

/datum/quirk/bruteresist/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.brutemod = 0.9

/datum/quirk/bruteresist/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.brutemod = 1

/datum/quirk/bruteresistmajor
	name = "Brute Resist, Major"
	desc = "You're even more resistant to physical trauma than others. You've got skin of steel!"
	mob_trait = TRAIT_BRUTERESISTMAJOR
	value = 44
	category = "Health Quirks"
	mechanics = "You take 20% less brute damage."
	conflicts = list(
		/datum/quirk/bruteresist,
		/datum/quirk/bruteweak,
		/datum/quirk/bruteweakmajor
)

/datum/quirk/bruteresistmajor/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.brutemod = 0.8

/datum/quirk/bruteresistmajor/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.brutemod = 1

/datum/quirk/burnresist
	name = "Burn Resist, Minor"
	desc = "You're more resistant to burns than others."
	mob_trait = TRAIT_BURNRESIST
	value = 22
	category = "Health Quirks"
	mechanics = "You take 10% less burn damage."
	conflicts = list(
		/datum/quirk/burnresistmajor,
		/datum/quirk/burnweak,
		/datum/quirk/burnweakmajor
)

/datum/quirk/burnresist/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.burnmod = 0.9

/datum/quirk/burnresist/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.burnmod = 1

/datum/quirk/burnresistmajor
	name = "Burn Resist, Major"
	desc = "You're even more resistant to burns than others. Your skin is insulated!"
	mob_trait = TRAIT_BURNRESISTMAJOR
	value = 44
	category = "Health Quirks"
	mechanics = "You take 20% less burn damage."
	conflicts = list(
		/datum/quirk/burnresist,
		/datum/quirk/burnweak,
		/datum/quirk/burnweakmajor
)

/datum/quirk/burnresistmajor/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.burnmod = 0.8

/datum/quirk/burnresistmajor/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.burnmod = 1
*/
