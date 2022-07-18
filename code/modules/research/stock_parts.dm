/*Power cells are in code\modules\power\cell.dm

If you create T5+ please take a pass at gene_modder.dm [L40]. Max_values MUST fit with the clamp to not confuse the user or cause possible exploits.*/
/obj/item/storage/part_replacer
	name = "rapid part exchange device"
	desc = "Special mechanical module made to store, sort, and apply standard machine parts."
	icon_state = "RPED"
	item_state = "RPED"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	component_type = /datum/component/storage/concrete/rped
	var/works_from_distance = FALSE
	var/pshoom_or_beepboopblorpzingshadashwoosh = 'sound/items/rped.ogg'
	var/alt_sound = null
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE	//cutting down on exploits

/obj/item/storage/part_replacer/pre_attack(obj/machinery/T, mob/living/user, params)
	if(!istype(T) || !T.component_parts)
		return ..()
	if(user.Adjacent(T)) // no TK upgrading.
		if(works_from_distance)
			user.Beam(T, icon_state = "rped_upgrade", time = 5)
		T.exchange_parts(user, src)
		return TRUE
	return ..()

/obj/item/storage/part_replacer/afterattack(obj/machinery/T, mob/living/user, adjacent, params)
	if(adjacent || !istype(T) || !T.component_parts)
		return ..()
	if(works_from_distance)
		user.Beam(T, icon_state = "rped_upgrade", time = 5)
		T.exchange_parts(user, src)
		return
	return ..()

/obj/item/storage/part_replacer/proc/play_rped_sound()
	//Plays the sound for RPED exhanging or installing parts.
	if(alt_sound && prob(1))
		playsound(src, alt_sound, 40, 1)
	else
		playsound(src, pshoom_or_beepboopblorpzingshadashwoosh, 40, 1)

/obj/item/storage/part_replacer/bluespace
	name = "quantum rapid part exchange device"
	desc = "A version of the RPED that allows for replacement of parts and scanning from a distance, along with higher capacity for parts. Definitely not just a BSRPED painted orange."
	icon_state = "BS_RPED"
	w_class = WEIGHT_CLASS_NORMAL
	works_from_distance = TRUE
	pshoom_or_beepboopblorpzingshadashwoosh = 'sound/items/pshoom.ogg'
	alt_sound = 'sound/items/pshoom_2.ogg'
	component_type = /datum/component/storage/concrete/bluespace/rped

/obj/item/storage/part_replacer/bluespace/tier1

/obj/item/storage/part_replacer/bluespace/tier1/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/stock_parts/capacitor(src)
		new /obj/item/stock_parts/scanning_module(src)
		new /obj/item/stock_parts/manipulator(src)
		new /obj/item/stock_parts/micro_laser(src)
		new /obj/item/stock_parts/matter_bin(src)
		new /obj/item/stock_parts/cell/high(src)

/obj/item/storage/part_replacer/bluespace/tier2

/obj/item/storage/part_replacer/bluespace/tier2/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/stock_parts/capacitor/adv(src)
		new /obj/item/stock_parts/scanning_module/adv(src)
		new /obj/item/stock_parts/manipulator/nano(src)
		new /obj/item/stock_parts/micro_laser/high(src)
		new /obj/item/stock_parts/matter_bin/adv(src)
		new /obj/item/stock_parts/cell/super(src)

/obj/item/storage/part_replacer/bluespace/tier3

/obj/item/storage/part_replacer/bluespace/tier3/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/stock_parts/capacitor/super(src)
		new /obj/item/stock_parts/scanning_module/phasic(src)
		new /obj/item/stock_parts/manipulator/pico(src)
		new /obj/item/stock_parts/micro_laser/ultra(src)
		new /obj/item/stock_parts/matter_bin/super(src)
		new /obj/item/stock_parts/cell/hyper(src)

/obj/item/storage/part_replacer/bluespace/tier4

/obj/item/storage/part_replacer/bluespace/tier4/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/stock_parts/capacitor/quadratic(src)
		new /obj/item/stock_parts/scanning_module/triphasic(src)
		new /obj/item/stock_parts/manipulator/femto(src)
		new /obj/item/stock_parts/micro_laser/quadultra(src)
		new /obj/item/stock_parts/matter_bin/bluespace(src)
		new /obj/item/stock_parts/cell/bluespace(src)

/obj/item/storage/part_replacer/cargo //used in a cargo crate

/obj/item/storage/part_replacer/cargo/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/stock_parts/capacitor(src)
		new /obj/item/stock_parts/scanning_module(src)
		new /obj/item/stock_parts/manipulator(src)
		new /obj/item/stock_parts/micro_laser(src)
		new /obj/item/stock_parts/matter_bin(src)

/obj/item/storage/part_replacer/cyborg
	icon_state = "borgrped"

/obj/item/storage/part_replacer/bluespace/cyborg
	icon_state = "borg_BS_RPED"

