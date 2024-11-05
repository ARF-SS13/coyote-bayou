/*
 * Old armors we dont need or use or anything go here
 */

// Metal- Melee, Laser Good, Ballistics Moderate, Energy, Explosion bad
// Leather/soft armor: Melee Good, Laser , Energy, Explosion Moderate, Ballistic Bad
// Coat style armor is good for allround protection but excels at none. (note plated with unarmored duster over is still plated.)
// Kevlar: Ballistic Good, all others Bad.
// Mix can vary wildly but usually has some glaring strongpoints and weakspots.
// Combat armor is allround but not top defense against any single category.
// Thick warm armor gives cold protection, piecemeal gives overheating protection.
// Armor covering much of the body gives more defense vs acid, fire, bio in general and vice versa.

/*
Suits. 0-10 in its primary value, slowdown 0, various utility
/obj/item/clothing/suit
	name = "suit template"
	lefthand_file = 'icons/mob/inhands/clothing_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing_righthand.dmi'
	slowdown = 0
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	allowed = null
	strip_delay = 10
*/


////////////
// LEGION //
////////////

// Recipe combine veteran armor with a kevlar vest
/obj/item/clothing/suit/armor/heavy/legion/breacher
	name = "lil ceaser's breacher armor"
	desc = "A suit with the standard metal reinforcements of a veteran and a patched bulletproof vest worn over it. Why does it smell like overcooked mozzarella?"
	icon_state = "legion_heavy"
	inhand_icon_state = "legion_heavy"

/obj/item/clothing/suit/armor/heavy/legion/centurion
	name = "larper centurion armor"
	desc = "The centurion armor from a CN9-D is by far the strongest suit of armor available to Lil Caesar's Larping Pizza Legion. The armor is composed from other pieces of armor taken from that of the wearer's defeated opponents in combat (it was oiled wrestling.)"
	icon_state = "legion_centurion"

/obj/item/clothing/suit/armor/heavy/legion/palacent
	name = "paladin-slayer biggus dickus centurion 'armor'"
	desc = "The armor of a well sliced Centurion who has bested one or more Brotherhood Paladins. Or something. Adding pieces of his prizes to his own defense. The symbol of the Pizza Legion are crudely painted on this once-'marvelous' suit of armor."
	icon_state = "legion_palacent"

/obj/item/clothing/suit/armor/heavy/legion/rangercent
	name = "wanger-huntew centuwion awmow" //uwu//
	desc = "A suit of armor collected over the years by the deaths of countless femboys out west. The inner padding has a photo of a blonde catgirl with red eyes stored in a pocket and you can't bring yourself to remove it."
	icon_state = "legion_rangercent"
	inhand_icon_state = "legion_rangercent"

/obj/item/clothing/suit/armor/heavy/legion/legate
	name = "legion's of leg-ater 'armor'"
	desc = "The armor appears to be a full suit of heavy gauge aluminum and offers 'full body protection'. It also has a cloak in excellent condition (because that's what you need in a swamp, to be warmer), but the armor itself bears numerous battle scars and the helmet is missing half of the left horn. The Leg-ater's suit appears originally crafted, in contrast to other Lil Ceasar's Brand armor which consists of repurposed Pre-Fall sports equipment."
	icon_state = "legion_legate"

//FOR BOTH SUITS AND ARMORS BELONGING TO FACTIONS
//PLEASE PUT CUSTOM ARMORS IN f13armor.dm. All power armors are found in f13armor.dm.



/obj/item/clothing/suit/armor/exile
	name = "base faction exile armor"
	desc = "this is for testing."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'

/obj/item/clothing/suit/armor/exile/ncrexile
	name = "modified NCR armor"
	desc = "A modified detoriated armor kit consisting of NCR gear and scrap metal."
	icon_state = "ncrexile"
	inhand_icon_state = "ncrexile"

/obj/item/clothing/suit/armor/exile/legexile
	name = "modified larper armor"
	desc = "A modified detoriated armor kit consisting of larping gear and scrap metal. You've never been able to get the smell of fresh breadsticks out of it."
	icon_state = "legexile"
	inhand_icon_state = "legexile"

//////////
//LEGION//
//////////

/obj/item/clothing/suit/armor/legion
	name = "legion armor template"
	desc = "should not exist. Bugreport."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "legrecruit"
	inhand_icon_state = "legarmor"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 2) // Because shit armor

/datum/component/storage/concrete/pockets/tiny/legion
	max_items = 3

/obj/item/clothing/suit/armor/legion/recruit
	name = "Lil Ceasar's Larpers recruit armor"
	desc = "Well, it's better than nothing.  Except it's weirdly sticky."
	icon_state = "legion_recruit"
	inhand_icon_state = "legion_recruit"

/obj/item/clothing/suit/armor/legion/recruit/decan
	name = "Lil Ceasar's recruitn't armor"
	desc = "Recruit chefs receive slightly better protection than regular recruits. Slightly."

/obj/item/clothing/suit/armor/legion/prime
	name = "amazon prime armor"
	desc = "Oh my god Becky, look at all these deals!"
	icon_state = "legion_prime"
	inhand_icon_state = "legion_prime"

/obj/item/clothing/suit/armor/legion/prime/decan
	name = "Larper amazon prime decanus armor"
	desc = "A baseball uniform for the unhinged."

/obj/item/clothing/suit/armor/legion/orator
	name = "big talkers skirt suit"
	desc = "Damn bitch, you go hard."
	icon_state = "legion-orator"
	inhand_icon_state = "legion-orator"

/obj/item/clothing/suit/armor/legion/prime/slavemaster
	name = "middle management armor"
	desc = "Issued to Lil Ceasars worker-watchers to keep them from getting their dainty toes burnt or something."
	icon_state = "legion-master"
	inhand_icon_state = "legion-master"

