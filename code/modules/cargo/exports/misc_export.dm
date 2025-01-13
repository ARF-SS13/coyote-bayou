// why wasn't this a thing. all other items

// medicine

/datum/export/item/chems
	cost = 200
	unit_name = "chems (low)"
	export_types = list(/obj/item/reagent_containers/hypospray/medipen/stimpak,
	/obj/item/reagent_containers/pill/patch/medx,
	/obj/item/reagent_containers/blood/radaway,
	/obj/item/reagent_containers/pill/patch/steady,
	/obj/item/storage/pill_bottle/chem_tin/mentats,
	/obj/item/reagent_containers/pill/healingpowder,
	/obj/item/storage/pill_bottle/chem_tin/buffout,
	/obj/item/reagent_containers/pill/stimulant,
	/obj/item/storage/pill_bottle/chem_tin/radx,
	/obj/item/reagent_containers/pill/healingpowder,
	/obj/item/reagent_containers/pill/bitterdrink,
	/obj/item/reagent_containers/pill/antivenom,
	)

/datum/export/item/chemshigh
	cost = 400
	unit_name = "chems (high)"
	export_types = list(,
	/obj/item/reagent_containers/hypospray/medipen/stimpak/super,
	/obj/item/reagent_containers/pill/patch/healpoultice,
	/obj/item/reagent_containers/pill/fiery_purgative,
	)

/* /datum/export/item/superstimpak
	cost = 80
	unit_name = "super stimpak"
	export_types = list(/obj/item/reagent_containers/hypospray/medipen/stimpak/super) */


/datum/export/item/trashgun
	cost = 100
	unit_name = "trash guns"
	export_types = list(
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/rockwell,
		/obj/item/gun/ballistic/automatic/varmint/bushmaster_arm_gun,
		/obj/item/gun/ballistic/revolver/shotpistol,
		/obj/item/gun/ballistic/automatic/hobo/zipgun,
		/obj/item/gun/ballistic/revolver/hobo/piperifle,
		/obj/item/gun/ballistic/revolver/hobo/pepperbox,
		/obj/item/gun/ballistic/revolver/hobo/single_shotgun,
		/obj/item/gun/ballistic/revolver/hobo/knifegun,
		/obj/item/gun/ballistic/revolver/hobo/knucklegun,
		/obj/item/gun/ballistic/automatic/autopipe,
		/obj/item/gun/ballistic/revolver/winchesterrebored,
		/obj/item/gun/ballistic/rifle/mosin/mini,
		/obj/item/gun/energy/laser/cranklasergun/tg,
		)

/datum/export/item/commongun
	cost = 150
	unit_name = "common guns"
	export_types = list(
		/obj/item/gun/ballistic/automatic/smg/smg10mm/worn,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/owengun,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10,
		/obj/item/gun/ballistic/automatic/m1carbine,
		/obj/item/gun/ballistic/automatic/delisle,
		/obj/item/gun/ballistic/automatic/sportcarbine,
		/obj/item/gun/ballistic/automatic/varmint,
		/obj/item/gun/ballistic/automatic/assault_carbine/policerifle,
		/obj/item/gun/ballistic/automatic/pistol/pistol22,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/tec22,
		/obj/item/gun/ballistic/automatic/pistol/ninemil,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/c93,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/c93/luger,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/auto,
		/obj/item/gun/ballistic/automatic/pistol/beretta,
		/obj/item/gun/ballistic/automatic/pistol/beretta/carbine,
		/obj/item/gun/ballistic/automatic/pistol/beretta/automatic,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/skorpion,
		/obj/item/gun/ballistic/automatic/pistol/n99,
		/obj/item/gun/ballistic/automatic/pistol/type17,
		/obj/item/gun/ballistic/automatic/pistol/sig,
		/obj/item/gun/ballistic/automatic/pistol/m1911,
		/obj/item/gun/ballistic/rifle/hunting,
		/obj/item/gun/ballistic/rifle/antique/gras,
		/obj/item/gun/ballistic/rifle/mosin,
		/obj/item/gun/ballistic/rifle/enfield,
		/obj/item/gun/ballistic/shotgun/hunting,
		/obj/item/gun/energy/laser/wattz,
		/obj/item/gun/energy/laser/wattzs,
		/obj/item/gun/energy/laser/pistol,
		/obj/item/gun/energy/laser/complianceregulator,
		/obj/item/gun/energy/laser/auto,
		/obj/item/gun/ballistic/revolver/detective,
		/obj/item/gun/ballistic/revolver/revolver45,
		/obj/item/gun/ballistic/revolver/colt357,
		/obj/item/gun/ballistic/revolver/police,
		/obj/item/gun/ballistic/revolver/m29,
		/obj/item/gun/ballistic/revolver/m29/alt,
		/obj/item/gun/ballistic/revolver/m29/snub,
		/obj/item/gun/ballistic/revolver/revolver44,
		/obj/item/gun/ballistic/revolver/thatgun,
		/obj/item/gun/ballistic/rifle/repeater/cowboy,
		/obj/item/gun/ballistic/revolver/caravan_shotgun,
		/obj/item/gun/ballistic/revolver/widowmaker,
		/obj/item/gun/ballistic/bow/modern,
		)

