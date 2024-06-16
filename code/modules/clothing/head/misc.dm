

/obj/item/clothing/head/centhat
	name = "\improper CentCom hat"
	icon_state = "centcom"
	desc = "It's good to be emperor."
	item_state = "that"
	flags_inv = 0
	armor = ARMOR_VALUE_HEAVY
	strip_delay = 80

/obj/item/clothing/head/powdered_wig
	name = "powdered wig"
	desc = "A powdered wig."
	icon_state = "pwig"
	item_state = "pwig"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/that
	name = "top-hat"
	desc = "It's an amish looking hat."
	icon_state = "tophat"
	item_state = "that"
	throwforce = 1
	dog_fashion = /datum/dog_fashion/head
	beepsky_fashion = /datum/beepsky_fashion/tophat
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/canada
	name = "striped red tophat"
	desc = "It smells like fresh donut holes. / <i>Il sent comme des trous de beignets frais.</i>"
	icon_state = "canada"
	item_state = "canada"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/redcoat
	name = "redcoat's hat"
	icon_state = "redcoat"
	desc = "<i>'I guess it's a redhead.'</i>"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/mailman
	name = "mailman's hat"
	icon_state = "mailman"
	desc = "<i>'Right-on-time'</i> mail service head wear."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/plaguedoctorhat
	name = "plague doctor's hat"
	desc = "These were once used by plague doctors. They're pretty much useless."
	icon_state = "plaguedoctor"
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T3)
	permeability_coefficient = 0.01
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/hasturhood
	name = "hastur's hood"
	desc = "It's <i>unspeakably</i> stylish."
	icon_state = "hasturhood"
	flags_inv = HIDEHAIR
	flags_cover = HEADCOVERSEYES
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/nursehat
	name = "nurse's hat"
	desc = "It allows quick identification of trained medical personnel."
	icon_state = "nursehat"
	dynamic_hair_suffix = ""
	armor = ARMOR_VALUE_CLOTHES
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)
	dog_fashion = /datum/dog_fashion/head/nurse
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/syndicatefake
	name = "black space-helmet replica"
	icon_state = "syndicate-helm-black-red"
	item_state = "syndicate-helm-black-red"
	desc = "A plastic replica of a Syndicate agent's space helmet. You'll look just like a real murderous Syndicate agent in this! This is a toy, it is not made for use in space!"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	mutantrace_variation = STYLE_MUZZLE
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/cueball
	name = "cueball helmet"
	desc = "A large, featureless white orb meant to be worn on your head. How do you even see out of this thing?"
	icon_state = "cueball"
	item_state="cueball"
	flags_cover = HEADCOVERSEYES|HEADCOVERSMOUTH
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/snowman
	name = "Snowman Head"
	desc = "A ball of white styrofoam. So festive."
	icon_state = "snowman_h"
	item_state = "snowman_h"
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/justice
	name = "justice hat"
	desc = "Fight for what's righteous!"
	icon_state = "justicered"
	item_state = "justicered"
	flags_inv = HIDEHAIR|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/justice/blue
	icon_state = "justiceblue"
	item_state = "justiceblue"

/obj/item/clothing/head/justice/yellow
	icon_state = "justiceyellow"
	item_state = "justiceyellow"

/obj/item/clothing/head/justice/green
	icon_state = "justicegreen"
	item_state = "justicegreen"

/obj/item/clothing/head/justice/pink
	icon_state = "justicepink"
	item_state = "justicepink"

/obj/item/clothing/head/rabbitears
	name = "rabbit ears"
	desc = "Wearing these makes you look useless, and only good for your sex appeal."
	icon_state = "bunny"
	dynamic_hair_suffix = ""
	dog_fashion = /datum/dog_fashion/head/rabbit
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/flatcap
	name = "flat cap"
	desc = "A working man's cap."
	icon_state = "flat_cap"
	item_state = "detective"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/pirate
	name = "pirate hat"
	desc = "Yarr."
	icon_state = "pirate"
	item_state = "pirate"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

	dog_fashion = /datum/dog_fashion/head/pirate
	beepsky_fashion = /datum/beepsky_fashion/pirate

