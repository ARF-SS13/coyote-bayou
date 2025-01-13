//How to balance this table
//-------------------------
//The total added weight of all the entries should be (roughly) equal to the total number of lootdrops
//(take in account those that spawn more than one object!)
//
//While this is random, probabilities tells us that item distribution will have a tendency to look like
//the content of the weighted table that created them.
//The less lootdrops, the less even the distribution.
//
//If you want to give items a weight <1 you can multiply all the weights by 10
//
//the "" entry will spawn nothing, if you increase this value,
//ensure that you balance it with more spawn points

//table data:
//-----------
//aft maintenance: 		24 items, 18 spots 2 extra (28/08/2014)
//asmaint: 				16 items, 11 spots 0 extra (08/08/2014)
//asmaint2:			 	36 items, 26 spots 2 extra (28/08/2014)
//fpmaint:				5  items,  4 spots 0 extra (08/08/2014)
//fpmaint2:				12 items, 11 spots 2 extra (28/08/2014)
//fsmaint:				0  items,  0 spots 0 extra (08/08/2014)
//fsmaint2:				40 items, 27 spots 5 extra (28/08/2014)
//maintcentral:			2  items,  2 spots 0 extra (08/08/2014)
//port:					5  items,  5 spots 0 extra (08/08/2014)

GLOBAL_LIST_INIT(maintenance_loot, list(
	/obj/item/bodybag = 1,
	/obj/item/clothing/glasses/meson = 2,
	/obj/item/clothing/glasses/sunglasses = 1,
	/obj/item/clothing/gloves/color/fyellow = 1,
	/obj/item/clothing/head/hardhat = 1,
	/obj/item/clothing/head/hardhat/red = 1,
	/obj/item/clothing/head/that = 1,
	/obj/item/clothing/head/ushanka = 1,
	/obj/item/clothing/head/welding = 1,
	/obj/effect/spawner/lootdrop/breathing_masks = 15,
	/obj/item/clothing/suit/hazardvest = 1,
	/obj/item/clothing/under/misc/vice_officer = 1,
	/obj/item/clothing/suit/hooded/flashsuit = 2,
	/obj/item/clothing/accessory/medal/greytide	=	1,
	/obj/item/assembly/prox_sensor = 4,
	/obj/item/assembly/timer = 3,
	/obj/item/flashlight = 4,
	/obj/item/flashlight/pen = 1,
	/obj/effect/spawner/lootdrop/glowstick = 4,
	/obj/effect/spawner/lootdrop/mre = 3,
	/obj/item/multitool = 2,
	/obj/item/radio/off = 2,
	/obj/item/t_scanner = 5,
	/obj/item/airlock_painter = 1,
	/obj/item/stack/cable_coil/random = 4,
	/obj/item/stack/cable_coil/random/five = 6,
	/obj/item/stack/medical/suture = 1,
	/obj/item/stack/rods/ten = 9,
	/obj/item/stack/rods/twentyfive = 1,
	/obj/item/stack/rods/fifty = 1,
	/obj/item/stack/sheet/cardboard = 2,
	/obj/item/stack/sheet/metal/twenty = 1,
	/obj/item/stack/sheet/mineral/plasma = 1,
	/obj/item/stack/sheet/rglass = 1,
	/obj/item/book/manual/wiki/engineering_construction = 1,
	/obj/item/book/manual/wiki/engineering_hacking = 1,
	/obj/item/clothing/head/cone = 1,
	/obj/item/coin/silver = 1,
	/obj/item/coin/twoheaded = 1,
	/obj/item/poster/random_contraband = 1,
	/obj/item/poster/random_official = 1,
	/obj/item/crowbar = 1,
	/obj/item/crowbar/red = 1,
	/obj/item/extinguisher = 11,
	/obj/item/hand_labeler = 1,
	/obj/item/paper/crumpled = 1,
	/obj/item/pen = 1,
	/obj/item/reagent_containers/spray/pestspray = 1,
	/obj/item/reagent_containers/rag = 3,
	/obj/item/stock_parts/cell = 3,
	/obj/item/storage/belt/utility = 2,
	/obj/item/storage/box = 2,
	/obj/item/storage/box/cups = 1,
	/obj/item/storage/box/donkpockets = 1,
	/obj/item/storage/box/lights/mixed = 3,
	/obj/item/storage/box/hug/medical = 1,
	/obj/item/storage/fancy/cigarettes/dromedaryco = 1,
	/obj/item/storage/toolbox/mechanical = 1,
	/obj/item/screwdriver = 3,
	/obj/item/tank/internals/emergency_oxygen = 2,
	/obj/item/vending_refill/cola = 1,
	/obj/effect/spawner/lootdrop/welder_tools = 3,
	/obj/effect/spawner/lootdrop/low_tools = 5,
	/obj/item/relic = 3,
	/obj/item/weaponcrafting/improvised_parts/shotgun_receiver = 2,
	/obj/item/clothing/head/cone = 2,
	/obj/item/grenade/smokebomb = 2,
	/obj/item/geiger_counter = 3,
	/obj/item/reagent_containers/food/snacks/grown/citrus/orange = 1,
	/obj/item/radio/headset = 1,
	/obj/item/assembly/infra = 1,
	/obj/item/assembly/igniter = 2,
	/obj/item/assembly/signaler = 2,
	/obj/item/assembly/mousetrap = 2,
	/obj/item/reagent_containers/syringe = 2,
	/obj/effect/spawner/lootdrop/gloves = 8,
	/obj/item/clothing/shoes/laceup = 1,
	/obj/item/storage/secure/briefcase = 3,
	/obj/item/storage/toolbox/artistic = 2,
	/obj/item/toy/eightball = 1,
	/obj/item/reagent_containers/pill/floorpill = 1,
	/obj/item/reagent_containers/food/snacks/cannedpeaches/maint = 2,
//	/obj/item/clothing/shoes/wheelys = 1,
	/obj/item/clothing/shoes/kindleKicks = 1,
	/obj/item/storage/box/marshmallow = 2,
	/obj/item/clothing/gloves/tackler/offbrand = 1,
	/obj/item/stack/sticky_tape = 1,
	"" = 3
	))