/datum/export/item/uncommongun
	cost = 400
	unit_name = "uncommon guns"
	export_types = list(
		/obj/item/gun/ballistic/automatic/smg/american180,
		/obj/item/gun/ballistic/automatic/smg/smg10mm,
		/obj/item/gun/ballistic/automatic/m1carbine/m2,
		/obj/item/gun/ballistic/automatic/smg/mp5sd,
		/obj/item/gun/ballistic/automatic/smg/sidewinder,
		/obj/item/gun/ballistic/automatic/combat,
		/obj/item/gun/ballistic/automatic/service,
		/obj/item/gun/ballistic/automatic/marksman,
		/obj/item/gun/ballistic/automatic/marksman/policerifle,
		/obj/item/gun/ballistic/automatic/assault_carbine,
		/obj/item/gun/ballistic/automatic/armalite,
		/obj/item/gun/ballistic/automatic/l1a1,
		/obj/item/gun/ballistic/automatic/c96auto,
		/obj/item/gun/ballistic/automatic/pistol/schmeisser,
		/obj/item/gun/ballistic/automatic/pistol/mk23,
		/obj/item/gun/ballistic/shotgun/trench,
		/obj/item/gun/ballistic/shotgun/automatic/combat/auto5,
		/obj/item/gun/ballistic/automatic/hobo/destroyer,
		/obj/item/gun/ballistic/rifle/hunting/obrez,
		/obj/item/gun/energy/laser/wattz2k,
		/obj/item/gun/energy/laser/aer9,
		/obj/item/gun/energy/laser/plasma/pistol,
		/obj/item/gun/ballistic/revolver/police/webley,
		/obj/item/gun/ballistic/revolver/hunting,
		/obj/item/gun/ballistic/revolver/revolver45/gunslinger,
		/obj/item/gun/ballistic/revolver/colt357/auto,
		/obj/item/gun/ballistic/rifle/repeater/trail,
		/obj/item/gun/ballistic/rifle/repeater/ranger,
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock,
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever,
		/obj/item/gun/ballistic/bow/longbow,
		/obj/item/gun/ballistic/automatic/sportcarbine/m1_22,
		/obj/item/gun/ballistic/automatic/varmint/ratslayer,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/maria,
		/obj/item/gun/ballistic/automatic/pistol/n99/crusader,
		/obj/item/gun/ballistic/revolver/colt357/lucky,
		/obj/item/gun/ballistic/automatic/delisle/commando,
		/obj/item/gun/ballistic/automatic/pistol/m1911/custom,
		/obj/item/gun/ballistic/automatic/m1carbine/compact,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp40,
		/obj/item/melee/onehanded/machete/gladius,
		/obj/item/melee/onehanded/knife/trench,
		/obj/item/gun/energy/laser/retro,
		/obj/item/gun/ballistic/revolver/grenadelauncher,
		/obj/item/gun/ballistic/shotgun/grenade,
		/obj/item/gun/energy/laser/cranklasergun/tg/carbine,
		/obj/item/gun/energy/laser/cranklasergun/tg/rifle,
		)

