//These birds came from Goon.

/mob/living/simple_animal/bird //the base
	name = "bird"
	desc = "chirp chirp"
	icon = 'modular_coyote/icons/mob/bird.dmi'
	icon_state = "gull"
	icon_living = "gull"
	icon_dead = "gull-dead"
	turns_per_move = 1
	response_help_continuous = "shoos"
	response_help_simple = "shoo"
	response_disarm_continuous = "brushes aside"
	response_disarm_simple = "brush aside"
	response_harm_continuous = "bats"
	response_harm_simple = "bat"
	speak_emote = list("chrips")
	maxHealth = 20
	health = 20
	harm_intent_damage = 5
	friendly_verb_continuous = "nudges"
	friendly_verb_simple = "nudge"
	density = FALSE
	movement_type = FLYING
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BUG
//	gold_core_spawnable = FRIENDLY_SPAWN
	verb_say = "chirps"
	verb_ask = "chirps inquisitively"
	verb_exclaim = "chirps intensely"
	verb_yell = "chirps intensely"
	idlesound = list(
		'sound/f13ambience/bird_1.ogg',
		'sound/f13ambience/bird_2.ogg',
		'sound/f13ambience/bird_3.ogg',
		'sound/f13ambience/bird_4.ogg',
		'sound/f13ambience/bird_5.ogg',
		'sound/f13ambience/bird_6.ogg',
		'sound/f13ambience/bird_7.ogg',
		'sound/f13ambience/bird_8.ogg',
	)




/mob/living/simple_animal/bird/Initialize()
	.=..()
	resize = 0.5
	update_transform()

/mob/living/simple_animal/bird/redparrot
	name = "red parrot"
	desc = "A red parrot!"
	icon_state = "parrot"
	icon_living = "parrot"
	icon_dead = "parrot-dead"

/mob/living/simple_animal/bird/kea
	name = "kea"
	desc = "Not to be confused with the car brand, it's a kea!"
	icon_state = "kea"
	icon_living = "kea"
	icon_dead = "kea-dead"

/mob/living/simple_animal/bird/eclectus
	name = "eclectus"
	gender = "male"
	desc = "A eclectus bird!"
	icon_state = "eclectus"
	icon_living = "eclectus"
	icon_dead = "eclectus-dead"

/mob/living/simple_animal/bird/eclectusf
	name = "female eclectus"
	gender = "female"
	desc = "A eclectus bird! This one is a female judging by the blue and red."
	icon_state = "eclectusf"
	icon_living = "eclectusf"
	icon_dead = "eclectusf-dead"

/mob/living/simple_animal/bird/agrey
	name = "grey parrot"
	desc = "A grey parrot!"
	icon_state = "agrey"
	icon_living = "agrey"
	icon_dead = "agrey-dead"

/mob/living/simple_animal/bird/bcaique
	name = "caique"
	desc = "A caique"
	icon_state = "bcaique"
	icon_living = "bcaique"
	icon_dead = "bcaique-dead"

/mob/living/simple_animal/bird/wcaique
	name = "caique"
	desc = "A caique"
	icon_state = "wcaique"
	icon_living = "wcaique"
	icon_dead = "wcaique-dead"

/mob/living/simple_animal/bird/gbudge
	name = "green budgie"
	desc = "A green budgie!"
	icon_state = "gbudge"
	icon_living = "gbudge"
	icon_dead = "gbudge-dead"

/mob/living/simple_animal/bird/bbudge
	name = "blue budgie"
	desc = "A blue budgie!"
	icon_state = "bbudge"
	icon_living = "bbudge"
	icon_dead = "bbudge-dead"

/mob/living/simple_animal/bird/bgbudge
	name = "blue green budgie"
	desc = "A blue and green budgie!"
	icon_state = "bgbudge"
	icon_living = "bgbudge"
	icon_dead = "bgbudge-dead"

/mob/living/simple_animal/bird/commonblackbird
	name = "common black bird"
	desc = "Black bird singing in the dead of night."
	icon_state = "commonblackbird"
	icon_living = "commonblackbird"
	icon_dead = "commonblackbird-dead"

/mob/living/simple_animal/bird/azuretit
	name = "azure tit"
	desc = "What an absurd tit!"
	icon_state = "azuretit"
	icon_living = "azuretit"
	icon_dead = "azuretit-dead"

/mob/living/simple_animal/bird/europeanrobin
	name = "european robin"
	desc = "This robin probably drinks tea and calls fries chips. Weird."
	icon_state = "europeanrobin"
	icon_living = "europeanrobin"
	icon_dead = "europeanrobin-dead"

/mob/living/simple_animal/bird/goldcrest
	name = "goldcrest"
	desc = "A gold crusted bird? Oh no, it's just a goldcrest."
	icon_state = "goldcrest"
	icon_living = "goldcrest"
	icon_dead = "goldcrest-dead"

/mob/living/simple_animal/bird/ringneckdove
	name = "ringneck dove"
	desc = "Coo coo, it's a dove!"
	icon_state = "ringneckdove"
	icon_living = "ringneckdove"
	icon_dead = "ringneckdove-dead"

/mob/living/simple_animal/bird/tiel
	name = "Cockatiel"
	desc = "It's a cock-a-teal!"
	icon_state = "tiel"
	icon_living = "tiel"
	icon_dead = "tiel-dead"

/mob/living/simple_animal/bird/wtiel
	name = "Cockatiel"
	desc = "It's a white cock-a-teal!"
	icon_state = "wtiel"
	icon_living = "wtiel"
	icon_dead = "wtiel-dead"