GLOBAL_LIST_INIT(ratking_trash, list(//Garbage: used by the regal rat mob when spawning garbage.
			/obj/item/cigbutt,
			/obj/item/trash/cheesie,
			/obj/item/trash/candy,
			/obj/item/trash/chips,
			/obj/item/trash/pistachios,
			/obj/item/trash/plate,
			/obj/item/trash/popcorn,
			/obj/item/trash/raisins,
			/obj/item/trash/sosjerky,
			/obj/item/trash/syndi_cakes))

GLOBAL_LIST_INIT(ratking_coins, list(//Coins: Used by the regal rat mob when spawning coins.
			/obj/item/coin/iron,
			/obj/item/coin/silver,
			/obj/item/coin/plastic,
			/obj/item/coin/titanium))

//removed the generic large trash_list, split it into multiple categories
//this means you can create customizable loot tables for trash piles
GLOBAL_LIST_INIT(trash_food, list(
	/obj/item/reagent_containers/food/snacks/f13/bubblegum = 3,
	/obj/item/reagent_containers/food/snacks/f13/bubblegum/large = 3,
	/obj/item/reagent_containers/food/snacks/f13/cram = 3,
	/obj/item/reagent_containers/food/snacks/f13/cram/large = 3,
	/obj/item/reagent_containers/food/snacks/f13/yumyum = 3,
	/obj/item/reagent_containers/food/snacks/f13/fancylads = 3,
	/obj/item/reagent_containers/food/snacks/f13/sugarbombs = 3,
	/obj/item/reagent_containers/food/snacks/f13/crisps = 3,
	/obj/item/reagent_containers/food/snacks/f13/steak = 3,
	/obj/item/reagent_containers/food/snacks/f13/specialapples = 3,
	/obj/item/reagent_containers/food/snacks/f13/dandyapples = 3,
	/obj/item/reagent_containers/food/snacks/f13/blamco = 3,
	/obj/item/reagent_containers/food/snacks/f13/blamco/large = 3,
	/obj/item/reagent_containers/food/snacks/f13/mechanic = 3,
	/obj/item/reagent_containers/food/snacks/f13/instamash = 3,
	/obj/item/reagent_containers/food/snacks/f13/canned/porknbeans = 3,
	/obj/item/reagent_containers/food/snacks/f13/canned/borscht = 3,
	/obj/item/reagent_containers/food/snacks/f13/canned/dog = 3
))

GLOBAL_LIST_INIT(trash_part, list(
	/obj/item/stock_parts/cell = 5,
	/obj/item/stock_parts/capacitor/adv = 5,
	/obj/item/stock_parts/scanning_module/adv = 5,
	/obj/item/stock_parts/manipulator/nano = 5,
	/obj/item/stock_parts/micro_laser/high = 5,
	/obj/item/stock_parts/matter_bin/adv = 5,
	/obj/item/stock_parts/manipulator/pico = 3,
	/obj/item/stock_parts/matter_bin/super = 3,
	/obj/item/stock_parts/cell/high = 3
))

GLOBAL_LIST_INIT(trash_clothing, list(
	/obj/item/clothing/glasses/sunglasses/big = 5,
	/obj/item/clothing/glasses/sunglasses = 5,
	/obj/item/clothing/suit/armor/medium/vest/breastplate/light = 5,
	/obj/item/clothing/head/helmet/knight/f13/rider = 5,
	/obj/item/clothing/shoes/f13/cowboy = 5,
	/obj/item/clothing/shoes/f13/explorer = 5,
	/obj/item/clothing/shoes/f13/diesel = 5,
	/obj/item/clothing/shoes/f13/diesel/alt = 5,
	/obj/item/clothing/gloves/f13/leather = 5,
	/obj/item/clothing/gloves/f13/military = 5,
	/obj/item/clothing/gloves/f13/leather/fingerless = 5,
	/obj/item/clothing/shoes/f13/tan = 5,
	/obj/item/clothing/suit/armor/light/kit/punk = 5,
	/obj/item/clothing/suit/armor/light/kit = 5,
	/obj/item/clothing/head/welding = 5
))

