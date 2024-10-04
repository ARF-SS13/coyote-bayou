/obj/item/stack/spacecash  //Don't use base space cash stacks. Any other space cash stack can merge with them, and could cause potential money duping exploits.
	name = "Pre-Fall cash"
	singular_name = "bill"
	icon = 'icons/obj/economy.dmi'
	icon_state = "spacecash"
	amount = 1
	max_amount = INFINITY
	throwforce = 0
	throw_speed = 2
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	grind_results = list(/datum/reagent/cellulose = 10)
	var/value = 0

/obj/item/stack/spacecash/Initialize()
	. = ..()
	update_desc()

/obj/item/stack/spacecash/proc/update_desc()
	var/total_worth = get_item_credit_value()
	desc = "It's worth [total_worth] credit[( total_worth > 1 ) ? "s" : ""]"

/obj/item/stack/spacecash/get_item_credit_value()
	return (amount*value)

/obj/item/stack/spacecash/merge(obj/item/stack/S)
	. = ..()
	update_desc()

/obj/item/stack/spacecash/use(used, transfer = FALSE, check = TRUE)
	. = ..()
	update_desc()

/obj/item/stack/spacecash/random
	//Used to generate a random stack of dosh
	var/min_dollars = 1
	var/max_dollars = 500

/obj/item/stack/spacecash/c1
	icon_state = "spacecash"
	singular_name = "one dollar bill"
	value = 1
	merge_type = /obj/item/stack/spacecash/c1

/obj/item/stack/spacecash/c10
	icon_state = "spacecash10"
	singular_name = "ten dollar bill"
	value = 10
	merge_type = /obj/item/stack/spacecash/c10

/obj/item/stack/spacecash/c20
	icon_state = "spacecash20"
	singular_name = "twenty dollar bill"
	value = 20
	merge_type = /obj/item/stack/spacecash/c20

/obj/item/stack/spacecash/c50
	icon_state = "spacecash50"
	singular_name = "fifty dollar bill"
	value = 50
	merge_type = /obj/item/stack/spacecash/c50

/obj/item/stack/spacecash/c100
	icon_state = "spacecash100"
	singular_name = "one hundred dollar bill"
	value = 100
	merge_type = /obj/item/stack/spacecash/c100

/obj/item/stack/spacecash/c200
	icon_state = "spacecash200"
	singular_name = "two hundred dollar bill"
	value = 200
	merge_type = /obj/item/stack/spacecash/c200

/obj/item/stack/spacecash/c500
	icon_state = "spacecash500"
	singular_name = "five hundred dollars worth of bills"
	value = 500
	merge_type = /obj/item/stack/spacecash/c500

/obj/item/stack/spacecash/c1000
	icon_state = "spacecash1000"
	singular_name = "one thousand dollars worth of bills"
	value = 1000
	merge_type = /obj/item/stack/spacecash/c1000

/obj/item/stack/spacecash/c10000
	icon_state = "spacecash10000"
	singular_name = "ten thousand dollars worth of bills"
	value = 10000
	merge_type = /obj/item/stack/spacecash/c10000

