/obj/item/modkit
	name = "modkit"
	desc = "A small container of parts made to modify a specific item. Use the target item on this kit to convert it."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "modkit"
	w_class = WEIGHT_CLASS_NORMAL
	var/target_item = null
	var/result_item = null

/obj/item/modkit/attackby(obj/item/I, mob/user, params)
	if(istype(I, target_item))
		var/obj/item/R = new result_item
		remove_item_from_storage(user)
		user.put_in_hands(R)
		to_chat(user, "<span class='notice'>You apply the [src] to [I], using the custom parts to turn it into [R].</span>")
		qdel(src)
		qdel(I)
	else
		return ..()

/obj/item/modkit/riotgear
	name = "desert ranger riot gear modkit"
	target_item = /obj/item/clothing/suit/armor/f13/rangercombat
	result_item = /obj/item/clothing/suit/armor/f13/rangercombat/desert

/obj/item/modkit/riotgear_helmet
	name = "desert ranger riot helmet modkit"
	target_item = /obj/item/clothing/head/helmet/f13/ncr/rangercombat
	result_item = /obj/item/clothing/head/helmet/f13/ncr/rangercombat/desert

/obj/item/modkit/riotgear/fox
	name = "sniper riot gear modkit"
	result_item = /obj/item/clothing/suit/armor/f13/rangercombat/foxcustom

/obj/item/modkit/riotgear_helmet/fox
	name = "reclaimed ranger-hunter combat helmet modkit"
	result_item = /obj/item/clothing/head/helmet/f13/ncr/rangercombat/foxcustom

/obj/item/modkit/riotgear/rigs
	name = "11th armored calvary armor modkit"
	result_item = /obj/item/clothing/suit/armor/f13/rangercombat/rigscustom

/obj/item/modkit/riotgear_helmet/rigs
	name = "11th armored calvary helmet modkit"
	result_item = /obj/item/clothing/head/helmet/f13/ncr/rangercombat/rigscustom

/obj/item/modkit/thax_patrol
	name = "modified patrol armor modkit"
	target_item = /obj/item/clothing/suit/armor/f13/combat/ncr_patrol
	result_item = /obj/item/clothing/suit/armor/f13/combat/ncr_patrol/thax

/obj/item/modkit/shank
	name = "follower's duster modkit"
	target_item = /obj/item/clothing/suit/armor/f13/raider
	result_item = /obj/item/clothing/suit/armor/f13/shankduster

/obj/item/modkit/custom_excess
	name = "Champion of Kanab's Armor modkit"
	target_item = /obj/item/clothing/suit/armor/f13/legion/palacent
	result_item = /obj/item/clothing/suit/armor/f13/legion/palacent/custom_excess

/obj/item/modkit/custom_excess_helmet
	name = "Champion of Kanab's Helm modkit"
	target_item = /obj/item/clothing/head/helmet/f13/legion/palacent
	result_item = /obj/item/clothing/head/helmet/f13/legion/palacent/custom_excess

/obj/item/modkit/piper_hat
	name = "gambler's hat modkit"
	target_item = /obj/item/clothing/head/f13/trailranger
	result_item = /obj/item/clothing/head/f13/flatranger

/obj/item/modkit/piper_vest
	name = "armoured poncho modkit"
	target_item = /obj/item/clothing/suit/armor/f13/trailranger
	result_item = /obj/item/clothing/suit/toggle/armor/f13/cloakranger

/obj/item/modkit/digger_helm
	name = "salvaged riot armor modkit"
	target_item = /obj/item/clothing/suit/armor/f13/raider
	result_item = /obj/item/clothing/suit/armor/f13/herbertranger

/obj/item/modkit/digger_vest
	name = "salvaged riot helmet modkit"
	target_item = /obj/item/clothing/head/helmet/f13/raider
	result_item = /obj/item/clothing/head/helmet/f13/herbertranger

/obj/item/modkit/diohelmet
	name = "galerum lacertarex"
	target_item = /obj/item/clothing/head/helmet/f13/legion/venator
	result_item = /obj/item/clothing/head/helmet/f13/legion/venator/diohelmet

/obj/item/modkit/trenchcoatfollowers
	name = "followers trenchcoat modkit"
	target_item = /obj/item/clothing/suit/armor/vest
	result_item = /obj/item/clothing/suit/armor/vest/trench

/obj/item/modkit/patrolduster
	name = "Patrol Duster modkit"
	target_item = /obj/item/clothing/suit/armor/f13/raider
	result_item = /obj/item/clothing/suit/armor/f13/raider/combatduster/patrolduster

/obj/item/modkit/wolfvest
	name = "subdued ranger vest modkit"
	target_item = /obj/item/clothing/suit/armor/f13/combat/ncr_patrol
	result_item = /obj/item/clothing/suit/armor/f13/modif_r_vest
