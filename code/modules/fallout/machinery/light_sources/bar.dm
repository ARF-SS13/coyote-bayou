//Fallout 13 neon signs directory

/obj/machinery/light/sign
	name = "bar sign"
	icon_state = "blue"
	base_state = "blue"
	icon = 'icons/fallout/machines/64x32.dmi'
	bound_width = 64
	fitting = "bulb"
	brightness = 4
	active_power_usage = 0
	density = 0
	desc = "The glow of the sign tempts you to buy a drink..."
	light_color = LIGHT_COLOR_BLUE
	light_type = /obj/item/light/bulb
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF //Destroying these just causes issues. Let's fucking not


/obj/machinery/light/sign/Initialize()
	. = ..()
	AddComponent(/datum/component/largetransparency, x_size = 1, y_size = 1)


/obj/machinery/light/sign/update_icon()
	return

/obj/machinery/light/sign/update()
	return

/obj/machinery/light/sign/process()
	return

/obj/machinery/light/sign/break_light_tube()
	return

/obj/machinery/light/sign/burn_out()
	return

/obj/machinery/light/sign/attackby(obj/item/W, mob/living/user, params) //Uh uh
	return 0

/obj/machinery/light/sign/deconstruct(disassembled = FALSE) //Can't be decosntructed
	return

/obj/machinery/light/sign/attack_hand(mob/living/carbon/human/user) //Fucking nope
	return 0

/obj/machinery/light/sign/explode() //Hell
	return

/obj/machinery/light/sign/kebab
	name = "Kebabtown sign"
	icon_state = "Kebab"
	base_state = "Kebab"
	icon = 'icons/fallout/objects/structures/kebabtown.dmi'
	density = 1
	desc = "So awful..."
	light_color = LIGHT_COLOR_YELLOW

/obj/machinery/light/sign/kebab_sign
	name = "Kebabtown"
	icon_state = "kebab_sign"
	base_state = "kebab_sign"
	icon = 'icons/fallout/objects/structures/kebabtown.dmi'
	desc = "So awful..."
	light_color = LIGHT_COLOR_YELLOW

/obj/machinery/light/sign/oasis
	name = "Oasis sign"
	icon_state = "Oasis"
	base_state = "Oasis"
	icon = 'icons/fallout/objects/structures/kebabtown.dmi'
	density = 1
	desc = "A sign marking the town of Oasis. It's remarkably fancy."
	light_color = LIGHT_COLOR_YELLOW

/obj/machinery/light/sign/oasis_sign
	name = "Oasis"
	icon_state = "oasis_sign"
	base_state = "oasis_sign"
	icon = 'icons/fallout/objects/structures/kebabtown.dmi'
	desc = "A sign marking the town of Oasis. It's remarkably fancy.."
	light_color = LIGHT_COLOR_YELLOW

/obj/machinery/light/sign/chiken_ranch
	name = "Chiken Ranch sign"
	icon_state = "chiken_ranch"
	base_state = "chiken_ranch"
	icon = 'icons/fallout/objects/structures/chiken_ranch.dmi'
	density = 1
	desc = "Where the west is still wild!"
	light_color = LIGHT_COLOR_PINK

/obj/machinery/light/sign/heaven
	name = "Heaven's Night"
	icon_state = "heaven"
	base_state = "heaven"
	desc = "A neon sign advertising Heaven's Night in a relaxing hue."
	icon = 'icons/fallout/objects/structures/heaven.dmi'
	light_color = LIGHT_COLOR_PINK

/obj/machinery/light/sign/crimson
	name = "Crimson Caravan"
	icon_state = "crimson"
	base_state = "crimson"
	desc = "A lit sign advertising Crimson Caravan - the wasteland trading conglomerate."
	icon = 'icons/fallout/objects/structures/crimson.dmi'
	brightness = 3
	light_color = LIGHT_COLOR_RED

/obj/machinery/light/sign/shed
	name = "Trading Shed"
	icon_state = "shed"
	base_state = "shed"
	desc = "A crude plate sign advertising Trading Shed - a shack of automated vendors."
	icon = 'icons/fallout/objects/structures/shed.dmi'
	brightness = 3
	light_color = LIGHT_COLOR_YELLOW
