//Mantles

/obj/item/clothing/neck/mantle
	name = "mantle template"
	desc = " worn in accessory slot, no concealing hood, decorative."
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|ARMS
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = null
	cold_protection = null
	permeability_coefficient = 0.9

/obj/item/clothing/neck/mantle/gecko
	name = "gecko skin mantle"
	desc = "Made from tanned young gecko hides, too thin to be useful for armor. The small claws are still attached."
	icon_state = "gecko"

/obj/item/clothing/neck/mantle/gray
	name = "plain gray mantle"
	desc = "A simple mantle to cover your shoulders with."
	icon_state = "gray"

/obj/item/clothing/neck/mantle/brown
	name = "plain brown mantle"
	desc = "A simple mantle to cover your shoulders with."
	icon_state = "brown"

/obj/item/clothing/neck/mantle/red
	name = "plain red mantle"
	desc = "A simple mantle to cover your shoulders with."
	icon_state = "red"

/obj/item/clothing/neck/mantle/overseer
	name = "vault-tec overseers mantle"
	desc = "This is the overseers mantle.  Issued by the Vault-tec corporation to easily identify the overseer. This mantle has been passed down from overseer to overseer"
	icon_state = "overseer"

/obj/item/clothing/neck/mantle/bos
	name = "Brotherhood of Steel shoulder cape"
	desc = "Issued to the Elders of the Brotherhood. Style over substance is important. This one is designed to be worn over the shoulder."
	icon_state = "bosshouldercape_l"

/obj/item/clothing/neck/mantle/bos/left
	name = "Brotherhood of Steel shoulder cape"
	desc = "Issued to the Elders of the Brotherhood. Style over substance is important. This one is designed to be worn over the shoulder."
	icon_state = "bosshouldercape_l"

/obj/item/clothing/neck/mantle/bos/right
	name = "Brotherhood of Steel shoulder cape"
	desc = "Issued to the Elders of the Brotherhood. Style over substance is important. This one is designed to be worn over the shoulder."
	icon_state = "bosshouldercape_r"

/obj/item/clothing/neck/mantle/bos/paladin
	name = "Paladin cape"
	desc = "This stylish deep crimson cape is made to be worn below a power armor pauldron, a shoulder holster is added for utility."
	icon_state = "paladin"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bos/paladin

/obj/item/clothing/neck/mantle/legion
	name = "Pizza Legion Cape"
	desc = "A deep crimson cape (it resembles marinara) woven by finest kitchen craftsman. A shoulder holster is added beneath for utility (it smells like old pepperonis.)"
	icon_state = "legion"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bos/paladin

/obj/item/clothing/neck/mantle/ranger
	name = "ranger cape"
	desc = "Ranger cape made from what looks like old poncho fitted with star, stripes and a bear. Most likely has a holster hidden underneath."
	icon_state = "rangercape"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bos/paladin

/obj/item/clothing/neck/mantle/chief
	name = "chieftains mantle"
	desc = "A symbol of the authority of the Wayfarer Chief."
	icon_state = "tribechief"

/obj/item/clothing/neck/mantle/jay
	name = "blue silk mantle"
	desc = "A finely woven and blue dyed mantle, with the emblem of a bird on its back."
	icon_state = "jaymantle"

/obj/item/clothing/neck/mantle/green
	name = "green decorated mantle"
	desc = "A mantle with festive green decorative patterns."
	icon = 'icons/fallout/clothing/custom/custom.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/custom/custom.dmi'
	icon_state = "mantle_wintergreen"
	item_state = "mantle_wintergreen"

/obj/item/clothing/neck/mantle/commander
	name = "commanders mantle"
	desc = "A fine mantle marking the wearer as a Commander of some long lost nation."
	icon_state = "commander"

/obj/item/clothing/neck/mantle/treasurer
	name = "treasurers mantle"
	desc = "The grey and black mantle with gold thread trimming shows the wearer is entrusted with matters of money and records. Hidden inner pockets can store money, keys and documents safely, and a discrete sheath for a knife for self defence is also attached."
	icon_state = "treasurer"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/treasurer

/obj/item/clothing/neck/mantle/peltfur
	name = "fur pelt"
	desc = "A pelt made from longhorner fur."
	icon_state = "peltfur"
	cold_protection = CHEST|GROIN|ARMS
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/neck/mantle/peltmountain
	name = "fur pelt"
	desc = "A pelt made from a mountain bear, brought in from Colorado."
	icon_state = "peltmountain"
	cold_protection = CHEST|GROIN|ARMS
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/neck/mantle/ragged
	name = "ragged mantle"
	desc = "A worn and ripped old primitive mantle, made from sinew and bone."
	icon_state = "ragged"

