///books that teach things (intrinsic actions like bar flinging, spells like fireball or smoke, or martial arts)///

/obj/item/book/granter
	due_date = 0 // Game time in deciseconds
	unique = 1   // 0  Normal book, 1  Should not be treated as normal book, unable to be copied, unable to be modified
	var/list/remarks = list() //things to read about while learning.
	var/pages_to_mastery = 3 //Essentially controls how long a mob must keep the book in his hand to actually successfully learn
	var/reading = FALSE //sanity
	var/oneuse = TRUE //default this is true, but admins can var this to 0 if we wanna all have a pass around of the rod form book
	var/used = FALSE //only really matters if oneuse but it might be nice to know if someone's used it for admin investigations perhaps
	var/select = FALSE
	var/time_per_page = 5 SECONDS

/obj/item/book/granter/proc/turn_page(mob/user)
	playsound(user, pick('sound/effects/pageturn1.ogg','sound/effects/pageturn2.ogg','sound/effects/pageturn3.ogg'), 30, 1)
	if(do_after(user,50, TRUE, user))
		if(remarks.len)
			to_chat(user, "<span class='notice'>[pick(remarks)]</span>")
		else
			to_chat(user, "<span class='notice'>You keep reading...</span>")
		return TRUE
	return FALSE

/obj/item/book/granter/proc/recoil(mob/user) //nothing so some books can just return

/obj/item/book/granter/proc/already_known(mob/user)
	return FALSE

/obj/item/book/granter/proc/on_reading_start(mob/user)
	to_chat(user, "<span class='notice'>You start reading [name]...</span>")

/obj/item/book/granter/proc/on_reading_stopped(mob/user)
	to_chat(user, "<span class='notice'>You stop reading...</span>")

/obj/item/book/granter/proc/on_reading_finished(mob/user)
	to_chat(user, "<span class='notice'>You finish reading [name]!</span>")

/obj/item/book/granter/proc/onlearned(mob/user)
	used = TRUE


/obj/item/book/granter/attack_self(mob/user)
	//if(user.special_i<5&&!istype(src,/obj/item/book/granter/trait/selection))//SPECIAL Integration
	//	to_chat(user, "<span class='warning'>You feel like you are too stupid to understand this.</span>")
	//	return
	if(reading)
		to_chat(user, "<span class='warning'>You're already reading this!</span>")
		return FALSE
	if(already_known(user))
		return FALSE
	if(used && oneuse)
		recoil(user)
	else
		on_reading_start(user)
		reading = TRUE
		for(var/i in 1 to pages_to_mastery)
			if(!turn_page(user))
				on_reading_stopped()
				reading = FALSE
				return
		if(do_after(user, time_per_page, TRUE, user))
			on_reading_finished(user)
		reading = FALSE
	return TRUE
///TRAITS///

/obj/item/book/granter/trait
	var/granted_trait
	var/traitname = "being cool"
	var/list/crafting_recipe_types = list()

/obj/item/book/granter/trait/already_known(mob/user)
	if(!granted_trait)
		return TRUE
	if(HAS_TRAIT(user, granted_trait))
		to_chat(user, "<span class ='notice'>You already have all the insight you need about [traitname].")
		return TRUE
	return FALSE

/obj/item/book/granter/trait/on_reading_start(mob/user)
	to_chat(user, "<span class='notice'>You start reading about [traitname]...</span>")

/obj/item/book/granter/trait/on_reading_finished(mob/user)
	. = ..()
	to_chat(user, "<span class='notice'>You feel like you've got a good handle on [traitname]!</span>")
	ADD_TRAIT(user, granted_trait, BOOK_TRAIT)
	if(!user.mind)
		return
	for(var/crafting_recipe_type in crafting_recipe_types)
		var/datum/crafting_recipe/R = crafting_recipe_type
		user.mind.teach_crafting_recipe(crafting_recipe_type)
		to_chat(user,"<span class='notice'>You learned how to make [initial(R.name)].</span>")
	onlearned(user)

/obj/item/book/granter/trait/rifleman
	name = "The Neo-Russian Rifleman\'s Primer"
	desc = "A book with stains of vodka and...blood? The back is hard to read, but says something about bolt-actions. Or pump-actions. Both, maybe."
	oneuse = TRUE
	granted_trait = TRAIT_FAST_PUMP
	traitname = "riflery"
	icon_state = "book1"
	remarks = list("One smooth motion...", "Palm the bolt...", "Push up, rotate back, push forward, down...", "Don't slap yourself with the bolt...", "Wait, what's this about pumping?", "Who just scribbled \"Z\" and \"LMB\" on this page?")

///ACTION BUTTONS///

/obj/item/book/granter/action
	var/granted_action
	var/actionname = "catching bugs" //might not seem needed but this makes it so you can safely name action buttons toggle this or that without it fucking up the granter, also caps

/obj/item/book/granter/action/already_known(mob/user)
	if(!granted_action)
		return TRUE
	for(var/datum/action/A in user.actions)
		if(A.type == granted_action)
			to_chat(user, "<span class='notice'>You already know all about [actionname].</span>")
			return TRUE
	return FALSE

/obj/item/book/granter/action/on_reading_start(mob/user)
	to_chat(user, "<span class='notice'>You start reading about [actionname]...</span>")

/obj/item/book/granter/action/on_reading_finished(mob/user)
	to_chat(user, "<span class='notice'>You feel like you've got a good handle on [actionname]!</span>")
	var/datum/action/G = new granted_action
	G.Grant(user)
	onlearned(user)

/obj/item/book/granter/trait/onlearned(mob/living/user)
	..()
	if(oneuse)
		user.visible_message(
		message = "<span class='notice'>Just as [user] finishes reading [p_their(user)] copy of [src], the ancient book crumbles to dust!</span>",
		self_message = "<span class='caution'>The ancient copy of [src] crumbles to dust as you finish reading it.</span>",
		blind_message = "<span class='notice'>You hear something crumble.</span>")
		ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		qdel(src)

/obj/item/book/granter/action/drink_fling
	granted_action = /datum/action/innate/drink_fling
	name = "Tapper: This One's For You"
	desc = "A seminal work on the dying art of booze sliding."
	icon_state = "barbook"
	actionname = "drink flinging"
	oneuse = FALSE
	remarks = list("The trick is keeping a low center of gravity it seems...", "The viscosity of the liquid is important...", "Accounting for crosswinds... really?", "Drag coefficients of various popular drinking glasses...", "What the heck is laminar flow and why does it matter here?", "Greasing the bar seems like it'd be cheating...", "I don't think I'll be working with superfluids...")

/datum/action/innate/drink_fling
	name = "Drink Flinging"
	desc = "Toggles your ability to satisfyingly throw glasses without spilling them."
	button_icon_state = "drinkfling_off"
	check_flags = 0

/datum/action/innate/drink_fling/Activate()
	button_icon_state = "drinkfling_on"
	active = TRUE
	UpdateButtonIcon()

/datum/action/innate/drink_fling/Deactivate()
	button_icon_state = "drinkfling_off"
	active = FALSE
	UpdateButtonIcon()

/obj/item/book/granter/action/origami
	granted_action = /datum/action/innate/origami
	name = "The Art of Origami"
	desc = "A meticulously in-depth manual explaining the art of paper folding."
	icon_state = "origamibook"
	actionname = "origami"
	oneuse = TRUE
	remarks = list("Dead-stick stability...", "Symmetry seems to play a rather large factor...", "Accounting for crosswinds... really?", "Drag coefficients of various paper types...", "Thrust to weight ratios?", "Positive dihedral angle?", "Center of gravity forward of the center of lift...")

/datum/action/innate/origami
	name = "Origami Folding"
	desc = "Toggles your ability to fold and catch robust paper airplanes."
	button_icon_state = "origami_off"
	check_flags = NONE

/datum/action/innate/origami/Activate()
	to_chat(owner, "<span class='notice'>You will now fold origami planes.</span>")
	button_icon_state = "origami_on"
	active = TRUE
	UpdateButtonIcon()

