/obj/machinery/mineral/wasteland_trader
	name = "Workshop Scrapper"
	desc = "A vending machine that's been modified to accept various items in exchange for caps. A sign on it reads, 'Keep your workplace clean and get paid doing it!' It's better than a trash can, at least."
	icon = 'icons/WVM/machines.dmi'
	icon_state = "trade_idle"

	density = TRUE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = 2.9

	var/stored_caps = 0	// store caps
	var/expected_price = 0
	var/list/prize_list = list()  // Once this is readded to the map, I need to do some testing regarding gunpowder. See if I can't bully the commie reloading bench to death.

	var/list/goods_list = list( /obj/item/stack/sheet/metal = 1,
								/obj/item/stack/sheet/mineral/titanium = 3,
								/obj/item/stack/sheet/plasteel =3,
								/obj/item/stack/sheet/cloth = 1,
								/obj/item/stack/sheet/cloth/ten = 1,
								/obj/item/stack/sheet/cloth/thirty = 1,
								/obj/item/stack/sheet/cloth/five = 1,
								/obj/item/stack/sheet/cloth/three = 1,
								/obj/item/stack/ore/blackpowder = 1,
								/obj/item/stack/ore/blackpowder/fifty = 1,
								/obj/item/stack/ore/blackpowder/twenty = 1,
								/obj/item/stack/ore/blackpowder/two = 1,
								/obj/item/stack/ore/blackpowder/five = 1,
								/obj/item/stack/sheet/prewar = 2,
								/obj/item/stack/sheet/prewar/five = 2,
								/obj/item/stack/sheet/prewar/twenty = 2,
								/obj/item/stack/sheet/prewar/fifty = 2,
								/obj/item/stack/sheet/leather = 1,
								/obj/item/stack/sheet/leather/five = 1,
								/obj/item/stack/sheet/leather/ten = 1,
								/obj/item/stack/sheet/leather/twenty = 1,
								/obj/item/stack/sheet/sinew = 1,
								/obj/item/stack/sheet/animalhide/chitin = 1,
								/obj/item/stack/sheet/mineral/plastitanium = 6,
								/obj/item/reagent_containers/hypospray/medipen/medx = 3,
								/obj/item/reagent_containers/hypospray/medipen/steady = 3,
								/obj/item/storage/pill_bottle/chem_tin/mentats = 3,
								/obj/item/storage/pill_bottle/chem_tin/buffout = 3,
								/obj/item/reagent_containers/pill/stimulant = 3,
								/obj/item/storage/pill_bottle/chem_tin/radx = 3,
								/obj/item/reagent_containers/pill/antivenom = 3,
								/obj/item/reagent_containers/food/drinks/bottle/orangejuice = 3,
								/obj/item/reagent_containers/food/snacks/grown/ambrosia/vulgaris = 1,
								/obj/item/reagent_containers/food/snacks/grown/apple = 1,
								/obj/item/reagent_containers/food/snacks/grown/banana = 1,
								/obj/item/reagent_containers/food/snacks/grown/soybeans = 1,
								/obj/item/reagent_containers/food/snacks/grown/berries = 1,
								/obj/item/reagent_containers/food/snacks/grown/cherries = 1,
								/obj/item/reagent_containers/food/snacks/grown/grapes = 1,
								/obj/item/reagent_containers/food/snacks/grown/grapes/green = 1,
								/obj/item/reagent_containers/food/snacks/grown/strawberry = 1,
								/obj/item/reagent_containers/food/snacks/grown/broc = 1,
								/obj/item/reagent_containers/food/snacks/grown/buffalogourd = 1,
								/obj/item/reagent_containers/food/snacks/grown/wheat = 1,
								/obj/item/reagent_containers/food/snacks/grown/oat = 1,
								/obj/item/reagent_containers/food/snacks/grown/rice = 1,
								/obj/item/reagent_containers/food/snacks/grown/chili = 1,
								/obj/item/reagent_containers/food/snacks/grown/bell_pepper = 1,
								/obj/item/reagent_containers/food/snacks/grown/citrus/lime = 1,
								/obj/item/reagent_containers/food/snacks/grown/citrus/orange = 1,
								/obj/item/reagent_containers/food/snacks/grown/citrus/lemon = 1,
								/obj/item/reagent_containers/food/snacks/grown/cocoapod = 1,
								/obj/item/reagent_containers/food/snacks/grown/corn = 1,
								/obj/item/grown/cotton = 1,
								/obj/item/reagent_containers/food/snacks/grown/coyotetobacco = 1,
								/obj/item/reagent_containers/food/snacks/grown/datura = 1,
								/obj/item/reagent_containers/food/snacks/grown/eggplant = 1,
								/obj/item/reagent_containers/food/snacks/grown/feracactus = 1,
								/obj/item/reagent_containers/food/snacks/grown/fever_blossom = 1,
								/obj/item/reagent_containers/food/snacks/grown/poppy = 1,
								/obj/item/reagent_containers/food/snacks/grown/poppy/lily = 1,
								/obj/item/reagent_containers/food/snacks/grown/poppy/geranium = 1,
								/obj/item/reagent_containers/food/snacks/grown/poppy/geranium/forgetmenot = 1,
								/obj/item/reagent_containers/food/snacks/grown/harebell = 1,
								/obj/item/grown/sunflower = 1,
								/obj/item/reagent_containers/food/snacks/grown/garlic = 1,
								/obj/item/reagent_containers/food/snacks/grown/herbs = 1,
								/obj/item/reagent_containers/food/snacks/grown/horsenettle = 1,
								/obj/item/reagent_containers/food/snacks/grown/watermelon = 1,
								/obj/item/reagent_containers/food/snacks/grown/mesquite = 1,
								/obj/item/reagent_containers/food/snacks/grown/cabbage = 1,
								/obj/item/reagent_containers/food/snacks/grown/sugarcane = 1,
								/obj/item/reagent_containers/food/snacks/grown/coconut = 1,
								/obj/item/reagent_containers/food/snacks/grown/aloe = 1,
								/obj/item/reagent_containers/food/snacks/grown/mushroom/reishi = 1,
								/obj/item/reagent_containers/food/snacks/grown/mushroom/amanita = 1,
								/obj/item/reagent_containers/food/snacks/grown/mushroom/libertycap = 1,
								/obj/item/reagent_containers/food/snacks/grown/mushroom/plumphelmet = 1,
								/obj/item/reagent_containers/food/snacks/grown/mushroom/chanterelle = 1,
								/obj/item/reagent_containers/food/snacks/grown/mutfruit = 1,
								/obj/item/reagent_containers/food/snacks/grown/nettle = 1,
								/obj/item/reagent_containers/food/snacks/grown/onion = 1,
								/obj/item/reagent_containers/food/snacks/grown/peach = 1,
								/obj/item/reagent_containers/food/snacks/grown/peanut = 1,
								/obj/item/reagent_containers/food/snacks/grown/peas = 1,
								/obj/item/reagent_containers/food/snacks/grown/pineapple = 1,
								/obj/item/reagent_containers/food/snacks/grown/pinyon = 1,
								/obj/item/reagent_containers/food/snacks/grown/potato = 1,
								/obj/item/reagent_containers/food/snacks/grown/pricklypear = 1,
								/obj/item/reagent_containers/food/snacks/grown/pumpkin = 1,
								/obj/item/reagent_containers/food/snacks/grown/pungafruit = 1,
								/obj/item/reagent_containers/food/snacks/grown/rainbow_flower = 1,
								/obj/item/reagent_containers/food/snacks/grown/carrot = 1,
								/obj/item/reagent_containers/food/snacks/grown/parsnip = 1,
								/obj/item/reagent_containers/food/snacks/grown/tato = 1,
								/obj/item/reagent_containers/food/snacks/grown/coffee = 1,
								/obj/item/reagent_containers/food/snacks/grown/tea = 1,
								/obj/item/reagent_containers/food/snacks/grown/tobacco = 1,
								/obj/item/reagent_containers/food/snacks/grown/tomato = 1,
								/obj/item/grown/log = 1,
								/obj/item/reagent_containers/food/snacks/grown/xander = 1,
								/obj/item/reagent_containers/food/snacks/grown/yucca = 1,
								/obj/item/stack/sheet/animalhide/deathclaw = 25,
								/obj/item/stack/sheet/animalhide/gecko = 2,
								/obj/item/stack/sheet/animalhide/molerat = 2,
								/obj/item/stack/sheet/animalhide/wolf = 5,
								/obj/item/stack/sheet/animalhide/radstag = 5,
								/obj/item/stack/sheet/animalhide/brahmin = 5,
								/obj/item/reagent_containers/food/snacks/meat/slab/deathclaw = 15, 
								/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 3, 
								/obj/item/reagent_containers/food/snacks/meat/slab/molerat = 3, 
								/obj/item/reagent_containers/food/snacks/meat/slab/wolf = 3, 
								/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 3, 
								/obj/item/reagent_containers/food/snacks/meat/slab/radroach_meat = 1, 
								/obj/item/reagent_containers/food/snacks/meat/slab/ant_meat = 3, 
								/obj/item/reagent_containers/food/snacks/meat/slab/fireant_meat = 5, 
								/obj/item/reagent_containers/food/snacks/meat/slab/bloatfly_meat = 1, 
								/obj/item/reagent_containers/food/snacks/meat/slab/cazador_meat = 3, 
								/obj/item/reagent_containers/food/snacks/meat/slab/radscorpion_meat = 3,
								/obj/item/advanced_crafting_components/flux = 15,
								/obj/item/advanced_crafting_components/lenses = 15,
								/obj/item/advanced_crafting_components/conductors = 15,
								/obj/item/advanced_crafting_components/receiver = 15,
								/obj/item/advanced_crafting_components/assembly = 15,
								/obj/item/advanced_crafting_components/alloys = 15,
								/obj/item/export/bottle/gin = 8,
								/obj/item/export/bottle/whiskey = 8,
								/obj/item/export/bottle/wine = 8,
								/obj/item/export/bottle/vodka = 8,
								/obj/item/export/bottle/rum = 8,
								/obj/item/export/bottle/tequila = 8,
								/obj/item/export/bottle/minikeg = 8,
								/obj/item/export/bottle/applejack = 8,
								/obj/item/export/bottle/cognac = 8,
								/obj/item/export/bottle/sake = 8,
								/obj/item/export/bottle/hcider = 8,
								/obj/item/export/bottle/vermouth = 8,
								/obj/item/export/bottle/absinthe = 8,
								/obj/item/export/bottle/grappa = 8,
								/obj/item/export/bottle/fernet = 8,
								/obj/item/export/bottle/kahlua = 8,
								/obj/item/export/bottle/champagne = 15,
								/obj/item/export/bottle/blazaam = 15,
								/obj/item/export/bottle/nukashine = 15,
								/obj/item/export/bottle/trappist = 15,
								/obj/item/export/bottle/goldschlager = 15,
								/obj/item/export/bottle/patron = 15,
								/obj/item/stealthboy = 100,
								/obj/item/blueprint/research = 25,
								// pistols/revolvers, 5 caps
								/obj/item/gun/ballistic/revolver/detective = 5,
								/obj/item/gun/ballistic/revolver/revolver45 = 5,
								/obj/item/gun/ballistic/revolver/colt357 = 5,
								/obj/item/gun/ballistic/revolver/colt357/auto = 5,
								/obj/item/gun/ballistic/revolver/colt357/mateba = 5,
								/obj/item/gun/ballistic/revolver/colt357/lucky = 5,
								/obj/item/gun/ballistic/revolver/police = 5,
								/obj/item/gun/ballistic/revolver/police/webley = 5,
								/obj/item/gun/ballistic/revolver/m29 = 5,
								/obj/item/gun/ballistic/revolver/m29/alt = 5,
								/obj/item/gun/ballistic/revolver/m29/peacekeeper = 5,
								/obj/item/gun/ballistic/revolver/m29/snub = 5,
								/obj/item/gun/ballistic/revolver/revolver44 = 5,
								/obj/item/gun/ballistic/revolver/revolver44/desert_ranger = 5,
								/obj/item/gun/ballistic/revolver/hunting = 5,
								/obj/item/gun/ballistic/revolver/hunting/klatue = 5,
								/obj/item/gun/ballistic/revolver/sequoia = 5,
								/obj/item/gun/ballistic/revolver/sequoia/death = 5,
								/obj/item/gun/ballistic/revolver/revolver45/gunslinger = 5,
								/obj/item/gun/ballistic/revolver/thatgun = 5,
								/obj/item/gun/ballistic/revolver/needler = 5,
								/obj/item/gun/ballistic/revolver/needler/ultra = 5,
								/obj/item/gun/ballistic/automatic/pistol/ninemil = 5,
								/obj/item/gun/ballistic/automatic/pistol/ninemil/auto = 5,
								/obj/item/gun/ballistic/automatic/pistol/ninemil/skorpion = 5,
								/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby = 5,
								/obj/item/gun/ballistic/automatic/pistol/ninemil/c93 = 5,
								/obj/item/gun/ballistic/automatic/pistol/ninemil/c93/luger = 5,
								/obj/item/gun/ballistic/automatic/pistol/ninemil/maria = 5,
								/obj/item/gun/ballistic/automatic/pistol/beretta = 5,
								/obj/item/gun/ballistic/automatic/pistol/beretta/carbine = 5,
								/obj/item/gun/ballistic/automatic/pistol/beretta/automatic = 5,
								/obj/item/gun/ballistic/automatic/pistol/beretta/automatic/worn = 5,
								/obj/item/gun/ballistic/automatic/pistol/n99 = 5,
								/obj/item/gun/ballistic/automatic/pistol/n99/executive = 5,
								/obj/item/gun/ballistic/automatic/pistol/n99/executive/worn = 5,
								/obj/item/gun/ballistic/automatic/pistol/n99/crusader = 5,
								/obj/item/gun/ballistic/automatic/pistol/n99/crusader/thingpony = 5,
								/obj/item/gun/ballistic/automatic/pistol/type17 = 5,
								/obj/item/gun/ballistic/automatic/pistol/type17/c96auto = 5,
								/obj/item/gun/ballistic/automatic/pistol/type17/c96auto/tox = 5,
								/obj/item/gun/ballistic/automatic/pistol/sig = 5,
								/obj/item/gun/ballistic/automatic/pistol/sig/trusty = 5,
								/obj/item/gun/ballistic/automatic/pistol/sig/worn = 5,
								/obj/item/gun/ballistic/automatic/pistol/sig/blackkite = 5,
								/obj/item/gun/ballistic/automatic/pistol/schmeisser = 5,
								/obj/item/gun/ballistic/automatic/pistol/m1911 = 5,
								/obj/item/gun/ballistic/automatic/pistol/m1911/custom = 5,
								/obj/item/gun/ballistic/automatic/pistol/m1911/custom/jackal = 5,
								/obj/item/gun/ballistic/automatic/pistol/mk23 = 5,
								/obj/item/gun/ballistic/automatic/pistol/deagle = 5,
								/obj/item/gun/ballistic/automatic/pistol/deagle/elcapitan = 5,
								/obj/item/gun/ballistic/automatic/pistol/automag = 5,
								/obj/item/gun/ballistic/automatic/pistol/pistol14 = 5,
								/obj/item/gun/ballistic/automatic/pistol/pistol14/compact = 5,
								/obj/item/gun/ballistic/automatic/pistol/pistol14/lildevil = 5,
								// shotguns/rifles, 10 caps
								/obj/item/gun/ballistic/revolver/m2405 = 10,
								/obj/item/gun/ballistic/revolver/caravan_shotgun = 10,
								/obj/item/gun/ballistic/revolver/widowmaker = 10,
								/obj/item/gun/ballistic/shotgun/hunting = 10,
								/obj/item/gun/ballistic/shotgun/police = 10,
								/obj/item/gun/ballistic/shotgun/trench = 10,
								/obj/item/gun/ballistic/shotgun/automatic/combat/auto5 = 10,
								/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever = 10,
								/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock = 10,
								/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock/tribal = 10,
								/obj/item/gun/ballistic/shotgun/automatic/combat/neostead = 10,
								/obj/item/gun/ballistic/shotgun/automatic/combat/citykiller = 10,
								/obj/item/gun/ballistic/automatic/shotgun/riot = 10,
								/obj/item/gun/ballistic/automatic/shotgun/pancor = 10,
								/obj/item/gun/ballistic/rifle/repeater/cowboy = 10,
								/obj/item/gun/ballistic/rifle/repeater/cowboy/tribal = 10,
								/obj/item/gun/ballistic/rifle/repeater/trail = 10,
								/obj/item/gun/ballistic/rifle/repeater/trail/tribal = 10,
								/obj/item/gun/ballistic/rifle/repeater/brush = 10,
								/obj/item/gun/ballistic/rifle/repeater/brush/tribal = 10,
								/obj/item/gun/ballistic/rifle/repeater/ranger = 10,
								/obj/item/gun/ballistic/rifle/repeater/ranger/tribal = 10,
								/obj/item/gun/ballistic/rifle/hunting = 10,
								/obj/item/gun/ballistic/rifle/hunting/special = 10,
								/obj/item/gun/ballistic/rifle/hunting/remington = 10,
								/obj/item/gun/ballistic/rifle/hunting/paciencia = 10,
								/obj/item/gun/ballistic/rifle/mosin = 10,
								/obj/item/gun/ballistic/rifle/enfield = 10,
								/obj/item/gun/ballistic/rifle/enfield/jungle = 10,
								/obj/item/gun/ballistic/rifle/antique/gras = 10,
								/obj/item/gun/ballistic/rifle/salvaged_eastern_rifle = 10,
								/obj/item/gun/ballistic/rifle/mag/antimateriel = 10,
								/obj/item/gun/ballistic/rifle/mag/boys = 10,
								// full auto smgs/rifles, 15 caps
								/obj/item/gun/ballistic/automatic/smg/american180 = 15,
								/obj/item/gun/ballistic/automatic/smg/american180/b180 = 15,
								/obj/item/gun/ballistic/automatic/smg/smg14 = 15,
								/obj/item/gun/ballistic/automatic/smg/greasegun = 15,
								/obj/item/gun/ballistic/automatic/smg/greasegun/worn = 15,
								/obj/item/gun/ballistic/automatic/smg/smg10mm = 15,
								/obj/item/gun/ballistic/automatic/smg/smg10mm/worn = 15,
								/obj/item/gun/ballistic/automatic/smg/mini_uzi = 15,
								/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22 = 15,
								/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp40 = 15,
								/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp5 = 15,
								/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/tec22 = 15,
								/obj/item/gun/ballistic/automatic/smg/mini_uzi/rockwell = 15,
								/obj/item/gun/ballistic/automatic/smg/mini_uzi/owengun = 15,
								/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10 = 15,
								/obj/item/gun/ballistic/automatic/smg/cg45 = 15,
								/obj/item/gun/ballistic/automatic/smg/tommygun = 15,
								/obj/item/gun/ballistic/automatic/smg/tommygun/whitelegs = 15,
								/obj/item/gun/ballistic/automatic/smg/p90 = 15,
								/obj/item/gun/ballistic/automatic/smg/p90/worn = 15,
								/obj/item/gun/ballistic/automatic/smg/mp5 = 15,
								/obj/item/gun/ballistic/automatic/smg/ppsh = 15,
								/obj/item/gun/ballistic/automatic/smg/sidewinder = 15,
								/obj/item/gun/ballistic/automatic/smg/sidewinder/worn = 15,
								/obj/item/gun/ballistic/automatic/smg/sidewinder/magnum = 15,
								/obj/item/gun/ballistic/automatic/m1carbine = 15,
								/obj/item/gun/ballistic/automatic/m1carbine/m2 = 15,
								/obj/item/gun/ballistic/automatic/m1carbine/compact = 15,
								/obj/item/gun/ballistic/automatic/delisle = 15,
								/obj/item/gun/ballistic/automatic/delisle/commando = 15,
								/obj/item/gun/ballistic/automatic/combat = 15,
								/obj/item/gun/ballistic/automatic/combat/worn/brim = 15,
								/obj/item/gun/ballistic/automatic/combat/worn = 15,
								/obj/item/gun/ballistic/automatic/sportcarbine = 15,
								/obj/item/gun/ballistic/automatic/sportcarbine/m1_22 = 15,
								/obj/item/gun/ballistic/automatic/varmint = 15,
								/obj/item/gun/ballistic/automatic/varmint/verminkiller = 15,
								/obj/item/gun/ballistic/automatic/varmint/ratslayer = 15,
								/obj/item/gun/ballistic/automatic/varmint/bushmaster_arm_gun = 15,
								/obj/item/gun/ballistic/automatic/service = 15,
								/obj/item/gun/ballistic/automatic/service/alr = 15,
								/obj/item/gun/ballistic/automatic/service/carbine = 15,
								/obj/item/gun/ballistic/automatic/marksman = 15,
								/obj/item/gun/ballistic/automatic/marksman/worn = 15,
								/obj/item/gun/ballistic/automatic/marksman/policerifle = 15,
								/obj/item/gun/ballistic/automatic/rangemaster = 15,
								/obj/item/gun/ballistic/automatic/slr = 15,
								/obj/item/gun/ballistic/automatic/m1garand = 15,
								/obj/item/gun/ballistic/automatic/m1garand/oldglory = 15,
								/obj/item/gun/ballistic/automatic/m1garand/republicspride = 15,
								/obj/item/gun/ballistic/automatic/m1garand/sks = 15,
								/obj/item/gun/ballistic/automatic/marksman/sniper = 15,
								/obj/item/gun/ballistic/automatic/marksman/sniper/gold = 15,
								/obj/item/gun/ballistic/automatic/marksman/sniper/snipervenator = 15,
								/obj/item/gun/ballistic/automatic/marksman/sniper/sniperranger = 15,
								/obj/item/gun/ballistic/automatic/service/r82 = 15,
								/obj/item/gun/ballistic/automatic/assault_rifle = 15,
								/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator = 15,
								/obj/item/gun/ballistic/automatic/r93 = 15,
								/obj/item/gun/ballistic/automatic/type93 = 15,
								/obj/item/gun/ballistic/automatic/type93/worn = 15,
								/obj/item/gun/ballistic/automatic/bozar = 15,
								/obj/item/gun/ballistic/automatic/assault_carbine = 15,
								/obj/item/gun/ballistic/automatic/assault_carbine/policerifle = 15,
								/obj/item/gun/ballistic/automatic/assault_carbine/worn = 15,
								/obj/item/gun/ballistic/automatic/fnfal = 15,
								/obj/item/gun/ballistic/automatic/armalite = 15,
								/obj/item/gun/ballistic/automatic/l1a1 = 15,
								/obj/item/gun/ballistic/automatic/bar = 15,
								/obj/item/gun/ballistic/automatic/g11 = 15,
								/obj/item/gun/ballistic/automatic/g11/tox = 15,
								/obj/item/gun/ballistic/automatic/wt550 = 15,
								/obj/item/gun/ballistic/automatic/r84 = 15,
								/obj/item/gun/ballistic/automatic/lsw = 15,
								/obj/item/gun/ballistic/automatic/lewis = 15,
								/obj/item/gun/ballistic/automatic/lewis/lanoe = 15,
								/obj/item/gun/ballistic/automatic/bren = 15,
								/obj/item/gun/ballistic/automatic/m1919 = 15,
								/obj/item/gun/ballistic/automatic/m72 = 15,
								/obj/item/gun/ballistic/automatic/xl70e3 = 15
								)

