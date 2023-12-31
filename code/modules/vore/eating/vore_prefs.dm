
/*
 * VVVVVVVV           VVVVVVVV      OOOOOOOOO       RRRRRRRRRRRRRRRRR     EEEEEEEEEEEEEEEEEEEEEE
 * V::::::V           V::::::V    OO:::::::::OO     R::::::::::::::::R    E::::::::::::::::::::E
 * V::::::V           V::::::V  OO:::::::::::::OO   R::::::RRRRRR:::::R   E::::::::::::::::::::E
 * V::::::V           V::::::V O:::::::OOO:::::::O  RR:::::R     R:::::R  EE::::::EEEEEEEEE::::E
 *  V:::::V           V:::::V  O::::::O   O::::::O    R::::R     R:::::R    E:::::E       EEEEEE
 *   V:::::V         V:::::V   O:::::O     O:::::O    R::::R     R:::::R    E:::::E
 *    V:::::V       V:::::V    O:::::O     O:::::O    R::::RRRRRR:::::R     E::::::EEEEEEEEEE
 *     V:::::V     V:::::V     O:::::O     O:::::O    R:::::::::::::RR      E:::::::::::::::E
 *      V:::::V   V:::::V      O:::::O     O:::::O    R::::RRRRRR:::::R     E:::::::::::::::E
 *       V:::::V V:::::V       O:::::O     O:::::O    R::::R     R:::::R    E::::::EEEEEEEEEE
 *        V:::::V:::::V        O:::::O     O:::::O    R::::R     R:::::R    E:::::E
 *         V:::::::::V         O::::::O   O::::::O    R::::R     R:::::R    E:::::E       EEEEEE
 *          V:::::::V          O:::::::OOO:::::::O  RR:::::R     R:::::R  EE::::::EEEEEEEE:::::E
 *           V:::::V            OO:::::::::::::OO   R::::::R     R:::::R  E::::::::::::::::::::E
 *            V:::V               OO:::::::::OO     R::::::R     R:::::R  E::::::::::::::::::::E
 *             VVV                  OOOOOOOOO       RRRRRRRR     RRRRRRR  EEEEEEEEEEEEEEEEEEEEEE
 * 
 * -Aro <3 
 * <3 Aro -lagg 
 * (mostly just ported this file for the text art)
 */

#define VORE_VERSION	2	//This is a Define so you don't have to worry about magic numbers.


/datum/preferences
	/// The master list of bellies to give the mob
	var/list/belly_prefs = list()
	/// currently unused, we have a whole 'nother taste system that rules =3
	//var/vore_taste = "nothing in particular"
	/// to be moved to a better method
	var/vore_smell = "nothing in particular"
	//Actual preferences
	var/allow_dogborgs = TRUE
	var/allow_eating_sounds = TRUE
	var/allow_digestion_sounds = FALSE
	var/allow_digestion_damage = FALSE
	var/allow_digestion_death = FALSE
	var/allow_absorbtion = TRUE
	var/allow_healbelly_healing = TRUE
	var/allow_vore_messages = TRUE
	var/allow_death_messages = FALSE
	var/allow_being_prey = TRUE
	var/allow_being_fed_to_others = TRUE
	var/allow_being_fed_prey = TRUE
	var/allow_seeing_belly_descriptions = TRUE
	var/allow_being_sniffed = TRUE
	var/allow_trash_messages = FALSE
	//Save us the trouble of reloading the preferences menu 15 times when someone turns all
	//of the vore shit on one at a time by just having most of them start on and the master off
	var/master_vore_toggle = FALSE


	// These are 'modifier' prefs, do nothing on their own but pair with drop_prey/drop_pred settings.
	// they are also not implemented yet! =3 -lagg
	// var/drop_vore = TRUE
	// var/stumble_vore = TRUE
	// var/slip_vore = TRUE
	// var/throw_vore = TRUE

	// var/resizable = TRUE
	// var/show_vore_fx = TRUE
	// var/step_mechanics_pref = FALSE
	// var/pickup_pref = TRUE

	// var/appendage_color = "#e03997" //Default pink. Used for the 'long_vore' trait.
	// var/appendage_alt_setting = 0	//Decides if appendage user is thrown at target or not.

	// var/selective_preference = DM_DEFAULT


	// var/nutrition_message_visible = TRUE
	// var/list/nutrition_messages = list(
	// 						"They are starving! You can hear their stomach snarling from across the room!",
	// 						"They are extremely hungry. A deep growl occasionally rumbles from their empty stomach.",
	// 						"",
	// 						"They have a stuffed belly, bloated fat and round from eating too much.",
	// 						"They have a rotund, thick gut. It bulges from their body obscenely, close to sagging under its own weight.",
	// 						"They are sporting a large, round, sagging stomach. It contains at least their body weight worth of glorping slush.",
	// 						"They are engorged with a huge stomach that sags and wobbles as they move. They must have consumed at least twice their body weight. It looks incredibly soft.",
	// 						"Their stomach is firmly packed with digesting slop. They must have eaten at least a few times worth their body weight! It looks hard for them to stand, and their gut jiggles when they move.",
	// 						"They are so absolutely stuffed that you aren't sure how it's possible for them to move. They can't seem to swell any bigger. The surface of their belly looks sorely strained!",
	// 						"They are utterly filled to the point where it's hard to even imagine them moving, much less comprehend it when they do. Their gut is swollen to monumental sizes and amount of food they consumed must be insane.")
	// var/weight_message_visible = TRUE
	// var/list/weight_messages = list(
	// 						"They are terribly lithe and frail!",
	// 						"They have a very slender frame.",
	// 						"They have a lightweight, athletic build.",
	// 						"They have a healthy, average body.",
	// 						"They have a thick, curvy physique.",
	// 						"They have a plush, chubby figure.",
	// 						"They have an especially plump body with a round potbelly and large hips.",
	// 						"They have a very fat frame with a bulging potbelly, squishy rolls of pudge, very wide hips, and plump set of jiggling thighs.",
	// 						"They are incredibly obese. Their massive potbelly sags over their waistline while their fat ass would probably require two chairs to sit down comfortably!",
	// 						"They are so morbidly obese, you wonder how they can even stand, let alone waddle around the station. They can't get any fatter without being immobilized.")