/datum/action/innate/origami/Deactivate()
	to_chat(owner, "<span class='notice'>You will no longer fold origami planes.</span>")
	button_icon_state = "origami_off"
	active = FALSE
	UpdateButtonIcon()

///SPELLS///

/obj/item/book/granter/spell
	var/spell
	var/spellname = "conjure bugs"

/obj/item/book/granter/spell/already_known(mob/user)
	if(!spell)
		return TRUE
	for(var/obj/effect/proc_holder/spell/knownspell in user.mind.spell_list)
		if(knownspell.type == spell)
			if(user.mind)
				if(iswizard(user))
					to_chat(user,"<span class='notice'>You're already far more versed in this spell than this flimsy how-to book can provide.</span>")
				else
					to_chat(user,"<span class='notice'>You've already read this one.</span>")
			return TRUE
	return FALSE

/obj/item/book/granter/spell/on_reading_start(mob/user)
	to_chat(user, "<span class='notice'>You start reading about casting [spellname]...</span>")

/obj/item/book/granter/spell/on_reading_finished(mob/user)
	to_chat(user, "<span class='notice'>You feel like you've experienced enough to cast [spellname]!</span>")
	var/obj/effect/proc_holder/spell/S = new spell
	user.mind.AddSpell(S)
	user.log_message("learned the spell [spellname] ([S])", LOG_ATTACK, color="orange")
	onlearned(user)

/obj/item/book/granter/spell/recoil(mob/user)
	user.visible_message("<span class='warning'>[src] glows in a black light!</span>")

/obj/item/book/granter/spell/onlearned(mob/user)
	..()
	if(oneuse)
		user.visible_message("<span class='caution'>[src] glows dark for a second!</span>")

/obj/item/book/granter/spell/fireball
	spell = /obj/effect/proc_holder/spell/aimed/fireball
	spellname = "fireball"
	icon_state ="bookfireball"
	desc = "This book feels warm to the touch."
	remarks = list("Aim...AIM, FOOL!", "Just catching them on fire won't do...", "Accounting for crosswinds... really?", "I think I just burned my hand...", "Why the dumb stance? It's just a flick of the hand...", "OMEE... ONI... Ugh...", "What's the difference between a fireball and a pyroblast...")

/obj/item/book/granter/spell/fireball/recoil(mob/user)
	..()
	explosion(user.loc, 1, 0, 2, 3, FALSE, FALSE, 2)
	qdel(src)

/obj/item/book/granter/spell/nuclearfist
	spell = /obj/effect/proc_holder/spell/targeted/touch/nuclear_fist
	spellname = "nuclear fist"
	icon_state ="booknuclearfist"
	desc = "This book radiates confidence."
	remarks = list("Line them up....", ".. knock em' down...", "Dress in yellow for maximum effect... why?", "The energy comes from spinach... huh", "Work out for three years? No way!", "Oh I'll cast you a spell allright...", "What ho mighty wizard... ho ho ho...")

/obj/item/book/granter/spell/nuclearfist/recoil(mob/living/carbon/user)
	..()
	to_chat(user, "<span class='danger'>Your arm spontaneously detonates!</span>")
	explosion(user.loc, -1, 0, 2, -1, FALSE, FALSE, 2)
	var/obj/item/bodypart/part = user.get_holding_bodypart_of_item(src)
	if(part)
		part.dismember()
		qdel(part)


/obj/item/book/granter/spell/sacredflame
	spell = /obj/effect/proc_holder/spell/targeted/sacred_flame
	spellname = "sacred flame"
	icon_state ="booksacredflame"
	desc = "Become one with the flames that burn within... and invite others to do so as well."
	remarks = list("Well, it's one way to stop an attacker...", "I'm gonna need some good gear to stop myself from burning to death...", "Keep a fire extinguisher handy, got it...", "I think I just burned my hand...", "Apply flame directly to chest for proper ignition...", "No pain, no gain...", "One with the flame...")

/obj/item/book/granter/spell/smoke
	spell = /obj/effect/proc_holder/spell/targeted/smoke
	spellname = "smoke"
	icon_state ="booksmoke"
	desc = "This book is overflowing with the dank arts."
	remarks = list("Smoke Bomb! Heh...", "Smoke bomb would do just fine too...", "Wait, there's a machine that does the same thing in chemistry?", "This book smells awful...", "Why all these weed jokes? Just tell me how to cast it...", "Wind will ruin the whole spell, good thing we're in space... Right?", "So this is how the spider clan does it...")

/obj/item/book/granter/spell/smoke/lesser //Chaplain smoke book
	spell = /obj/effect/proc_holder/spell/targeted/smoke/lesser

/obj/item/book/granter/spell/smoke/recoil(mob/user)
	..()
	to_chat(user,"<span class='caution'>Your stomach rumbles...</span>")
	if(user.nutrition > NUTRITION_LEVEL_STARVING + 50)
		user.set_nutrition(NUTRITION_LEVEL_STARVING + 50)

/obj/item/book/granter/spell/blind
	spell = /obj/effect/proc_holder/spell/pointed/trigger/blind
	spellname = "blind"
	icon_state ="bookblind"
	desc = "This book looks blurry, no matter how you look at it."
	remarks = list("Well I can't learn anything if I can't read the damn thing!", "Why would you use a dark font on a dark background...", "Ah, I can't see an Oh, I'm fine...", "I can't see my hand...!", "I'm manually blinking, damn you book...", "I can't read this page, but somehow I feel like I learned something from it...", "Hey, who turned off the lights?")

/obj/item/book/granter/spell/blind/recoil(mob/user)
	..()
	to_chat(user,"<span class='warning'>You go blind!</span>")
	user.blind_eyes(10)

/obj/item/book/granter/spell/mindswap
	spell = /obj/effect/proc_holder/spell/pointed/mind_transfer
	spellname = "mindswap"
	icon_state ="bookmindswap"
	desc = "This book's cover is pristine, though its pages look ragged and torn."
	var/mob/stored_swap //Used in used book recoils to store an identity for mindswaps
	remarks = list("If you mindswap from a mouse, they will be helpless when you recover...", "Wait, where am I...?", "This book is giving me a horrible headache...", "This page is blank, but I feel words popping into my head...", "GYNU... GYRO... Ugh...", "The voices in my head need to stop, I'm trying to read here...", "I don't think anyone will be happy when I cast this spell...")

/obj/item/book/granter/spell/mindswap/onlearned()
	spellname = pick("fireball","smoke","blind","forcewall","knock","barnyard","charge")
	icon_state = "book[spellname]"
	name = "spellbook of [spellname]" //Note, desc doesn't change by design
	..()

/obj/item/book/granter/spell/mindswap/recoil(mob/user)
	..()
	if(stored_swap in GLOB.dead_mob_list)
		stored_swap = null
	if(!stored_swap)
		stored_swap = user
		to_chat(user,"<span class='warning'>For a moment you feel like you don't even know who you are anymore.</span>")
		return
	if(stored_swap == user)
		to_chat(user,"<span class='notice'>You stare at the book some more, but there doesn't seem to be anything else to learn...</span>")
		return
	var/obj/effect/proc_holder/spell/pointed/mind_transfer/swapper = new
	if(swapper.cast(list(stored_swap), user, TRUE, TRUE))
		to_chat(user,"<span class='warning'>You're suddenly somewhere else... and someone else?!</span>")
		to_chat(stored_swap,"<span class='warning'>Suddenly you're staring at [src] again... where are you, who are you?!</span>")
	else
		user.visible_message("<span class='warning'>[src] fizzles slightly as it stops glowing!</span>") //if the mind_transfer failed to transfer mobs, likely due to the target being catatonic.

	stored_swap = null

/obj/item/book/granter/spell/forcewall
	spell = /obj/effect/proc_holder/spell/targeted/forcewall
	spellname = "forcewall"
	icon_state ="bookforcewall"
	desc = "This book has a dedication to mimes everywhere inside the front cover."
	remarks = list("I can go through the wall! Neat.", "Why are there so many mime references...?", "This would cause much grief in a hallway...", "This is some surprisingly strong magic to create a wall nobody can pass through...", "Why the dumb stance? It's just a flick of the hand...", "Why are the pages so hard to turn, is this even paper?", "I can't mo Oh, i'm fine...")