/mob/living/simple_animal/bird/luttiel
	name = "yellow headed cockatiel"
	desc = "It's a yellow and white cock-a-teal!"
	icon_state = "luttiel"
	icon_living = "luttiel"
	icon_dead = "luttiel-dead"

/mob/living/simple_animal/bird/blutiel
	name = "blue cockatiel"
	desc = "It's a blue cock-a-teal!"
	icon_state = "blutiel"
	icon_living = "blutiel"
	icon_dead = "blutiel-dead"

/mob/living/simple_animal/bird/too
	name = "Cockatoo"
	desc = "It's cock-a-too!"
	icon_state = "too"
	icon_living = "too"
	icon_dead = "too-dead"

/mob/living/simple_animal/bird/utoo
	name = "Umbrella Cockatoo"
	desc = "It's a umbrella cock-a-too, ready for rain!"
	icon_state = "utoo"
	icon_living = "utoo"
	icon_dead = "utoo-dead"

/mob/living/simple_animal/bird/mtoo
	name = "pink Cockatoo"
	desc = "It's a pink cock-a-too"
	icon_state = "mtoo"
	icon_living = "mtoo"
	icon_dead = "mtoo-dead"

/mob/living/simple_animal/bird/toucan
	name = "toucan"
	desc = "You can? toucan!"
	icon_state = "toucan"
	icon_living = "toucan"
	icon_dead = "toucan-dead"

/mob/living/simple_animal/bird/kbtoucan
	name = "toucan"
	desc = "You can? toucan!"
	icon_state = "kbtoucan"
	icon_living = "kbtoucan"
	icon_dead = "kbtoucan-dead"

/mob/living/simple_animal/bird/ikea
	name = "ikea"
	desc = "It's a bird!"
	icon_state = "ikea"
	icon_living = "ikea"
	icon_dead = "ikea-dead"

/mob/living/simple_animal/bird/goose
	name = "goose"
	desc = "It's a bird!"
	icon_state = "goose"
	icon_living = "goose"
	icon_dead = "goose-dead"

/mob/living/simple_animal/bird/gull
	name = "gull"
	desc = "It's a bird!"
	icon_state = "gull"
	icon_living = "gull"
	icon_dead = "gull-dead"

/mob/living/simple_animal/bird/smallowl
	name = "small owl"
	desc = "It's a bird!"
	icon_state = "smallowl"
	icon_living = "smallowl"
	icon_dead = "smallowl-dead"

/mob/living/simple_animal/bird/owl
	name = "owl"
	desc = "It's a bird!"
	icon_state = "owl"
	icon_living = "owl"
	icon_dead = "owl-dead"

/mob/living/simple_animal/bird/hooty
	name = "owl"
	desc = "It's a bird!"
	icon_state = "hooty"
	icon_living = "hooty"
	icon_dead = "hooty-dead"

/mob/living/simple_animal/bird/then
	name = "turkey hen"
	desc = "It's a bird!"
	icon_state = "then"
	icon_living = "then"
	icon_dead = "then-dead"

/mob/living/simple_animal/bird/ttom
	name = "turkey tom"
	desc = "It's a bird!"
	icon_state = "ttom"
	icon_living = "ttom"
	icon_dead = "ttom-dead"

/mob/living/simple_animal/bird/gannet
	name = "gannet"
	desc = "It's a bird!"
	icon_state = "gannet"
	icon_living = "gannet"
	icon_dead = "gannet-dead"

/mob/living/simple_animal/bird/love
	name = "love bird"
	desc = "It's a bird!"
	icon_state = "love"
	icon_living = "love"
	icon_dead = "love-dead"

/mob/living/simple_animal/bird/loveyellow
	name = "love bird"
	desc = "It's a bird!"
	icon_state = "lovey"
	icon_living = "lovey"
	icon_dead = "lovey-dead"

/mob/living/simple_animal/bird/lovemale
	name = "love bird"
	desc = "It's a bird!"
	icon_state = "lovem"
	icon_living = "lovem"
	icon_dead = "lovem-dead"

/mob/living/simple_animal/bird/loveblue
	name = "love bird"
	desc = "It's a bird!"
	icon_state = "loveb"
	icon_living = "loveb"
	icon_dead = "loveb-dead"

/mob/living/simple_animal/bird/lovefemale
	name = "love bird"
	desc = "It's a bird!"
	icon_state = "lovef"
	icon_living = "lovef"
	icon_dead = "lovef-dead"

/mob/living/simple_animal/bird/crow
	name = "crow"
	desc = "It's a bird!"
	icon_state = "crow"
	icon_living = "crow"
	icon_dead = "crow-dead"
	idlesound = list(
		'sound/f13ambience/crow_1.ogg',
		'sound/f13ambience/crow_2.ogg',
	)

/mob/living/simple_animal/bird/doodle
	name = "doodle"
	desc = "It's a bird!"
	icon_state = "doodle"
	icon_living = "doodle"
	icon_dead = "doodle-dead"

/mob/living/simple_animal/bird/swan
	name = "swan"
	desc = "It's a bird!"
	icon_state = "swan"
	icon_living = "swan"
	icon_dead = "swan-dead"

/mob/living/simple_animal/bird/cassowary
	name = "cassowary"
	desc = "It's a bird!"
	icon_state = "cassowary"
	icon_living = "cassowary"
	icon_dead = "cassowary-dead"
