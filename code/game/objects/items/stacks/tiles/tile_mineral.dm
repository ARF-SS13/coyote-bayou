/obj/item/stack/tile/mineral/plasma
	name = "plasma tile"
	singular_name = "plasma floor tile"
	desc = "A tile made out of highly flammable plasma. This can only end well."
	icon_state = "tile_plasma"
	turf_type = /turf/open/floor/mineral/plasma
	mineralType = "plasma"
	custom_materials = list(/datum/material/plasma=250)
	merge_type = /obj/item/stack/tile/mineral/plasma

/obj/item/stack/tile/mineral/uranium
	name = "uranium tile"
	singular_name = "uranium floor tile"
	desc = "A tile made out of uranium. You feel a bit woozy."
	icon_state = "tile_uranium"
	turf_type = /turf/open/floor/mineral/uranium
	mineralType = "uranium"
	custom_materials = list(/datum/material/uranium=250)
	merge_type = /obj/item/stack/tile/mineral/uranium

/obj/item/stack/tile/mineral/gold
	name = "gold tile"
	singular_name = "gold floor tile"
	desc = "A tile made out of gold, the swag seems strong here."
	icon_state = "tile_gold"
	turf_type = /turf/open/floor/mineral/gold
	mineralType = "gold"
	custom_materials = list(/datum/material/gold=250)
	merge_type = /obj/item/stack/tile/mineral/gold

/obj/item/stack/tile/mineral/silver
	name = "silver tile"
	singular_name = "silver floor tile"
	desc = "A tile made out of silver, the light shining from it is blinding."
	icon_state = "tile_silver"
	turf_type = /turf/open/floor/mineral/silver
	mineralType = "silver"
	custom_materials = list(/datum/material/silver=250)
	merge_type = /obj/item/stack/tile/mineral/silver

/obj/item/stack/tile/mineral/diamond
	name = "diamond tile"
	singular_name = "diamond floor tile"
	desc = "A tile made out of diamond. Wow, just, wow."
	icon_state = "tile_diamond"
	turf_type = /turf/open/floor/mineral/diamond
	mineralType = "diamond"
	custom_materials = list(/datum/material/diamond=250)
	merge_type = /obj/item/stack/tile/mineral/diamond

/obj/item/stack/tile/mineral/abductor
	name = "polymer floor tile" //Fortuna edit: alien alloy -> polymer
	singular_name = "polymer floor tile"
	desc = "A tile made from an experimental polymer alloy."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "tile_abductor"
	turf_type = /turf/open/floor/mineral/abductor
	mineralType = "abductor"
	merge_type = /obj/item/stack/tile/mineral/abductor

/obj/item/stack/tile/mineral/titanium
	name = "titanium tile"
	singular_name = "titanium floor tile"
	desc = "A tile made of titanium, used for shuttles."
	icon_state = "tile_shuttle"
	turf_type = /turf/open/floor/mineral/titanium
	mineralType = "titanium"
	custom_materials = list(/datum/material/titanium=250)
	merge_type = /obj/item/stack/tile/mineral/titanium

/obj/item/stack/tile/mineral/plastitanium
	name = "plastitanium tile"
	singular_name = "plastitanium floor tile"
	desc = "A tile made of plastitanium, used for very evil shuttles."
	icon_state = "tile_darkshuttle"
	turf_type = /turf/open/floor/mineral/plastitanium
	mineralType = "plastitanium"
	custom_materials = list(/datum/material/titanium=100, /datum/material/plasma=100)
	merge_type = /obj/item/stack/tile/mineral/plastitanium