/obj/item/book/granter/spell/forcewall/recoil(mob/living/user)
	..()
	to_chat(user,"<span class='warning'>You suddenly feel very solid!</span>")
	user.Stun(40, ignore_canstun = TRUE)
	user.petrify(30)

/obj/item/book/granter/spell/knock
	spell = /obj/effect/proc_holder/spell/aoe_turf/knock
	spellname = "knock"
	icon_state ="bookknock"
	desc = "This book is hard to hold closed properly."
	remarks = list("Open Sesame!", "So THAT'S the magic password!", "Slow down, book. I still haven't finished this page...", "The book won't stop moving!", "I think this is hurting the spine of the book...", "I can't get to the next page, it's stuck t- I'm good, it just turned to the next page on it's own.", "Yeah, staff of doors does the same thing. Go figure...")

/obj/item/book/granter/spell/knock/recoil(mob/living/user)
	..()
	to_chat(user,"<span class='warning'>You're knocked down!</span>")
	user.DefaultCombatKnockdown(40)

/obj/item/book/granter/spell/barnyard
	spell = /obj/effect/proc_holder/spell/pointed/barnyardcurse
	spellname = "barnyard"
	icon_state ="bookhorses"
	desc = "This book is more horse than your mind has room for."
	remarks = list("Moooooooo!","Moo!","Moooo!", "NEEIIGGGHHHH!", "NEEEIIIIGHH!", "NEIIIGGHH!", "HAAWWWWW!", "HAAAWWW!", "Oink!", "Squeeeeeeee!", "Oink Oink!", "Ree!!", "Reee!!", "REEE!!", "REEEEE!!")

/obj/item/book/granter/spell/barnyard/recoil(mob/living/carbon/user)
	if(ishuman(user))
		to_chat(user,"<font size='15' color='red'><b>HORSIE HAS RISEN</b></font>")
		var/obj/item/clothing/magichead = new /obj/item/clothing/mask/horsehead/cursed(user.drop_location())
		if(!user.dropItemToGround(user.wear_mask))
			qdel(user.wear_mask)
		user.equip_to_slot_if_possible(magichead, SLOT_WEAR_MASK, TRUE, TRUE)
		qdel(src)
	else
		to_chat(user,"<span class='notice'>I say thee neigh</span>") //It still lives here

/obj/item/book/granter/spell/charge
	spell = /obj/effect/proc_holder/spell/targeted/charge
	spellname = "charge"
	icon_state ="bookcharge"
	desc = "This book is made of 100% postconsumer wizard."
	remarks = list("I feel ALIVE!", "I CAN TASTE THE MANA!", "What a RUSH!", "I'm FLYING through these pages!", "THIS GENIUS IS MAKING IT!", "This book is ACTION PAcKED!", "HE'S DONE IT", "LETS GOOOOOOOOOOOO", "Just wait faster is all...")

/obj/item/book/granter/spell/charge/recoil(mob/user)
	..()
	to_chat(user,"<span class='warning'>[src] suddenly feels very warm!</span>")
	empulse_using_range(src, 1)

/obj/item/book/granter/spell/summonitem
	spell = /obj/effect/proc_holder/spell/targeted/summonitem
	spellname = "instant summons"
	icon_state ="booksummons"
	desc = "This book is bright and garish, very hard to miss."
	remarks = list("I can't look away from the book!", "The words seem to pop around the page...", "I just need to focus on one item...", "Make sure to have a good grip on it when casting...", "Slow down, book. I still haven't finished this page...", "Sounds pretty great with some other magical artifacts...", "Magicians must love this one.")

/obj/item/book/granter/spell/summonitem/recoil(mob/user)
	..()
	to_chat(user,"<span class='warning'>[src] suddenly vanishes!</span>")
	qdel(src)

/obj/item/book/granter/spell/random
	icon_state = "random_book"

///MARTIAL ARTS///

/obj/item/book/granter/martial
	var/martial
	var/martialname = "bug jitsu"
	var/greet = "You feel like you have mastered the art in breaking code. Nice work, jackass."

/obj/item/book/granter/martial/already_known(mob/user)
	if(!martial)
		return TRUE
	var/datum/martial_art/MA = martial
	if(user.mind.has_martialart(initial(MA.id)))
		to_chat(user,"<span class='warning'>You already know [martialname]!</span>")
		return TRUE
	return FALSE

/obj/item/book/granter/martial/on_reading_start(mob/user)
	to_chat(user, "<span class='notice'>You start reading about [martialname]...</span>")

/obj/item/book/granter/martial/on_reading_finished(mob/user)
	to_chat(user, "[greet]")
	var/datum/martial_art/MA = new martial
	MA.teach(user)
	user.log_message("learned the martial art [martialname] ([MA])", LOG_ATTACK, color="orange")
	onlearned(user)

/obj/item/book/granter/martial/cqc
	martial = /datum/martial_art/cqc
	name = "old manual"
	martialname = "close quarters combat"
	desc = "A small, black manual. There are drawn instructions of tactical hand-to-hand combat."
	greet = "<span class='boldannounce'>You've mastered the basics of CQC.</span>"
	icon_state = "cqcmanual"
	remarks = list("Kick... Slam...", "Lock... Kick...", "Strike their abdomen, neck and back for critical damage...", "Slam... Lock...", "I could probably combine this with some other martial arts!", "Words that kill...", "The last and final moment is yours...")

/obj/item/book/granter/martial/cqc/onlearned(mob/living/carbon/user)
	..()
	if(oneuse == TRUE)
		to_chat(user, "<span class='warning'>[src] beeps ominously...</span>")

/obj/item/book/granter/martial/cqc/recoil(mob/living/carbon/user)
	to_chat(user, "<span class='warning'>[src] explodes!</span>")
	playsound(src,'sound/effects/explosion1.ogg',40,1)
	user.flash_act(1, 1)
	user.adjustBruteLoss(6)
	user.adjustFireLoss(6)
	qdel(src)

/obj/item/book/granter/martial/carp
	martial = /datum/martial_art/the_sleeping_carp
	name = "mysterious scroll"
	martialname = "sleeping carp"
	desc = "A scroll filled with strange markings. It seems to be drawings of some sort of martial art."
	greet = "<span class='sciradio'>You have learned the ancient martial art of the Sleeping Carp! Your hand-to-hand combat has become much more effective, and you are now able to deflect any projectiles \
	directed toward you while in Throw Mode. Your body is also honed to protect you from damage and punctures, and even briefly survive space. \
	However, you are also unable to use any ranged weaponry, and some medical supplies will prove useless to you. You can learn more about your newfound art by using the Recall Teachings verb in the Sleeping Carp tab.</span>"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	remarks = list("Wait, a high protein diet is really all it takes to become bulletproof...?", "Overwhelming force, immovable object...", "Focus... And you'll be able to incapacitate any foe in seconds...", "I must pierce armor for maximum damage...", "I don't think this would combine with other martial arts...", "Become one with the carp...", "Glub...")

/obj/item/book/granter/martial/carp/onlearned(mob/living/carbon/user)
	..()
	if(oneuse == TRUE)
		desc = "It's completely blank."
		name = "empty scroll"
		icon_state = "blankscroll"

/obj/item/book/granter/martial/bass
	martial = /datum/martial_art/the_rising_bass
	name = "shifting scroll"
	martialname = "rising bass"
	desc = "A paper scroll that seems to move even as you read it, the letters never seem to stay still."
	greet = "<span class='sciradio'>You have learned the ancient martial art of the Rising Bass. Your skill at running away has increased quite a bit. Use the combos to get away from opponents quickly. Along with this, you now dodge all projectiles and catch anything thrown at you.</span>"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	remarks = list("The trick is to disarm them...","Running away helps in many situations...","Never stay still...","Fighting won't help unless you're forced to...", "Crush their limbs to incapacitate them...", "Stay as far away as possible...")

