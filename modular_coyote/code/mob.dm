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
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 12, /obj/item/stack/sheet/bone = 7, /obj/item/reagent_containers/food/snacks/meat/rawbacon = 8)
	butcher_difficulty = 1
	speak_chance = 1
	loot = list(/obj/effect/spawner/lootdrop/f13/uncommon)
	loot_drop_amount = 4
	am_important = TRUE

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
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 1)
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
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 1)
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
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 6)

/mob/living/simple_animal/uffalo/Initialize()
	. = ..()
	recenter_wide_sprite()

//Start Advanced Mobs//

/mob/living/simple_animal/advanced/tenderclawmale
	name = "male tenderclaw"
	desc = "A..aethergiest? Or, well. It sort of looks like a aethergiest. Just, softer and friendler!"
	icon = 'modular_coyote/icons/mob/newclaws.dmi'
	icon_state = "newclaw"
	icon_living = "newclaw"
	icon_dead = "newclaw_d"

/mob/living/simple_animal/advanced/tenderclawfemale
	name = "female tenderclaw"
	desc = "A..aethergiest? Or, well. It sort of looks like a aethergiest. Just, softer and friendler!"
	icon = 'modular_coyote/icons/mob/newclaws.dmi'
	icon_state = "femclaw"
	icon_living = "femclaw"
	icon_dead = "femclaw_d"

/mob/living/simple_animal/advanced/tenderclawherm
	name = "herm tenderclaw"
	desc = "A..aethergiest? Or, well. It sort of looks like a aethergiest. Just, softer and friendler!"
	icon = 'modular_coyote/icons/mob/newclaws.dmi'
	icon_state = "hermclaw"
	icon_living = "hermclaw"
	icon_dead = "hermclaw_d"

/mob/living/simple_animal/advanced/nightstalker
	name = "nightstalker"
	desc = "A nightstalker!"
	icon = 'icons/fallout/mobs/animals/nightstalker.dmi'
	icon_state = "nightstalker"
	icon_living = "nightstalker"
	icon_dead = "nightstalker-dead"

/mob/living/simple_animal/advanced/wendigo
	name = "wendigo"
	desc = "A mythological man-eating legendary creature, you probably aren't going to survive this.!"
	icon = 'icons/mob/icemoon/64x64megafauna.dmi'
	icon_state = "wendigo"
	icon_living = "wendigo"
	icon_dead = "wendigo_dead"

//The simple version of the dog borgs.
/mob/living/simple_animal/advanced/blade//Yes they are pokemon, shut.
	name = "blade borg"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "blade"
	icon_living = "blade"
	icon_dead = "blade-wreck"

/mob/living/simple_animal/advanced/k9
	name = "k9"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "k9"
	icon_living = "k9"
	icon_dead = "k9-wreck"

/mob/living/simple_animal/advanced/k9
	name = "k9"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "blocky_valesec"
	icon_living = "blocky_valesec"
	icon_dead = "blocky_valesec-wreck"

/mob/living/simple_animal/advanced/medihound
	name = "medihound"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "light_valemed"
	icon_living = "light_valemed"
	icon_dead = "light_valemed-wreck"

/mob/living/simple_animal/advanced/k69
	name = "k69"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "k69"
	icon_living = "k69"
	icon_dead = "k69-wreck"

/mob/living/simple_animal/advanced/scrubpup
	name = "scrubpup"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "scrubpup"
	icon_living = "scrubpup"
	icon_dead = "scrubpup-wreck"

/mob/living/simple_animal/advanced/alinaeng
	name = "engineering hound"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "alina-eng"
	icon_living = "alina-eng"
	icon_dead = "alina-eng-wreck"

/mob/living/simple_animal/advanced/alinasec
	name = "security hound"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "alina-sec"
	icon_living = "alina-sec"
	icon_dead = "alina-sec-wreck"

/mob/living/simple_animal/advanced/alinamed
	name = "medical hound"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "alina-med"
	icon_living = "alina-med"
	icon_dead = "alina-med-wreck"

/mob/living/simple_animal/advanced/medihounddark
	name = "medical hound dark"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "dark_valemed"
	icon_living = "dark_valemed"
	icon_dead = "dark_valemed-wreck"

/mob/living/simple_animal/advanced/pupdozer
	name = "pupdozer"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "pupdozer_valeeng"
	icon_living = "pupdozer_valeeng"
	icon_dead = "pupdozer_valeeng-wreck"

/mob/living/simple_animal/advanced/k9dark
	name = "k9 dark"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "dark_valesec"
	icon_living = "dark_valesec"
	icon_dead = "dark_valesec-wreck"