/proc/cmp_rped_sort(obj/item/A, obj/item/B)
	return B.get_part_rating() - A.get_part_rating()

/obj/item/stock_parts
	name = "stock part"
	desc = "What?"
	icon = 'icons/obj/stock_parts.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/rating = 1
	rad_flags = RAD_NO_CONTAMINATE

/obj/item/stock_parts/Initialize()
	. = ..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

/obj/item/stock_parts/get_part_rating()
	return rating

//Base parts. They aren't intended to be replicate-able by players, but are useful to describe what a machine needs, and round-start machines will have them.

/obj/item/stock_parts/capacitor
	name = "capacitor"
	desc = "A pre-war design for a simple consumer-grade capacitor. Not much better than a watch battery."
	icon_state = "capacitor"
	custom_materials = list(/datum/material/iron=50, /datum/material/glass=50)

/obj/item/stock_parts/scanning_module
	name = "scanning module"
	desc = "A pre-war design for a simple consumer-grade scanning device. Not much better than a light sensitive circuit."
	icon_state = "scan_module"
	custom_materials = list(/datum/material/iron=50, /datum/material/glass=20)

/obj/item/stock_parts/manipulator
	name = "manipulator"
	desc = "A pre-war design for a simple consumer-grade manipulator. Not much better than a simple gear."
	icon_state = "micro_mani"
	custom_materials = list(/datum/material/iron=30)

/obj/item/stock_parts/micro_laser
	name = "laser"
	desc = "A pre-war design for a simple consumer-grade laser. Not much better than a nixie tube."
	icon_state = "micro_laser"
	custom_materials = list(/datum/material/iron=10, /datum/material/glass=20)

/obj/item/stock_parts/matter_bin
	name = "matter bin"
	desc = "A pre-war design for a simple consumer-grade storage bin. Not much better than a funnel."
	icon_state = "matter_bin"
	custom_materials = list(/datum/material/iron=80)

//Rating 1

/obj/item/stock_parts/capacitor/simple
	name = "watch battery"
	desc = "A small battery presumably used to keep a watch timing properly. Could be useful as a makeshift capacitor."
	icon_state = "watch_battery"
	custom_materials = list(/datum/material/iron=50, /datum/material/glass=50)

/obj/item/stock_parts/scanning_module/simple
	name = "light sensitive circuit"
	desc = "Sometimes found in cameras or infrared detectors. Useful for scanning things, if a little low-tech."
	icon_state = "light_sensitive_circuit"
	custom_materials = list(/datum/material/iron=50, /datum/material/glass=20)

/obj/item/stock_parts/manipulator/simple
	name = "simple gear"
	desc = "A simple gear. A couple of these could probably be used in a mechanism to manipulate things."
	icon_state = "simple_gear"
	custom_materials = list(/datum/material/iron=30)

/obj/item/stock_parts/micro_laser/simple
	name = "nixie tube"
	desc = "A small bulb with a complicated filament pattern. Puts off enough heat that it could be used for heating small components in a pinch."
	icon_state = "simple_bulb"
	custom_materials = list(/datum/material/iron=10, /datum/material/glass=20)

/obj/item/stock_parts/matter_bin/simple
	name = "intake funnel"
	desc = "Practically a metal cone. Useful to store some stuff in a machine, at least."
	icon_state = "funnel"
	custom_materials = list(/datum/material/iron=80)

//Rating 2

/obj/item/stock_parts/capacitor/adv
	name = "capacitor"
	desc = "A fairly modern design for a capacitor, it can take in and distribute power pretty quickly compared to a battery."
	icon_state = "simple_capacitor"
	rating = 2
	custom_materials = list(/datum/material/iron=50, /datum/material/glass=50)

/obj/item/stock_parts/scanning_module/adv
	name = "small antenna"
	desc = "Useful for scanning and analyzing signals. Comes with a built in miniature light sensor, too!"
	icon_state = "adv_scan_module"
	rating = 2
	custom_materials = list(/datum/material/iron=50, /datum/material/glass=20)

/obj/item/stock_parts/manipulator/nano
	name = "complex gearwork"
	desc = "More than a few gears interlocked together, useful for manipulating things on a finer scale."
	icon_state = "complex_gearwork"
	rating = 2
	custom_materials = list(/datum/material/iron=30)

/obj/item/stock_parts/micro_laser/high
	name = "flash bulb"
	desc = "A reusable flash bulb. Not only does it shine particularly bright, it can let out a fair bit of heat."
	icon_state = "modern_bulb"
	rating = 2
	custom_materials = list(/datum/material/iron=10, /datum/material/glass=20)

/obj/item/stock_parts/matter_bin/adv
	name = "hopper"
	desc = "A spacious hopper for containing just about anything in a machine and distributing it effectively."
	icon_state = "hopper"
	rating = 2
	custom_materials = list(/datum/material/iron=80)

//Rating 3