/obj/item/clothing/suit/armor/legion/vet
	name = "pizza wars veteran armor"
	desc = "When the fields of sauce ran red this big cheese stood alone."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "legion_veteran"
	inhand_icon_state = "legion_veteran"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 4) // Slightly better armor

/obj/item/clothing/suit/armor/legion/heavy
	name = "heavy pizza wars armor"
	desc = "A veterans armor reinforced with a patched bulletproof vest, the wearer has the markings signifying their claiming of ten anuses.  Anusii?"
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "legion_heavy"
	inhand_icon_state = "legion_heavy"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 5)

/obj/item/clothing/suit/armor/legion/vet/explorer
	name = "lil ceasar's scunt armor"
	desc = "Armor based on layered strips of laminated linen and leather, the technique giving it surprising resilience for low weight. As well as gifting the wearer with the ability to die to turrets like crazy."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "legion_explorer"
	inhand_icon_state = "legion_explorer"

/obj/item/clothing/suit/armor/legion/vet/vexil
	name = "lil ceasar's vexillarius armor"
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	desc = " Worn by Vexillarius (You're pretty sure you've seen a guy named this in a comic book once), this armor has been reinforced with circular metal plates that look a bit like pizzas on the chest and a back mounted pole for the flag of the baby cow, making the wearer easy to see at a distance."
	icon_state = "legion_vex"
	inhand_icon_state = "legion_vex"

/obj/item/clothing/suit/armor/legion/venator
	name = "pizza wars explorer's armor"
	desc = "Explorer's armor reinforced with metal plates (they're clearly stylized pepperonis) and chainmail."
	icon_state = "legion-venator"
	inhand_icon_state = "legion-venator"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 5)

/obj/item/clothing/suit/armor/legion/centurion //good all around
	name = "pizza centurion armor"
	desc = "Every Centurion is issued some of the best armor available in the Pizza Legion, and adds better pieces from slain opponents over time."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "legion_centurion"
	inhand_icon_state = "legion_centurion"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 10) // Rest in pieces

/obj/item/clothing/suit/armor/legion/palacent //laser resist spec
	name = "paladin-slayer pizza centurion armor"
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi' // Inconsistent naming, clean all of the sprites and code up sometime
	desc = "A Pizza Centurion able to defeat a Brotherhood Paladin gets the honorific title 'Paladin-Slayer', and adds bits of the looted armor to his own. The biggest downside is that he often gets called a dweeb for if he dares to demand that title."
	icon_state = "legion_palacent"
	inhand_icon_state = "legion_palacent"


/obj/item/clothing/suit/armor/legion/rangercent //speed and bullet resist, sacrifices all else
	name = "wanger-huntew centuwion awmow"
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	desc = "Centurions who have led many patrols and ambushes have a distinct look from the many looted pieces of the armor they pulled off femboys out west, and are often experienced in 'skirmishing'."
	icon_state = "legion_rangercent"
	inhand_icon_state = "legion_rangercent"

/obj/item/clothing/suit/armor/legion/legate
	name = "leg-ater armor"
	desc = " Made by the most skilled blacksmiths in the kitchen, the bronzed steel of this rare armor offers good protection despite smelling like old anchovies, and the scars on its metal proves it has seen use on the field. Probably."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "legion_legate"
	inhand_icon_state = "legion_legate"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 15) // Wouldn't it be hilarious if we just tore apart Legate's armor?

/obj/item/clothing/suit/armor/medium/combat/legion
	name = "pizza combat armor"
	desc = "Pre-Fall military style armor, patched and missing some parts. Modified and repainted to declare the user a fighter for Lil Caesar's Pizza Larpers Legion."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "legion_combat"
	inhand_icon_state = "legion_combat"

/obj/item/clothing/suit/armor/medium/combat/mk2/legion
	name = "reinforced pizza combat armor"
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	desc = "Pre-Fall military style armor, a full set with bracers and reinforcements. Modified and repainted to declare the user a fighter for Lil Caesar's Pizza Larpers Legion."
	icon_state = "legion_combat2"
	inhand_icon_state = "legion_combat2"

/obj/item/clothing/suit/armor/legion/vet/explorercanada
	name = "custom explorer armor"
	desc = "Armor based on layered strips of laminated linen and leather, the technique giving it surprising resilience for low weight. This one has been custom made and smells like maple syrup."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "legion-explorercustom"
	inhand_icon_state = "legion-explorercustom"

/obj/item/clothing/suit/armor/ncrarmor
	name = "NCR patrol vest"
	desc = "A standard issue NCR Infantry vest."
	icon_state = "ncr_infantry_vest"
	inhand_icon_state = "ncr_infantry_vest"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 2)

/datum/component/storage/concrete/pockets/bulletbelt/ncr
	max_items = 2

/obj/item/clothing/suit/armor/ncrarmor/mantle
	name = "NCR mantle vest"
	desc = "A standard issue NCR Infantry vest with a mantle on the shoulder."
	icon_state = "ncr_standard_mantle"
	inhand_icon_state = "ncr_standard_mantle"

/obj/item/clothing/suit/armor/ncrarmor/reserve
	name = "reserve NCR patrol vest"
	desc = "A standard issue NCR Infantry vest."
	icon_state = "ncr_infantry_vest"
	inhand_icon_state = "ncr_infantry_vest"

/obj/item/clothing/suit/armor/ncrarmor/conscript
	name = "NCR flak vest"
	desc = "A standard issue NCR Infantry vest reinforced with a thin kelvar sheet."
	icon_state = "ncr_kelvar_vest"
	inhand_icon_state = "ncr_kelvar_vest"

/obj/item/clothing/suit/armor/ncrarmor/reinforced
	name = "NCR reinforced patrol vest"
	desc = "A standard issue NCR Infantry vest reinforced with a groinpad."
	icon_state = "ncr_reinforced_vest"
	inhand_icon_state = "ncr_reinforced_vest"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 3)