// lagg note-- couldnt get it to work immediately, so away it goes

//
// Save/Load Vore Preferences
//
// /datum/vore_preferences/proc/load_path(ckey, slot, filename="character", ext="json")
// 	if(!ckey || !slot)
// 		return
// 	path = "data/player_saves/[copytext(ckey,1,2)]/[ckey]/vore/[filename][slot].[ext]"


// /datum/vore_preferences/proc/load_vore()
// 	if(!client || !client_ckey)
// 		return FALSE //No client, how can we save?
// 	if(!client.prefs || !client.prefs.default_slot)
// 		return FALSE //Need to know what character to load!

// 	slot = client.prefs.default_slot

// 	load_path(client_ckey,slot)

// 	if(!path)
// 		return FALSE //Path couldn't be set?
// 	if(!fexists(path)) //Never saved before
// 		save_vore() //Make the file first
// 		return TRUE

// 	var/list/json_from_file = json_decode(file2text(path))
// 	if(!json_from_file)
// 		return FALSE //My concern grows

// 	var/version = json_from_file["version"]
// 	json_from_file = patch_version(json_from_file,version)

// 	// digestable = json_from_file["digestable"]
// 	// devourable = json_from_file["devourable"]
// 	// resizable = json_from_file["resizable"]
// 	// feeding = json_from_file["feeding"]
// 	// absorbable = json_from_file["absorbable"]
// 	// digest_leave_remains = json_from_file["digest_leave_remains"]
// 	// allowmobvore = json_from_file["allowmobvore"]
// 	// vore_taste = json_from_file["vore_taste"]
// 	// vore_smell = json_from_file["vore_smell"]
// 	// permit_healbelly = json_from_file["permit_healbelly"]
// 	// noisy = json_from_file["noisy"]
// 	// appendage_color = json_from_file["appendage_color"]
// 	// appendage_alt_setting = json_from_file["appendage_alt_setting"]
// 	// selective_preference = json_from_file["selective_preference"]
// 	// show_vore_fx = json_from_file["show_vore_fx"]
// 	// can_be_drop_prey = json_from_file["can_be_drop_prey"]
// 	// can_be_drop_pred = json_from_file["can_be_drop_pred"]
// 	// allow_inbelly_spawning = json_from_file["allow_inbelly_spawning"]
// 	// allow_spontaneous_tf = json_from_file["allow_spontaneous_tf"]
// 	// step_mechanics_pref = json_from_file["step_mechanics_pref"]
// 	// pickup_pref = json_from_file["pickup_pref"]
// 	// belly_prefs = json_from_file["belly_prefs"]
// 	// drop_vore = json_from_file["drop_vore"]
// 	// slip_vore = json_from_file["slip_vore"]
// 	// throw_vore = json_from_file["throw_vore"]
// 	// stumble_vore = json_from_file["stumble_vore"]
// 	// nutrition_message_visible = json_from_file["nutrition_message_visible"]
// 	// nutrition_messages = json_from_file["nutrition_messages"]
// 	// weight_message_visible = json_from_file["weight_message_visible"]

