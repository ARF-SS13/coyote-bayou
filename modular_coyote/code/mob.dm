/mob/living/carbon/human
	///This player has been standing still for very long and are probably roleplaying. They won't use up nutrition until they start moving again.
	var/insanelycomfy = FALSE

/mob/living/simple_animal/hostile/hellpig
	name = "hellpig"
	desc = "A mutated American boar, sporting razor sharp tucks and a nasty temper."
	icon = 'modular_coyote/icons/mob/hellpig.dmi'
	icon_state = "hellpig"
	icon_living = "hellpig"
	icon_dead = "hellpig_dead"
	maxHealth = 500
	health = 500
	melee_damage_lower = 20
	melee_damage_upper = 40
	footstep_type = FOOTSTEP_MOB_HEAVY
	wound_bonus = 5
	bare_wound_bonus = 25
	faction = list("yaoguai")
	emote_taunt_sound = list('sound/f13npc/deathclaw/taunt.ogg')
	emote_taunt_sound = list('sound/f13npc/deathclaw/aggro1.ogg', 'sound/f13npc/deathclaw/aggro2.ogg', )
	idlesound = list('sound/f13npc/deathclaw/idle.ogg',)
	death_sound = list('sound/f13npc/hellpig/hellpigdead.ogg',)
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 10, /obj/item/stack/sheet/bone = 6, /obj/item/reagent_containers/food/snacks/meat/rawbacon = 8)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/bone = 2,)
	butcher_difficulty = 1

/mob/living/simple_animal/hostile/hellpig/Initialize()
	. = ..()
	recenter_wide_sprite()

//Cat slugs

/mob/living/simple_animal/pet/catslug
	name = "catslug"
	desc = "A noodley bodied creature with thin arms and legs, and gloomy dark eyes."
	icon_state = "catslug"
	icon_living = "catslug"
	icon_dead = "catslug_dead"
	icon = 'modular_coyote/icons/mob/slugcat.dmi'
	rotate_on_lying = FALSE // plop~

	faction = list("catslug", "neutral")
	mob_armor = ARMOR_VALUE_MEDIUM
	maxHealth = 200
	health = 200
	healable = 1
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2)

	response_help_simple = "hugs"
	response_disarm_simple = "rudely paps"
	response_harm_simple = "punches"
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	harm_intent_damage = 2
	melee_damage_lower = 2
	melee_damage_upper = 5
	dextrous = TRUE
	dextrous_hud_type = /datum/hud/dextrous/drone
	held_items = list(null, null)
	see_in_dark = 8
	can_ghost_into = TRUE
	head_offset = -9

/mob/living/simple_animal/pet/catslug/proc/catslug_color()
	set name = "Pick Color"
	set category = "IC"
	set desc = "You can set your color!"
	var/newcolor = input(usr, "Choose a color.", "", color) as color|null
	if(newcolor)
		color = newcolor
	update_icon()

/mob/living/simple_animal/pet/catslug/Initialize()
	. = ..()
	verbs += /mob/living/simple_animal/pet/catslug/proc/catslug_color
	add_verb(src, /mob/living/proc/lay_down)

/mob/living/simple_animal/pet/catslug/update_mobility()
	. = ..()
	if(client && stat != DEAD)
		if(!CHECK_MOBILITY(src, MOBILITY_STAND))
			icon_state = "[icon_living]_rest"
			collar_type = "[initial(collar_type)]_rest"
		else
			icon_state = "[icon_living]"
			collar_type = "[initial(collar_type)]"
	regenerate_icons()