/obj/machinery/mineral/wasteland_trader/general
	name = "Trading point"
	icon_state = "generic_idle"
	prize_list = list()

/*
/datum/data/wasteland_equipment
	var/equipment_name = "generic"
	var/equipment_path = null
	var/cost = 0

/datum/data/wasteland_equipment/New(name, path, cost)
	src.equipment_name = name
	src.equipment_path = path
	src.cost = cost
*/
/obj/machinery/mineral/wasteland_trader/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "<b>Bottle caps stored:</b> [stored_caps]. <A href='?src=[REF(src)];choice=eject'>Eject caps</A><br>"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Accepted goods and prices:</b><br>"
	dat += "Most Crap : 1 - 6 caps<br>"
	dat += "Advanced Crap : maybe about 15 caps<br>"
	dat += "Crazy Crap: 25-100 caps<br>"
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Trading point", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/wasteland_trader/Topic(href, href_list)
	if(..())
		return
	if(href_list["choice"] == "eject")
		remove_all_caps()
	if(href_list["purchase"])
		var/datum/data/wasteland_equipment/prize = locate(href_list["purchase"])
		if (!prize || !(prize in prize_list))
			to_chat(usr, span_warning("Error: Invalid choice!"))
			return
		if(prize.cost > stored_caps)
			to_chat(usr, span_warning("Error: Insufficent bottle caps value for [prize.equipment_name]!"))
		else
			stored_caps -= prize.cost
			GLOB.vendor_cash += prize.cost
			to_chat(usr, span_notice("[src] clanks to life briefly before vending [prize.equipment_name]!"))
			new prize.equipment_path(src.loc)
			SSblackbox.record_feedback("nested tally", "wasteland_equipment_bought", 1, list("[type]", "[prize.equipment_path]"))
	updateUsrDialog()
	return

