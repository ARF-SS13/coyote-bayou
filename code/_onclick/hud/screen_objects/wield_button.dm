/datum/hud/var/obj/screen/wield/wield_button

/obj/screen/wield
	name = "toggle wield"
	icon = 'icons/fallout/UI/buttons_fallout2.dmi'
	icon_state = "wield"
	layer = HUD_LAYER - 0.1


/obj/screen/wield/Click()
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		H.do_wield()