/mob/living/simple_animal/advanced/valemed
	name = "vale med"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valemed"
	icon_living = "valemed"
	icon_dead = "valemed-wreck"

/mob/living/simple_animal/advanced/valesci
	name = "vale sci"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valesci"
	icon_living = "valesci"
	icon_dead = "valesci-wreck"

/mob/living/simple_animal/advanced/valesesc
	name = "Vale sec"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valesec"
	icon_living = "valesec"
	icon_dead = "valesec-wreck"

/mob/living/simple_animal/advanced/valeseng
	name = "Vale eng"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valeeng"
	icon_living = "valeeng"
	icon_dead = "valeeng-wreck"

/mob/living/simple_animal/advanced/valemine
	name = "Vale mine"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valemine"
	icon_living = "valemine"
	icon_dead = "valemine-wreck"

/mob/living/simple_animal/advanced/k50
	name = "k50"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "blocky_valeserv"
	icon_living = "blocky_valeserv"
	icon_dead = "blocky_valeserv-wreck"

/mob/living/simple_animal/advanced/valeserv
	name = "vale serv"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "valeserv"
	icon_living = "valeserv"
	icon_dead = "valeserv-wreck"

/mob/living/simple_animal/advanced/valeservdark
	name = "vale serv dark"
	icon = 'modular_coyote/icons/mob/dogborg.dmi'
	icon_state = "dark_valeserv"
	icon_living = "dark_valeserv"
	icon_dead = "dark_valeserv-wreck"


//Raptor borgs from Virgo
/mob/living/simple_animal/advanced/secraptor
	name = "security raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "secraptor"
	icon_living = "secraptor"
	icon_dead = "secraptor-wreck"

/mob/living/simple_animal/advanced/sciraptor
	name = "science raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "sciraptor"
	icon_living = "sciraptor"
	icon_dead = "sciraptor-wreck"

/mob/living/simple_animal/advanced/mediraptor
	name = "medical raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "medraptor"
	icon_living = "medraptor"
	icon_dead = "medraptor-wreck"

/mob/living/simple_animal/advanced/engiraptor
	name = "engineering raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "engiraptor"
	icon_living = "engiraptor"
	icon_dead = "engiraptor-wreck"

/mob/living/simple_animal/advanced/mineraptor
	name = "mining raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "mineraptor"
	icon_living = "mineraptor"
	icon_dead = "mineraptor-wreck"

/mob/living/simple_animal/advanced/traumaraptor
	name = "trauma raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "traumaraptor"
	icon_living = "traumaraptor"
	icon_dead = "traumaraptor-wreck"

/mob/living/simple_animal/advanced/janiraptor
	name = "janitor raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "janiraptor"
	icon_living = "janiraptor"
	icon_dead = "janiraptor-wreck"

/mob/living/simple_animal/advanced/serviraptor
	name = "service raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "serviraptor"
	icon_living = "serviraptor"
	icon_dead = "serviraptor-wreck"

/mob/living/simple_animal/advanced/fancyraptor
	name = "fancy raptor"
	icon = 'modular_coyote/icons/mob/raptorborg.dmi'
	icon_state = "fancyraptor"
	icon_living = "fancyraptor"
	icon_dead = "fancyraptor-wreck"

//raptor mobs from virgo

/mob/living/simple_animal/advanced/purpleraptor
	name = "purple raptor - animal"
	icon = 'modular_coyote/icons/mob/virgo_raptor.dmi'
	icon_state = "raptorpurple"
	icon_living = "raptorpurple"
	icon_dead = "raptorpurple_dead"

/mob/living/simple_animal/advanced/greenraptor
	name = "green raptor - animal"
	icon = 'modular_coyote/icons/mob/virgo_raptor.dmi'
	icon_state = "raptorgreen"
	icon_living = "raptorgreen"
	icon_dead = "raptorgreen_dead"

/mob/living/simple_animal/advanced/redraptor
	name = "red raptor - animal"
	icon = 'modular_coyote/icons/mob/virgo_raptor.dmi'
	icon_state = "raptorred"
	icon_living = "raptorred"
	icon_dead = "raptorred_dead"

/mob/living/simple_animal/advanced/blueraptor
	name = "blue raptor - animal"
	icon = 'modular_coyote/icons/mob/virgo_raptor.dmi'
	icon_state = "raptorblue"
	icon_living = "raptorblue"
	icon_dead = "raptorblue_dead"

/mob/living/simple_animal/advanced/blackraptor
	name = "black raptor - animal"
	icon = 'modular_coyote/icons/mob/virgo_raptor.dmi'
	icon_state = "raptorblack"
	icon_living = "raptorblack"
	icon_dead = "raptorblack_dead"

