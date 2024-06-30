/* 
 * File:   outfits_we_use.dm
 * Author: werty and the GoonSquad
 * Date: 2010-07-07
 * License: AeFalleToTheMoon
 * 
 * Description: This file contains the code for the outfits that we use for our folkers
 * Purpose: To make it so these damn outfits arent blended in with the job datums and
 * make it so us illiterate folk can actually know the what the heck is going on
 * So suck it
 */

////////////////////////
// Base Wasteland Outfit
// This is the base default outfit for just about everyone
// please please please base everything off this
/datum/outfit/job/cb
	name = "Wastelander"
	jobtype = /datum/job/wasteland/f13wastelander

	uniform = list(
		/obj/item/clothing/under/f13/settler,
		/obj/item/clothing/under/f13/brahminm,
		/obj/item/clothing/under/f13/lumberjack,
		/obj/item/clothing/under/f13/roving)
	gloves   = /obj/item/pda
	id       = /obj/item/storage/wallet/stash/low
	ears     = /obj/item/radio/headset
	belt     = /obj/item/supplykit
	backpack = /obj/item/storage/backpack
	satchel  = /obj/item/storage/backpack/satchel/leather
	l_pocket = /obj/item/storage/survivalkit
	r_pocket = list(
		/obj/item/storage/fancy/flare_pouch,
		/obj/item/storage/fancy/flare_pouch/glowstick)
	box = /obj/item/storage/survivalkit/medical
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/card/id/selfassign,
		)

/datum/outfit/job/cb/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(isrobotic(H))
		box = /obj/item/storage/survivalkit/medical/synth