GLOBAL_LIST_INIT(trash_ammo, list(
	/obj/item/ammo_box/a308box/improvised = 2,
	/obj/item/ammo_box/a3006box/improvised = 2,
	/obj/item/ammo_box/m5mmbox/improvised = 1,
	/obj/item/ammo_box/a556/improvised = 3,
	/obj/item/ammo_box/magazine/m10mm/adv/simple = 1,
	/obj/item/ammo_box/c10mm/improvised = 5,
	/obj/item/ammo_box/c9mm/improvised = 5,
	/obj/item/ammo_box/shotgun/improvised = 1,
	/obj/item/ammo_box/a357box/improvised = 3,
	/obj/item/ammo_box/m44box/improvised = 1,
	/obj/item/ammo_box/c45/improvised = 5,
	/obj/item/ammo_box/m14mm/improvised = 1,
	/obj/item/ammo_box/c4570box/improvised = 1,
	/obj/item/ammo_box/m22 = 3,
	/obj/item/ammo_box/rock/improvised = 3
))

GLOBAL_LIST_INIT(trash_chem, list(
	/obj/item/storage/pill_bottle/chem_tin/radx = 10,
	/obj/item/reagent_containers/food/drinks/bottle/orangejuice = 20,
	/obj/item/reagent_containers/food/drinks/bottle/cognac = 10,
	/obj/item/reagent_containers/food/drinks/bottle/whiskey = 20,
	/obj/item/export/bottle/whiskey = 10,
	/obj/item/export/bottle/vodka = 10,
	/obj/item/export/bottle/nukashine = 1,
	/obj/item/reagent_containers/pill/patch/jet = 5,
	/obj/item/reagent_containers/pill/patch/turbo = 1,
	/obj/item/reagent_containers/pill/healingpowder = 10,
	/obj/item/reagent_containers/pill/stimulant = 1,
	/obj/item/reagent_containers/pill/patch/medx = 5,
	/obj/item/storage/pill_bottle/chem_tin/buffout = 5,
	/obj/item/reagent_containers/pill/patch/steady = 5,
	/obj/item/reagent_containers/pill/patch/psycho = 5,
	/obj/item/storage/pill_bottle/chem_tin/mentats = 5,
	/obj/item/storage/pill_bottle/chem_tin/mentats/grape = 1,
	/obj/item/storage/pill_bottle/chem_tin/mentats/orange = 1,
	/obj/item/storage/pill_bottle/chem_tin/mentats/berry = 1,
	/obj/item/reagent_containers/pill/random = 20,
	/obj/item/reagent_containers/pill/patch/random = 5,
	/obj/item/reagent_containers/pill/healingpowder/random = 10,
	/obj/item/reagent_containers/hypospray/medipen/stimpak/random = 20,
	/obj/item/reagent_containers/syringe/random = 20,
	/obj/item/reagent_containers/glass/bottle/random = 10,
	/obj/item/storage/pill_bottle/random = 1,
))

GLOBAL_LIST_INIT(trash_craft, list(
	/obj/item/crafting/duct_tape = 5,
	/obj/item/crafting/abraxo = 5,
	/obj/item/circuitboard/machine/autolathe/ammo/improvised = 5,
	/obj/item/crafting/lunchbox = 5,
	/obj/item/stack/crafting/metalparts/three = 5,
	/obj/item/stack/crafting/electronicparts/three = 5,
	/obj/item/stack/crafting/goodparts = 5
))

GLOBAL_LIST_INIT(trash_gun, list(
	/obj/item/melee/onehanded/machete/scrapsabre = 5,
	/obj/item/melee/onehanded/knife/cosmicdirty = 5,
	/obj/item/melee/onehanded/club/tireiron = 10,
	/obj/item/twohanded/fireaxe/bmprsword = 5,
	/obj/item/melee/onehanded/club = 10,
	/obj/item/twohanded/spear/scrapspear = 10,
	/obj/item/melee/unarmed/lacerator = 5,
	/obj/item/shishkebabpack = 1
))

GLOBAL_LIST_INIT(trash_money, list(
	/obj/item/stack/f13Cash/random/low = 30,
	/obj/item/stack/f13Cash/random/med = 9,
	/obj/item/stack/f13Cash/random/high = 1
))

GLOBAL_LIST_INIT(trash_mob, list(
	/obj/effect/spawner/bundle/mobs/rat/one = 30,
	/obj/effect/spawner/bundle/mobs/rat/three = 9,
	/obj/effect/spawner/bundle/mobs/rat/five = 1
))

GLOBAL_LIST_INIT(trash_tool, list(
	/obj/item/geiger_counter = 5,
	/obj/item/cultivator = 5,
	/obj/item/shovel/spade = 5,
	/obj/item/hatchet = 5,
	/obj/item/scalpel = 5,
	/obj/item/circular_saw = 5,
	/obj/item/surgicaldrill = 5,
	/obj/item/retractor = 5,
	/obj/item/cautery = 5,
	/obj/item/hemostat = 5,
	/obj/item/crowbar = 5,
	/obj/item/flashlight = 5,
	/obj/item/extinguisher = 5,
	/obj/item/multitool = 5,
	/obj/item/analyzer = 5,
	/obj/item/t_scanner = 5,
	/obj/item/weldingtool = 5,
	/obj/item/screwdriver = 5,
	/obj/item/wirecutters = 5,
	/obj/item/wrench = 5,
	/obj/item/stack/cable_coil/random = 5,
	/obj/item/radio/off = 5
))

