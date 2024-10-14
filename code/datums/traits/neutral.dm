//traits with no real impact that can be taken freely
//MAKE SURE THESE DO NOT MAJORLY IMPACT GAMEPLAY. those should be positive or negative traits.

/datum/quirk/no_taste
	name = "Ageusia"
	desc = "You can't taste anything! Toxic food will still poison you."
	value = 0
	category = "Food Quirks"
	mechanics = "You don't get disgusted from anything, but you still suffer chemical side effects."
	conflicts = list(
		/datum/quirk/pineapple_liker,
		/datum/quirk/pineapple_hater,
		/datum/quirk/deviant_tastes,
		/datum/quirk/nukalover,
	)
	mob_trait = TRAIT_AGEUSIA
	gain_text = span_notice("You can't taste anything!")
	lose_text = span_notice("You can taste again!")
	medical_record_text = "Patient suffers from ageusia and is incapable of tasting food or reagents."

/datum/quirk/no_chocolate
	name = "Chocolate intolerance"
	desc = "Your metabolism finds chocolate rather disagreeable."
	value = 0
	category = "Food Quirks"
	mechanics = "You take toxin damage from eating chocolate. You know. Like a dog."
	conflicts = list()
	mob_trait = TRAIT_NO_CHOCOLATE
	gain_text = span_notice("You feel like eating chocolate is a bad idea.")
	lose_text = span_notice("You feel like it's safe to eat chocolate again")
	medical_record_text = "Patient has an aversion to theobromine, and therefore cannot have chocolate."

/datum/quirk/white_woman
	name = "Peanutbutter difficulties"
	desc = "Your tongue has difficulty handling the adhesiveness of peanut butter"
	value = 0
	category = "Food Quirks"
	mechanics = "You will lick your lips rapidly and constantly while eating peanut butter. You know. Like a dog."
	conflicts = list()
	mob_trait = TRAIT_WHITE_WOMAN
	gain_text = span_notice("Your tongue lacks the manipulation to properly eat peanut butter.")
	lose_text = span_notice("Your tongue is skilled at taking on sticky peanut butter.")
	medical_record_text = "Patient's tongue lacks the dexterity required to eat peanut butter."

/datum/quirk/autobrew //sugary foods create ethanol
	name = "Autobrewery syndrome"
	desc = "Your natural gut flora ferments many sugary foods and drinks into alcohol."
	value = 0
	category = "Food Quirks"
	mechanics = "Anything with sugar in it turns into alchohol chems in your system, you can take penicillian or eat nonsugary foods to prevent this."
	conflicts = list()
	mob_trait = TRAIT_AUTOBREW
	gain_text = span_notice("you feel rather fuzzy.")
	lose_text = span_notice("you feel more coherent.")
	medical_record_text = "Patient shows chronically unusual blood alcohol levels."

/datum/quirk/snob
	name = "Snob"
	desc = "You care about the finer things, if a room doesn't look nice its just not really worth it, is it?"
	value = 0
	category = "Emotional Quirks"
	mechanics = "WIP In a perfect world this would adjust your mood on the beauty rating of the room you're in, in reality it does nearly nothing. Gives you a good reason to whine about the feng shui. WIP"
	conflicts = list(
	)
	gain_text = span_notice("You feel like you understand what things should look like.")
	lose_text = span_notice("Well who cares about deco anyways?")
	medical_record_text = "Patient seems to be rather stuck up."
	mob_trait = TRAIT_SNOB

/* Temporarily removed for reworking, god this thing is WAY too busy. ~TK // reworked into multiple other trait options, here for example purposes now - bear
/quirk/fev
	name = "FEV Exposure"
	desc = " "
	value = 4
	category = ""
	mechanics = ""
	conflicts = list()
	gain_text = span_notice("You feel a burning pain as your DNA is ripped apart, and sewn back together.")
	lose_text = span_notice("The dull metronome of pain that defined your existence has faded.")
	medical_record_text = "Patient appears to have 'perfect' DNA."
	mob_trait = TRAIT_FEV

/datum/quirk/fev/add()
	var/mob/living/carbon/human/H = quirk_holder
	H.dna.species.punchdamagelow = 8 //Their fists hurt more
	H.dna.species.punchdamagehigh = 15 //But not that much more at peak. Until they put on spikes.
	quirk_holder.become_mega_nearsighted(ROUNDSTART_TRAIT) //:trollge:
	H.maxHealth += 30 //These guys are tanky. But almost blind, slow in most instances, and unable to use most ranged weapons.
	H.health += 30
*/

/datum/quirk/pineapple_liker
	name = "Ananas Affinity"
	desc = "You find yourself greatly enjoying fruits of the ananas genus. You can't seem to ever get enough of their sweet goodness!"
	value = 0
	category = "Food Quirks"
	mechanics = "You get a mood boost from eating pineapples."
	conflicts = list(
		/datum/quirk/no_taste,
		/datum/quirk/pineapple_hater,
		/datum/quirk/nukalover,
	)
	gain_text = span_notice("You feel an intense craving for pineapple.")
	lose_text = span_notice("Your feelings towards pineapples seem to return to a lukewarm state.")
	medical_record_text = "Patient demonstrates a pathological love of pineapple."

/datum/quirk/pineapple_liker/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food |= PINEAPPLE

/datum/quirk/pineapple_liker/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food &= ~PINEAPPLE

/datum/quirk/pineapple_hater
	name = "Ananas Aversion"
	desc = "You find yourself greatly detesting fruits of the ananas genus. Serious, how the hell can anyone say these things are good? And what kind of madman would even dare putting it on a pizza!?"
	value = 0
	category = "Food Quirks"
	mechanics = "You really just hate eating pineapples."
	conflicts = list(
		/datum/quirk/no_taste,
		/datum/quirk/pineapple_liker,
		/datum/quirk/nukalover,
	)
	gain_text = span_notice("You find yourself pondering what kind of idiot actually enjoys pineapples...")
	lose_text = span_notice("Your feelings towards pineapples seem to return to a lukewarm state.")
	medical_record_text = "Patient is correct to think that pineapple is disgusting."

/datum/quirk/pineapple_hater/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.disliked_food |= PINEAPPLE

/datum/quirk/pineapple_hater/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.disliked_food &= ~PINEAPPLE

/datum/quirk/deviant_tastes
	name = "Deviant Tastes"
	desc = "You dislike food that most people enjoy, and find delicious what they don't."
	value = 0
	category = "Food Quirks"
	mechanics = "You can eat stuff like bug meat, rats on a stick, and other things of that nature with no mood debuff. Taaastttyyy?"
	conflicts = list(
		/datum/quirk/no_taste,
	)
	gain_text = span_notice("You start craving something that tastes strange.")
	lose_text = span_notice("You feel like eating normal food again.")
	medical_record_text = "Patient demonstrates irregular nutrition preferences."