// 	allow_dogborgs = json_from_file["allow_dogborgs"]
// 	allow_eating_sounds = json_from_file["allow_eating_sounds"]
// 	allow_digestion_sounds = json_from_file["allow_digestion_sounds"]
// 	allow_digestion_damage = json_from_file["allow_digestion_damage"]
// 	allow_digestion_death = json_from_file["allow_digestion_death"]
// 	allow_absorbtion = json_from_file["allow_absorbtion"]
// 	allow_healbelly_healing = json_from_file["allow_healbelly_healing"]
// 	allow_vore_messages = json_from_file["allow_vore_messages"]
// 	allow_death_messages = json_from_file["allow_death_messages"]
// 	allow_being_prey = json_from_file["allow_being_prey"]
// 	allow_being_fed_to_others = json_from_file["allow_being_fed_to_others"]
// 	allow_being_fed_prey = json_from_file["allow_being_fed_prey"]
// 	allow_seeing_belly_descriptions = json_from_file["allow_seeing_belly_descriptions"]
// 	allow_being_sniffed = json_from_file["allow_being_sniffed"]

// 	//Quick sanitize
// 	if(isnull(allow_dogborgs))
// 		allow_dogborgs = TRUE
// 	if(isnull(allow_eating_sounds))
// 		allow_eating_sounds = TRUE
// 	if(isnull(allow_digestion_sounds))
// 		allow_digestion_sounds = TRUE
// 	if(isnull(allow_digestion_death))
// 		allow_digestion_death = TRUE
// 	if(isnull(allow_absorbtion))
// 		allow_absorbtion = TRUE
// 	if(isnull(allow_healbelly_healing))
// 		allow_healbelly_healing = TRUE
// 	if(isnull(allow_vore_messages))
// 		allow_vore_messages = TRUE
// 	if(isnull(allow_death_messages))
// 		allow_death_messages = TRUE
// 	if(isnull(allow_being_fed_to_others))
// 		allow_being_fed_to_others = TRUE
// 	if(isnull(allow_being_fed_prey))
// 		allow_being_fed_prey = TRUE
// 	if(isnull(allow_seeing_belly_descriptions))
// 		allow_seeing_belly_descriptions = TRUE
// 	if(isnull(allow_being_sniffed))
// 		allow_being_sniffed = TRUE