/obj/item/clothing/suit/armor/ncrarmor/reinforced/engineer
	name = "NCR blast-padded reinforced patrol vest"
	desc = "A standard issue NCR Engineer vest reinforced with a groinpad."

/obj/item/clothing/suit/armor/ncrarmor/mantle/reinforced
	name = "NCR reinforced mantle vest"
	desc = "A standard issue NCR Infantry vest reinforced with a groinpad and a mantle."
	icon_state = "ncr_reinforced_mantle"

/obj/item/clothing/suit/armor/ncrarmor/mantle/reinforced/trenchraider
	name = "NCR reinforced trench mantle vest"
	desc = "A standard issue NCR Infantry vest with a really long name and extra melee plating."

/obj/item/clothing/suit/armor/ncrarmor/labcoat
	name = "NCR medical labcoat"
	desc = "An armored labcoat typically issued to NCR Medical Officers. It's a standard white labcoat with the Medical Officer's name stitched into the breast and a two headed bear sewn into the shoulder."
	icon_state = "ncr_labcoat"
	inhand_icon_state = "ncr_labcoat"

/obj/item/clothing/suit/armor/ncrarmor/lieutenant
	name = "NCR officer vest"
	desc = "A reinforced set of NCR mantle armour, with added padding on the groin, neck and shoulders. Intended for use by the officer class."
	icon_state = "ncr_lt_armour"
	inhand_icon_state = "ncr_lt_armour"

/obj/item/clothing/suit/armor/ncrarmor/captain/ncr_officer_coat
	name = "NCR officer vest"
	desc = "A special issue NCR officer's armour with an added thick overcoat for protection from the elements."
	icon_state = "ncr_officer_coat"
	inhand_icon_state = "ncr_officer_coat"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 5)

/obj/item/clothing/suit/armor/ncrarmor/captain
	name = "NCR reinforced officer vest"
	desc = "A heavily reinforced set of NCR mantle armour, with large ceramic plating fitted to cover the torso and back, with additional plating on the shoulders and arms. Intended for use by high ranking officers."
	icon_state = "ncr_captain_armour"
	inhand_icon_state = "ncr_captain_armour"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 10) // Le captain

/obj/item/clothing/suit/armor/ncrarmor/ncr_dressjack
	name = "NCR dress jacket"
	desc = "A brown dress uniform jacket intended for enlisted NCRA personnel."
	icon_state = "ncr_dressjack"
	inhand_icon_state = "ncr_dressjack"

/obj/item/clothing/suit/armor/ncrarmor/ncr_codressjack
	name = "NCR dress jacket"
	desc = "A brown dress uniform jacket for commissioned NCRA personnel."
	icon_state = "ncr_codressjack"
	inhand_icon_state = "ncr_codressjack"


//NCR Ranger
/obj/item/clothing/suit/toggle/armor/rangerrecon
	name = "ranger recon duster"
	desc = "A thicker than average duster worn by NCR recon rangers out in the field. It's not heavily armored by any means, but is easy to move around in and provides excellent protection from the harsh desert environment."
	icon_state = "duster_recon"
	inhand_icon_state = "duster_recon"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 4)

/obj/item/clothing/suit/armor/trailranger
	name = "ranger vest"
	desc = "A quaint little jacket and scarf worn by NCR trail rangers."
	icon_state = "cowboyrang"
	inhand_icon_state = "cowboyrang"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 4)

/obj/item/clothing/suit/armor/modif_r_vest
	name = "subdued ranger vest"
	desc = "A quaint little jacket and scarf worn by NCR trail rangers. This one has the leather bleached and the scarf dyed black."
	icon_state = "modif_r_vest"
	inhand_icon_state = "modif_r_vest"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 4)


/obj/item/clothing/suit/armor/rangercombat
	name = "veteran ranger combat armor"
	desc = "The NCR veteran ranger combat armor, or black armor consists of a Pre-Fall L.A.P.D. riot suit under a duster with rodeo jeans. Considered one of the most prestigious suits of armor to earn and wear while in service of the NCR Rangers."
	icon_state = "ranger"
	inhand_icon_state = "ranger"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 8)

//Great Khan
/obj/item/clothing/suit/armor/khan_jacket
	name = "khan armored jacket"
	desc = "The symbol of the greatest pushers."
	icon_state = "khan_jacket"
	inhand_icon_state = "khan_jacket"

//All of the armor below is mostly unused

/obj/item/clothing/suit/armor/centcom
	name = "\improper CentCom armor"
	desc = "A suit that protects against some damage."
	icon_state = "centcom"
	inhand_icon_state = "centcom"
	w_class = WEIGHT_CLASS_BULKY
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	clothing_flags = THICKMATERIAL
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT

//*shrug
/obj/item/clothing/suit/armor/heavy/old
	name = "heavy armor"
	desc = "A heavily armored suit that protects against moderate damage."
	icon_state = "heavy"
	inhand_icon_state = "swat_suit"
	w_class = WEIGHT_CLASS_BULKY
	gas_transfer_coefficient = 0.9
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 3
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/armor/tdome
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	clothing_flags = THICKMATERIAL
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/suit/armor/tdome/red
	name = "thunderdome suit"
	desc = "Reddish armor."
	icon_state = "tdred"
	inhand_icon_state = "tdred"

/obj/item/clothing/suit/armor/tdome/green
	name = "thunderdome suit"
	desc = "Pukish armor."	//classy.
	icon_state = "tdgreen"
	inhand_icon_state = "tdgreen"


/obj/item/clothing/suit/armor/heavy/riot/knight
	name = "plate armour"
	desc = "A classic suit of plate armour, highly effective at stopping melee attacks."
	icon_state = "knight_green"
	inhand_icon_state = "knight_green"

/obj/item/clothing/suit/armor/heavy/riot/knight/yellow
	icon_state = "knight_yellow"
	inhand_icon_state = "knight_yellow"

/obj/item/clothing/suit/armor/heavy/riot/knight/blue
	icon_state = "knight_blue"
	inhand_icon_state = "knight_blue"