/mob/living/simple_animal/advanced/whiteraptor
	name = "white raptor - animal"
	icon = 'modular_coyote/icons/mob/virgo_raptor.dmi'
	icon_state = "raptorwhite"
	icon_living = "raptorwhite"
	icon_dead = "raptorwhite_dead"

/mob/living/simple_animal/advanced/bat
	name = "bat"
	icon = 'icons/mob/animal.dmi'
	icon_state = "bat"
	icon_living = "bat"
	icon_dead = "bat_dead"

/mob/living/simple_animal/advanced/cat
	name = "cat"
	icon = 'icons/mob/pets.dmi'
	icon_state = "cat2"
	icon_living = "cat2"
	icon_dead = "cat2_dead"

/mob/living/simple_animal/advanced/bighorn
	name = "bighorner"
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "bighorner"
	icon_living = "bighorner"
	icon_dead = "bighorner_dead"

//More Virgo mobs
//Big wolfs
/mob/living/simple_animal/advanced/bigwolf
	name = "big wolf - black"
	icon = 'modular_coyote/icons/mob/vore128x64.dmi'
	icon_state = "blackwolf"
	icon_living = "blackwolf"
	icon_dead = "blackwolf_dead"

/mob/living/simple_animal/advanced/bigwolf/Initialize()
    .=..()
    resize = 0.5
    update_transform()

/mob/living/simple_animal/advanced/sifwolf
	name = "big wolf - silver"
	icon = 'modular_coyote/icons/mob/vore128x64.dmi'
	icon_state = "sifwolf"
	icon_living = "sifwolf"
	icon_dead = "sifwolf_dead"

/mob/living/simple_animal/advanced/sifwolf/Initialize()
    .=..()
    resize = 0.5
    update_transform()

/mob/living/simple_animal/advanced/whitewolf
	name = "big wolf - white"
	icon = 'modular_coyote/icons/mob/vore128x64.dmi'
	icon_state = "whitewolf"
	icon_living = "whitewolf"
	icon_dead = "whitewolf_dead"

/mob/living/simple_animal/advanced/whitewolf/Initialize()
    .=..()
    resize = 0.5
    update_transform()

//Leopardmanders

/mob/living/simple_animal/advanced/leopardmander
	name = "leopardmander -blue"
	icon = 'modular_coyote/icons/mob/vore128x64.dmi'
	icon_state = "leopardmander_blue"
	icon_living = "leopardmander_blue"
	icon_dead = "leopardmander_blue_dead"

/mob/living/simple_animal/advanced/leopardmander/Initialize()
    .=..()
    resize = 0.5
    update_transform()

/mob/living/simple_animal/advanced/leopardmanderwhite
	name = "leopardmander - white"
	icon = 'modular_coyote/icons/mob/vore128x64.dmi'
	icon_state = "leopardmander"
	icon_living = "leopardmander"
	icon_dead = "leopardmander_dead"

/mob/living/simple_animal/advanced/leopardmanderwhite/Initialize()
    .=..()
    resize = 0.5
    update_transform()

/mob/living/simple_animal/advanced/leopardmanderexotic
	name = "leopardmander - exotic"
	icon = 'modular_coyote/icons/mob/vore128x64.dmi'
	icon_state = "leopardmander_exotic"
	icon_living = "leopardmander_exotic"
	icon_dead = "leopardmander_exotic_dead"

/mob/living/simple_animal/advanced/leopardmanderexotic/Initialize()
    .=..()
    resize = 0.5
    update_transform()


/mob/living/simple_animal/advanced/gecko
	name = "gecko"
	desc = "A large mutated reptile with sharp teeth."
	icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_state = "gekko"
	icon_living = "gekko"
	icon_dead = "gekko_dead"

/mob/living/simple_animal/advanced/gecko_villager
	name = "gecko villager"
	desc = "A large mutated reptile that has learned the basics of tool usage."
	icon = 'icons/fallout/mobs/animals/gecktribe.dmi'
	icon_state = "gekko_tribe_villager"
	icon_living = "gekko_tribe_villager"
	icon_dead = "gekko_dead"



/mob/living/simple_animal/advanced/gecko_leader
	name = "gecko leader"
	desc = "A large mutated reptile that has learned the basics of checks and balances."
	icon = 'icons/fallout/mobs/animals/gecktribe.dmi'
	icon_state = "gekko_tribe_leader"
	icon_living = "gekko_tribe_leader"
	icon_dead = "gekko_dead"

/mob/living/simple_animal/advanced/gecko_shaman
	name = "gecko shaman"
	desc = "A large mutated reptile that has learned the basics of magic."
	icon = 'icons/fallout/mobs/animals/gecktribe.dmi'
	icon_state = "gekko_tribe_shaman"
	icon_living = "gekko_tribe_shaman"
	icon_dead = "gekko_dead"