/* Slugcat helmet/hat sprites were a bit of a headache so we're not doing it right now : ^ ))))
/mob/living/simple_animal/pet/catslug/proc/apply_overlay(cache_index)
	if((. = overlays[cache_index]))
		add_overlay(.)

/mob/living/simple_animal/pet/catslug/proc/remove_overlay(cache_index)
	var/I = overlays[cache_index]
	if(I)
		cut_overlay(I)
		overlays[cache_index] = null

/mob/living/simple_animal/pet/catslug/update_inv_head()
	remove_overlay(DRONE_HEAD_LAYER)

	if(head)
		if(client && hud_used && hud_used.hud_shown)
			head.screen_loc = ui_drone_head
			client.screen += head
		var/mutable_appearance/head_overlay = head.build_worn_icon(default_layer = DRONE_HEAD_LAYER, default_icon_file = head.icon, override_state = head.icon_state)
		head_overlay.pixel_y += head_offset

		overlays[DRONE_HEAD_LAYER] = head_overlay

	apply_overlay(DRONE_HEAD_LAYER)
*/
//Slugcat OC for thingpony
/mob/living/simple_animal/pet/catslug/meadow
	name = "Meadow"
	desc = "A noodly creature with soft looking fur. This one has orange and black patches upon it's white fur! (OOC notes : Fine with most Rp! No snuff or scat) Ref: https://cdn.discordapp.com/attachments/986783005743923230/1071899061919166624/Meadow.png"
	icon_state = "calicoslug"
	icon_living = "calicoslug"
	icon_dead = "calicoslug_dead"
	gender = "female"

//Slugcat OC for Gamma
/mob/living/simple_animal/pet/catslug/sunrise
	name = "Falling Sunrise"
	desc = "This somewhat large Scug, standing at about 3'10, is mostly magenta, though his head is covered with a Vulture mask. He is frequently seen around town, or out doing light hunting in the wastes. He is capable of English speech. OOC : ERP Ok, Non-Con is a No, Unsanitary is a No"
	icon_state = "sunrise"
	icon_living = "sunrise"
	icon_dead = "sunrise_dead"
	gender = "male"

//Slugcat OC for Puff
/mob/living/simple_animal/pet/catslug/cherish
	name = "Cherish"
	desc = "A thickly furred, emerald catslug with big, shiny dark eyes that are constantly mooned with mirth. A red sash is wrapped over their chest; A keepsake, perhaps?"
	icon_state = "saintslug"
	icon_living = "saintslug"
	icon_dead = "saintslug_dead"
	gender = "plural"
//Mobs from Virgo

/mob/living/simple_animal/pet/wolf/direwolf
	name = "dire wolf"
	desc = "The biggest and baddest wolf around"
	icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_dead = "direwolf-dead"
	icon_living = "direwolf"
	icon_state = "direwolf"
	old_x = -16
	old_y = 0
	pixel_x = -16
	pixel_y = 0
	harm_intent_damage = 10
	melee_damage_lower = 10
	melee_damage_upper = 20
	health = 300
	maxHealth = 300

/mob/living/simple_animal/pet/wolf/direwolf/Initialize()
	. = ..()
	recenter_wide_sprite()

/mob/living/simple_animal/pet/wolf/direwolf/dog
	name = "large dog"
	desc = "The biggest and goodest dog around."
	icon_dead = "diredog-dead"
	icon_living = "diredog"
	icon_state = "diredog"

/mob/living/simple_animal/pet/wolf/direwolf/dog/sec
	name = "large guard dog"
	icon_dead = "diredogs-dead"
	icon_living = "diredogs"
	icon_state = "diredogs"

/mob/living/simple_animal/pet/wolf/direwolf/rykka
	name = "Rykka"
	desc = "This big canine looks like a GSD."
	icon_dead = "rykka-dead"
	icon_living = "rykka"
	icon_state = "rykka"

/mob/living/simple_animal/pet/wolf/direwolf/andrews
	name = "andrewsarchus"
	desc = "That's one massive mean-looking piece of long extinct megafauna."
	icon_dead = "andrews-dead"
	icon_living = "andrews"
	icon_state = "andrews"

