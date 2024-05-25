//This is the file that handles donator loadout items.

/datum/gear/donator
	name = "IF YOU SEE THIS, PING A CODER RIGHT NOW!"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/storage/belt/shoulderholster/ranger45
	category = LOADOUT_CATEGORY_DONATOR
	ckeywhitelist = list("This entry should never appear with this variable set.") //If it does, then that means somebody fucked up the whitelist system pretty hard
	cost = 0

/datum/gear/donator/donortestingbikehorn
	name = "Donor item testing"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/storage/belt/shoulderholster/ranger45
	geargroupID = list("DONORTEST") //This is a list mainly for the sake of testing, but geargroupID works just fine with ordinary strings

/datum/gear/donator/monke1818
	name = "CIA Badge"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/clothing/accessory/cia_badge
	ckeywhitelist = list("monke1818")

// COYOTE FLUFF ITEMS

/obj/item/weldingtool/largetank/cylphie //Virtually the same as an industrial but slightly faster
	name = "Cylphie's welding tool"
	desc = "A heavily altered industrial welding tool stolen from the brotherhood."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "welder"
	toolspeed = 0.5
	max_fuel = 40
	custom_materials = list(/datum/material/glass=60)

/obj/item/clothing/gloves/ring/plasma/lucine
	name = "plasma ring"
	desc = "This ring is stylized to have an ornate sun, with a sample of phoron swirling around inside. An inscription reads: my undying love and affection, For my Sunflower."
	icon_state = "ringplasma"
	item_state = "pring"
	mood_event_on_equip = /datum/mood_event/equipped_ring/plasma

/datum/gear/donator/mrsanderp
	name = "Happy Sharky Company Cuisine Book"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/book/granter/crafting_recipe/happysharky
	category = LOADOUT_CATEGORY_BACKPACK
	ckeywhitelist = list("mr.sanderp")
	cost = 0

/obj/item/clothing/mask/surgical/sloaff
	name = "rusty muzzle"
	desc = "A rusted steel muzzle. It’s covered in scratches."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "muzzle"
	item_state = "blindfold"
	flags_cover = MASKCOVERSMOUTH
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.9
	equip_delay_other = 20
	mutantrace_variation = STYLE_MUZZLE

/obj/item/card/id/dogtag/darknova
	name = "holo dogtag"
	icon_state = "holodogtag"
	desc = "An advanced holographic dogtag that seems to have a coded pattern imprinted on its side, as if implying it can be interfaced with certain devices. This one in particular denotes the owner being Nikolatz, J. S with an identifier of Ship Captain, Eyes of Dorian. The sex is listed as male, the blood type is listed as O positive, and a serial number is written of 242-355-179-22. The text ends at the end of the serial number, a duplicate tag is joined with the same information using a small chain."
	assignment = "ID tags"
	uses_overlays = FALSE

/obj/item/card/id/dogtag/prismaticnova
	name = "holo dogtag"
	icon_state = "holodogtag"
	desc = "An advanced holographic dogtag that seems to have a coded pattern imprinted on its side, as if implying it can be interfaced with certain devices. This one in particular denotes the owner being Amethyst with an identifier of Ship Pilot, Eyes of Dorian. The sex is listed as female, the blood type is listed as A positive, and a serial number is written of 243-331-173-49. The text ends at the end of the serial number, a duplicate tag is joined with the same information using a small chain."
	assignment = "ID tags"
	uses_overlays = FALSE

/obj/item/card/id/dogtag/radiantflash
	name = "holo dogtag"
	icon_state = "holodogtag"
	desc = "An advanced holographic dogtag that shows the duty of a BoS member. This one in particular is assigned to a Rynn Morand  with a rank of senior scribe. The sex is listed as male, the blood type is listed as O negative, A serial number is written of 210-463-053-15. The last line then reads: WCBOS-C CB-04 along with an insignia depicting wings, cogwheels and a sword."
	assignment = "ID tags"
	uses_overlays = FALSE

/obj/item/clothing/suit/armor/light/kit/punk/labcoat/trailsworth
	name = "salvaged medical labcoat" //modified from the already-custom armored labcoat sprite.
	desc = "A mix of lightweight salvaged Brotherhood armor and an old labcoat. Not nearly as protective as it used to be, however. It seems to have blue medical crosses spray-painted on, and a name patch on the side. 'Trailsworth'."
	icon_state = "armored_labcoat_trailsworth"
	item_state = "armored_labcoat_trailsworth"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/melee/onehanded/club/fryingpan/saltspider
	name = "well-cleaned frying pan"
	desc = "An ancient cast iron frying pan.<br>It's heavy, but fairly useful if you need to keep the mutants away, and don't have a better weapon around. This one seems to be kept in remarkable condition. Along the outside edge of the pan is a series of engravings- it reads 'Dolorem Ipsum'"
	force = 23 //-1 damage
	throwforce = 40 //2x throwdamage, goofy

/obj/item/clothing/suit/armor/light/duster/brahmin/saltspider
	name = "hand-sewn brahmin leather duster"
	desc = "A duster made from tanned brahmin hide. It has a thick waxy surface from the processing, making it surprisingly laser resistant. Along the collar reads 'Tu Stultes Es'"

/////////////////////
///Loadout Boxes///// See kits.dm, use this model for loadouts that have more than one item per character.
/////////////////////
/datum/gear/donator/kits
	slot = SLOT_IN_BACKPACK

/*example
/datum/gear/donator/kits/averyamadeus
	name = "Avery Amadeus' belongings"
	path = /obj/item/storage/box/large/custom_kit/averyamadeus
	ckeywhitelist = list("topbirb")
*/

//Please alphebetize entries by ckey.
// A

/datum/gear/donator/kits/aerodynamique
	name = "Yee-Haw Sharpshooter Kit"
	path = /obj/item/storage/box/large/custom_kit/aerodynamique
	ckeywhitelist = list("aerodynamique")

/obj/item/storage/box/large/custom_kit/aerodynamique/PopulateContents()
	new /obj/item/gun/ballistic/rifle/repeater/trail(src)
//	new /obj/item/gun_upgrade/scope/watchman(src) // for now just icing their attachments, when they play they'll complain

/datum/gear/donator/kits/aerodynamique2
	name = "Ancient Huntress' Bounty"
	path = /obj/item/storage/box/large/custom_kit/aerodynamique2
	ckeywhitelist = list("aerodynamique")

/obj/item/storage/box/large/custom_kit/aerodynamique2/PopulateContents()
	new /obj/item/clothing/suit/armor/light/tribal/geckocloak(src)
	new /obj/item/twohanded/sledgehammer/simple(src)
	new /obj/item/throwing_star/spear(src)
	new /obj/item/throwing_star/spear(src)

/datum/gear/donator/kits/aerodynamique3
	name = "Kalcia Loadout Time!"
	path = /obj/item/storage/box/large/custom_kit/aerodynamique3
	ckeywhitelist = list("aerodynamique")

/obj/item/storage/box/large/custom_kit/aerodynamique3/PopulateContents()
	//new /obj/item/gun/ballistic/bow/sturdy(src)
	new /obj/item/gun/ballistic/bow/modern(src)
	new /obj/item/storage/bag/tribe_quiver/light/full(src)
	new /obj/item/reagent_containers/pill/patch/jet(src)

/datum/gear/donator/kits/aldrictalvalin
	name = "Aldric's Supply Kit"
	path = /obj/item/storage/box/large/custom_kit/aldrictalvalin
	ckeywhitelist = list("aldrictalvalin")

/obj/item/storage/box/large/custom_kit/aldrictalvalin/PopulateContents()
	new /obj/item/clothing/under/f13/enclave/peacekeeper(src)
	new /obj/item/clothing/suit/armor/medium/combat/enclave/aldric(src)
	new /obj/item/melee/transforming/plasmacutter/regular/eve(src)
	new /obj/item/clothing/glasses/welding(src)
	new /obj/item/gun/energy/laser/plasma/castereve(src)
	new /obj/item/bedsheet/zebra(src)
	new /obj/item/clothing/head/helmet/f13/ncr/rangercombat/foxcustom(src)
	new /obj/item/reagent_containers/food/snacks/f13/canned/dog(src) // evil and fucked up

/datum/gear/donator/kits/rinpin
	name = "Lee's stash"
	path = /obj/item/storage/box/large/custom_kit/rinpin
	ckeywhitelist = list("Pootismaniac")

/obj/item/storage/box/large/custom_kit/rinpin/PopulateContents()
	new /obj/item/clothing/head/helmet/f13/metalmask/custom(src)
	new /obj/item/gun/ballistic/rifle/magnetic(src)
	new /obj/item/melee/unarmed/sappers/fightgloves(src)
/datum/gear/donator/kits/archyzt
	name = "Follower's Traveler"
	path = /obj/item/storage/box/large/custom_kit/archyzt
	ckeywhitelist = list("archyzt")

/obj/item/storage/box/large/custom_kit/archyzt/PopulateContents()
	new /obj/item/clothing/suit/toggle/labcoat/paramedic(src)
	new /obj/item/storage/backpack/medic(src)
	new /obj/item/pda/medical(src)
	new /obj/item/gun/energy/laser/pistol(src)

/datum/gear/donator/kits/arandomhyena
	name = "Old Sergant's Kit"
	path = /obj/item/storage/box/large/custom_kit/arandomhyena
	ckeywhitelist = list("ARandomHyena")

/obj/item/storage/box/large/custom_kit/arandomhyena/PopulateContents()
	new /obj/item/clothing/head/f13/enclave/peacekeeper(src)
	new /obj/item/clothing/accessory/enclave/sergeant(src)
	new /obj/item/clothing/shoes/f13/enclave/serviceboots(src)
	new /obj/item/clothing/head/f13/enclave/peacekeeper(src)

// B

/datum/gear/donator/kits/baticon
	name = "Laser Bat Kit"
	path = /obj/item/storage/box/large/custom_kit/baticon
	ckeywhitelist = list("baticon")

/obj/item/storage/box/large/custom_kit/baticon/PopulateContents()
	new /obj/item/gun/energy/laser/pistol(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)

/datum/gear/donator/kits/bladeburstninja
	name = "Split-Noggin's Box"
	path = /obj/item/storage/box/large/custom_kit/bladeburstninja
	ckeywhitelist = list("bladeburstninja")

/obj/item/storage/box/large/custom_kit/bladeburstninja/PopulateContents()
	//new /obj/item/gun/ballistic/bow/silver(src)
	new /obj/item/gun/ballistic/bow/modern(src)
	new /obj/item/clothing/head/helmet/f13/metalmask(src)
	new /obj/item/clothing/suit/armor/light/leather/leathermk2(src)
	new /obj/item/clothing/accessory/talisman(src)
	new /obj/item/storage/bag/tribe_quiver(src)

/datum/gear/donator/kits/bladeburstninja2
	name = "Space Monkey Kit"
	path = /obj/item/storage/box/large/custom_kit/bladeburstninja2
	ckeywhitelist = list("bladeburstninja")

/obj/item/storage/box/large/custom_kit/bladeburstninja2/PopulateContents()
	new /obj/item/melee/unarmed/sappers(src)
	new /obj/item/clothing/head/helmet/space/eva(src)
	new /obj/item/clothing/under/rank/civilian/curator/nasa(src)

/datum/gear/donator/kits/bladeburstninja3
	name = "Bone Zone Kit"
	path = /obj/item/storage/box/large/custom_kit/bladeburstninja3
	ckeywhitelist = list("bladeburstninja")

/obj/item/storage/box/large/custom_kit/bladeburstninja3/PopulateContents()
	new /obj/item/clothing/head/helmet/knight/yellow(src)
	new /obj/item/clothing/glasses/sunglasses/reagent(src)
	new /obj/item/clothing/suit/armor/light/poachervest(src)
	new /obj/item/clothing/gloves/bracer(src)

/datum/gear/donator/kits/bonirus
	name = "Xal-SH Kit"
	path = /obj/item/storage/box/large/custom_kit/bonirus
	ckeywhitelist = list("bonirus")

/obj/item/storage/box/large/custom_kit/bonirus/PopulateContents()
	new /obj/item/clothing/head/cone(src)
	new /obj/item/gun/energy/laser/sida(src)
	new /obj/item/clothing/accessory/bos/initiateS(src)
	new /obj/item/clothing/accessory/bos/headscribe(src)
	new /obj/item/pizzabox/infinite(src)
	new /obj/item/clothing/glasses/welding(src)
	new /obj/item/flashlight/lantern(src)
	new /obj/item/toy/plush/mammal/fox/squishfox(src)