/mob/living/simple_animal/advanced/molerat
	name = "molerat"
	desc = "A large mutated rat-mole hybrid that finds its way everywhere. Common in caves and underground areas."
	icon = 'icons/fallout/mobs/animals/wasteanimals.dmi'
	icon_state = "molerat"
	icon_living = "molerat"
	icon_dead = "molerat_dead"

/mob/living/simple_animal/advanced/dog
	name = "dog"
	desc = "Some kind of dog."
	icon = 'icons/fallout/mobs/animals/dogs.dmi'
	icon_state = "dog_feral"
	icon_living = "dog_feral"
	icon_dead = "dog_feral_dead"

/mob/living/simple_animal/advanced/rottweiler
	name = "rottweiler"
	desc = "Some kind of dog."
	icon = 'icons/fallout/mobs/animals/dogs.dmi'
	icon_state = "rottweiler"
	icon_living = "rottweiler"
	icon_dead = "rottweiler_dead"

/mob/living/simple_animal/advanced/labretriever
	name = "labrador retriever"
	desc = "Some kind of dog."
	icon = 'icons/fallout/mobs/animals/dogs.dmi'
	icon_state = "tippen"
	icon_living = "tippen"
	icon_dead = "tippen_dead"

/mob/living/simple_animal/advanced/shepherd
	name = "shepherd"
	desc = "Some kind of dog."
	icon = 'icons/fallout/mobs/animals/dogs.dmi'
	icon_state = "shepherd"
	icon_living = "shepherd"
	icon_dead = "shepherd_dead"

/mob/living/simple_animal/advanced/wolf
	name = "wolf"
	desc = "Some kind of wild dog thing."
	icon = 'icons/fallout/mobs/animals/dogs.dmi'
	icon_state = "wolf"
	icon_living = "wolf"
	icon_dead = "wolf_dead"

/mob/living/simple_animal/advanced/direwolf
	name = "white dire wolf"
	desc = "Some kind of wild dog thing."
	icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_state = "direwolf"
	icon_living = "direwolf"
	icon_dead = "direwolf_dead"

/mob/living/simple_animal/advanced/hyotie
	name = "hyotie"
	desc = "Some kind of mix of otie and hyena."
	icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_state = "andrews"
	icon_living = "andrews"
	icon_dead = "andrews_dead"

/mob/living/simple_animal/advanced/direwolf_black
	name = "black direwolf"
	desc = "Some kind of big black dog."
	icon = 'modular_coyote/icons/mob/vore64x32.dmi'
	icon_state = "rykka"
	icon_living = "rykka"
	icon_dead = "rykka_dead"

/mob/living/simple_animal/advanced/hellhound
	name = "hellound"
	desc = "It's a fire doggo from hell."
	icon = 'modular_coyote/icons/mob/paramob.dmi'
	icon_state = "hellhound"
	icon_living = "hellhound"
	icon_dead = "hellhound_dead"

/mob/living/simple_animal/advanced/hellhound_greater
	name = "greater hellound"
	desc = "It's a fire doggo from hell."
	icon = 'modular_coyote/icons/mob/paramob.dmi'
	icon_state = "hellhoundgreater"
	icon_living = "hellhoundgreater"
	icon_dead = "hellhound_dead"

/mob/living/simple_animal/advanced/rabbit
	name = "bunny"
	desc = "Hoppity hop, easter is on it's way."
	icon = 'modular_coyote/icons/mob/paramob.dmi'
	icon_state = "bunny"
	icon_living = "bunny"
	icon_dead = "bunny_dead"

/mob/living/simple_animal/advanced/yaoguai
	name = "tamed Yaoguai"
	desc = "Some kind of big black dog."
	icon = 'icons/fallout/mobs/animals/yaoguai.dmi'
	icon_state = "yaoguai"
	icon_living = "yaoguai"
	icon_dead = "yaoguai_dead"

//By request, xenomorphs
/mob/living/simple_animal/advanced/xeno
	name = "Xenomorph Drone"
	desc = "Don't tell Riply..."
	icon = 'modular_coyote/icons/mob/aliens.dmi'
	icon_state = "aliend"
	icon_living = "aliend"
	icon_dead = "aliend_dead"

/mob/living/simple_animal/advanced/xenos
	name = "Xenomorph Sentry"
	desc = "Don't tell Riply..."
	icon = 'modular_coyote/icons/mob/aliens.dmi'
	icon_state = "alienq"
	icon_living = "alienq"
	icon_dead = "alienq_dead"

