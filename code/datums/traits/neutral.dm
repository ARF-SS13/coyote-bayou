//traits with no real impact that can be taken freely
//MAKE SURE THESE DO NOT MAJORLY IMPACT GAMEPLAY. those should be positive or negative traits.

/datum/quirk/no_taste
	name = "Ageusia"
	desc = "You can't taste anything! Toxic food will still poison you."
	value = 0
	mob_trait = TRAIT_AGEUSIA
	gain_text = span_notice("You can't taste anything!")
	lose_text = span_notice("You can taste again!")
	medical_record_text = "Patient suffers from ageusia and is incapable of tasting food or reagents."

/datum/quirk/no_chocolate
	name = "Chocolate intolerance"
	desc = "Your metabolism finds chocolate rather disagreeable."
	value = 0
	mob_trait = TRAIT_NO_CHOCOLATE
	gain_text = span_notice("You feel like eating chocolate is a bad idea.")
	lose_text = span_notice("You feel like it's safe to eat chocolate again")
	medical_record_text = "Patient has an aversion to theobromine, and therefore cannot have chocolate."

/datum/quirk/white_woman
	name = "Peanutbutter difficulties"
	desc = "Your tongue has difficulty handling the adhesiveness of peanut butter"
	value = 0
	mob_trait = TRAIT_WHITE_WOMAN
	gain_text = span_notice("Your tongue lacks the manipulation to properly eat peanut butter.")
	lose_text = span_notice("Your tongue is skilled at taking on sticky peanut butter.")
	medical_record_text = "Patient's tongue lacks the dexterity required to eat peanut butter."

/datum/quirk/autobrew //sugary foods create ethanol
	name = "Autobrewery syndrome"
	desc = "Your natural gut flora ferments many sugary foods and drinks into alcohol. taking penicillin or eating healthy prevents this."
	value = 0
	mob_trait = TRAIT_AUTOBREW
	gain_text = span_notice("you feel rather fuzzy.")
	lose_text = span_notice("you feel more coherent.")
	medical_record_text = "Patient shows chronically unusual blood alcohol levels."

/datum/quirk/snob
	name = "Snob"
	desc = "You care about the finer things, if a room doesn't look nice its just not really worth it, is it?"
	value = 0
	gain_text = span_notice("You feel like you understand what things should look like.")
	lose_text = span_notice("Well who cares about deco anyways?")
	medical_record_text = "Patient seems to be rather stuck up."
	mob_trait = TRAIT_SNOB

/* Temporarily removed for reworking, god this thing is WAY too busy. ~TK
/quirk/fev
	name = "FEV Exposure"
	desc = " "
	value = 4
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
	desc = "You suffer from full colorblindness, and perceive nearly the entire world in blacks and whites."
	value = 0
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

/datum/quirk/maso
	name = "Masochism"
	desc = "You are aroused by pain."
	value = 0
	mob_trait = TRAIT_MASO
	gain_text = span_notice("You desire to be hurt.")
	lose_text = span_notice("Pain has become less exciting for you.")


/datum/quirk/alcohol_intolerance
	name = "Alcohol Intolerance"
	desc = "You take toxin damage from alcohol rather than getting drunk."
	value = 0
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
 */
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
	mob_trait = TRAIT_STEEL_ASS
	gain_text = "<span class='notice'>Your ass rivals those of golems.</span>"
	lose_text = "<span class='notice'>Your butt feels more squishy and slappable.</span>"

/datum/quirk/headpat_hater
	name = "Distant"
	desc = "You don't seem to show much care for being touched. Whether it's because you're reserved or due to self control, others touching your head won't make you wag your tail should you possess one, and the action may even attract your ire.."
	mob_trait = TRAIT_DISTANT
	value = 0
	gain_text = "<span class='notice'>Others' touches begin to make your blood boil...</span>"
	lose_text = "<span class='notice'>Having your head pet doesn't sound so bad right about now...</span>"
	medical_record_text = "Patient cares little with or dislikes being touched."

/datum/quirk/headpat_slut
	name = "Headpat Lover"
	desc = "You love the feeling of others touching your head! Maybe a little too much, actually... Others patting your head will provide a bigger mood boost and cause aroused reactions."
	mob_trait = TRAIT_HEADPAT_SLUT
	value = 0
	gain_text = "<span class='notice'>You crave headpats immensely!</span>"
	lose_text = "<span class='notice'>Your headpats addiction wanes.</span>"
	medical_record_text = "Patient seems overly affectionate."

