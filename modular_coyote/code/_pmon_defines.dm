// Should make these into bitflags later if we want to use them for realsies
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


///Creatures that players can select for creature characters. Exclude mobs by giving them the P_TRAIT_BLACKLIST trait (see Bud for example).
GLOBAL_LIST_EMPTY(creature_selectable)
///The same list, but with preview icons instead of typepaths
GLOBAL_LIST_EMPTY(creature_selectable_icons)

/proc/generate_selectable_creatures(clear = FALSE)
	if(clear)
		GLOB.creature_selectable = list()
	for(var/I in subtypesof(/mob/living/simple_animal/advanced))
		var/mob/living/simple_animal/advanced/P = I
		if(initial(P.is_blacklisted))
			continue
		var/list/traits = initial(P.p_traits)
		if(!(P_TRAIT_BLACKLIST in traits))//Not blacklisted from being added to the list
			GLOB.creature_selectable[capitalize("[initial(P.name)]")] = P
			GLOB.creature_selectable_icons[capitalize("[initial(P.name)]")] = icon(initial(P.icon), initial(P.icon_living), frame = 1, moving = FALSE)
		continue
	for(var/T in GLOB.creature_whitelist)
		var/mob/living/simple_animal/SA = T
		GLOB.creature_selectable[capitalize(initial(SA.name))] = T
		GLOB.creature_selectable_icons[capitalize("[initial(SA.name)]")] = icon(initial(SA.icon), initial(SA.icon_living), frame = 1, moving = FALSE)

///List of all pokemon on the whole map.
GLOBAL_LIST_EMPTY(advanced_mob_list)

///List of available spawnpoints for creatures to choose from when spawning
GLOBAL_LIST_INIT(creature_spawnpoints, list(
	"New Boston" = /obj/effect/landmark/start/f13/settler,
	"Wasteland" = /obj/effect/landmark/start/f13/wastelander,
	"Ashdown" = /obj/effect/landmark/start/f13/ashdown
	))

///Creatures that should be added to the playable creature list.
///DO NOT ADD MOBS HERE UNLESS THEY ARE SUBTYPES OF /mob/living/simple_animal/advanced. CATSLUGS CAN STAY BECAUSE THEY ARE BASICALLY ALREADY ADVANCED MOBS.
GLOBAL_LIST_INIT(creature_whitelist, list(
	/mob/living/simple_animal/pet/catslug
	))
///DO NOT ADD MOBS HERE UNLESS THEY ARE SUBTYPES OF /mob/living/simple_animal/advanced. CATSLUGS CAN STAY BECAUSE THEY ARE BASICALLY ALREADY ADVANCED MOBS.
