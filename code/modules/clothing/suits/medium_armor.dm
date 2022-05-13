// In this document: Medium armor


///////////////
// WASTELAND //
///////////////

// Kevlar
/obj/item/clothing/suit/armored/medium/vestarmor
	name = "armored vest"
	desc = "Large bulletproof vest with ballistic plates."
	icon_state = "vest_armor"
	item_state = "vest_armor"
	armor = list("melee" = 15, "bullet" = 45, "laser" = 10, "energy" = 10, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = -5)

/obj/item/clothing/suit/armored/medium/vestchinese
	name = "chinese flak vest"
	desc = "An uncommon suit of pre-war Chinese armor. It's a very basic and straightforward piece of armor that covers the front of the user."
	icon_state = "vest_chicom"
	item_state = "vest_chicom"
	armor = list("melee" = 20, "bullet" = 35, "laser" = 5, "energy" = 5, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = -10)

// Plated medium armor
/obj/item/clothing/suit/armored/medium/scrapchest
	name = "scrap metal chestplate"
	desc = "Various metal bits welded together to form a crude chestplate."
	icon_state = "metal_chestplate"
	item_state = "metal_chestplate"
	siemens_coefficient = 1.3
	armor = list("melee" = 40, "bullet" = 30, "laser" = 15, "energy" = 15, "bomb" = 30, "bio" = 0, "rad" = 5, "fire" = 10, "acid" = 0)
	slowdown = 0.125

/obj/item/clothing/suit/armored/medium/scrapchest/reinforced
	name = "reinforced metal chestplate"
	desc = "Various metal bits welded together to form a crude chestplate, with extra bits of metal top of the first layer. Heavy."
	icon_state = "metal_chestplate2"
	item_state = "metal_chestplate2"
	armor = list("melee" = 40, "bullet" = 35, "laser" = 20, "energy" = 15, "bomb" = 30, "bio" = 0, "rad" = 5, "fire" = 10, "acid" = 0)

/obj/item/clothing/suit/armored/medium/brokencombat
	name = "broken combat armor chestpiece"
	desc = "It's barely holding together, but the plates might still work, you hope."
	icon_state = "combat_chestpiece"
	item_state = "combat_chestpiece"
	armor = list("melee" = 20, "bullet" = 20, "laser" = 15, "energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armored/medium/steelbib
	name = "steel breastplate"
	desc = "a steel breastplate inspired by a pre-war design. It provides some protection against impacts, cuts, and medium-velocity bullets. It's pressed steel construction feels heavy."
	icon_state = "steel_bib"
	item_state = "steel_bib"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 30, "energy" = 10, "bomb" = 5, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = -10)
	slowdown = 0.11

// Combat armor
/obj/item/clothing/suit/armored/medium/combat
	name = "combat armor"
	desc = "Military grade pre-war combat armor."
	icon_state = "combat_armor"
	item_state = "combat_armor"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 10, "rad" = 10, "fire" = 20, "acid" = 10)

//recipe any combat armor + duster
/obj/item/clothing/suit/armored/medium/combat/duster
	name = "combat duster"
	desc = "Refurbished combat armor under a weathered duster. Simple metal plates replace the ceramic plates that has gotten damaged."
	icon_state = "combatduster"
	item_state = "combatduster"
	permeability_coefficient = 0.9
	heat_protection = CHEST | GROIN | LEGS
	cold_protection = CHEST | GROIN | LEGS
	armor = list("melee" = 30, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 10, "rad" = 15, "fire" = 25, "acid" = 10)

/obj/item/clothing/suit/armored/medium/combat/swat
	name = "SWAT combat armor"
	desc = "A custom version of the pre-war combat armor, slimmed down and minimalist for domestic S.W.A.T. teams."
	icon_state = "armoralt"
	item_state = "armoralt"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 25, "energy" = 15, "bomb" = 30, "bio" = 10, "rad" = 10, "fire" = 25, "acid" = 10)