/datum/export/item/raregun
	cost = 1000
	unit_name = "rare guns"
	export_types = list(
		/obj/item/gun/ballistic/automatic/smg/greasegun,
		/obj/item/gun/ballistic/automatic/smg/cg45,
		/obj/item/gun/ballistic/automatic/smg/tommygun,
		/obj/item/gun/ballistic/automatic/smg/p90,
		/obj/item/gun/ballistic/automatic/smg/ppsh,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp5,
		/obj/item/gun/ballistic/automatic/rangemaster,
		/obj/item/gun/ballistic/automatic/slr,
		/obj/item/gun/ballistic/automatic/m1garand,
		/obj/item/gun/ballistic/automatic/m1garand/sks,
		/obj/item/gun/ballistic/automatic/marksman/sniper,
		/obj/item/gun/ballistic/automatic/service/r82,
		/obj/item/gun/ballistic/automatic/assault_rifle,
		/obj/item/gun/ballistic/automatic/r93,
		/obj/item/gun/ballistic/automatic/lewis,
		/obj/item/gun/ballistic/automatic/type93,
		/obj/item/gun/ballistic/automatic/lsw,
		/obj/item/gun/ballistic/automatic/pistol/deagle,
		/obj/item/gun/ballistic/automatic/pistol/automag,
		/obj/item/gun/ballistic/automatic/pistol/pistol14,
		/obj/item/gun/ballistic/automatic/pistol/pistol14/compact,
		/obj/item/gun/ballistic/rifle/mag/boys,
		/obj/item/gun/ballistic/rifle/mag/antimaterial,
		/obj/item/gun/ballistic/shotgun/police,
		/obj/item/gun/ballistic/shotgun/automatic/combat/neostead,
		/obj/item/gun/ballistic/shotgun/automatic/combat/citykiller,
		/obj/item/gun/ballistic/automatic/shotgun/riot,
		/obj/item/gun/ballistic/automatic/fnfal,
		/obj/item/gun/ballistic/automatic/bar,
		/obj/item/gun/energy/laser/scatter,
		/obj/item/gun/energy/laser/aer12,
		/obj/item/gun/energy/laser/rcw,
		/obj/item/gun/energy/laser/plasma/glock,
		/obj/item/gun/energy/laser/plasma,
		/obj/item/gun/energy/ionrifle,
		/obj/item/gun/energy/laser/wattz2k/extended,
		/obj/item/gun/energy/laser/solar,
		/obj/item/gun/ballistic/revolver/m2405,
		/obj/item/gun/ballistic/revolver/sequoia,
		/obj/item/gun/ballistic/rifle/repeater/brush,
		/obj/item/gun/ballistic/bow/compoundbow,
		/obj/item/m2flamethrowertank,
		/obj/item/gun/ballistic/rocketlauncher,
		/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator,
		/obj/item/gun/ballistic/automatic/pistol/n99/executive,
		/obj/item/gun/ballistic/rifle/hunting/paciencia,
		/obj/item/gun/ballistic/automatic/smg/american180/b180,
		/obj/item/gun/energy/laser/plasma/pistol/eve,
		/obj/item/gun/ballistic/automatic/g11,
		/obj/item/gun/ballistic/automatic/smg/sidewinder/magnum,
		/obj/item/gun/ballistic/automatic/service/alr,
		/obj/item/gun/ballistic/automatic/service/carbine,
		/obj/item/gun/energy/laser/wattz/recharger,
		/obj/item/gun/energy/laser/wattz2ks,
		/obj/item/gun/ballistic/rocketlauncher,
		/obj/item/gun/magic/,
		/obj/item/gun/energy/laser/cranklasergun/tg/rifle/heavy,
		/obj/item/gun/energy/laser/cranklasergun/tg/rifle/auto,
		/obj/item/gun/energy/laser/tg/recharger,
		)

/datum/export/item/uniquegun
	cost = 3000
	unit_name = "unique guns"
	export_types = list(
		/obj/item/gun/ballistic/automatic/smg/smg14,
		/obj/item/gun/ballistic/automatic/m1garand/oldglory,
		/obj/item/gun/ballistic/automatic/m1garand/republicspride,
		/obj/item/gun/ballistic/automatic/marksman/sniper/gold,
		/obj/item/gun/ballistic/automatic/bozar,
		/obj/item/gun/ballistic/automatic/wt550,
		/obj/item/gun/ballistic/automatic/r84,
		/obj/item/gun/ballistic/automatic/lewis/lanoe,
		/obj/item/gun/ballistic/automatic/m1919,
		/obj/item/gun/ballistic/automatic/m72,
		/obj/item/gun/ballistic/automatic/xl70e3,
		/obj/item/minigunpackbal5mm,
		/obj/item/gun/ballistic/automatic/pistol/deagle/elcapitan,
		/obj/item/gun/ballistic/automatic/pistol/pistol14/lildevil,
		/obj/item/gun/energy/laser/badlands,
		/obj/item/gun/energy/laser/scatter/nonlethal,
		/obj/item/gun/energy/laser/scatter/laserbuss,
		/obj/item/gun/energy/laser/aer14,
		/obj/item/gun/energy/laser/laer,
		/obj/item/gun/energy/laser/plasma/pistol/alien,
		/obj/item/minigunpack,
		/obj/item/gun/energy/laser/plasma/pistol/adam,
		/obj/item/gun/energy/laser/plasma/carbine,
		/obj/item/gun/energy/laser/plasma/scatter,
		/obj/item/gun/energy/ionrifle/carbine,
		/obj/item/gun/energy/tesla/teslacannon,
		/obj/item/melee/onehanded/dragonfire,
		/obj/item/melee/unarmed/aethergiestgauntlet,
		/obj/item/melee/unarmed/powerfist/goliath,
		/obj/item/melee/powered/ripper/prefall,
		/obj/item/twohanded/spear/bonespear/aethergiest,
		/obj/item/twohanded/sledgehammer/atomsjudgement,
		/obj/item/sord,
		/obj/item/melee/transforming/plasmacutter/regular/adam,
		/obj/item/gun/ballistic/fatman,
		/obj/item/gun/ballistic/rifle/hunting/paciencia,
		/obj/item/gun/ballistic/revolver/shotpistol/flair_gun,
		/obj/item/gun/energy/laser/tg/particlecannon,
		/obj/item/gun/energy/laser/xcomufolaser,
		/obj/item/gun/energy/laser/LaserAK,
	)