/datum/quirk/deviant_tastes/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	var/liked = species.liked_food
	species.liked_food = species.disliked_food
	species.disliked_food = liked

/datum/quirk/deviant_tastes/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food = initial(species.liked_food)
		species.disliked_food = initial(species.disliked_food)

/datum/quirk/monochromatic
	name = "Monochromacy"
	desc = "You suffer from full colorblindness, and perceive nearly the entire world in blacks and whites. Sure hope you like Kurasawa movies."
	value = 0
	category = "Vision Quirks"
	mechanics = "Your vision will have no color in it whatsoever. Kind of like a, uh. Dog."
	conflicts = list()
	medical_record_text = "Patient is afflicted with almost complete color blindness."

/datum/quirk/monochromatic/add()
	quirk_holder.add_client_colour(/datum/client_colour/monochrome)

/datum/quirk/monochromatic/post_add()
	if(quirk_holder.mind.assigned_role == "Detective")
		to_chat(quirk_holder, span_boldannounce("Mmm. Nothing's ever clear on this station. It's all shades of gray..."))
		quirk_holder.playsound_local(quirk_holder, 'sound/ambience/ambidet1.ogg', 50, FALSE)

/datum/quirk/monochromatic/remove()
	if(quirk_holder)
		quirk_holder.remove_client_colour(/datum/client_colour/monochrome)

/datum/quirk/agroeater
	name = "Aggressive Metabolism"
	desc = "You gain natural healing from eating food, but your metabolism is aggressively fast, causing you to eat alot of food"
	value = 0 // This heals 71 brute damage in 16 minutes, but also massively increases your hunger rate. Having no hunger is extremely bad
	category = "Food Quirks"
	mechanics = "You heal naturally, but if your starving, you no longer heal. Starving is very bad for you."
	conflicts = list() 

/datum/quirk/agroeater/add()
	var/mob/living/carbon/human/H = quirk_holder
	H.AddElement(/datum/element/photosynthesis, -0.15, -0.15, -0.15, -0.15, -1, 0, -1, -1.5) // Should work at all times, no matter what light condition

/datum/quirk/agroeater/remove()
	var/mob/living/carbon/human/H = quirk_holder
	H.RemoveElement(/datum/element/photosynthesis, -0.15, -0.15, -0.15, -0.15, -1, 0, -1, -1.5)

/datum/quirk/maso
	name = "Masochism"
	desc = "You are aroused by pain."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "You get a mood boost and aroused by taking pain, though its somewhat limited in this code due to age so it's mostly just from having your ass slapped (disarm intent, target groin, click from behind to do this to others thoug!)"
	conflicts = list()
	mob_trait = TRAIT_MASO
	gain_text = span_notice("You desire to be hurt.")
	lose_text = span_notice("Pain has become less exciting for you.")


/datum/quirk/alcohol_intolerance
	name = "Alcohol Intolerance"
	desc = "You take toxin damage from alcohol rather than getting drunk."
	value = 0
	category = "Food Quirks"
	mechanics = "Pretty straight forward, liquor makes your ticker flicker. Toxin damage from alchohol."
	conflicts = list(
		/datum/quirk/alcohol_tolerance
	)
	mob_trait = TRAIT_NO_ALCOHOL
	medical_record_text = "Patient's body does not react properly to ethyl alcohol."

/datum/quirk/alcohol_intolerance/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.disliked_food |= ALCOHOL

/datum/quirk/alcohol_intolerance/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.disliked_food &= ~ALCOHOL

/datum/quirk/longtimer
	name = "Scarred" //Renamed to be more clear what it is, u ugly af ~TK
	desc = "You've been around for a long time and seen more than your fair share of action, suffering some pretty nasty scars along the way. For whatever reason, you've declined to get them removed or augmented."
	value = 0
	category = "Lifepath Quirks"
	conflicts = list()
	gain_text = span_notice("Your body has seen better days.")
	lose_text = span_notice("Your sins may wash away, but those scars are here to stay...")
	medical_record_text = "Patient has withstood significant physical trauma and declined plastic surgery procedures to heal scarring."
	/// the minimum amount of scars we can generate
	var/min_scars = 3
	/// the maximum amount of scars we can generate
	var/max_scars = 7

/datum/quirk/longtimer/on_spawn()
	var/mob/living/carbon/C = quirk_holder
	C.generate_fake_scars(rand(min_scars, max_scars))

/*
 * A status effect used for preventing caltrop message spam
 *
 * While a mob has this status effect, they won't recieve any messages about
 * stepping on caltrops. But they will be stunned and damaged regardless.
 *
 * The status effect itself has no effect, other than to disappear after
 * a second.
 */ // why is this here?
/datum/status_effect/caltropped
	id = "caltropped"
	duration = 1 SECONDS
	tick_interval = INFINITY
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null

/datum/quirk/steel_ass
	name = "Buns of Steel"
	desc = "You've never skipped ass day. You are completely immune to all forms of ass slapping and anyone who tries to slap your rock hard ass usually gets a broken hand."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "Your ass bites back, doing damage to any who dare to slap your glorious behind."
	conflicts = list(
		/datum/quirk/butter_ass,
	)
	mob_trait = TRAIT_STEEL_ASS
	gain_text = span_notice("Your ass rivals those of golems.")
	lose_text = span_notice("Your butt feels more squishy and slappable.")

/datum/quirk/butter_ass
	name = "Buns of Thunder"
	desc = "That pants-stretching, seat-creaking, undie-devouring ass of yours is as satisfying to smack as it is difficult to keep balanced!"
	value = 0
	category = "Bawdy Quirks"
	mechanics = "Any time someone smacks your pillowy butt, its jiggling will make moving hard for a few moments! But, it'll satisfy whoever smacked it!"
	conflicts = list(
		/datum/quirk/steel_ass,
	)
	mob_trait = TRAIT_JIGGLY_ASS
	gain_text = span_notice("The ass is fat.")
	lose_text = span_notice("The ass was fat.")

/datum/quirk/headpat_hater
	name = "Distant"
	desc = "You don't seem to show much care for being touched. Whether it's because you're reserved or due to self control, others touching your head won't make you wag your tail should you possess one, and the action may even attract your ire.."
	mob_trait = TRAIT_DISTANT
	value = 0
	category = "Bawdy Quirks"
	mechanics = "Being headpatted makes you angry as shit, giving a mood debuff when it happens. Maybe you're just tsundere as shit."
	conflicts = list(
		/datum/quirk/headpat_slut,
	)
	gain_text = span_notice("Others' touches begin to make your blood boil...")
	lose_text = span_notice("Having your head pet doesn't sound so bad right about now...")
	medical_record_text = "Patient cares little with or dislikes being touched."

