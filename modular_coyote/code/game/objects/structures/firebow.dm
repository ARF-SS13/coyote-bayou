// Firebows! - GremlingSS
// Primitive way of creating fires, very nice yesyes.area
// Requires 2 wood, 1 string to craft.

// I totally didn't forget to include a crafting method, totally did not. Shut the fuck up right now.
/datum/crafting_recipe/firebow
	name = "Firebow"
	result = /obj/item/firebow
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 2,
				/obj/item/weaponcrafting/string = 1)

	category = CAT_PRIMAL

/obj/item/firebow
	name = "firebow"
	desc = "A firebow! An unreliable yet very useful tool to help start create fires."
	icon = 'modular_coyote/icons/items/items.dmi'
	icon_state = "firebow0"
	item_state = "firebow"
	lefthand_file = 'modular_coyote/icons/items/itemlefthand.dmi'
	righthand_file = 'modular_coyote/icons/items/itemrighthand.dmi'
	w_class = WEIGHT_CLASS_SMALL

	var/iconBaseState = "firebow"

	var/cinder = FALSE
	var/burnLength = 15 SECONDS

/obj/item/firebow/attack_self(mob/user)
	if(user.stat)
		return

	UpdateIcon()

	if(!cinder)
		if(AttemptIgnite(user))
			StartBurning(user)
	else
		to_chat(user, span_danger("You already have hot embers, pour it onto something to light it!"))
	
	..()

/obj/item/firebow/proc/AttemptIgnite(mob/user)
	if(user.stat)
		return FALSE

	// behold my cursed layered chance effect for firebows. Each do_after plays a new sound file, and the last 2 stages will have a prob check.
	user.playsound_local(user, 'modular_coyote/sound/items/firebow1.ogg', 40, FALSE)
	user.visible_message(span_notice("[user] begins to draw the bow back and forth, starting slow..."), span_notice("You start drawing the bow back and forth slowly..."))

	if(do_after(user, 35, target = src))
		user.playsound_local(user, 'modular_coyote/sound/items/firebow2.ogg', 40, FALSE)
		user.visible_message(span_notice("[user] builds up momentum, causing smoke to form around the bottom of the stick."), span_notice("You get quicker, you even start seeing smoke to form.."))

		if(do_after(user, 15, target = src))
			if(prob(60))
				user.playsound_local(user, 'modular_coyote/sound/items/firebow3.ogg', 40, FALSE)
				user.visible_message(span_notice("[user] gets incredibly quick now, as a red glow would softly brighten the longer they continue..!"), span_notice("You're now at max speed, you can see a red glow forming at the base."))

				if(do_after(user, 50, target = src))
					user.visible_message(span_notice("[user] creates a small glowing pile of embers on the [src]..!"), span_danger("You created a small pile of red embers on the [src], use it quickly!"))
					return TRUE
	
	user.playsound_local(user, 'modular_coyote/sound/items/firebowfail.ogg', 40, FALSE)
	user.visible_message(span_danger("[user] suddenly lost control of the spin, the stick flew off of the base and dropped onto the floor!"), span_danger("You lost control of the stick, it twisted and flung from the base, falling onto the floor... Time to try again..."))
	return FALSE
	

/obj/item/firebow/proc/StartBurning(mob/user)
	cinder = TRUE
	heat = 1500
	addtimer(CALLBACK(src,PROC_REF(Extinguish), user), burnLength)
	UpdateIcon()

/obj/item/firebow/proc/Extinguish(mob/user)
	cinder = FALSE
	heat = 0
	user.visible_message(span_notice("[src] loses it's glowing embers, extinguishing silently."))
	UpdateIcon()

/obj/item/firebow/proc/UpdateIcon()
	icon_state = "[iconBaseState][cinder]"

// Peter, I've had enough of your nonsense! You need to grow up and stop wasting your time and money on this catgirl fantasy! You're a married man with three kids and a dog! You have responsibilities and obligations! You can't just run away to some imaginary place where you think you'll be happy! You need to face reality and deal with your problems! You need to work on your marriage and your parenting and your career! You need to be a good husband and a good father and a good citizen! You need to stop being so selfish and immature and foolish! You need to stop being Peter Griffin and start being a man!