/datum/quirk/overweight
	name = "Overweight"
	desc = "You're particularly fond of food, and join the round being overweight."
	value = 0
	gain_text = "<span class='notice'>You feel a bit chubby!</span>"
	//no lose_text cause why would there be?

/datum/quirk/overweight/on_spawn()
	var/mob/living/M = quirk_holder
	M.nutrition = rand(NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MIN, NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MAX)
	M.overeatduration = 100
	ADD_TRAIT(M, TRAIT_FAT, OBESITY)

/datum/quirk/vegetarian
	name = "Vegetarian"
	desc = "You find the idea of eating meat morally and/or physically repulsive."
	value = 0
	gain_text = "<span class='notice'>You feel repulsion at the idea of eating meat.</span>"
	lose_text = "<span class='notice'>You feel like eating meat isn't that bad.  Might could even go for a cheeseburger.</span>"
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
	name = "Hydra Heads"
	desc = "You are a tri-headed creature. To use, format your name like (Rucks-Sucks-Ducks) and use the action button in the top left."
	value = 0
	mob_trait = TRAIT_HYDRA_HEADS
	gain_text = "<span class='notice'>You hear two other voices inside of your head(s).</span>"
	lose_text = "<span class='danger'>All of your minds become singular.</span>"
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
	hydra.visible_message("<span class='notice'>[hydra.name] pushes all three heads forwards; they seem to be talking as a collective.</span>", \
							"<span class='notice'>You are now talking as [hydra.name_archive]!</span>", ignored_mobs=owner)

/datum/action/innate/hydra/Activate() //I hate this but its needed
	var/mob/living/carbon/human/hydra = owner
	var/list/names = splittext(hydra.name_archive,"-")
	var/selhead = input("Who would you like to speak as?","Heads:") in names
	hydra.real_name = selhead
	hydra.visible_message("<span class='notice'>[hydra.name] pulls the rest of their heads back; and puts [selhead]'s forward.</span>", \
							"<span class='notice'>You are now talking as [selhead]!</span>", ignored_mobs=owner)

/datum/quirk/sheltered
	name = "Sheltered"
	desc = "For one reason or another, you either can't or haven't learned English."
	value = 0
	mob_trait = TRAIT_SHELTERED
	gain_text = "<span class='danger'>The words of others begin to blur together...</span>"
	lose_text = "<span class='notice'>You start putting together what people are saying!</span>"
	medical_record_text = "Patient has shown an inability to use common speaking languages."

/datum/quirk/sheltered/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.remove_language(/datum/language/common)
// You can pick languages for your character, if you don't pick anything, enjoy the rest of the round understanding nothing.

/datum/quirk/sheltered/remove() //i mean, the lose text explains it, so i'm making it actually work
	var/mob/living/carbon/human/H = quirk_holder
	H.grant_language(/datum/language/common)

/datum/quirk/tribespeak
	name = "Tribal Language Comprehension"
	desc = "You're somehow capable of understanding and speaking the common tribal languages in the area."
	value = 0
	gain_text = span_notice("You remember the old ways of your tribe..")
	lose_text = span_notice("You've forgotten the ways of your ancestors..")


/datum/quirk/tribespeak/add()
	var/mob/living/carbon/human/H = quirk_holder
	H.grant_language(/datum/language/tribal)

/datum/quirk/tribespeak/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(!QDELETED(H))
		H.remove_language(/datum/language/tribal)

/datum/quirk/in_heat
	name = "ERP Receptive"
	desc = "Your character, for whatever reason, is PASSIVELY seeking out attention from those who match your OOC Prefences. Remember to set your OOC notes!"
	value = 0
	mob_trait = TRAIT_IN_HEAT


/datum/quirk/heat
	name = "ERP Seeking"
	desc = "Your character, for whatever reason, is ACTIVELY seeking out attention from those who match your OOC Preferences. Remember to check peoples OOC notes!"
	value = 0
	mob_trait = TRAIT_HEAT_DETECT

/datum/quirk/smol
	name = "Smol!"
	desc = "Maybe you're really smol, maybe you're just really light, maybe you're *really* into yoga. However it is, others can Alt-Click to pick you up like an item!"
	value = 0
	mob_trait = TRAIT_SMOL
	gain_text = span_notice("You feel scoopable! Others can ALT-CLICK you to pick you up!")
	lose_text = span_notice("You feel a lot less scoopable.")

/datum/quirk/smol/add()
	if(istype(quirk_holder))
		quirk_holder.AddElement(/datum/element/mob_holder, "corgi") // dog