GLOBAL_LIST_INIT(trash_misc, list(
	/obj/item/pipe = 5,
	/obj/item/trash/f13/electronic/toaster = 5,
	/obj/item/reagent_containers/glass/bucket = 5,
	/obj/item/kitchen/knife = 5,
	/obj/item/kitchen/fork = 5,
	/obj/item/storage/bag/tray = 5,
	/obj/item/reagent_containers/glass/bowl = 5,
	/obj/item/reagent_containers/food/drinks/drinkingglass = 5,
	/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass = 5,
	/obj/item/reagent_containers/glass/beaker = 5,
	/obj/item/reagent_containers/glass/beaker/large = 5,
	/obj/item/taperecorder/empty = 5,
	/obj/item/light/tube = 5,
	/obj/item/light/bulb = 5,
	/obj/item/reagent_containers/syringe = 5,
	/obj/item/restraints/handcuffs = 5,
	/obj/item/toy/crayon/spraycan = 5,
	/obj/item/laser_pointer = 5
))

GLOBAL_LIST_INIT(trash_mob_loot, GLOB.trash_ammo +\
	GLOB.trash_chem +\
	GLOB.trash_clothing +\
	GLOB.trash_craft +\
	GLOB.trash_gun +\
	GLOB.trash_misc +\
	GLOB.trash_mob +\
	GLOB.trash_part +\
	GLOB.trash_tool)

GLOBAL_LIST_INIT(loot_prefall_clothing, list(
	/obj/item/clothing/under/overalls,
	/obj/item/clothing/head/flatcap,
	/obj/item/clothing/under/plaid_skirt/green,
	/obj/item/clothing/under/plaid_skirt/purple,
	/obj/item/clothing/under/blacktango,
	/obj/item/clothing/under/redeveninggown,
	/obj/item/clothing/under/janimaid,
	/obj/item/clothing/suit/jacket/leather,
	/obj/item/clothing/gloves/fingerless,
	/obj/item/clothing/suit/jacket/puffer/vest,
	/obj/item/clothing/under/pants/jeans,
	/obj/item/clothing/neck/mantle/gray,
	/obj/item/clothing/under/suit_jacket/charcoal,
	/obj/item/clothing/head/that,
	/obj/item/clothing/under/suit_jacket/checkered,
	/obj/item/clothing/under/suit_jacket/burgundy,
	/obj/item/clothing/neck/mantle/brown,
	/obj/item/clothing/under/scratch,
	/obj/item/clothing/shoes/sneakers/white,
	/obj/item/clothing/head/beanie/black,
	/obj/item/clothing/suit/hooded/chaplain_hoodie,
	/obj/item/clothing/under/pants/camo,
	/obj/item/clothing/neck/apron/bartender,
	/obj/item/clothing/under/rank/bartender/purple,
	/obj/item/clothing/under/plaid_skirt/blue,
	/obj/item/clothing/under/plaid_skirt,
	/obj/item/clothing/under/suit_jacket/navy,
	/obj/item/clothing/under/suit_jacket/female,
	/obj/item/clothing/under/f13/erpdress,
	/obj/item/clothing/shoes/laceup
))

GLOBAL_LIST_INIT(loot_prefall_costume, list(
	/obj/item/clothing/head/ushanka,
	/obj/item/clothing/under/soviet,
	/obj/item/clothing/under/geisha,
	/obj/item/clothing/shoes/sandal,
	/obj/item/clothing/under/blacktango,
	/obj/item/clothing/under/redeveninggown,
	/obj/item/clothing/head/sombrero,
	/obj/item/clothing/neck/mantle/poncho,
	/obj/item/clothing/under/sailor,
	/obj/item/clothing/under/schoolgirl/red,
	/obj/item/clothing/under/schoolgirl,
	/obj/item/clothing/head/fluff/bandit,
	/obj/item/clothing/head/fluff/gambler,
	/obj/item/clothing/under/jabroni,
	/obj/item/clothing/glasses/sunglasses/blindfold,
	/obj/item/clothing/under/gladiator,
	/obj/item/clothing/shoes/roman,
	/obj/item/clothing/under/maid,
	/obj/item/clothing/under/draculass,
	/obj/item/clothing/under/kilt,
	/obj/item/clothing/under/pirate,
	/obj/item/clothing/suit/pirate,
	/obj/item/clothing/under/costume/cheongsam,
	/obj/item/clothing/under/costume/qipao/red,
))

GLOBAL_LIST_INIT(loot_t1_armor, list(
	/obj/item/clothing/suit/armor/light/leather/leather_jacket,
	/obj/item/clothing/suit/armor/light/kit,
	/obj/item/clothing/suit/armor/light/duster
))

