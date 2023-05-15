/mob/living/simple_animal/pet/catslug
	name = "catslug"
	desc = "A noodley bodied creature with thin arms and legs, and gloomy dark eyes."
	icon_state = "catslug"
	icon_living = "catslug"
	icon_dead = "catslug_dead"
	icon = 'modular_coyote/icons/mob/slugcat.dmi'
	rotate_on_lying = FALSE // plop~

	faction = list("catslug", "neutral")
	mob_armor = ARMOR_VALUE_MEDIUM
	maxHealth = 200
	health = 200
	healable = 1
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2)

	response_help_simple = "hugs"
	response_disarm_simple = "rudely paps"
	response_harm_simple = "punches"
	waddle_amount = 3
	waddle_up_time = 1
	waddle_side_time = 2
	harm_intent_damage = 2
	melee_damage_lower = 2
	melee_damage_upper = 5
	dextrous = TRUE
	dextrous_hud_type = /datum/hud/dextrous/drone
	held_items = list(null, null)
	see_in_dark = 8
	can_ghost_into = TRUE
	head_offset = -9

/mob/living/simple_animal/pet/catslug/proc/catslug_color()
	set name = "Pick Color"
	set category = "IC"
	set desc = "You can set your color!"
	var/newcolor = input(usr, "Choose a color.", "", color) as color|null
	if(newcolor)
		color = newcolor
	update_icon()

/mob/living/simple_animal/pet/catslug/Initialize()
	. = ..()
	verbs += /mob/living/simple_animal/pet/catslug/proc/catslug_color
	add_verb(src, /mob/living/proc/lay_down)

/mob/living/simple_animal/pet/catslug/update_mobility()
	. = ..()
	if(client && stat != DEAD)
		if(!CHECK_MOBILITY(src, MOBILITY_STAND))
			icon_state = "[icon_living]_rest"
			collar_type = "[initial(collar_type)]_rest"
		else
			icon_state = "[icon_living]"
			collar_type = "[initial(collar_type)]"
	regenerate_icons()
/* Slugcat helmet/hat sprites were a bit of a headache so we're not doing it right now : ^ ))))
/mob/living/simple_animal/pet/catslug/proc/apply_overlay(cache_index)
	if((. = overlays[cache_index]))
		add_overlay(.)

/mob/living/simple_animal/pet/catslug/proc/remove_overlay(cache_index)
	var/I = overlays[cache_index]
	if(I)
		cut_overlay(I)
		overlays[cache_index] = null

/mob/living/simple_animal/pet/catslug/update_inv_head()
	remove_overlay(DRONE_HEAD_LAYER)

	if(head)
		if(client && hud_used && hud_used.hud_shown)
			head.screen_loc = ui_drone_head
			client.screen += head
		var/mutable_appearance/head_overlay = head.build_worn_icon(default_layer = DRONE_HEAD_LAYER, default_icon_file = head.icon, override_state = head.icon_state)
		head_overlay.pixel_y += head_offset

		overlays[DRONE_HEAD_LAYER] = head_overlay

	apply_overlay(DRONE_HEAD_LAYER)
*/
//Slugcat OC for thingpony
/mob/living/simple_animal/pet/catslug/meadow
	name = "Meadow"
	desc = "A noodly creature with soft looking fur. This one has orange and black patches upon it's white fur! (OOC notes : Fine with most Rp! No snuff or scat) Ref: https://cdn.discordapp.com/attachments/986783005743923230/1071899061919166624/Meadow.png"
	icon_state = "calicoslug"
	icon_living = "calicoslug"
	icon_dead = "calicoslug_dead"
	gender = "female"

//Slugcat OC for Cosmic
/mob/living/simple_animal/pet/catslug/shroomslug
	name = "Myca Rashee"
	desc = "A slugcat that seems to be idly sitting there their fur seems a bit odd to look at as they give off a odd glow from the mushroom cap on their head. They seem somewhat timid and shy? Their seems to be fungal growths along the blanket of moss on their body..https://media.discordapp.net/attachments/1020998258669129758/1025891405605912626/cosmic_mushroom_cat_1_1.png?width=773&height=805"
	icon_state = "shroomslug"
	icon_living = "shroomslug"
	icon_dead = "shroomslug_dead"
	gender = "plural"
	light_color ="#728FCE"
	light_range = 1.4
	light_power = 4

//Slugcat OC for Gamma
/mob/living/simple_animal/pet/catslug/sunrise
	name = "Falling Sunrise"
	desc = "This somewhat large Scug, standing at about 3'10, is mostly magenta, though his head is covered with a Vulture mask. He is frequently seen around town, or out doing light hunting in the wastes. He is capable of English speech. OOC : ERP Ok, Non-Con is a No, Unsanitary is a No"
	icon_state = "sunrise"
	icon_living = "sunrise"
	icon_dead = "sunrise_dead"
	gender = "male"

//Slugcat OC for Puff
/mob/living/simple_animal/pet/catslug/cherish
	name = "Cherish"
	desc = "A thickly furred, emerald catslug with big, shiny dark eyes that are constantly mooned with mirth. A red sash is wrapped over their chest; A keepsake, perhaps?"
	icon_state = "saintslug"
	icon_living = "saintslug"
	icon_dead = "saintslug_dead"
	gender = "plural"