/datum/quirk/headpat_slut
	name = "Headpat Lover"
	desc = "You love the feeling of others touching your head! Maybe a little too much, actually... Others patting your head will provide a bigger mood boost and cause aroused reactions."
	mob_trait = TRAIT_HEADPAT_SLUT
	value = 0
	category = "Bawdy Quirks"
	mechanics = "You get a bigger mood boost from being petted, maybe uh. A bit of a boost to your libido too, it's hard to tell."
	conflicts = list(
		/datum/quirk/headpat_hater,
	)
	gain_text = span_notice("You crave headpats immensely!")
	lose_text = span_notice("Your headpats addiction wanes.")
	medical_record_text = "Patient seems overly affectionate."

/datum/quirk/oral_fixation
	name = "Oral Fixation"
	desc = "You have an urge to put things in your mouth."
	mob_trait = TRAIT_ORAL_FIXATION
	value = 0
	category = "Bawdy Quirks"
	mechanics = "You can fit any small sized item in your mouth. Small items will muffle your voice. Tiny items wont."
	conflicts = list()

/datum/quirk/overweight
	name = "Overweight"
	desc = "You're particularly fond of food, and join the round being overweight."
	value = 0
	category = "Lifepath Quirks"
	mechanics = "You spawn in overweight and full, this also limits your movement quirks out of Freerunning, Light Step, and Quick Walking. Good if you plan on bleeding a lot near round start, I guess."
	mob_trait = TRAIT_FAT
	conflicts = list(
		/datum/quirk/freerunning,
		/datum/quirk/light_step,
		// /datum/quirk/quick_step,
	)
	gain_text = span_notice("You feel blubbery!")
	//no lose_text cause why would there be?

/datum/quirk/overweight/on_spawn()
	var/mob/living/M = quirk_holder
	M.nutrition = rand(NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MIN, NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MAX)
	M.overeatduration = 100

/datum/quirk/vegetarian
	name = "Vegetarian"
	desc = "You find the idea of eating meat morally and/or physically repulsive."
	value = 0
	category = "Food Quirks"
	mechanics = "You are mechanically disgusted by eating meat."
	conflicts = list(
		/datum/quirk/horrifying_tastes,
		)
	gain_text = span_notice("You feel repulsion at the idea of eating meat.")
	lose_text = span_notice("You feel like eating meat isn't that bad.  Might could even go for a cheeseburger.")
	medical_record_text = "Patient reports a vegetarian diet."

/datum/quirk/vegetarian/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food &= ~MEAT
	species.disliked_food |= MEAT

/datum/quirk/vegetarian/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		if(initial(species.liked_food) & MEAT)
			species.liked_food |= MEAT
		if(initial(species.disliked_food) & ~MEAT)
			species.disliked_food &= ~MEAT

/datum/quirk/hydra
	name = "Multiple Identities"
	desc = "You have multiple identities voices, names, or you are a multi-headed creature."
	value = 0
	category = "Lifepath Quirks"
	mechanics = "Format your name in a manner similar to Rucks-Tucks-Ducks and you can use the action button to toggle between which will be your character name and voice."
	conflicts = list()
	mob_trait = TRAIT_HYDRA_HEADS
	gain_text = span_notice("You hear other voices inside of your head(s).")
	lose_text = span_danger("All of your minds become singular.")
	medical_record_text = "Patient has multiple heads and personalities affixed to their body."

/datum/quirk/hydra/on_spawn()
	var/mob/living/carbon/human/hydra = quirk_holder
	var/datum/action/innate/hydra/spell = new
	var/datum/action/innate/hydrareset/resetspell = new
	spell.Grant(hydra)
	spell.owner = hydra
	resetspell.Grant(hydra)
	resetspell.owner = hydra
	hydra.name_archive = hydra.real_name


/datum/action/innate/hydra
	name = "Switch head"
	desc = "Switch between each of the heads on your body."
	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydrareset
	name = "Reset speech"
	desc = "Go back to speaking as a whole."
	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydrareset/Activate()
	var/mob/living/carbon/human/hydra = owner
	hydra.real_name = hydra.name_archive
	hydra.visible_message(span_notice("[hydra.name] speaks with multiple familiar voices overlapping eachother."), \
							span_notice("You are now talking as [hydra.name_archive]!"), ignored_mobs=owner)

/datum/action/innate/hydra/Activate() //I hate this but its needed
	var/mob/living/carbon/human/hydra = owner
	var/list/names = splittext(hydra.name_archive,"-")
	var/selhead = input("Who would you like to speak as?","Heads:") in names
	hydra.real_name = selhead
	hydra.visible_message(span_notice("[hydra.name] alters their portrayed identity, appearing as [selhead] instead."), \
							span_notice("You are now talking as [selhead]!"), ignored_mobs=owner)


/datum/quirk/tribespeak
	name = "Language - Tribal Language Comprehension"
	desc = "You're somehow capable of understanding and speaking the common tribal languages in the area."
	value = 0
	category = "Language Quirks"
	mechanics = "You can speak the language of the taiga, shared with the Mountain River Tribe."
	conflicts = list()
	gain_text = span_notice("You remember the old ways of your tribe..")
	lose_text = span_notice("You've forgotten the ways of your ancestors..")
	human_only = FALSE


/datum/quirk/tribespeak/add()
	var/mob/living/H = quirk_holder
	H.grant_language(/datum/language/tribal)

/datum/quirk/tribespeak/remove()
	var/mob/living/H = quirk_holder
	if(!QDELETED(H))
		H.remove_language(/datum/language/tribal)

/datum/quirk/pokespeak
	name = "Language - Pokemon Language Comprehension"
	desc = "You're somehow capable of understanding and speaking the common pokemon language."
	value = 0
	category = "Language Quirks"
	mechanics = "You can speak the pokemon langage, or at least understand it. Maybe you really are the very best."
	conflicts = list()
	gain_text = span_notice("You remember how to speak to pokemon.")
	lose_text = span_notice("You've forgotten how to speak pokemon.")
	human_only = FALSE

/datum/quirk/pokespeak/add()
	var/mob/living/H = quirk_holder
	H.grant_language(/datum/language/pokemon)

/datum/quirk/pokespeak/remove()
	var/mob/living/H = quirk_holder
	if(!QDELETED(H))
		H.remove_language(/datum/language/pokemon)

/datum/quirk/in_heat
	name = "ERP Receptive"
	desc = "Your character, for whatever reason, is PASSIVELY seeking out attention from those who match your OOC Prefences. Remember to set your OOC notes!"
	value = 0
	category = "Bawdy Quirks"
	mechanics = "This trait is a flag for people who have ERP seeking to know that you, right now, are seeking ERP. It's a simple concept, if you just have this quirk you are not going out of our way to look for it, but if it stumbles into your lap well that'd be fine, right?"
	conflicts = list()
	mob_trait = TRAIT_IN_HEAT
	human_only = FALSE