GLOBAL_LIST_INIT(loot_t2_armor, list(
	/obj/item/clothing/suit/armor/light/raider/supafly,
	/obj/item/clothing/head/helmet/f13/raider,
	/obj/item/clothing/suit/armor/light/raider/sadist,
	/obj/item/clothing/head/helmet/f13/raider/arclight,
	/obj/item/clothing/suit/armor/medium/raider/blastmaster,
	/obj/item/clothing/head/helmet/f13/raider/blastmaster,
	/obj/item/clothing/suit/armor/medium/raider/yankee,
	/obj/item/clothing/head/helmet/f13/raider/yankee,
	/obj/item/clothing/head/helmet/f13/fiend,
	/obj/item/clothing/suit/armor/light/raider/painspike,
	/obj/item/clothing/head/helmet/f13/raider/psychotic,
	/obj/item/clothing/suit/armor/light/raider/supafly,
	/obj/item/clothing/head/helmet/f13/raider,
	/obj/item/clothing/suit/armor/medium/raider/iconoclast
))

GLOBAL_LIST_INIT(loot_t3_armor, list(
	/obj/item/clothing/suit/armor/heavy/metal,
	/obj/item/clothing/head/helmet/knight/f13/metal,
	/obj/item/clothing/suit/armor/heavy/metal,
	/obj/item/clothing/head/helmet/f13/metalmask,
	/obj/item/clothing/suit/armor/light/leather,
	/obj/item/clothing/suit/armor/light/leather/leather_jacketmk2,
	/obj/item/clothing/suit/armor/light/leather/leathercoat
))

GLOBAL_LIST_INIT(loot_t4_armor, list(
	/obj/item/clothing/suit/armor/heavy/metal/reinforced,
	/obj/item/clothing/head/helmet/f13/metalmask/mk2,
	/obj/item/clothing/suit/armor/light/leather/leathercoat,
	/obj/item/clothing/head/helmet/f13/combat/swat,
	/obj/item/clothing/suit/armor/medium/combat/swat,
	/obj/item/clothing/suit/armor/medium/combat,
	/obj/item/clothing/head/helmet/f13/combat,
	/obj/item/clothing/suit/armor/heavy/vest/bulletproof,
	/obj/item/clothing/head/helmet/alt,
	/obj/item/clothing/suit/armor/medium/combat/dark,
	/obj/item/clothing/head/helmet/f13/combat/dark,
	/obj/item/clothing/suit/armor/medium/combat/mk2/dark,
	/obj/item/clothing/head/helmet/f13/combat/mk2/dark,
	/obj/item/clothing/suit/armor/heavy/metal/sulphite,
	/obj/item/clothing/head/helmet/f13/sulphitehelm
))

GLOBAL_LIST_INIT(loot_t5_armor, list(
	/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b,
	/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b,
	/obj/item/clothing/suit/armor/heavy/riot/combat,
	/obj/item/clothing/head/helmet/f13/combat/rangerbroken,
	/obj/item/clothing/suit/armor/medium/combat/mk2,
	/obj/item/clothing/head/helmet/f13/combat/mk2
))

GLOBAL_LIST_INIT(loot_medical_tool, list(
	/obj/item/hemostat,
	/obj/item/surgicaldrill,
	/obj/item/retractor,
	/obj/item/cautery,
	/obj/item/scalpel,
	/obj/item/clothing/suit/hooded/surgical,
	/obj/item/clothing/gloves/color/latex,
	/obj/item/clothing/mask/surgical,
	/obj/item/surgical_drapes,
	/obj/item/circular_saw
))

GLOBAL_LIST_INIT(loot_medical_medicine, list(
	/obj/item/reagent_containers/pill/healingpowder,
	/obj/item/reagent_containers/blood/radaway,
	/obj/item/reagent_containers/hypospray/medipen/stimpak,
	/obj/item/stack/medical/gauze/adv,
	/obj/item/stack/medical/mesh/advanced,
	/obj/item/stack/medical/suture/medicated
))

GLOBAL_LIST_INIT(loot_medical_drug, list(
	/obj/item/reagent_containers/pill/patch/jet,
	/obj/item/reagent_containers/pill/patch/turbo,
	/obj/item/reagent_containers/pill/healingpowder,
	/obj/item/reagent_containers/pill/stimulant,
	/obj/item/reagent_containers/pill/patch/medx,
	/obj/item/reagent_containers/pill/patch/steady
))

GLOBAL_LIST_INIT(loot_t1_melee, list(
	/obj/item/crowbar,
	/obj/item/extinguisher,
	/obj/item/hatchet,
	/obj/item/pickaxe/mini,
	/obj/item/wrench,
	/obj/item/kitchen/knife,
	/obj/item/kitchen/rollingpin,
))