/mob/living/simple_animal/hostile/alligator
	name = "Alligator"
	desc = "A large reptile with sharp looking teeth."
	icon = 'modular_coyote/icons/mob/alligator.dmi'
	icon_living = "alligator"
	icon_state = "alligator"
	icon_dead = "alligator_dead"
	melee_damage_lower = 30
	melee_damage_upper = 20
	maxHealth = 400
	health = 400
	emote_taunt_sound = list('sound/alien/Voice/growl1.ogg', 'sound/alien/Voice/growl3.ogg', )
	idlesound = list('sound/alien/Voice/hiss1.ogg',)

/mob/living/simple_animal/hostile/alligator/Initialize()
	. = ..()
	recenter_wide_sprite()

//Dinos

/mob/living/simple_animal/hostile/dinosaur/Initialize()
	. = ..()
	recenter_wide_sprite()

/mob/living/simple_animal/hostile/retaliate/goat/dinosaur/Initialize()
	. = ..()
	recenter_wide_sprite()

/mob/living/simple_animal/hostile/retaliate/goat/dinosaur/triceratops/bull
	name = "Bull Triceratops"
	desc = "With its 3 horns, a parrot-like beak and a large frill that could reach nearly 1 metre (3 feet) across, the Triceratops skull is one of the largest and most striking of any land animal."
	icon = 'modular_coyote/icons/mob/dinosaurs68x45.dmi'
	icon_state = "triceratops_bull"
	icon_living = "triceratops_bull"
	icon_dead = "triceratops_bull_dead"
	speak_emote = list("bellows")
	emote_hear = list("bellows")
	emote_see = list("shakes its head.", "stamps a foot.", "glares around.")
	health = 200
	maxHealth = 200
	melee_damage_lower = 5
	melee_damage_upper = 10

/mob/living/simple_animal/hostile/retaliate/goat/dinosaur/triceratops/cow
	name = "Cow Triceratops"
	desc = "With its 3 horns, a parrot-like beak and a large frill that could reach nearly 1 metre (3 feet) across, the Triceratops skull is one of the largest and most striking of any land animal."
	icon = 'modular_coyote/icons/mob/dinosaurs68x45.dmi'
	icon_state = "triceratops_cow"
	icon_living = "triceratops_cow"
	icon_dead = "triceratops_cow_dead"
	speak_emote = list("bellows")
	emote_hear = list("bellows")
	emote_see = list("shakes its head.", "stamps a foot.", "glares around.")
	health = 200
	maxHealth = 200
	melee_damage_lower = 5
	melee_damage_upper = 10

/mob/living/simple_animal/hostile/dinosaur/velociraptor
	name = "velociraptor"
	desc = " Its sleek body was lightweight and built for speed, making it an effective predator. Its head was long and narrow, its snout was somewhat flattened, and it had a fairly large brain."
	icon = 'modular_coyote/icons/mob/dinosaurs68x45.dmi'
	icon_state = "velociraptor"
	icon_living = "velociraptor"
	icon_dead = "velociraptor_dead"
	speak_emote = list("hisses")
	emote_hear = list("hisses", "roars", "barks")
	emote_see = list("shakes it's head.", "taps it's claws,")
	health = 200 //Just a place holder for now
	maxHealth = 200
	melee_damage_lower = 20
	melee_damage_upper = 30

/mob/living/simple_animal/hostile/dinosaur/pachycephalosaurus
	name = "pachycephalosaurus"
	desc = "A biped with strong hind limbs and little developed forelimbs. Featuring a high, domelike skull."
	icon = 'modular_coyote/icons/mob/dinosaurs45x27.dmi'
	icon_state = "pachycephalosaurus"
	icon_living = "pachycephalosaurus"
	icon_dead = "pachycephalosaurus_dead"
	health = 200
	maxHealth = 200
	melee_damage_lower = 15
	melee_damage_upper = 20