/datum/quirk/heat
	name = "ERP Seeking"
	desc = "Your character, for whatever reason, is ACTIVELY seeking out attention from those who match your OOC Preferences. Remember to check peoples OOC notes!"
	value = 0
	category = "Perceptive Quirks"
	mechanics = "This Quirk allows you to see other players ERP related quirks when you examine them. Letting you know, at a glance, some of their prefs if they have them set."
	conflicts = list()
	mob_trait = TRAIT_HEAT_DETECT
	human_only = FALSE

/datum/quirk/shy
	name = "OOCly Shy"
	desc = "You, and likely your character, are a bit shy. This is a fine thing to be, but letting people know this way will let them know you do want to be included in social situations when its feasible. Basically just top bait though, lets be real."
	value = 0
	category = "OOC Quirks"
	mechanics = "The description should be fairly clear, but to reiterate this quirk exists as an OOC flag to let everyone know that you have some sort of social issue that makes it hard for you to approach others. If anyone dares to give you problems about taking this please alert staff immediatly, we will eat their legs off."
	conflicts = list()
	mob_trait = TRAIT_SHY
	human_only = FALSE

/datum/quirk/pvefocus
	name = "PVP Refusing"
	desc = "You opt out of PVP, and refuse to take part in it. Players may not engage you in PVP, or try to bait you into it. Likewise, you \
		may not engage or bait others into trying to PVP with you. While you don't need this quirk to opt out of PVP, it does help set this \
		preference for you by default. You can toggle this on or off at any time by using *nopvp."
	value = 0
	category = "OOC Quirks"
	mechanics = "Your examine text will let others know that you're not interested in PVP engagements."
	conflicts = list(
		/datum/quirk/pvpfocus,
	)
	mob_trait = TRAIT_PVEFOC
	human_only = FALSE

/datum/quirk/pvefocus/on_spawn()
	var/mob/living/M = quirk_holder
	M.SetPVPflag(PVP_NO)

/datum/quirk/pvpfocus
	name = "PVP Focused"
	desc = "You're looking for PVP action! While you don't need this quirk to partake in PVP, it is helpful for others to know that you're happy to do so. \
		Keep in mind that players can opt out of PVP, either through saying so through LOOC, having the PVP Opt Out quirk, or by using *nopvp. \
		If a player has opted out of PVP, you should respect their wishes and not engage in PVP with them."
	value = 0
	category = "OOC Quirks"
	mechanics = "Your examine text will let others know that you're open for PVP engagements."
	conflicts = list()
	mob_trait = TRAIT_PVPFOC
	human_only = FALSE

/datum/quirk/pvpfocus/on_spawn()
	var/mob/living/M = quirk_holder
	M.SetPVPflag(PVP_YES)

/datum/quirk/loocapproach
	name = "L/OOC Approach"
	desc = "You prefer to be approached for Roleplay (Erotic or otherwise) via LOOC/OOC first to help work out a plan for scenes and ideas so that the experiences are a bit more tailored."
	value = 0
	category = "OOC Quirks"
	mechanics = "This quirk should be helpful also for people who like to plan scenes ahead of time. It's a well known fact of SS13 that time always runs short when roleplay is happening and hopefully this can help alleviate that via planning."
	conflicts = list()
	mob_trait = TRAIT_OOCAPP
	human_only = FALSE

// /datum/quirk/pvpande
// 	name = "PVP/PVE Accepting"
// 	desc = "You are down for PVP & PVE Scenarios.  The wastes are violent, and you are down bad for Miss Violencia. Be it PVP or PVE this quirk lets others know you're ready to R U M B L E."
// 	value = 0
// 	category = "OOC Quirks"
// 	mechanics = "Yeah, you're just violent and quirky. We get it."
// 	conflicts = list()
// 	mob_trait = TRAIT_COMBATSWITCH
// 	human_only = FALSE

/*/datum/quirk/smol
	name = "Scoopable!"
	desc = "Maybe you're really smol, maybe you're just really light, maybe you're *really* into yoga. However it is, carrying you around is just pretty dang easy."
	value = 0
	category = "Lifepath Quirks"
	mechanics = "You can be picked up by others with as simple as an alt + click. Careful, they can stuff you in some vending machines too. Yikes."
	conflicts = list()
	mob_trait = TRAIT_SMOL
	gain_text = span_notice("You feel scoopable! Others can ALT-CLICK you to pick you up!")
	lose_text = span_notice("You feel a lot less scoopable.")
	human_only = FALSE

/datum/quirk/smol/add()
	if(istype(quirk_holder))
		quirk_holder.AddElement(/datum/element/mob_holder, "corgi") // dog

/datum/quirk/smol/remove()
	if(istype(quirk_holder))
		quirk_holder.RemoveElement(/datum/element/mob_holder) // undog
*/ //Inate trait with all humans now

/datum/quirk/cat
	name = "A cat!"
	desc = "You identify as a cat! (Mostly to help identify your species mechanically)"
	value = 0
	category = "Identification Quirks"
	mechanics = "You trigger the cat phobia, amazing."
	conflicts = list()
	mob_trait = TRAIT_CAT
	human_only = FALSE

/datum/quirk/rat
	name = "A rat!"
	desc = "You identify as a rat! (Mostly to help identify your species mechanically)"
	value = 0
	category = "Identification Quirks"
	mechanics = "You trigger the cat phobia, stellar."
	conflicts = list()
	mob_trait = TRAIT_RAT
	human_only = FALSE

/datum/quirk/spider
	name = "A spider!"
	desc = "You identify as a spider! (Mostly to help identify your species mechanically)"
	value = 0
	category = "Identification Quirks"
	mechanics = "You trigger the spider phobia, tubular."
	conflicts = list()
	mob_trait = TRAIT_SPIDER
	human_only = FALSE

/datum/quirk/lizard
	name = "A lizard or reptillian!"
	desc = "You identify as a lizard/reptillian! (Mostly to help identify your species mechanically)"
	value = 0
	category = "Identification Quirks"
	mechanics = "You trigger the lizard phobia, choice."
	conflicts = list()
	mob_trait = TRAIT_LIZARD
	human_only = FALSE

/datum/quirk/robot
	name = "A robot/synth!"
	desc = "You identify as a robot/synth! (Mostly to help identify your species mechanically)"
	value = 0
	category = "Identification Quirks"
	mechanics = "You trigger the robot phobia, radical."
	conflicts = list()
	mob_trait = TRAIT_ROBOT
	human_only = FALSE

/datum/quirk/bird
	name = "A bird!"
	desc = "You identify as a bird! (Mostly to help identify your species mechanically)"
	value = 0
	category = "Identification Quirks"
	mechanics = "You trigger the bird phobia, magical."
	conflicts = list()
	mob_trait = TRAIT_BIRD
	human_only = FALSE

/datum/quirk/dog
	name = "A dog!"
	desc = "You identify as a dog! (Mostly to help identify your species mechanically)"
	value = 0
	category = "Identification Quirks"
	mechanics = "You trigger the dog phobia, dastardly."
	conflicts = list()
	mob_trait = TRAIT_DOG
	human_only = FALSE

