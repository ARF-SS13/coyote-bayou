obj/item/bighorn_flag
	name = "Bighorn flag"
	desc = "A flag depicting the head of a bighorner. It's the symbol of the town of Bighorn."
	icon = 'modular_sunset/icons/structures/bighorn_flag.dmi'
	icon_state = "bighorn_flag"
	item_state = "bighorn_flag"
	density = 1
	anchored = 1
	w_class = 4
	layer = 4.1

obj/item/bighorn_sign
	name = "Bighorn sign"
	desc = "A repurposed highway sign with the spray painted name of 'Bighorn'."
	icon = 'modular_sunset/icons/structures/bighorn_sign.dmi'
	icon_state = "bighorn_hvysign"
	item_state = "bighorn_hvysign"
	density = 1
	anchored = 1
	w_class = 4
	layer = 5

obj/item/trade_sign
	name = "Trade sign"
	desc = "A wooden sign with seemingly hand forged lettering bolted to it."
	icon = 'modular_sunset/icons/structures/sunset_signs.dmi'
	icon_state = "sign_trade_south"
	item_state = "sign_trade_south"
	density = 1
	anchored = 1
	w_class = 4
	layer = 5

/datum/weather/ash_storm/sandstorm
	telegraph_message = "<span class='userdanger'>A sandstorm is coming to the area, decreasing overall visibility outside.</span>"

	weather_message = "<span class='boldannounce'>The sand wafts down around you like grotesque, thick snow. The sandstorm is here...</span>"

	end_message = "<span class='boldannounce'>The sandstorm slows before stopping. Adding another layer of sand to the ground beneath your feet.</span>"