/obj/item/clothing/neck/mantle/poncho
	name = "poncho"
	desc = "Plain and rugged piece of clothing, put it over your suit and make sure your gear don't get soaked through when it rains."
	icon_state = "poncho"
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/neck/mantle/umbo
	name = "Roman mantle"
	desc = "A decorated mantle created in the ancient roman era, this one appears to be hand made by an auxilia likely with a large bust."
	icon_state = "umbo"

/obj/item/clothing/neck/mantle/snugglycape
	name = "Fancy Cape"
	desc = "A fancy looking cape that has been manufactured for an androgynous person."
	icon_state = "snugglycape"

/obj/item/clothing/neck/tie/gob
	name = "base cape"
	desc = "A black cape with a blue trim."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "allseer"
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|ARMS
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT

/obj/item/clothing/neck/tie/gob/allseer
	name = "All Seer Cape"
	desc = "A black cape with a blue trim."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "allseer"

/obj/item/clothing/neck/tie/gob/astral
	name = "Astral Cape"
	desc = "A dark purple cape with a white trim."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "astral"

/obj/item/clothing/neck/tie/gob/black
	name = "Black Cape"
	desc = "A dark black cape that's pretty flowy."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "black"

/obj/item/clothing/neck/tie/gob/black_shoulder
	name = "Black Shoulder Cape"
	desc = "A black cape with a golden trim."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "black_shoulder"

/obj/item/clothing/neck/tie/gob/bluewolves
	name = "Blue Wolves Cape"
	desc = "A black cape with blue trim."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "bluewolves"

/obj/item/clothing/neck/tie/gob/redstar
	name = "Red Star Cape"
	desc = "A black cape with a white trim."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "redstar"

/obj/item/clothing/neck/tie/gob/grey
	name = "Grey Cape"
	desc = "A long grey cape!"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "grey"

/obj/item/clothing/neck/tie/gob/aegis
	name = "Aegis Cape"
	desc = "A black cape with a white feather attatched. "
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "aegis"

/obj/item/clothing/neck/tie/gob/darkpurple
	name = "Dark Purple Cape"
	desc = "A dark purple cape "
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "darkpurple"

/obj/item/clothing/neck/tie/gob/darkpurple
	name = "Dark Purple Cape"
	desc = "A dark purple cape "
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "darkpurple"

/obj/item/clothing/neck/tie/gob/blue
	name = "Blue Cape"
	desc = "A blue cape "
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "blue"

/obj/item/clothing/neck/tie/gob/green
	name = "Green Cape"
	desc = "A green cape "
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "green"

/obj/item/clothing/neck/tie/gob/purple
	name = "Purple Cape"
	desc = "A purple cape "
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "purple"

/obj/item/clothing/neck/tie/gob/red
	name = "Red Cape"
	desc = "A Red cape "
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "red"

/obj/item/clothing/neck/tie/gob/whiteblue
	name = "White cape with blue lining"
	desc = "A white cape with blue lining, fancy!"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "white_blue"

/obj/item/clothing/neck/tie/gob/white
	name = "White cape"
	desc = "A white cape"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "white"

/obj/item/clothing/neck/tie/gob/azure_dawn
	name = "Azure Dawn Cape"
	desc = "A dark blue cape with yellow trim."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "azure_dawn"

/obj/item/clothing/neck/tie/gob/azure_dawn
	name = "Azure Dawn Cape"
	desc = "A dark blue cape with yellow trim."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "azure_dawn"

/obj/item/clothing/neck/tie/gob/delta
	name = "Delta Cape"
	desc = "A black cape with a white trim."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "delta"

/obj/item/clothing/neck/tie/gob/black_fur
	name = "black fur lined cape"
	desc = "A black cape lined with fur"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "black_fur"

/obj/item/clothing/neck/tie/gob/gold_lions
	name = "Black cape lined with gold"
	desc = "A black cape lined with crests of gold."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "gold_lions"

/obj/item/clothing/neck/tie/gob/heart
	name = "Heart Cape"
	desc = "A pink cape with a heart on it."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "heart"

/obj/item/clothing/neck/tie/gob/silk
	name = "Silk Cape"
	desc = "A silky white cape. Flowy!"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "silk"

/obj/item/clothing/neck/tie/gob/silver_snake
	name = "Silver Snake Cape"
	desc = "A fancy black cape."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "silver_snake"

/obj/item/clothing/neck/tie/gob/white_fur
	name = "White fur cape"
	desc = "A white furred cape."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "white_fur"

