
/* animals and plants

//primary vars
/datum/supplykit_item/animals/
	name = 
	desc = 
	item = 
	cost = 

//other vars
	surplus = 100 //if set below 100, reduces chances of being in the surplus crate
	cant_discount = FALSE //if set to true, prevents possible discounts
	limited_stock = -1 //-1 is infinite stock. otherwise, limits how many you can buy. also prevents discounts.
	restricted_roles = list() //for restricting by job type
	*/


/datum/supplykit_item/animals/botanygloves
	name = "Botany Gloves"
	desc = "Heavy leather gloves that protect against thorns."
	item = /obj/item/clothing/gloves/botanic_leather
	cost = 5

/datum/supplykit_item/animals/plantanalyzer
	name = "Plant Analyzer"
	desc = "A piece of tech used to scan the health and biology of plants."
	item = /obj/item/plant_analyzer
	cost = 5

/datum/supplykit_item/animals/spade
	name = "Spade"
	desc = "A compact tool for digging up sand and plant roots."
	item = /obj/item/shovel/spade
	cost = 5

/datum/supplykit_item/animals/shovel
	name = "Shovel"
	desc = "A large shovel, for digging up sand and plant roots"
	item = /obj/item/shovel
	cost = 1

/datum/supplykit_item/animals/cultivator
	name = "Cultivator"
	desc = "A small rake used to clear away weeds."
	item = /obj/item/cultivator
	cost = 5

/datum/supplykit_item/animals/bucket
	name = "Plastic Bucket"
	desc = "This, is a bucket."
	item = /obj/item/reagent_containers/glass/bucket/plastic
	cost = 2

/datum/supplykit_item/animals/portaseeder
	name = "Portaseeder"
	desc = "A belt mounted machine that refines fresh seeds from plant crops."
	item = /obj/item/storage/bag/plants/portaseeder
	cost = 5

/datum/supplykit_item/animals/plantbag
	name = "Produce Bag"
	desc = "A clean cloth bag for holding plants and animal products."
	item = /obj/item/storage/bag/plants
	cost = 1

/datum/supplykit_item/animals/nutrient
	name = "Nutrient Bottle"
	desc = "A bottle of basic plant fertilizer for your starter garden."
	item = /obj/item/reagent_containers/glass/bottle/nutrient/ez
	cost = 5

/datum/supplykit_item/animals/wheat //wanna make a random seed option with 1 cost, but later
	name = "Wheat Bundle"
	desc = "A bundle of grains for feeding animals or growing crops for flour and beer."
	item = /obj/item/reagent_containers/food/snacks/grown/wheat
	cost = 1

/datum/supplykit_item/animals/oats
	name = "Oats Bundle"
	desc = "A bundle of grains for feeding animals or growing crops for flour and ale."
	item = /obj/item/reagent_containers/food/snacks/grown/oat
	cost = 1

/datum/supplykit_item/animals/seeds
	name = "Random Seed"
	desc = "A handful of four random plant seeds. who knows what they are!"
	item = /obj/effect/spawner/lootdrop/f13/seedspawner
	cost = 4

/datum/supplykit_item/animals/fever
	name = "Fever Blossom"
	desc = "A mutated passion flower that has developed strong aphrodisiac properties."
	item = /obj/item/reagent_containers/food/snacks/grown/fever_blossom
	cost = 1

/datum/supplykit_item/animals/capturedevice
	name = "Capture Device"
	desc = "A compact device used for transporting friendly creatures in a small package."
	item = /obj/item/capturedevice
	cost = 10

/datum/supplykit_item/animals/lazarus_injector
	name = "Lazarus Injector"
	desc = "An advanced device used to revive and tame most creatures."
	item = /obj/item/lazarus_injector
	cost = 10

/datum/supplykit_item/animals/etherleech
	name = "BioSynth Reanimator Injector"
	desc = "A reusable modified Lazarus used to revive and tame most creatures"
	item = /obj/item/holoparasite_injector
	cost = 20

/datum/supplykit_item/animals/tribalres
	name = "Necronomicon"
	desc = "A reusable book Lazarus used to revive and tame most creatures, necromancer delight!"
	item = /obj/item/holotribal_injector
	cost = 20

/datum/supplykit_item/animals/pet
	name = "Animal Beacon"
	desc = "A beacon that summons your harmless pet or livestock from the safety of home."
	item = /obj/item/choice_beacon/pet
	cost = 5

/datum/supplykit_item/animals/collar //could be compressed into a single barding kit
	name = "Mount Collar"
	desc = "A collar with a tag, used to name animals."
	item = /obj/item/brahmincollar
	cost = 5

/datum/supplykit_item/animals/bridle
	name = "Mount Bridle"
	desc = "A set of headgear used to claim and control a mount."
	item = /obj/item/brahminbridle
	cost = 5

/datum/supplykit_item/animals/saddle
	name = "Mount Saddle"
	desc = "A riding saddle for your dashing mount."
	item = /obj/item/brahminsaddle
	cost = 5

/datum/supplykit_item/animals/brand
	name = "Mount Branding Tool"
	desc = "A hot brand used to claim your mount."
	item = /obj/item/brahminbrand
	cost = 5

/datum/supplykit_item/animals/mount //could make individual entries but it's ever expanding and long
	name = "Mount Beacon"
	desc = "A beacon used to summon you mount from the safety of home."
	item = /obj/item/choice_beacon/pet/mountable
	cost = 20