/obj/item/clothing/head/pirate/captain
	name = "pirate captain hat"
	icon_state = "hgpiratecap"
	item_state = "hgpiratecap"

/obj/item/clothing/head/bandana
	name = "pirate bandana"
	desc = "Yarr."
	icon_state = "bandana"
	item_state = "bandana"
	dynamic_hair_suffix = ""

/obj/item/clothing/head/bowler
	name = "bowler-hat"
	desc = "Gentleman, elite aboard!"
	icon_state = "bowler"
	item_state = "bowler"
	dynamic_hair_suffix = ""
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/witchwig
	name = "witch costume wig"
	desc = "Eeeee~heheheheheheh!"
	icon_state = "witch"
	item_state = "witch"
	flags_inv = HIDEHAIR
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/chicken
	name = "chicken suit head"
	desc = "Bkaw!"
	icon_state = "chickenhead"
	item_state = "chickensuit"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/griffin
	name = "griffon head"
	desc = "Why not 'eagle head'? Who knows."
	icon_state = "griffinhat"
	item_state = "griffinhat"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/bearpelt
	name = "bear pelt hat"
	desc = "Fuzzy."
	icon_state = "bearpelt"
	item_state = "bearpelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/xenos
	name = "xenos helmet"
	icon_state = "xenos"
	item_state = "xenos_helm"
	desc = "A helmet made out of chitinous alien hide."
	alternate_screams = list('sound/voice/hiss6.ogg')
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/fedora
	name = "fedora"
	icon_state = "fedora"
	item_state = "fedora"
	desc = "A really cool hat if you're a mobster. A really lame hat if you're not."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

	beepsky_fashion = /datum/beepsky_fashion/fedora

/obj/item/clothing/head/sombrero
	name = "sombrero"
	icon_state = "sombrero"
	item_state = "sombrero"
	desc = "Bury me con mi sombrero."
	flags_inv = HIDEHAIR
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

	dog_fashion = /datum/dog_fashion/head/sombrero
	beepsky_fashion = /datum/beepsky_fashion/sombrero

/obj/item/clothing/head/sombrero/green
	name = "green sombrero"
	icon_state = "greensombrero"
	item_state = "greensombrero"
	desc = "As elegant as a dancing cactus."
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

	dog_fashion = null

/obj/item/clothing/head/sombrero/shamebrero
	name = "shamebrero"
	icon_state = "shamebrero"
	item_state = "shamebrero"
	desc = "Once it's on, it never comes off."

	dog_fashion = null

/obj/item/clothing/head/sombrero/shamebrero/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SHAMEBRERO_TRAIT)

/obj/item/clothing/head/cone
	desc = "You can leave your friends behind."
	name = "safety cone"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "cone"
	item_state = "cone"
	force = 1
	throwforce = 3
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("warned", "cautioned", "smashed")
	resistance_flags = NONE
	dynamic_hair_suffix = ""
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/santa
	name = "santa hat"
	desc = "On the first day of christmas my employer gave to me!"
	icon_state = "santahatnorm"
	item_state = "that"
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

	dog_fashion = /datum/dog_fashion/head/santa
	beepsky_fashion = /datum/beepsky_fashion/santa

/obj/item/clothing/head/jester
	name = "jester hat"
	desc = "A hat with bells, to add some merriness to the suit."
	icon_state = "jester_hat"
	dynamic_hair_suffix = ""
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/rice_hat
	name = "rice hat"
	desc = "Welcome to the rice fields, motherfucker."
	icon_state = "rice_hat"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/lizard
	name = "lizardskin cloche hat"
	desc = "How many lizards died to make this hat? Not enough."
	icon_state = "lizard"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/papersack
	name = "paper sack hat"
	desc = "A paper sack with crude holes cut out for eyes. Useful for hiding one's identity or ugliness."
	icon_state = "papersack"
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS|HIDESNOUT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/papersack/smiley
	name = "paper sack hat"
	desc = "A paper sack with crude holes cut out for eyes and a sketchy smile drawn on the front. Not creepy at all."
	icon_state = "papersack_smile"
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS|HIDESNOUT

/obj/item/clothing/head/crown
	name = "crown"
	desc = "A crown fit for a king, a petty king maybe."
	icon_state = "crown"
	armor = ARMOR_VALUE_LIGHT
	resistance_flags = FIRE_PROOF
	dynamic_hair_suffix = ""
	beepsky_fashion = /datum/beepsky_fashion/king