/mob/living/simple_animal/advanced/xenoh
	name = "Xenomorph Hunter"
	desc = "Don't tell Riply..."
	icon = 'modular_coyote/icons/mob/aliens.dmi'
	icon_state = "alienh"
	icon_living = "alienh"
	icon_dead = "alienh_dead"

/mob/living/simple_animal/advanced/xenop
	name = "Xenomorph Protector"
	desc = "Don't tell Riply..."
	icon = 'icons/mob/alienqueen.dmi'
	icon_state = "alienp"
	icon_living = "alienp"
	icon_dead = "alienp_dead"

/mob/living/simple_animal/advanced/xenoq
	name = "Xenomorph Queen"
	desc = "Don't tell Riply..."
	icon = 'icons/mob/alienqueen.dmi'
	icon_state = "alienq"
	icon_living = "alienq"
	icon_dead = "alienq_dead"

/mob/living/simple_animal/advanced/xenoq/Initialize()
    .=..()
    resize = 0.7
    update_transform()

/mob/living/simple_animal/advanced/mousegrey
	name = "grey mouse"
	desc = "Now you see it, now you don't."
	icon = 'icons/mob/animal.dmi'
	icon_state = "mouse_gray"
	icon_living = "mouse_gray"
	icon_dead = "mouse_gray_dead"

/mob/living/simple_animal/advanced/mousebrown
	name = "brown mouse"
	desc = "Now you see it, now you don't."
	icon = 'icons/mob/animal.dmi'
	icon_state = "mouse_brown"
	icon_living = "mouse_brown"
	icon_dead = "mouse_brown_dead"

/mob/living/simple_animal/advanced/mousewhite
	name = "white mouse"
	desc = "Now you see it, now you don't."
	icon = 'icons/mob/animal.dmi'
	icon_state = "mouse_white"
	icon_living = "mouse_white"
	icon_dead = "mouse_white_dead"

/mob/living/simple_animal/advanced/opossum
	name = "opossum"
	desc = "It's an opossum, a small scavenging marsupial."
	icon = 'icons/mob/animal.dmi'
	icon_state = "possum"
	icon_living = "possum"
	icon_dead = "possum_dead"

/mob/living/simple_animal/advanced/greensnake
	name = "green snake"
	desc = "A slithering, noodle-like thing with a mouth."
	icon = 'icons/mob/animal.dmi'
	icon_state = "snake"
	icon_living = "snake"
	icon_dead = "snake_dead"

/mob/living/simple_animal/advanced/bee
	name = "bee"
	desc = "Bee yourself!"
	icon = 'icons/mob/animal.dmi'
	icon_state = "bumbles"
	icon_living = "bumbles"
	icon_dead = "bumbles_dead"

/mob/living/simple_animal/advanced/sophisticatedgorilla
	name = "sophisticated gorilla"
	desc = "The leg muscles!"
	icon = 'icons/mob/gorilla.dmi'
	icon_state = "standing"
	icon_living = "standing"
	icon_dead = "standing_dead"

/mob/living/simple_animal/advanced/gorilla
	name = "gorilla"
	desc = "The muscles!"
	icon = 'icons/mob/gorilla.dmi'
	icon_state = "crawling"
	icon_living = "crawling"
	icon_dead = "crawling_dead"

/mob/living/simple_animal/advanced/mothroach
	name = "mothroach"
	desc = "This is the adorable by-product of multiple attempts at genetically mixing mothpeople with cockroaches."
	icon = 'icons/mob/animal.dmi'
	icon_state = "mothroach"
	icon_living = "mothroach"
	icon_dead = "mothroach_dead"

/mob/living/simple_animal/advanced/bat
	name = "bat"
	desc = "Try not to go batty"
	icon = 'modular_coyote/icons/mob/bat.dmi'
	icon_state = "bat"
	icon_living = "bat"
	icon_dead = "bat_dead"

/mob/living/simple_animal/advanced/parrot
	name = "parrot"
	desc = "SQUAAAAWK!"
	icon = 'icons/mob/animal.dmi'
	icon_state = "parrot"
	icon_living = "parrot"
	icon_dead = "parrot_dead"

/mob/living/simple_animal/advanced/purpledc
	name = "purple cloaked aethergiest"
	desc = "Gonna rip and tear, in style."
	icon = 'modular_coyote/icons/mob/deathclaw.dmi'
	icon_state = "pur"
	icon_living = "pur"
	icon_dead = "pur_dead"

/mob/living/simple_animal/advanced/whitedc
	name = "white cloaked aethergiest"
	desc = "Gonna rip and tear, in style."
	icon = 'modular_coyote/icons/mob/deathclaw.dmi'
	icon_state = "whi"
	icon_living = "whi"
	icon_dead = "whi_dead"