/mob/living/simple_animal/hostile/dinosaur/dimetrodon
	name = "dimetrodon"
	desc = "A carnivore with a large sail upon it's back."
	icon = 'modular_coyote/icons/mob/dinosaurs45x27.dmi'
	icon_state = "dimetrodon"
	icon_living = "dimetrodon"
	icon_dead = "dimetrodon_dead"
	health = 200
	maxHealth = 200
	melee_damage_lower = 15
	melee_damage_upper = 20

/mob/living/simple_animal/hostile/dinosaur/mammoth
	name = "mammoth"
	desc = "A large creature with long, curved tusks and thick hair upon it's body."
	icon = 'modular_coyote/icons/mob/dinosaurs128x96.dmi'
	icon_state = "mammoth"
	icon_living = "mammoth"
	icon_dead = "mammoth_dead"
	health = 200
	maxHealth = 200
	melee_damage_lower = 15
	melee_damage_upper = 20

/mob/living/simple_animal/hostile/dinosaur/rex
	name = "Rex"
	desc = "Standing about 40 feet tall, this creature looks rather strong and powerful."
	icon = 'modular_coyote/icons/mob/dinosaurs128x96.dmi'
	icon_state = "rex"
	icon_living = "rex"
	icon_dead = "rex_dead"
	health = 200
	maxHealth = 200
	melee_damage_lower = 15
	melee_damage_upper = 20

//Kangaroo

/mob/living/simple_animal/hostile/kangaroo //cause roo's be mean
	name = "Kangaroo"
	desc = "A marsupial! One that posseses powerful hind legs, a long strong tail and small front legs."
	icon = 'modular_coyote/icons/mob/kangaroo.dmi'
	icon_state = "kangaroo"
	icon_living = "kangaroo"
	icon_dead = "kangaroo_dead"
	speak_emote = list("grunts")
	emote_hear = list("grunts.", "barks")
	emote_see = list("shakes its head.", "hops around.", "ears flick.")
	health = 200
	maxHealth = 200
	melee_damage_lower = 5
	melee_damage_upper = 10

/mob/living/simple_animal/pet/kiwi
	name = "Kiwi"
	icon = 'modular_coyote/icons/mob/kiwi.dmi'
	icon_dead = "kiwi_dead"
	icon_living = "kiwi"
	icon_state = "kiwi"

/mob/living/simple_animal/pet/sheep
	name = "Sheep"
	icon = 'modular_coyote/icons/mob/sheep.dmi'
	icon_dead = "sheep_dead"
	icon_living = "sheep"
	icon_state = "sheep"

//raccoons
/mob/living/simple_animal/raccoon //the base, generic raccoon
	name = "Raccoon"
	desc = "A trash panda! Aw, how cute."
	icon = 'modular_coyote/icons/mob/raccoon.dmi'
	icon_dead = "raccoon_darkgrey_dead"
	icon_living = "raccoon_darkgrey"
	icon_state = "raccoon_darkgrey"
	speak_emote = list("chitters")
	emote_hear = list ("chitters", "purr")
	emote_see = list("rubs it's hands togther.", "twitches it's nose.", "flicks it's ears.")
	idlesound = list('modular_coyote/sound/typing/arfs1sounds/raccoon1.ogg',)
	turns_per_move = 3
	maxHealth = 100
	health = 100
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "stamps on"
	response_harm_simple = "stamp"

/mob/living/simple_animal/raccoon/Initialize()
    .=..()
    resize = 0.5
    update_transform()

/mob/living/simple_animal/raccoon/brown
	name = "Raccoon"
	desc = "A trash panda! Aw, how cute. This one is brown."
	icon = 'modular_coyote/icons/mob/raccoon.dmi'
	icon_dead = "raccoon_brown_dead"
	icon_living = "raccoon_brown"
	icon_state = "raccoon_brown"

/mob/living/simple_animal/raccoon/redbrown
	name = "Raccoon"
	desc = "A trash panda! Aw, how cute. This one is redish brown."
	icon = 'modular_coyote/icons/mob/raccoon.dmi'
	icon_dead = "raccoon_redbrown_dead"
	icon_living = "raccoon_redbrown"
	icon_state = "raccoon_redbrown"

