#define isadvancedmob(A)		istype(A, /mob/living/simple_animal/advanced)

#define P_TYPE_FIRE 	"fire"
#define P_TYPE_WATER 	"water"
#define P_TYPE_ICE 		"ice"
#define P_TYPE_FLY 		"flying"
#define P_TYPE_PSYCH 	"psychic"
#define P_TYPE_NORM 	"normal"
#define P_TYPE_DARK 	"dark"
#define P_TYPE_FAIRY	"fairy"
#define P_TYPE_GRASS	"grass"
#define P_TYPE_DRAGON	"dragon"
#define P_TYPE_GROUND	"ground"
#define P_TYPE_ROCK		"rock"
#define P_TYPE_FIGHT	"fighting"
#define P_TYPE_GHOST	"ghost"
#define P_TYPE_STEEL	"steel"
#define P_TYPE_ELEC		"electric"
#define P_TYPE_POISON	"poison"
#define P_TYPE_BUG		"bug"

//A ghost is using their phase move
#define M_GHOSTED		"ghosted"
//Electric types shocking people who touch them
#define M_SHOCK			"shocking"
//A ditto or something similar has transformed to look like something else
#define	M_TF			"transformed"
//Mew can turn invisible, but not ethereal like M_GHOSTED
#define M_INVIS			"invisible"

//Don't spawn this pokemon or show it in lists.
#define P_TRAIT_BLACKLIST	"blacklisted"
//This pokemon can be buckled to, ridden, and steered like a vehicle
#define P_TRAIT_RIDEABLE	"rideable"

//List of pokemon subtypes that a player can choose from when spawning in. Exclude pokemon by giving them the P_TRAIT_BLACKLIST trait.
GLOBAL_LIST_EMPTY(pokemon_selectable)
/proc/generate_selectable_pokemon(clear = FALSE)
	if(clear)
		GLOB.pokemon_selectable = list()
	for(var/I in subtypesof(/mob/living/simple_animal/advanced))
		var/mob/living/simple_animal/advanced/P = I
		var/list/traits = initial(P.p_traits)
		if(!(P_TRAIT_BLACKLIST in traits))//Not blacklisted from being added to the list
			GLOB.pokemon_selectable[capitalize("[initial(P.name)]")] = P

///Creatures that players can select for creature characters
GLOBAL_LIST_EMPTY(creature_selectable)

/proc/generate_selectable_creatures(clear = FALSE)
	if(clear)
		GLOB.creature_selectable = list()
	if(!LAZYLEN(GLOB.pokemon_selectable))//Pokemon list hasn't been generated so do it now
		generate_selectable_pokemon()
 	GLOB.creature_selectable |= GLOB.pokemon_selectable //Merge pokemon into master creature list
	for(var/T in typesof(/mob/living/simple_animal))
		var/mob/living/simple_animal/SA = T
		if(initial(SA.gold_core_spawnable) == FRIENDLY_SPAWN)
			if(!(SA in GLOB.creature_blacklist))
				GLOB.creature_selectable[capitalize(initial(SA.name))] = SA
	for(var/T in GLOB.creature_whitelist)
		var/mob/living/simple_animal/SA = T
		GLOB.creature_selectable[capitalize(initial(SA.name))] = T

///List of all pokemon on the whole map.
GLOBAL_LIST_EMPTY(pokemon_list)

///List of available spawnpoints for creatures to choose from when spawning
GLOBAL_LIST_INIT(creature_spawnpoints, list(
	"Nash" = /obj/effect/landmark/start/f13/settler,
	"Wasteland" = /obj/effect/landmark/start/f13/wastelander
	))

///Creatures that are not allowed for players to select for characters
GLOBAL_LIST_INIT(creature_blacklist, list(
	/mob/living/simple_animal/chick,
	/mob/living/simple_animal/hostile/retaliate/goat,
	/mob/living/simple_animal/cow/random,
	/mob/living/simple_animal/opossum/poppy,
	/mob/living/simple_animal/radstag/rudostag,
	/mob/living/simple_animal/cow/brahmin/nightstalker,
	/mob/living/simple_animal/cow/brahmin/sgtsillyhorn,
	/mob/living/simple_animal/cow/brahmin/calf,
	/mob/living/simple_animal/cow/brahmin,
	/mob/living/simple_animal/cow/brahmin/motorbike,
	/mob/living/simple_animal/cow/brahmin/horse/honse,
	/mob/living/simple_animal/pet/cat/cak,
	/mob/living/simple_animal/pet/cat/kitten,
	/mob/living/simple_animal/pet/bumbles,
	/mob/living/simple_animal/pet/redpanda/stinky,
	/mob/living/simple_animal/pet/fox/paws,
	/mob/living/simple_animal/hostile/asteroid/gutlunch/guthen,
	/mob/living/simple_animal/hostile/asteroid/gutlunch/gubbuck
	))

///Creatures that should be added to the playable creature list. Only put mobs in here if they aren't gold slime core spawnable already.
GLOBAL_LIST_INIT(creature_whitelist, list(
	/mob/living/simple_animal/pet/catslug,
	/mob/living/simple_animal/pet/wolf/direwolf,
	/mob/living/simple_animal/raccoon,
	/mob/living/simple_animal/armadillo,
	/mob/living/simple_animal/pet/kiwi,
	/mob/living/simple_animal/pet/sheep,
	/mob/living/simple_animal/advanced/tenderclawmale,
	/mob/living/simple_animal/advanced/tenderclawfemale,
	/mob/living/simple_animal/advanced/tenderclawherm,
	/mob/living/simple_animal/advanced/nightstalker
	))