GLOBAL_LIST_INIT(loot_t2_melee, list(
	/obj/item/oar,
	/obj/item/pickaxe,
	/obj/item/shovel,
	/obj/item/melee/onehanded/knife/switchblade,
	/obj/item/throwing_star/spear,
	/obj/item/surgicaldrill,
	/obj/item/melee/onehanded/knife/hunting,
	/obj/item/melee/onehanded/knife/survival,
	/obj/item/melee/onehanded/knife/bone,
	/obj/item/twohanded/baseball/golfclub,
	/obj/item/twohanded/baseball/louisville,
	/obj/item/instrument/guitar,
	/obj/item/melee/onehanded/club,
	/obj/item/melee/onehanded/knife/cosmicdirty,
	/obj/item/melee/unarmed/brass,
	/obj/item/melee/unarmed/brass/spiked
))

GLOBAL_LIST_INIT(loot_t3_melee, list(
	/obj/item/weldingtool,
	/obj/item/twohanded/spear,
	/obj/item/twohanded/baseball,
	/obj/item/kitchen/knife/butcher,
	/obj/item/melee/onehanded/machete,
	/obj/item/melee/onehanded/machete/forgedmachete,
	/obj/item/melee/transforming/energy/axe/protonaxe,
	/obj/item/shield/riot/buckler,
	/obj/item/melee/unarmed/tigerclaw,
	/obj/item/melee/unarmed/sappers
))

GLOBAL_LIST_INIT(loot_t4_melee, list(
	/obj/item/twohanded/fireaxe,
	/obj/item/twohanded/sledgehammer/simple,
	/obj/item/twohanded/fireaxe/bmprsword,
	/obj/item/melee/unarmed/lacerator,
	/obj/item/melee/unarmed/maceglove,
	/obj/item/melee/unarmed/punchdagger,
	/obj/item/melee/unarmed/powerfist/moleminer,
	/obj/item/shield/riot
))

GLOBAL_LIST_INIT(loot_t5_melee, list(
	/obj/item/twohanded/thermic_lance,
	/obj/item/twohanded/chainsaw,
	/obj/item/melee/powered/ripper,
	/obj/item/twohanded/sledgehammer/rockethammer,
	/obj/item/gun/ballistic/revolver/ballisticfist,
	/obj/item/twohanded/sledgehammer/supersledge,
	/obj/item/shishkebabpack,
	/obj/item/melee/unarmed/powerfist,
	/obj/item/melee/unarmed/aethergiestgauntlet,
	/obj/item/melee/unarmed/powerfist/moleminer
))

GLOBAL_LIST_INIT(loot_t1_range, list(
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/common_guns
))

GLOBAL_LIST_INIT(loot_t2_range, list(
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns
))

GLOBAL_LIST_INIT(loot_t3_range, list(
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns
))

GLOBAL_LIST_INIT(loot_t4_range, list(
	/obj/effect/spawner/lootdrop/f13/common_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns
))

GLOBAL_LIST_INIT(loot_t5_range, list(
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/uncommon_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns
))

GLOBAL_LIST_INIT(loot_unique_range, list(
	/obj/effect/spawner/lootdrop/f13/rare_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns,
	/obj/effect/spawner/lootdrop/f13/rare_guns
))

GLOBAL_LIST_INIT(loot_t1_ammo, list(
	/obj/item/salvage/ammo
))

GLOBAL_LIST_INIT(loot_t2_ammo, list(
	/obj/item/salvage/ammo
))

GLOBAL_LIST_INIT(loot_t3_ammo, list(
	/obj/item/salvage/ammo
))

GLOBAL_LIST_INIT(loot_t4_ammo, list(
	/obj/item/salvage/ammo
))

GLOBAL_LIST_INIT(loot_t5_ammo, list(
	/obj/item/salvage/ammo
))

GLOBAL_LIST_INIT(loot_garbage, list(
	/obj/item/broken_bottle,
	/obj/item/poster/random_official,
	/obj/item/multitool,
	/obj/item/cigbutt/cigarbutt,
	/obj/item/razor,
	/obj/item/candle,
	/obj/item/rollingpaper,
	/obj/item/trash/coal,
	/obj/item/soap/homemade,
	/obj/item/stack/cable_coil/random,
	/obj/item/stack/medical/bruise_pack,
	/obj/item/trash/popcorn,
	/obj/item/valentine,
	/obj/item/taperecorder,
	/obj/item/tape/random,
	/obj/item/stack/medical/gauze,
	/obj/item/trash/plate,
	/obj/item/storage/box/snappops,
	/obj/item/stack/packageWrap,
	/obj/item/storage/box/matches,
	/obj/item/reagent_containers/food/snacks/deadmouse,
	/obj/item/toner,
	/obj/item/tank/internals/oxygen,
	/obj/item/storage/box/papersack,
	/obj/item/storage/box/lights/mixed,
	/obj/item/storage/box/beakers,
	/obj/item/storage/belt/fannypack/black,
	/obj/item/camera,
	/obj/item/bodypart/l_arm,
	/obj/item/toy/dummy,
	/obj/item/toy/eightball,
	/obj/item/toy/cards/deck,
	/obj/item/trash/tray,
	/obj/item/toy/xmas_cracker,
	/obj/item/reagent_containers/glass/bowl,
	/obj/item/reagent_containers/spray/cleaner,
	/obj/item/reagent_containers/glass/bucket,
	/obj/item/poster/random_contraband
))