/obj/item/book/granter/martial/bass/onlearned(mob/living/carbon/user)
	..()
	if(oneuse == TRUE)
		desc = "It's completely blank."
		name = "empty scroll"
		icon_state = "blankscroll"

/obj/item/book/granter/martial/berserker
	martial = /datum/martial_art/berserker
	name = "berserker's rites"
	martialname = "berserkers rites"
	desc = "A paper scroll detailing the sacred rites of the berserker. It is against the law of the Legion for any not walking the path of the berserker to read this."
	greet = "<span class='sciradio'>You have mastered the rites of the berserker. Use the help verb to see your combos.</span>"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	remarks = list("Rip and tear...", "Overwhelming force, immovable object...", "Focus... And you'll be able to incapacitate any foe in seconds...", "I must pierce armor for maximum damage...", "You are huge, that means you have huge guts...")

/obj/item/book/granter/martial/berserker/onlearned(mob/living/carbon/user)
	..()
	if(oneuse == TRUE)
		desc = "It's completely blank."
		name = "empty scroll"
		icon_state = "blankscroll"

/obj/item/book/granter/martial/plasma_fist
	martial = /datum/martial_art/plasma_fist
	name = "frayed scroll"
	martialname = "plasma fist"
	desc = "An aged and frayed scrap of paper written in shifting runes. There are hand-drawn illustrations of pugilism."
	greet = "<span class='boldannounce'>You have learned the ancient martial art of Plasma Fist. Your combos are extremely hard to pull off, but include some of the most deadly moves ever seen including \
	the plasma fist, which when pulled off will make someone violently explode.</span>"
	icon = 'icons/obj/wizard.dmi'
	icon_state ="scroll2"
	remarks = list("Balance...", "Power...", "Control...", "Mastery...", "Vigilance...", "Skill...")

/obj/item/book/granter/martial/plasma_fist/onlearned(mob/living/carbon/user)
	..()
	if(oneuse == TRUE)
		desc = "It's completely blank."
		name = "empty scroll"
		icon_state = "blankscroll"

/obj/item/book/granter/martial/krav_maga
	martial = /datum/martial_art/krav_maga
	name = "parchment scroll"
	martialname = "krav maga"
	desc = "A worn parchment scrap written in an ancient language. Somehow you can still understand the lessons!"
	greet = "<span class='sciradio'>You have learned the ancient martial art of Krav Maga. You have special attacks with which to take down your foes.</span>"
	icon = 'icons/obj/wizard.dmi'
	icon_state ="scroll2"
	remarks = list("Sweep the legs...", "Chop the throat...", "Punch the lungs...", "Get the gold...", "Where are my sick gloves..?")

/obj/item/book/granter/martial/krav_maga/onlearned(mob/living/carbon/user)
	. = ..()
	if(oneuse == TRUE)
		desc = "It's completely blank."
		name = "empty scroll"
		icon_state = "blankscroll"

// I did not include mushpunch's grant, it is not a book and the item does it just fine.


//Crafting Recipe books

/obj/item/book/granter/crafting_recipe
	var/list/crafting_recipe_types = list() //Use full /datum/crafting_recipe/what_you_craft

/obj/item/book/granter/crafting_recipe/on_reading_finished(mob/user)
	. = ..()
	if(!user.mind)
		return
	for(var/crafting_recipe_type in crafting_recipe_types)
		var/datum/crafting_recipe/R = crafting_recipe_type
		user.mind.teach_crafting_recipe(crafting_recipe_type)
		to_chat(user,"<span class='notice'>You learned how to make [initial(R.name)].</span>")
	onlearned(user)

/obj/item/book/granter/crafting_recipe/onlearned(mob/living/user)
	..()
	if(oneuse)
		user.visible_message(
		message = "<span class='notice'>Just as [user] finishes reading [p_their(user)] copy of [src], the ancient document crumbles to dust!</span>",
		self_message = "<span class='caution'>The ancient copy of [src] crumbles to dust as you finish reading it.</span>",
		blind_message = "<span class='notice'>You hear something crumble.</span>")
		qdel(src)


/obj/item/book/granter/crafting_recipe/threads //Durathread crafting book
	name = "Credible Threads"
	desc = "A simple book about sewing and usefull clothing crafting with cloth and durathreads."
//	crafting_recipe_types = list(/datum/crafting_recipe/durathread_duffelbag, /datum/crafting_recipe/durathread_toolbelt, /datum/crafting_recipe/durathread_bandolier, /datum/crafting_recipe/durathread_helmet, /datum/crafting_recipe/durathread_vest)
	icon_state = "tailers_art1"
	oneuse = FALSE
	remarks = list("Durathread is cloth thats also fire-resistant?", "Strong threads that can be used with leather for some light weight storage!", "The cloth can withstand a beating it said but not that much...")

/obj/item/book/granter/crafting_recipe/cooking_sweets_101 //We start at 101 for 103 and 105
	name = "Cooking Desserts 101"
	desc = "A cook book that teaches you about desserts."
	crafting_recipe_types = list(/datum/crafting_recipe/smg10mm)
	icon_state = "cooking_learing_sweets"
	oneuse = FALSE
	remarks = list("So that is how icing is made!", "Placing fruit on top? How simple...", "Huh layering cake seems harder then this...", "This book smells like candy", "A clown must have made this page, or they forgot to spell check it before printing...", "Wait, a way to cook slime to be safe?")

/obj/item/book/granter/crafting_recipe/coldcooking //Icecream
	name = "Cooking with Ice"
	desc = "A cook book that teaches you many old icecream treats."
	crafting_recipe_types = list(/datum/crafting_recipe/smg10mm)
	icon_state = "cooking_learing_ice"
	oneuse = FALSE
	remarks = list("Looks like these would sell much better in a plasma fire...", "Using glass bowls rather then cones?", "Mixing soda and ice-cream?", "Tall glasses with of liquids and solids...", "Just add a bit of icecream and cherry on top?")

/obj/item/book/granter/crafting_recipe/bone_bow //Bow crafting for non-ashwalkers
	name = "bowyery sandstone slab" // this is an actual word
	desc = "A sandstone slab with inscriptions describing the Ash Walkers of Lavaland's bowyery."
//	crafting_recipe_types = list(/datum/crafting_recipe/bone_arrow, /datum/crafting_recipe/bone_bow, /datum/crafting_recipe/ashen_arrow, /datum/crafting_recipe/quiver, /datum/crafting_recipe/bow_tablet)
	icon_state = "stone_tablet"
	oneuse = FALSE
	remarks = list("Sticking burning arrows into the sand makes them stronger...", "Breaking the bone apart to get shards, not sharpening the bone...", "Sinew is just like rope...")

/obj/item/book/granter/crafting_recipe/under_the_oven //Illegal cook book
	name = "Under The Oven"
	desc = "A cook book that teaches you many illegal and fun candys. MALF AI approved, and a best seller on the blackmarket."
	crafting_recipe_types = list()
	icon_state = "cooking_learing_illegal"
	oneuse = FALSE
	remarks = list()

/obj/item/book/granter/crafting_recipe/gunsmith_one
	name = "Guns and Bullets, Part 1"
	desc = "A rare issue of Guns and Bullets detailing the basic manufacture of firearms, allowing the reader to craft firearms. It's barely holding up, and looks like only one person can study the knowledge from it."
	icon_state = "gab1"
	oneuse = TRUE
	remarks = list("Always keep your gun well lubricated...", "Keep your barrel free of grime...", "Perfect fitment is the key to a good firearm...", "Maintain a proper trigger pull length...", "Keep your sights zeroed to proper range...")
	crafting_recipe_types = list(/datum/crafting_recipe/ninemil, /datum/crafting_recipe/huntingrifle)