/datum/quirk/alien
	name = "An alien!"
	desc = "You identify as some manner of wierd, uncanny alien! Maybe you're a xenomorph, youre a grey skinned big headded creature, or you're just otherwise otherworldly!"
	value = 0
	category = "Identification Quirks"
	mechanics = "You trigger the alien phobia."
	conflicts = list()
	mob_trait = TRAIT_ALIEN
	human_only = FALSE


/datum/quirk/photographer
	name = "Photographer"
	desc = "You carry your camera and personal photo album everywhere you go, and your scrapbooks are legendary among your coworkers."
	value = 0
	category = "Lifepath Quirks"
	mechanics = "Like it says, camera and photo album. The album saves between rounds for you to remember all those good times with. Or cry in six months when you come back and see it again."
	conflicts = list(
		/datum/quirk/luddite, // fucer'll steal your soul
	)
	mob_trait = TRAIT_PHOTOGRAPHER
	gain_text = span_notice("You know everything about photography.")
	lose_text = span_danger("You forget how photo cameras work.")
	medical_record_text = "Patient mentions photography as a stress-relieving hobby."

/datum/quirk/photographer/on_spawn()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/storage/photo_album/photo_album = new(get_turf(human_holder))
	photo_album.persistence_id = "personal_[lowertext(human_holder.last_mind?.key)]" // this is a persistent album, the ID is tied to the account's key to avoid tampering
	photo_album.persistence_load()
	photo_album.name = "[human_holder.real_name]'s photo album"

	if(!human_holder.equip_to_slot_if_possible(photo_album, SLOT_IN_BACKPACK, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
		if(!human_holder.put_in_hands(photo_album))
			photo_album.forceMove(get_turf(photo_album))

	var/obj/item/camera/cam = new(get_turf(human_holder))
	if(!human_holder.equip_to_slot_if_possible(cam , SLOT_IN_BACKPACK, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
		if(!human_holder.put_in_hands(cam))
			cam.forceMove(get_turf(cam))

/datum/quirk/journalist
	name = "Journalist"
	desc = "You carry yourself a pen and a personal folder around, you are known to be the one who records everything."
	value = 0
	category = "Lifepath Quirks"
	mechanics = "Yeah, you get a bunch of junk. Cool thing though, alt click the pen and you can rename stuff. See if you can sell someone a deed to Nash, I double dog dare you."
	conflicts = list() // you can be an illiterate journalist
	mob_trait = TRAIT_JOURNALIST
	gain_text = span_notice("You feel like you need to harrass politicians.")
	lose_text = span_danger("You forget how to be a journalist. :(")
	medical_record_text = ""

/datum/quirk/journalist/on_spawn()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/folder/folder = new(get_turf(human_holder))
	folder.persistenceID = "personal_[lowertext(human_holder.last_mind?.key)]" // this is a persistent album, the ID is tied to the account's key to avoid tampering
	folder.PersistenceLoad()
	folder.name = "[human_holder.real_name]'s journal"

	if(!human_holder.equip_to_slot_if_possible(folder, SLOT_IN_BACKPACK, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
		if(!human_holder.put_in_hands(folder))
			folder.forceMove(get_turf(human_holder))

/datum/quirk/lick_heal
	name = "Innate healing - Saliva"
	desc = "You got that dog in you, your licks straight up heal the wounded. Somehow. Don't think about it too hard."
	value = 0
	category = "Healer Quirks"
	mechanics = "You can pull out your tongue with *lick and use it to heal wounds on folks. Drink water to regain uses faster. Just remember that some people do not like being licked to be healed."
	conflicts = list()
	mob_trait = TRAIT_HEAL_TONGUE
	gain_text = span_notice("You feel a slight tingle in your mouth.")
	lose_text = span_danger("The tingle in your mouth fades.")
	locked = FALSE
	human_only = FALSE

/datum/quirk/touch_heal
	name = "Innate healing - Magic"
	desc = "By the Nine- Wait, wrong game. One way or another you can lay on hands."
	value = 0
	category = "Healer Quirks"
	mechanics = "Your touch has a mild healing effect on burns and bruises. Use *touch to soothe the injuries of yourself or others. Drinking water helps recover from the fatigue of using the spell faster."
	conflicts = list()
	mob_trait = TRAIT_HEAL_TOUCH
	gain_text = span_notice("You feel a slight tingle in your hands.")
	lose_text = span_danger("The tingle in your palm fades.")
	locked = FALSE
	human_only = FALSE

/datum/quirk/tend_heal
	name = "Innate healing - Triage"
	desc = "You keep a tiny kit of medical supplies stashed away for emergencies."
	value = 0
	category = "Healer Quirks"
	mechanics = "Use *tend to treat the injuries of yourself or others. Drinking water helps recover your focus."
	conflicts = list()
	mob_trait = TRAIT_HEAL_TEND
	gain_text = span_notice("You feel your triage kit tucked safely in a pocket.")
	lose_text = span_danger("You lost your triage kit...")
	locked = FALSE
	human_only = FALSE

//Fennys insane RP quirks

/datum/quirk/rpfocused
	name = "Roleplay Seeking"
	desc = "You are actively seeking out people who also are seeking roleplay that isn't necessarily erotic in nature. With this you will be able to see the other Roleplay related quirks on others."
	value = 0
	category = "Perceptive Quirks"
	mechanics = "This quirk lets you see other peoples roleplay related traits, pretty simple."
	conflicts = list()
	mob_trait = TRAIT_RPFOCUSED
	human_only = FALSE

/datum/quirk/rplongterm
	name = "Roleplay Seeking - Long Term Focus"
	desc = "You are seeking out people to have more than one rounds worth of interaction with.  Maybe on the regular if your real world schedules allow it."
	value = 0
	category = "Roleplay Quirks"
	mechanics = "Consider passing each other your discords, or something similar. Make a little long term group!  We'd love to see it!"
	conflicts = list()
	mob_trait = TRAIT_RPLONGTERM
	human_only = FALSE

/datum/quirk/rpshortterm
	name = "Roleplay Seeking - Short Term Focus"
	desc = "You are seeking out people to have occasional interaction with. Pick this if you want more casual quicker roleplay, instead of something that likely needs OOC planning between those involved."
	value = 0
	category = "Roleplay Quirks"
	mechanics = "Grab and go, go gettem y'all!"
	conflicts = list()
	mob_trait = TRAIT_RPSHORTTERM
	human_only = FALSE

/datum/quirk/rpserious
	name = "Roleplay Seeking - Serious Roleplay"
	desc = "You are seeking out 'Serious' Roleplay with others. This includes things like taking threats realistically and generally really digging into the setting to create believable, and not terribly wacky, situations."
	value = 0
	category = "Roleplay Quirks"
	mechanics = "For more clarification, when we say 'serious' we're implying what some players may know to some degree as a 'higher' roleplay level. Think serious cop drama."
	conflicts = list()
	mob_trait = TRAIT_RPSERIOUS
	human_only = FALSE

/datum/quirk/rplight
	name = "Roleplay Seeking - Light Roleplay"
	desc = "You are seeing out 'Light' Roleplay with others.  This includes things like generally playing into the wackyness of the game overall.  While we do ask you not to break the 4th wall (too often, anyway) this means you're seeking more silly interactions generally."
	value = 0
	category = "Roleplay Quirks"
	mechanics = "For more clarification, when we say 'light' we're implying what some players may know to some degree as a 'lower' roleplay level. Think goofy and lighthearted."
	conflicts = list()
	mob_trait = TRAIT_RPLIGHT
	human_only = FALSE

/datum/quirk/rpdaysofourlives
	name = "Roleplay Seeking - Dramatic Roleplay"
	desc = "You are seeking out interactions with others that are perhaps a bit overdramatic. Scandalous, gossiping, overly sad or emotional scenes. Think Days of Our Lives, or any Soap Opera. This is not a way around the OOC Drama rule, but it does mean you're seeking IC Drama roleplay!"
	value = 0
	category = "Roleplay Quirks"
	mechanics = "For more clarification, when we say 'dramatic' we mean spicier topics. These dramatic moments should also be careful to be kept in IC spaces, remember your IC/OOC barrier peeps."
	conflicts = list()
	mob_trait = TRAIT_RPDAYSOFOURLIVES
	human_only = FALSE

/datum/quirk/rpscrubs
	name = "Roleplay Seeking - Medical Roleplay"
	desc = "You are seeking out interactions with players that are medical related.  This includes roleplaying treating wounds, or maybe even roleplaying treating them poorly."
	value = 0
	category = "Roleplay Quirks"
	mechanics = "For more clarification, when we say 'medical' we don't mean roleplaying out adding every bandage but maybe give this person a little bit more to work with than wandering in and out of medbay like a stooge."
	conflicts = list()
	mob_trait = TRAIT_RPSCRUBS
	human_only = FALSE

//ERP Focused quirks

/datum/quirk/erpboykisser
	name = "ERP Seeking - Prefers Guys"
	desc = "When it comes to picking who to kiss, you choose boys. Boykisser."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "For people who like both but have a lean consider taking this with the anyone kisser quirk."
	conflicts = list()
	mob_trait = TRAIT_ERPBOYKISSER
	human_only = FALSE

/datum/quirk/erpgirlkisser
	name = "ERP Seeking - Prefers Girls"
	desc = "When it comes to picking who to kiss, you choose girls.  Girlkisser."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "For people who like both but have a lean consider taking this with the anyone kisser quirk."
	conflicts = list()
	mob_trait = TRAIT_ERPGIRLKISSER
	human_only = FALSE

/datum/quirk/erpanykisser
	name = "ERP Seeking - Prefers Anyone"
	desc = "When it comes to picking who to kiss you'll kiss em' all."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "For those with a lean towards boys or girls consider taking the quirks for them with this to show that interest."
	conflicts = list()
	mob_trait = TRAIT_ERPANYKISSER
	human_only = FALSE

/datum/quirk/erpquicky
	name = "ERP Seeking - Relationships - Short Term"
	desc = "You're a flinger, swing, floozy, harlot or a harem anime protagonist. You prefer your partners to come and go, and the spice of life is variety."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "Party like its 6969, bro."
	conflicts = list()
	mob_trait = TRAIT_ERPQUICKY
	human_only = FALSE

/datum/quirk/erplongerm
	name = "ERP Seeking - Relationships - Long Term"
	desc = "A waifu or husbando, you probably don't care much which term is used but you want one partner, and to generally stick to them."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "If you really liked it you shoulda put a ring on it."
	conflicts = list()
	mob_trait = TRAIT_ERPLONGTERM
	human_only = FALSE

/datum/quirk/erpbottom //or dan, or fuzzy, or kuddles or like 9/10ths of the dev team, lmao
	name = "ERP Seeking - I am a Bottom"
	desc = "You're a bottom. Be you shy, bratty, or somewhere in between. You prefer to be approached and woo'd over doing the approaching (lets be real, that's scary!)"
	value = 0
	category = "Bawdy Quirks"
	mechanics = "More like Buwudy quirks, am I right?"
	conflicts = list()
	mob_trait = TRAIT_ERPBOTTOM
	human_only = FALSE

/datum/quirk/erptop
	name = "ERP Seeking - I am a Top"
	desc = "Cruel or gentle, you're the one that likes to do the approaching and picking from the options at hand."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "Go get em, cowboy. There's a lot of em', I promise."
	conflicts = list()
	mob_trait = TRAIT_ERPTOP
	human_only = FALSE

/datum/quirk/erpswitch
	name = "ERP Seeking - I am a Switch"
	desc = "There's two sides to your coin, you don't mind being approached or doing the approaching. Just as long as someone gets touched."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "If you lean a specific direction maybe take it to."
	conflicts = list()
	mob_trait = TRAIT_ERPSWITCH
	human_only = FALSE

/datum/quirk/erpflirty
	name = "ERP Seeking - Flirty"
	desc = "More of a guideline, you enjoy using the *flirt system built into our say verbs, or enjoy having them used on you. It really can clarify how people feel, after all."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "We understand that the *help verb is a mess right now, but this is a sign to others that using the *flirt related verbs on you is a GREAT way to get your attention."
	conflicts = list()
	mob_trait = TRAIT_ERPFLIRTY
	human_only = FALSE


//Adventure Traits

/datum/quirk/advseeker
	name = "Adventure Seeking"
	desc = "You keep an eye out for the type of person who sees this swampy wasteland as a way to grow famous and rich.  Preferably both."
	value = 0
	category = "Perceptive Quirks"
	mechanics = "This is a flag quirk that lets you see what other peoples builds are for going out and doing adventure, letting you more easily build your groups strenghths up and check weaknesses."
	conflicts = list()
	mob_trait = TRAIT_ADV_SEEKER
	human_only = FALSE

/datum/quirk/adver
	name = "Adventurer"
	desc = "You are one of those people who go about in search of what was in hopes of making what is bigger and better. Or maybe you just focus on making money. It's your call."
	value = 0
	category = "Adventure Quirks"
	mechanics = "You're really always on call for a wild time. Wanna go kill some robots later?"
	conflicts = list()
	mob_trait = TRAIT_ADV_ER
	human_only = FALSE

/datum/quirk/advlfg
	name = "Adventurer - Looking for Group"
	desc = "The wasteland calls to you, and you hope that others hear its call as well. As such, you prefer to explore with a friend, or maybe even friends."
	value = 0
	category = "Adventure Quirks"
	mechanics = "This is the flag to tell others that you are really down for going out at any time!"
	conflicts = list()
	mob_trait = TRAIT_ADV_LFG
	human_only = FALSE

/datum/quirk/advsolo
	name = "Adventurer - Not Looking for Group"
	desc = "The wasteland calls to you, and you're your own ride and die. No need to bring others along in your book."
	value = 0
	category = "Adventure Quirks"
	mechanics = "This is the flag to tell others that you aren't really looking for adventure today."
	conflicts = list()
	mob_trait = TRAIT_ADV_SOLO
	human_only = FALSE

/datum/quirk/advgunner
	name = "Adventurer - Class: Gunner"
	desc = "While this offers no mechanical boons this tag lets other adventurers know you're a Gunner at heart. Be it long gun, smg, or even black powder you're happiest with slinging lead, arrows, rocks, or the like. Generally staying somewhat back from combat."
	value = 0
	category = "Adventure Quirks"
	mechanics = "Not a skygunner though, no airplanes around here. Yet."
	conflicts = list()
	mob_trait = TRAIT_ADV_GUNNER
	human_only = FALSE

/datum/quirk/advfighter
	name = "Adventurer - Class: Fighter"
	desc = "While this offers no mechanical boons this tag lets other adventurers know you're a Fighter at heart. Using Melee weapons, though not usually a shield, you can do a good job of keeping critters away from friends and probably do decent damage."
	value = 0
	category = "Adventure Quirks"
	mechanics = "No, you don't get an extra 'feat' for taking this."
	conflicts = list()
	mob_trait = TRAIT_ADV_FIGHTER
	human_only = FALSE

/datum/quirk/advtank
	name = "Adventurer - Class: Tank"
	desc = "While this offers no mechanical boons this tag lets other adventurers know you're a Tank at heart. What matters most to you is your shield, and ability to block monsters from getting past you as best you can, while others do the real damage."
	value = 0
	category = "Adventure Quirks"
	mechanics = "No promises about your team actually using you as a shield, you know how it is man."
	conflicts = list()
	mob_trait = TRAIT_ADV_TANK
	human_only = FALSE

/datum/quirk/advbruiser
	name = "Adventurer - Class: Bruiser"
	desc = "While this offers no mechanical boons this tag lets other adventurers know you're a Bruiser at heart. Two handed weapons are your jam (and jam smasher, for that matter.) With little focus on keeping yourself, or others, safe. Which means you can focus on smashing things as fast as possible."
	value = 0
	category = "Adventure Quirks"
	mechanics = "Bruise em', smash em', stick em' in a stew."
	conflicts = list()
	mob_trait = TRAIT_ADV_BRUISER
	human_only = FALSE

/datum/quirk/advrogue
	name = "Adventurer - Class: Rogue"
	desc = "While this offers no mechanical boons this tag lets other adventurers know you're a Rogue at heart. Carrying tools and offering options that the other classes may not consider. Like lockpicks, or EMP grenades. This lets others know you're focused on playing smarter, not harder."
	value = 0
	category = "Adventure Quirks"
	mechanics = "If you pray for extra backstab damage I promise I'll only smite you three times. ~Fenny"
	conflicts = list()
	mob_trait = TRAIT_ADV_ROGUE
	human_only = FALSE

/datum/quirk/advhealer
	name = "Adventurer - Class: Healer"
	desc = "While this offers no mechanical boons this tag lets other adventurers know you're a Healer at heart. Be it with consumables or the innate healing quirks this tag lets others know you're focused on keeping them up and in the fight. That doesn't mean you can't defend yourself though."
	value = 0
	category = "Adventure Quirks"
	mechanics = "Doesn't actually require you to take the quirk for being a bottom, believe it or not."
	conflicts = list()
	mob_trait = TRAIT_ADV_HEALER
	human_only = FALSE

/datum/quirk/distinct
	name = "Distinct"
	desc = "Whether you've got horns, wings, a big ass tail, or maybe just your general vibe, something about you cannot be concealed"
	value = 0
	category = "Lifepath Quirks"
	mechanics = "Face coverings will not hide your identity from others, including flavor text and species"
	conflicts = list()
	mob_trait = TRAIT_NOHIDEFACE
	gain_text = span_notice("You feel seen!")
	lose_text = span_notice("You feel hidden")

/obj/item/clothing/proc/FixClothesFit()
	set name = "Fix Fit"
	SEND_SIGNAL(src, COMSIG_CLOTHING_FIX, usr)
	verbs -= /obj/item/clothing/proc/FixClothesFit

#define	CLOTHING_FIX_TIME_MIN 10 MINUTES
#define CLOTHING_FIX_TIME_MAX 15 MINUTES 

/datum/quirk/dan_nicki
	name = "Big Boobs"
	desc = "If the internet was a thing, people would be looking you up on google."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "You need to fix the fit of your clothes every once in a while, or your breathing will be restricted and you'll take a tiny bit of suffocation damage."
	conflicts = list()
	gain_text = span_notice("It's hard to find clothes that fit around your chest.")
	lose_text = span_notice("The urge to find a tailor disappears.")
	var/debufftimer = null
	var/warningtimer = null
	var/active = FALSE
	var/datum/status_effect/debuff = /datum/status_effect/dan_nicki
	var/warning_text = "Your top is really squeezing at your breasts..."
	var/unfix_text = "You shift and your top is suddenly squeezing down on your chest very uncomfortably.  You should fix your fit."
	var/fix_text = "You take your top in hand and shift it, trying to get your cleavage under control."
	var/drop_text = "Whew... free at last!"

/datum/status_effect/dan_nicki
	id = "Constriction"
	duration = -1
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE

/datum/status_effect/dan_nicki/tick()
	. = ..()
	owner.adjustOxyLoss(0.5)

/datum/quirk/dan_nicki/proc/make_timers()
	deltimer(debufftimer)
	deltimer(warningtimer)
	var/time_til_debuff = rand(CLOTHING_FIX_TIME_MIN, CLOTHING_FIX_TIME_MAX)
	var/time_til_warning = time_til_debuff - (1 MINUTES)
	debufftimer = addtimer(CALLBACK(src, PROC_REF(unfixclothes)), time_til_debuff, TIMER_DELETE_ME | TIMER_STOPPABLE)
	warningtimer = addtimer(CALLBACK(src, PROC_REF(warn)), time_til_warning, TIMER_DELETE_ME | TIMER_STOPPABLE)

/datum/quirk/dan_nicki/add()
	. = ..()
	make_timers()

/datum/quirk/dan_nicki/remove()
	. = ..()
	deltimer(debufftimer)
	deltimer(warningtimer)

/datum/quirk/dan_nicki/proc/unfixclothes()
	var/mob/living/H = quirk_holder
	var/obj/item/clothing/under/prison = H.get_item_by_slot(SLOT_W_UNIFORM)
	if(prison)
		H.apply_status_effect(debuff)
		prison.verbs += /obj/item/clothing/proc/FixClothesFit
		RegisterSignal(prison, COMSIG_CLOTHING_FIX, PROC_REF(on_fix))
		RegisterSignal(prison, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
		to_chat(H, span_warning(unfix_text))
		active = TRUE
	else
		make_timers()

/datum/quirk/dan_nicki/proc/warn()
	if(quirk_holder.get_item_by_slot(SLOT_W_UNIFORM))
		to_chat(quirk_holder, span_warning(warning_text))

/datum/quirk/dan_nicki/proc/on_fix(obj/item/source, mob/user)
	var/mob/living/H = user
	if(!istype(H))
		return
	if(!active || H.get_item_by_slot(SLOT_W_UNIFORM) != source)
		return
	H.remove_status_effect(debuff)
	to_chat(H, span_warning(fix_text))
	user.visible_message(span_info("[user] adjusts their top."), null, null, 3)
	active = FALSE
	make_timers()

/datum/quirk/dan_nicki/proc/on_drop(obj/item/source, mob/user)
	var/mob/living/H = user
	if(!istype(H))
		return
	if(!active || H.get_item_by_slot(SLOT_W_UNIFORM))
		return
	H.remove_status_effect(debuff)
	to_chat(H, span_warning(drop_text))
	user.visible_message(span_info("[user] undoes their clothing to find some relief."), null, null, 3)
	var/obj/item/clothing/S = source
	S.verbs -= /obj/item/clothing/proc/FixClothesFit
	active = FALSE
	make_timers()


#undef CLOTHING_FIX_TIME_MIN
#undef CLOTHING_FIX_TIME_MAX

/datum/quirk/dan_nicki/wreckingballs
	name = "Big Balls"
	desc = "You have a hard time finding clothes that fit."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "You need to fix the fit of your clothes every once in a while, or you'll suffer a speed penalty."
	conflicts = list()
	gain_text = span_notice("The heavy swingers between your legs strain your clothes.")
	lose_text = span_notice("Your clothes feel looser.")
	debuff = /datum/status_effect/wreckingballs
	warning_text = "Your balls shift and start to get uncomfortable in your pants."
	unfix_text = "You shift once more and your nads feel like they're trapped, augh!  Time to fix your fit!"
	fix_text = "You subtly reach down and rearrange your tackle."
	drop_text = "Whew... free at last!"

/datum/status_effect/wreckingballs
	id = "Constriction"
	duration = -1
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE

/datum/status_effect/wreckingballs/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/wreckingballs, TRUE, "wreckingballs")

/datum/status_effect/wreckingballs/on_remove()
	. = ..()
	owner.remove_movespeed_modifier("wreckingballs", update = TRUE)

/datum/movespeed_modifier/wreckingballs
	flags = IGNORE_NOSLOW
	variable = TRUE
	multiplicative_slowdown = 0.3

/datum/quirk/dan_nicki/wreckingballs/proc/on_fix(obj/item/source, mob/user)
	var/mob/living/H = user
	if(!istype(H))
		return
	if(!active || H.get_item_by_slot(SLOT_W_UNIFORM) != source)
		return
	H.remove_status_effect(debuff)
	to_chat(H, span_warning(fix_text))
	user.visible_message(span_info("[user] very subtly adjusts the inseam of their pants."), null, null, 3)
	active = FALSE
	make_timers()


/datum/quirk/dan_nicki/hugecock
	name = "Big Dick"
	desc = "You have a HARD time finding clothes that fit."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "You need to fix the fit of your clothes every once in a while, or your clothes will be too tight to reach into your pockets."
	conflicts = list()
	gain_text = span_notice("You feel your clothes stretch around your extra leg.")
	lose_text = span_notice("Your clothes feel looser.")
	debuff = /datum/status_effect/hotrod
	warning_text = "Your pants really starts to feel constraining."
	unfix_text = "Your pants are starting to actively make you uncomfortable due to a lack of space inside, fix your fit!"
	fix_text = "You feel like you can reach into your pockets again. That's much better."
	drop_text = "Whew... free at last!"

/datum/status_effect/hotrod
	id = "Constriction"
	duration = -1
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE

/datum/status_effect/hotrod/on_apply()
	. = ..()
	RegisterSignal(owner, COMSIG_MOB_CLICKON, PROC_REF(on_clickon))

/datum/status_effect/hotrod/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOB_CLICKON)

/datum/status_effect/hotrod/proc/on_clickon(atom/A, params)

	var/obj/item/left = owner.get_item_by_slot(SLOT_L_STORE)
	var/obj/item/right = owner.get_item_by_slot(SLOT_R_STORE)
	if(params == left || params == right)
		return COMSIG_MOB_CANCEL_CLICKON

/datum/quirk/dan_nicki/hotrod/proc/on_fix(obj/item/source, mob/user)
	var/mob/living/H = user
	if(!istype(H))
		return
	if(!active || H.get_item_by_slot(SLOT_W_UNIFORM) != source)
		return
	H.remove_status_effect(debuff)
	to_chat(H, span_warning(fix_text))
	user.visible_message(span_info("[user] very subtly tugs at the front of their pants."), null, null, 3)
	active = FALSE
	make_timers()	


/datum/quirk/dan_nicki/cake
	name = "Big Ass"
	desc = "You have a hard time getting your clothes on."
	value = 0
	category = "Bawdy Quirks"
	mechanics = "You need to fix the fit of your clothes every once in a while, or they'll become uncomfortable."
	conflicts = list()
	gain_text = span_notice("You feel your lower body being compressed by your clothes.")
	lose_text = span_notice("Your clothes feel looser.")
	debuff = /datum/status_effect/toomuchcake
	warning_text = "Your lower outfit shift and you realize it was a miracle you got them on."
	unfix_text = "You're pretty sure this is what it feels like to have your butt put through a mangle. Fix your fit!"
	fix_text = "You no longer feel like your own clothing is trying to give you the grippers!"
	drop_text = "Whew... free at last!"

/datum/status_effect/toomuchcake
	id = "Constriction"
	duration = -1
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE

/datum/status_effect/toomuchcake/on_apply()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "toomuchcake", /datum/mood_event/toomuchcake)

/datum/status_effect/toomuchcake/on_remove()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "toomuchcake")

/datum/mood_event/toomuchcake
	mood_change = -4
	description = span_warning("These clothes are way too tight!")

/datum/quirk/dan_nicki/toomuchcake/proc/on_fix(obj/item/source, mob/user)
	var/mob/living/H = user
	if(!istype(H))
		return
	if(!active || H.get_item_by_slot(SLOT_W_UNIFORM) != source)
		return
	H.remove_status_effect(debuff)
	to_chat(H, span_warning(fix_text))
	user.visible_message(span_info("[user] runs their hands over their bottomwear, trying to smooth it out."), null, null, 3)
	active = FALSE
	make_timers()	