/mob/living/simple_animal/advanced/reddc
	name = "red cloaked aethergiest"
	desc = "Gonna rip and tear, in style."
	icon = 'modular_coyote/icons/mob/deathclaw.dmi'
	icon_state = "red"
	icon_living = "red"
	icon_dead = "red_dead"

/mob/living/simple_animal/advanced/grydc
	name = "grey cloaked aethergiest"
	desc = "Gonna rip and tear, in style."
	icon = 'modular_coyote/icons/mob/deathclaw.dmi'
	icon_state = "gry"
	icon_living = "gry"
	icon_dead = "gry_dead"

/mob/living/simple_animal/advanced/brodc
	name = "brown cloaked aethergiest"
	desc = "Gonna rip and tear, in style."
	icon = 'modular_coyote/icons/mob/deathclaw.dmi'
	icon_state = "bro"
	icon_living = "bro"
	icon_dead = "bro_dead"

/mob/living/simple_animal/advanced/hubdc
	name = "black cloaked aethergiest"
	desc = "Gonna rip and tear, in style."
	icon = 'modular_coyote/icons/mob/deathclaw.dmi'
	icon_state = "hub"
	icon_living = "hub"
	icon_dead = "hub_dead"

/mob/living/simple_animal/advanced/maidclaw
	name = "maid aethergiest"
	desc = "Gonna rip and tear, in style."
	icon = 'modular_coyote/icons/mob/deathclaw.dmi'
	icon_state = "maidclaw"
	icon_living = "maidclaw"
	icon_dead = "maidclaw_dead"

/mob/living/simple_animal/advanced/queenclaw
	name = "Queen aethergiest"
	desc = "Gonna rip and tear, in style."
	icon = 'modular_coyote/icons/mob/deathclaw.dmi'
	icon_state = "aethergiest_queen"
	icon_living = "aethergiest_queen"
	icon_dead = "aethergiest_queen_dead"

//splurt mobs
/mob/living/simple_animal/advanced/femdigo
	name = "Female Wendigo"
	desc = "A curse, Or perhaps a blessing."
	icon = 'icons/mob/wendigo.dmi'
	icon_state = "femdigo"
	icon_living = "femdigo"
	icon_dead = "femdigo_dead"

// Start of colfers silly craftable hivebots

/mob/living/simple_animal/advanced/hivebot
	name = "General Hivebot"
	desc = "A hivebot?"
	health = 70
	see_in_dark = 3
	maxHealth = 70
	mob_armor = ARMOR_VALUE_ZERO
	AIStatus = AI_IDLE
	light_color = "#2BFF2B"
	light_range = 2.5
	light_power = 2
	can_have_ai = TRUE
	is_blacklisted = TRUE
	death_sound = 'modular_coyote/sound/typing/hivebot-attack.ogg'
	deathmessage = "was destroyed, use a multi-tool to revive them!"
	idlesound = 'modular_coyote/sound/typing/hivebot-bark-003.ogg'
	bubble_icon = "machine"
	icon = 'icons/mob/playerswarmer.dmi'
	rotate_on_lying = FALSE
	ghost_cooldown_time = 1 SECONDS
	can_ghost_into = TRUE
	healable = 0
	icon_state = "mediumarm_hivebot"
	icon_living = "mediumarm_hivebot"
	icon_dead = "mediumarm_hivebot_dead"

/mob/living/simple_animal/advanced/hivebot/cheap
	name = "Cheap Hivebot"
	desc = "Cheap hivebot with little health, no special traits."
	see_in_dark = 4
	health = 25
	maxHealth = 25
	icon_state = "small_hivebot"
	icon_living = "small_hivebot"
	icon_dead = "small_hivebot_dead"

/mob/living/simple_animal/advanced/hivebot/ranged
	name = "Ranged Hivebot"
	desc = "Ranged hivebot, comes with deadeye."
	health = 50
	maxHealth = 50
	icon_state = "rangedarm_hivebot"
	icon_living = "rangedarm_hivebot"
	icon_dead = "rangedarm_hivebot_dead"

/mob/living/simple_animal/advanced/hivebot/factory
	name = "Factory Hivebot"
	desc = "Factory hivebot, comes with treasure hunter, quick build, and technophreak"
	health = 50
	maxHealth = 50
	icon_state = "factory_hivebot"
	icon_living = "factory_hivebot"
	icon_dead = "factory_hivebot_dead"

/mob/living/simple_animal/advanced/hivebot/crystal
	name = "Crystaline Hivebot"
	desc = "Comes with improved healing, magegrab, and wand usage."
	health = 60
	maxHealth = 60
	icon_state = "crystal_hivebot"
	icon_living = "crystal_hivebot"
	icon_dead = "crystal_hivebot_dead"