/mob/living/simple_animal/raccoon/orange
	name = "Raccoon"
	desc = "A trash panda! Aw, how cute. This one is orange."
	icon = 'modular_coyote/icons/mob/raccoon.dmi'
	icon_dead = "raccoon_orange_dead"
	icon_living = "raccoon_orange"
	icon_state = "raccoon_orange"

/mob/living/simple_animal/raccoon/lightgrey
	name = "Raccoon"
	desc = "A trash panda! Aw, how cute. This one is light grey. It seems like it likes donuts."
	icon = 'modular_coyote/icons/mob/raccoon.dmi'
	icon_dead = "raccoon_lightgrey_dead"
	icon_living = "raccoon_lightgrey"
	icon_state = "raccoon_lightgrey"

/mob/living/simple_animal/raccoon/darkbrown
	name = "Raccoon"
	desc = "A trash panda! Aw, how cute. This one is dark brown."
	icon = 'modular_coyote/icons/mob/raccoon.dmi'
	icon_dead = "raccoon_darkbrown_dead"
	icon_living = "raccoon_darkbrown"
	icon_state = "raccoon_darkbrown"

/mob/living/simple_animal/raccoon/red
	name = "Raccoon"
	desc = "A trash panda! Aw, how cute. This one is red"
	icon = 'modular_coyote/icons/mob/raccoon.dmi'
	icon_dead = "raccoon_red_dead"
	icon_living = "raccoon_red"
	icon_state = "raccoon_red"

/mob/living/simple_animal/raccoon/oakbrown
	name = "Raccoon"
	desc = "A trash panda! Aw, how cute. This one is oak brown"
	icon = 'modular_coyote/icons/mob/raccoon.dmi'
	icon_dead = "raccoon_oakbrown_dead"
	icon_living = "raccoon_oakbrown"
	icon_state = "raccoon_oakbrown"

/mob/living/simple_animal/armadillo
	name = "Armadillo"
	desc = "Better hope he doesn't cross the road to see the spirit of the west."
	icon = 'modular_coyote/icons/mob/armadillo.dmi'
	icon_dead = "armadillo_dead"
	icon_living = "armadillo"
	icon_state = "armadillo"
	speak_emote = list("chitters")
	emote_hear = list ("chitters", "screams")
	emote_see = list("rolls around.", "twitches it's nose.", "flicks it's ears.")
	turns_per_move = 3
	maxHealth = 100
	health = 100
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "stamps on"
	response_harm_simple = "stamp"

/mob/living/simple_animal/uffalo
	name = "Uffalo"
	desc = "Some sort of..mutant buffallo creature. Gross."
	icon = 'modular_coyote/icons/mob/uffalo.dmi'
	icon_dead = "uffalo_dead"
	icon_living = "uffalo"
	icon_state = "uffalo"
	turns_per_move = 3
	maxHealth = 100
	health = 100
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 6)

/mob/living/simple_animal/uffalo/Initialize()
	. = ..()
	recenter_wide_sprite()

/mob/living/simple_animal/pokemon/tenderclawmale
	name = "male tenderclaw"
	desc = "A..deathclaw? Or, well. It sort of looks like a deathclaw. Just, softer and friendler!"
	icon = 'modular_coyote/icons/mob/newclaws.dmi'
	icon_state = "newclaw"
	icon_living = "newclaw"
	icon_dead = "newclaw_d"

/mob/living/simple_animal/pokemon/tenderclawfemale
	name = "female tenderclaw"
	desc = "A..deathclaw? Or, well. It sort of looks like a deathclaw. Just, softer and friendler!"
	icon = 'modular_coyote/icons/mob/newclaws.dmi'
	icon_state = "femclaw"
	icon_living = "femclaw"
	icon_dead = "femclaw_d"

