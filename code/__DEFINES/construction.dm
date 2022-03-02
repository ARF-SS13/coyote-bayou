/*ALL DEFINES RELATED TO CONSTRUCTION, CONSTRUCTING THINGS, OR CONSTRUCTED OBJECTS GO HERE*/

//Defines for construction states

//girder construction states
#define GIRDER_NORMAL 0
#define GIRDER_REINF_STRUTS 1
#define GIRDER_REINF 2
#define GIRDER_DISPLACED 3
#define GIRDER_DISASSEMBLED 4

//rwall construction states
#define INTACT 0
#define SUPPORT_LINES 1
#define COVER 2
#define CUT_COVER 3
#define ANCHOR_BOLTS 4
#define SUPPORT_RODS 5
#define SHEATH 6

//window construction states
#define WINDOW_OUT_OF_FRAME 0
#define WINDOW_IN_FRAME 1
#define WINDOW_SCREWED_TO_FRAME 2

//airlock assembly construction states
#define AIRLOCK_ASSEMBLY_NEEDS_WIRES 0
#define AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS 1
#define AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER 2

//default_unfasten_wrench() return defines
#define CANT_UNFASTEN 0
#define FAILED_UNFASTEN 1
#define SUCCESSFUL_UNFASTEN 2

//ai core defines
#define EMPTY_CORE 0
#define CIRCUIT_CORE 1
#define SCREWED_CORE 2
#define CABLED_CORE 3
#define GLASS_CORE 4
#define AI_READY_CORE 5

//Construction defines for the pinion airlock
#define GEAR_SECURE 1
#define GEAR_LOOSE 2

//floodlights because apparently we use defines now
#define FLOODLIGHT_NEEDS_WIRES 0
#define FLOODLIGHT_NEEDS_LIGHTS 1
#define FLOODLIGHT_NEEDS_SECURING 2
#define FLOODLIGHT_NEEDS_WRENCHING 3

//other construction-related things

//windows affected by Nar'Sie turn this color.
#define NARSIE_WINDOW_COLOUR "#7D1919"

//let's just pretend fulltile windows being children of border windows is fine
#define FULLTILE_WINDOW_DIR NORTHEAST

//The maximum size of a stack object.
#define MAX_STACK_SIZE 50
//maximum amount of cable in a coil
#define MAXCOIL 30

//tablecrafting defines
#define CAT_NONE	""
#define CAT_WEAPONRY	"Weaponry"
#define CAT_WEAPON	"Ranged Weapons"
#define CAT_MELEE	"Melee Weapons"
#define CAT_AMMO	"Ammo & Cells"
#define CAT_MISCWEP	"Weapons Misc"
#define CAT_PARTS	"Weapon Parts"
#define CAT_CRAFTING	"Crafting"
#define CAT_ROBOT	"Electronics & Robots"
#define CAT_FORGING	"Forging & Smithing"
#define CAT_MISC	"Misc"
#define CAT_SCAVENGING	"Scavenging & Tinkering"
#define CAT_MISCELLANEOUS	"Miscellaneous"
#define CAT_TOOL	"Tools & Workbench"
#define CAT_FURNITURE	"Burial & Execution"
#define CAT_FARMING	"Farming"
#define CAT_PRIMAL	"Primal"
#define CAT_TRIBAL "Tribal"
#define CAT_CLOTHING	"Clothing"
#define CAT_FOOD	"Foods"
#define CAT_WASTEFOOD	"Food Wasteland"
#define CAT_BREAD	"Food Bread"
#define CAT_BURGER	"Food Old World"
#define CAT_CAKE	"Food Cakes"
#define CAT_DONUT	"Food Donuts"
#define CAT_EGG	"Food Egg-Based"
#define CAT_MEAT	"Food Meats"
#define CAT_MEXICAN	"Food Mexican"
#define CAT_MISCFOOD	"Food Misc"
#define CAT_PASTRY	"Food Pastries"
#define CAT_PIE	"Food Pies & Sweets"
#define CAT_PIZZA	"Food Pizzas"
#define CAT_SALAD	"Food Salads"
#define CAT_SEAFOOD	"Food Seafood"
#define CAT_SANDWICH	"Food Sandwiches"
#define CAT_SOUP	"Food Soups"
#define CAT_SPAGHETTI	"Food Spaghettis"
#define CAT_ICE	"Food Frozen"
#define CAT_MEDICAL "Medical"
#define CAT_BOTTLE "Bottling"
#define CAT_GENCLOTHES "General Clothing"
#define CAT_ARMOR "Armor"
#define CAT_BELTS	"Belts"
#define CAT_WASTELAND	"Wasteland Clothing"
#define CAT_SHOES "Shoes"
#define CAT_MISCCLOTHING "Misc Clothing"
#define CAT_DRINK "Drinks"
#define CAT_EXPLOSIVE "Explosives"

#define RCD_FLOORWALL 1
#define RCD_AIRLOCK 2
#define RCD_DECONSTRUCT 3
#define RCD_WINDOWGRILLE 4
#define RCD_MACHINE 8
#define RCD_COMPUTER 16

#define RCD_UPGRADE_FRAMES 1
#define RCD_UPGRADE_SIMPLE_CIRCUITS 2

//Electrochromatic window defines.
#define NOT_ELECTROCHROMATIC		0
#define ELECTROCHROMATIC_OFF		1
#define ELECTROCHROMATIC_DIMMED		2