/obj/item/clothing/head/crown/fancy
	name = "magnificent crown"
	desc = "A crown worn by only the highest emperors of the <s>land</s> space."
	icon_state = "fancycrown"

/obj/item/clothing/head/scarecrow_hat
	name = "scarecrow hat"
	desc = "A simple straw hat."
	icon_state = "scarecrow_hat"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/lobsterhat
	name = "foam lobster head"
	desc = "When everything's going to crab, protecting your head is the best choice."
	icon_state = "lobster_hat"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/drfreezehat
	name = "doctor freeze's wig"
	desc = "A cool wig for cool people."
	icon_state = "drfreeze_hat"
	flags_inv = HIDEHAIR
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/pharaoh
	name = "pharaoh hat"
	desc = "Walk like an Egyptian."
	icon_state = "pharaoh_hat"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/jester/alt
	name = "jester hat"
	desc = "A hat with bells, to add some merriness to the suit."
	icon_state = "jester2"
	dynamic_hair_suffix = ""
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/nemes
	name = "headdress of Nemes"
	desc = "Lavish space tomb not included."
	icon_state = "nemes_headdress"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/frenchberet
	name = "french beret"
	desc = "A quality beret, infused with the aroma of chain-smoking, wine-swilling Parisians. You feel less inclined to engage military conflict, for some reason."
	icon_state = "beretblack"
	dynamic_hair_suffix = ""
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/frenchberet/equipped(mob/M, slot)
	. = ..()
	if (slot == SLOT_HEAD)
		RegisterSignal(M, COMSIG_MOB_SAY,PROC_REF(handle_speech))
	else
		UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/frenchberet/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/frenchberet/proc/handle_speech(datum/source, mob/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = " [message]"
		var/list/french_words = strings("french_replacement.json", "french")

		for(var/key in french_words)
			var/value = french_words[key]
			if(islist(value))
				value = pick(value)

			message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
			message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
			message = replacetextEx(message, " [key]", " [value]")

		if(prob(3))
			message += pick(" Honh honh honh!"," Honh!"," Zut Alors!")
	speech_args[SPEECH_MESSAGE] = trim(message)

/obj/item/clothing/head/assu_helmet
	name = "DAB helmet"
	icon_state = "assu_helmet"
	item_state = "assu_helmet"
	desc = "A cheap replica of old riot helmet without visor. It has \"D.A.B.\" written on the front."
	flags_inv = HIDEHAIR
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/hotel
	name = "Telegram cap"
	desc = "A bright red cap warn by hotel staff. Or people who want to be a singing telegram"
	icon_state = "telegram"
	dog_fashion = /datum/dog_fashion/head/telegram
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/christmashat
	name = "red santa hat"
	desc = "A red Christmas Hat! How festive!"
	icon_state = "christmashat"
	item_state = "christmashat"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/christmashatg
	name = "green santa hat"
	desc = "A green Christmas Hat! How festive!"
	icon_state = "christmashatg"
	item_state = "christmashatg"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/cowboyhat
	name = "cowboy hat"
	desc = "A standard brown cowboy hat, yeehaw."
	icon_state = "cowboyhat"
	item_state = "cowboyhat"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

	beepsky_fashion = /datum/beepsky_fashion/cowboy

/obj/item/clothing/head/cowboyhat/black
	name = "black cowboy hat"
	desc = "A a black cowboy hat, perfect for any outlaw"
	icon_state = "cowboyhat_black"
	item_state= "cowboyhat_black"

/obj/item/clothing/head/cowboyhat/white
	name = "white cowboy hat"
	desc = "A white cowboy hat, perfect for your every day rancher"
	icon_state = "cowboyhat_white"
	item_state= "cowboyhat_white"

/obj/item/clothing/head/cowboyhat/pink
	name = "pink cowboy hat"
	desc = "A pink cowboy? more like cowgirl hat, just don't be a buckle bunny."
	icon_state = "cowboyhat_pink"
	item_state= "cowboyhat_pink"

/obj/item/clothing/head/cowboyhat/sec
	name = "security cowboy hat"
	desc = "A security cowboy hat, perfect for any true lawman"
	icon_state = "cowboyhat_sec"
	item_state= "cowboyhat_sec"

/obj/item/clothing/head/squatter_hat
	name = "slav squatter hat"
	icon_state = "squatter_hat"
	item_state = "squatter_hat"
	desc = "Cyka blyat."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/russobluecamohat
	name = "russian blue camo beret"
	desc = "A symbol of discipline, honor, and lots and lots of removal of some type of skewered food."
	icon_state = "russobluecamohat"
	item_state = "russobluecamohat"
	dynamic_hair_suffix = ""
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/hunter
	name = "bounty hunting hat"
	desc = "Ain't nobody gonna cheat the hangman in my town."
	icon_state = "hunter"
	item_state = "hunter"
	armor = ARMOR_VALUE_LIGHT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/kepi
	name = "kepi"
	desc = "A white cap with visor. Oui oui, mon capitane!"
	armor = ARMOR_VALUE_LIGHT
	icon_state = "kepi"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/kepi/old
	icon_state = "kepi_old"
	desc = "A flat, white circular cap with a visor. It demands some honor from its wearer."

/obj/item/clothing/head/maid
	name = "maid headband"
	desc = "Maid in the USA!"
	icon_state = "maid"
	item_state = "maid"
	dynamic_hair_suffix = ""
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/widered
	name = "Wide red hat"
	desc = "It is both wide, and red. Stylish!"
	icon_state = "widehat_red"
	item_state = "widehat_red"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/kabuto
	name = "Kabuto helmet"
	desc = "A traditional kabuto helmet."
	icon_state = "kabuto"
	item_state = "kabuto"
	flags_inv = HIDEHAIR|HIDEEARS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/fluff/bandit
	name = "bandit hat"
	desc = "A black cowboy hat with a large brim, curved to the sides, and a silver eagle pinned to the front."
	icon_state = "bandit"
	item_state = "fedora"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/fluff/gambler
	name = "gambler hat"
	desc = "Perfect for a ramblin' gamblin' man." //But I got to ramble (ramblin' man) //Oh I got to gamble (gamblin' man) //Got to got to ramble (ramblin' man) //I was born a ramblin' gamblin' man
	icon_state = "gambler"
	item_state = "dethat"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/fluff/Bikerhelmet
	name = "Future Helmet"
	desc = "A helmet of some sort as if from the distant future."
	icon_state = "biker_helmet"
	item_state = "biker_helmet"
	resistance_flags = FIRE_PROOF
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/rainbowbunchcrown
	name = "rainbow flower crown"
	desc = "A flower crown made out of the flowers of the rainbow bunch plant."
	dynamic_hair_suffix = ""
	attack_verb = list("crowned")
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/rainbowbunchcrown/Initialize()
	. = ..()
	var/crown_type = rand(1,4)
	switch(crown_type)
		if(1)
			desc += " This one has red, yellow and white flowers."
			icon_state = "rainbow_bunch_crown_1"
		if(2)
			desc += " This one has blue, yellow, green and white flowers."
			icon_state = "rainbow_bunch_crown_2"
		if(3)
			desc += " This one has red, blue, purple and pink flowers."
			icon_state = "rainbow_bunch_crown_3"
		if(4)
			desc += " This one has yellow, green and white flowers."
			icon_state = "rainbow_bunch_crown_4"

/obj/item/clothing/head/sunflowercrown
	name = "sunflower crown"
	desc = "A bright flower crown made out sunflowers that is sure to brighten up anyone's day!"
	icon_state = "sunflower_crown"
	dynamic_hair_suffix = ""
	attack_verb = list("crowned")
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/poppycrown
	name = "poppy crown"
	desc = "A flower crown made out of a string of bright red poppies."
	icon_state = "poppy_crown"
	dynamic_hair_suffix = ""
	attack_verb = list("crowned")

/obj/item/clothing/head/lilycrown
	name = "lily crown"
	desc = "A leafy flower crown with a cluster of large white lilies at at the front."
	icon_state = "lily_crown"
	dynamic_hair_suffix = ""
	attack_verb = list("crowned")
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/mk2/one
	name = "MK2 helment"
	desc = "The mk2 helmet commonly refered as the brodie due to its inventor Latvian inventor John Leopold Brodie, it was commonly used by Commonwealth nations, its also refered as the battle bowler.."
	icon_state = "mk2_nettan_1"
	item_state= "mk2_nettan_1"

/obj/item/clothing/head/mk2/two
	name = "MK2 helment"
	desc = "The mk2 helmet commonly refered as the brodie due to its inventor Latvian inventor John Leopold Brodie, it was commonly used by Commonwealth nations, its also refered as the battle bowler.."
	icon_state = "mk2_nettan_2"
	item_state= "mk2_nettan_2"

/obj/item/clothing/head/mk2/four
	name = "MK2 helment"
	desc = "The mk2 helmet commonly refered as the brodie due to its inventor Latvian inventor John Leopold Brodie, it was commonly used by Commonwealth nations, its also refered as the battle bowler.."
	icon_state = "mk2_nettan_4"
	item_state= "mk2_nettan_4"

/obj/item/clothing/head/mk2/two
	name = "MK2 helment"
	desc = "The mk2 helmet commonly refered as the brodie due to its inventor Latvian inventor John Leopold Brodie, it was commonly used by Commonwealth nations, its also refered as the battle bowler.."
	icon_state = "mk2_nettan_2"
	item_state= "mk2_nettan_2"

/obj/item/clothing/head/mk2/two
	name = "MK2 helment"
	desc = "The mk2 helmet commonly refered as the brodie due to its inventor Latvian inventor John Leopold Brodie, it was commonly used by Commonwealth nations, its also refered as the battle bowler.."
	icon_state = "mk2_nettan_2"
	item_state= "mk2_nettan_2"

/obj/item/clothing/head/military_turban
	name = "Military Turban"
	desc = "A Military green Turban used by pre war Raj recently freed of its British overlords."
	icon_state = "turban_mil"
	item_state = "turban_mil"

/obj/item/clothing/head/burma/cowboy/black
	name = "Burma Cowboy hat, black"
	desc = "A wide brimmed hat in an aussie style brim more common around the wastes now a days being an easily replicate able style of fur felt hat. This one is a dark colour,...some what stupid if your trying to get heat away from you..."
	icon_state = "burma_cowboy_black"
	item_state = "burma_cowboy_black"

/obj/item/clothing/head/burma/cowboy/black/ribbon
	name = "Burma Cowboy hat, black with ribbon"
	desc = "A wide brimmed hat in an aussie style brim more common around the wastes now a days being an easily replicate able style of fur felt hat. This one is a dark colour,...some what stupid if your trying to get heat away from you..."
	icon_state = "burma_cowboy_black_ribbon"
	item_state = "burma_cowboy_black_ribon"

/obj/item/clothing/head/burma/cowboy/brown
	name = "Burma Cowboy hat, brown"
	desc = "A wide brimmed hat in an aussie style brim more common around the wastes now a days being an easily replicate able style of fur felt hat."
	icon_state = "burma_cowboy_brown"
	item_state = "burma_cowboy_brown"

/obj/item/clothing/head/burma/pith
	name = "Pith"
	desc = "A lightweight sun helmet with a puggaree hat band, commonly worn by imperalists. Some post war gangs and Nations have adopted this style of hat, all though some noticeably different shapes but still its a useful garment."
	icon_state = "pith_burma"
	item_state = "pith_burma"

/obj/item/clothing/head/burma/glengarry
	name = "Glengarry"
	desc = "A woolen Scottish military hat, with a plaid pattern and tails that come off it. Notably in the pre war this was used by several different specific bagpipe regiments of Commonwealth nations..And was used primarly by the british for its scottish brigades."
	icon_state = "glengarry"
	item_state = "glengarry"

/obj/item/clothing/head/fifi
	name = "fifi"
	desc = "A colorful firlly hat"
	icon_state = "fifi_hat"
	item_state = "fifi_hat"

/obj/item/clothing/head/croc_hat
	name = "Croc teeth lined hat"
	desc = "A black hat with sharp looking teeth. Crikey!"
	icon_state = "croc_hat"
	item_state = "croc_hat"

/obj/item/clothing/head/pinched_cowboy
	name = "Pinched Cowboy"
	desc = "A brown felt cowboy hat with a pinched look in the middle. Snazy."
	icon_state = "pinched_cowboy"
	item_state = "pinched_cowboy"

/obj/item/clothing/head/floppy_hat
	name = "floppy bush hat"
	desc = "commonly used by military forces in hot tropical climates. Its design is similar to a bucket hat but with a stiffer brim"
	icon_state = "giggle_hat"
	item_state = "giggle_hat"

/obj/item/clothing/head/japan_cap
	name = "green floppy cap"
	desc = "A pre war japanese cap used for soldiers in the Japanese defense force for pacific and jungle combat."
	icon_state = "japan_cap"
	item_state = "japan_cap"
/*
/obj/item/clothing/head/tribal_helmant
	name = "tribal helmet"
	desc = "A helmet, for tribals! Probably."
	icon_state = "tribal_helmant"
	item_state = "tribal_helmant"
*/
/obj/item/clothing/head/adrian
	name = "adrian helmet"
	desc = "A helmet, amazing!"
	icon_state = "adrian"
	item_state = "adrian"

/obj/item/clothing/head/mk2_nettan_5
	name = "Nettan Helmet"
	desc = "A helmet, amazing!"
	icon_state = "mk2_nettan_5"
	item_state = "mk2_nettan_5"

/obj/item/clothing/head/m1_standard
	name = "Standard Helmet"
	desc = "A helmet, amazing!"
	icon_state = "m1_standard"
	item_state = "m1_standard"

//Wizard/Witch hats from Paradise

/obj/item/clothing/head/good_witch
	name = "good witch"
	desc = "A yellow witch hat"
	icon_state = "good_witch"
	item_state = "good_witch"

/obj/item/clothing/head/dark_witch
	name = "dark witch"
	desc = "A black witch hat"
	icon_state = "dark_witch"
	item_state = "dark_witch"

/obj/item/clothing/head/classic_witch
	name = "classic witch"
	desc = "A classic witch hat"
	icon_state = "classic_witch"
	item_state = "classic_witch"

/obj/item/clothing/head/healer_witch
	name = "healer witch"
	desc = "A light blue witch hat"
	icon_state = "healer_witch"
	item_state = "healer_witch"

/obj/item/clothing/head/cutie_witch
	name = "cute witch"
	desc = "A cute witch hat"
	icon_state = "cutie_witch"
	item_state = "cutie_witch"

/obj/item/clothing/head/shy_witch
	name = "shy witch"
	desc = "A cute witch hat"
	icon_state = "shy_witch"
	item_state = "shy_witch"

/obj/item/clothing/head/sexy_witch
	name = "sexy witch hat"
	desc = "A witch hat"
	icon_state = "sexy_witch"
	item_state = "sexy_witch"

/obj/item/clothing/head/bunny_witch
	name = "bunny witch hat"
	desc = "A witch hat"
	icon_state = "bunny_witch"
	item_state = "bunny_witch"

/obj/item/clothing/head/potions_witch
	name = "potions witch hat"
	desc = "A witch hat"
	icon_state = "potions_witch"
	item_state = "potions_witch"

/obj/item/clothing/head/syndie_witch
	name = "syndie witch hat"
	desc = "A witch hat"
	icon_state = "syndie_witch"
	item_state = "syndie_witch"

/obj/item/clothing/head/nt_witch
	name = "blue witch hat"
	desc = "A witch hat"
	icon_state = "nt_witch"
	item_state = "nt_witch"

/obj/item/clothing/head/hoodcowl
	name = "Hood cowl"
	desc = "A dirty, worn-down rag with crudely cut-out eyeholes that barely qualifies as clothing."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "hoodcowl"
	item_state = "hoodcowl"
	flags_inv = HIDEHAIR
	dynamic_hair_suffix = ""

/obj/item/clothing/head/canadian
	name = "canadian mounty hat"
	desc = "smells like maple syrup"
	icon_state = "canadian"
	item_state = "canadian"

/obj/item/clothing/head/ncr_ranger
	name = "ncr ranger helmet"
	desc = "Is a helmet. Yep."
	icon_state = "ncr_ranger"
	item_state = "ncr_ranger"