/obj/machinery/mineral/wasteland_trader/attackby(obj/item/I, mob/user, params)
	add_caps(I)
	//not sure why anything else was here anyways?

/* Adding a caps to caps storage and release vending item. */
/obj/machinery/mineral/wasteland_trader/proc/add_caps(obj/item/I)
	var/final_value = 0
	var/value_per = 0

	if(!(I?.type in goods_list))
		to_chat(usr, span_notice("[src] is not buying that!"))
		return

	value_per = goods_list[I.type]
	if(!isnum(value_per))
		return

	if(istype(I, /obj/item/stack))
		var/obj/item/stack/S = I
		final_value = FLOOR(S.amount * value_per, 1)
	else
		final_value = value_per

	stored_caps += final_value
	playsound(src, 'sound/items/change_jaws.ogg', 60, 1)
	to_chat(usr, "You sell [final_value] bottle caps value to the [src]. Total caps: [stored_caps].")
	qdel(I)
	src.ui_interact(usr)

/* Spawn all caps on world and clear caps storage */
/obj/machinery/mineral/wasteland_trader/proc/remove_all_caps()
	if(stored_caps <= 0)
		return
	var/obj/item/stack/f13Cash/C = new /obj/item/stack/f13Cash/caps
	if(stored_caps > C.max_amount)
		C.add(C.max_amount - 1)
		C.forceMove(src.loc)
		stored_caps -= C.max_amount
	else
		C.add(stored_caps - 1)
		C.forceMove(src.loc)
		stored_caps = 0
	playsound(src, 'sound/items/coinflip.ogg', 60, 1)
	src.ui_interact(usr)