/obj/item/clothing/suit/armor/heavy/riot/knight/red
	icon_state = "knight_red"
	inhand_icon_state = "knight_red"

/obj/item/clothing/suit/armor/heavy/riot/knight/tabard
	name = "tabard plate armor"
	desc = "A set of plate armor with tabard for the user's high-visibility during combat."
	icon_state = "knight_tabard"
	inhand_icon_state = "knight_tabard"

/obj/item/clothing/suit/armor/heavy/riot/knight/greyscale
	name = "knight armour"
	desc = "A classic suit of armour, able to be made from many different materials."
	icon_state = "knight_greyscale"
	inhand_icon_state = "knight_greyscale"
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS //Can change color and add prefix

//Custom/Patreon/Donor - A lot of this likely needs putting in the graveyard
/obj/item/clothing/suit/armor/power_armor/midwest/reinforced // PATREON SUPPORTER CUSTOM GEAR, DO NOT USE.
	name = "hardened midwestern power armor" // PATREON SUPPORTER CUSTOM GEAR, DO NOT USE.
	icon_state = "midwestpa" // PATREON SUPPORTER CUSTOM GEAR, DO NOT USE.
	inhand_icon_state = "midwestpa" // PATREON SUPPORTER CUSTOM GEAR, DO NOT USE.
	desc = "This set of power armor once belonged to the Midwestern branch of the Brotherhood of Steel, and now resides here. This particular one has gone through a chemical hardening process, increasing its armor capabilities." // PATREON SUPPORTER CUSTOM GEAR, DO NOT USE.

/obj/item/clothing/suit/armor/exile/cust0m
	name = "Lorica Iudicis"
	desc = "A set of well maintained though still quite clearly worn armor consisting of a metal vest, a Centurion's shoulder pad, a pair of Centurion's arm guards and an incredibly large, perhaps even over-sized fur cloak. Upon basic examination, one can see that every piece of metal bar the buckles on the leather straps and whatever scratches and blemishes are yet to be retouched is masterfully decorated with silver, in complete contrast to the blackness of the cloak. Though only upon closer examination can the intricacies of the armor set be observed. The most obvious piece is the metal vest which has clearly been engraved, mostly decorationally besides the name 'Iudex Flammae' near the top. Though the engravings provide no tactical advantage whatsoever, the sharp geometric shapes accompanied by smooth, tastefully placed curves would catch the eye of even the most skeptical engraving enjoyer. As for the shoulder pad and arm guards, they hold the same engravings, and though they are recognizable as salvage, they still look incredibly beautiful yet simultaneously sturdy. Not much of the metal seems to exist on the back though that is only due to the fact that the incredibly thick, durable and flexible bear pelt that covers it would definitely provide ample protection. The pelt itself is absolutely covered in thick, almost jet black fur. One can tell from touch that the skin underneath is about as sturdy as skin gets. The pelt hangs across the wearer's back, held up by the neck and shoulders. This armor was competently made, and it shows."
	icon_state = "exilecust0m"
	inhand_icon_state = "exilecust0m"
	var/adjusted = FALSE

/obj/item/clothing/suit/armor/exile/cust0m/verb/armor_adjust()
	set name = "Adjust Armor"
	set category = null
	set src in usr

	if(!adjusted)
		adjusted = TRUE
		icon_state = "exilecust0m_d"
	else
		adjusted = FALSE
		icon_state = "exilecust0m"

	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		H.update_inv_w_uniform()
		H.update_body()

/obj/item/clothing/suit/armor/harpercoat
	name = "outlaw coat"
	desc = "An ugly looking combat duster"
	icon_state = "harperduster"

/obj/item/clothing/suit/armor/medium/raider/reptiliatenebris
	name = "Reptilia Tenebris"
	desc = "An old military-grade Pre-Fall combat armor under a weathered duster. It appears to be fitted with metal plates to replace the crumbling ceramic. The color of this duster has been washed out time and time again, giving it a more faded look as if time gripped it heavily. Along with that, the duster has been dyed a deep shade of grey, and the body armor a darker shade of green."
	icon_state = "reptiliatenebris"
	inhand_icon_state = "reptiliatenebris"


/obj/item/clothing/suit/toggle/armor/rangercustomdark
	name = "tattered recon duster"
	desc = "A thicker than average duster worn by rangers out in the field. This one has been dyed black and appears to be a little more heavily armoured."
	icon_state = "duster_recon_custom"
	inhand_icon_state = "duster_recon_custom"

/obj/item/clothing/suit/armor/legion/palacent/custom_excess
	name = "Champion of Kanab's Armor"
	desc = "The armor of the Champion and Conqueror of the city in Utah named Kanab. The armor is made up of pieces of Power Armor and Pre-Fall Riot Gear, the shin guards are spraypainted a dark crimson and the Power Armour pauldron has a red trim. The symbol of a Pheonix is carefully engraved and painted upon the chest piece... I wonder what it means.."
	icon_state = "palacent_excess"
	inhand_icon_state = "palacent_excess"

/obj/item/clothing/suit/donor/soldier
	name = "Soldier's Greatcoat"
	desc = "A resistant, tan greatcoat, typically worn by Pre-Fall Generals."
	icon_state = "soldier"
	inhand_icon_state = "soldier"

/obj/item/clothing/suit/armor/rangercombat/foxcustom
	name = "sniper riot gear"
	desc = "A customized and well-worn suit of riot gear with parts of the suit reinforced with leather armor and slain Centurion armor pieces by the wearer. A sniper's veil is wrapped around the neck."
	icon_state = "foxranger"
	inhand_icon_state = "foxranger"

/obj/item/clothing/suit/armor/rangercombat/degancustom
	name = "sniper riot gear"
	desc = "A customized and well-worn suit of riot gear with parts of the suit reinforced with leather armor and slain Centurion armor pieces by the wearer. A sniper's veil is wrapped around the neck."
	icon_state = "elite_riot"
	inhand_icon_state = "elite_riot"