/datum/gear/donator/kits/bound2theground/strike
	name = "A Box for the Shadow"
	path = /obj/item/storage/box/large/custom_kit/strike
	ckeywhitelist = list("Bound2theground")

/obj/item/storage/box/large/custom_kit/strike/PopulateContents()
	new /obj/item/book/granter/crafting_recipe/blueprint/infiltrator(src)
	new /obj/item/melee/onehanded/knife/switchblade(src)
	new /obj/item/gun/ballistic/automatic/assault_rifle(src)
//	new /obj/item/gun_upgrade/muzzle/silencer(src) // for now just icing their attachments, when they play they'll complain

/datum/gear/donator/kits/matter7
	name = "A Box for the Smelly Circuit Sergal"
	path = /obj/item/storage/box/large/custom_kit/matter7
	ckeywhitelist = list("Matter7")

/obj/item/storage/box/large/custom_kit/matter7/PopulateContents()
	new /obj/item/gun/ballistic/revolver/colt357/mateba(src)

/datum/gear/donator/kits/applewhiskey
	name = "Huntress Customs Minigun"
	path = /obj/item/storage/box/large/custom_kit/applewhiskey
	ckeywhitelist = list("Apple Whisky")

/obj/item/storage/box/large/custom_kit/applewhiskey/PopulateContents()
	new /obj/item/gun/ballistic/babygun(src)

/datum/gear/donator/kits/brimcon
	name = "Gift from Claws"
	path = /obj/item/storage/box/large/custom_kit/brimcon
	ckeywhitelist = list("brimcon")

/obj/item/storage/box/large/custom_kit/brimcon/PopulateContents()
	new /obj/item/clothing/suit/armor/heavy/tribal/westernwayfarer(src)
	new /obj/item/clothing/head/helmet/f13/wastewarhat(src)
	new /obj/item/gun/ballistic/automatic/combat/worn/brim(src)
	new /obj/item/toy/scale(src)

/datum/gear/donator/kits/bwoincognito
	name = "Tasald's Kit"
	path = /obj/item/storage/box/large/custom_kit/bwoincognito
	ckeywhitelist = list("bwoincognito")