/obj/item/clothing/suit/armored/medium/combat/rusted
	name = "rusted combat armor"
	desc = "Weathered set of combat armor, it has clearly seen use for a long time by various previous owners, judging by the patched holes. The composite plates are a little cracked but it should still work. Probably."
	icon_state = "combat_rusted"
	item_state = "combat_rusted"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 25, "energy" = 15, "bomb" = 20, "bio" = 10, "rad" = 10, "fire" = 20, "acid" = 10)

/obj/item/clothing/suit/armored/medium/combat/mk2
	name = "reinforced combat armor"
	desc = "A reinforced set of bracers, greaves, and torso plating of prewar design. This one is kitted with additional plates."
	icon_state = "combat_armor_mk2"
	item_state = "combat_armor_mk2"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 20, "bomb" = 30, "bio" = 10, "rad" = 10, "fire" = 20, "acid" = 10)

/obj/item/clothing/suit/armored/medium/combat/mk2/raider
	name = "painspike combat armor"
	desc = "Take one set of combat armor, add a classic suit of painspike armor, forget hugging your friends ever again."
	icon_state = "combat_painspike"
	item_state = "combat_painspike"

////////////
// OUTLAW //
////////////

/obj/item/clothing/suit/armored/medium/supafly
	name = "supa-fly raider armor"
	desc = "Fabulous mutant powers were revealed to me the day I held aloft my bumper sword and said...<br>BY THE POWER OF NUKA-COLA, I AM RAIDER MAN!"
	icon_state = "supafly"
	item_state = "supafly"
	armor = list("melee" = 25, "bullet" = 40, "laser" = 20, "energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)

/obj/item/clothing/suit/armored/medium/rebel
	name = "rebel raider armor"
	desc = "Rebel, rebel. Your face is a mess."
	icon_state = "raider_rebel_icon"
	item_state = "raider_rebel_armor"
	armor = list("melee" = 25, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 20)

/obj/item/clothing/suit/armored/medium/sadist
	name = "sadist raider armor"
	desc = "A bunch of metal chaps adorned with severed hands at the waist with a leather plate worn on the left shoulder. Very intimidating."
	icon_state = "sadist"
	item_state = "sadist"
	armor = list("melee" = 30, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 15, "acid" = 5)

/obj/item/clothing/suit/armored/medium/blastmaster
	name = "blastmaster raider armor"
	desc = "A suit composed largely of blast plating, though there's so many holes it's hard to say if it will protect against much."
	icon_state = "blastmaster"
	item_state = "blastmaster"
	flash_protect = 2
	armor = list("melee" = 25, "bullet" = 25, "laser" = 20, "energy" = 25, "bomb" = 60, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 25)

/obj/item/clothing/suit/armored/medium/yankee
	name = "yankee raider armor"
	desc = "A set of armor made from bulky plastic and rubber. A faded sports team logo is printed in various places. Go Desert Rats!"
	icon_state = "yankee"
	item_state = "yankee"
	armor = list("melee" = 40, "bullet" = 20, "laser" = 15, "energy" = 15, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)

/obj/item/clothing/suit/armored/medium/painspike
	name = "painspike raider armor"
	desc = "A particularly unhuggable armor, even by raider standards. Extremely spiky."
	icon_state = "painspike"
	item_state = "painspike"
	armor = list("melee" = 40, "bullet" = 25, "laser" = 10, "energy" = 5, "bomb" = 5, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 5)

/obj/item/clothing/suit/armored/medium/iconoclast
	name = "iconoclast raider armor"
	desc = "A rigid armor set that appears to be fashioned from a radiation suit, or a mining suit."
	icon_state = "iconoclast"
	item_state = "iconoclast"
	permeability_coefficient = 0.8
	armor = list("melee" = 25, "bullet" = 30, "laser" = 25, "energy" = 30, "bomb" = 30, "bio" = 40, "rad" = 60, "fire" = 25, "acid" = 40)

/obj/item/clothing/suit/armored/medium/khancoat
	name = "khan battlecoat"
	desc = "Affluent pushers can affort fancy coats with a lot of metal and ceramic plates stuffed inside."
	icon_state = "khanbattle"
	item_state = "khanbattle"
	armor = list("melee" = 35, "bullet" = 25, "laser" = 15, "energy" = 20, "bomb" = 20, "bio" = 5, "rad" = 10, "fire" = 20, "acid" = 10)

/obj/item/clothing/suit/armored/medium/ncrexile
	name = "modified NCR armor"
	desc = "A modified detoriated armor kit consisting of NCR gear and scrap metal."
	icon_state = "ncrexile"
	item_state = "ncrexile"
	armor = list("melee" = 30, "bullet" = 35, "laser" = 30, "energy" = 25, "bomb" = 30, "bio" = 20, "rad" = 20, "fire" = 15, "acid" = 0)

/obj/item/clothing/suit/armored/medium/legexile
	name = "modified Legion armor"
	desc = "A modified detoriated armor kit consisting of Legion gear and scrap metal."
	icon_state = "legexile"
	item_state = "legexile"
	armor = list("melee" = 45, "bullet" = 30, "laser" = 20, "energy" = 15, "bomb" = 30, "bio" = 25, "rad" = 20, "fire" = 35, "acid" = 0)


/obj/item/clothing/suit/armored/medium/armoredcoat
	name = "armored battlecoat"
	desc = "A heavy padded leather coat with faded colors, worn over a armor vest."
	icon_state = "battlecoat_tan"
	item_state = "battlecoat_tan"
	armor = list("melee" = 20, "bullet" = 35, "laser" = 30, "energy" = 25, "bomb" = 20, "bio" = 5, "rad" = 10, "fire" = 25, "acid" = 5)

/obj/item/clothing/suit/armored/medium/duster_renegade
	name = "renegade duster"
	desc = "Metal armor worn under a stylish duster. For the bad boy who wants to look good while commiting murder."
	icon_state = "duster-renegade"
	item_state = "duster-renegade"
	armor = list("melee" = 20, "bullet" = 35, "laser" = 30, "energy" = 25, "bomb" = 20, "bio" = 5, "rad" = 10, "fire" = 25, "acid" = 5)

/obj/item/clothing/suit/armored/medium/slam
	name = "slammer raider armor"
	desc = "Crude armor using a premium selection of sawn up tires and thick layers of filthy cloth to give that murderous hobo look.<br>Come on and slam and turn your foes to jam! Pretty warm, but it is made of very flammable stuff. It's probably fine."
	icon_state = "slam"
	item_state = "slam"
	flags_inv = HIDEJUMPSUIT
	cold_protection = CHEST | GROIN | LEGS| ARMS | HEAD
	siemens_coefficient = 0.9
	armor = list("melee" = 45, "bullet" = 20, "laser" = 0, "energy" = 0, "bomb" = 40, "bio" = 10, "rad" = 10, "fire" = -25, "acid" = 0)

/obj/item/clothing/suit/armored/medium/scrapcombat
	name = "scrap combat armor"
	desc = "Scavenged military combat armor, repaired by unskilled hands many times, most of the original plating having cracked or crumbled to dust."
	icon_state = "raider_combat"
	item_state = "raider_combat"
	armor = list("melee" = 35, "bullet" = 25, "laser" = 15, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 5)


////////////
// LEGION //
////////////

/obj/item/clothing/suit/armored/medium/forgemaster
	name = "forgemaster armor"
	desc = "Legion armor reinforced with metal, worn with a Forgemaster apron with the bull insignia over it."
	icon_state = "opifex_apron"
	item_state = "opifex_apron"
	blood_overlay_type = "armor"
	armor = list("melee" = 45, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 30, "bio" = 5, "rad" = 10, "fire" = 45, "acid" = 10)

/obj/item/clothing/suit/armored/medium/vet
	name = "legion veteran armor"
	desc = "Armor worn by veteran legionaries who have proven their combat prowess in many battles, its hardened leather is sturdier than that of previous ranks."
	icon_state = "legion_veteran"
	armor = list("melee" = 45, "bullet" = 30, "laser" = 20, "energy" = 15, "bomb" = 30, "bio" = 5, "rad" = 5, "fire" = 35, "acid" = 0)
	slowdown = 0.075

/obj/item/clothing/suit/armored/medium/vexil
	name = "legion vexillarius armor"
	desc = "The armor appears to be based off of a suit of Legion veteran armor, with the addition of circular metal plates attached to the torso, as well as a banner displaying the flag of the Legion worn on the back."
	icon_state = "legion_vex"
	armor = list("melee" = 45, "bullet" = 35, "laser" = 25, "energy" = 20, "bomb" = 35, "bio" = 5, "rad" = 5, "fire" = 35, "acid" = 0)
	slowdown = 0.075

/obj/item/clothing/suit/armored/medium/combat/legion
	name = "Legion combat armor"
	desc = "An old military grade pre war combat armor and, repainted to the colour scheme of Caesar's Legion."
	icon_state = "legion_combat"
	item_state = "legion_combat"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 10, "rad" = 10, "fire" = 20, "acid" = 10)