/obj/item/clothing/suit/armor/rangercombat/rigscustom
	name = "11th armored calvary armor"
	desc = "A suit of special military grade riot control gear and a duster, worn by 11th Armored Calvary Regiment members in The Divide before the war. Yellow markings are painted on the shoulderpads and forearm guards."
	icon_state = "rigscustom_suit"
	inhand_icon_state = "rigscustom_suit"

/obj/item/clothing/suit/armor/rangercombat/pricecustom
	name = "spider riot gear"
	desc = "A customised and faded suit of riot gear, reminiscient of that found near Hopeville in the Divide, with a pair of wrist mounted ammo pouches for easy access to spare munitions with a pair of stripes down the back made from a fire-proof material."
	icon_state = "price_ranger"
	inhand_icon_state = "price_ranger"

/obj/item/clothing/suit/toggle/armor/cloakranger //Reskinned trail ranger gear
	name = "ranger poncho"
	desc = "A durable muslin poncho. Tough enough to bear the elements and serve as handy blanket."
	icon_state = "ranger_cloak"
	inhand_icon_state = "ranger_cloak"



//THE GRAVEYARD
//UNUSED or LEGACY - RETAINED IN CASE DESIRED FOR ADMIN SPAWN OR REIMPLEMENATION. MAY NOT BE EVERYTHING THAT'S UNUSED. TEST BEFORE USING
//IF PUT BACK INTO USE, PLEASE FILE IT BACK SOMEWHERE ABOVE

/obj/item/clothing/suit/armor/warriors
	name = "warriors armored vest"
	desc = "The symbol of the greatest gangers."
	icon_state = "warriors"
	inhand_icon_state = "warriors"

/obj/item/clothing/suit/armor/atomzealot
	name = "zealot armor"
	desc = "The armor of those true to the Division."
	icon_state = "atomzealot"
	inhand_icon_state = "atomzealot"

/obj/item/clothing/suit/armor/atomwitch
	name = "atomic seer robes"
	desc = "The robes worn by female seers of the Division."
	icon_state = "atomwitch"
	inhand_icon_state = "atomwitch"

/obj/item/clothing/suit/armor/harbingermantle
	name = "Harbinger's Mantle"
	desc = "An eerie, silken cloth that seems to be dripping with a thick mist. It is in truth a high-tech stealth device that allows for psionic amplification. The capacitors and manipulators in it utilise quantum technology and are highly volatile."
	icon_state = "scloak"
	inhand_icon_state = "scloak"

/obj/item/clothing/suit/armor/medium/combat/vetranger
	name = "veteran ranger combat armor"
	desc = "The NCR veteran ranger combat armor, or black armor consists of a Pre-Fall L.A.P.D. riot suit under a duster with rodeo jeans. Considered one of the most prestigious suits of armor to earn and wear while in service of the NCR Rangers."
	icon_state = "ranger"
	inhand_icon_state = "ranger"

/////////
// NCR //
/////////

/obj/item/clothing/suit/armor/medium/vest/ncr
	name = "NCR armor vest"
	desc = "A standard issue NCR Infantry armor vest."
	icon_state = "ncr_infantry_vest"
	inhand_icon_state = "ncr_infantry_vest"

/obj/item/clothing/suit/armor/medium/vest/ncr/mant
	name = "NCR mantle vest"
	desc = "A standard issue NCR Infantry vest with a mantle on the shoulder."
	icon_state = "ncr_standard_mantle"
	inhand_icon_state = "ncr_standard_mantle"

/obj/item/clothing/suit/armor/medium/vest/ncr/reinf
	name = "NCR reinforced armor vest"
	desc = "A standard issue NCR Infantry vest reinforced with a groinpad."
	icon_state = "ncr_reinforced_vest"
	inhand_icon_state = "ncr_reinforced_vest"

/obj/item/clothing/suit/armor/medium/vest/ncr/mantreinf
	name = "NCR reinforced mantle vest"
	desc = "A standard issue NCR Infantry vest reinforced with a groinpad and a mantle."
	icon_state = "ncr_reinforced_mantle"
	inhand_icon_state = "ncr_reinforced_mantle"

/obj/item/clothing/suit/armor/medium/vest/ncr/officer
	name = "NCR officer armor vest"
	desc = "A reinforced set of NCR mantle armour, with added padding on the groin, neck and shoulders. Intended for use by the officer class."
	icon_state = "ncr_lt_armour"
	inhand_icon_state = "ncr_lt_armour"



//// LIGHT LEGION ARMOR //// unused =3
/obj/item/clothing/suit/armor/light/tribal/legion


/obj/item/clothing/suit/armor/light/tribal/legion/recruit
	name = "lil ceasar's recruit armor"
	desc = "Legion recruit armor is a common light armor, clearly inspired by gear worn by old world football players and baseball catchers, much of it restored ancient actual sports equipment, other newly made from mostly leather, tanned and boiled in oil."
	icon_state = "legion_recruit"

/obj/item/clothing/suit/armor/light/tribal/legion/prime
	name = "amazon prime armor"
	desc = "It's some amazon prime armor, the warrior has been granted some additional protective pieces to add to his suit. At a cost to their credit rating."
	icon_state = "legion_prime"

/obj/item/clothing/suit/armor/light/tribal/legion/recruit/slavemaster
	name = "middle management armor"
	desc = "Issued to cruel Lil Ceasar task masters to keep them cool during long hours of watching the wagies work in the sun."
	icon_state = "legion_master"

/obj/item/clothing/suit/armor/light/tribal/legion/explorer
	name = "pizza wars explorer armor"
	desc = "Light armor with layered strips of laminated linen and leather and worn with a large pouch for storing your binoculars, or salami."
	icon_state = "legion_explorer"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/binocular

////////////
// LEGION //
////////////

