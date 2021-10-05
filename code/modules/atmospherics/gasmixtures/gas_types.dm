
//Unomos - oh god oh fuck oh shit oh lord have mercy this is messy as fuck oh god
//my addiction to seeing better performance numbers isn't healthy, kids
//you see this shit, children?
//i am not a good idol. don't take after me.
//this is literally worse than my alcohol addiction
/proc/meta_gas_heat_list()
	. = subtypesof(/datum/gas)
	for(var/gas_path in .)
		var/datum/gas/gas = gas_path
		.[gas_path] = initial(gas.specific_heat)

/proc/meta_gas_name_list()
	. = subtypesof(/datum/gas)
	for(var/gas_path in .)
		var/datum/gas/gas = gas_path
		.[gas_path] = initial(gas.name)

/proc/meta_gas_visibility_list()
	. = subtypesof(/datum/gas)
	for(var/gas_path in .)
		var/datum/gas/gas = gas_path
		.[gas_path] = initial(gas.moles_visible)

/proc/meta_gas_overlay_list()
	. = subtypesof(/datum/gas)
	for(var/gas_path in .)
		var/datum/gas/gas = gas_path
		.[gas_path] = 0 //gotta make sure if(GLOB.meta_gas_overlays[gaspath]) doesn't break
		if(initial(gas.moles_visible) != null)
			.[gas_path] = new /list(FACTOR_GAS_VISIBLE_MAX)
			for(var/i in 1 to FACTOR_GAS_VISIBLE_MAX)
				.[gas_path][i] = new /obj/effect/overlay/gas(initial(gas.gas_overlay), i * 255 / FACTOR_GAS_VISIBLE_MAX)




/proc/meta_gas_fusion_list()
	. = subtypesof(/datum/gas)
	for(var/gas_path in .)
		var/datum/gas/gas = gas_path
		.[gas_path] = initial(gas.fusion_power)

/*||||||||||||||/----------\||||||||||||||*\
||||||||||||||||[GAS DATUMS]||||||||||||||||
||||||||||||||||\__________/||||||||||||||||
||||These should never be instantiated. ||||
||||They exist only to make it easier   ||||
||||to add a new gas. They are accessed ||||
||||only by meta_gas_list().            ||||
\*||||||||||||||||||||||||||||||||||||||||*/


/datum/gas/oxygen
	id = "o2"
	specific_heat = 20
	name = "Oxygen"


/datum/gas/nitrogen
	id = "n2"
	specific_heat = 20
	name = "Nitrogen"


/datum/gas/carbon_dioxide //what the fuck is this?
	id = "co2"
	specific_heat = 30
	name = "Carbon Dioxide"
	fusion_power = 3


/datum/gas/plasma
	id = "plasma"
	specific_heat = 200
	name = "Plasma"
	gas_overlay = "plasma"
	moles_visible = MOLES_GAS_VISIBLE



/datum/gas/water_vapor
	id = "water_vapor"
	specific_heat = 40
	name = "Water Vapor"
	gas_overlay = "water_vapor"
	moles_visible = MOLES_GAS_VISIBLE
	fusion_power = 8


/datum/gas/hypernoblium
	id = "nob"
	specific_heat = 2000
	name = "Hyper-noblium"
	gas_overlay = "freon"
	moles_visible = MOLES_GAS_VISIBLE



/datum/gas/nitrous_oxide
	id = "n2o"
	specific_heat = 40
	name = "Nitrous Oxide"
	gas_overlay = "nitrous_oxide"
	moles_visible = MOLES_GAS_VISIBLE * 2



/datum/gas/nitryl
	id = "no2"
	specific_heat = 20
	name = "Nitryl"
	gas_overlay = "nitryl"
	moles_visible = MOLES_GAS_VISIBLE

	fusion_power = 15


/datum/gas/tritium
	id = "tritium"
	specific_heat = 10
	name = "Tritium"
	gas_overlay = "tritium"
	moles_visible = MOLES_GAS_VISIBLE

	fusion_power = 1


/datum/gas/bz
	id = "bz"
	specific_heat = 20
	name = "BZ"

	fusion_power = 8


/datum/gas/stimulum
	id = "stim"
	specific_heat = 5
	name = "Stimulum"
	fusion_power = 7


/datum/gas/pluoxium
	id = "pluox"
	specific_heat = 80
	name = "Pluoxium"
	fusion_power = 10


/datum/gas/miasma
	id = "miasma"
	specific_heat = 20
	fusion_power = 50
	name = "Miasma"
	gas_overlay = "miasma"
	moles_visible = MOLES_GAS_VISIBLE * 60


/datum/gas/methane
	id = "methane"
	specific_heat = 30
	name = "Methane"


/datum/gas/methyl_bromide
	id = "methyl_bromide"
	specific_heat = 42
	name = "Methyl Bromide"




/obj/effect/overlay/gas
	icon = 'icons/effects/atmospherics.dmi'
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE  // should only appear in vis_contents, but to be safe
	layer = FLY_LAYER
	appearance_flags = TILE_BOUND
	vis_flags = NONE

/obj/effect/overlay/gas/New(state, alph)
	. = ..()
	icon_state = state
	alpha = alph