GLOBAL_LIST_INIT(loot_seed, list(
	/obj/item/seeds/ambrosia,
	/obj/item/seeds/apple,
	/obj/item/seeds/banana,
	/obj/item/seeds/cotton,
	/obj/item/seeds/berry,
	/obj/item/seeds/poppy/broc,
	/obj/item/seeds/cabbage,
	/obj/item/seeds/carrot,
	/obj/item/seeds/carrot/parsnip,
	/obj/item/seeds/cherry,
	/obj/item/seeds/chanterelle,
	/obj/item/seeds/chili,
	/obj/item/seeds/cocoapod,
	/obj/item/seeds/coffee,
	/obj/item/seeds/corn,
	/obj/item/seeds/eggplant,
	/obj/item/seeds/grape,
	/obj/item/seeds/grass,
	/obj/item/seeds/lemon,
	/obj/item/seeds/lime,
	/obj/item/seeds/onion,
	/obj/item/seeds/orange,
	/obj/item/seeds/rainbow_bunch,
	/obj/item/seeds/pineapple,
	/obj/item/seeds/potato,
	/obj/item/seeds/poppy,
	/obj/item/seeds/pumpkin,
	/obj/item/seeds/wheat/rice,
	/obj/item/seeds/soya,
	/obj/item/seeds/sugarcane,
	/obj/item/seeds/sunflower,
	/obj/item/seeds/tea,
	/obj/item/seeds/tobacco,
	/obj/item/seeds/tomato,
	/obj/item/seeds/tower,
	/obj/item/seeds/watermelon,
	/obj/item/seeds/wheat,
	/obj/item/seeds/whitebeet,
	/obj/item/seeds/xander,
	/obj/item/seeds/mutfruit,
	/obj/item/seeds/amanita,
	/obj/item/seeds/glowshroom,
	/obj/item/seeds/liberty,
	/obj/item/seeds/nettle,
	/obj/item/seeds/plump,
	/obj/item/seeds/reishi,
	/obj/item/seeds/cannabis,
	/obj/item/seeds/starthistle,
	/obj/item/seeds/random
))

GLOBAL_LIST_INIT(loot_food, list(
	/obj/item/storage/box/ingredients/american,
	/obj/item/reagent_containers/food/snacks/f13/crisps,
	/obj/item/reagent_containers/food/snacks/f13/crisps,
	/obj/item/reagent_containers/food/snacks/f13/bubblegum,
	/obj/item/reagent_containers/food/snacks/f13/cram,
	/obj/item/reagent_containers/food/snacks/f13/yumyum,
	/obj/item/reagent_containers/food/snacks/f13/fancylads,
	/obj/item/reagent_containers/food/snacks/f13/sugarbombs,
	/obj/item/reagent_containers/food/snacks/cheesiehonkers,
	/obj/item/reagent_containers/food/snacks/f13/steak,
	/obj/item/reagent_containers/food/snacks/f13/dandyapples,
	/obj/item/reagent_containers/food/snacks/f13/blamco,
	/obj/item/reagent_containers/food/snacks/f13/instamash ,
	/obj/item/reagent_containers/food/snacks/f13/canned/porknbeans,
	/obj/item/storage/box/ingredients/carnivore,
	/obj/item/storage/box/ingredients/delights,
	/obj/item/storage/box/ingredients/exotic,
	/obj/item/storage/box/ingredients/fiesta,
	/obj/item/storage/box/ingredients/fruity,
	/obj/item/storage/box/ingredients/grains,
	/obj/item/storage/box/ingredients/italian,
	/obj/item/storage/box/ingredients/sweets,
	/obj/item/storage/box/ingredients/vegetarian,
	/obj/item/storage/box/ingredients/wildcard,
	/obj/item/reagent_containers/food/condiment/flour,
	/obj/item/reagent_containers/food/condiment/rice,
	/obj/item/reagent_containers/food/condiment/yeast,
	/obj/item/reagent_containers/food/condiment/soymilk,
	/obj/item/reagent_containers/food/condiment/ketchup,
	/obj/item/reagent_containers/food/condiment/sugar,
	/obj/item/reagent_containers/food/condiment/milk,
	/obj/item/reagent_containers/food/condiment/saltshaker,
	/obj/item/reagent_containers/food/condiment/peppermill,
	/obj/item/reagent_containers/food/condiment/soysauce,
	/obj/item/reagent_containers/food/snacks/beans,
	/obj/item/reagent_containers/food/snacks/cracker,
	/obj/item/reagent_containers/food/snacks/lollipop,
))

GLOBAL_LIST_INIT(loot_craft_basic, list(
	/obj/item/crafting/abraxo,
	/obj/item/stack/crafting/metalparts/three,
	/obj/item/stack/crafting/metalparts/five,
	/obj/item/stack/crafting/goodparts/three,
	/obj/item/stack/crafting/goodparts/five,
	/obj/item/stack/crafting/electronicparts/three,
	/obj/item/stack/crafting/electronicparts/five,
	/obj/item/reagent_containers/glass/bottle/blackpowder,
	/obj/item/crafting/wonderglue,
	/obj/item/crafting/duct_tape
))