/*

ORGAN SELLER

*/

/obj/machinery/mineral/wasteland_trader/organ
	name = "Organ Grinder"
	desc = "Organs go in, caps come out. How does it work? Nobody knows."
	icon = 'icons/WVM/machines.dmi'
	icon_state = "organs"

	goods_list = list( /obj/item/organ/heart = 30,
								/obj/item/organ/ears = 5,
								/obj/item/organ/eyes = 5,
								/obj/item/organ/liver = 15,
								/obj/item/organ/lungs = 25,
								/obj/item/organ/stomach = 15,
								/obj/item/organ/tongue = 5
								)

/obj/machinery/mineral/wasteland_trader/organ/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "<b>Bottle caps stored:</b> [stored_caps]. <A href='?src=[REF(src)];choice=eject'>Eject caps</A><br>"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Accepted goods and prices:</b><br>"
	dat += "Heart : 30 caps<br>"
	dat += "Lungs : 25 caps<br>"
	dat += "Liver : 15 caps<br>"
	dat += "Stomach : 15 caps<br>"
	dat += "Eyes : 5 caps<br>"
	dat += "Ears : 5 caps<br>"
	dat += "Tongue : 5 caps<br>"
	dat += "Brain : UNAVAILABLE<br>"
	dat += ""
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Organ Grinder", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/wasteland_trader/organ/attackby(obj/item/I, mob/user, params)
	add_caps_squish(I)

