#define MANNEQUIN_RANDOMIZE_OUTFIT (1<<0)
#define MANNEQUIN_RANDOMIZE_BODY (1<<1)
#define MANNEQUIN_RANDOMIZE_SPECIES (1<<2)

#define MANNEQUIN_OVERRIDE_RANDOM_NAKED "nude"
#define MANNEQUIN_OVERRIDE_RANDOM_CLOTHED "clothed"
#define MANNEQUIN_OVERRIDE_RANDOM_CLIENT "client"

/obj/item/mannequin
	name = "some kind of mannequin"
	desc = "I had to look up how to spell this darn thing."
	icon = 'icons/effects/effects.dmi'
	icon_state = "nothing"
	w_class = WEIGHT_CLASS_GIGANTIC
	var/datum/outfit/dressup
	var/datum/species/spec
	var/random_flags = NONE
	var/random_override
	var/image/my_overlay
	var/debug

/obj/item/mannequin/Initialize(mapload)
	. = ..()
	if(mapload)
		addtimer(CALLBACK(src,PROC_REF(set_looks)), 30 SECONDS)
	else
		set_looks()
	if(debug)
		debugify()

/obj/item/mannequin/proc/set_looks(datum/source, mob/living/carbon/human/H, mob/living/carbon/human/target)
	if(ishuman(target))
		my_overlay = SSdummy.get_player_image(target, TRUE)
		update_icon()
		return
	else if(ishuman(H))
		my_overlay = SSdummy.get_player_image(H, TRUE)
		update_icon()
		return
	switch(random_override)
		if(MANNEQUIN_OVERRIDE_RANDOM_NAKED)
			my_overlay = SSdummy.get_naked_dummy_image()
		if(MANNEQUIN_OVERRIDE_RANDOM_CLOTHED)
			my_overlay = SSdummy.get_clothed_dummy_image()
		if(MANNEQUIN_OVERRIDE_RANDOM_CLIENT)
			my_overlay = SSdummy.get_player_image(null, TRUE)
	if(my_overlay)
		update_icon()
		return
	var/random_outfit = CHECK_BITFIELD(random_flags, MANNEQUIN_RANDOMIZE_OUTFIT)
	if(random_outfit)
		dressup = null
	var/random_body = CHECK_BITFIELD(random_flags, MANNEQUIN_RANDOMIZE_BODY)
	var/random_species = CHECK_BITFIELD(random_flags, MANNEQUIN_RANDOMIZE_SPECIES)
	if(random_species)
		spec = null

	my_overlay = SSdummy.get_dummy_image("mannequin", spec, dressup, null, null, null, random_body, random_species, random_outfit, TRUE, FALSE)
	update_icon()
	addtimer(CALLBACK(src,PROC_REF(set_looks)), 1 HOURS)

/obj/item/mannequin/update_overlays()
	. = ..()
	cut_overlays()
	if(!my_overlay)
		my_overlay = image('icons/effects/effects.dmi', "explosion_indef")
	add_overlay(my_overlay)

/obj/item/mannequin/AltClick(mob/user)
	. = ..()
	if(!debug)
		return
	set_looks(src, user, user)

/obj/item/mannequin/proc/debugify()
	RegisterSignal(src, COMSIG_ITEM_ATTACKCHAIN,PROC_REF(set_looks))

/obj/item/mannequin/british_infantry
	name = "british infantry mannequin"
	desc = "The british infantry uniform standard standard infantry uniform after the british economic collapse."
	dressup = /datum/outfit/job/ncranger
	random_flags = MANNEQUIN_RANDOMIZE_BODY | MANNEQUIN_RANDOMIZE_SPECIES

/obj/item/mannequin/british_paratrooper
	name = "british paratrooper mannequin"
	desc = "The british paratrooper uniform standard standard infantry uniform after the british economic collapse."
	dressup = /datum/outfit/job/ncranger/british2
	random_flags = MANNEQUIN_RANDOMIZE_BODY | MANNEQUIN_RANDOMIZE_SPECIES

/obj/item/mannequin/burma
	name = "Australian combat mannequin"
	desc = "The standard issue Australian uniform that was used in jungles."
	dressup = /datum/outfit/job/ncranger/burma
	random_flags = MANNEQUIN_RANDOMIZE_BODY | MANNEQUIN_RANDOMIZE_SPECIES

/obj/item/mannequin/raj
	name = "raj combat mannequin"
	desc = "A rare uniform of the snipers of the Indian RAJ."
	dressup = /datum/outfit/job/ncranger/raj
	random_flags = MANNEQUIN_RANDOMIZE_BODY | MANNEQUIN_RANDOMIZE_SPECIES

/obj/item/mannequin/canadian
	name = "canadian combat mannequin"
	desc = "A prefall uniform used by Canada."
	dressup = /datum/outfit/job/ncranger/canadian
	random_flags = MANNEQUIN_RANDOMIZE_BODY | MANNEQUIN_RANDOMIZE_SPECIES