/obj/item/clothing/suit/armor/medium/tribal/legion/legexile
	name = "modified Legion armor"
	desc = "A modified detoriated armor kit consisting of Legion gear and scrap metal."
	icon_state = "legexile"
	inhand_icon_state = "legexile"

/obj/item/clothing/suit/armor/medium/tribal/legion/forgemaster
	name = "Ovenkeepers Armor"
	desc = "The only true protection from the heat of the pizza ovens is your faith in Lil' Ceasar's love."
	icon_state = "opifex_apron"
	inhand_icon_state = "opifex_apron"
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/medium/tribal/legion/vet
	name = "lil ceasar's veteran armor"
	desc = "Armor worn by veteran delivery drivers who have proven their combat prowess in many battles, its hardened leather is sturdier than that of previous ranks."
	icon_state = "legion_veteran"

/obj/item/clothing/suit/armor/medium/tribal/legion/vexil
	name = "lil ceasar's vexillarius armor"
	desc = "The armor appears to be based off of a suit of Legion veteran armor, with the addition of circular metal plates attached to the torso, as well as a banner displaying the flag of the Legion worn on the back."
	icon_state = "legion_vex"

/obj/item/clothing/suit/armor/medium/tribal/legion/combat
	name = "lil ceasar's combat armor"
	desc = "An old military grade pre war combat armor and, repainted to the colour scheme of Lil Caesar's Pizza Legion."
	icon_state = "legion_combat"
	inhand_icon_state = "legion_combat"

/// Brotherhood of steel -- unused
/obj/item/clothing/suit/armor/medium/combat/bos
	name = "initiate armor"
	desc = "An old military grade pre war combat armor, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_armor"
	inhand_icon_state = "brotherhood_armor"

/obj/item/clothing/suit/armor/medium/combat/bos/cylphie
	name = "Singed Brotherhood Armor"
	desc = "A suit of scrap brotherhood combat armor with burn marks across every piece. There are broken holotags welded across the numerous plates, and a scratched to shit dogtag with the name 'Blue Blaze' cut into it."
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "cylphieexilearmor"
	inhand_icon_state = "cylphieexilearmor"

/obj/item/clothing/suit/armor/medium/combat/mk2/bos
	name = "reinforced initiate armor"
	desc = "A reinforced set of bracers, greaves, and torso plating of prefall design This one is kitted with additional plates and, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_armor_mk2"
	inhand_icon_state = "brotherhood_armor_mk2"

/obj/item/clothing/suit/armor/medium/combat/mk2/knight
	name = "brotherhood armor"
	desc = "A combat armor set made by the Brotherhood of Steel, standard issue for all Knights. It bears a red stripe."
	icon_state = "brotherhood_armor_knight"
	inhand_icon_state = "brotherhood_armor_knight"

/obj/item/clothing/suit/armor/medium/combat/mk2/senknight
	name = "brotherhood senior knight armor"
	desc = "A combat armor set made by the Brotherhood of Steel, standard issue for all Senior Knight. It bears a silver stripe."
	icon_state = "brotherhood_armor_senior"
	inhand_icon_state = "brotherhood_armor_senior"

/obj/item/clothing/suit/armor/medium/combat/mk2/headknight
	name = "brotherhood knight-captain armor"
	desc = "A combat armor set made by the Brotherhood of Steel, standard issue for all Knight-Captains. It bears golden embroidery."
	icon_state = "brotherhood_armor_captain"
	inhand_icon_state = "brotherhood_armor_captain"

///////////////////////
// GREAT KHANS ARMOR //
///////////////////////

//Basic Jacket
/obj/item/clothing/suit/toggle/labcoat/khan_jacket
	name = "Great Khan jacket"
	desc = "A black leather jacket. <br>There is an illustration on the back - an aggressive, red-eyed skull wearing a fur hat with horns.<br>The skull has a mongoloid moustache - it's obviously a Great Khans emblem."
	icon = 'icons/fallout/clothing/khans.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/khaans.dmi'
	icon_state = "khan_jacket"
	inhand_icon_state = "khan_jacket"

//Armored jacket
/obj/item/clothing/suit/toggle/labcoat/khan_jacket/armored
	name = "Great Khan armored jacket"
	desc = "A black leather jacket with ballistic plates and a big Great Khan logo on the back. Some prefer to wear a leather vest (alt-click)."
	icon_state = "khan_jacket_armored"
	inhand_icon_state = "khan_jacket_armored"

//Battlecoat
/obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat
	name = "Leather battle coat"
	desc = "Heavy leather coat lined with a patchwork of metal plates on the inside."
	icon_state = "khan_heavy"
	inhand_icon_state = "khan_heavy"

//Battlecoat/Goji
/obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat/goji
	name = "Golden Geckoskin jacket"
	desc = "Heavy Geckoskin jacket lined with a bulletproof lining on the inside. On the back the symbol of the Great Khans is displayed proudly."
	icon_state = "GojiSuit"
	inhand_icon_state = "GojiSuit"

//Special Biosuit





//TRIBALS


//ARMOR, AND ALL PATREON/CUSTOM/DONOR STUFF (EVEN IF SUIT AND NOT ARMOR) TO GO INTO f13armor.dm
/*FOR REFERENCE
/obj/item/clothing/suit
	icon = 'icons/obj/clothing/suits.dmi'
	name = "suit"
	block_priority = BLOCK_PRIORITY_WEAR_SUIT
	var/fire_resist = T0C+100
	allowed = null
	slot_flags = INV_SLOTBIT_OCLOTHING
	body_parts_covered = CHEST|GROIN|LEGS|ARMS //I don't care if some armors only visibly covers the chest, they're going to offer protection to limbs too because game design.
	var/blood_overlay_type = "suit"
	var/togglename = null
	var/suittoggled = FALSE
	limb_integrity = 0 // disabled for most exo-suits
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.f13_coat_allowed

/obj/item/clothing/suit/worn_overlays(isinhands = FALSE, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damaged[blood_overlay_type]")
		if(blood_DNA)
			var/file2use = (style_flags & STYLE_ALL_TAURIC) ? 'modular_citadel/icons/mob/64x32_effects.dmi' : 'icons/effects/blood.dmi'
			. += mutable_appearance(file2use, "[blood_overlay_type]blood", color = blood_DNA_to_color())
		var/mob/living/carbon/human/M = loc
		if(ishuman(M) && M.w_uniform)
			var/obj/item/clothing/under/U = M.w_uniform
			if(istype(U) && U.attached_accessory)
				var/obj/item/clothing/accessory/A = U.attached_accessory
				if(A.above_suit)
					. += U.accessory_overlay

/obj/item/clothing/suit/update_clothes_damaged_state()
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_wear_suit()
*/









