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
	aggrosound = list('sound/f13npc/deathclaw/aggro1.ogg', 'sound/f13npc/deathclaw/aggro2.ogg', )
	idlesound = list('sound/f13npc/deathclaw/idle.ogg',)
	death_sound = list('sound/f13npc/hellpig/hellpigdead.ogg',)
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 10, /obj/item/stack/sheet/bone = 6,)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/bone = 2,)
	butcher_difficulty = 1

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
	maxHealth = 100
	health = 100
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
	held_items = list(null, null)
	see_in_dark = 8
	can_ghost_into = TRUE

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

//Slugcat OC for thingpony
/mob/living/simple_animal/pet/catslug/meadow
	name = "Meadow"
	desc = "A noodly creature with soft looking fur. This one has orange and black patches upon it's white fur! (OOC notes : Fine with most Rp! No snuff or scat) Ref: https://cdn.discordapp.com/attachments/986783005743923230/1071899061919166624/Meadow.png"
	icon_state = "calicoslug"
	icon_living = "calicoslug"
	icon_dead = "calicoslug_dead"
	gender = "female"

/mob/living/simple_animal/pet/catslug/shroomslug
	name = "Myca Rashee"
	desc = "A slugcat that seems to be idly sitting there their fur seems a bit odd to look at as they give off a odd glow from the mushroom cap on their head. They seem somewhat timid and shy? Their seems to be fungal growths along the blanket of moss on their body..https://media.discordapp.net/attachments/1020998258669129758/1025891405605912626/cosmic_mushroom_cat_1_1.png?width=773&height=805"
	icon_state = "shroomslug"
	icon_living = "shroomslug"
	icon_dead = "shroomslug_dead"
	gender = "plural"
	light_color ="#728FCE"
	light_range = 1.4
	light_power = 4


//Pokemon!

/mob/living/simple_animal/pet/pokemon
	name = "eevee"
	desc = "It has the ability to alter the composition of its body to suit its surrounding environment."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "eevee"
	icon_living = "eevee"
	icon_dead = "eevee_d"
	unsuitable_atmos_damage = 0
	minbodytemp = TCMB
	maxbodytemp = T0C + 40
	health = 200
	maxHealth = 200
	healable = 1
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "bops"
	response_disarm_simple = "bop"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "nuzzles"
	attack_verb_simple = "nuzzle"

/mob/living/simple_animal/pet/pokemon/update_mobility()
	. = ..()
	if(client && stat != DEAD)
		if(!CHECK_MOBILITY(src, MOBILITY_STAND))
			icon_state = "[icon_living]_rest"
			collar_type = "[initial(collar_type)]_rest"
		else
			icon_state = "[icon_living]"
			collar_type = "[initial(collar_type)]"
	regenerate_icons()

/mob/living/simple_animal/pet/pokemon/eevee
	name = "Eevee"
	desc = "It has the ability to alter the composition of its body to suit its surrounding environment."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "eevee"
	icon_living = "eevee"
	icon_dead = "eevee_d"

/mob/living/simple_animal/pet/pokemon/vaporeon
	name = "Vaporeon"
	desc = "Lives close to water. Its long tail is ridged with a fin which is often mistaken for a mermaid's."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "vaporeon"
	icon_living = "vaporeon"
	icon_dead = "vaporeon_d"

/mob/living/simple_animal/pet/pokemon/glaceon
	name = "Glaceon"
	desc = "As a protective technique, it can completely freeze its fur to make its hairs stand like needles."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "glaceon"
	icon_living = "glaceon"
	icon_dead = "glaceon_d"

/mob/living/simple_animal/pet/pokemon/leafeon
	name = "Leafeon"
	desc = "Just like a plant, it uses photosynthesis. As a result, it is always enveloped in clear air."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "leafeon"
	icon_living = "leafeon"
	icon_dead = "leafeon_d"

/mob/living/simple_animal/pet/pokemon/flareon
	name = "Flareon"
	desc = "When storing thermal energy in its body, its temperature could soar to over 1600 degrees."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "flareon"
	icon_living = "flareon"
	icon_dead = "flareon_d"

/mob/living/simple_animal/pet/pokemon/jolteon
	name = "Jolteon"
	desc = "It accumulates negative ions in the atmosphere to blast out 10000-volt lightning bolts."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "jolteon"
	icon_living = "jolteon"
	icon_dead = "jolteon_d"

/mob/living/simple_animal/pet/pokemon/sylveon
	name = "Sylveon"
	desc = "It sends a soothing aura from its ribbonlike feelers to calm fights."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "sylveon"
	icon_living = "sylveon"
	icon_dead = "sylveon_d"

/mob/living/simple_animal/pet/pokemon/espeon
	name = "Espeon"
	desc = "It uses the fine hair that covers its body to sense air currents and predict its enemy's actions."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "espeon"
	icon_living = "espeon"
	icon_dead = "espeon_d"

/mob/living/simple_animal/pet/pokemon/umbreon
	name = "Umbreon"
	desc = "When agitated, this Pokémon protects itself by spraying poisonous sweat from its pores."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "umbreon"
	icon_living = "umbreon"
	icon_dead = "umbreon_d"

/mob/living/simple_animal/pet/pokemon/absol
	name = "Absol"
	desc = "Every time Absol appears before people, it is followed by a disaster such as an earthquake or a tidal wave. As a result, it came to be known as the disaster Pokémon."
	icon = 'modular_coyote/icons/mob/pokemon.dmi'
	icon_state = "absol"
	icon_living = "absol"
	icon_dead = "absol_d"


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
	maxHealth = 300

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
	aggrosound = list('sound/alien/Voice/growl1.ogg', 'sound/alien/Voice/growl3.ogg', )
	idlesound = list('sound/alien/Voice/hiss1.ogg',)

//Dinos

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