/datum/export/item/melee
	cost = 1000
	unit_name = "melee weapon"
	export_types = list(
	/obj/item/melee/powerfist/f13,
	/obj/item/melee/coyote,
	/obj/item/melee/onehanded,
	/obj/item/twohanded,
	)

/datum/export/item/armorrare
	cost = 1500
	unit_name = "quality armor"
	export_types = list(
		/obj/item/clothing/suit/armor/heavy/salvaged_pa,
		/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa,
		/obj/item/clothing/suit/armor/heavy/riot/combat,
		/obj/item/clothing/head/helmet/f13/combat/rangerbroken,
		/obj/item/clothing/suit/armor/medium/combat/mk2,
		/obj/item/clothing/head/helmet/f13/combat/mk2,
		/obj/item/clothing/suit/armor/medium/combat/mk2/dark,
		/obj/item/clothing/head/helmet/f13/combat/mk2/dark,
		/obj/item/clothing/suit/armor/heavy/riot/vault,
		/obj/item/clothing/suit/armor/heavy/riot/marine,
		/obj/item/clothing/suit/armor/medium/odst,
		/obj/item/clothing/suit/armor/medium/odstlead,
	)

/datum/export/item/powerarmor // note to self -- tier this later, kelprunner, 9/16/23
	cost = 7000
	unit_name = "power armor frame"
	export_types = list(
		/obj/item/clothing/suit/armor/power_armor,
	)

/datum/export/item/powerarmorhelmet
	cost = 500
	unit_name = "power armor helmet"
	export_types = list(
		/obj/item/clothing/head/helmet/f13/power_armor,
	)

/datum/export/item/armoruncommon
	cost = 1000
	unit_name = "surplus armor"
	export_types = list(
		/obj/item/clothing/suit/armor/heavy/metal/reinforced,
		/obj/item/clothing/head/helmet/f13/metalmask/mk2,
		/obj/item/clothing/head/helmet/f13/combat/swat,
		/obj/item/clothing/suit/armor/medium/combat/swat,
		/obj/item/clothing/suit/armor/medium/combat,
		/obj/item/clothing/head/helmet/f13/combat,
		/obj/item/clothing/suit/armor/heavy/vest/bulletproof,
		/obj/item/clothing/head/helmet/alt,
		/obj/item/clothing/suit/armor/heavy/metal/sulphite,
		/obj/item/clothing/head/helmet/f13/sulphitehelm,
		/obj/item/clothing/suit/armor/medium/vest/bulletproof/big,
		/obj/item/clothing/head/helmet/riot/vaultsec,
		/obj/item/clothing/suit/armor/medium/raider/slam,
		/obj/item/clothing/suit/armor/medium/raider/rebel,
		/obj/item/clothing/suit/armor/medium/raider/slam,
		/obj/item/clothing/suit/armor/medium/raider/wastewar,
		/obj/item/clothing/suit/armor/medium/combat/mk2/raider,
		/obj/item/clothing/head/helmet/f13/raider/wastehound,
		/obj/item/clothing/head/helmet/f13/raidermetal,
		/obj/item/clothing/suit/armor/medium/combat/dark,
		/obj/item/clothing/head/helmet/f13/combat/dark,
		/obj/item/clothing/suit/armor/medium/raider/reptiliatenebris,
		/obj/item/clothing/suit/armor/medium/odstcqb,
	)

/datum/export/item/energycell
	cost = 100
	unit_name = "energy cell"
	export_types = list(/obj/item/stock_parts/cell/ammo/ec)

/datum/export/item/mfc
	cost = 300
	unit_name = "microfusion cell"
	export_types = list(/obj/item/stock_parts/cell/ammo/mfc)

/datum/export/item/ecp
	cost = 400
	unit_name = "electron charge pack"
	export_types = list(/obj/item/stock_parts/cell/ammo/ecp)

/datum/export/item/bountycard
	cost = 0 // 50% more than the salvager, lets shop purchase them for a higher price than the scrapper and still make profit. Limited resource.
	unit_name = "small roller bounty ticket"
	export_types = list(/obj/item/card)

/datum/export/item/bountycard/get_cost(atom/movable/AM)
	return SEND_SIGNAL(AM, COMSIG_ATOM_GET_VALUE)



// /datum/export/item/lowbounty
// 	cost = 1500 // 50% more than the salvager, lets shop purchase them for a higher price than the scrapper and still make profit. Limited resource.
// 	unit_name = "small roller bounty ticket"
// 	export_types = list(/obj/item/card/lowbounty)

// /datum/export/item/midbounty
// 	cost = 3000 // 50% more than the salvager, lets shop purchase them for a higher price than the scrapper and still make profit. Limited resource.
// 	unit_name = "medium roller bounty ticket"
// 	export_types = list(/obj/item/card/midbounty)