/*
Just leaving this here for quick copy-pasting, for future contributors.
	icon = 'modular_sunset/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_sunset/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_sunset/icons/mob/clothing/suit_digi.dmi'
	mutantrace_variation = STYLE_DIGITIGRADE
	!!If you don't have digi-adapted sprites use `mutantrace_variation = NONE` instead. Should snap legs sprites to planti when related clothing is worn.
	(unless suit doesn't cover legs in `body_parts_covered` var)
*/


// In this document: Light armor





/////////
// NCR //
/////////



///////////////
// WAYFARERS //
///////////////






///////////
// MISC. //
///////////

// Recipe winter coat + armor kit
/obj/item/clothing/suit/toggle/armored/winterkit
	name = "armored winter coat"
	desc = "Fur lined coat with armor kit bits added to it."
	icon_state = "winter_kit"
	inhand_icon_state = "winter_kit"

/*
// Heavy
/obj/item/clothing/suit/armor/atomzealot
	name = "zealot armor"
	desc = "Praise be to Atom."
	icon_state = "atomzealot"
	inhand_icon_state = "atomzealot"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 30, "energy" = 45, "bomb" = 55, "bio" = 65, "rad" = 100, "fire" = 60, "acid" = 20)

/obj/item/clothing/suit/armor/atomwitch
	name = "atomic seer robes"
	desc = "Atom be praised."
	icon_state = "atomwitch"
	inhand_icon_state = "atomwitch"
	armor = list("melee" = 5, "bullet" = 10, "laser" = 30, "energy" = 45, "bomb" = 55, "bio" = 65, "rad" = 100, "fire" = 60, "acid" = 20)
*/

// In this document: Medium armor


///////////////
// WASTELAND //
///////////////


//THE GRAVEYARD
//IF PUT BACK INTO USE, PLEASE FILE IT BACK SOMEWHERE ABOVE

/*

/obj/item/clothing/suit/armor/medium/lawcoat/mayor
	name = "mayor trenchcoat"
	desc = "A symbol of the mayor's authority (or lack thereof)."
	armor = list("melee" = 40, "bullet" = 35, "laser" = 30, "energy" = 40, "bomb" = 30, "bio" = 40, "rad" = 40, "fire" = 40, "acid" = 0)

//Enclave/Remnants

/obj/item/clothing/suit/armor/medium/combat/enclave
	name = "enclave combat armor"
	desc = "A set of matte black advanced Pre-Fall combat armor."
	icon_state = "enclave_new"
	inhand_icon_state = "enclave_new"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 20, "bomb" = 30, "bio" = 10, "rad" = 10, "fire" = 20, "acid" = 10)

/obj/item/clothing/suit/armor/medium/vest/enclave
	name = "armored vest"
	desc = "Efficient prefall design issued to Enclave personell."
	icon_state = "armor_enclave_peacekeeper"
	inhand_icon_state = "armor_enclave_peacekeeper"
	armor = list("melee" = 35, "bullet" = 50, "laser" = 30, "energy" = 30, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)

/obj/item/clothing/suit/armor/enclave/officercoat
	name = "armored coat"
	desc = "Premium prefall armor fitted into a coat for Enclave officers."
	icon_state = "armor_enclave_officer"
	inhand_icon_state = "armor_enclave_officer"
	armor = list("melee" = 60, "bullet" = 45, "energy" = 40, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)
*/

// In this document: Heavy armor (not powerarmor)

/* /obj/item/clothing/suit/armor/fluff/metalarmor/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/suit/armor/fluff/metalarmor/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..() */


/obj/item/clothing/suit/armor/medium/duster/khancoat
	name = "khan battlecoat"
	desc = "Affluent pushers can affort fancy coats with a lot of metal and ceramic plates stuffed inside."
	icon_state = "khanbattle"
	inhand_icon_state = "khanbattle"

// Outlaw
/obj/item/clothing/suit/toggle/armored/khanlight
	name = "great khan jacket"
	desc = "With small lead plate inserts giving some defense, the jackets and vests popular with the Great Khans show off their emblem on the back."
	icon_state = "khanjacket"
	inhand_icon_state = "khanjacket"

/obj/item/clothing/suit/armor/light/tribal/ncr
	name = "tribalized NCR armor vest"
	desc = "A suit of worn dated NCR armor, it seems to have seen better days."
	icon_state = "ncr_tribal_armor"
	inhand_icon_state = "ncr_tribal_armor"

/obj/item/clothing/suit/armor/light/rangerrig
	name = "chest gear harness"
	desc = "A handmade tactical rig made of black cloth, attached to a dusty desert-colored belt. A flask and two ammo pouches hang from the belt. Very cool to move about in."
	icon_state = "r_gear_rig"
	inhand_icon_state = "r_gear_rig"

/obj/item/clothing/suit/armor/light/trailranger
	name = "ranger vest"
	desc = "A quaint little jacket and scarf worn by NCR trail rangers."
	icon_state = "cowboyrang"
	inhand_icon_state = "cowboyrang"