/obj/item/book/granter/crafting_recipe/gunsmith_two
	name = "Guns and Bullets, Part 2"
	desc = "A rare issue of Guns and Bullets following up Part 1, going further indepth into weapon mechanics, allowing the reader to craft certain firearms. It's barely holding up, and looks like only one person can study the knowledge from it."
	icon_state = "gab2"
	oneuse = TRUE
	remarks = list("Always keep your gun well lubricated...", "Keep your barrel free of grime...", "Perfect fitment is the key to a good firearm...", "Maintain a proper trigger pull length...", "Keep your sights zeroed to proper range...")
	crafting_recipe_types = list(/datum/crafting_recipe/n99, /datum/crafting_recipe/huntingrifle, /datum/crafting_recipe/m1911, /datum/crafting_recipe/varmintrifle)

/obj/item/book/granter/crafting_recipe/gunsmith_three
	name = "Guns and Bullets, Part 3"
	desc = "A rare issue of Guns and Bullets following up Part 2, explaining difficult ballistics theory and weapon mechanics, allowing the reader to craft weapon attachments. It's barely holding up, and looks like only one person can study the knowledge from it."
	icon_state = "gab3"
	oneuse = TRUE
	remarks = list("Always keep your gun well lubricated...", "Keep your barrel free of grime...", "Perfect fitment is the key to a good firearm...", "Maintain a proper trigger pull length...", "Keep your sights zeroed to proper range...")
	crafting_recipe_types = list(/datum/crafting_recipe/scope, /datum/crafting_recipe/suppressor, /datum/crafting_recipe/burst_improvement, /datum/crafting_recipe/recoil_decrease)

/obj/item/book/granter/crafting_recipe/gunsmith_four
	name = "Guns and Bullets, Part 4"
	desc = "An extremely rare issue of Guns and Bullets, showing some design flaws of weapons and how to rectify them. It's barely holding up, and looks like only one person can study the knowledge from it."
	icon_state = "gab4"
	oneuse = TRUE
	remarks = list("Always keep your gun well lubricated...", "Keep your barrel free of grime...", "Perfect fitment is the key to a good firearm...", "Maintain a proper trigger pull length...", "Keep your sights zeroed to proper range...")
	crafting_recipe_types = list(/datum/crafting_recipe/flux, /datum/crafting_recipe/lenses, /datum/crafting_recipe/conductors, /datum/crafting_recipe/receiver, /datum/crafting_recipe/assembly, /datum/crafting_recipe/alloys)

/obj/item/book/granter/crafting_recipe/scav_one
	name = "SCAV! Issue 1"
	desc = "A popular post-war comic series detailing the trials and tribulations of scavengers and their tools."
	oneuse = TRUE
	remarks = list("And it was here that I stabbed a man over a desk fan...", "The paint was chipping, but that didn't matter when he lay dead...", "A tank here, a pipe there...", "A bit of duct tape wrapped around everything...", "My flamethrower spat fire! Wait, where are my eyebrows...")
	crafting_recipe_types = list(/datum/crafting_recipe/chainsaw, /datum/crafting_recipe/tools/forged/entrenching_tool, /datum/crafting_recipe/durathread_vest, /datum/crafting_recipe/steeltower)

/obj/item/book/granter/crafting_recipe/scav_two
	name = "SCAV! Issue 2"
	desc = "A popular post-war comic series detailing the trials and tribulations of scavengers and their tools."
	oneuse = TRUE
	remarks = list("And it was here that I stabbed a man over a desk fan...", "The paint was chipping, but that didn't matter when he lay dead...", "A tank here, a pipe there...", "A bit of duct tape wrapped around everything...", "My flamethrower spat fire! Wait, where are my eyebrows...")
	crafting_recipe_types = list(/datum/crafting_recipe/steelsaw)

/obj/item/book/granter/crafting_recipe/scav_three
	name = "SCAV! Issue 3"
	desc = "A popular post-war comic series detailing the trials and tribulations of scavengers and their tools."
	oneuse = TRUE
	remarks = list("And it was here that I stabbed a man over a desk fan...", "The paint was chipping, but that didn't matter when he lay dead...", "A tank here, a pipe there...", "A bit of duct tape wrapped around everything...", "My flamethrower spat fire! Wait, where are my eyebrows...")
	crafting_recipe_types = list(/datum/crafting_recipe/autoaxe)

// New Blueprints, yay! -Superballs
/obj/item/book/granter/crafting_recipe/blueprint
	name = "blueprint"
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "blueprint_empty"
	desc = "A detailed schematic for crafting an item."
	w_class = WEIGHT_CLASS_TINY
	oneuse = TRUE
	remarks = list()

/obj/item/book/granter/crafting_recipe/blueprint/r82
	name = "r82 heavy service rifle blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/R82)

/obj/item/book/granter/crafting_recipe/blueprint/marksman
	name = "marksman carbine blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/marksmancarbine)

/obj/item/book/granter/crafting_recipe/blueprint/combatrifle
	name = "combat rifle blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/combatrifle)

/obj/item/book/granter/crafting_recipe/blueprint/r84
	name = "r84 lmg blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/lmg)

/obj/item/book/granter/crafting_recipe/blueprint/service
	name = "service rifle blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/servicerifle)

/obj/item/book/granter/crafting_recipe/blueprint/aep7
	name = "aep7 blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/AEP7)

/obj/item/book/granter/crafting_recipe/blueprint/leveraction
	name = "lever action shotgun blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/lever_action)

/obj/item/book/granter/crafting_recipe/blueprint/trailcarbine
	name = "trail carbine blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/trail_carbine)

/obj/item/book/granter/crafting_recipe/blueprint/thatgun
	name = ".223 pistol blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/thatgun)

/obj/item/book/granter/crafting_recipe/blueprint/plasmapistol
	name = "plasma pistol blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/plasmapistol)

/obj/item/book/granter/crafting_recipe/blueprint/lightplasmapistol
	name = "light plasma pistol blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/lightplasmapistol)

/obj/item/book/granter/crafting_recipe/blueprint/uzi
	name = "mini uzi blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/uzi)

/obj/item/book/granter/crafting_recipe/blueprint/smg10mm
	name = "10mm smg blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/smg10mm)

/obj/item/book/granter/crafting_recipe/blueprint/greasegun
	name = "m3a1 grease gun blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/grease_gun)

/obj/item/book/granter/crafting_recipe/blueprint/brushgun
	name = "brush gun blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/brush)

/obj/item/book/granter/crafting_recipe/blueprint/r91
	name = "r91 assault rifle blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/r91)

/obj/item/book/granter/crafting_recipe/blueprint/riotshotgun
	name = "riot shotgun blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/riotshotgun)

/obj/item/book/granter/crafting_recipe/blueprint/sniper
	name = "sniper rifle blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/sniper)

/obj/item/book/granter/crafting_recipe/blueprint/deagle
	name = "desert eagle blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/deagle)

/obj/item/book/granter/crafting_recipe/blueprint/aer9
	name = "aer9 blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/AER9)

/obj/item/book/granter/crafting_recipe/blueprint/plasmarifle
	name = "plasma rifle blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/plasmarifle)

/obj/item/book/granter/crafting_recipe/blueprint/tribeam
	name = "tribeam laser rifle blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/tribeam)

/obj/item/book/granter/crafting_recipe/blueprint/am_rifle
	name = "anti-materiel rifle blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/am_rifle)

/obj/item/book/granter/crafting_recipe/blueprint/citykiller
	name = "citykiller blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/city_killer)

/obj/item/book/granter/crafting_recipe/blueprint/rangemaster
	name = "colt rangemaster blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/rangemaster)

/obj/item/book/granter/crafting_recipe/blueprint/bozar
	name = "bozar blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/bozar)

/obj/item/book/granter/crafting_recipe/blueprint/m1garand
	name = "battle rifle blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/m1garand)

/obj/item/book/granter/crafting_recipe/blueprint/infiltrator
	name = "infiltrator blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/infiltrator)

/obj/item/book/granter/crafting_recipe/blueprint/lsw
	name = "lsw blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/gun/lsw)

/obj/item/book/granter/crafting_recipe/blueprint/m1carbine
	name = "m1 carbine blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/m1carbine)