// /datum/export/item/highbounty
// 	cost = 6000 // 50% more than the salvager, lets shop purchase them for a higher price than the scrapper and still make profit. Limited resource.
// 	unit_name = "high roller bounty ticket"
// 	export_types = list(/obj/item/card/highbounty)

// /datum/export/item/kingbounty
// 	cost = 12000 // 50% more than the salvager, lets shop purchase them for a higher price than the scrapper and still make profit. Limited resource.
// 	unit_name = "a king's  bounty ticket"
// 	export_types = list(/obj/item/card/kingbounty)

/datum/export/item/trashmeat // Bugs, nasty things. Gross.
	cost = 100
	unit_name = "low-quality meat products"
	export_types = list(/obj/item/reagent_containers/food/snacks/meat/slab/radroach_meat,
						/obj/item/reagent_containers/food/snacks/meat/slab/bloatfly_meat,
						/obj/item/reagent_containers/food/snacks/meat/slab/cazador_meat,
						/obj/item/reagent_containers/food/snacks/meat/slab/fireant_meat,
						/obj/item/reagent_containers/food/snacks/meat/slab/ant_meat,
						/obj/item/reagent_containers/food/snacks/rawantbrain,
						/obj/item/reagent_containers/food/snacks/meat/slab/radscorpion_meat)

/datum/export/item/commonmeat // Real meat. Yum. Stuff high in important minerals.
	cost = 250
	unit_name = "common meat products"
	export_types = list(/obj/item/reagent_containers/food/snacks/meat/slab,
						/obj/item/reagent_containers/food/snacks/meat/slab/gecko,
						/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk,
						/obj/item/reagent_containers/food/snacks/meat/slab/molerat)

/datum/export/item/raremeat // Delicacies.
	cost = 450
	unit_name = "high-quality meat products"
	export_types = list(/obj/item/reagent_containers/food/snacks/meat/slab/wolf,
						/obj/item/reagent_containers/food/snacks/meat/slab/aethergiest)

/datum/export/item/processedmeats
	cost = 20 // Gotta be small so people cant cheese the meat with a food processor
	unit_name = "meat portion"
	export_types = list(/obj/item/reagent_containers/food/snacks/meat/rawbacon,
						/obj/item/reagent_containers/food/snacks/rawmeatball

	)

/datum/export/item/traitbookslow
	cost = 800
	unit_name = "low-quality technical manual"
	export_types = list(/obj/item/book/granter/trait/lowsurgery,
				/obj/item/book/granter/trait/chemistry,
				/obj/item/book/granter/crafting_recipe/scav_one,
				/obj/item/book/granter/crafting_recipe/scav_two,
				/obj/item/book/granter/trait/explosives,
				/obj/item/book/granter/trait/techno,
				/obj/item/book/granter/crafting_recipe/ODF,
				/obj/item/book/granter/action/drink_fling,)
				// /obj/item/book/granter/crafting_recipe/gunsmith_one)

/datum/export/item/traitbooks
	cost = 1000
	unit_name = "high-quality technical manual"
	export_types = list(/obj/item/book/granter/trait/lowsurgery,
				/obj/item/book/granter/trait/chemistry,
				// /obj/item/book/granter/trait/trekking,
				/obj/item/book/granter/trait/pa_wear,
				/obj/item/book/granter/trait/explosives,
				/obj/item/book/granter/trait/explosives_advanced,
				/obj/item/book/granter/trait/rifleman,)
				// /obj/item/book/granter/crafting_recipe/gunsmith_two,
				// /obj/item/book/granter/crafting_recipe/gunsmith_three,
				// /obj/item/book/granter/crafting_recipe/gunsmith_four)

