/obj/item/clothing/gloves/ring
	name = "gold ring"
	desc = "A tiny gold ring, sized to wrap around a finger."
	gender = NEUTER
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/ring.dmi'
	icon_state = "ringgold"
	inhand_icon_state = "gring"
	body_parts_covered = 0
	attack_verb = list("proposed")
	transfer_prints = TRUE
	strip_delay = 40
	var/mood_event_on_equip = /datum/mood_event/equipped_ring/gold

/obj/item/clothing/gloves/ring/equipped(mob/user, slot)
	. = ..()
	if (slot == SLOT_GLOVES && istype(user))
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "ringbuff", mood_event_on_equip)
	else
		SEND_SIGNAL(user, COMSIG_CLEAR_MOOD_EVENT, "ringbuff")

/obj/item/clothing/gloves/ring/dropped(mob/user)
	. = ..()
	SEND_SIGNAL(user, COMSIG_CLEAR_MOOD_EVENT, "ringbuff")


/obj/item/clothing/gloves/ring/diamond
	name = "diamond ring"
	desc = "An expensive ring, studded with a diamond. Cultures have used these rings in courtship for a millenia."
	icon_state = "ringdiamond"
	inhand_icon_state = "dring"
	mood_event_on_equip = /datum/mood_event/equipped_ring/diamond

/obj/item/clothing/gloves/ring/diamond/attack_self(mob/user)
	user.visible_message(span_warning("\The [user] gets down on one knee, presenting \the [src]."),span_warning("You get down on one knee, presenting \the [src]."))

/obj/item/clothing/gloves/ring/silver
	name = "silver ring"
	desc = "A tiny silver ring, sized to wrap around a finger."
	icon_state = "ringsilver"
	inhand_icon_state = "sring"
	mood_event_on_equip = /datum/mood_event/equipped_ring

/obj/item/clothing/gloves/ring/plasma
	name = "plasma ring"
	desc = "This ring is stylized to have an ornate sun, with a sample of phoron swirling around inside."
	icon_state = "ringplasma"
	inhand_icon_state = "pring"
	mood_event_on_equip = /datum/mood_event/equipped_ring/plasma

/obj/item/clothing/gloves/ring/bluespace
	name = "bluespace ring"
	desc = "This ring is stylized to have an ornate sun, with a small sample of a bluespace crystal shining inside."
	icon_state = "ringbluespace"
	inhand_icon_state = "bring"
	mood_event_on_equip = /datum/mood_event/equipped_ring/bluespace