/mob/living/simple_animal/pokemon/tenderclawherm
	name = "herm tenderclaw"
	desc = "A..deathclaw? Or, well. It sort of looks like a deathclaw. Just, softer and friendler!"
	icon = 'modular_coyote/icons/mob/newclaws.dmi'
	icon_state = "hermclaw"
	icon_living = "hermclaw"
	icon_dead = "hermclaw_d"

/mob/living/simple_animal/pokemon/nightstalker
	name = "nightstalker"
	desc = "A nightstalker!"
	icon = 'icons/fallout/mobs/animals/nightstalker.dmi'
	icon_state = "nightstalker"
	icon_living = "nightstalker"
	icon_dead = "nightstalker-dead"

/mob/living/simple_animal/pokemon/wendigo
	name = "wendigo"
	desc = "A mythological man-eating legendary creature, you probably aren't going to survive this.!"
	icon = 'icons/mob/icemoon/64x64megafauna.dmi'
	icon_state = "wendigo"
	icon_living = "wendigo"
	icon_dead = "wendigo_dead"
	health = 150
	maxHealth = 150

//Actual chooseable mouse colors

/mob/living/simple_animal/pokemon/mousewhite
	icon = 'icons/mob/animal.dmi'
	icon_state = "mouse_white"

/mob/living/simple_animal/pokemon/mousegray
	icon = 'icons/mob/animal.dmi'
	icon_state = "mouse_gray"

/mob/living/simple_animal/pokemon/mousebrown
	icon = 'icons/mob/animal.dmi'
	icon_state = "mouse_brown"


//The simple version of the dog borgs.


/mob/living/simple_animal/pokemon/blade//Yes they are pokemon, shut.
	name = "blade borg"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "blade"
	icon_living = "blade"
	icon_dead = "blade-wreck"

/mob/living/simple_animal/pokemon/k9
	name = "k9"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "k9"
	icon_living = "k9"
	icon_dead = "k9-wreck"

/mob/living/simple_animal/pokemon/k9
	name = "k9"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "k9"
	icon_living = "k9"
	icon_dead = "k9-wreck"

/mob/living/simple_animal/pokemon/medihound
	name = "medihound"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "medihound"
	icon_living = "medihound"
	icon_dead = "medihound-wreck"

/mob/living/simple_animal/pokemon/k69
	name = "k69"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "k69"
	icon_living = "k69"
	icon_dead = "k69-wreck"

/mob/living/simple_animal/pokemon/scrubpup
	name = "scrubpup"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "scrubpup"
	icon_living = "scrubpup"
	icon_dead = "scrubpup-wreck"

/mob/living/simple_animal/pokemon/alinaeng
	name = "engineering hound"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "alina-eng"
	icon_living = "alina-eng"
	icon_dead = "alina-eng-wreck"

/mob/living/simple_animal/pokemon/alinasec
	name = "security hound"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "alina-sec"
	icon_living = "alina-sec"
	icon_dead = "alina-sec-wreck"

/mob/living/simple_animal/pokemon/alinamed
	name = "medical hound"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "alina-med"
	icon_living = "alina-med"
	icon_dead = "alina-med-wreck"

/mob/living/simple_animal/pokemon/medihounddark
	name = "medical hound dark"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "medihounddark"
	icon_living = "medihounddark"
	icon_dead = "medihounddark-wreck"

/mob/living/simple_animal/pokemon/pupdozer
	name = "pupdozer"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "pupdozer"
	icon_living = "pupdozer"
	icon_dead = "pupdozer-wreck"

/mob/living/simple_animal/pokemon/k9dark
	name = "k9 dark"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "k9dark"
	icon_living = "k9dark"
	icon_dead = "k9dark-wreck"

/mob/living/simple_animal/pokemon/valemed
	name = "vale med"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valemed"
	icon_living = "valemed"
	icon_dead = "valemed-wreck"

/mob/living/simple_animal/pokemon/valesci
	name = "vale sci"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valesci"
	icon_living = "valesci"
	icon_dead = "valesci-wreck"