/////////
// NCR //
/////////

/obj/item/clothing/suit/armored/medium/ncrarmor
	name = "NCR armor vest"
	desc = "A standard issue NCR Infantry armor vest."
	icon_state = "ncr_infantry_vest"
	item_state = "ncr_infantry_vest"
	armor = list("melee" = 15, "bullet" = 35, "laser" = 15, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 0)

/obj/item/clothing/suit/armored/medium/ncrarmormant
	name = "NCR mantle vest"
	desc = "A standard issue NCR Infantry vest with a mantle on the shoulder."
	icon_state = "ncr_standard_mantle"
	item_state = "ncr_standard_mantle"
	armor = list("melee" = 15, "bullet" = 35, "laser" = 15, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 5)

/obj/item/clothing/suit/armored/medium/ncrarmorreinf
	name = "NCR reinforced armor vest"
	desc = "A standard issue NCR Infantry vest reinforced with a groinpad."
	icon_state = "ncr_reinforced_vest"
	item_state = "ncr_reinforced_vest"
	armor = list("melee" = 20, "bullet" = 40, "laser" = 15, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 0)

/obj/item/clothing/suit/armored/medium/ncrarmormantreinf
	name = "NCR reinforced mantle vest"
	desc = "A standard issue NCR Infantry vest reinforced with a groinpad and a mantle."
	icon_state = "ncr_reinforced_mantle"
	item_state = "ncr_reinforced_mantle"
	armor = list("melee" = 20, "bullet" = 40, "laser" = 15, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 5)

