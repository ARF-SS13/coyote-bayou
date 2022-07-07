/obj/machinery/computer/vertibird_console
	name = "Vertibird control"
	desc = "Used to control the autopilot on linked vertibirds."
	icon = 'icons/fallout/machines/terminals.dmi'
	icon_state = "enclave"
	icon_screen = "enclave_on"
	connectable = FALSE

/obj/machinery/computer/vertibird_console/attack_hand(mob/user)
	GLOB.vertibird:beginFly()
