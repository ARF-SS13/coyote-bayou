/obj/item/clothing/head/f13/ncr
	name = "NCR steelpot helmet"
	desc = "A standard issue NCR steel helmet."
	icon_state = "ncr_steelpot"
	item_state = "ncr_steelpot"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	strip_delay = 50

/*
/obj/item/clothing/head/f13/ncr/medic
	name = "NCR medical helmet"
	desc = "A standard issue NCR Infantry helmet, colored to suit a medical officer."
	icon_state = "ncr_medical_helmet"
	item_state = "ncr_medical_helmet"

/obj/item/clothing/head/f13/ncr/mp
	name = "NCR military police helmet"
	desc = "A standard issue NCR helmet, with the letters \"MP\" scrawled on the front."
	icon_state = "ncr_MP"
	item_state = "ncr_MP"

/obj/item/clothing/head/f13/ncr/goggles
	name = "NCR storm helmet"
	desc = "A standard issue NCR Infantry helmet, with a pair of goggles attached to it."
	icon_state = "ncr_goggles_helmet"
	item_state = "ncr_goggles_helmet"
	toggle_message = "You pull the goggles down under "
	alt_toggle_message = "You push the goggles up onto the "
	can_toggle = 1
	flags_inv = HIDEEARS
	actions_types = list(/datum/action/item_action/toggle)
	toggle_cooldown = 0
	flags_cover = HEADCOVERSEYES
	visor_flags_cover = HEADCOVERSEYES
	dog_fashion = null

/obj/item/clothing/head/hardhat/ncr
	name = "NCR engineer helmet"
	desc = "A standard issue NCR Infantry helmet, modified with a head lamp for engineers."
	icon_state = "hardhat_ncr"
	item_state = "hardhat_ncr"
	item_color = "ncr"
	flags_inv = HIDEEARS
	dog_fashion = null
	armor = list("melee" = 40, "bullet" = 40, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	strip_delay = 50

/obj/item/clothing/head/hardhat/ncr
	name = "NCR engineer helmet"
	desc = "A standard issue NCR Infantry helmet, modified with a head lamp for engineers."
	icon_state = "hardhat0_ncr"
	item_state = "hardhat0_ncr"
	item_color = "ncr"
	flags_inv = HIDEEARS
	dog_fashion = null
	armor = list("melee" = 40, "bullet" = 40, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	strip_delay = 50

/obj/item/clothing/head/f13/ncr/goggles/attack_self(mob/user)
	if(can_toggle && !user.incapacitated())
		if(world.time > cooldown + toggle_cooldown)
			cooldown = world.time
			up = !up
			flags_1 ^= visor_flags
			flags_inv ^= visor_flags_inv
			flags_cover ^= visor_flags_cover
			icon_state = "[initial(icon_state)][up ? "up" : ""]"
			to_chat(user, "[up ? alt_toggle_message : toggle_message] \the [src]")

			user.update_inv_head()
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.head_update(src, forced = 1)

			if(active_sound)
				while(up)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(15)
*/

/obj/item/clothing/head/beret/ncr
	name = "NCR officer beret"
	desc = "A green beret, standard issue for all commissioned NCR Officers."
	icon_state = "ncr_officer_beret"
	item_state = "ncr_officer_beret"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 20, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_recon
	name = "NCR First Recon beret"
	desc = "A red beret, issued to members of NCR First Recon."
	icon_state = "ncr_recon_beret"
	item_state = "ncr_recon_beret"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 20, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_scout
	name = "NCR Third Scout beret"
	desc = "A brown beret, issued to members of the NCR Third Scout Battallion."
	icon_state = "scoutberet"
	item_state = "scoutberet"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_recon_ranger
	name = "NCR Ranger scout beret"
	desc = "A brown beret, issued to members of the NCR Recon Rangers."
	icon_state = "scoutberet"
	item_state = "scoutberet"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_scout_lt
	name = "NCR Third Scout officer beret"
	desc = "A brown beret, issued to officers of the NCR Third Scout Battallion."
	icon_state = "scoutberet"
	item_state = "scoutberet"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/f13/ranger
	name = "NCR ranger campaign hat"
	desc = "An NCR ranger hat, standard issue amongst all but the most elite rangers."
	icon_state = "drillhat"
	item_state = "drillhat"
	armor = list("melee" = 50, "bullet" = 40, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 40, "rad" = 40, "fire" = 80, "acid" = 0)

/obj/item/clothing/head/f13/trailranger
	name = "NCR trail ranger hat"
	desc = "A rustic, homely style cowboy hat worn by NCR trail rangers. Yeehaw!"
	icon_state = "cowboyrang"
	item_state = "cowboyrang"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 20, "energy" = 30, "bomb" = 25, "bio" = 40, "rad" = 40, "fire" = 80, "acid" = 0)

/obj/item/clothing/head/f13/ncr_cap
	name = "NCR garrison cap"
	desc = "A simple cloth garrison cap to be worn when a helmet isn't necessary."
	icon_state = "ncr_cap"
	item_state = "ncr_cap"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	flags_inv = HIDEHAIR