/obj/item/stock_parts/capacitor/super
	name = "advanced capacitor"
	desc = "A very effective capacitor, with a bit more heft to it."
	icon_state = "advanced_capacitor"
	rating = 3
	custom_materials = list(/datum/material/iron=50, /datum/material/glass=50)

/obj/item/stock_parts/scanning_module/phasic
	name = "advanced antenna"
	desc = "A high-resolution antenna and camera device, this could scan a pretty wide variety of things."
	icon_state = "advanced_antenna"
	rating = 3
	custom_materials = list(/datum/material/iron=50, /datum/material/glass=20)

/obj/item/stock_parts/manipulator/pico
	name = "delicate mechanism"
	desc = "A whole lot of finely crafted gears, belts, and gearshafts. This could probably manipulate things with microscopic precision."
	icon_state = "delicate_mechanism"
	rating = 3
	custom_materials = list(/datum/material/iron=30)

/obj/item/stock_parts/micro_laser/ultra
	name = "laser diode"
	icon_state = "diode"
	desc = "A laser diode able to put out heat and light very precisely."
	rating = 3
	custom_materials = list(/datum/material/iron=10, /datum/material/glass=20)

/obj/item/stock_parts/matter_bin/super
	name = "storage bin"
	desc = "A small container designed compressed and store just about anything safely in a machine."
	icon_state = "super_matter_bin"
	rating = 3
	custom_materials = list(/datum/material/iron=80)

//Rating 4

/obj/item/stock_parts/capacitor/quadratic
	name = "pre-war capacitor"
	desc = "This absurdly efficient capacitor was made with pre-war materials and designs."
	icon_state = "pre_war_capacitor"
	rating = 4
	custom_materials = list(/datum/material/iron=50, /datum/material/glass=50)

/obj/item/stock_parts/scanning_module/triphasic
	name = "pre-war scanning device"
	desc = "A compact, ultra-high resolution scanning device made with pre-war materials and designs."
	icon_state = "pre_war_scanner"
	rating = 4
	custom_materials = list(/datum/material/iron=50, /datum/material/glass=20)

/obj/item/stock_parts/manipulator/femto
	name = "pre-war servo"
	desc = "A microservo capable of manipulating things on the atomic scale, made using pre-war materials and designs."
	icon_state = "pre_war_servo"
	rating = 4
	custom_materials = list(/datum/material/iron=30)

/obj/item/stock_parts/micro_laser/quadultra
	name = "pre-war laser emitter"
	icon_state = "pre_war_emitter"
	desc = "This extremely powerful micro-laser could only be made with pre-war materials and designs."
	rating = 4
	custom_materials = list(/datum/material/iron=10, /datum/material/glass=20)

/obj/item/stock_parts/matter_bin/bluespace
	name = "pre-war storage system"
	desc = "A container that uses the same pre-war tech that some Vaults pack into Pip-Boys to contain large amounts of material."
	icon_state = "pre_war_storage"
	rating = 4
	custom_materials = list(/datum/material/iron=80)

// Subspace stock parts

/obj/item/stock_parts/subspace/ansible
	name = "subspace ansible"
	icon_state = "subspace_ansible"
	desc = "A compact module capable of sensing extradimensional activity."
	custom_materials = list(/datum/material/iron=30, /datum/material/glass=10)

/obj/item/stock_parts/subspace/filter
	name = "hyperwave filter"
	icon_state = "hyperwave_filter"
	desc = "A tiny device capable of filtering and converting super-intense radiowaves."
	custom_materials = list(/datum/material/iron=30, /datum/material/glass=10)

/obj/item/stock_parts/subspace/amplifier
	name = "subspace amplifier"
	icon_state = "subspace_amplifier"
	desc = "A compact micro-machine capable of amplifying weak subspace transmissions."
	custom_materials = list(/datum/material/iron=30, /datum/material/glass=10)

/obj/item/stock_parts/subspace/treatment
	name = "subspace treatment disk"
	icon_state = "treatment_disk"
	desc = "A compact micro-machine capable of stretching out hyper-compressed radio waves."
	custom_materials = list(/datum/material/iron=30, /datum/material/glass=10)

/obj/item/stock_parts/subspace/analyzer
	name = "subspace wavelength analyzer"
	icon_state = "wavelength_analyzer"
	desc = "A sophisticated analyzer capable of analyzing cryptic subspace wavelengths."
	custom_materials = list(/datum/material/iron=30, /datum/material/glass=10)

/obj/item/stock_parts/subspace/crystal
	name = "ansible crystal"
	icon_state = "ansible_crystal"
	desc = "A crystal made from pure glass used to transmit laser databursts to subspace."
	custom_materials = list(/datum/material/glass=50)

/obj/item/stock_parts/subspace/transmitter
	name = "subspace transmitter"
	icon_state = "subspace_transmitter"
	desc = "A large piece of equipment used to open a window into the subspace dimension."
	custom_materials = list(/datum/material/iron=50)

/obj/item/research//Makes testing much less of a pain -Sieve
	name = "research"
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "capacitor"
	desc = "A debug item for research."