/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/ncr
	name = "salvaged NCR power armor"
	desc = "It's a set of T-45b power armor with a air conditioning module installed, sadly it lacks servomotors to enhance the users strength. The paintjob and the two headed bear painted onto the chestplate shows it belongs to the NCR."
	icon_state = "ncr_salvaged"
	inhand_icon_state = "ncr_salvaged"

/obj/item/clothing/suit/armor/power_armor/t45d/sierra
	name = "Scorched Sierra power armor"
	desc = "A captured set of T-45d power armor put into use by the NCR, it's been heavily modified and decorated with the head of a bear and intricate gold trimming. A two headed bear is scorched into the breastplate."
	icon_state = "sierra"
	inhand_icon_state = "sierra"

// Recipe Firesuit + metal chestplate + 50 welding fuel + 1 HQ + 1 plasteel
/obj/item/clothing/suit/armor/heavy/metal/sulphite/old
	name = "sulphite raider suit"
	desc = "There are still some old asbestos fireman suits laying around from before the war. How about adding a ton of metal, plasteel and a combustion engine to one? The resulting armor is surprisingly effective at dissipating energy."
	icon_state = "sulphite"
	inhand_icon_state = "sulphite"

/obj/item/clothing/suit/armor/heavy/tribal/metal/old
	name = "iron raider suit"
	desc = "More rust than metal, with gaping holes in it, this armor looks like a pile of junk. Under the rust some quality steel still remains however."
	icon_state = "raider_metal"
	inhand_icon_state = "raider_metal"

// Midwest
/obj/item/clothing/suit/armor/heavy/salvaged_pa/midwest
	name = "Salvaged midwestern T-51b power armor"
	desc = "This set of power armor belongs to the Midwestern branch of the Brotherhood of Steel. Its servomotors and valauble components have been stripped out of it."
	icon_state = "midwestgrey_pa_salvaged"
	inhand_icon_state = "midwestgrey_pa_salvaged"

// Hardened Midwest
/obj/item/clothing/suit/armor/heavy/salvaged_pa/midwest/hardened
	name = "Salvaged hardened midwestern T-51b power armor"
	desc = "This set of power armor belongs to the Midwestern branch of the Brotherhood of Steel. This particular one has gone through a chemical hardening process, increasing its armor capabilities. Its servomotors and valuable components have been stripped out of it."
	icon_state = "midwestpa_salvaged"
	inhand_icon_state = "midwestpa_salvaged"

// T-60A
/obj/item/clothing/suit/armor/heavy/salvaged_pa/t60
	name = "salvaged T-60a power armor"
	desc = "T-60a power armor with servomotors and all valuable components stripped out of it."
	icon_state = "t60_salvaged"
	inhand_icon_state = "t60_salvaged"

/obj/item/clothing/suit/armor/power_armor/midwest
	name = "Midwestern T-51b power armor"
	desc = "This set of power armor belongs to the Midwestern branch of the Brotherhood of Steel."
	icon_state = "midwestgrey_pa"
	inhand_icon_state = "midwestgrey_pa"
	salvaged_type = /obj/item/clothing/suit/armor/heavy/salvaged_pa/midwest

/obj/item/clothing/suit/armor/power_armor/midwest/hardened
	name = "Hardened midwestern  T-51b power armor"
	desc = "This set of power armor belongs to the Midwestern branch of the Brotherhood of Steel. This particular one has gone through a chemical hardening process, increasing its armor capabilities."
	icon_state = "midwestpa"
	inhand_icon_state = "midwestpa"
	salvaged_type = /obj/item/clothing/suit/armor/heavy/salvaged_pa/midwest/hardened


/obj/item/clothing/suit/armor/power_armor/t60
	name = "T-60a power armor"
	desc = "Developed in early 2077 after the Anchorage Reclamation, the T-60 series of power armor was designed to eventually replace the T-51b as the pinnacle of powered armor technology in the U.S. military arsenal."
	icon_state = "t60powerarmor"
	inhand_icon_state = "t60powerarmor"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 30)
	salvaged_type = /obj/item/clothing/suit/armor/heavy/salvaged_pa/t60

/obj/item/clothing/suit/armor/power_armor/t60/pineapple
	name = "degraded T-60a power armor"
	desc = "Developed in early 2077 after the Anchorage Reclamation, the T-60 series of power armor was designed to eventually replace the T-51b as the pinnacle of powered armor technology in the U.S. military arsenal. This suit is heavily degraded." //reskin of head knight armor

/* /obj/item/clothing/suit/armor/medium/tribal/chitinarmor/old
	name = "insect chitin armor"
	desc = " set of light armor made of insect chitin. Tough and light, it provides some moderate protection from trauma while allowing the user to remain mobile and protected from the elements."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "insect"
	inhand_icon_state = "insect"
	armor = list("melee" = 40, "bullet" = 35,"laser" = 20, "energy" = 25, "bomb" = 25, "bio" = 70, "rad" = 65, "fire" = 80, "acid" = 100)
	flags_inv = HIDEJUMPSUIT
	strip_delay = 40
 */
/* /obj/item/clothing/suit/armor/generaluniform
	name = "Yuma 1st Irregular General Uniform"
	desc = "A uniform created by Kaleb alongside the laser muskets. On the breast is a patch of the Yuma 1st Irregulars, a sun over a wasteland desert, a cactus standing lonely in the middle. It denotes him as the Leader of the militia company."
	icon_state = "gen_uniform"
	inhand_icon_state = "gen_uniform" */

/* /obj/item/clothing/suit/armor/light/duster
	name = "duster"
	desc = "A long brown leather overcoat.<br>A powerful accessory of fearsome bounty hunter."
	icon_state = "duster"
	inhand_icon_state = "det_suit"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS */

//these are dusters
/obj/item/clothing/suit/toggle/armored/ranger_duster
	name = "ranger recon duster"
	desc = "A light bulletproof vest under a high-quality duster. Popular with Rangers."
	icon_state = "duster_recon"
	inhand_icon_state = "duster_recon"
	permeability_coefficient = 0.9