/mob/living/simple_animal/pokemon/valesesc
	name = "Vale sec"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valesec"
	icon_living = "valesec"
	icon_dead = "valesec-wreck"

/mob/living/simple_animal/pokemon/valeseng
	name = "Vale eng"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valeeng"
	icon_living = "valeeng"
	icon_dead = "valeeng-wreck"

/mob/living/simple_animal/pokemon/valemine
	name = "Vale mine"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valemine"
	icon_living = "valemine"
	icon_dead = "valemine-wreck"

/mob/living/simple_animal/pokemon/k50
	name = "k50"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "k50"
	icon_living = "k50"
	icon_dead = "k50-wreck"

/mob/living/simple_animal/pokemon/valeserv
	name = "vale serv"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valeserv"
	icon_living = "valeserv"
	icon_dead = "valeserv-wreck"

/mob/living/simple_animal/pokemon/valeservdark
	name = "vale serv dark"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valeservdark"
	icon_living = "valeservdark"
	icon_dead = "valeservdark-wreck"


//Raptor borgs from Virgo
/mob/living/simple_animal/pokemon/secraptor
	name = "security raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "secraptor"
	icon_living = "secraptor"
	icon_dead = "secraptor-wreck"

/mob/living/simple_animal/pokemon/sciraptor
	name = "science raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "sciraptor"
	icon_living = "sciraptor"
	icon_dead = "sciraptor-wreck"

/mob/living/simple_animal/pokemon/mediraptor
	name = "medical raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "medraptor"
	icon_living = "medraptor"
	icon_dead = "medraptor-wreck"

/mob/living/simple_animal/pokemon/engiraptor
	name = "engineering raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "engiraptor"
	icon_living = "engiraptor"
	icon_dead = "engiraptor-wreck"

/mob/living/simple_animal/pokemon/mineraptor
	name = "mining raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "mineraptor"
	icon_living = "mineraptor"
	icon_dead = "mineraptor-wreck"

/mob/living/simple_animal/pokemon/traumaraptor
	name = "trauma raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "traumaraptor"
	icon_living = "traumaraptor"
	icon_dead = "traumaraptor-wreck"

/mob/living/simple_animal/pokemon/janiraptor
	name = "janitor raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "janiraptor"
	icon_living = "janiraptor"
	icon_dead = "janiraptor-wreck"

/mob/living/simple_animal/pokemon/serviraptor
	name = "service raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "serviraptor"
	icon_living = "serviraptor"
	icon_dead = "serviraptor-wreck"

/mob/living/simple_animal/pokemon/fancyraptor
	name = "fancy raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "fancyraptor"
	icon_living = "fancyraptor"
	icon_dead = "fancyraptor-wreck"



//raptor mobs from virgo

/mob/living/simple_animal/pokemon/purpleraptor
	name = "purple raptor - animal"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "raptorpurple"
	icon_living = "raptorpurple"
	icon_dead = "raptorpurple_dead"

/mob/living/simple_animal/pokemon/greenraptor
	name = "green raptor - animal"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "raptorgreen"
	icon_living = "raptorgreen"
	icon_dead = "raptorgreen_dead"

/mob/living/simple_animal/pokemon/redraptor
	name = "red raptor - animal"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "raptorred"
	icon_living = "raptorred"
	icon_dead = "raptorred_dead"

/mob/living/simple_animal/pokemon/blueraptor
	name = "blue raptor - animal"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "raptorblue"
	icon_living = "raptorblue"
	icon_dead = "raptorblue_dead"

/mob/living/simple_animal/pokemon/blackraptor
	name = "black raptor - animal"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "raptorblack"
	icon_living = "raptorblack"
	icon_dead = "raptorblack_dead"

/mob/living/simple_animal/pokemon/whiteraptor
	name = "white raptor - animal"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "raptorwhite"
	icon_living = "raptorwhite"
	icon_dead = "raptorwhite_dead"