/obj/item/clothing/suit/armored/medium/ncrarmorofficer
	name = "NCR officer armor vest"
	desc = "A reinforced set of NCR mantle armour, with added padding on the groin, neck and shoulders. Intended for use by the officer class."
	icon_state = "ncr_lt_armour"
	item_state = "ncr_lt_armour"
	armor = list("melee" = 25, "bullet" = 45, "laser" = 15, "energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 5)

/obj/item/clothing/suit/armored/medium/ncrarmorofficer/captain
	name = "NCR captain's armor"
	desc = "The captain gets to wear a non-regulation coat over his armor because he is in charge, and don't you forget it."
	icon_state = "ncr_officer_coat"
	item_state = "ncr_officer_coat"

/obj/item/clothing/suit/armored/medium/combat/ncr
	name = "NCR combat armor"
	desc = "Combat armor painted in the khaki of the New California Republic, displaying its flag on the chest."
	icon_state = "ncr_armor"
	item_state = "ncr_armor"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 15, "energy" = 20, "bomb" = 25, "bio" = 10, "rad" = 10, "fire" = 15, "acid" = 10)

/obj/item/clothing/suit/armored/medium/ncrarmorcolonel
	name = "NCR colonels armor"
	desc = "A heavily reinforced set of NCR mantle armour, ceramic inserts protects the vital organs quite well. Used by high ranking NCR officers in dangerous zones."
	icon_state = "ncr_captain_armour"
	item_state = "ncr_captain_armour"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 40, "energy" = 40, "bomb" = 45, "bio" = 40, "rad" = 45, "fire" = 45, "acid" = 20)