/datum/quirk/smol/remove()
	if(istype(quirk_holder))
		quirk_holder.RemoveElement(/datum/element/mob_holder) // undog

/datum/quirk/cat
	name = "A cat!"
	desc = "You identify as a cat! (Mostly to help identify your species mechanically)"
	value = 0
	mob_trait = TRAIT_RAT
/datum/quirk/rat
	name = "A rat!"
	desc = "You identify as a rat! (Mostly to help identify your species mechanically)"
	value = 0
	mob_trait = TRAIT_RAT
/datum/quirk/spider
	name = "A spider!"
	desc = "You identify as a spider! (Mostly to help identify your species mechanically)"
	value = 0
	mob_trait = TRAIT_SPIDER
/datum/quirk/lizard
	name = "A lizard or reptillian!"
	desc = "You identify as a lizard/reptillian! (Mostly to help identify your species mechanically)"
	value = 0
	mob_trait = TRAIT_LIZARD
/datum/quirk/robot
	name = "A robot/synth!"
	desc = "You identify as a robot/synth! (Mostly to help identify your species mechanically)"
	value = 0
	mob_trait = TRAIT_ROBOT

/datum/quirk/bird
	name = "A bird!"
	desc = "You identify as a bird! (Mostly to help identify your species mechanically)"
	value = 0
	mob_trait = TRAIT_BIRD

/datum/quirk/dog
	name = "A dog!"
	desc = "You identify as a dog! (Mostly to help identify your species mechanically)"
	value = 0
	mob_trait = TRAIT_DOG

/datum/quirk/photographer
	name = "Photographer"
	desc = "You carry your camera and personal photo album everywhere you go, and your scrapbooks are legendary among your coworkers."
	value = 0
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

/datum/quirk/zoomies
	name = "Zoomies"
	desc = "You can sprint twice as far before you begin to get tired. Just don't run into things."
	value = 0
	mob_trait = TRAIT_ZOOMIES

/datum/quirk/super_zoomies
	name = "Zoomies - Super"
	desc = "You never tire of sprinting at all, just be extremely careful not to run into things."
	value = 0
	mob_trait = TRAIT_SUPER_ZOOMIES

/datum/quirk/lick_heal
	name = "Innate healing - Saliva"
	desc = "Your saliva has a mild healing effect on burns and bruises. Use *lick to lick the injuries of yourself or others. Drinking water helps recover from a dry tongue faster."
	value = 0
	mob_trait = TRAIT_HEAL_TONGUE
	gain_text = span_notice("You feel a slight tingle in your mouth.")
	lose_text = span_danger("The tingle in your mouth fades.")
	locked = FALSE

/datum/quirk/touch_heal
	name = "Innate healing - Magic"
	desc = "Your touch has a mild healing effect on burns and bruises. Use *touch to sooth the injuries of yourself or others. Drinking water helps recover from the fatigue of using the spell faster."
	value = 0
	mob_trait = TRAIT_HEAL_TOUCH
	gain_text = span_notice("You feel a slight tingle in your hands.")
	lose_text = span_danger("The tingle in your palm fades.")
	locked = FALSE

/datum/quirk/tend_heal
	name = "Innate healing - Triage"
	desc = "You keep a tiny kit of medical supplies stashed away for emergencies. Use *tend to treat the injuries of yourself or others. Drinking water helps recover your focus."
	value = 0
	mob_trait = TRAIT_HEAL_TEND
	gain_text = span_notice("You feel your triage kit tucked safely in a pocket.")
	lose_text = span_danger("You lost your triage kit...")
	locked = FALSE

// /datum/quirk/lick_heal/on_spawn()
// 	var/mob/living/carbon/human/human_holder = quirk_holder
// 	if(!quirk_holder)
// 		return //oh no
// 	var/obj/item/organ/tongue/our_tongue = human_holder.getorganslot(ORGAN_SLOT_TONGUE)
// 	if(!our_tongue)
// 		return //welp
// 	our_tongue.initialize_lickpack(/obj/item/stack/medical/bruise_pack/lick)

// /datum/quirk/lick_heal/remove()
// 	var/mob/living/carbon/human/human_holder = quirk_holder
// 	if(!quirk_holder)
// 		return //oh no
// 	var/obj/item/organ/tongue/our_tongue = human_holder.getorganslot(ORGAN_SLOT_TONGUE)
// 	if(!our_tongue)
// 		return //welp
// 	QDEL_NULL(our_tongue.lick_healer)