/obj/item/book/granter/crafting_recipe/blueprint/pps
	name = "ppsh-41 blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/pps)

/obj/item/book/granter/crafting_recipe/blueprint/commando
	name = "commando carbine blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/commando)

/obj/item/book/granter/crafting_recipe/blueprint/trapper
	name = "guide to minelaying"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/explosive/shrapnelmine, /datum/crafting_recipe/explosive/explomine, /datum/crafting_recipe/explosive/stingmine, /datum/crafting_recipe/explosive/pulsemine, /datum/crafting_recipe/explosive/stunmine)

/*
/obj/item/book/granter/crafting_recipe/blueprint/fnfal
	name = "fn fal blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/fnfal)

/obj/item/book/granter/crafting_recipe/blueprint/caws
	name = "h&k caws blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/caws)
*/

/obj/item/book/granter/crafting_recipe/blueprint/scoutcarbine
	name = "scout carbine blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/scoutcarbine)

/obj/item/book/granter/crafting_recipe/blueprint/neostead
	name = "neostead 2000 blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/neostead)

/obj/item/book/granter/crafting_recipe/blueprint/gauss
	name = "gauss rifle blueprint"
	icon_state = "blueprint2"
	crafting_recipe_types = list(/datum/crafting_recipe/gaussrifle)

/obj/item/book/granter/crafting_recipe/manual/denvr
	name = "den vr configuration"
	icon_state = "book"
	remarks = list("Never make dreams...", "Don't pick from an empty list...", "Runtimes are not good for cardio...", "Report an issue to a nearby technician, and expect to be told to post it to their terminal...", "Probably don't adjust the default safety settings.", "Clean up any messes left in the pod before the next use.")
	crafting_recipe_types = list(/datum/crafting_recipe/set_vrboard/den)

/obj/item/book/granter/crafting_recipe/ODF
	name = "Weapons of Yuma and the Oasis Defense Force"
	desc = "a book detailing weapons used in the region and by the local town, it has lithiographed pictures of hand-drawn schematics for each weapon type"
	oneuse = TRUE
	crafting_recipe_types = list(/datum/crafting_recipe/policepistol, /datum/crafting_recipe/durathread_vest, /datum/crafting_recipe/policerifle, /datum/crafting_recipe/steelbib/heavy, /datum/crafting_recipe/armyhelmetheavy, /datum/crafting_recipe/huntingshotgun)
	remarks = list("Looks like Oasis hand-crafts replicas from a pre-war police armory", "Some of these weapons are more than 200 years old....", "Duct tape really can hold it together!", "So that is how you laminate armor sheets together", "Looks like you can beat metal into just the right shape to replace the bits")


/obj/item/book/granter/trait/tagger
	name = "Picket Fences"
	desc = "A guide to home decor! The American Dream might be dead and the white picket fences might be caked in rads, but at least you can read about it!"
	oneuse = TRUE
	granted_trait = TRAIT_TAGGER
	traitname = "tagger"
	remarks = list("Just two tins of paint is enough for your whole house!", "Move your sofa to the left three paces, and you've discovered Feng Shui! Please report to the nearest police station.", "Your neighbours got a new BBQ and is hosting one at the weekend! Here's what you do...")

/obj/item/book/granter/trait/chemistry
	name = "Big Book of Science"
	desc = "This heavy textbook can teach basic chemistry, but saw more use as a blunt weapon shortly after the Collapse."
	oneuse = TRUE
	granted_trait = TRAIT_CHEMWHIZ
	traitname = "chemistry"
	remarks = list("Always ensure a safe working environment, promptly clean any chemical mess.", "Improperly stored chemicals can quickly lead to safety hazards.", "Do not abuse chemicals for recreational use in the laboratory!", "Labcoats and goggles not only protect you from burns, but give an aura of authority.", "Keep your laboratory clean and organized, utilize cabinets and shelves.", "Potassium and water should not be mixed, or they will react violently.")
	crafting_recipe_types = list(
		/datum/crafting_recipe/jet, 
		/datum/crafting_recipe/turbo, 
		/datum/crafting_recipe/psycho, 
		/datum/crafting_recipe/medx, 
		/datum/crafting_recipe/stimpak, 
		/datum/crafting_recipe/stimpak5, 
		/datum/crafting_recipe/superstimpak, 
		/datum/crafting_recipe/superstimpak5, 
		/datum/crafting_recipe/buffout)

/obj/item/book/granter/trait/bigleagues
	name = "Grognak the Barbarian"
	desc = "A pulp fiction paperback detailing the adventures of a violent barbarian. Surprisingly, this was sold to children."
	oneuse = TRUE
	granted_trait = TRAIT_BIG_LEAGUES
	traitname = "hitting things"
	remarks = list("Grognak hit the Death Knight only once, but that was enough.", "Grognak is surprisingly agile, never committing too heavily on an attack, dancing between his enemies.", "Grognak isn't good at talking, but he knows it has its place. He has friends to talk for him.", "Other barbarians might change their weapons, but Grognak could never leave his beloved axe.")

/obj/item/book/granter/trait/lowsurgery
	name = "First Aid Pamphlet"
	desc = "A flimsy collection of vital tips and tricks for the average American with a sudden injury."
	oneuse = TRUE
	granted_trait = TRAIT_SURGERY_LOW
	traitname = "minor surgery"
	remarks = list("Keep your hands and any injuries clean!", "While bandages help to seal a wound, they do not heal a wound.", "Remain calm, focus on the task at hand, stop the bleeding.", "An open wound can lead to easy infection of said wound.", "Keep track of your home's first aid kit, restock used components regularly.", "If a body part has been lost, ice and transport it with the injured to a hospital.",)

/obj/item/book/granter/trait/lowsurgery/already_known(mob/user)
	if(HAS_TRAIT(user, TRAIT_SURGERY_MID) || HAS_TRAIT(user, TRAIT_SURGERY_HIGH))
		to_chat(user, "<span class ='notice'>This book is too basic for you!")
		return TRUE
	return ..()

/obj/item/book/granter/trait/midsurgery
	name = "D.C. Journal of Internal Medicine"
	desc = "A nearly intact guide on surgery for pre-collapse medical students and physicians."
	oneuse = TRUE
	granted_trait = TRAIT_SURGERY_MID
	traitname = "intermediate surgery"
	remarks = list("Sterilization is essential before and after surgery.", "Keep track of all your tools, double check body cavities.", "Ensure complete focus while operating on the patient.", "Cauterize incisions once the operation concludes.", "Spare organs and blood must be kept at a low temperature.", "Most prosthesis come with significant trade-offs, and maintenance costs.",)

/obj/item/book/granter/trait/midsurgery/already_known(mob/user)
	if(HAS_TRAIT(user, TRAIT_SURGERY_HIGH))
		to_chat(user, "<span class ='notice'>This book is too basic for you!")
		return TRUE
	return ..()

/obj/item/book/granter/trait/techno
	name = "Dean's Electronics"
	desc = "A study book on the field of electronics. A note on the cover says that it is for the budding young electrician in everyone!"
	oneuse = TRUE
	granted_trait = TRAIT_TECHNOPHREAK
	traitname = "craftsmanship"
	crafting_recipe_types = list(/datum/crafting_recipe/tribalradio, /datum/crafting_recipe/durathread_vest)
	remarks = list("Troubleshooting is a systematic approach to problem solving, do not skip any steps in the process.", "Ensure you have all the required parts before you begin.", "Always wear personal protective equipment, electric shock can be fatal.", "Combustibles and sparks do not mix, store welding fuel in a safe location.", "Don't lose track of your tools, or you have a new problem to deal with.")

/obj/item/book/granter/trait/wirevision
	name = "Popular Electronics"
	desc = "An issue of Popular Electronics, dated January 1975. This one has a wiring guide for the Altair 8800 computer, and a few other projects to boot!"
	oneuse = TRUE
	granted_trait = TRAIT_WIREVISION
	traitname = "wirevision"
	remarks = list("Troubleshooting is a systematic approach to problem solving, do not skip any steps in the process.", "Ensure you have all the required parts before you begin.", "Don't lose track of your tools, or you have a new problem to deal with.", "Make sure you check the colouring of wires extremely carefully- you don't want to be mixing up yellow and lime, or purple and indigo!")