/mob/living/simple_animal/advanced/hivebot/crystal/Initialize(trait_source = TRAIT_GENERIC)
	. = ..()
	ADD_TRAIT(src, TRAIT_WAND_PROFICIENT, "wand_proficient")
	ADD_TRAIT(src, TRAIT_IMPROVED_HEALING, "improved_healing")
	ADD_TRAIT(src, TRAIT_MAGEGRAB, "Mage Grab")

/mob/living/simple_animal/advanced/hivebot/ranged/Initialize(trait_source = TRAIT_GENERIC)
	. = ..()
	ADD_TRAIT(src, TRAIT_NICE_SHOT, "nice_shot")

/mob/living/simple_animal/advanced/hivebot/factory/Initialize(trait_source = TRAIT_GENERIC)
	. = ..()
	/*ADD_TRAIT(src, TRAIT_TREASURE_HUNTER, "treasurehunter")*/// Not until crafting menus are fixed
	ADD_TRAIT(src, TRAIT_TECHNOPHREAK, "technophreak")
	ADD_TRAIT(src, TRAIT_QUICK_BUILD, "quick-build")

/mob/living/simple_animal/advanced/hivebot/Initialize(trait_source = TRAIT_GENERIC)
	. = ..()
	ADD_TRAIT(src, TRAIT_IGNOREDAMAGESLOWDOWN, "ignoredamageslowdown")
	ADD_TRAIT(src, TRAIT_HEAL_TEND, "healing_triage")

/mob/living/simple_animal/advanced/hivebot/Initialize(mapload)
	. = ..()
	notify_ghosts("A new FRIENDLY hivebot has been created somewhere on the map, click it to take control!", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE, ignore_key = POLL_IGNORE_FUGITIVE)

/*/mob/living/simple_animal/advanced/hivebot/attack_ghost(mob/dead/observer/ghost)
	. = ..()
	icon_state = input("Default","small_hivebot","smallarm_hivebot","medium_hivebot")
	if(icon_state == "Default")
		icon_state = "hivebot"
	else
		icon_state = "hivebot"

	icon_living = icon_state
	icon_dead = "[icon_state]_dead"*/ // Would be cool to be able to set your icon, but I don't know how to make it work and im tired grandpa

/mob/living/simple_animal/advanced/hivebot/examine(mob/user)
	. = list("<span class='info'>*---------*\nThis is [icon2html(src, user)] \a <b>[src]</b>!")

	if(health != maxHealth)
		if(health > maxHealth * 0.50) //Between maxHealth and about a third of maxHealth, between 30 and 10 for normal drones
			. += span_warning("Its screws are slightly loose.")
		else //otherwise, below about 33%
			. += span_boldwarning("Its screws are very loose!")

	if(stat == DEAD)
		if(client)
			. += span_deadsay("A message repeatedly flashes on its display: \"MULTITOOL -- REQUIRED\".")
		else
			. += span_deadsay("A message repeatedly flashes on its display: \"ERROR -- OFFLINE\".")
	. += "*---------*</span>"

/mob/living/simple_animal/advanced/hivebot/attackby(obj/item/I, mob/user)
	. = ..()
	if(istype(I, /obj/item/screwdriver) && stat != DEAD)
		if(health < maxHealth)
			to_chat(user, span_notice("You start to tighten loose screws on [src]..."))
			if(I.use_tool(src, user, 20))
				adjustBruteLoss(-getBruteLoss())
				visible_message(span_notice("[user] tightens [src == user ? "[user.p_their()]" : "[src]'s"] loose screws!"), span_notice("You tighten [src == user ? "your" : "[src]'s"] loose screws."))
			else
				to_chat(user, span_warning("You need to remain still to tighten [src]'s screws!"))
		else
			to_chat(user, span_warning("[src]'s screws can't get any tighter!"))
		return //This used to not exist and drones who repaired themselves also stabbed the shit out of themselves.

/mob/living/simple_animal/advanced/hivebot/attackby(obj/item/I, mob/user)
	. = ..()
	if(istype(I, /obj/item/multitool) && stat == DEAD)
		try_reactivating(user)