/datum/export/item/crops
	cost = 50
	unit_name = "produce"
	export_types = list(/obj/item/reagent_containers/food/snacks/grown/agave,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia/vulgaris,
		/obj/item/reagent_containers/food/snacks/grown/apple,
		/obj/item/reagent_containers/food/snacks/grown/banana,
		/obj/item/reagent_containers/food/snacks/grown/soybeans,
		/obj/item/reagent_containers/food/snacks/grown/berries,
		/obj/item/reagent_containers/food/snacks/grown/cherries,
		/obj/item/reagent_containers/food/snacks/grown/grapes,
		/obj/item/reagent_containers/food/snacks/grown/grapes/green,
		/obj/item/reagent_containers/food/snacks/grown/strawberry,
		/obj/item/reagent_containers/food/snacks/grown/broc,
		/obj/item/reagent_containers/food/snacks/grown/buffalogourd,
		/obj/item/reagent_containers/food/snacks/grown/wheat,
		/obj/item/reagent_containers/food/snacks/grown/oat,
		/obj/item/reagent_containers/food/snacks/grown/rice,
		/obj/item/reagent_containers/food/snacks/grown/chili,
		/obj/item/reagent_containers/food/snacks/grown/bell_pepper,
		/obj/item/reagent_containers/food/snacks/grown/citrus/lime,
		/obj/item/reagent_containers/food/snacks/grown/citrus/orange,
		/obj/item/reagent_containers/food/snacks/grown/citrus/lemon,
		/obj/item/reagent_containers/food/snacks/grown/cocoapod,
		/obj/item/reagent_containers/food/snacks/grown/corn,
		/obj/item/grown/cotton,
		/obj/item/reagent_containers/food/snacks/grown/coyotetobacco,
		/obj/item/reagent_containers/food/snacks/grown/datura,
		/obj/item/reagent_containers/food/snacks/grown/eggplant,
		/obj/item/reagent_containers/food/snacks/grown/feracactus,
		/obj/item/reagent_containers/food/snacks/grown/fever_blossom,
		/obj/item/reagent_containers/food/snacks/grown/poppy,
		/obj/item/reagent_containers/food/snacks/grown/poppy/lily,
		/obj/item/reagent_containers/food/snacks/grown/poppy/geranium,
		/obj/item/reagent_containers/food/snacks/grown/poppy/geranium/forgetmenot,
		/obj/item/reagent_containers/food/snacks/grown/harebell,
		/obj/item/grown/sunflower,
		/obj/item/reagent_containers/food/snacks/grown/garlic,
		/obj/item/reagent_containers/food/snacks/grown/herbs,
		/obj/item/reagent_containers/food/snacks/grown/horsenettle,
		/obj/item/reagent_containers/food/snacks/grown/watermelon,
		/obj/item/reagent_containers/food/snacks/grown/mesquite,
		/obj/item/reagent_containers/food/snacks/grown/cabbage,
		/obj/item/reagent_containers/food/snacks/grown/sugarcane,
		/obj/item/reagent_containers/food/snacks/grown/coconut,
		/obj/item/reagent_containers/food/snacks/grown/aloe,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/reishi,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/amanita,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/libertycap,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/plumphelmet,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/chanterelle,
		/obj/item/reagent_containers/food/snacks/grown/mutfruit,
		/obj/item/reagent_containers/food/snacks/grown/nettle,
		/obj/item/reagent_containers/food/snacks/grown/onion,
		/obj/item/reagent_containers/food/snacks/grown/peach,
		/obj/item/reagent_containers/food/snacks/grown/peanut,
		/obj/item/reagent_containers/food/snacks/grown/peas,
		/obj/item/reagent_containers/food/snacks/grown/pineapple,
		/obj/item/reagent_containers/food/snacks/grown/pinyon,
		/obj/item/reagent_containers/food/snacks/grown/potato,
		/obj/item/reagent_containers/food/snacks/grown/pricklypear,
		/obj/item/reagent_containers/food/snacks/grown/pumpkin,
		/obj/item/reagent_containers/food/snacks/grown/pungafruit,
		/obj/item/reagent_containers/food/snacks/grown/rainbow_flower,
		/obj/item/reagent_containers/food/snacks/grown/carrot,
		/obj/item/reagent_containers/food/snacks/grown/parsnip,
		/obj/item/reagent_containers/food/snacks/grown/tato,
		/obj/item/reagent_containers/food/snacks/grown/coffee,
		/obj/item/reagent_containers/food/snacks/grown/tea,
		/obj/item/reagent_containers/food/snacks/grown/tobacco,
		/obj/item/reagent_containers/food/snacks/grown/tomato,
		/obj/item/grown/log,
		/obj/item/reagent_containers/food/snacks/grown/xander,
		/obj/item/reagent_containers/food/snacks/grown/yucca,
	)

