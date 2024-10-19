/obj/machinery/vending/brahmin_machine
	name = "\improper Billy Brahmin's Cattle Supply"
	desc = "A repurposed foransic supply station crammed full of various brahmin-related odds and ends."
	icon_state = "detdrobe"
	icon_deny = "detdrobe-deny"
	//product_slogans = "Apply your brZZT- Giddeyup, yall!;Apply your brilliant deductiZZT-are better than one!;Apply your brilliant deductive methoZZT-your two-headed friends!;Apply your brilliant deductive methods in style! ...ZZT-ahmin, today!"
	vend_reply = "Thank you for using the DetDroZZT-le Supply!"
	products = list(/obj/item/tattoo_gun = 5,
		/obj/item/tattoo_holder/blank = 20,
		/obj/item/tattoo_holder/blank/temporary = 20,
		///obj/item/brahminbags = 10,
		/obj/item/brahminbrand = 10,
		/obj/item/brahminbridle = 10,
		/obj/item/brahmincollar = 10,
		/obj/item/brahminsaddle = 10,
		/obj/item/brahmin_beacon = 2)
	refill_canister = /obj/item/vending_refill/autodrobe
	default_price = PRICE_ALMOST_CHEAP
	extra_price = PRICE_NORMAL
	payment_department = ACCOUNT_SRV

/obj/machinery/vending/brahmin_machine/Initialize()
	. = ..()
	cost_multiplier_per_dept = list("[ACCESS_BIKER]" = 0)

/obj/machinery/vending/brahmin_machine/canLoadItem(obj/item/I,mob/user)
	return (I.type in products)

/obj/item/vending_refill/brahmin_machine
	machine_name = "Box of ranching supplies"
	icon_state = "refill_costume"

GLOBAL_VAR_INIT(orbital_cow_catapult_ready, TRUE)
GLOBAL_VAR(orbital_cow_cooldown)
#define COW_CANNON_RELOAD_DELAY 20 MINUTES

/// brahmin delivery thingy!
/obj/item/brahmin_beacon
	name = "Farmyard Frank's orbital cattle delivery beacon"
	desc = "A portable satellite uplink terminal to BUFFALO-STAR-1. Most of the keys are unlabeled, aside from a big, red, cow-shaped button. Huh."
	icon = 'icons/obj/computer.dmi'
	icon_state = "tech_key"
	var/delivering_cow = FALSE
	var/beeps_left = 7
	COOLDOWN_DECLARE(clickyclick)

/obj/item/brahmin_beacon/attack_self(mob/user)
	activate_beacon(user)

/obj/item/brahmin_beacon/update_icon_state()
	icon_state = "tech_key[GLOB.orbital_cow_catapult_ready ? "" : "_off"]"

/obj/item/brahmin_beacon/examine(mob/user)
	. = ..()
	if(GLOB.orbital_cow_catapult_ready)
		. += "The [span_green("COW READY")] light is blinking."
	else
		. += "The [span_green("COW [span_red("NOT")] READY")] light is blinking."
		. += "Under it reads: [DisplayTimeText(GLOB.orbital_cow_cooldown - world.time, 30)]."

/// Activates the beacon!
/obj/item/brahmin_beacon/proc/activate_beacon(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return FALSE
	if(!COOLDOWN_FINISHED(src, clickyclick) || delivering_cow)
		playsound(src, 'sound/machines/low_buzz.ogg', 40, ignore_walls = TRUE)
		return
	COOLDOWN_START(src, clickyclick, 4 SECONDS)
	playsound(src, 'sound/machines/keyboard_beep.ogg', 40, ignore_walls = TRUE)
	user.show_message(span_notice("You press one or more buttons on the uplink..."))
	addtimer(CALLBACK(src,PROC_REF(claim_beacon), user), 3 SECONDS)

/obj/item/brahmin_beacon/proc/claim_beacon(mob/user)
	if(!GLOB.orbital_cow_catapult_ready)
		playsound(src, 'sound/machines/up_end.ogg', 40, ignore_walls = TRUE)
		if(in_range(src, user))
			user.show_message(span_alert("...and the uplink just grumps at you. Great. Someone else must have gotten it first."))
		return
	/// Okay claim that fuckin cow!
	delivering_cow = TRUE
	COOLDOWN_START(GLOB, orbital_cow_cooldown, COW_CANNON_RELOAD_DELAY)
	GLOB.orbital_cow_catapult_ready = FALSE
	playsound(src, 'sound/machines/switch_on.ogg', 80, ignore_walls = TRUE)
	playsound(src, 'sound/machines/fuckedup_fax.ogg', 80, ignore_walls = TRUE)
	if(in_range(src, user))
		user.show_message(span_notice("...and the uplink starts making noises like it's doing something!"))
	addtimer(CALLBACK(src,PROC_REF(drop_cow), user), 7.5 SECONDS)
	addtimer(VARSET_CALLBACK(GLOB, orbital_cow_catapult_ready, TRUE), COW_CANNON_RELOAD_DELAY)
	addtimer(CALLBACK(src,PROC_REF(reset_beacon)), COW_CANNON_RELOAD_DELAY)

/obj/item/brahmin_beacon/proc/drop_cow(mob/user)
	var/obj/structure/closet/supplypod/bluespacepod/pod = new()
	pod.explosionSize = list(0,0,2,0) // a bit of a boom
	pod.setStyle(STYLE_BOX)
	var/mob/living/simple_animal/cow/brahmin/bessie = new(pod)
	var/cowname = pick(GLOB.cow_names)
	beep_loop()
	if(cowname == "Cookies and Cream")
		var/mob/living/simple_animal/cow/brahmin/bessie2 = new(pod)
		bessie.name = "Cookies"
		bessie.real_name = "Cookies"
		bessie.desc = "Iiiiiiit's Cookies!"
		bessie2.name = "Cream"
		bessie2.real_name = "Cream"
		bessie2.desc = "Wow, it's Cream!"
	else
		bessie.name = cowname
		bessie.real_name = cowname
	var/turf/hereiam = get_turf(src)
	hereiam.visible_message(span_userdanger("[src] starts beeping furiously! HIT THE DECK!"))
	new /obj/effect/abstract/DPtarget(get_turf(src), pod)
	addtimer(CALLBACK(src,PROC_REF(reset_beacon)), 7.5 SECONDS)

/obj/item/brahmin_beacon/proc/reset_beacon(mob/user)
	delivering_cow = FALSE
	update_icon()

/obj/item/brahmin_beacon/proc/beep_loop()
	playsound(src, 'sound/machines/targbeep.ogg', 100, ignore_walls = TRUE)
	if(beeps_left-- < 0)
		beeps_left = initial(beeps_left)
		return
	addtimer(CALLBACK(src,PROC_REF(beep_loop)), 0.2 SECONDS)

#undef COW_CANNON_RELOAD_DELAY
