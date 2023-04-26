#define ispokemon(A)		istype(A, /mob/living/simple_animal/pokemon)

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
GLOBAL_LIST_EMPTY(pokemon_spawnable)
//List of all pokemon on the whole map.
GLOBAL_LIST_EMPTY(pokemon_list)
//List of available spawnpoints for pokemon to choose from
GLOBAL_LIST_EMPTY(pokemon_spawnpoints)