/datum/export/item/rarecrops
	cost = 100
	unit_name = "exotic produce"
	export_types = list(/obj/item/reagent_containers/food/snacks/grown/ambrosia/deus,
		/obj/item/reagent_containers/food/snacks/grown/ambrosia/gaia,
		/obj/item/reagent_containers/food/snacks/grown/apple/gold,
		/obj/item/reagent_containers/food/snacks/grown/banana/banana_spider_spawnable,
		/obj/item/reagent_containers/food/snacks/grown/koibeans,
		/obj/item/reagent_containers/food/snacks/grown/berries/poison,
		/obj/item/reagent_containers/food/snacks/grown/berries/death,
		/obj/item/reagent_containers/food/snacks/grown/berries/glow,
		/obj/item/reagent_containers/food/snacks/grown/bluecherries,
		/obj/item/reagent_containers/food/snacks/grown/cherrybulbs,
		/obj/item/reagent_containers/food/snacks/grown/cannabis,
		/obj/item/reagent_containers/food/snacks/grown/cannabis/white,
		/obj/item/reagent_containers/food/snacks/grown/meatwheat,
		/obj/item/reagent_containers/food/snacks/grown/icepepper,
		/obj/item/reagent_containers/food/snacks/grown/ghost_chili,
		/obj/item/reagent_containers/food/snacks/grown/citrus/orange_3d,
		/obj/item/reagent_containers/food/snacks/grown/firelemon,
		/obj/item/reagent_containers/food/snacks/grown/vanillapod,
		/obj/item/reagent_containers/food/snacks/grown/bungofruit,
		/obj/item/reagent_containers/food/snacks/grown/bungopit,
		/obj/item/grown/snapcorn,
		/obj/item/grown/cotton/durathread,
		/obj/item/reagent_containers/food/snacks/grown/shell/eggy,
		/obj/item/reagent_containers/food/snacks/grown/trumpet,
		/obj/item/reagent_containers/food/snacks/grown/moonflower,
		/obj/item/grown/novaflower,
		/obj/item/reagent_containers/food/snacks/grown/bee_balm,
		/obj/item/grown/rose,
		/obj/item/grown/carbon_rose,
		/obj/item/reagent_containers/food/snacks/grown/holymelon,
		/obj/item/reagent_containers/food/snacks/grown/cherry_bomb,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/angel,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/walkingmushroom,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/jupitercup,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/glowshroom,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/glowshroom/glowcap,
		/obj/item/reagent_containers/food/snacks/grown/mushroom/glowshroom/shadowshroom,
		/obj/item/reagent_containers/food/snacks/grown/nettle/death,
		/obj/item/reagent_containers/food/snacks/grown/onion/red,
		/obj/item/reagent_containers/food/snacks/grown/laugh,
		/obj/item/reagent_containers/food/snacks/grown/peace,
		/obj/item/reagent_containers/food/snacks/grown/potato/sweet,
		/obj/item/reagent_containers/food/snacks/grown/blumpkin,
		/obj/item/reagent_containers/food/snacks/grown/whitebeet,
		/obj/item/reagent_containers/food/snacks/grown/redbeet,
		/obj/item/reagent_containers/food/snacks/grown/tea/astra,
		/obj/item/reagent_containers/food/snacks/grown/tea/catnip,
		/obj/item/reagent_containers/food/snacks/grown/coffee/robusta,
		/obj/item/reagent_containers/food/snacks/grown/tobacco/space,
		/obj/item/reagent_containers/food/snacks/grown/tomato/blood,
		/obj/item/reagent_containers/food/snacks/grown/tomato/blue,
		/obj/item/reagent_containers/food/snacks/grown/tomato/killer,
		/obj/item/grown/log/bamboo
	)

/datum/export/item/liquor
	cost = 1000
	unit_name = "cheap liquor"
	export_types = list(/obj/item/export/bottle/gin,
	/obj/item/export/bottle/whiskey,
	/obj/item/export/bottle/wine,
	/obj/item/export/bottle/vodka,
	/obj/item/export/bottle/rum,
	/obj/item/export/bottle/tequila,
	/obj/item/export/bottle/minikeg,
	/obj/item/export/bottle/applejack,
	/obj/item/export/bottle/cognac,
	/obj/item/export/bottle/sake,
	/obj/item/export/bottle/hcider,
	/obj/item/export/bottle/vermouth,
	/obj/item/export/bottle/absinthe,
	/obj/item/export/bottle/grappa,
	/obj/item/export/bottle/fernet,
	/obj/item/export/bottle/kahlua,
	)

/datum/export/item/highliquor
	cost = 1500
	unit_name = "classy liquor"
	export_types = list(/obj/item/export/bottle/champagne,
	/obj/item/export/bottle/blazaam,
	/obj/item/export/bottle/nukashine,
	/obj/item/export/bottle/trappist,
	/obj/item/export/bottle/goldschlager,
	/obj/item/export/bottle/patron,
	)


/datum/export/item/toyslow
	k_elasticity = 1/100 // Toy lathe is scary
	cost = 500
	unit_name = "basic toy"
	export_types = list(/obj/item/toy,
						/obj/item/gun/ballistic/shotgun/toy,
						/obj/item/gun/ballistic/automatic/toy,
	)


/datum/export/item/toyshigh
	k_elasticity = 1/100 // Toy lathe is scary
	cost = 1000
	unit_name = "advanced toy"
	export_types = list(/obj/item/toy/prize,
	/obj/item/toy/talking,
	)

/datum/export/item/prefallsalvage
	cost = 62.5 // 2000 credits or 200 caps for the shop per full bag. Avg 80 caps for customers per bag
	unit_name = "saleable scrap"
	export_types = list(/obj/item/salvage/low,
	)

/datum/export/item/toolsalvage
	cost = 2500 // Tools are nice, but often clutter places up. This should help.
	unit_name = "tool salvage"
	export_types = list(/obj/item/salvage/tool,
	)