GLOBAL_LIST_INIT(loot_alcohol, list(
	/obj/item/reagent_containers/food/drinks/beer,
	/obj/item/reagent_containers/food/drinks/ale,
	/obj/item/reagent_containers/food/drinks/bottle/gin,
	/obj/item/reagent_containers/food/drinks/bottle/hcider,
	/obj/item/reagent_containers/food/drinks/bottle/whiskey,
	/obj/item/reagent_containers/food/drinks/bottle/vodka,
	/obj/item/reagent_containers/food/drinks/bottle/tequila,
	/obj/item/reagent_containers/food/drinks/bottle/rum,
	/obj/item/reagent_containers/food/drinks/bottle/vermouth,
	/obj/item/reagent_containers/food/drinks/bottle/kahlua,
	/obj/item/reagent_containers/food/drinks/bottle/cognac,
	/obj/item/reagent_containers/food/drinks/bottle/wine,
	/obj/item/reagent_containers/food/drinks/bottle/absinthe,
	/obj/item/reagent_containers/food/drinks/bottle/lizardwine,
	/obj/item/reagent_containers/food/drinks/bottle/hcider,
	/obj/item/reagent_containers/food/drinks/bottle/grappa,
	/obj/item/reagent_containers/food/drinks/bottle/sake,
	/obj/item/reagent_containers/food/drinks/bottle/fernet
))

GLOBAL_LIST_INIT(loot_material, list(
	/obj/item/stack/rods/ten,
	/obj/item/stack/sheet/metal/ten,
	/obj/item/stack/sheet/cardboard/fifty,
	/obj/item/stack/sheet/cardboard/twenty,
	/obj/item/stack/sheet/glass/ten,
	/obj/item/stack/sheet/metal/five,
	/obj/item/stack/sheet/plasteel/five,
	/obj/item/stack/sheet/plastic/five,
	/obj/item/stack/sheet/paperframes/twenty,
	/obj/item/stack/sheet/cloth/ten,
	/obj/item/stack/crafting/metalparts/five,
	/obj/item/stack/crafting/goodparts/three
))

GLOBAL_LIST_INIT(loot_t1_money, list(
	/obj/item/stack/f13Cash/random/low
))

GLOBAL_LIST_INIT(loot_t2_money, list(
	/obj/item/stack/f13Cash/random/med
))

GLOBAL_LIST_INIT(loot_t3_money, list(
	/obj/item/stack/f13Cash/random/high
))

// GLOBAL_LIST_INIT(loot_skillbook, list(
// 	/obj/item/book/granter/trait/chemistry,
// 	// /obj/item/book/granter/trait/trekking,
// 	/obj/item/book/granter/trait/pa_wear,
// 	/obj/item/book/granter/crafting_recipe/gunsmith_one,
// 	/obj/item/book/granter/crafting_recipe/gunsmith_two,
// 	/obj/item/book/granter/crafting_recipe/gunsmith_three,
// 	/obj/item/book/granter/crafting_recipe/gunsmith_four
// ))

// GLOBAL_LIST_INIT(loot_craft_advanced, list(
// 	/obj/item/advanced_crafting_components/flux,
// 	/obj/item/advanced_crafting_components/lenses,
// 	/obj/item/advanced_crafting_components/conductors,
// 	/obj/item/advanced_crafting_components/receiver,
// 	/obj/item/advanced_crafting_components/assembly,
// 	/obj/item/advanced_crafting_components/alloys
// ))

// GLOBAL_LIST_INIT(loot_t1_blueprint, list(
// 	/obj/item/book/granter/crafting_recipe/blueprint/marksman,
// 	/obj/item/book/granter/crafting_recipe/blueprint/combatrifle,
// 	/obj/item/book/granter/crafting_recipe/blueprint/plasmapistol,
// 	/obj/item/book/granter/crafting_recipe/blueprint/brushgun,
// 	/obj/item/book/granter/crafting_recipe/blueprint/aer9,
// 	/obj/item/book/granter/crafting_recipe/blueprint/smg10mm
// ))

// GLOBAL_LIST_INIT(loot_t2_blueprint, list(
// 	/obj/item/book/granter/crafting_recipe/blueprint/r91,
// 	/obj/item/book/granter/crafting_recipe/blueprint/sniper,
// 	/obj/item/book/granter/crafting_recipe/blueprint/riotshotgun,
// 	/obj/item/book/granter/crafting_recipe/blueprint/thatgun,
// 	/obj/item/book/granter/crafting_recipe/blueprint/lsw,
// 	/obj/item/book/granter/crafting_recipe/blueprint/deagle
// ))

// GLOBAL_LIST_INIT(loot_t3_blueprint, list(
// 	/obj/item/book/granter/crafting_recipe/blueprint/am_rifle,
// 	/obj/item/book/granter/crafting_recipe/blueprint/citykiller,
// 	/obj/item/book/granter/crafting_recipe/blueprint/rangemaster,
// 	/obj/item/book/granter/crafting_recipe/blueprint/bozar
// ))