/mob/living/simple_animal/advanced/hivebot/proc/try_reactivating(mob/living/user)
	/*var/mob/dead/observer/G = get_ghost()
	if(!client && (!G || !G.client))
		var/list/faux_gadgets = list("hypertext inflator","failsafe directory","DRM switch","stack initializer",\
									"anti-freeze capacitor","data stream diode","TCP bottleneck","supercharged I/O bolt",\
									"tradewind stabilizer","radiated XML cable","registry fluid tank","open-source debunker")

		var/list/faux_problems = list("won't be able to tune their bootstrap projector","will constantly remix their binary pool"+\
									  " even though the BMX calibrator is working","will start leaking their XSS coolant",\
									  "can't tell if their ethernet detour is moving or not", "won't be able to reseed enough"+\
									  " kernels to function properly","can't start their neurotube console")

		to_chat(user, span_warning("You can't seem to find the [pick(faux_gadgets)]! Without it, [src] [pick(faux_problems)]."))
		return*/
	user.visible_message(span_notice("[user] begins to reactivate [src]."), span_notice("You begin to reactivate [src]..."))
	if(do_after(user, 130, 1, target = src))
		revive(full_heal = 1)
		user.visible_message(span_notice("[user] reactivates [src]!"), span_notice("You reactivate [src]."))
		/*if(G)
			to_chat(G, span_ghostalert("You([name]) were reactivated by [user]!"))*/
	else
		to_chat(user, span_warning("You need to remain still to reactivate [src]!"))

/mob/living/simple_animal/advanced/thicktron_s
	name = "Modified Assaultron"
	desc = "Why is it so thick?"
	icon = 'icons/mob/splurtbot.dmi'
	rotate_on_lying = TRUE
	icon_state = "assaultronstandard"
	icon_living = "assaultronstandard"
	icon_dead = "assaultronstandard_dead"

//End Advanced Mobs//

// Start Pets //

/mob/living/simple_animal/pet/mothroach
	name = "mothroach"
	desc = "This is the adorable by-product of multiple attempts at genetically mixing mothpeople with cockroaches."
	icon = 'icons/mob/animal.dmi'
	icon_state = "mothroach"
	icon_living = "mothroach"
	icon_dead = "mothroach_dead"
	var/held_icon = "mothroach"

/mob/living/simple_animal/pet/mothroach/tox
	name = "Fluffy"
	desc = "A adorably fluffy mothroach. This moth roach seems to have a collar on its neck, the tag reading 'Fluffy Mckit. If found, return to Tox Mckit'. What a fluffy fella!"
	icon = 'icons/mob/animal.dmi'
	icon_state = "mothroach"
	icon_living = "mothroach"
	icon_dead = "mothroach_dead"
	speak = list("Squee","Squeak-squeak-squeak","squeak","Chitters","Momf")
	speak_emote = list("chitters", "squeaks")
	emote_hear = list("chitters.", "squeaks")
	emote_see = list("tilts its head", "flutters its wings" , "does a little dance")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "punts"
	response_harm_simple = "punt"
	maxHealth = 200
	health = 200
	mob_armor = ARMOR_VALUE_LIGHT
	healable = 1
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	harm_intent_damage = 2
	melee_damage_lower = 2
	melee_damage_upper = 5
	dextrous = TRUE
	dextrous_hud_type = /datum/hud/dextrous/drone
	held_items = list(null, null)
	healable = 1

/mob/living/simple_animal/pet/pony
	name = "pony"
	desc = "A cute fluffy pony"
	icon = 'icons/mob/animal.dmi'
	icon_state = "pony"
	icon_living = "pony"
	icon_dead = "pony_dead"

/mob/living/simple_animal/pet/giraffe
	name = "giraffe"
	desc = "A long necked goat"
	icon = 'modular_coyote/icons/mob/giraffe.dmi'
	icon_state = "giraffe"
	icon_living = "giraffe"
	icon_dead = "giraffe_dead"

/mob/living/simple_animal/advanced/kirin
	name = "teal kirin"
	desc = "A mythical type of creature."
	icon = 'modular_coyote/icons/mob/kirin.dmi'
	icon_state = "teal_kirin"
	icon_living = "teal_kirin"
	icon_dead = "teal_kirin_dead"

/mob/living/simple_animal/advanced/kirin/white
	name = "white kirin"
	desc = "A mythical type of creature."
	icon = 'modular_coyote/icons/mob/kirin.dmi'
	icon_state = "white_kirin"
	icon_living = "white_kirin"
	icon_dead = "white_kirin_dead"

/mob/living/simple_animal/advanced/kirin/purple
	name = "purple kirin"
	desc = "A mythical type of creature."
	icon = 'modular_coyote/icons/mob/kirin.dmi'
	icon_state = "purple_kirin"
	icon_living = "purple_kirin"
	icon_dead = "purple_kirin_dead"

/mob/living/simple_animal/advanced/greycat
	name = "fluffy cat"
	desc = "a fluffy grey and white cat."
	icon = 'modular_coyote/icons/mob/cat.dmi'
	icon_state = "grey_white"
	icon_living = "grey_white"
	icon_dead = "grey_white_dead"

/mob/living/simple_animal/advanced/greycat/Initialize()
    .=..()
    resize = 0.5
    update_transform()