/obj/item/clothing/suit/armored/medium/combat/ncrranger
	name = "ranger patrol armor"
	desc = "The standard issue ranger patrol armor is based on pre-war combat armor design, and has similar capabilities."
	icon_state = "ncr_patrol"
	item_state = "ncr_patrol"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 10, "rad" = 10, "fire" = 20, "acid" = 10)

/obj/item/clothing/suit/armored/medium/combat/vetranger
	name = "veteran ranger combat armor"
	desc = "The NCR veteran ranger combat armor, or black armor consists of a pre-war L.A.P.D. riot suit under a duster with rodeo jeans. Considered one of the most prestigious suits of armor to earn and wear while in service of the NCR Rangers."
	icon_state = "ranger"
	item_state = "ranger"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 30, "energy" = 25, "bomb" = 25, "bio" = 10, "rad" = 20, "fire" = 35, "acid" = 10)


//////////////////////////
// BROTHERHOOD OF STEEL //
//////////////////////////

/obj/item/clothing/suit/armored/medium/combat/bos
	name = "initiate armor"
	desc = "An old military grade pre war combat armor, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_armor"
	item_state = "brotherhood_armor"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 10, "rad" = 10, "fire" = 20, "acid" = 10)

/obj/item/clothing/suit/armored/medium/combatmk2/bos
	name = "reinforced initiate armor"
	desc = "A reinforced set of bracers, greaves, and torso plating of prewar design This one is kitted with additional plates and, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_armor_mk2"
	item_state = "brotherhood_armor_mk2"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 20, "bomb" = 30, "bio" = 10, "rad" = 10, "fire" = 20, "acid" = 10)

/obj/item/clothing/suit/armored/medium/combatmk2/knight
	name = "brotherhood armor"
	desc = "A combat armor set made by the Brotherhood of Steel, standard issue for all Knights. It bears a red stripe."
	icon_state = "brotherhood_armor_knight"
	item_state = "brotherhood_armor_knight"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 40, "energy" = 30, "bomb" = 30, "bio" = 10, "rad" = 20, "fire" = 25, "acid" = 10)

/obj/item/clothing/suit/armored/medium/combatmk2/senknight
	name = "brotherhood senior knight armor"
	desc = "A combat armor set made by the Brotherhood of Steel, standard issue for all Senior Knight. It bears a silver stripe."
	icon_state = "brotherhood_armor_senior"
	item_state = "brotherhood_armor_senior"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 30, "bomb" = 30, "bio" = 10, "rad" = 25, "fire" = 25, "acid" = 10)

/obj/item/clothing/suit/armored/medium/combatmk2/headknight
	name = "brotherhood knight-captain armor"
	desc = "A combat armor set made by the Brotherhood of Steel, standard issue for all Knight-Captains. It bears golden embroidery."
	icon_state = "brotherhood_armor_captain"
	item_state = "brotherhood_armor_captain"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 30, "bomb" = 30, "bio" = 15, "rad" = 25, "fire" = 30, "acid" = 15)

////////////////
// OASIS/TOWN //
////////////////

/obj/item/clothing/suit/armored/medium/lawcoat
	name = "deputy trenchcoat"
	desc = "An armored trench coat with added shoulderpads, a chestplate, and leg guards."
	icon_state = "towntrench_medium"
	item_state = "hostrench"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 30, "energy" = 25, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 40, "acid" = 5)

/obj/item/clothing/suit/armored/medium/lawcoat/sheriff
	name = "sheriff trenchcoat"
	desc = "A trenchcoat which does a poor job at hiding the full-body combat armor beneath it."
	icon_state = "towntrench_heavy"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 35,  "energy" = 40, "bomb" = 30, "bio" = 40, "rad" = 40, "fire" = 50, "acid" = 10)

/obj/item/clothing/suit/armored/medium/lawcoat/commissioner
	name = "commissioner's jacket"
	desc = "A navy-blue jacket with blue shoulder designations, '/OPD/' stitched into one of the chest pockets, and hidden ceramic trauma plates. It has a small compartment for a holdout pistol."
	icon_state = "warden_alt"
	item_state = "armor"
	armor = list("melee" = 40, "bullet" = 60, "laser" = 30,  "energy" = 35, "bomb" = 30, "bio" = 40, "rad" = 40, "fire" = 50, "acid" = 10)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/holdout

