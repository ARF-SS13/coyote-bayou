/* Copied to sprite_accessories subtree for code reasons. This file is not actually used, included so all the data thats needed in the module is collected.
//////////////////////
// Hair Definitions //
//////////////////////
// Hair Flags
#define VERY_SHORT_HAIR	(1<<0)
#define VERY_LONG_HAIR	(1<<1)
/datum/sprite_accessory/hair
	icon = 'modular_atom/fashion/icons/hair.dmi'
	var/flags
	// Name is type of hair first, second part the hair ID. Avouid numbers, use names, avoid hair ID duplication.
	// sort by category
	// try to capitalize the names please~, and keep them short enough for single line names in preferences.
	// try to spell
	// If you add a hair, add a changlog to the readme, and make a hair extension verions, not optional.
/datum/sprite_accessory/hair/bald //this is exempt from the alphabetical sort
	name = "Bald"
	icon_state = "bald"
	flags = VERY_SHORT_HAIR
// BUNS
/datum/sprite_accessory/hair/bun
	name = "Bun"
	icon_state = "bun"
/datum/sprite_accessory/hair/bun_biggy
	name = "Bun (Biggy)"
	icon_state = "bun_biggy"
/datum/sprite_accessory/hair/bun_double
	name = "Bun (Double)"
	icon_state = "bun_double"
/datum/sprite_accessory/hair/bun_armstrong
	name = "Bun (Strong)"
	icon_state = "bun_armstrong"
/datum/sprite_accessory/hair/bun_uniter
	name = "Bun (Uniter)"
	icon_state = "bun_uniter"
/datum/sprite_accessory/hair/bun_grandma
	name = "Bun (Grandma)"
	icon_state = "bun_grandma"
// BUSINESS
/datum/sprite_accessory/hair/business
	name = "Business Hair"
	icon_state = "business"
	gender = MALE
/datum/sprite_accessory/hair/business_burns
	name = "Business (Burn)"
	icon_state = "business_burns"
/datum/sprite_accessory/hair/business_classy
	name = "Business (Class)"
	icon_state = "business_classy"
/datum/sprite_accessory/hair/business_cia
	name = "Business (CIA)"
	icon_state = "business_cia"
/datum/sprite_accessory/hair/business_dave
	name = "Business (Dave)"
	icon_state = "business_dave"
/datum/sprite_accessory/hair/business_ivy
	name = "Business (Ivy)"
	icon_state = "business_ivy"
/datum/sprite_accessory/hair/business_jensen
	name = "Business (Jens)"
	icon_state = "business_jensen"
// BOB
/datum/sprite_accessory/hair/bob
	name = "Bob"
	icon_state = "bob"
/datum/sprite_accessory/hair/bob_ada
	name = "Bob (Ada)"
	icon_state = "bob_ada"
/datum/sprite_accessory/hair/bob_amelie
	name = "Bob (Amelie)"
	icon_state = "bob_amelie"
/datum/sprite_accessory/hair/bob_helen
	name = "Bob (Helen)"
	icon_state = "bob_helen"
/datum/sprite_accessory/hair/bob_page
	name = "Bob (Page)"
	icon_state = "bob_page"
/datum/sprite_accessory/hair/bob_scully
	name = "Bob (Scully)"
	icon_state = "bob_scully"
/datum/sprite_accessory/hair/bob_shy
	name = "Bob (Shy)"
	icon_state = "bob_shy"
// BRAIDS
/datum/sprite_accessory/hair/braid_single
	name = "Braid"
	icon_state = "braid_single"
/datum/sprite_accessory/hair/braid_pulled
	name = "Braid (Pulled)"
	icon_state = "braid_pulled"
/datum/sprite_accessory/hair/braid_twinfront
	name = "Braids Front"
	icon_state = "braid_twinfront"
/datum/sprite_accessory/hair/braid_tribal
	name = "Braid (Tribal)"
	icon_state = "braid_tribal"
/datum/sprite_accessory/hair/braid_zone
	name = "Braid (Zone)"
	icon_state = "braid_zone"
	gender = FEMALE
//CURLY
/datum/sprite_accessory/hair/curly
	name = "Curly"
	icon_state = "curly"
/datum/sprite_accessory/hair/curly_beach
	name = "Curly (Beach)"
	icon_state = "curly_beachwave"
/datum/sprite_accessory/hair/curly_drill
	name = "Curly (Drill)"
	icon_state = "curly_drill"
/datum/sprite_accessory/hair/curly_drilluru
	name = "Curly (Drilluru)"
	icon_state = "curly_drilluru"
/datum/sprite_accessory/hair/curly_feather
	name = "Curly (Feather)"
	icon_state = "curly_feather"
/datum/sprite_accessory/hair/curly_jessica
	name = "Curly (Jessica)"
	icon_state = "curly_jessica"
/datum/sprite_accessory/hair/curly_volaju
	name = "Curly (Volaju)"
	icon_state = "curly_volaju"
//EMO
/datum/sprite_accessory/hair/emo
	name = "Emo"
	icon_state = "emo"
/datum/sprite_accessory/hair/emo_goth
	name = "Emo (Goth)"
	icon_state = "emo_goth"
/datum/sprite_accessory/hair/emo_long
	name = "Emo (Long)"
	icon_state = "emo_long"
/datum/sprite_accessory/hair/emo_reverse
	name = "Emo (Reverse)"
	icon_state = "emo_reverse"
/datum/sprite_accessory/hair/emo_tails
	name = "Emo (Tails)"
	icon_state = "emo_tails"
//GENTLE
/datum/sprite_accessory/hair/gentle
	name = "Gentle hair"
	icon_state = "gentle"
/datum/sprite_accessory/hair/gentle_comb
	name = "Gentle (Comb)"
	icon_state = "gentle_comb"
/datum/sprite_accessory/hair/gentle_long
	name = "Gentle (Long)"
	icon_state = "gentle_long"
/datum/sprite_accessory/hair/gentle_fringe
	name = "Gentle (Fringe)"
	icon_state = "gentle_fringe"
//HIME
/datum/sprite_accessory/hair/himecut
	name = "Hime cut"
	icon_state = "hime"
/datum/sprite_accessory/hair/hime_junia
	name = "Hime (Junia)"
	icon_state = "hime_junia"
/datum/sprite_accessory/hair/hime_major
	name = "Hime (Major)"
	icon_state = "hime_major"
/datum/sprite_accessory/hair/hime_school
	name = "Hime (School)"
	icon_state = "hime_school"
/datum/sprite_accessory/hair/hime_styled
	name = "Hime (Styled)"
	icon_state = "hime_styled"
// LONG
/datum/sprite_accessory/hair/long
	name = "Long hair"
	icon_state = "long"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/long_amazon
	name = "Long (Amazon)"
	icon_state = "long_amazon"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/long_blunt
	name = "Long (Blunt)"
	icon_state = "long_blunt"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/long_cali
	name = "Long (Cali)"
	icon_state = "long_cali"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/long_choir
	name = "Long (Choir)"
	icon_state = "long_choir"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/long_mary
	name = "Long (Mary)"
	icon_state = "long_mary"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/long_modern
	name = "Long (Modern)"
	icon_state = "long_modern"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/long_over
	name = "Long (Overeye)"
	icon_state = "long_over"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/long_surf
	name = "Long (Surf)"
	icon_state = "long_surf"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/long_straight
	name = "Long (Straight)"
	icon_state = "long_straight"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/long_80s
	name = "Long (80s)"
	icon_state = "long_80s"
	flags = VERY_LONG_HAIR
// MATURE
/datum/sprite_accessory/hair/mature_balding
	name = "Mature (Baldy"
	icon_state = "mature_balding"
	flags = VERY_SHORT_HAIR
	gender = MALE
/datum/sprite_accessory/hair/mature_bodicker
	name = "Mature (Bo)"
	icon_state = "mature_bodicker"
	flags = VERY_SHORT_HAIR
	gender = MALE
/datum/sprite_accessory/hair/mature_baldfade
	name = "Mature (Fade)"
	icon_state = "mature_baldfade"
	flags = VERY_SHORT_HAIR
	gender = MALE
/datum/sprite_accessory/hair/mature_father
	name = "Mature (Father)"
	icon_state = "mature_father"
	flags = VERY_SHORT_HAIR
	gender = MALE
/datum/sprite_accessory/hair/mature_thinning
	name = "Mature (Thin)"
	icon_state = "mature_thinning"
	flags = VERY_SHORT_HAIR
	gender = MALE
/datum/sprite_accessory/hair/mature_monk
	name = "Mature (Monk)"
	icon_state = "mature_monk"
	flags = VERY_SHORT_HAIR
	gender = MALE
// MOHAWK
/datum/sprite_accessory/hair/mohawk
	name = "Mohawk"
	icon_state = "mohawk"
/datum/sprite_accessory/hair/mohawk_mister
	name = "Mohawk (Mr T)"
	icon_state = "mohawk_mister"
/datum/sprite_accessory/hair/mohawk_mullet
	name = "Mohawk-Mullet"
	icon_state = "mohawk_mullet"
/datum/sprite_accessory/hair/mohawk_taxi
	name = "Mohawk (Taxi)"
	icon_state = "mohawk_taxi"
// PONYTAIL
/datum/sprite_accessory/hair/ponytail
	name = "Ponytail"
	icon_state = "ponytail"
/datum/sprite_accessory/hair/ponytail_bright
	name = "Ponytail (Bright)"
	icon_state = "ponytail_bright"
/datum/sprite_accessory/hair/ponytail_fox
	name = "Ponytail (Fox)"
	icon_state = "ponytail_fox"
/datum/sprite_accessory/hair/ponytail_grande
	name = "Ponytail (Grand)"
	icon_state = "ponytail_grande"
/datum/sprite_accessory/hair/ponytail_neat
	name = "Ponytail (Neat)"
	icon_state = "ponytail_neat"
/datum/sprite_accessory/hair/ponytail_rynn
	name = "Ponytail (Rynn)"
	icon_state = "ponytail_rynn"
/datum/sprite_accessory/hair/ponytail_summer
	name = "Pony (Summer)"
	icon_state = "ponytail_summer"
/datum/sprite_accessory/hair/ponytail_shade
	name = "Pony (Shade)"
	icon_state = "ponytail_shade"
/datum/sprite_accessory/hair/ponytail_spiky
	name = "Ponytail (Spiky)"
	icon_state = "ponytail_spiky"
/datum/sprite_accessory/hair/ponytail_tied
	name = "Ponytail (Tied)"
	icon_state = "ponytail_tied"
/datum/sprite_accessory/hair/ponytail_winter
	name = "Pony (Winter)"
	icon_state = "ponytail_winter"
// PIGTAILS
/datum/sprite_accessory/hair/pigtails
	name = "Pigtails"
	icon_state = "pigtails"
/datum/sprite_accessory/hair/pigtails_african
	name = "Pigtails (African)"
	icon_state = "pigtails_african"
	gender = FEMALE
/datum/sprite_accessory/hair/pigtails_belle
	name = "Pigtails (Belle)"
	icon_state = "pigtails_belle"
	gender = FEMALE
/datum/sprite_accessory/hair/pigtails_britney
	name = "Pigtails (Brit)"
	icon_state = "pigtails_britney"
	gender = FEMALE
/datum/sprite_accessory/hair/pigtails_cotton
	name = "Pigtails (Cotton)"
	icon_state = "pigtails_cotton"
	gender = FEMALE
/datum/sprite_accessory/hair/pigtails_fairy
	name = "Pigtails (Fairy)"
	icon_state = "pigtails_fairy"
	gender = FEMALE
// Unsorted
/datum/sprite_accessory/hair/pompadour
	name = "Pompadour"
	icon_state = "pompadour"
	gender = MALE
// SHAVED
/datum/sprite_accessory/hair/shaved
	name = "Shaved"
	icon_state = "shaved"
/datum/sprite_accessory/hair/shaved_buzzcut
	name = "Shave (Buzzcut)"
	icon_state = "shaved_buzzcut"
	flags = VERY_SHORT_HAIR
/datum/sprite_accessory/hair/shaved_crewcut
	name = "Shave (Crew)"
	icon_state = "shaved_crewcut"
	flags = VERY_SHORT_HAIR
/datum/sprite_accessory/hair/shaved_coffeehouse
	name = "Shave (Coffee)"
	icon_state = "shaved_coffeehouse"
/datum/sprite_accessory/hair/shaved_cutty
	name = "Shave (Cutty)"
	icon_state = "shaved_cutty"
/datum/sprite_accessory/hair/shaved_european
	name = "Shave (Euro)"
	icon_state = "shaved_european"
	gender = MALE
/datum/sprite_accessory/hair/shaved_fade
	name = "Shave (Fade)"
	icon_state = "shaved_fade"
/datum/sprite_accessory/hair/shaved_high
	name = "Shave (High)"
	icon_state = "shaved_high"
/datum/sprite_accessory/hair/shaved_joe
	name = "Shave (Joe)"
	icon_state = "shaved_joe"
	gender = MALE
/datum/sprite_accessory/hair/shaved_legion
	name = "Shave (Legion)"
	icon_state = "shaved_legion"
	gender = MALE
/datum/sprite_accessory/hair/shaved_marine
	name = "Shave (Marine)"
	icon_state = "shaved_marine"
/datum/sprite_accessory/hair/shaved_part
	name = "Shave (Part)"
	icon_state = "shaved_part"
/datum/sprite_accessory/hair/shaved_punk
	name = "Shave (Punk)"
	icon_state = "shaved_punk"
/datum/sprite_accessory/hair/shaved_tight
	name = "Shave (Tight)"
	icon_state = "shaved_tight"
/datum/sprite_accessory/hair/shaved_under
	name = "Shave (Under)"
	icon_state = "shaved_under"
// SHOULDER
/datum/sprite_accessory/hair/shoulder
	name = "Shoulderlength"
	icon_state = "shoulder"
/datum/sprite_accessory/hair/shoulder_bang
	name = "Shoulder (Bang)"
	icon_state = "shoulder_bang"
/datum/sprite_accessory/hair/shoulder_flair
	name = "Shoulder (Flair)"
	icon_state = "shoulder_flair"
/datum/sprite_accessory/hair/shoulder_flow
	name = "Shoulder (Flow)"
	icon_state = "shoulder_flow"
/datum/sprite_accessory/hair/shoulder_nova
	name = "Shoulder (Nova)"
	icon_state = "shoulder_nova"
/datum/sprite_accessory/hair/shoulder_wife
	name = "Shoulder (Wife)"
	icon_state = "shoulder_wife"
// SLICK
/datum/sprite_accessory/hair/slick_back
	name = "Slick (Back)"
	icon_state = "slick_back"
/datum/sprite_accessory/hair/slick_bang
	name = "Slick (Bang)"
	icon_state = "slick_bang"
/datum/sprite_accessory/hair/slick_devil
	name = "Slick (Devil)"
	icon_state = "slick_devil"
/datum/sprite_accessory/hair/slick_gelled
	name = "Slick (Gelled)"
	icon_state = "slick_gelled"
/datum/sprite_accessory/hair/slick_grease
	name = "Slick (Grease)"
	icon_state = "slick_grease"
/datum/sprite_accessory/hair/slick_nick
	name = "Slick (Nick)"
	icon_state = "slick_nick"
/datum/sprite_accessory/hair/slick_parted
	name = "Slick (Parted)"
	icon_state = "slick_parted"
/datum/sprite_accessory/hair/slick_sleaze
	name = "Slick (Sleaze)"
	icon_state = "slick_sleaze"
/datum/sprite_accessory/hair/slick_quiff
	name = "Slick (Quiff)"
	icon_state = "slick_quiff"
// SIDEHAIR
/datum/sprite_accessory/hair/sidehair
	name = "Sidehair"
	icon_state = "sidehair"
/datum/sprite_accessory/hair/sidehair_braid
	name = "Sidehair (Braid)"
	icon_state = "sidehair_braid"
/datum/sprite_accessory/hair/sidehair_tress
	name = "Sidehair (Tress)"
	icon_state = "sidehair_tress"
	gender = FEMALE
// SIDETAIL
/datum/sprite_accessory/hair/sidetail
	name = "Sidetail"
	icon_state = "sidetail"
/datum/sprite_accessory/hair/country
	name = "Side (Country)"
	icon_state = "sidetail_country"
	gender = FEMALE
/datum/sprite_accessory/hair/sidetail_kitty
	name = "Sidetail (Kitty)"
	icon_state = "sidetail_kitty"
/datum/sprite_accessory/hair/sidetail4
	name = "Sidetail no. 4"
	icon_state = "sidetail_4"
// TAIL LONGHAIR
/datum/sprite_accessory/hair/tail_inari
	name = "Tail (Inari)"
	icon_state = "tail_inari"
	flags = VERY_LONG_HAIR
	gender = FEMALE
/datum/sprite_accessory/hair/newyou
	name = "Tail (New You)"
	icon_state = "tail_newyou"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/tail_spiky
	name = "Tail (Spiky)"
	icon_state = "tail_spiky"
	flags = VERY_LONG_HAIR
/datum/sprite_accessory/hair/wisp
	name = "Tail (Wisp)"
	icon_state = "tail_wisp"
	flags = VERY_LONG_HAIR
	gender = FEMALE
/datum/sprite_accessory/hair/ziegler
	name = "Tail (Ziegler)"
	icon_state = "tail_ziegler"
	flags = VERY_LONG_HAIR

// TOPKNOT
/datum/sprite_accessory/hair/topknot
	name = "Topknot"
	icon_state = "topknot"
/datum/sprite_accessory/hair/topknot_ronin
	name = "Topknot (Ronin)"
	icon_state = "topknot_ronin"
/datum/sprite_accessory/hair/topknot_manbun
	name = "Top (Manbun)"
	icon_state = "topknot_manbun"
	gender = MALE
// TRIMMED
/datum/sprite_accessory/hair/trimmed
	name = "Trimmed"
	icon_state = "trimmed"
/datum/sprite_accessory/hair/trimmed_bowlcut
	name = "Trimmed (Bowl)"
	icon_state = "trimmed_bowlcut"
/datum/sprite_accessory/hair/trimmed_brother
	name = "Trimmed (Bro)"
	icon_state = "trimmed_brother"
/datum/sprite_accessory/hair/trimmed_flat
	name = "Trimmed (Flat)"
	icon_state = "trimmed_flat"
// UPDO
/datum/sprite_accessory/hair/updo
	name = "Updo"
	icon_state = "updo"
/datum/sprite_accessory/hair/updo_anita
	name = "Updo (Anita)"
	icon_state = "updo_anita"
/datum/sprite_accessory/hair/updo_beehive
	name = "Updo (Beehive)"
	icon_state = "updo_beehive"
	gender = FEMALE
/datum/sprite_accessory/hair/updo_empress
	name = "Updo (Empress)"
	icon_state = "updo_empress"
	gender = FEMALE
/datum/sprite_accessory/hair/updo_geisha
	name = "Updo (Geisha)"
	icon_state = "updo_geisha"
	gender = FEMALE
//SHORT
/datum/sprite_accessory/hair/short
	name = "Short"
	icon_state = "short"
/datum/sprite_accessory/hair/short_afro
	name = "Short (Afro)"
	icon_state = "short_afro"
/datum/sprite_accessory/hair/short_overye
	name = "Short (Overeye)"
	icon_state = "short_overeye"
/datum/sprite_accessory/hair/short_kurt
	name = "Short (Kurt)"
	icon_state = "short_kurt"
/datum/sprite_accessory/hair/short_mulder
	name = "Short (Mulder)"
	icon_state = "short_mulder"
	gender = MALE
/datum/sprite_accessory/hair/short_omar
	name = "Short (Omar)"
	icon_state = "short_omar"
	flags = VERY_SHORT_HAIR
/datum/sprite_accessory/hair/short_rows
	name = "Short (Rows)"
	icon_state = "short_rows"
	flags = VERY_SHORT_HAIR
/datum/sprite_accessory/hair/short_parted
	name = "Short (Parted)"
	icon_state = "short_parted"
/datum/sprite_accessory/hair/short_rebel
	name = "Short (Rebel)"
	icon_state = "short_rebel"
/datum/sprite_accessory/hair/short_spiked
	name = "Short (Spiked)"
	icon_state = "short_spiked"
/datum/sprite_accessory/hair/short_suburb
	name = "Short (Suburb)"
	icon_state = "short_suburb"
// MESSY
/datum/sprite_accessory/hair/messy
	name = "Messy"
	icon_state = "messy"
/datum/sprite_accessory/hair/messy_bedhead
	name = "Messy (Bed)"
	icon_state = "messy_bedhead"
/datum/sprite_accessory/hair/messy_dreads
	name = "Messy (Dreads)"
	icon_state = "messy_dreads"
	flags = VERY_SHORT_HAIR
/datum/sprite_accessory/hair/messy_ganja
	name = "Messy (Ganja)"
	icon_state = "messy_ganja"
/datum/sprite_accessory/hair/messy_oxton
	name = "Messy (Oxton)"
	icon_state = "messy_oxton"
/datum/sprite_accessory/hair/messy_poofy
	name = "Messy (Poofy)"
	icon_state = "messy_poofy"
/datum/sprite_accessory/hair/messy_skank
	name = "Messy (Skank)"
	icon_state = "messy_skank"
	gender = FEMALE
/datum/sprite_accessory/hair/messy_sabitsuki
	name = "Messy (Tsuki)"
	icon_state = "messy_sabitsuki"
/datum/sprite_accessory/hair/messy_jade
	name = "Messy (Jade)"
	icon_state = "messy_jade"
/datum/sprite_accessory/hair/messy_wave
	name = "Messy (Wave)"
	icon_state = "messy_wave"
// SPIKY
/datum/sprite_accessory/hair/spiky
	name = "Spiky"
	icon_state = "spiky"
/datum/sprite_accessory/hair/spiky_radish
	name = "Spiky (Radish)"
	icon_state = "spiky_radish"
/datum/sprite_accessory/hair/swept
	name = "Spiky (Swept)"
	icon_state = "spiky_swept"
/datum/sprite_accessory/hair/joestar
	name = "Spiky (Joestar)"
	icon_state = "spiky_joestar"
/datum/sprite_accessory/hair/toriyama
	name = "Spiky (Yama)"
	icon_state = "spiky_toriyama"
// WILD
/datum/sprite_accessory/hair/wild_madman
	name = "Wild (Madman)"
	icon_state = "wild_madman"
/datum/sprite_accessory/hair/wild_irradiated
	name = "Wild (Radiated)"
	icon_state = "wild_irradiated"
	flags = VERY_SHORT_HAIR
/datum/sprite_accessory/hair/wild_shamate
	name = "Wild (Shamate)"
	icon_state = "wild_shamate"
/datum/sprite_accessory/hair/wild_silly
	name = "Wild (Silly)"
	icon_state = "wild_silly"
*/