/* Adding a caps to caps storage and release vending item. */
/obj/machinery/mineral/wasteland_trader/organ/proc/add_caps_squish(obj/item/I)
	var/final_value = 0
	var/value_per = 0

	if(!(I?.type in goods_list))
		to_chat(usr, span_notice("[src] is not buying that!"))
		return

	value_per = goods_list[I.type]
	if(!isnum(value_per))
		return

	if(istype(I, /obj/item/stack))
		var/obj/item/stack/S = I
		final_value = FLOOR(S.amount * value_per, 1)
	else
		final_value = value_per

	stored_caps += final_value
	playsound(src, 'sound/vore/prey/squish_01.ogg', 60, 1)
	to_chat(usr, "You sell [final_value] bottle caps value to the [src]. Total caps: [stored_caps].")
	qdel(I)
	src.ui_interact(usr)

/*

Fence

*/

/obj/machinery/mineral/wasteland_trader/brotherhood
	name = "Nash Bounty Ticket Machine"
	desc = "This vending machine accepts bounty tickets in exchange for caps. Make the Wasteland safer, and yourself richer, one bullet at a time."

	goods_list = list( 	/obj/item/card/lowbounty = 100,
						/obj/item/card/midbounty = 200,
						/obj/item/card/highbounty = 400,
						/obj/item/card/kingbounty = 800
								)

