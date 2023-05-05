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
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 10, /obj/item/stack/sheet/bone = 6, /obj/item/reagent_containers/food/snacks/meat/rawbacon = 8)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/bone = 2,)
	butcher_difficulty = 1

/mob/living/simple_animal/hostile/hellpig/Initialize()
	. = ..()
	recenter_wide_sprite()

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
	aggrosound = list('sound/alien/Voice/growl1.ogg', 'sound/alien/Voice/growl3.ogg', )
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