/obj/item/storage/box/large/custom_kit/bwoincognito/PopulateContents()
	new /obj/item/clothing/head/helmet/f13/brahmincowboyhat(src)
	new /obj/item/clothing/under/f13/ranger/modif_ranger(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/melee/onehanded/knife/trench(src)
	new /obj/item/storage/belt/legholster(src)
	new /obj/item/gun/ballistic/revolver/revolver45/gunslinger(src)
	new /obj/item/ammo_box/a45lcrev(src)
	new /obj/item/ammo_box/a45lcrev(src)
	new /obj/item/ammo_box/a45lcbox(src)
	new /obj/item/lighter/fusion(src)
	new /obj/item/book/granter/crafting_recipe/poultice(src)
	new /obj/item/book/granter/crafting_recipe/happysharky(src)
	new /obj/item/clothing/suit/armor/light/leather/leathercoat(src)
	new /obj/item/circuitboard/machine/biogenerator(src)
	new /obj/item/circuitboard/machine/plantgenes(src)
	new /obj/item/circuitboard/machine/seed_extractor(src)
	new /obj/item/circuitboard/machine/smartfridge(src)
	new /obj/item/disk/plantgene(src)
	new /obj/item/disk/plantgene(src)
// C

/datum/gear/donator/kits/colfer
	name = "parmesan smelling box"
	path = /obj/item/storage/box/large/custom_kit/colfer
	ckeywhitelist = list("colfer")

/obj/item/storage/box/large/custom_kit/colfer/PopulateContents()
	name = "parmesan smelling box"
	new /obj/item/clothing/head/peaceflower(src)
	new /obj/item/melee/classic_baton/telescopic/contractor_baton(src)

/datum/gear/donator/kits/caseapollo58143
	name = "Missionary Kit"
	path = /obj/item/storage/box/large/custom_kit/caseapollo58143
	ckeywhitelist = list("caseapollo58143")

/obj/item/storage/box/large/custom_kit/caseapollo58143/PopulateContents()
	new /obj/item/nullrod/rosary(src)
	new /obj/item/gun/ballistic/automatic/pistol/m1911/custom(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/storage/belt/legholster(src)
	new /obj/item/storage/book/bible(src)

/datum/gear/donator/kits/caseapollo58143_2
	name = "Missionary Preacher Kit"
	path = /obj/item/storage/box/large/custom_kit/caseapollo58143_2
	ckeywhitelist = list("caseapollo58143")

/obj/item/storage/box/large/custom_kit/caseapollo58143_2/PopulateContents()
	new /obj/item/clothing/suit/armor/light/duster/battlecoat(src)
	new /obj/item/nullrod/rosary(src)
	new /obj/item/gun/ballistic/rifle/mosin(src)
	new /obj/item/reagent_containers/food/drinks/flask/russian(src)
	new /datum/uplink_item/device_tools/syndicate_eyepatch(src)
	new /obj/item/clothing/shoes/russian(src)
	new /obj/item/clothing/under/syndicate/rus_army(src)

/datum/gear/donator/kits/caseapollo58143_3
	name = "Missionary Eyepatch Kit"
	path = /obj/item/storage/box/large/custom_kit/caseapollo58143_3
	ckeywhitelist = list("caseapollo58143")

/obj/item/storage/box/large/custom_kit/caseapollo58143_3/PopulateContents()
	new /obj/item/clothing/glasses/eyepatch/syndicate(src)
	new /obj/item/grown/rose(src)
	new /obj/item/clothing/under/rank/security/detective/brown(src)
	new /obj/item/clothing/suit/det_suit/forensicsblue(src)
	new /obj/item/gun/ballistic/revolver/colt357/mateba(src)
	new /obj/item/lighter/bullet(src)

/datum/gear/donator/kits/caseapollo58143_4
	name = "Smogsuit Kit"
	path = /obj/item/storage/box/large/custom_kit/caseapollo58143_4
	ckeywhitelist = list("caseapollo58143")

/obj/item/storage/box/large/custom_kit/caseapollo58143_4/PopulateContents()
	new /obj/item/clothing/head/helmet/f13/combat/rangerbroken/smog(src)
	new /obj/item/clothing/suit/armor/light/kit/dustersmog(src)

/datum/gear/donator/kits/cavusogluzevk
	name = "Raider Kit"
	path = /obj/item/storage/box/large/custom_kit/cavusogluzevk
	ckeywhitelist = list("cavusogluzevk")

/obj/item/storage/box/large/custom_kit/cavusogluzevk/PopulateContents()
	new /obj/item/storage/belt/military/alt(src)
	new /obj/item/melee/onehanded/knife/trench(src)
	new /obj/item/melee/unarmed/brass/spiked(src)
	new /obj/item/clothing/suit/armor/light/raider/painspike(src)
	new /obj/item/gun/ballistic/automatic/pistol/sig/worn(src)

/datum/gear/donator/kits/cavusogluzevk2
	name = "B.O.S Loadout"
	path = /obj/item/storage/box/large/custom_kit/cavusogluzevk2
	ckeywhitelist = list("cavusogluzevk")

/obj/item/storage/box/large/custom_kit/cavusogluzevk2/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/n99/crusader(src)
	new /obj/item/clothing/accessory/bos/scribe(src)
	new /obj/item/storage/belt/army/assault(src)
	new /obj/item/melee/unarmed/brass/spiked(src)
	new /obj/item/melee/onehanded/knife/survival(src)

/datum/gear/donator/kits/calebc789
	name = "The old fashioned"
	path = /obj/item/storage/box/large/custom_kit/calebc789
	ckeywhitelist = list("calebc789")

/obj/item/storage/box/large/custom_kit/calebc789/PopulateContents()
	new /obj/item/gun/ballistic/automatic/sovietantimaterial(src)
	new /obj/item/ammo_box/a50MGbox(src)
	new /obj/item/ammo_box/a50MGbox(src)

/datum/gear/donator/kits/calebc7892
	name = "The Liberation"
	path = /obj/item/storage/box/large/custom_kit/calebc7892
	ckeywhitelist = list("calebc789")

/obj/item/storage/box/large/custom_kit/calebc7892/PopulateContents()
	new /obj/item/gun/ballistic/automatic/z34rifle/needlercustom(src)
	new /obj/item/ammo_box/needlercapsule(src)
	new /obj/item/ammo_box/needlercapsule(src) //provided two given when I spawned some in for testing, some came empty or half of their capsule. Needs fixing when possible.

// D

/datum/gear/donator/kits/dameonowen
	name = "Dragon Stash"
	path = /obj/item/storage/box/large/custom_kit/dameonowen
	ckeywhitelist = list("dameonowen", "andyman105")

/obj/item/storage/box/large/custom_kit/dameonowen/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/sig/trusty(src)
	new /obj/item/ammo_box/magazine/m45/rubber(src)
	new /obj/item/ammo_box/magazine/m45/rubber(src)
	new /obj/item/ammo_box/c45/rubber(src)
	new /obj/item/storage/belt/legholster(src)
	new /obj/item/gun/ballistic/automatic/marksman/worn(src)
	new /obj/item/clothing/suit/armor/light/duster/town/leather(src)

/datum/gear/donator/kits/DeadWolf411
	name = "Drop Shock Orian"
	path = /obj/item/storage/box/large/custom_kit/DeadWolf411
	ckeywhitelist = list("DeadWolf411")

/obj/item/storage/box/large/custom_kit/DeadWolf411/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/fivemilimeterpistol/custom2(src)
	new /obj/item/gun/ballistic/automatic/pistol/fivemilimeterpistol/custom1(src)
	new /obj/item/ammo_box/m5mmbox(src)
	new /obj/item/ammo_box/m5mmbox(src)
	new /obj/item/clothing/suit/armor/medium/wolf(src)
/datum/gear/donator/kits/dameonowencoat
	name = "Dragon Coat"
	path = /obj/item/clothing/suit/armor/light/duster/town/leather
	ckeywhitelist = list("dameonowen", "andyman105")
	cost = 1

/datum/gear/donator/kits/dameonowencart
	name = "Experimental Nanite Factory Cartridge"
	path = /obj/item/cartridge/resize
	ckeywhitelist = list("dameonowen", "andyman105")

/datum/gear/donator/kits/darknova92
	name = "Nikolatz Military Set"
	path = /obj/item/storage/box/large/custom_kit/darknova92
	ckeywhitelist = list("darknova92")

/obj/item/storage/box/large/custom_kit/darknova92/PopulateContents()
	new /obj/item/card/id/dogtag/darknova(src)
	new /obj/item/reagent_containers/food/drinks/flask/tech(src)
	new /obj/item/gun/energy/laser/aer9(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)

/datum/gear/donator/kits/dezuel
	name = "Lunas Stash"
	path = /obj/item/storage/box/large/custom_kit/dezuel
	ckeywhitelist = list("dezuel")

/obj/item/storage/box/large/custom_kit/dezuel/PopulateContents()
	new /obj/item/gun/ballistic/revolver/police(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/bedsheet/cult(src)

/datum/gear/donator/kits/Delta_DavGrunt
    name = "Grunt-Cop Kit"
    path = /obj/item/storage/box/large/custom_kit/Delta_DavGrunt
    ckeywhitelist = list("delta_dav")

/obj/item/storage/box/large/custom_kit/Delta_DavGrunt/PopulateContents()
    new /obj/item/clothing/head/f13/ncr/steelpot_mp(src)
    new /obj/item/clothing/under/f13/ncr/ncr_dress(src)
    new /obj/item/clothing/accessory/armband/black(src)

/datum/gear/donator/kits/Delta_DavTrek
	name = "Voyager Equipment Kit"
	path = /obj/item/storage/box/large/custom_kit/Delta_DavTrek
	ckeywhitelist = list("delta_dav")

/obj/item/storage/box/large/custom_kit/Delta_DavTrek/PopulateContents()
	new /obj/item/clothing/under/trek/medsci/voy(src)
	new /obj/item/gun/energy/laser/pistol/phaser(src)
	new /obj/item/gun/energy/laser/pistol/phaser/disable(src)

/datum/gear/donator/kits/dirtyoldharry
	name = "Custom loadout kit."
	path = /obj/item/storage/box/large/custom_kit/dirtyoldharry
	ckeywhitelist = list("DirtyOldHarry")

/obj/item/storage/box/large/custom_kit/dirtyoldharry/PopulateContents()
	new /obj/item/gun/energy/laser/aer9(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)

// E

/datum/gear/donator/kits/esperkin
	name = "Alchemist's Kit"
	path = /obj/item/storage/box/large/custom_kit/esperkin
	ckeywhitelist = list("esperkin")

/obj/item/storage/box/large/custom_kit/esperkin/PopulateContents()
	new /obj/item/clothing/mask/gas/glass(src)
	new /obj/item/melee/onehanded/knife/ritualdagger(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/clothing/glasses/welding(src)
	new /obj/item/gun/energy/laser/pistol(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/smelling_salts(src)
	new /obj/item/circuitboard/machine/chem_dispenser(src)

/datum/gear/donator/kits/Escamado
	name = "Blacksmith's Kit"
	path = /obj/item/storage/box/large/custom_kit/Escamado
	ckeywhitelist = list("Escamado")

/obj/item/storage/box/large/custom_kit/Escamado/PopulateContents()
	new /obj/item/survivalcapsule/blacksmith(src)
	new /obj/item/melee/smith/hammer/premadeadam(src)

// F

/datum/gear/donator/kits/ferisramsay
	name = "Feris' Box"
	path = /obj/item/storage/box/large/custom_kit/ferisramsay
	ckeywhitelist = list("ferisramsay")

/obj/item/storage/box/large/custom_kit/ferisramsay/PopulateContents()
	new /obj/item/gun/energy/laser/wattz(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)

/datum/gear/donator/kits/ferisramsay2
	name = "Rhetta's Kit"
	path = /obj/item/storage/box/large/custom_kit/ferisramsay2
	ckeywhitelist = list("ferisramsay")

/obj/item/storage/box/large/custom_kit/ferisramsay2/PopulateContents()
	new /obj/item/gun/ballistic/rifle/repeater/cowboy(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/clothing/suit/armor/light/kit/plates(src)
//	new /obj/item/tool_upgrade/productivity/ergonomic_grip(src) // for now just icing their attachments, when they play they'll complain

/datum/gear/donator/kits/ferisramsay3
	name = "Maddy's Loadout"
	path = /obj/item/storage/box/large/custom_kit/ferisramsay3
	ckeywhitelist = list("ferisramsay")

/obj/item/storage/box/large/custom_kit/ferisramsay3/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/sig/worn(src)
	new /obj/item/gun/ballistic/automatic/pistol/sig/worn(src)

/datum/gear/donator/kits/fireclaw787
	name = "Jade's Loadout"
	path = /obj/item/storage/box/large/custom_kit/fireclaw787
	ckeywhitelist = list("fireclaw787")

/// cure the whole wasteland of the *scourge* that is not having mountainous tits
/obj/item/storage/box/large/custom_kit/fireclaw787/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/storage/pill_bottle/breast_enlarger(src)

/datum/gear/donator/kits/fuzlet
	name = "fuzzy supply box"
	path = /obj/item/storage/box/large/custom_kit/fuzlet
	ckeywhitelist = list("fuzlet", "superlagg")

/obj/item/storage/box/large/custom_kit/fuzlet/PopulateContents()
	new /obj/item/card/fuzzy_license(src)
	new /obj/item/geiger_counter(src)
	new /obj/item/toy/plush/mammal/fox/fuzzy(src)
	new /obj/item/stack/marker_beacon/thirty(src)
	new /obj/item/storage/survivalkit/combat/empty(src)

/datum/gear/donator/kits/fuzlet2
	name = "Scavfox Kit"
	path = /obj/item/storage/box/large/custom_kit/fuzlet2
	ckeywhitelist = list("fuzlet")

/obj/item/storage/box/large/custom_kit/fuzlet2/PopulateContents()
	new /obj/item/storage/survivalkit/triple(src)
	new /obj/item/storage/bag/trash/sack(src)

/datum/gear/donator/kits/fuzlet3
	name = "Snowfox Kit"
	path = /obj/item/storage/box/large/custom_kit/fuzlet3
	ckeywhitelist = list("fuzlet")

/obj/item/storage/box/large/custom_kit/fuzlet3/PopulateContents()
	new /obj/item/dnainjector/geladikinesis(src)

/datum/gear/donator/kits/fuzlet4
	name = "Brewing Kit"
	path = /obj/item/storage/box/large/custom_kit/fuzlet4
	ckeywhitelist = list("fuzlet")

/obj/item/storage/box/large/custom_kit/fuzlet4/PopulateContents()
	new /obj/item/seeds/aloe(src)
	new /obj/item/seeds/wheat(src)
	new /obj/item/seeds/wheat/oat(src)
	new /obj/item/seeds/corn(src)
	new /obj/item/seeds/potato(src)
	new /obj/item/seeds/sugarcane(src)
	new /obj/item/paper_bin(src)
	new /obj/item/storage/bag/plants/portaseeder(src)
	new /obj/item/stack/sheet/mineral/wood/fifty(src)

// G

/datum/gear/donator/kits/generalpantsu
	name = "Appropriated Brotherhood Supplies"
	path = /obj/item/storage/box/large/custom_kit/generalpantsu
	ckeywhitelist = list("generalpantsu")

/obj/item/storage/box/large/custom_kit/generalpantsu/PopulateContents()
	new /obj/item/clothing/head/helmet/armyhelmet/heavy(src)
	new /obj/item/storage/belt/shoulderholster/kemble(src)
	new /obj/item/storage/belt/army/assault(src)
//	new /obj/item/gun/ballistic/revolver/m2405(src) //YEAH UH, NO
	new /obj/item/melee/unarmed/tigerclaw(src)
	new /obj/item/lighter/fusion(src)

/datum/gear/donator/kits/gozulio
	name = "Jess' Kit"
	path = /obj/item/storage/box/large/custom_kit/gozulio
	ckeywhitelist = list("gozulio")

/obj/item/storage/box/large/custom_kit/gozulio/PopulateContents()
	new /obj/item/pda/medical(src)
	new /obj/item/storage/medical/ancientfirstaid(src)
	new /obj/item/storage/belt/shoulderholster(src)
	new /obj/item/gun/energy/laser/pistol(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/healthanalyzer/advanced(src)
	new /obj/item/clothing/gloves/color/latex/nitrile(src)

/datum/gear/donator/kits/greed2323
	name = "Greed Kit"
	path = /obj/item/storage/box/large/custom_kit/greed2323
	ckeywhitelist = list("greed2323")

/obj/item/storage/box/large/custom_kit/greed2323/PopulateContents()
	new /obj/item/gun/ballistic/revolver/m29/alt(src)
//	new /obj/item/gun_upgrade/trigger/raidertrigger(src) // for now just icing their attachments, when they play they'll complain

// H

// I

/datum/gear/donator/kits/icefistthunderdick
	name = "Sindy Kit"
	path = /obj/item/storage/box/large/custom_kit/icefistthunderdick
	ckeywhitelist = list("icefistthunderdick")

/obj/item/storage/box/large/custom_kit/icefistthunderdick/PopulateContents()
	name = "Sindy Kit"
	var/obj/item/lighter/zippo = new /obj/item/lighter(src)
	zippo.overlay_state = "snake"
	zippo.update_icon()

	var/obj/item/melee/transforming/plasmacutter/sword/esword = new /obj/item/melee/transforming/plasmacutter/sword(src)
	esword.sword_color = "red"

	var/obj/item/clothing/suit/space/hardsuit/syndi/suit = new /obj/item/clothing/suit/space/hardsuit/syndi(src)
	qdel(suit.jetpack)
	suit.armor = suit.armor.modifyRating(rad = -5)

	var/obj/item/card = new /obj/item(src)
	card.icon = 'icons/obj/card.dmi'
	card.icon_state = "emag"
	card.name = "cryptographic sequencer"
	card.desc = "The cryptographic sequencer, electromagnetic card, or emag, is a small card that unlocks hidden functions \
			in electronic devices, subverts intended functions, and easily breaks security mechanisms. \
			However, this one seems non-functional."
	card.AddComponent(/datum/component/squeak)
	card.w_class = WEIGHT_CLASS_SMALL


/datum/gear/donator/kits/imbubbl101
	name = "Magnum Kit"
	path = /obj/item/storage/box/large/custom_kit/imbubbl101
	ckeywhitelist = list("imbubbl101")

/obj/item/storage/box/large/custom_kit/imbubbl101/PopulateContents()
	new /obj/item/clothing/head/f13/enclave/peacekeeper(src)
	new /obj/item/storage/belt/military(src)

/datum/gear/donator/kits/imbubbl101_2
	name = "Syndi Kit"
	path = /obj/item/storage/box/large/custom_kit/imbubbl101_2
	ckeywhitelist = list("imbubbl101")

/obj/item/storage/box/large/custom_kit/imbubbl101_2/PopulateContents()
	new /obj/item/clothing/accessory/waistcoat(src)
	new /obj/item/clothing/glasses/science/f13(src)
	new /obj/item/melee/classic_baton/telescopic(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_syndicate(src)

/datum/gear/donator/kits/irkallaepsilon
    name = "Protective Equipment and Analysis Tools"
    path = /obj/item/storage/box/large/custom_kit/irkallaepsilon
    ckeywhitelist = list("irkallaepsilon")

/obj/item/storage/box/large/custom_kit/irkallaepsilon/PopulateContents()
    new /obj/item/circuitboard/machine/plantgenes(src)
    new /obj/item/circuitboard/machine/biogenerator(src)
    new /obj/item/circuitboard/machine/seed_extractor(src)
    new /obj/item/clothing/mask/gas/syndicate(src)

// J

/datum/gear/donator/kits/jackalface
	name = "Jackal Kit"
	path = /obj/item/storage/box/large/custom_kit/jackalface
	ckeywhitelist = list("jackalface")

/obj/item/storage/box/large/custom_kit/jackalface/PopulateContents()
	new /obj/item/clothing/under/draculass(src)
	new /obj/item/clothing/mask/chameleon(src)
	new /obj/item/gun/ballistic/automatic/pistol/m1911/custom/jackal(src)

/datum/gear/donator/kits/jackson1112
	name = "Recon Kit"
	path = /obj/item/storage/box/large/custom_kit/jackson1112
	ckeywhitelist = list("jackson1112")

/obj/item/storage/box/large/custom_kit/jackson1112/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/cg45/worn(src)
	new /obj/item/ammo_box/magazine/cg45(src)
	new /obj/item/ammo_box/magazine/cg45(src)
	new /obj/item/melee/onehanded/knife/bayonet(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/storage/box/ration/ranger_breakfast(src)
	new /obj/item/clothing/head/helmet/f13/combat(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/radio(src)
	new /obj/item/binoculars(src)
	new /obj/item/shovel/trench(src)

/datum/gear/donator/kits/jackson1112_2
	name = "SAS Kit"
	path = /obj/item/storage/box/large/custom_kit/jackson1112_2
	ckeywhitelist = list("jackson1112")

/obj/item/storage/box/large/custom_kit/jackson1112_2/PopulateContents()
	new /obj/item/storage/belt/army(src)
	new /obj/item/gun/ballistic/rifle/enfield(src)
	new /obj/item/ammo_box/a308(src)
	new /obj/item/ammo_box/a308(src)
	new /obj/item/gun/ballistic/automatic/pistol/beretta(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/clothing/under/syndicate/camo(src)
//	new /obj/item/gun_upgrade/muzzle/silencer(src) // for now just icing their attachments, when they play they'll complain
	new /obj/item/radio(src)

/datum/gear/donator/kits/jademanique
	name = "Ifanse's Trinkets"
	path = /obj/item/storage/box/large/custom_kit/jademanique
	ckeywhitelist = list("jademanique")

/obj/item/storage/box/large/custom_kit/jademanique/PopulateContents()
	new /obj/item/voodoo(src)
	new /obj/item/clothing/mask/chameleon(src)

/datum/gear/donator/kits/jaeger
	name = "Huntress Customs"
	path = /obj/item/storage/box/large/custom_kit/jaeger
	ckeywhitelist = list("Kilment")

/obj/item/storage/box/large/custom_kit/jaeger/PopulateContents()
	new /obj/item/jaegerholopara(src)

/datum/gear/donator/kits/chewyexe
	name = "stash from the past"
	path = /obj/item/storage/box/large/custom_kit/chewyexe
	ckeywhitelist = list("Chewy.exe")

/obj/item/storage/box/large/custom_kit/chewyexe/PopulateContents()
	new	/obj/item/clothing/suit/armor/rangercombat(src)
	new	/obj/item/clothing/head/helmet/f13/ncr/rangercombat(src)
	new	/obj/item/gun/ballistic/rifle/mag/antimaterial/loadout(src)

/datum/gear/donator/kits/aphass
	name = "lapine smelling premium plasmacutter box"
	path = /obj/item/storage/box/large/custom_kit/aphass
	ckeywhitelist = list("Whirlsam")

/obj/item/storage/box/large/custom_kit/aphass/PopulateContents()
	new /obj/item/gun/energy/plasmacutter/adv(src)

/datum/gear/donator/kits/palpapus
	name = "Darth Plapappus Customs"
	path = /obj/item/storage/box/large/custom_kit/palpapus
	ckeywhitelist = list("lordpapalus", "Lord_Papalus")

/obj/item/storage/box/large/custom_kit/palpapus/PopulateContents()
	new /obj/item/clothing/head/helmet/f13/brahmincowboyhat(src)
	new /obj/item/clothing/suit/armor/medium/raider/combatduster(src)
	new /obj/item/clothing/under/f13/eighties(src)
	new /obj/item/clothing/shoes/f13/rag/pawb(src)
	new /obj/item/gun/ballistic/rifle/repeater/cowboy/tribal(src)
	new /obj/item/kit_spawner/tools(src)
	new /obj/item/clothing/gloves/f13/military(src)
	new /obj/item/clothing/neck/tie/aurora/strelitz_cape(src)
	new /obj/item/storage/backpack/trekker(src)

/datum/gear/donator/kits/jaggachi
	name = "Scug Industries Kit"
	path = /obj/item/storage/box/large/custom_kit/jaggachi
	ckeywhitelist = list("jaggachi")

/obj/item/storage/box/large/custom_kit/jaggachi/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/cg45/worn(src)

/datum/gear/donator/kits/jaggachi_2
	name = "NCR Service Kit"
	path = /obj/item/storage/box/large/custom_kit/jaggachi_2
	ckeywhitelist = list("jaggachi")

/obj/item/storage/box/large/custom_kit/jaggachi_2/PopulateContents()
	new /obj/item/gun/ballistic/automatic/m1carbine/compact(src)

/datum/gear/donator/kits/jaggachi_3
	name = "Hunting Kit"
	path = /obj/item/storage/box/large/custom_kit/jaggachi_3
	ckeywhitelist = list("jaggachi")

/obj/item/storage/box/large/custom_kit/jaggachi_3/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/automatic/combat/auto5(src)

/datum/gear/donator/kits/jaggachi_4
	name = "Gunslinging Kit"
	path = /obj/item/storage/box/large/custom_kit/jaggachi_4
	ckeywhitelist = list("jaggachi")

/obj/item/storage/box/large/custom_kit/jaggachi_4/PopulateContents()
	new /obj/item/gun/ballistic/rifle/repeater/volcanic(src)
	new /obj/item/gun/ballistic/rifle/repeater/volcanic(src)

/datum/gear/donator/kits/jaggachi_5
	name = "Laser Service Kit"
	path = /obj/item/storage/box/large/custom_kit/jaggachi_5
	ckeywhitelist = list("jaggachi")

/obj/item/storage/box/large/custom_kit/jaggachi_5/PopulateContents()
	new /obj/item/clothing/suit/armor/medium/combat/rusted(src)
	new /obj/item/clothing/head/helmet/f13/combat/rangerbroken(src)
	new /obj/item/gun/ballistic/rifle/antique/gras/laserfusil(src)

/datum/gear/donator/kits/jaggachi_6
	name = "Soviet Service Kit"
	path = /obj/item/storage/box/large/custom_kit/jaggachi_6
	ckeywhitelist = list("jaggachi")

/obj/item/storage/box/large/custom_kit/jaggachi_6/PopulateContents()
	new /obj/item/clothing/under/f13/modernbdu(src)
	new /obj/item/clothing/suit/armor/light/duster/russian_coat(src)
	new /obj/item/clothing/suit/armor/medium/heavierballisticvest/rusvest2(src)
	new /obj/item/clothing/head/kevlarhelmet/rus1(src)
	new /obj/item/gun/energy/laser/LaserAK/worn/jaggi(src)


/datum/gear/donator/kits/jaggachi_7
	name = "Medical wardrobe"
	path = /obj/item/storage/box/large/custom_kit/jaggachi_7
	ckeywhitelist = list("jaggachi")

/obj/item/storage/box/large/custom_kit/jaggachi_7/PopulateContents()
	new /obj/item/clothing/suit/coat/coyote/nurse_coat(src)
	new /obj/item/clothing/head/f13/nursehat(src)
	new /obj/item/clothing/under/rank/medical/doctor/nurse

// K

/datum/gear/donator/kits/Krerkruger
	name = "Automag"
	path = /obj/item/storage/box/large/custom_kit/Krerkruger
	ckeywhitelist = list("Krerkruger")

/obj/item/storage/box/large/custom_kit/Krerkruger/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/automag(src)
	new /obj/item/ammo_box/m44(src)

// L

/datum/gear/donator/kits/LilKuddles
	name = "MelMels Belongings"
	path = /obj/item/storage/box/large/custom_kit/kuddles2
	ckeywhitelist = list("LilKuddles")

/obj/item/storage/box/large/custom_kit/kuddles2/PopulateContents()
	new /obj/item/clothing/under/f13/customelody(src)


/datum/gear/donator/kits/lifelessghoul
	name = "Ancient Memories"
	path = /obj/item/storage/box/large/custom_kit/lifelessghoul
	ckeywhitelist = list("lifelessghoul")

/obj/item/storage/box/large/custom_kit/lifelessghoul/PopulateContents()
	new /obj/item/melee/smith/hammer(src)
	new /obj/item/clothing/head/helmet/f13/legion/orator(src)
	new /obj/item/flashlight/lantern(src)

/datum/gear/donator/kits/lucine
	name = "Earlong Travel Supplies"
	path = /obj/item/storage/box/large/custom_kit/lucine
	ckeywhitelist = list("lucine")

/obj/item/storage/box/large/custom_kit/lucine/PopulateContents()
	//new /obj/item/gun/energy/laser/freeblade(src)
	//new /obj/item/gun/energy/laser/freeblade(src)
	//new /obj/item/stock_parts/cell/ammo/ec(src)
	//new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/gun/flintlock/laser(src)
	new /obj/item/gun/flintlock/laser(src)
	new /obj/item/ammo_box/flintlock(src)
	new /obj/item/ammo_box/flintlock(src)
	new /obj/item/clothing/gloves/ring/plasma/lucine(src)
	new /obj/item/book/granter/martial/carp(src)

/datum/gear/donator/kits/lucine2
	name = "HAVOC"
	path = /obj/item/storage/box/large/custom_kit/lucine2
	ckeywhitelist = list("lucine")

/obj/item/storage/box/large/custom_kit/lucine2/PopulateContents()
	new /obj/item/clothing/head/helmet/knight/f13/metal(src)
	new /obj/item/gun/energy/mmlbuster(src)

/datum/gear/donator/kits/lowpowermia
	name = "Gunslinger Kit"
	path = /obj/item/storage/box/large/custom_kit/lowpowermia
	ckeywhitelist = list("lowpowermia")

/obj/item/storage/box/large/custom_kit/lowpowermia/PopulateContents()
	new /obj/item/reagent_containers/pill/antirad_plus(src)
	new /obj/item/gun/ballistic/revolver/revolver45/gunslinger(src)
	new /obj/item/gun/ballistic/revolver/revolver45/gunslinger(src)
	new /obj/item/ammo_box/a45lcbox(src)
	new /obj/item/ammo_box/a45lcbox(src)

/datum/gear/donator/kits/littleplayer0102
	name = "The Brotherhood Specialist"
	path = /obj/item/storage/box/large/custom_kit/littleplayer0102
	ckeywhitelist = list("littleplayer0102")

/obj/item/storage/box/large/custom_kit/littleplayer0102/PopulateContents()
	new /obj/item/gun/ballistic/automatic/ak556/custom(src)
	new /obj/item/ammo_box/m5mmbox(src)
	new /obj/item/clothing/suit/armor/outfit/custompa(src)
	new /obj/item/clothing/under/f13/recon(src)
	new /obj/item/clothing/accessory/bos/paladin(src)
	new /obj/item/clothing/head/droptrooper/custompahelmet(src)

/datum/gear/donator/kits/luxyleatherhat
	name = "NV"
	path = /obj/item/storage/box/large/custom_kit/luxyleatherhat
	ckeywhitelist = list("luxyleatherhat")

/obj/item/storage/box/large/custom_kit/luxyleatherhat/PopulateContents()
	new /obj/item/gun/energy/laser/aer9(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)

// M

/datum/gear/donator/kits/mathiel
	name = "Annastasia's Kit"
	path = /obj/item/storage/box/large/custom_kit/mathiel
	ckeywhitelist = list("mathiel")

/obj/item/storage/box/large/custom_kit/mathiel/PopulateContents()
	new /obj/item/gun/ballistic/revolver/m29/alt(src)
	new /obj/item/clothing/head/helmet/f13/combat/swat(src)
	new /obj/item/clothing/suit/armor/medium/combat/swat(src)
	new /obj/item/clothing/shoes/jackboots/fakeswat(src)
	new /obj/item/clothing/suit/hooded/wintercoat/medical(src)
	new /obj/item/clothing/under/rank/medical/doctor/skirt(src)

/datum/gear/donator/kits/mathiel2
	name = "Xuretia's Kit"
	path = /obj/item/storage/box/large/custom_kit/mathiel2
	ckeywhitelist = list("mathiel")

/obj/item/storage/box/large/custom_kit/mathiel2/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/mini_uzi/mp5(src)
	new /obj/item/ammo_box/magazine/uzim9mm(src)
	new /obj/item/gun/ballistic/automatic/pistol/ninemil/glock(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/clothing/head/helmet/sec(src)
	new	/obj/item/clothing/suit/armor/medium/combat/swat(src)
	new	/obj/item/clothing/shoes/jackboots/fakeswat(src)

/obj/item/clothing/shoes/jackboots/fakeswat
	name = "\improper SWAT boots"
	desc = "High speed, no drag combat boots."
	icon_state = "combat"

/datum/gear/donator/kits/merek2
	name = "Brotherhood Kit"
	path = /obj/item/storage/box/large/custom_kit/merek2
	ckeywhitelist = list("merek2")

/obj/item/storage/box/large/custom_kit/merek2/PopulateContents()
	new /obj/item/clothing/suit/armor/light/duster/brahmin/biker(src)
	new /obj/item/reagent_containers/food/drinks/flask/vault113(src)
	new /obj/item/lighter/moff(src)
	new /obj/item/gun/energy/laser/wattzs(src)
	new /obj/item/radio/headset/headset_sci(src)
	new /obj/item/camera/coldwar(src)
	new /obj/item/clothing/ears/headphones(src)
	new /obj/item/clothing/neck/mantle/bos(src)
	new /obj/item/clothing/neck/mantle/treasurer(src)
	new /obj/item/card/id/dogtag(src)

/datum/gear/donator/kits/merek22
	name = "UNMC Kit"
	path = /obj/item/storage/box/large/custom_kit/merek22
	ckeywhitelist = list("merek2")

/obj/item/storage/box/large/custom_kit/merek22/PopulateContents()
	new /obj/item/gun/ballistic/automatic/p47merek (src)
	new /obj/item/ammo_box/a556(src)
	new /obj/item/clothing/suit/armor/medium/merek (src)
	new /obj/item/clothing/head/helmet/merekcustom(src)
	new /obj/item/warpaint_bowl(src)

/datum/gear/donator/kits/mrsanderp
	name = "Happy Sharky Co. Business Bundle"
	path = /obj/item/storage/box/large/custom_kit/exoticjazz
	ckeywhitelist = list("mrsanderp")

/obj/item/storage/box/large/custom_kit/exoticjazz/PopulateContents()
	new /obj/item/book/granter/crafting_recipe/happysharky(src)

// N

/datum/gear/donator/kits/neskah
	name = "IV items for Errant-XIV"
	path = /obj/item/storage/box/large/custom_kit/neskah
	ckeywhitelist = list("neskah")

/obj/item/storage/box/large/custom_kit/neskah/PopulateContents()
	name = "IV items for Errant-XIV"

	new /obj/item/clothing/head/helmet/f13/power_armor/fluff/errant(src)
	new /obj/item/clothing/suit/armor/power_armor/fluff/errant(src)

	var/obj/item/gun/energy/laser/wattz2ks/wattz = new /obj/item/gun/energy/laser/wattz2ks(src)
	wattz.name = "Staccato"
	wattz.desc = "A heavy self-charging pulse weapon kept in perfect operating condition, fitted with an OVRseer sensor-plug optical scope dialed for midrange encounters. 'XIV' is stamped onto the left side of its upper receiver."

	var/obj/item/gun/energy/laser/tg/recharger/pistol = new /obj/item/gun/energy/laser/tg/recharger(src)
	pistol.name = "Prelude"
	pistol.desc = "A bulky laser pistol, just small enough to be concealable. Coils and exposed wiring adorn what appear to be an extremely old experimental laser pistol design. Its cell seems to siphon electrical energy from the wearer, perfect for cybernetic individuals. XIV is etched into the left side of its grip."

/obj/item/clothing/head/helmet/f13/power_armor/fluff/errant
	name = "heavy robotic visor"
	desc = "A remarkably heavy helmet fitted for a square OVRmind cranium, with cables that link the wearer to an advanced observational visor."
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	icon_state = "eva3"
	item_state = "eva3"
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDEMASK|HIDEJUMPSUIT|HIDESNOUT

/obj/item/clothing/head/helmet/f13/power_armor/fluff/errant/obj_break(damage_flag)
	return

/obj/item/clothing/head/helmet/f13/power_armor/fluff/errant/obj_destruction(damage_flag)
	return

/obj/item/clothing/suit/armor/power_armor/fluff/errant
	name = "servo-lined exoplating"
	desc = "A remarkably heavy set of plates designed to be bolted to an OVRmind-compatible cybernetic frame."
	icon_state = "markvi3"
	item_state = "markvi3"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/power_armor/fluff/errant/obj_break(damage_flag)
	return

/obj/item/clothing/suit/armor/power_armor/fluff/errant/obj_destruction(damage_flag)
	return

/datum/gear/donator/kits/nightmare6669
	name = "Chadsune"
	path = /obj/item/storage/box/large/custom_kit/nightmare6669
	ckeywhitelist = list("nightmare6669")

/obj/item/storage/box/large/custom_kit/nightmare6669/PopulateContents()
	new /obj/item/gun/ballistic/revolver/m29/alt(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/storage/belt/shoulderholster(src)
	new /obj/item/melee/onehanded/knife/trench(src)
	new /obj/item/clothing/head/helmet/f13/combat/swat(src)
	new /obj/item/clothing/suit/armor/medium/combat/swat(src)
	new /obj/item/melee/onehanded/machete/spatha(src)

// /datum/gear/donator/kits/nirzak
// 	name = "Vas Kit"
// 	path = /obj/item/storage/box/large/custom_kit/nirzak
// 	ckeywhitelist = list("nirzak")

// /obj/item/storage/box/large/custom_kit/nirzak/PopulateContents()
// 	new /obj/item/clothing/suit/armor/harpercoat(src)
// 	new /obj/item/stealthboy(src)
// 	new /obj/item/clothing/mask/gas/sechailer(src)
// 	new /obj/item/storage/belt/military(src)
// 	new /obj/item/clothing/head/helmet/armyhelmet/heavy(src)

// O

/datum/gear/donator/kits/octanerockwell
	name = "Baa and squeak loadout"
	path = /obj/item/storage/box/large/custom_kit/octanerockwell
	ckeywhitelist = list("octanerockwell")

/obj/item/storage/box/large/custom_kit/octanerockwell/PopulateContents()
	new /obj/item/gun/ballistic/revolver/Lemat(src)
	new /obj/item/gun/ballistic/automatic/z34rifle/custom(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/ammo_box/a308box(src)

// P

/obj/item/pet_carrier/eye
    name = "Eyebot Carrier"
    desc = "An unholy amalgamation of a pet carrier and a jury-rigged charging station- although the latter function probably doesn't work in any capacity."

/obj/item/pet_carrier/eye/Initialize()
    . = ..()
    var/mob/living/simple_animal/pet/dog/eyebot/panzer/pvt_eye = new(src)
    add_occupant(pvt_eye)

/datum/gear/donator/kits/panzer
	name = "Val's Equipment"
	path = /obj/item/storage/box/large/custom_kit/panzer
	ckeywhitelist = list("panzer1944")

/obj/item/storage/box/large/custom_kit/panzer/PopulateContents()
	new /obj/item/clothing/suit/armor/medium/duster/armoredcoat/panzer(src)
	new /obj/item/clothing/mask/gas/sechailer(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/clothing/under/f13/enclave/officer(src)
	new /obj/item/pet_carrier/eye(src)
	new /obj/item/gun/ballistic/revolver/m29/alt(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/card/id/selfassign/brotherenclave(src)
	new /obj/item/pda/warden(src)
	new /obj/item/clothing/accessory/enclave/lieutenant(src)

/datum/gear/donator/kits/pappavol
	name = "Tribal Power Kit"
	path = /obj/item/storage/box/large/custom_kit/pappavol
	ckeywhitelist = list("pappavol")

/obj/item/storage/box/large/custom_kit/pappavol/PopulateContents()
	new /obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/tribal/junk(src)
	new /obj/item/twohanded/sledgehammer/simple(src)

/datum/gear/donator/kits/pipes_wildin
	name = "Teyla's Kit"
	path = /obj/item/storage/box/large/custom_kit/pipes_wildin
	ckeywhitelist = list("pipes_wildin")

/obj/item/storage/box/large/custom_kit/pipes_wildin/PopulateContents()
	new /obj/item/gun/ballistic/automatic/combat/worn(src)

/datum/gear/donator/kits/pipes_wildin2
	name = "Zimnt's Kit"
	path = /obj/item/storage/box/large/custom_kit/pipes_wildin2
	ckeywhitelist = list("pipes_wildin")

/obj/item/storage/box/large/custom_kit/pipes_wildin2/PopulateContents()
	new /obj/item/stealthboy(src)

/datum/gear/donator/kits/pixelexip
	name = "Bruiser's Kit"
	path = /obj/item/storage/box/large/custom_kit/pixelexip
	ckeywhitelist = list("pixelexip")

/obj/item/storage/box/large/custom_kit/pixelexip/PopulateContents()
	new /obj/item/clothing/suit/armor/light/poachervest(src)
	new /obj/item/reagent_containers/food/drinks/flask/gold(src)
	new /obj/item/clothing/gloves/fingerless/pugilist/rapid(src)

/datum/gear/donator/kits/pixelexip2
	name = "Hypocritical Oath Kit"
	path = /obj/item/storage/box/large/custom_kit/pixelexip2
	ckeywhitelist = list("pixelexip")

/obj/item/storage/box/large/custom_kit/pixelexip2/PopulateContents()
	new /obj/item/gun/ballistic/rifle/hunting/special(src)

/datum/gear/donator/kits/pappavol
	name = "Bolter And Armor Kit"
	path = /obj/item/storage/box/large/custom_kit/pappavol
	ckeywhitelist = list("PappaVol")

/obj/item/storage/box/large/custom_kit/pappavol/PopulateContents()
	new /obj/item/gun/ballistic/automatic/compact14mmrifle/custom(src)
	new /obj/item/ammo_box/c10mm(src)
	new /obj/item/ammo_box/magazine/m10mm/adv(src)
	new /obj/item/clothing/suit/armor/power_armor/fluff/pappavol(src)
	new /obj/item/clothing/head/helmet/f13/power_armor/fluff/pappavol(src)

/datum/gear/donator/kits/planetary
	name = "Collector"
	path = /obj/item/storage/box/large/custom_kit/planetary
	ckeywhitelist = list("planetary")

/obj/item/storage/box/large/custom_kit/planetary/PopulateContents()
	new /obj/item/clothing/under/f13/chinasuitcosmetic(src)
	new /obj/item/clothing/head/f13/chinahelmetcosmetic(src)
	new /obj/item/clothing/suit/armor/harpercoat(src)
	new /obj/item/gun/ballistic/automatic/pistol/n99/crusader(src)
	new /obj/item/toy/plush/mammal/fox(src)

/datum/gear/donator/kits/planetary2
	name = "Replica"
	path = /obj/item/storage/box/large/custom_kit/planetary2
	ckeywhitelist = list("planetary")

/obj/item/storage/box/large/custom_kit/planetary2/PopulateContents()
	new /obj/item/clothing/suit/armor/heavy/riot/eliteweak(src)
	new /obj/item/clothing/head/helmet/f13/ncr/rangercombat/eliteriotweak(src)
	new /obj/item/gun/ballistic/revolver/revolver44/desert_ranger(src)

/datum/gear/donator/kits/PotatoPerson993
	name = "Gobbo Gear"
	path = /obj/item/storage/box/large/custom_kit/PotatoPerson993
	ckeywhitelist = list("PotatoPerson993")

/obj/item/storage/box/large/custom_kit/PotatoPerson993/PopulateContents()
	new /obj/item/clothing/under/f13/recon/outcast(src)
	new /obj/item/book/granter/crafting_recipe/blueprint/plasmarifle(src)

/datum/gear/donator/kits/prismaticnova
	name = "Blue's Kit"
	path = /obj/item/storage/box/large/custom_kit/prismaticnova
	ckeywhitelist = list("prismaticnova")

/obj/item/storage/box/large/custom_kit/prismaticnova/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/grown/poppy/geranium/forgetmenot(src)
	new /obj/item/lighter/fusion(src)
	new /obj/item/melee/onehanded/knife/trench(src)
	new /obj/item/slimecross/consuming/grey(src)

/datum/gear/donator/kits/prismaticnova2
	name = "Pharmaceutical Scientist Essentials"
	path = /obj/item/storage/box/large/custom_kit/prismaticnova2
	ckeywhitelist = list("prismaticnova")

/obj/item/storage/box/large/custom_kit/prismaticnova2/PopulateContents()
	new /obj/item/lighter/royalgold(src)
	new /obj/item/reagent_containers/pill/redambrosia(src)
	new /obj/item/stack/medical/mesh/aloe(src)
	new /obj/item/reagent_containers/pill/antirad_plus(src)

/datum/gear/donator/kits/prismaticnova3
	name = "Military Pilot Kit"
	path = /obj/item/storage/box/large/custom_kit/prismaticnova3
	ckeywhitelist = list("prismaticnova")

/obj/item/storage/box/large/custom_kit/prismaticnova3/PopulateContents()
	new /obj/item/lighter/gold(src)
	new /obj/item/card/id/dogtag/prismaticnova(src)
	new /obj/item/gun/ballistic/automatic/needlerrifle/custom(src)
	new /obj/item/ammo_box/needlercapsule(src)

// Q

// R

/datum/gear/donator/kits/radiantflash
	name = "Rynn's Kit"
	path = /obj/item/storage/box/large/custom_kit/radiantflash
	ckeywhitelist = list("radiantflash")

/obj/item/storage/box/large/custom_kit/radiantflash/PopulateContents()
	new /obj/item/book/granter/crafting_recipe/blueprint/aer9/focused/rynn(src)
	new /obj/item/clothing/accessory/bos/seniorscribe(src)
	new /obj/item/clothing/suit/armor/light/kit/punk/labcoat(src)
	new /obj/item/card/id/dogtag/radiantflash(src)

/datum/gear/donator/kits/rachei
	name = "OURP I did it again"
	path = /obj/item/storage/box/large/custom_kit/rachei
	ckeywhitelist = list("RacheI")

/obj/item/storage/box/large/custom_kit/rachei/PopulateContents()
	new /obj/item/gun/energy/laser/magpistolcustom(src)

/datum/gear/donator/kits/rainbyplays
	name = "Trailsworth's Gear"
	path = /obj/item/storage/box/large/custom_kit/rainbyplays
	ckeywhitelist = list("rainbyplays")

/obj/item/storage/box/large/custom_kit/rainbyplays/PopulateContents()
	new /obj/item/clothing/suit/armor/light/kit/punk/labcoat/trailsworth(src)
	new /obj/item/gun/ballistic/automatic/pistol/ninemil/m3civ(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/melee/powered/ripper/dull(src)

/datum/gear/donator/kits/roachwitharoach
	name = "Desert Kit"
	path = /obj/item/storage/box/large/custom_kit/roachwitharoach
	ckeywhitelist = list("roachwitharoach")

/obj/item/storage/box/large/custom_kit/roachwitharoach/PopulateContents()
	new /obj/item/clothing/under/f13/ncr(src)

/datum/gear/donator/kits/rubeebee
    name = "Shoddy Armor Kit"
    path = /obj/item/storage/box/large/custom_kit/rubeebee
    ckeywhitelist = list("rubeebee")

/obj/item/storage/box/large/custom_kit/rubeebee/PopulateContents()
    new /obj/item/clothing/suit/armor/light/leather/durathread(src)

/datum/gear/donator/kits/ruinerk
	name = "Custom revolver kit"
	path = /obj/item/storage/box/large/custom_kit/ruinerk
	ckeywhitelist = list("RUINEREK")

/obj/item/storage/box/large/custom_kit/ruinerk/PopulateContents()
	new /obj/item/gun/ballistic/revolver/Lemat/customrevolvers(src)
	new /obj/item/gun/ballistic/revolver/Lemat/customrevolvers/second(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/ammo_box/c9mm(src)


// S

/datum/gear/donator/kits/sage1990
	name = "Follower's Starting Kit"
	path = /obj/item/storage/box/large/custom_kit/sage1990
	ckeywhitelist = list("sage1990")

/obj/item/storage/box/large/custom_kit/sage1990/PopulateContents()
	new /obj/item/clothing/suit/armor/light/leather(src)
	new /obj/item/gun/energy/laser/wattz(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)

/datum/gear/donator/kits/saltyscabbard
	name = "Warrior Salty Kity"
	path = /obj/item/storage/box/large/custom_kit/saltyscabbard
	ckeywhitelist = list("saltyscabbard")

/obj/item/storage/box/large/custom_kit/saltyscabbard/PopulateContents()
	new /obj/item/clothing/head/helmet/f13/wayfarer/shamanred(src)
	new /obj/item/clothing/head/helmet/f13/wayfarer/shamanblue(src)
	new /obj/item/shield/riot/buckler(src)
	new /obj/item/melee/onehanded/machete/spatha(src)

/datum/gear/donator/kits/seermankhajiit00
	name = "The FallhlífVeiðimaður"
	path = /obj/item/storage/box/large/custom_kit/seermankhajiit00
	ckeywhitelist = list("seermankhajiit00")

/obj/item/storage/box/large/custom_kit/seermankhajiit00/PopulateContents()
	new /obj/item/clothing/shoes/customtoxboots(src)
	new /obj/item/gun/ballistic/automatic/fg42tox(src)
	new /obj/item/ammo_box/magazine/fallschirm(src)
	new /obj/item/ammo_box/magazine/fallschirm(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/gun/ballistic/automatic/pistol/type17/tox(src)
	new /obj/item/ammo_box/a3006box(src)
/datum/gear/donator/kits/seermankhajiit002
	name = "Sovietcat Kit"
	path = /obj/item/storage/box/large/custom_kit/seermankhajiit002
	ckeywhitelist = list("seermankhajiit00", "superlagg")

/obj/item/storage/box/large/custom_kit/seermankhajiit002/PopulateContents()
	new /obj/item/storage/box/hobo_tox(src)
	new /obj/item/clothing/under/f13/ww1custom(src)
	new /obj/item/gun/ballistic/automatic/fnfal/ak47/custom(src)
	new /obj/item/gun/ballistic/automatic/pistol/type17/tox(src)

/datum/gear/donator/kits/SilencedMP5A5
	name = "Arroyo's Kit"
	path = /obj/item/storage/box/large/custom_kit/SilencedMP5A5
	ckeywhitelist = list("SilencedMP5A5")

/obj/item/storage/box/large/custom_kit/SilencedMP5A5/PopulateContents()
	new /obj/item/clothing/head/helmet/f13/power_armor/fluff/arroyo(src)
	new /obj/item/clothing/suit/armor/power_armor/fluff/arroyo(src)
/datum/gear/donator/kits/smytheguy
	name = "Main ARG Research group kit"
	path = /obj/item/storage/box/large/custom_kit/smytheguy
	ckeywhitelist = list("Smytheguy")

/obj/item/storage/box/large/custom_kit/smytheguy/PopulateContents()
	new /obj/item/clothing/suit/armor/medium/spartanmarkviarmor/arggroup(src)
	new /obj/item/clothing/suit/armor/medium/spartanmarkviarmor/arggroup(src)
	new /obj/item/clothing/head/droptrooper/arghelmet(src)
	new /obj/item/clothing/head/droptrooper/arghelmet/two(src)

//Tox note: Despite the other not being in the S location, it helps me for sake of memory and ease of access. Thanks for reading oo woo.
/datum/gear/donator/kits/rhody
	name = "ARG Research group kit"
	path = /obj/item/storage/box/large/custom_kit/rhody
	ckeywhitelist = list("rhody")

/obj/item/storage/box/large/custom_kit/rhody/PopulateContents()
	new /obj/item/clothing/suit/armor/medium/spartanmarkviarmor/arggroup(src)
	new /obj/item/clothing/suit/armor/medium/spartanmarkviarmor/arggroup(src)
	new /obj/item/clothing/head/droptrooper/arghelmet(src)
	new /obj/item/clothing/head/droptrooper/arghelmet/two(src)

/datum/gear/donator/kits/seermankhajiit003
	name = "The Latos Agent OG"
	path = /obj/item/storage/box/large/custom_kit/seermankhajiit003
	ckeywhitelist = list("seermankhajiit00")

/obj/item/storage/box/large/custom_kit/seermankhajiit003/PopulateContents()
	new /obj/item/ammo_box/m14mm(src)
	new /obj/item/ammo_box/a308box(src)
	new /obj/item/gun/ballistic/automatic/gewehr41civ/tox(src)
	new /obj/item/gun/ballistic/automatic/pistol/hellocutiepistol(src)
	new /obj/item/clothing/suit/armor/medium/toxspartanarmors(src)
	new /obj/item/clothing/shoes/customtoxboots(src)

/datum/gear/donator/kits/seermankhajiit004
	name = "The Icelandic Latos Agent"
	path = /obj/item/storage/box/large/custom_kit/seermankhajiit004
	ckeywhitelist = list("seermankhajiit00")

/obj/item/storage/box/large/custom_kit/seermankhajiit004/PopulateContents()
	new /obj/item/ammo_box/m5mmbox(src)
	new /obj/item/ammo_box/c9mm(src)
	new /obj/item/gun/ballistic/automatic/pistol/type17/tox(src)
	new /obj/item/gun/ballistic/rifle/antique/tankgun/custom(src)
	new /obj/item/ammo_box/a50MGbox(src)
	new /obj/item/clothing/shoes/customtoxboots(src)
	new /obj/item/clothing/head/kevlarhelmet/toxtestinghelmet(src)
	new /obj/item/gun/ballistic/automatic/pistol/no3pistoltox(src)

/datum/gear/donator/kits/seermankhajiit006
	name = "The Icelandic G11"
	path = /obj/item/storage/box/large/custom_kit/seermankhajiit006
	ckeywhitelist = list("seermankhajiit00")

/obj/item/storage/box/large/custom_kit/seermankhajiit006/PopulateContents()
	new /obj/item/ammo_box/m473(src)
	new /obj/item/ammo_box/m14mm(src)
	new /obj/item/gun/ballistic/automatic/pistol/lugerrevolver/tox(src)
	new /obj/item/gun/ballistic/automatic/g11/tox(src)
	new /obj/item/clothing/shoes/customtoxboots(src)
	new /obj/item/pet_carrier/paws(src)
	new /obj/item/pet_carrier/fluffy(src)


/datum/gear/donator/kits/seermankhajiit00last
	name = "The Finale"
	path = /obj/item/storage/box/large/custom_kit/seermankhajiit00last
	ckeywhitelist = list("seermankhajiit00")

/obj/item/storage/box/large/custom_kit/seermankhajiit00last/PopulateContents()
	new /obj/item/ammo_box/a3006box(src)
	new /obj/item/ammo_box/magazine/stg(src)
	new /obj/item/gun/ballistic/automatic/pistol/lugerrevolver/tox(src)
	new /obj/item/ammo_box/m14mm(src)
	new /obj/item/clothing/head/kevlarhelmet/toxtestinghelmet(src)
	new /obj/item/gun/ballistic/automatic/stg44custom(src)
	new /obj/item/clothing/shoes/customtoxboots(src)

/datum/gear/donator/kits/seermankhajiit00new
	name = "The Shadowtribe"
	path = /obj/item/storage/box/large/custom_kit/seermankhajiit00new
	ckeywhitelist = list("seermankhajiit00")

/obj/item/storage/box/large/custom_kit/seermankhajiit00new/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/derringercustom(src)
	new /obj/item/ammo_box/m14mm(src)
	new /obj/item/ammo_box/m473(src)
	new /obj/item/gun/ballistic/automatic/g11/tox(src)
	new /obj/item/clothing/suit/armor/outfit/warriorcats/customshadow(src)
	new /obj/item/clothing/head/kevlarhelmet/toxtestinghelmet(src)

/obj/item/pet_carrier/paws
	name = "Paws' carrier"
	desc = "Hey look who it is!"

/obj/item/pet_carrier/paws/Initialize()
	. = ..()
	var/mob/living/simple_animal/pet/fox/paws/pet_paws = new(src)
	add_occupant(pet_paws)

/obj/item/pet_carrier/fluffy
	name = "Fluffy's carrier"
	desc = "Hey look who it is!"

/obj/item/pet_carrier/fluffy/Initialize()
	. = ..()
	var/mob/living/simple_animal/pet/mothroach/tox/pet_fluffy = new(src)
	add_occupant(pet_fluffy)


/datum/gear/donator/kits/sampletex
	name = "The Aug Loadout"
	path = /obj/item/storage/box/large/custom_kit/sampletex
	ckeywhitelist = list("SampleTex")

/obj/item/storage/box/large/custom_kit/sampletex/PopulateContents()
	new /obj/item/ammo_box/m5mmbox(src)
	new /obj/item/gun/ballistic/automatic/assault_carbine/aug5mm/custom(src)

/datum/gear/donator/kits/sloaff
	name = "Leo's Kit"
	path = /obj/item/storage/box/large/custom_kit/sloaff
	ckeywhitelist = list("sloaff")

/obj/item/storage/box/large/custom_kit/sloaff/PopulateContents()
	new /obj/item/binoculars(src)
	new /obj/item/gun/ballistic/revolver/thatgun(src)
	new /obj/item/ammo_box/magazine/m556/rifle/small(src)
	new /obj/item/ammo_box/magazine/m556/rifle/small(src)
	new /obj/item/melee/onehanded/knife/bowie(src)
	new /obj/item/clothing/head/helmet/f13/marlowhat(src)

/datum/gear/donator/kits/sloaff2
	name = "Danger Doggo Kit"
	path = /obj/item/storage/box/large/custom_kit/sloaff2
	ckeywhitelist = list("sloaff")

/obj/item/storage/box/large/custom_kit/sloaff2/PopulateContents()
	new /obj/item/clothing/mask/surgical/sloaff(src)
	new /obj/item/lighter/fusion(src)
	new /obj/item/reagent_containers/pill/patch/jet(src)
	new /obj/item/gun/energy/laser/badlands/worn(src)

/datum/gear/donator/kits/sloaff3
	name = "Sloan's Food Pack"
	path = /obj/item/storage/box/large/custom_kit/sloaff3
	ckeywhitelist = list("sloaff")

/obj/item/storage/box/large/custom_kit/sloaff3/PopulateContents()
	new /obj/item/storage/fancy/cigarettes/cigpack_cannabis(src)
	new /obj/item/reagent_containers/food/drinks/drinkingglass/filled/nukaberry(src)
	new /obj/item/reagent_containers/food/snacks/jellysandwich/pbj/cherry(src)
	new /obj/item/reagent_containers/food/drinks/flask/vault13(src)

/datum/gear/donator/kits/soulwinter446
	name = "Shocome's relic cross"
	path = /obj/item/nullrod/rosary/keep_as_is
	ckeywhitelist = list("soulwinter446")

/datum/gear/donator/kits/superlagg
	name = "Bigfox Kit"
	path = /obj/item/storage/box/large/custom_kit/superlagg
	ckeywhitelist = list("superlagg")

/obj/item/storage/box/large/custom_kit/superlagg/PopulateContents()
	new /obj/item/gun/ballistic/automatic/varmint/extended(src)
	new /obj/item/ammo_box/magazine/m556/rifle(src)
	new /obj/item/gun/ballistic/revolver/revolver44(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/melee/onehanded/knife/switchblade(src)
	new /obj/item/toy/plush/mammal/fox/squishfox(src)

/datum/gear/donator/kits/superlagg2
	name = "Danny Kit"
	path = /obj/item/storage/box/large/custom_kit/superlagg2
	ckeywhitelist = list("superlagg")

/obj/item/storage/box/large/custom_kit/superlagg2/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/sidewinder(src)
	new /obj/item/ammo_box/magazine/uzim9mm/rockwell/empty(src)
	new /obj/item/ammo_box/magazine/cg45/empty(src)
	new /obj/item/ammo_box/magazine/tommygunm45/stick/empty(src)
	new /obj/item/melee/onehanded/knife/switchblade(src)
	new /obj/item/toy/plush/mammal/fox/squishfox(src)

/datum/gear/donator/kits/swirlby
	name = "Tribal Kit"
	path = /obj/item/storage/box/large/custom_kit/swirlby
	ckeywhitelist = list("swirlby")

/obj/item/storage/box/large/custom_kit/swirlby/PopulateContents()
	new /obj/item/clothing/under/f13/exile/vault(src)
	new /obj/item/gun/ballistic/rifle/hunting(src)
	new /obj/item/clothing/suit/armor/light/tribal/rustwalkers(src)
	new /obj/item/clothing/suit/armor/medium/tribal/deadhorses(src)

// T

/datum/gear/donator/kits/thingpony/teras
	name = "Teras gun"
	path = /obj/item/storage/box/large/custom_kit/thingpony/teras
	ckeywhitelist = list("thingpony")

/obj/item/storage/box/large/custom_kit/thingpony/teras/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/n99/crusader/thingpony(src)

/datum/gear/donator/kits/thingpony/fleur
	name = "fleur's necklace"
	path = /obj/item/storage/box/large/custom_kit/thingpony/fleur
	ckeywhitelist = list("thingpony")

/obj/item/storage/box/large/custom_kit/thingpony/fleur/PopulateContents()
	new /obj/item/clothing/neck/customfleur(src)

/datum/gear/donator/kits/thingpony/warmfur
	name = "Warmfur's clothing"
	path = /obj/item/storage/box/large/custom_kit/thingpony/warmfur
	ckeywhitelist = list("thingpony")

/obj/item/storage/box/large/custom_kit/thingpony/warmfur/PopulateContents()
	new /obj/item/clothing/under/tribalcustom(src)

/datum/gear/donator/kits/thingpony/iris
	name = "Iris's pack"
	path = /obj/item/storage/box/large/custom_kit/thingpony/iris
	ckeywhitelist = list("thingpony")

/obj/item/storage/box/large/custom_kit/thingpony/iris/PopulateContents()
	new /obj/item/clothing/under/tribaliris(src)
	new /obj/item/gun/ballistic/shotgun/s163/thingblessed(src)

/datum/gear/donator/kits/thingpony/petal
	name = "Petal's pack"
	path = /obj/item/storage/box/large/custom_kit/thingpony/petal
	ckeywhitelist = list("thingpony")

/obj/item/storage/box/large/custom_kit/thingpony/petal/PopulateContents()
	new /obj/item/clothing/under/poofygreen(src)

/datum/gear/donator/kits/tk420634
	name = "Casey's 'Business' Bundle"
	path = /obj/item/storage/box/large/custom_kit/tk420634
	ckeywhitelist = list("tk420634")

/obj/item/storage/box/large/custom_kit/tk420634/PopulateContents()
	new /obj/item/melee/onehanded/knife/trench(src)
	new /obj/item/card/lowbounty(src)
	new /obj/item/ammo_box/magazine/m308/ext(src)
	new /obj/item/ammo_box/magazine/m308/ext(src)
	new /obj/item/gun/ballistic/automatic/slr/stinki(src)
//	new /obj/item/gun_upgrade/scope/killer(src) // for now just icing their attachments, when they play they'll complain

/datum/gear/donator/kits/tk420634_2
	name = "Catgirl Kit"
	path = /obj/item/storage/box/large/custom_kit/tk420634_2
	ckeywhitelist = list("tk420634")

/obj/item/storage/box/large/custom_kit/tk420634_2/PopulateContents()
	new /obj/item/melee/unarmed/brass/spiked(src)
	new /obj/item/reagent_containers/glass/bowl(src)
	new /obj/item/reagent_containers/food/condiment/milk(src)
	new /obj/item/reagent_containers/food/snacks/deadmouse(src)
	new /obj/item/clothing/suit/armor/light/kit/shoulder(src)
	new /obj/item/melee/onehanded/knife/throwing(src)
	new /obj/item/melee/onehanded/knife/throwing(src)
	new /obj/item/melee/onehanded/knife/throwing(src)
	new /obj/item/reagent_containers/food/snacks/kebab/rat/double(src)
	new /obj/item/reagent_containers/food/drinks/bottle/instacocoa(src)

/datum/gear/donator/kits/tk420634_3
	name = "Pandagirl kit"
	path = /obj/item/storage/box/large/custom_kit/tk420634_3
	ckeywhitelist = list("tk420634")

/obj/item/storage/box/large/custom_kit/tk420634_3/PopulateContents()
	new /obj/item/clothing/suit/armor/light/kit/shoulder(src)
	new /obj/item/melee/baton/boomerang/loaded(src)
	new /obj/item/radio/tribal(src)
	new /obj/item/clothing/shoes/combat/sneakboots(src)
	new /obj/item/clothing/glasses/phantomthief(src)
	new /obj/item/storage/backpack/satchel/sec(src)
	new /obj/item/clothing/gloves/thief(src)
	new /obj/item/stealthboy(src)
	new /obj/item/lockpick_set(src)
	new /obj/item/lockpick_set(src)
	new /obj/item/lockpick_set(src)

/datum/gear/donator/kits/tk420634_4
	name = "Tri-Heal Staff"
	path = /obj/item/storage/box/large/custom_kit/tk420634_4
	ckeywhitelist = list("tk420634")

/obj/item/storage/box/large/custom_kit/tk420634_4/PopulateContents()
	new /obj/item/gun/magic/staff/healing/triheal(src)


/datum/gear/donator/kits/twitchysw
	name = "The Avian"
	path = /obj/item/storage/box/large/custom_kit/twitchysw
	ckeywhitelist = list("TwitchySw")


/obj/item/storage/box/large/custom_kit/twitchysw/PopulateContents()
	new /obj/item/gun/ballistic/automatic/assault_carbine/aug5mm/asvalcustom(src)
	new /obj/item/ammo_box/m5mmbox(src)
	new /obj/item/gun/ballistic/revolver/hunting/custom(src)
	new /obj/item/ammo_box/c4570box(src)

/datum/gear/donator/kits/thelasthosea2
	name = "Bren loadout"
	path = /obj/item/storage/box/large/custom_kit/thelasthosea2
	ckeywhitelist = list("ThelastHosea2")

/obj/item/storage/box/large/custom_kit/thelasthosea2/PopulateContents()
	new /obj/item/gun/ballistic/automatic/bren/custom(src)
	new /obj/item/ammo_box/magazine/bren(src)
	new /obj/item/ammo_box/a308box(src)

/datum/gear/donator/kits/triplewammy
	name = "Service rifle doggo loadout"
	path = /obj/item/storage/box/large/custom_kit/triplewammy
	ckeywhitelist = list("Triple_Wammy")

/obj/item/storage/box/large/custom_kit/triplewammy/PopulateContents()
	new /obj/item/gun/ballistic/automatic/service(src)
	new /obj/item/ammo_box/magazine/m556/rifle(src)
	new /obj/item/ammo_box/a556(src)

/datum/gear/donator/kits/tonyburritos
	name = "NCR Scout"
	path = /obj/item/storage/box/large/custom_kit/tonyburritos
	ckeywhitelist = list("tonyburritos")

/obj/item/storage/box/large/custom_kit/tonyburritos/PopulateContents()
	new /obj/item/clothing/gloves/f13/leather/fingerless(src)
	new /obj/item/clothing/under/f13/ncr(src)
	new /obj/item/clothing/shoes/f13/military/ncr(src)
	new /obj/item/clothing/head/f13/ncr/ncr_flapcap(src)
	new /obj/item/clothing/suit/armor/light/leather(src)
	new /obj/item/clothing/mask/ncr_facewrap(src)

/datum/gear/donator/kits/tonyburritos2
	name = "Traveling Ranger"
	path = /obj/item/storage/box/large/custom_kit/tonyburritos2
	ckeywhitelist = list("tonyburritos")

/obj/item/storage/box/large/custom_kit/tonyburritos2/PopulateContents()
	new /obj/item/clothing/suit/armor/medium/combat/desert_ranger(src)
	new /obj/item/clothing/under/f13/ranger/modif_ranger(src)
	new /obj/item/clothing/accessory/ranger(src)
	new /obj/item/clothing/gloves/f13/leather/fingerless(src)
	new /obj/item/clothing/mask/bandana/legion/legprime(src)
	new /obj/item/clothing/shoes/f13/military/desert(src)
	new /obj/item/clothing/head/helmet/f13/ncr/rangercombat/desert(src)
	new /obj/item/clothing/head/helmet/f13/ncr/rangercombat/desert/whiskey(src)
	new /obj/item/gun/ballistic/revolver/revolver45(src)

/datum/gear/donator/kits/truedark
	name = "Lockhard Renegade Supplies"
	path = /obj/item/storage/box/large/custom_kit/truedark
	ckeywhitelist = list("truedark")

/obj/item/storage/box/large/custom_kit/truedark/PopulateContents()
	new /obj/item/book/granter/crafting_recipe/blueprint/aep7(src)
	new /obj/item/stock_parts/cell/ammo/ecp(src)
	new /obj/item/stock_parts/cell/ammo/ecp(src)
	new /obj/item/stack/cable_coil/thirty(src)
	new /obj/item/gun/energy/laser/auto/nayriin(src)
	new /obj/item/weldingtool/largetank/cylphie(src)
	new /obj/item/clothing/under/dress/skirt/polychromic/pleated(src)
	new /obj/item/pen/edagger(src)
	new /obj/item/pen/edagger(src)
	new /obj/item/pen/edagger(src)
	new /obj/item/clothing/suit/armor/medium/combat/bos/cylphie(src)
	new /obj/item/card/id/denid/truedark(src)

/datum/gear/donator/kits/truedark2
	name = "Alaskan Survival Kit"
	path = /obj/item/storage/box/large/custom_kit/truedark2
	ckeywhitelist = list("truedark")

/obj/item/storage/box/large/custom_kit/truedark2/PopulateContents()
	new /obj/item/gun/ballistic/bow/shortbow/nayriin_crossbow(src)
	new /obj/item/storage/bag/tribe_quiver/light/full(src)
	new /obj/item/smelling_salts/wayfarer(src)
	new /obj/item/reagent_containers/glass/bottle/gaia(src)
	new /obj/item/reagent_containers/pill/patch/turbo(src)

/datum/gear/donator/kits/truedark3
	name = "Junker's Kit"
	path = /obj/item/storage/box/large/custom_kit/truedark3
	ckeywhitelist = list("truedark")

/obj/item/storage/box/large/custom_kit/truedark3/PopulateContents()
	new /obj/item/clothing/suit/armor/light/leather/rig(src)
	new /obj/item/clothing/under/rank/rnd/roboticist(src)
	new /obj/item/clothing/suit/hooded/wintercoat/robotics(src)
	new /obj/item/gun/ballistic/revolver/hobo/piperifle(src)
	new /obj/item/ammo_box/a556(src)
	new /obj/item/toy/plush/lampplushie(src)

/datum/gear/donator/kits/truedark4
	name = "Alien Stuff"
	path = /obj/item/storage/box/large/custom_kit/truedark4
	ckeywhitelist = list("truedark")

/obj/item/storage/box/large/custom_kit/truedark4/PopulateContents()
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/gun/energy/laser/covcarbine(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)
	// /obj/item/gun/energy/alien(src)
	new /obj/item/stack/cable_coil/thirty(src)
	new /obj/item/stack/sheet/mineral/abductor/ten(src)

/datum/gear/donator/kits/truedark5
	name = "Vivian loadout"
	path = /obj/item/storage/box/large/custom_kit/truedark5
	ckeywhitelist = list("truedark")

/obj/item/storage/box/large/custom_kit/truedark5/PopulateContents()
	new /obj/item/clothing/neck/scarf/pink(src)
	new/obj/item/clothing/suit/jacket/leather(src)
	new /obj/item/clothing/under/dress/skirt/polychromic/pleated(src)
	new /obj/item/clothing/shoes/wraps/silver(src)

// U
// V
// W

/datum/gear/donator/kits/wrongendoftherainbow
	name = "Slave Equipment"
	path = /obj/item/storage/box/large/custom_kit/wrongendoftherainbow
	ckeywhitelist = list("wrongendoftherainbow")

/obj/item/storage/box/large/custom_kit/wrongendoftherainbow/PopulateContents()
	new /obj/item/electropack/shockcollar/shimsusa_shackles(src)
	new /obj/item/clothing/under/f13/exile/tribal/shimsusa_loincloth(src)
	new /obj/item/storage/bag/plants(src)

/datum/gear/donator/kits/weredoggo
	name = "Weredoggo Customs"
	path = /obj/item/storage/box/large/custom_kit/weredoggo
	ckeywhitelist = list("weredoggo")

/obj/item/storage/box/large/custom_kit/weredoggo/PopulateContents()
	new /obj/item/reagent_containers/food/snacks/grown/peach(src)
	new /obj/item/gun/energy/laser/auto/oasis(src)

/datum/gear/donator/kits/weredoggo2
	name = "Cloth Supply Cache"
	path = /obj/item/storage/box/large/custom_kit/weredoggo2
	ckeywhitelist = list("weredoggo")

/obj/item/storage/box/large/custom_kit/weredoggo2/PopulateContents()
	new /obj/item/stack/sheet/cloth/ten(src)
	new /obj/item/toy/crayon/spraycan(src)

/datum/gear/donator/kits/weredoggo3
	name = "BBQ Fun"
	path = /obj/item/storage/box/large/custom_kit/weredoggo3
	ckeywhitelist = list("weredoggo")

/obj/item/storage/box/large/custom_kit/weredoggo3/PopulateContents()
	new /obj/item/reagent_containers/food/condiment/bbqsauce(src)
	new /obj/item/storage/box/hug(src)
	new /obj/item/pen/edagger(src)
	new /obj/item/reagent_containers/food/snacks/peanut_butter(src)
	new /obj/item/coin/gold/dogecoin(src)

/datum/gear/donator/kits/woundedwafflez
	name = "Airsoft Kit"
	path = /obj/item/storage/box/large/custom_kit/woundedwafflez
	ckeywhitelist = list("Woundedwafflez")

/obj/item/storage/box/large/custom_kit/woundedwafflez/PopulateContents()
	new /obj/item/gun/ballistic/automatic/varmint/knockoffalr(src)
	new /obj/item/ammo_box/magazine/m556/rifle/small/empty(src)

// X

/datum/gear/donator/kits/xxpawnstarrxx
	name = "Botanical Bounty Box"
	path = /obj/item/storage/box/large/custom_kit/blindboyo
	ckeywhitelist = list("xxpawnstarrxx")

/obj/item/storage/box/large/custom_kit/blindboyo/PopulateContents()
	new /obj/item/circuitboard/machine/biogenerator(src)
	new /obj/item/circuitboard/machine/plantgenes(src)
	new /obj/item/circuitboard/machine/seed_extractor(src)
	new /obj/item/queen_bee/bought(src)
	new /obj/item/vending_refill/hydroseeds(src)
	new /obj/machinery/vending/hydroseeds(src)
	new /obj/item/storage/box/disks_plantgene(src)

/datum/gear/donator/kits/xxpawnstarrxx
	name = "Justice's notes"
	path = /obj/item/storage/box/large/custom_kit/cachejustice
	ckeywhitelist = list("xxpawnstarrxx")

/obj/item/storage/box/large/custom_kit/cachejustice/PopulateContents()
	new /obj/item/book/granter/crafting_recipe/polis(src)

// Y

/datum/gear/donator/kits/yawet
	name = "Tribal Drip"
	path = /obj/item/storage/box/large/custom_kit/yawet
	ckeywhitelist = list("yawet330")

/obj/item/storage/box/large/custom_kit/yawet/PopulateContents()
	new /obj/item/clothing/suit/hooded/outcast(src)
	new /obj/item/twohanded/sledgehammer/simple(src)

// Z

/datum/gear/donator/kits/zeronetalpha
	name = "Glowstick Kit"
	path = /obj/item/storage/box/large/custom_kit/zeronetalpha
	ckeywhitelist = list("zeronetalpha", "zeronettwo")

/obj/item/storage/box/large/custom_kit/zeronetalpha/PopulateContents()
	new /obj/item/cartridge/resize
	new /obj/item/gun/energy/laser/pistol(src)
	new /obj/item/gun/energy/laser/pistol(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/card/id/denid/truedark(src)

/datum/gear/donator/kits/saltspider
	name = "Wasteland cooking kit"
	path = /obj/item/storage/box/large/custom_kit/saltspider
	ckeywhitelist = list("saltspider")

/obj/item/storage/box/large/custom_kit/saltspider/PopulateContents()
	new /obj/item/clothing/suit/armor/light/duster/brahmin/saltspider(src)
	new /obj/item/melee/onehanded/club/fryingpan/saltspider(src)

/datum/gear/donator/kits/kelprunner01
	name = "Nuclear Rifle"
	path = /obj/item/storage/box/large/custom_kit/kelprunner01
	ckeywhitelist = list("Kelprunner")

/obj/item/storage/box/large/custom_kit/kelprunner01/PopulateContents()
	new /obj/item/gun/energy/laser/tg/recharger/nuclear/rifle/worn(src)

/datum/gear/donator/kits/kelprunner02
	name = "Invisible Backpack"
	path = /obj/item/storage/box/large/custom_kit/kelprunner02
	ckeywhitelist = list("Kelprunner")

/obj/item/storage/box/large/custom_kit/kelprunner02/PopulateContents()
	new /obj/item/storage/backpack/invisipack(src)

/datum/gear/donator/kits/kelprunner03
	name = "Engikit"
	path = /obj/item/storage/box/large/custom_kit/kelprunner03
	ckeywhitelist = list("Kelprunner")

/obj/item/storage/box/large/custom_kit/kelprunner03/PopulateContents()
	new /obj/item/storage/backpack/satchel/eng(src)
	new /obj/item/storage/firstaid/emergency(src)

/datum/gear/donator/kits/deltadav
	name = "Voyager Equipment Kit"
	path = /obj/item/storage/box/large/custom_kit/deltadav
	ckeywhitelist = list("delta_dav")

/obj/item/storage/box/large/custom_kit/deltadav/PopulateContents()
	new /obj/item/clothing/under/trek/medsci/voy(src)
	new /obj/item/gun/energy/laser/pistol/phaser(src)
	new /obj/item/gun/energy/laser/pistol/phaser/disable(src)

/datum/gear/donator/kits/rattles
	name = "Box of Rattlers"
	path = /obj/item/storage/box/large/custom_kit/rattles
	ckeywhitelist = list("sabals")

/obj/item/storage/box/large/custom_kit/rattles/PopulateContents()
	new /obj/item/toy/plush/rattler(src)
	new /obj/item/toy/plush/rattler(src)
	new /obj/item/toy/plush/rattler(src)
	new /obj/item/toy/plush/rattler(src)
	new /obj/item/toy/plush/rattler(src)
	new /obj/item/toy/plush/rattler(src)
	new /obj/item/toy/plush/rattler(src)

/datum/gear/donator/kits/lucine3
	name = "Gob-lyn Muderbox"
	path = /obj/item/storage/box/large/custom_kit/lucine3
	ckeywhitelist = list("lucine")

/obj/item/storage/box/large/custom_kit/lucine3/PopulateContents()
	new /obj/item/melee/transforming/plasmacutter/regular/flamberge(src)

/datum/gear/donator/kits/zombotheskunk
	name = "Royal Kit"
	path = /obj/item/storage/box/large/custom_kit/zombotheskunk
	ckeywhitelist = list("ZomboTheSkunk")

/obj/item/storage/box/large/custom_kit/zombotheskunk/PopulateContents()
	new /obj/item/clothing/head/crown(src)

//Mayor Kit

/datum/gear/donator/kits/Mayor_kit
	name = "Mayor Card"
	path = /obj/item/storage/box/large/custom_kit/Mayor_kit
	ckeywhitelist = list("ursine")

/obj/item/storage/box/large/custom_kit/Mayor_kit/PopulateContents()
	new /obj/item/card/id/captains_spare(src)
	new /obj/item/radio/headset/headset_town/mayor(src)
	new /obj/item/kit_spawner/townie/mayor(src)


/datum/gear/donator/kits/fourty2
	name = "Swamp star box"
	path = /obj/item/storage/box/large/custom_kit/fourty2
	ckeywhitelist = list("fourty2")

/obj/item/storage/box/large/custom_kit/fourty2/PopulateContents()
	new /obj/item/clothing/gloves/fingerless/pugilist/rapid(src)
	new  /obj/item/reagent_containers/food/drinks/flask(src)
	new  /obj/item/weldingtool/largetank(src)
	new  /obj/item/clothing/suit/space/hardsuit/lavaknight(src)
	new  /obj/item/clothing/glasses/welding(src)

//for Gitts

/obj/item/gun/ballistic/automatic/ww1selfloader/smelly
	name = "Anti-Preservative"
	desc = "A Mauser M1906 Selbstlader. Though many would call it a museum piece, this old firearm is surprisingly still in wonderful condition, and even appears to have some aftermarket modifications made to it, most notably its ability to accept .30-06 rounds. The letters 'FDH' are crudely carved onto the top of the stock in a vertical stack, clearly legible to anyone shouldering the rifle."

/obj/item/gun/ballistic/automatic/pistol/ninemil/makarov/smelly
	name = "Migraine"
	desc = "The PM Makarov, a compact pistol designed by the Soviet Union, though this one is modified to accept the more common 9x19mm round. It also has the letters 'FDH' crudely etched into the bakelite pistol grips on either side."

/obj/item/clothing/suit/armor/medium/duster/town/embroidered/smelly
	name = "DeHyde's Coat"
	desc = "A custom-tailored armoured trench coat with extra length and a raised collar. There's a flower embroidered onto the back, somewhat faded, and the letters 'FDH' are scribbled onto an inside pocket."

/obj/item/clothing/glasses/red/smelly
	name = "Pristine Red Sunglasses"
	desc = "A pair of shiny mirrored red spectacles which always seem to catch the light. On one of the earpieces, the letters 'FDH' are very carefully scratched into the plastic."

/obj/item/clothing/collectable/tophat/smelly
	name = "Smelly Tophat"
	desc = "A tailor-made tophat that smells awfully of chemical preservative. The letters 'FDH' are written on the inner liner in permanent marker."

/datum/gear/donator/kits/gittsy
	name = "Smelly box"
	path = /obj/item/storage/box/large/custom_kit/gittsy
	ckeywhitelist = list("Gittsy")

/obj/item/storage/box/large/custom_kit/gittsy/PopulateContents()
	new /obj/item/clothing/collectable/tophat/smelly(src)
	new  /obj/item/clothing/glasses/red/smelly(src)
	new  /obj/item/clothing/suit/armor/medium/duster/town/embroidered/smelly(src)
	new  /obj/item/gun/ballistic/automatic/pistol/ninemil/makarov/smelly(src)
	new  /obj/item/gun/ballistic/automatic/ww1selfloader/smelly(src)

/datum/gear/donator/kits/trickingtrapster
	name = "Tarot Box"
	path = /obj/item/storage/box/large/custom_kit/trickingtrapster
	ckeywhitelist = list("trickingtrapster")

/obj/item/storage/box/large/custom_kit/trickingtrapster/PopulateContents()
	new /obj/item/tarotdeck(src)

/obj/item/toy/tennis/custom
	name = "parental red tennis ball of parenthood"
	icon_state = "tennis_red"

/datum/gear/donator/kits/nocturnalfoxboi
	name = "ball box"
	path = /obj/item/storage/box/large/custom_kit/nocturnalfoxboi
	ckeywhitelist = list("nocturnalfoxboi")

/obj/item/storage/box/large/custom_kit/nocturnalfoxboi/PopulateContents()
	new /obj/item/toy/tennis/custom(src)

/datum/gear/donator/kits/everfire
	name = "helmet"
	path = /obj/item/storage/box/large/custom_kit/everfire
	ckeywhitelist = list("everfire")

/obj/item/storage/box/large/custom_kit/everfire/PopulateContents()
	new /obj/item/clothing/head/helmet/riot(src)

/datum/gear/donator/kits/hallow96
	name = "small ott box"
	path = /obj/item/storage/box/large/custom_kit/hallow96
	ckeywhitelist = list("hallow96")

/obj/item/storage/box/large/custom_kit/hallow96/PopulateContents()
	new /obj/item/clothing/under/kuddles/rattyskirtgreen(src)
	new /obj/item/seeds/poppy/lily(src)
	new /obj/item/seeds/sunflower(src)
	new /obj/item/reagent_containers/glass/waterskin(src)
	new /obj/item/clothing/suit/armor/outfit/flagcapes/unitedkingdom(src)
	new /obj/item/bedsheet/britishflag(src)
	new /obj/item/card/fuzzy_license(src)
	new /obj/item/toy/plush/mammal/fox/fuzzy(src)
	new /obj/item/gun/ballistic/revolver/police(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/toy/plush/otter(src)