/obj/item/clothing/neck/tie/inf_cloak
	name = "black cloak with red etching"
	desc = "A black and red cloak"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "inf_cloak"

/obj/item/clothing/neck/tie/carrotcloak
	name = "Carrot Cloak"
	desc = "A rather cute cloak in the shape of a carrot"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "carrotcloak"

/obj/item/clothing/neck/tie/festive
	name = "festive cloak"
	desc = "Santa is coming to town."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "festive"

/obj/item/clothing/neck/tie/green_cloak
	name = "White green cloak"
	desc = "A white cloak with green accents."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "green_cloak"

/obj/item/clothing/neck/tie/wintergreencloak
	name = "Winter Green Cloak"
	desc = "A green cloak with white accents."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "wintergreencloak"

/obj/item/clothing/neck/tie/flagcape
	name = "American Flag cape"
	desc = "'Murica"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "flagcape"

/obj/item/clothing/neck/tie/zuliecloak
	name = "Zulie Cloak"
	desc = "A dark black and grey cloak."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "zuliecloak"

/obj/item/clothing/neck/tie/vampire
	name = "Vampire Cloak"
	desc = "A dark black cloak."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "vampcape"

/obj/item/clothing/neck/tie/witchcapep
	name = "purple witch cape"
	desc = "A purple cape."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "witchcape_purple"

/obj/item/clothing/neck/tie/witchcapem
	name = "mint witch cape"
	desc = "A mint cape."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "witchcape_mint"


/obj/item/clothing/neck/tie/flagcapesaccessories
	name = "Polish flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "polanda"
	item_state = "polanda"

/obj/item/clothing/neck/tie/flagcapesaccessories/no2
	name = "Icelandic flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "icelanda"
	item_state = "icelanda"

/obj/item/clothing/neck/tie/flagcapesaccessories/no3
	name = "Finland flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "finlanda"
	item_state = "finlanda"

/obj/item/clothing/neck/tie/flagcapesaccessories/no4
	name = "Norwegian flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "norwaya"
	item_state = "norwaya"

/obj/item/clothing/neck/tie/flagcapesaccessories/no5
	name = "West German flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "germanya"
	item_state = "germanya"

/obj/item/clothing/neck/tie/flagcapesaccessories/no6
	name = "French flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "francea"
	item_state = "francea"

/obj/item/clothing/neck/tie/flagcapesaccessories/no7
	name = "Danish flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "denmarka"
	item_state = "denmarka"

/obj/item/clothing/neck/tie/flagcapesaccessories/no8
	name = "Swedish flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "swedena"
	item_state = "swedena"

/obj/item/clothing/neck/tie/flagcapesaccessories/no9
	name = "Imperial Tsar flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "imperialrusa"
	item_state = "imperialrusa"

/obj/item/clothing/neck/tie/flagcapesaccessories/no10
	name = "Irish flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "irelanda"
	item_state = "irelanda"

/obj/item/clothing/neck/tie/flagcapesaccessories/no11
	name = "Brazilian flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "brazila"
	item_state = "brazila"

/obj/item/clothing/neck/tie/flagcapesaccessories/no12
	name = "Canadian flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "canadaa"
	item_state = "canadaa"

/obj/item/clothing/neck/tie/flagcapesaccessories/no13
	name = "British flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "uka"
	item_state = "uka"

/obj/item/clothing/neck/tie/flagcapesaccessories/no14
	name = "Australian flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "australiaa"
	item_state = "australiaa"

/obj/item/clothing/neck/tie/flagcapesaccessories/no15
	name = "New Zealander flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "newzealanda"
	item_state = "newzealanda"


/obj/item/clothing/neck/tie/flagcapesaccessories/no16
	name = "Italian flag cape"
	desc = "A flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "italya"
	item_state = "italya"

/obj/item/clothing/neck/tie/warriorcataccessories
	name = "Thunderous flag cape"
	desc = "A tribal flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "thundera"
	item_state = "thundera"


/obj/item/clothing/neck/tie/warriorcataccessories/shadows
	name = "Shdowed flag cape"
	desc = "A tribal flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "shadowa"
	item_state = "shadowa"

/obj/item/clothing/neck/tie/warriorcataccessories/winds
	name = "Windy flag cape"
	desc = "A tribal flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "winda"
	item_state = "winda"


/obj/item/clothing/neck/tie/warriorcataccessories/rivers
	name = "Rivulet flag cape"
	desc = "A tribal flag cape!"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
	icon_state = "rivera"
	item_state = "rivera"
