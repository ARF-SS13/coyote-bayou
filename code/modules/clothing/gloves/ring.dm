/obj/item/clothing/gloves/ring
	name = "gold ring"
	desc = "A tiny gold ring, sized to wrap around a finger."
	gender = NEUTER
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/ring.dmi'
	icon_state = "ringgold"
	item_state = "gring"
	body_parts_covered = 0
	attack_verb = list("proposed")
	transfer_prints = TRUE
	strip_delay = 40
	block_chance = 5

/obj/item/clothing/gloves/ring/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	. = ..()
	if(prob(block_chance))
		owner.visible_message("<span class='danger'>[owner] seems to dodge [attack_text] entirely thanks to [src]!</span>")
		playsound(src, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, 1)
		block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_PASSTHROUGH
		return BLOCK_SUCCESS | BLOCK_REDIRECTED | BLOCK_SHOULD_REDIRECT | BLOCK_TARGET_DODGED
	return

/obj/item/clothing/gloves/ring/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>\[user] is putting the [src] in [user.p_their()] mouth! It looks like [user] is trying to choke on the [src]!</span>")
	return OXYLOSS

/obj/item/clothing/gloves/ring/diamond
	name = "diamond ring"
	desc = "An expensive ring, studded with a diamond. Cultures have used these rings in courtship for a millenia."
	icon_state = "ringdiamond"
	item_state = "dring"
	block_chance = 10

/obj/item/clothing/gloves/ring/diamond/attack_self(mob/user)
	user.visible_message("<span class='warning'>\The [user] gets down on one knee, presenting \the [src].</span>","<span class='warning'>You get down on one knee, presenting \the [src].</span>")

/obj/item/clothing/gloves/ring/silver
	name = "silver ring"
	desc = "A tiny silver ring, sized to wrap around a finger."
	icon_state = "ringsilver"
	item_state = "sring"
	block_chance = 3

/obj/item/clothing/gloves/ring/custom
	name = "ring"
	desc = "A ring."
	gender = NEUTER
	w_class = WEIGHT_CLASS_TINY
	obj_flags = UNIQUE_RENAME
	icon_state = "ringsilver"
	item_state = "sring"
	block_chance = 0
