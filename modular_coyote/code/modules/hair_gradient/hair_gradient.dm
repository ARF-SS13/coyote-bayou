// Author: GremlingSS
// Not all of my work, it's porting over vorestation's gradient system into TG and adapting it basically.
// This is gonna be fun, wish me luck!~
//
// Also, as obligated to my coding standards, I must design a shitpost related to the code, but because it's hard to think of a meme
// I'm gonna just pull one out my ass and hope it's funny.

// Globals/helpers/randomness.
GLOBAL_LIST_INIT(hair_gradients, list(
	"None" = "none",
	"Fade (Up)" = "fadeup",
	"Fade (Down)" = "fadedown",
	"Fade Low (Up)" = "fadeup_low",
	"Bottom Flat" = "bottomflat",
	"Fade Low (Down)" = "fadedown_low",
	"Vertical Split" = "vsplit",
	"Reflected" = "reflected",
	"Reflected (Inverted)" = "reflected_inverse",
	"Reflected High" = "reflected_high",
	"Reflected High (Inverted)" = "reflected_inverse_high",
	"Wavy" = "wavy",
	"Striped" = "striped",
	"Reversed Stripe" = "stripedreverse",
	"Squigly" = "squigly",
	"Swayed" = "sinewave",
	"Vertical Swayed" = "sinewavesideways",
	"Mixy" = "dots",
	"Mixy Faded Down" = "fadedowndots",
	"Spots" = "skrell_gradient_spots",
	"Stripey" = "skr_headtail_stripes", //My beloved
	"Horizontal Fading Stripes" = "stripeshorzfade",
	"Horizontal Stripes" = "stripeshorz",
	"Vertical Fading Stripes" = "stripesvertfaded",
	"Vertical Stripes" = "stripesvert",
	"Swirly" = "swirls",
	"Suspect" = "amogus" //ඞ//
	))

/* // Disabled random features from providing random gradients, simply to avoid reloading save file errors.
random_features(intendedspecies, intended_gender)
	. = ..(intendedspecies, intended_gender)
	
	var/grad_color = random_color()

	var/list/output = .

	output += list(
		"grad_color"			= grad_color,
		"grad_style"			= pick(GLOB.hair_gradients))

	return output


randomize_human(mob/living/carbon/human/H)
//	H.dna.features["flavor_text"] = "" // I'm so tempted to put lorem ipsum in the flavor text so freaking badly please someone hold me back god.
	H.dna.features["grad_color"] = random_color()
	H.dna.features["grad_style"] = pick(GLOB.hair_gradients)
	..(H)
*/

/mob/living/carbon/human/proc/change_hair_gradient(var/hair_gradient)
	if(dna.features["grad_style"] == hair_gradient)
		return

	if(!(hair_gradient in GLOB.hair_gradients))
		return

	dna.features["grad_style"] = hair_gradient

	update_hair()
	return 1

// Preferences + save file/copy_to and stuff.
/datum/preferences
	var/list/features_override = list("grad_style" = "None", "grad_color" = "333333")

// Moved this to preferences_savefile.dm as we're having issues with overriding the function I think.
// My speculation is that us trying to open the save file multiple times with multiple users is causing a memory overflow on the server end and refusing to open it
// Though surely it would alteast warn us?? IDK. There's no way to debug this live. That's atleast what I think is happening, as it's strange that it works locally, but not server side.
/*
/datum/preferences/load_character(slot)
	. = ..()
	if(!(. == 1))
		return . // There's an error!!
	
	var/savefile/S = new /savefile(path)
	S.cd = "/character[slot]"

	S["gradient_color"]		>> features_override["grad_color"]
	S["gradient_style"]		>> features_override["grad_style"]

	features_override["grad_color"]		= sanitize_hexcolor(features_override["grad_color"], 6, FALSE, default = COLOR_ALMOST_BLACK)
	features_override["grad_style"]		= sanitize_inlist(features_override["grad_style"], GLOB.hair_gradients, "none")

	return 1


/datum/preferences/save_character()
	. = ..()

	if(!(. == TRUE))
		return . // erroooooooooooorrrrrrrrrrr
	
	var/savefile/S = new /savefile(path)
	if(!S)
		return 0
	
	S.cd = "/character[default_slot]"

	//Character
	WRITE_FILE(S["gradient_color"]			, features_override["grad_color"])
	WRITE_FILE(S["gradient_style"]			, features_override["grad_style"])

	return 1
*/


/datum/preferences/process_link(mob/user, list/href_list)
	switch(href_list["task"])
		if("input")
			switch(href_list["preference"])
				if("grad_color")
					var/new_grad_color = input(user, "Choose your character's fading hair colour:", "Character Preference","#"+features_override["grad_color"]) as color|null
					if(new_grad_color)
						features_override["grad_color"] = sanitize_hexcolor(new_grad_color, 6, default = COLOR_ALMOST_BLACK)

				if("grad_style")
					var/new_grad_style
					new_grad_style = input(user, "Choose your character's hair fade style:", "Character Preference")  as null|anything in GLOB.hair_gradients
					if(new_grad_style)
						features_override["grad_style"] = new_grad_style
				
				if("grad_color_2")
					var/new_grad_color = input(user, "Choose your character's fading hair colour:", "Character Preference","#"+features_override["grad_color_2"]) as color|null
					if(new_grad_color)
						features_override["grad_color_2"] = sanitize_hexcolor(new_grad_color, 6, default = COLOR_ALMOST_BLACK)

				if("grad_style_2")
					var/new_grad_style
					new_grad_style = input(user, "Choose your character's hair fade style:", "Character Preference")  as null|anything in GLOB.hair_gradients
					if(new_grad_style)
						features_override["grad_style_2"] = new_grad_style
				
				if("hair_color_2")
					var/new_color = input(user, "Choose your character's fading hair colour:", "Character Preference","#"+features_override["hair_color_2"]) as color|null
					if(new_color)
						features_override["hair_color_2"] = sanitize_hexcolor(new_color, 6, default = COLOR_ALMOST_BLACK)

				if("hair_style_2")
					var/new_style
					new_style = input(user, "Choose your character's hair fade style:", "Character Preference")  as null|anything in GLOB.hair_styles_list
					if(new_style)
						features_override["hair_style_2"] = new_style
				
				if("previous_hair_style_2")
					features_override["hair_style_2"] = previous_list_item(features_override["hair_style_2"], GLOB.hair_styles_list)
				
				if("next_hair_style_2")
					features_override["hair_style_2"] = next_list_item(features_override["hair_style_2"], GLOB.hair_styles_list)
	..()

/datum/preferences/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, initial_spawn = FALSE)
	features += features_override
	..()