// 	////// I feel like these'll be useful later
// 	// if(isnull(devourable))
// 	// 	devourable = TRUE
// 	// if(isnull(resizable))
// 	// 	resizable = TRUE
// 	// if(isnull(feeding))
// 	// 	feeding = TRUE
// 	// if(isnull(absorbable))
// 	// 	absorbable = TRUE
// 	// if(isnull(digest_leave_remains))
// 	// 	digest_leave_remains = FALSE
// 	// if(isnull(allowmobvore))
// 	// 	allowmobvore = TRUE
// 	// if(isnull(permit_healbelly))
// 	// 	permit_healbelly = TRUE
// 	// if(isnull(selective_preference))
// 	// 	selective_preference = DM_DEFAULT
// 	// if (isnull(noisy))
// 	// 	noisy = FALSE
// 	// if (isnull(appendage_color))
// 	// 	appendage_color = "#e03997"
// 	// if (isnull(appendage_alt_setting))
// 	// 	appendage_alt_setting = 0
// 	// if(isnull(show_vore_fx))
// 	// 	show_vore_fx = TRUE
// 	// if(isnull(can_be_drop_prey))
// 	// 	can_be_drop_prey = FALSE
// 	// if(isnull(can_be_drop_pred))
// 	// 	can_be_drop_pred = FALSE
// 	// if(isnull(allow_inbelly_spawning))
// 	// 	allow_inbelly_spawning = FALSE
// 	// if(isnull(allow_spontaneous_tf))
// 	// 	allow_spontaneous_tf = FALSE
// 	// if(isnull(step_mechanics_pref))
// 	// 	step_mechanics_pref = TRUE
// 	// if(isnull(pickup_pref))
// 	// 	pickup_pref = TRUE
// 	// if(isnull(belly_prefs))
// 	// 	belly_prefs = list()
// 	// if(isnull(drop_vore))
// 	// 	drop_vore = TRUE
// 	// if(isnull(slip_vore))
// 	// 	slip_vore = TRUE
// 	// if(isnull(throw_vore))
// 	// 	throw_vore = TRUE
// 	// if(isnull(stumble_vore))
// 	// 	stumble_vore = TRUE
// 	// if(isnull(nutrition_message_visible))
// 	// 	nutrition_message_visible = TRUE
// 	// if(isnull(weight_message_visible))
// 	// 	weight_message_visible = TRUE
// 	// if(isnull(nutrition_messages))
// 	// 	nutrition_messages = list(
// 	// 						"They are starving! You can hear their stomach snarling from across the room!",
// 	// 						"They are extremely hungry. A deep growl occasionally rumbles from their empty stomach.",
// 	// 						"",
// 	// 						"They have a stuffed belly, bloated fat and round from eating too much.",
// 	// 						"They have a rotund, thick gut. It bulges from their body obscenely, close to sagging under its own weight.",
// 	// 						"They are sporting a large, round, sagging stomach. It contains at least their body weight worth of glorping slush.",
// 	// 						"They are engorged with a huge stomach that sags and wobbles as they move. They must have consumed at least twice their body weight. It looks incredibly soft.",
// 	// 						"Their stomach is firmly packed with digesting slop. They must have eaten at least a few times worth their body weight! It looks hard for them to stand, and their gut jiggles when they move.",
// 	// 						"They are so absolutely stuffed that you aren't sure how it's possible for them to move. They can't seem to swell any bigger. The surface of their belly looks sorely strained!",
// 	// 						"They are utterly filled to the point where it's hard to even imagine them moving, much less comprehend it when they do. Their gut is swollen to monumental sizes and amount of food they consumed must be insane.")
// 	// else if(nutrition_messages.len < 10)
// 	// 	while(nutrition_messages.len < 10)
// 	// 		nutrition_messages.Add("")
// 	// if(isnull(weight_messages))
// 	// 	weight_messages = list(
// 	// 						"They are terribly lithe and frail!",
// 	// 						"They have a very slender frame.",
// 	// 						"They have a lightweight, athletic build.",
// 	// 						"They have a healthy, average body.",
// 	// 						"They have a thick, curvy physique.",
// 	// 						"They have a plush, chubby figure.",
// 	// 						"They have an especially plump body with a round potbelly and large hips.",
// 	// 						"They have a very fat frame with a bulging potbelly, squishy rolls of pudge, very wide hips, and plump set of jiggling thighs.",
// 	// 						"They are incredibly obese. Their massive potbelly sags over their waistline while their fat ass would probably require two chairs to sit down comfortably!",
// 	// 						"They are so morbidly obese, you wonder how they can even stand, let alone waddle around the station. They can't get any fatter without being immobilized.")
// 	// else if(weight_messages.len < 10)
// 	// 	while(weight_messages.len < 10)
// 	// 		weight_messages.Add("")

// 	return TRUE

// /datum/vore_preferences/proc/save_vore()
// 	if(!path)
// 		return FALSE
// 	if(world.time < savecharcooldown)
// 		return FALSE
// 	savecharcooldown = world.time + PREF_SAVELOAD_COOLDOWN
// 	var/savefile/S = new /savefile(path)
// 	if(!S)
// 		return FALSE
// 	S.cd = "/character[default_slot]"

// 	WRITE_FILE(S["version"]			, SAVEFILE_VERSION_MAX)


// 	var/version = VORE_VERSION	//For "good times" use in the future
// 	var/list/settings_list = list(
// 			"version"					= version,
// 			"allow_dogborgs"			= allow_dogborgs,
// 			"allow_eating_sounds"		= allow_eating_sounds,
// 			"allow_digestion_sounds"	= allow_digestion_sounds,
// 			"allow_digestion_damage"	= allow_digestion_damage,
// 			"allow_digestion_death"		= allow_digestion_death,
// 			"allow_absorbtion"			= allow_absorbtion,
// 			"allow_healbelly_healing"	= allow_healbelly_healing,
// 			"allow_vore_messages"		= allow_vore_messages,
// 			"allow_death_messages"		= allow_death_messages,
// 			"allow_being_prey"			= allow_being_prey,
// 			"allow_being_fed_to_others"	= allow_being_fed_to_others,
// 			"allow_being_fed_prey"		= allow_being_fed_prey,
// 			"allow_seeing_belly_descriptions" = allow_seeing_belly_descriptions,
// 			"allow_being_sniffed"		= allow_being_sniffed,
// 		)

// 	//List to JSON
// 	var/json_to_file = safe_json_encode(settings_list)
// 	if(!json_to_file)
// 		return FALSE

// 	//Write it out
// 	text2file(json_to_file, path)

// 	if(!fexists(path))
// 		return FALSE

// 	return TRUE

// //Can do conversions here
// /datum/vore_preferences/proc/patch_version(list/json_from_file, version)
// 	return json_from_file