/obj/item/clothing/suit/armored/medium/steelbib/town
	name = "steel breastplate"
	desc = "A steel breastplate inspired by a pre-war design, this one was made locally in Oasis. It uses a stronger steel alloy in it's construction, still heavy though"
	armor = list("melee" = 30, "bullet" = 35, "laser" = 35, "energy" = 15, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = -10)
	slowdown = 0.11

///////////////
// WAYFARERS //
///////////////

/obj/item/clothing/suit/armored/medium/combat/tribal
	name = "tribal combat armor"
	desc = "Military grade pre war combat armor, now decorated with sinew and the bones of the hunted for its new wearer."
	icon_state = "tribecombatarmor"
	item_state = "tribecombatarmor"
	armor = list("melee" = 35, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 10, "rad" = 10, "fire" = 20, "acid" = 10)


////////////
// CUSTOM //
////////////

/obj/item/clothing/suit/armored/medium/combat/cloak_armored
	name = "armored cloak"
	desc = "A dark cloak worn over protective plating."
	icon_state = "cloak_armored"
	item_state = "cloak_armored"
	armor = list("melee" = 25, "bullet" = 35, "laser" = 20, "energy" = 15, "bomb" = 20, "bio" = 5, "rad" = 10, "fire" = 25, "acid" = 5)

/obj/item/clothing/suit/armored/medium/scrapchest/mutant
	name = "mutant armour"
	desc = "Metal plates rigged to fit the frame of a super mutant. Maybe he's the big iron with a ranger on his hip?"
	icon_state = "mutie_heavy_metal"
	item_state = "mutie_heavy_metal"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 15, "energy" = 15, "bomb" = 30, "bio" = 0, "rad" = 5, "fire" = 10, "acid" = 0)
	slowdown = 0.1
	allowed = list(/obj/item/gun, /obj/item/melee/onehanded, /obj/item/twohanded, /obj/item/melee/smith, /obj/item/melee/smith/twohand)

/obj/item/clothing/suit/armored/medium/motorball
	name = "motorball suit"
	desc = "Reproduction motorcycle-football suit, made in vault 75 that was dedicated to a pure sports oriented culture."
	icon_state = "motorball"
	item_state = "motorball"
	armor = list("melee" = 40, "bullet" = 25, "laser" = 15, "energy" = 15, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 10)

//THE GRAVEYARD
//IF PUT BACK INTO USE, PLEASE FILE IT BACK SOMEWHERE ABOVE

/*

/obj/item/clothing/suit/armored/medium/lawcoat/mayor
	name = "mayor trenchcoat"
	desc = "A symbol of the mayor's authority (or lack thereof)."
	armor = list("melee" = 40, "bullet" = 35, "laser" = 30, "energy" = 40, "bomb" = 30, "bio" = 40, "rad" = 40, "fire" = 40, "acid" = 0)

//Enclave/Remnants

/obj/item/clothing/suit/armor/f13/combat/enclave
	name = "enclave combat armor"
	desc = "A set of matte black advanced pre-war combat armor."
	icon_state = "enclave_new"
	item_state = "enclave_new"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 20, "bomb" = 30, "bio" = 10, "rad" = 10, "fire" = 20, "acid" = 10)

/obj/item/clothing/suit/armor/f13/enclave/armorvest
	name = "armored vest"
	desc = "Efficient prewar design issued to Enclave personell."
	icon_state = "armor_enclave_peacekeeper"
	item_state = "armor_enclave_peacekeeper"
	armor = list("melee" = 35, "bullet" = 50, "laser" = 30, "energy" = 30, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)

/obj/item/clothing/suit/armor/f13/enclave/officercoat
	name = "armored coat"
	desc = "Premium prewar armor fitted into a coat for Enclave officers."
	icon_state = "armor_enclave_officer"
	item_state = "armor_enclave_officer"
	armor = list("melee" = 60, "bullet" = 45, "energy" = 40, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)
*/