/datum/export/item/advancedtools
	cost = 500 // Tools are useful. Good tools are better. Makes selling to shop better than scrapping them.
	unit_name = "quality tools"
	export_types = list(/obj/item/weldingtool/advanced,
					/obj/item/crowbar/hightech,
					/obj/item/screwdriver/hightech,
					/obj/item/wrench/hightech,
					/obj/item/wirecutters/hightech,
					/obj/item/multitool/advanced)

/datum/export/item/ultratools
	cost = 2750 // Super expensive so theyre worth something when sold. Difficult for clinic to reproduce these.
	unit_name = "ultracite tools"
	export_types = list(/obj/item/weldingtool/abductor,
						/obj/item/wrench/abductor,
						/obj/item/wirecutters/abductor,
						/obj/item/screwdriver/abductor,
						/obj/item/crowbar/abductor,
						/obj/item/multitool/abductor)

/datum/export/item/advancedsalvage
	cost = 2500 // advanced salvage is VERY in demand in and outside the shop. Very valuable.
	unit_name = "quality salvage"
	export_types = list(/obj/item/salvage/high,
	)

/datum/export/item/advancedsalvageloot
	cost = 800 // advanced salvage is VERY in demand in and outside the shop. Very valuable.
	unit_name = "quality components"
	export_types = list(/obj/item/advanced_crafting_components/receiver,
				/obj/item/advanced_crafting_components/assembly,
				/obj/item/advanced_crafting_components/alloys,
				/obj/item/advanced_crafting_components/conductors,
				/obj/item/advanced_crafting_components/lenses,
				/obj/item/advanced_crafting_components/flux,
)

/datum/export/item/nightstalkerpelt
	cost = 200
	unit_name = "nightstalker pelt"
	export_types = list(/obj/item/clothing/head/f13/stalkerpelt,
	)

/datum/export/item/armorgeneric
	cost = 300 // just a test so the shop can actually move armor since nobody ever buys it //this existing means the armor crates have to be expensive
	unit_name = "armor item"
	export_types = list(/obj/item/clothing/suit/armor,
	)

/datum/export/item/stealthboy
	cost = 1500
	unit_name = "cloaking device"
	export_types = list(/obj/item/stealthboy
	)
/datum/export/item/lowfish
	cost = 150
	unit_name = "common fish"
	export_types = list(/obj/item/fishy/carp,
						/obj/item/fishy/salmon,
						/obj/item/fishy/crawdad,
						/obj/item/fishy/shrimp,
	)

/datum/export/item/highfish
	cost = 500
	unit_name = "rare fish"
	export_types = list(/obj/item/fishy/eel,
	)

/datum/export/item/forged
	cost = 200
	unit_name = "forged weapons"
	export_types = list(
//	/obj/item/melee/smith/sword,
//	/obj/item/melee/smith/sword/spatha,
//	/obj/item/melee/smith/sword/sabre,
	/obj/item/melee/smith/dagger // haha skyrim dagger farm
//	/obj/item/melee/smith/dagger/bowie,
//	/obj/item/melee/smith/machete,
//	/obj/item/melee/smith/machete/gladius,
//	/obj/item/melee/smith/machete/reforged,
//	/obj/item/melee/smith/wakizashi,
//	/obj/item/melee/smith/mace,
//	/obj/item/melee/smith/twohand/katana,
//	/obj/item/melee/smith/twohand/longsword,
//	/obj/item/melee/smith/twohand/axe,
//	/obj/item/melee/smith/twohand/axe/warhoned,
//	/obj/item/melee/smith/twohand/axe/crusher,
//	/obj/item/melee/smith/twohand/axe/scrapblade,
//	/obj/item/melee/smith/twohand/spear,
//	/obj/item/melee/smith/twohand/spear/lance,
//	/obj/item/melee/smith/twohand/spear/trident,
//	/obj/item/melee/smith/javelin,
//	/obj/item/melee/smith/throwingknife,
	)

/datum/export/item/nucrate // Hopefully this one works
	cost = 200
	k_elasticity = 0
	unit_name = "crate"
	export_types = list(/obj/structure/closet/crate, /obj/structure/closet/crate/footlocker)
	exclude_types = list(/obj/structure/closet/crate/large, /obj/structure/closet/crate/wooden, /obj/structure/closet/crate/bin)

/datum/export/item/lowartifact
	cost = 5000
	unit_name = "common artifact"
	export_types = list(/obj/item/artifact/common,
	)

/datum/export/item/highartifact
	cost = 15000
	unit_name = "rare artifact"
	export_types = list(/obj/item/artifact/rare,
	)

/datum/export/item/midartifact
	cost = 10000
	unit_name = "uncommon artifact"
	export_types = list(/obj/item/artifact/uncommon,
	)

/* k_elasticity 0 - the price degredation thing, in case we need it. Might need to be applied to toys in the future. */