/obj/item/mannequin/japanese
	name = "japanese combat mannequin"
	desc = "A pre war uniform used by the Japanese on their islands."
	dressup = /datum/outfit/job/ncranger/japanese
	random_flags = MANNEQUIN_RANDOMIZE_BODY | MANNEQUIN_RANDOMIZE_SPECIES

/obj/item/mannequin/german
	name = "german combat mannequin"
	desc = "German standard issue infantry uniform."
	dressup = /datum/outfit/job/ncranger/german
	random_flags = MANNEQUIN_RANDOMIZE_BODY | MANNEQUIN_RANDOMIZE_SPECIES

/obj/item/mannequin/american
	name = "american combat mannequin"
	desc = "The current combat uniform of the United states. ahem, was."
	dressup = /datum/outfit/job/ncranger/american
	random_flags = MANNEQUIN_RANDOMIZE_BODY | MANNEQUIN_RANDOMIZE_SPECIES




/obj/item/mannequin/debug_mannequin/random_random
	name = "mannequin"
	desc = "A life-size action figure that totally didn't just move. It also isn't watching you."
	random_flags = MANNEQUIN_RANDOMIZE_BODY | MANNEQUIN_RANDOMIZE_OUTFIT | MANNEQUIN_RANDOMIZE_SPECIES

/obj/item/mannequin/debug_mannequin/random_naked
	name = "a mannequin"
	desc = "A life-size person-doll that lacks clothing and, confusingly, genitals."
	random_override = MANNEQUIN_OVERRIDE_RANDOM_NAKED

/obj/item/mannequin/debug_mannequin/random_clothed
	name = "a mannequin"
	desc = "A life-size dude-figurine sporting a snazzy set of clothes that are apparently welded to its skin. The tag says 50% off."
	random_override = MANNEQUIN_OVERRIDE_RANDOM_CLOTHED

/obj/item/mannequin/debug_mannequin/random_client
	name = "a mannequin"
	desc = "A life-size effigy of... someone oddly familiar."
	random_override = MANNEQUIN_OVERRIDE_RANDOM_CLIENT

/obj/item/ckey_mannequin
	name = "Polymannequin"
	desc = "A shifting mass of unattuned matter. It seems to be trying to take on a form, but can't seem to decide which..."
	icon = 'icons/effects/effects.dmi'
	icon_state = "static"
	w_class = WEIGHT_CLASS_GIGANTIC
	var/image/my_image
	var/my_ckey
	var/my_name
	var/nude = TRUE
	var/very_nude = FALSE
	var/random_clothes = FALSE

/obj/item/ckey_mannequin/clothed
	nude = FALSE

/obj/item/ckey_mannequin/clothed/random
	random_clothes = TRUE

/obj/item/ckey_mannequin/very_nude
	very_nude = TRUE

/obj/item/ckey_mannequin/attack_hand(mob/user, act_intent, attackchain_flags)
	if(!attune_to(user))
		return ..()

/obj/item/ckey_mannequin/proc/attune_to(mob/user)
	if(!user)
		return
	if(!user.ckey)
		return
	if(!user.real_name)
		return
	if(user.ckey == my_ckey || user.real_name == my_name)
		return
	visible_message("[user] touches [src], and it transforms!")
	my_ckey = user.ckey
	my_name = user.real_name
	SSdummy.snapshot_player(my_ckey)
	START_PROCESSING(SSobj, src)
	update_icon()
	return TRUE

/obj/item/ckey_mannequin/process()
	if(prob(5))
		switch(rand(1,5))
			if(1)
				step_rand(src)
			if(2)
				setDir(pick(GLOB.cardinals))
			if(3)
				do_jiggle(5, 0.5 SECONDS)
			if(4)
				TOGGLE_VAR(nude)
			if(5)
				TOGGLE_VAR(random_clothes)
	update_icon()

/obj/item/ckey_mannequin/update_overlays()
	. = ..()
	cut_overlays()
	if(!my_ckey)
		icon = initial(icon)
		icon_state = initial(icon_state)
		name = initial(name)
		desc = initial(desc)
		return
	var/list/imglist
	var/list/cool_list
	if(very_nude)
		cool_list = SSdummy.very_naked_player_cache
	else if(nude)
		cool_list = SSdummy.naked_player_cache
	else if(random_clothes)
		cool_list = SSdummy.randomclothed_player_cache
	else
		cool_list = SSdummy.clothed_player_cache
	for(var/kye in SSdummy.naked_player_cache)
		if(findtext(kye, my_ckey) || findtext(kye, my_name))
			imglist = cool_list[kye]
	if(!imglist)
		visible_message("[src] panics and disappears!")
		return
	if(!my_image)
		my_image = LAZYACCESS(imglist, 1)
		. += my_image
	else
		my_image = next_list_item(my_image, imglist)
		. += my_image
	var/client/userclient = GLOB.directory[my_ckey]
	if(!userclient)
		return
	var/mob/user = userclient.mob
	if(!user)
		return
	name = user.real_name
	var/list/desctext = user.examine(user)
	desc = "[jointext(desctext,"\n")]"
	icon_state = "nothing"