/obj/machinery/mineral/wasteland_trader/brotherhood/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "<b>Bottle caps stored:</b> [stored_caps]. <A href='?src=[REF(src)];choice=eject'>Eject caps</A><br>"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Turn your kills into caps today!</b><br>"
	dat += "Small Roller Bounty Ticket: 100 caps<br>"
	dat += "Medium Roller Bounty Ticket: 200 caps<br>"
	dat += "High Roller Bounty Ticket: 400 caps<br>"
	dat += "King's Bounty Ticket: 800 caps<br>"
	dat += ""
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Brotherhood of Steal", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/wasteland_trader/gunbuyer
	name = "Gun Repository"
	desc = "Place weapon inside slot. Weapon is sent out of the region for post-processing. Recieve compensation. Yuma Wasteland Supply Inc. thanks you for disarming the wasteland."
	goods_list = list(/obj/item/gun/ballistic/automatic/hobo/zipgun = 5,
						/obj/item/gun/ballistic/revolver/hobo = 5,
						/obj/item/gun/ballistic/revolver/detective = 5,
						/obj/item/gun/ballistic/revolver/hobo = 8,
						/obj/item/gun/ballistic/revolver/hobo/piperifle = 8,
						/obj/item/gun/ballistic/revolver/hobo/knifegun = 8,
						/obj/item/gun/ballistic/revolver/hobo/pepperbox = 8,
						/obj/item/gun/ballistic/revolver/single_shotgun = 8,
						/obj/item/gun/ballistic/automatic/pistol/n99 = 8,
						/obj/item/gun/ballistic/automatic/pistol/pistol22 = 8,
						/obj/item/gun/ballistic/automatic/pistol/ninemil = 8,
						/obj/item/gun/ballistic/automatic/pistol/sig = 8,
						/obj/item/gun/ballistic/automatic/pistol/beretta = 8,
						/obj/item/gun/ballistic/automatic/pistol/m1911 = 8,
						/obj/item/gun/ballistic/rifle/hunting = 10,
						/obj/item/gun/ballistic/revolver/colt357 = 10,
						/obj/item/gun/ballistic/rifle/mosin = 10,
						/obj/item/gun/ballistic/revolver/caravan_shotgun = 10,
						/obj/item/gun/ballistic/revolver/widowmaker = 10,
						/obj/item/gun/ballistic/revolver/winchesterrebored = 10,
						/obj/item/gun/ballistic/automatic/autopipe = 15,
						/obj/item/gun/ballistic/rifle/hobo/lasmusket = 15,
						)

/obj/machinery/mineral/wasteland_trader/gunbuyer/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "<b>Bottle caps stored:</b> [stored_caps]. <A href='?src=[REF(src)];choice=eject'>Eject caps</A><br>"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Disarming the Wasteland one gun at a time.</b><br>"
	dat += "<b>Warning: The automated system cannot guarantee an accurate appraisal of value.</b><br>"
	dat += "<b>Accepted goods and prices:</b><br>"
	dat += "Pistols and revolvers: 5-10 caps<br>"
	dat += "Rifles and Shotguns : 10-15 caps<br>"
	dat += "Does not accept weapons of historical or artisanal value. Those belong in a musuem."
	dat += ""
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Trading point", 400, 500)
	popup.set_content(dat)
	popup.open()
	return