/obj/item/book/granter/trait/pa_wear
	name = "US Army: Mechanized Infantry Handbook"
	desc = "A battered olive-green handbook, detailing lessons to ancient mechanized US Army infantry units."
	oneuse = TRUE
	granted_trait = TRAIT_PA_WEAR
	traitname = "Power Armor"
	remarks = list("Daily maintenance is essential, clean and repair your suit often.", "Don't let overconfidence kill you, you are not invincible.", "Mechanized infantry should always be supported by regular infantry.", "You move slowly, pay attention to your position relative to the enemy.", "You are always vulnerable to ambush, do not rest in the field.", "AP rounds will shred your suit, you are not invincible.")

/obj/item/book/granter/trait/trekking
	name = "Wasteland Survival Guide"
	desc = "This indispensable guidebook contains everything that a survivor in the wasteland would need to know."
	oneuse = TRUE
	granted_trait = TRAIT_HARD_YARDS
	traitname = "trekking"
	remarks = list("Tribes and gangs often hide the best loot in the back room.", "Radiation is best avoided entirely, but it helps to carry spare rad-x.", "Whether ancient or recent, landmines are still a threat, and readers should look out for them.", "Injuries and open bleeding make it harder to travel, always carry spare medical supplies.", "Most animals are simple-minded, and can be led into easy lines of fire.")

/obj/item/book/granter/trait/explosives
	name = "Industrial Society and Its Future"
	desc = "This lengthy manifesto happens to contain a variety of valuable knowledge on how to craft explosives of all kinds."
	oneuse = TRUE
	granted_trait = TRAIT_EXPLOSIVE_CRAFTING
	traitname = "explosive crafting"
	remarks = list("If you want to get started making bombs, you're going to need a lot of igniters and black powder.", "Did a Follower write this book, or something?", "All thermite takes is some aluminum and iron.", "Coconut shells make acceptable grenade casings in a pinch.")
	crafting_recipe_types = list(/datum/crafting_recipe/frag_shrapnel, /datum/crafting_recipe/stinger, /datum/crafting_recipe/flashbang,
/datum/crafting_recipe/smokebomb, /datum/crafting_recipe/rocket_base, /datum/crafting_recipe/weakrocket)

/obj/item/book/granter/trait/explosives_advanced
	name = "Advanced Techniques for Winning at Postal Chess"
	desc = "Author: Ted Kaczynski."
	oneuse = TRUE
	granted_trait = TRAIT_ADVANCED_EXPLOSIVE_CRAFTING
	traitname = "advanced explosive crafting"
	remarks = list("Is this actually a legal chess move...?", "If you hook electronic parts up to a flux capacitor-oh, that makes a lot of sense, actually.", "Radium? What would you use radium f-oh no.", "Why would anyone actually publish this?")
	crafting_recipe_types = list(/datum/crafting_recipe/incendiary, /datum/crafting_recipe/concussion, /datum/crafting_recipe/radgrenade, /datum/crafting_recipe/empgrenade, /datum/crafting_recipe/incendiaryrocket, /datum/crafting_recipe/strongrocket, /datum/crafting_recipe/frag_shrapnel, /datum/crafting_recipe/stinger, /datum/crafting_recipe/flashbang,
/datum/crafting_recipe/smokebomb, /datum/crafting_recipe/rocket_base, /datum/crafting_recipe/weakrocket)

/obj/item/book/granter/trait/gunslinger
	name = "Tycho: Life of a Lawman"
	desc = "The memoirs of a self-acclaimed companion to a mythical folk hero, between the blustering and tales of Texas Rangers there are snippets of useful information."
	oneuse = TRUE
	granted_trait = TRAIT_NICE_SHOT
	traitname = "gunslinging"
	remarks = list("Engravings offer no tactical advantage whatsoever!", "I love to reload during battle.", "There's nothing like the feeling of slamming a long silver bullet into a well greased chamber.", "It doesn't feel right to shoot an unarmed man, but you get over it.", "He was pretty good, but I was better. At least, so I thought.", "The moment any truth is passed on, it starts turning into fiction. The problem is, fiction inspires people more than facts.")

/obj/item/book/granter/trait/iron_fist
	name = "Brawler's Guide to Fisticuffs"
	desc = "An advanced manual on fistfighting. It has pictures, too!"
	oneuse = TRUE
	granted_trait = TRAIT_IRONFIST
	traitname = "punching"
	remarks = list("Keep your fists up...", "Don't clench your thumb in your fist, or you might break it...", "Turn into your punch, and put your body weight behind it...", "Footwork is everything, make sure to step into your punches...", "Aim for their jaw for an easy K-O...")

/obj/item/book/granter/trait/medical
	name = "Medical Booklet"
	desc = "An instruction manual on basic medicine!"
	granted_trait = null
	pages_to_mastery = 0
	time_per_page = 0

/obj/item/book/granter/trait/medical/attack_self(mob/user)
	var/list/choices = list("Big Book of Science","First Aid Pamphlet")
	if(granted_trait == null)
		var/choice = input("Choose a trait:") in choices
		switch(choice)
			if(null)
				return 0
			if("First Aid Pamphlet")
				granted_trait = TRAIT_SURGERY_LOW
				traitname = "minor surgery"
				remarks = list("Keep your hands and any injuries clean!", "While bandages help to seal a wound, they do not heal a wound.", "Remain calm, focus on the task at hand, stop the bleeding.", "An open wound can lead to easy infection of said wound.", "Keep track of your home's first aid kit, restock used components regularly.", "If a body part has been lost, ice and transport it with the injured to a hospital.",)
			if("Big Book of Science")
				granted_trait = TRAIT_CHEMWHIZ
				traitname = "chemistry"
				crafting_recipe_types = list(/datum/crafting_recipe/jet, /datum/crafting_recipe/turbo, /datum/crafting_recipe/psycho, /datum/crafting_recipe/medx, /datum/crafting_recipe/buffout)
				remarks = list("Always ensure a safe working environment, promptly clean any chemical mess.", "Improperly stored chemicals can quickly lead to safety hazards.", "Do not abuse chemicals for recreational use in the laboratory!", "Labcoats and goggles not only protect you from burns, but give an aura of authority.", "Keep your laboratory clean and organized, utilize cabinets and shelves.", "Potassium and water should not be mixed, or they will react violently.")
	return ..()


/obj/item/book/granter/trait/medical/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)


/obj/item/book/granter/trait/selection
	name = "Burned Book"
	desc = "Pulled from the ashes of the old world, it feels warm to the touch. It looks to be in poor condition."
	granted_trait = null
	pages_to_mastery = 0
	time_per_page = 0

/obj/item/book/granter/trait/selection/attack_self(mob/user)
	var/list/choices = list("Big Book of Science","Dean's Electronics","Grognak the Barbarian","First Aid Pamphlet","Wasteland Survival Guide")
	if(granted_trait == null)
		var/choice = input("Choose a trait:") in choices
		switch(choice)
			if(null)
				return 0
			if("Wasteland Survival Guide")
				granted_trait = TRAIT_HARD_YARDS
				traitname = "trekking"
				remarks = list("Tribes and gangs often hide the best loot in the back room.", "Radiation is best avoided entirely, but it helps to carry spare rad-x.", "Whether ancient or recent, landmines are still a threat, and readers should look out for them. Their detonators can be removed with a screwdriver.", "Injuries and open bleeding make it harder to travel, always carry spare medical supplies.", "Most animals are simple-minded, and can be led into easy lines of fire.")
			if("First Aid Pamphlet")
				granted_trait = TRAIT_SURGERY_LOW
				traitname = "minor surgery"
				remarks = list("Keep your hands and any injuries clean!", "While bandages help to seal a wound, they do not heal a wound.", "Remain calm, focus on the task at hand, stop the bleeding.", "An open wound can lead to easy infection of said wound.", "Keep track of your home's first aid kit, restock used components regularly.", "If a body part has been lost, ice and transport it with the injured to a hospital.",)
			if("Big Book of Science")
				granted_trait = TRAIT_CHEMWHIZ
				traitname = "chemistry"
				crafting_recipe_types = list(/datum/crafting_recipe/jet, /datum/crafting_recipe/turbo, /datum/crafting_recipe/psycho, /datum/crafting_recipe/medx, /datum/crafting_recipe/buffout)
				remarks = list("Always ensure a safe working environment, promptly clean any chemical mess.", "Improperly stored chemicals can quickly lead to safety hazards.", "Do not abuse chemicals for recreational use in the laboratory!", "Labcoats and goggles not only protect you from burns, but give an aura of authority.", "Keep your laboratory clean and organized, utilize cabinets and shelves.", "Potassium and water should not be mixed, or they will react violently.")
			if("Dean's Electronics")
				granted_trait = TRAIT_TECHNOPHREAK
				traitname = "craftsmanship"
				crafting_recipe_types = list(/datum/crafting_recipe/tribalradio)
				remarks = list("Troubleshooting is a systematic approach to problem solving, do not skip any steps in the process.", "Ensure you have all the required parts before you begin.", "Always wear personal protective equipment, electric shock can be fatal.", "Combustibles and sparks do not mix, store welding fuel in a safe location.", "Don't lose track of your tools, or you have a new problem to deal with.")
			if("Grognak the Barbarian")
				granted_trait = TRAIT_BIG_LEAGUES
				traitname = "hitting things"
				remarks = list("Grognak hit the Death Knight only once, but that was enough.", "Grognak is surprisingly agile, never committing too heavily on an attack, dancing between his enemies.", "Grognak isn't good at talking, but he knows it has its place. He has friends to talk for him.", "Other barbarians might change their weapons, but Grognak could never leave his beloved axe.")

	if(HAS_TRAIT(user, granted_trait))
		to_chat(user, "<span class ='notice'>You already have all the insight you need about [traitname].")
		granted_trait == null
		return FALSE

	return ..()


/obj/item/book/granter/trait/selection/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

//TRIBAL BOOKS

/obj/item/book/granter/trait/selection/tribal
		name = "Book of Ancient Knowledge"
		desc = "A compendium of knowledge passed down from the elders. It looks to be in poor condition."

/obj/item/book/granter/trait/selection/tribal/attack_self(mob/user)
	var/list/choices = list("Hit Them With Sticks","Technophilia","Pugilist","Padded Feet","Veteran Table Climber","Basic Surgery")
	if(granted_trait == null)
		var/choice = input("Choose a trait:") in choices
		switch(choice)
			if(null)
				return 0
			if("Hit Them With Sticks")
				granted_trait = TRAIT_BIG_LEAGUES
				traitname = "fighting with melee weapons"
			if("Technophilia")
				granted_trait = TRAIT_TECHNOPHREAK
				traitname = "technology and crafting"
				crafting_recipe_types = list(/datum/crafting_recipe/ninemil, /datum/crafting_recipe/huntingrifle, /datum/crafting_recipe/n99, /datum/crafting_recipe/huntingrifle, /datum/crafting_recipe/m1911, /datum/crafting_recipe/varmintrifle, /datum/crafting_recipe/autoaxe, /datum/crafting_recipe/steelsaw, /datum/crafting_recipe/tools/forged/entrenching_tool, /datum/crafting_recipe/chainsaw, /datum/crafting_recipe/steeltower, /datum/crafting_recipe/durathread_vest)
			if("Pugilist")
				granted_trait = TRAIT_IRONFIST
				traitname = "using your fists"
			if("Padded Feet")
				granted_trait = TRAIT_LIGHT_STEP
				traitname = "treading carefully"
			if("Veteran Table Climber")
				granted_trait = TRAIT_FREERUNNING
				traitname = "....climbing tables"
			if("Basic Surgery")
				granted_trait = TRAIT_SURGERY_LOW
				traitname = "basic surgery"
			if("Desert Affinity")
				granted_trait = TRAIT_HARD_YARDS
				traitname = "trekking"

	if(HAS_TRAIT(user, granted_trait))
		to_chat(user, "<span class ='notice'>You already have all the insight you need about [traitname].")
		granted_trait == null
		return FALSE

	return ..()

/obj/item/book/granter/trait/selection/tribal/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

/obj/item/book/granter/crafting_recipe/tribal
	name = "Tribal traditions"
	desc = "A book of traditions passed down through generations within the tribe."
	crafting_recipe_types = list(
		/datum/crafting_recipe/tribalwar/lighttribe, 
		/datum/crafting_recipe/tribalwar/heavytribe, 
		/datum/crafting_recipe/healpoultice, 
		/datum/crafting_recipe/healpoultice5, 
		/datum/crafting_recipe/warmace)

/obj/item/book/granter/crafting_recipe/tribal/whitelegs
	name = "White Legs traditions"
	crafting_recipe_types = list(/datum/crafting_recipe/tribalwar/whitelegs/lightarmour, /datum/crafting_recipe/tribalwar/whitelegs/armour, /datum/crafting_recipe/tribalwar/whitelegs/garb,
								/datum/crafting_recipe/tribalwar/whitelegs/femalegarb, /datum/crafting_recipe/tribalwar/whitelegs/heavyarmour)

/obj/item/book/granter/crafting_recipe/tribal/deadhorses
	name = "Dead Horses traditions"
	crafting_recipe_types = list(/datum/crafting_recipe/tribalwar/deadhorses/lightarmour, /datum/crafting_recipe/tribalwar/deadhorses/armour, /datum/crafting_recipe/tribalwar/deadhorses/garb,
								/datum/crafting_recipe/tribalwar/deadhorses/femalegarb, /datum/crafting_recipe/tribalwar/deadhorses/heavyarmour)

/obj/item/book/granter/crafting_recipe/tribal/rustwalkers
	name = "Rustwalkers traditions"
	crafting_recipe_types = list(/datum/crafting_recipe/tribalwar/rustwalkers/lightarmour, /datum/crafting_recipe/tribalwar/rustwalkers/armour, /datum/crafting_recipe/tribalwar/rustwalkers/garb,
								/datum/crafting_recipe/tribalwar/rustwalkers/femalegarb, /datum/crafting_recipe/tribalwar/rustwalkers/heavyarmour)

/obj/item/book/granter/crafting_recipe/tribal/eighties
	name = "Eighties traditions"
	crafting_recipe_types = list(/datum/crafting_recipe/tribalwar/eighties/lightarmour, /datum/crafting_recipe/tribalwar/eighties/armour, /datum/crafting_recipe/tribalwar/eighties/garb,
								/datum/crafting_recipe/tribalwar/eighties/femalegarb, /datum/crafting_recipe/tribalwar/eighties/heavyarmour)

/obj/item/book/granter/crafting_recipe/tribal/sorrows
	name = "Sorrows traditions"
	crafting_recipe_types = list(/datum/crafting_recipe/tribalwar/sorrows/armour, /datum/crafting_recipe/tribalwar/sorrows/garb, /datum/crafting_recipe/tribalwar/sorrows/femalegarb,
								/datum/crafting_recipe/tribalwar/sorrows/yaoguaigauntlet)

/obj/item/book/granter/crafting_recipe/tribal/wayfarer
	name = "Wayfarer traditions"
	crafting_recipe_types = list(/datum/crafting_recipe/tribalwar/lighttribe, /datum/crafting_recipe/tribalwar/heavytribe, /datum/crafting_recipe/warmace)

/obj/item/book/granter/crafting_recipe/tribal/bone
	name = "Bone Dancer traditions"
	crafting_recipe_types = list(/datum/crafting_recipe/tribalwar/bone/lightarmour,/datum/crafting_recipe/tribalwar/bone/armour, /datum/crafting_recipe/tribalwar/bone/heavyarmour,
								/datum/crafting_recipe/tribalwar/bone/garb,/datum/crafting_recipe/tribalwar/bone/helmet)
								
								
								
								
								
