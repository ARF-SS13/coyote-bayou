/obj/item/stack/tile
	name = "broken tile"
	singular_name = "broken tile"
	desc = "A broken tile. This should not exist."
	icon = 'icons/obj/tiles.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	force = 1
	throwforce = 1
	throw_speed = 3
	throw_range = 7
	max_amount = 60
	var/turf_type = null
	var/mineralType = null
	novariants = TRUE
	var/human_maxHealth = 100

/obj/item/stack/tile/Initialize(mapload, amount)
	. = ..()
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3) //randomize a little

/obj/item/stack/tile/examine(mob/user)
	. = ..()
	if(throwforce && !is_cyborg) //do not want to divide by zero or show the message to borgs who can't throw
		var/verb
		switch(CEILING(human_maxHealth / throwforce, 1)) //throws to crit a human
			if(1 to 3)
				verb = "superb"
			if(4 to 6)
				verb = "great"
			if(7 to 9)
				verb = "good"
			if(10 to 12)
				verb = "fairly decent"
			if(13 to 15)
				verb = "mediocre"
		if(!verb)
			return
		. += span_notice("Those could work as a [verb] throwing weapon.")

/obj/item/stack/tile/attackby(obj/item/W, mob/user, params)

	if (istype(W, /obj/item/weldingtool))
		if(get_amount() < 4)
			to_chat(user, span_warning("You need at least four tiles to do this!"))
			return

		if(!mineralType)
			to_chat(user, span_warning("You can not reform this!"))
			return

		if(W.use_tool(src, user, 0, volume=40))
			if(mineralType == "plasma")
				atmos_spawn_air("plasma=5;TEMP=1000")
				user.visible_message(span_warning("[user.name] sets the plasma tiles on fire!"), \
									span_warning("You set the plasma tiles on fire!"))
				qdel(src)
				return

			if (mineralType == "metal")
				var/obj/item/stack/sheet/metal/new_item = new(user.loc)
				user.visible_message("[user.name] shaped [src] into metal with the welding tool.", \
							span_notice("You shaped [src] into metal with the welding tool."), \
							span_italic("You hear welding."))
				var/obj/item/stack/rods/R = src
				src = null
				var/replace = (user.get_inactive_held_item()==R)
				R.use(4)
				if (!R && replace)
					user.put_in_hands(new_item)

			else
				var/sheet_type = text2path("/obj/item/stack/sheet/mineral/[mineralType]")
				var/obj/item/stack/sheet/mineral/new_item = new sheet_type(user.loc)
				user.visible_message("[user.name] shaped [src] into a sheet with the welding tool.", \
							span_notice("You shaped [src] into a sheet with the welding tool."), \
							span_italic("You hear welding."))
				var/obj/item/stack/rods/R = src
				src = null
				var/replace = (user.get_inactive_held_item()==R)
				R.use(4)
				if (!R && replace)
					user.put_in_hands(new_item)
	else
		return ..()

//Grass
/obj/item/stack/tile/grass
	name = "grass tile"
	singular_name = "grass floor tile"
	desc = "A patch of grass like they use on space golf courses."
	icon_state = "tile_grass"
	turf_type = /turf/open/floor/grass
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/grass

//Fairygrass
/obj/item/stack/tile/fairygrass
	name = "fairygrass tile"
	singular_name = "fairygrass floor tile"
	desc = "A patch of odd, glowing blue grass."
	icon_state = "tile_fairygrass"
	inhand_icon_state = "tile-fairygrass"
	turf_type = /turf/open/floor/grass/fairy
	resistance_flags = FLAMMABLE
	color = "#33CCFF"
	merge_type = /obj/item/stack/tile/fairygrass

/obj/item/stack/tile/fairygrass/white
	name = "white fairygrass tile"
	singular_name = "white fairygrass floor tile"
	desc = "A patch of odd, glowing white grass."
	turf_type = /turf/open/floor/grass/fairy/white
	color = "#FFFFFF"
	merge_type = /obj/item/stack/tile/fairygrass/white

/obj/item/stack/tile/fairygrass/red
	name = "red fairygrass tile"
	singular_name = "red fairygrass floor tile"
	desc = "A patch of odd, glowing red grass."
	turf_type = /turf/open/floor/grass/fairy/red
	color = "#FF3333"
	merge_type = /obj/item/stack/tile/fairygrass/red

/obj/item/stack/tile/fairygrass/yellow
	name = "yellow fairygrass tile"
	singular_name = "yellow fairygrass floor tile"
	desc = "A patch of odd, glowing yellow grass."
	turf_type = /turf/open/floor/grass/fairy/yellow
	color = "#FFFF66"
	merge_type = /obj/item/stack/tile/fairygrass/yellow

/obj/item/stack/tile/fairygrass/green
	name = "green fairygrass tile"
	singular_name = "green fairygrass floor tile"
	desc = "A patch of odd, glowing green grass."
	turf_type = /turf/open/floor/grass/fairy/green
	color = "#99FF99"
	merge_type = /obj/item/stack/tile/fairygrass/green

/obj/item/stack/tile/fairygrass/blue
	name = "blue fairygrass tile"
	singular_name = "blue fairygrass floor tile"
	desc = "A patch of odd, glowing blue grass."
	turf_type = /turf/open/floor/grass/fairy/blue
	merge_type = /obj/item/stack/tile/fairygrass/blue

/obj/item/stack/tile/fairygrass/purple
	name = "purple fairygrass tile"
	singular_name = "purple fairygrass floor tile"
	desc = "A patch of odd, glowing purple grass."
	turf_type = /turf/open/floor/grass/fairy/purple
	color = "#D966FF"
	merge_type = /obj/item/stack/tile/fairygrass/purple

/obj/item/stack/tile/fairygrass/pink
	name = "pink fairygrass tile"
	singular_name = "pink fairygrass floor tile"
	desc = "A patch of odd, glowing pink grass."
	turf_type = /turf/open/floor/grass/fairy/pink
	color = "#FFB3DA"
	merge_type = /obj/item/stack/tile/fairygrass/pink

//Wood
/obj/item/stack/tile/wood
	name = "wooden floor tile"
	singular_name = "wooden floor tile"
	desc = "An easy to fit wood floor tile."
	icon_state = "tile-wood"
	turf_type = /turf/open/floor/wood_common
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/wood

//Bamboo
/obj/item/stack/tile/bamboo
	name = "bamboo mat pieces"
	singular_name = "bamboo mat piece"
	desc = "A piece of a bamboo mat with a decorative trim."
	icon_state = "tile_bamboo"
	turf_type = /turf/open/floor/bamboo
	merge_type = /obj/item/stack/tile/bamboo
	resistance_flags = FLAMMABLE

//Cloth Floors

/obj/item/stack/tile/padded
	name = "padded floor tile"
	desc = "These are soft and cushy, they'd make good pillows. They look very comfortable, although what they're used for is discomforting."
	icon_state = "tile_padded"
	turf_type = /turf/open/floor/padded
	merge_type = /obj/item/stack/tile/padded

//Basalt
/obj/item/stack/tile/basalt
	name = "basalt tile"
	singular_name = "basalt floor tile"
	desc = "Artificially made ashy soil themed on a hostile environment."
	icon_state = "tile_basalt"
	turf_type = /turf/open/floor/grass/fakebasalt
	merge_type = /obj/item/stack/tile/basalt

//Carpets
/obj/item/stack/tile/carpet
	name = "carpet"
	singular_name = "carpet"
	desc = "A piece of carpet. It is the same size as a floor tile."
	icon_state = "tile-carpet"
	turf_type = /turf/open/floor/carpet
	resistance_flags = FLAMMABLE
	tableVariant = /obj/structure/table/wood/fancy
	merge_type = /obj/item/stack/tile/carpet

/obj/item/stack/tile/carpet/black
	name = "black carpet"
	icon_state = "tile-carpet-black"
	turf_type = /turf/open/floor/carpet/black
	tableVariant = /obj/structure/table/wood/fancy/black
	merge_type = /obj/item/stack/tile/carpet/black

/obj/item/stack/tile/carpet/arcade
	name = "arcade carpet"
	icon_state = "tile-carpet-arcade"
	turf_type = /turf/open/floor
	tableVariant = null
	merge_type = /obj/item/stack/tile/carpet/arcade

/obj/item/stack/tile/carpet/blackred
	name = "red carpet"
	icon_state = "tile-carpet-blackred"
	turf_type = /turf/open/floor/carpet/blackred
	tableVariant = /obj/structure/table/wood/fancy/blackred
	merge_type = /obj/item/stack/tile/carpet/blackred

/obj/item/stack/tile/carpet/monochrome
	name = "monochrome carpet"
	icon_state = "tile-carpet-monochrome"
	turf_type = /turf/open/floor/carpet/monochrome
	tableVariant = /obj/structure/table/wood/fancy/monochrome
	merge_type = /obj/item/stack/tile/carpet/monochrome

/obj/item/stack/tile/carpet/blue
	name = "blue carpet"
	icon_state = "tile-carpet-blue"
	inhand_icon_state = "tile-carpet-blue"
	turf_type = /turf/open/floor/carpet/blue
	tableVariant = /obj/structure/table/wood/fancy/blue
	merge_type = /obj/item/stack/tile/carpet/blue

/obj/item/stack/tile/carpet/cyan
	name = "cyan carpet"
	icon_state = "tile-carpet-cyan"
	inhand_icon_state = "tile-carpet-cyan"
	turf_type = /turf/open/floor/carpet/cyan
	tableVariant = /obj/structure/table/wood/fancy/cyan
	merge_type = /obj/item/stack/tile/carpet/cyan

/obj/item/stack/tile/carpet/green
	name = "green carpet"
	icon_state = "tile-carpet-green"
	inhand_icon_state = "tile-carpet-green"
	turf_type = /turf/open/floor/carpet/green
	tableVariant = /obj/structure/table/wood/fancy/green
	merge_type = /obj/item/stack/tile/carpet/green

/obj/item/stack/tile/carpet/orange
	name = "orange carpet"
	icon_state = "tile-carpet-orange"
	inhand_icon_state = "tile-carpet-orange"
	turf_type = /turf/open/floor/carpet/orange
	tableVariant = /obj/structure/table/wood/fancy/orange
	merge_type = /obj/item/stack/tile/carpet/orange

/obj/item/stack/tile/carpet/purple
	name = "purple carpet"
	icon_state = "tile-carpet-purple"
	inhand_icon_state = "tile-carpet-purple"
	turf_type = /turf/open/floor/carpet/purple
	tableVariant = /obj/structure/table/wood/fancy/purple
	merge_type = /obj/item/stack/tile/carpet/purple

/obj/item/stack/tile/carpet/red
	name = "red carpet"
	icon_state = "tile-carpet-red"
	inhand_icon_state = "tile-carpet-red"
	turf_type = /turf/open/floor/carpet/red
	tableVariant = /obj/structure/table/wood/fancy/red
	merge_type = /obj/item/stack/tile/carpet/red

/obj/item/stack/tile/carpet/royalblack
	name = "royal black carpet"
	icon_state = "tile-carpet-royalblack"
	inhand_icon_state = "tile-carpet-royalblack"
	turf_type = /turf/open/floor/carpet/royalblack
	tableVariant = /obj/structure/table/wood/fancy/royalblack
	merge_type = /obj/item/stack/tile/carpet/royalblack

/obj/item/stack/tile/carpet/royalblue
	name = "royal blue carpet"
	icon_state = "tile-carpet-royalblue"
	inhand_icon_state = "tile-carpet-royalblue"
	turf_type = /turf/open/floor/carpet/royalblue
	tableVariant = /obj/structure/table/wood/fancy/royalblue
	merge_type = /obj/item/stack/tile/carpet/royalblue

/obj/item/stack/tile/carpet/stellar
	name = "stellar carpet"
	icon_state = "tile_carpet_stellar"
	inhand_icon_state = "tile-carpet-royalblue"
	turf_type = /turf/open/floor/carpet/stellar
	merge_type = /obj/item/stack/tile/carpet/stellar

/obj/item/stack/tile/carpet/ten
	amount = 10

/obj/item/stack/tile/carpet/twenty
	amount = 20

/obj/item/stack/tile/carpet/fifty
	amount = 50

/obj/item/stack/tile/carpet/black/ten
	amount = 10

/obj/item/stack/tile/carpet/black/twenty
	amount = 20

/obj/item/stack/tile/carpet/black/fifty
	amount = 50

/obj/item/stack/tile/carpet/arcade/ten
	amount = 10

/obj/item/stack/tile/carpet/arcade/twenty
	amount = 20

/obj/item/stack/tile/carpet/arcade/fifty
	amount = 50

/obj/item/stack/tile/carpet/blackred/ten
	amount = 10

/obj/item/stack/tile/carpet/blackred/twenty
	amount = 20

/obj/item/stack/tile/carpet/blackred/thirty
	amount = 30

/obj/item/stack/tile/carpet/blackred/fifty
	amount = 50

/obj/item/stack/tile/carpet/monochrome/ten
	amount = 10

/obj/item/stack/tile/carpet/monochrome/twenty
	amount = 20

/obj/item/stack/tile/carpet/monochrome/thirty
	amount = 30

/obj/item/stack/tile/carpet/monochrome/fifty
	amount = 50

/obj/item/stack/tile/carpet/blue/ten
	amount = 10

/obj/item/stack/tile/carpet/blue/twenty
	amount = 20

/obj/item/stack/tile/carpet/blue/thirty
	amount = 30

/obj/item/stack/tile/carpet/blue/fifty
	amount = 50

/obj/item/stack/tile/carpet/cyan/ten
	amount = 10

/obj/item/stack/tile/carpet/cyan/twenty
	amount = 20

/obj/item/stack/tile/carpet/cyan/thirty
	amount = 30

/obj/item/stack/tile/carpet/cyan/fifty
	amount = 50

/obj/item/stack/tile/carpet/green/ten
	amount = 10

/obj/item/stack/tile/carpet/green/twenty
	amount = 20

/obj/item/stack/tile/carpet/green/thirty
	amount = 30

/obj/item/stack/tile/carpet/green/fifty
	amount = 50

/obj/item/stack/tile/carpet/orange/ten
	amount = 10

/obj/item/stack/tile/carpet/orange/twenty
	amount = 20

/obj/item/stack/tile/carpet/orange/thirty
	amount = 30

/obj/item/stack/tile/carpet/orange/fifty
	amount = 50

/obj/item/stack/tile/carpet/purple/ten
	amount = 10

/obj/item/stack/tile/carpet/purple/twenty
	amount = 20

/obj/item/stack/tile/carpet/purple/thirty
	amount = 30

/obj/item/stack/tile/carpet/purple/fifty
	amount = 50

/obj/item/stack/tile/carpet/red/ten
	amount = 10

/obj/item/stack/tile/carpet/red/twenty
	amount = 20

/obj/item/stack/tile/carpet/red/thirty
	amount = 30

/obj/item/stack/tile/carpet/red/fifty
	amount = 50

/obj/item/stack/tile/carpet/royalblack/ten
	amount = 10

/obj/item/stack/tile/carpet/royalblack/twenty
	amount = 20

/obj/item/stack/tile/carpet/royalblack/thirty
	amount = 30

/obj/item/stack/tile/carpet/royalblack/fifty
	amount = 50

/obj/item/stack/tile/carpet/royalblue/ten
	amount = 10

/obj/item/stack/tile/carpet/royalblue/twenty
	amount = 20

/obj/item/stack/tile/carpet/royalblue/thirty
	amount = 30

/obj/item/stack/tile/carpet/royalblue/fifty
	amount = 50

/obj/item/stack/tile/fakespace
	name = "astral carpet"
	singular_name = "astral carpet"
	desc = "A piece of carpet with a convincing star pattern."
	icon_state = "tile_space"
	turf_type = /turf/open/floor/fakespace
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/fakespace

/obj/item/stack/tile/fakespace/loaded
	amount = 30

/obj/item/stack/tile/fakepit
	name = "fake pits"
	singular_name = "fake pit"
	desc = "A piece of carpet with a forced perspective illusion of a pit. No way this could fool anyone!"
	icon_state = "tile_pit"
	turf_type = /turf/open/floor/fakepit
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/fakepit

/obj/item/stack/tile/fakepit/loaded
	amount = 30

//High-traction
/obj/item/stack/tile/noslip
	name = "high-traction floor tile"
	singular_name = "high-traction floor tile"
	desc = "A high-traction floor tile. It feels rubbery in your hand."
	icon_state = "tile_noslip"
	turf_type = /turf/open/floor/noslip
	merge_type = /obj/item/stack/tile/noslip

/obj/item/stack/tile/noslip/thirty
	amount = 30

//Circuit
/obj/item/stack/tile/circuit
	name = "blue circuit tile"
	singular_name = "blue circuit tile"
	desc = "A blue circuit tile."
	icon_state = "tile_bcircuit"
	turf_type = /turf/open/floor/circuit
	merge_type = /obj/item/stack/tile/circuit

/obj/item/stack/tile/circuit/green
	name = "green circuit tile"
	singular_name = "green circuit tile"
	desc = "A green circuit tile."
	icon_state = "tile_gcircuit"
	turf_type = /turf/open/floor/circuit/green
	merge_type = /obj/item/stack/tile/circuit/green

/obj/item/stack/tile/circuit/green/anim
	turf_type = /turf/open/floor/circuit/green/anim
	merge_type = /obj/item/stack/tile/circuit/green/anim

/obj/item/stack/tile/circuit/red
	name = "red circuit tile"
	singular_name = "red circuit tile"
	desc = "A red circuit tile."
	icon_state = "tile_rcircuit"
	turf_type = /turf/open/floor/circuit/red
	merge_type = /obj/item/stack/tile/circuit/red

/obj/item/stack/tile/circuit/red/anim
	turf_type = /turf/open/floor/circuit/red/anim
	merge_type = /obj/item/stack/tile/circuit/red/anim

//Pod floor
/obj/item/stack/tile/pod
	name = "pod floor tile"
	singular_name = "pod floor tile"
	desc = "A grooved floor tile."
	icon_state = "tile_pod"
	turf_type = /turf/open/floor/pod
	merge_type = /obj/item/stack/tile/pod

/obj/item/stack/tile/pod/light
	name = "light pod floor tile"
	singular_name = "light pod floor tile"
	desc = "A lightly colored grooved floor tile."
	icon_state = "tile_podlight"
	turf_type = /turf/open/floor/pod/light
	merge_type = /obj/item/stack/tile/pod/light

/obj/item/stack/tile/pod/dark
	name = "dark pod floor tile"
	singular_name = "dark pod floor tile"
	desc = "A darkly colored grooved floor tile."
	icon_state = "tile_poddark"
	turf_type = /turf/open/floor/pod/dark
	merge_type = /obj/item/stack/tile/pod/dark

//Plasteel (normal)
/obj/item/stack/tile/plasteel
	name = "floor tile"
	singular_name = "floor tile"
	desc = "The ground you walk on."
	icon_state = "tile"
	force = 6
	custom_materials = list(/datum/material/iron=500)
	throwforce = 10
	flags_1 = CONDUCT_1
	turf_type = /turf/open/floor/plasteel
	mineralType = "metal"
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/tile/plasteel

/obj/item/stack/tile/plasteel/cyborg
	custom_materials = null // All other Borg versions of items have no Metal or Glass - RR
	is_cyborg = 1
	cost = 125
	merge_type = /obj/item/stack/tile/plasteel/cyborg

/obj/item/stack/tile/material
	name = "floor tile"
	singular_name = "floor tile"
	desc = "The ground you walk on."
	throwforce = 10
	icon_state = "material_tile"
	turf_type = /turf/open/floor/material
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	merge_type = /obj/item/stack/tile/material

/obj/item/stack/tile/bronze
	name = "bronze tile"
	singular_name = "bronze floor tile"
	desc = "A tile made out of bronze. Looks like clockwork."
	icon_state = "material_tile"
	color = "#92661A"
	turf_type = /turf/open/floor/bronze
	custom_materials = list(/datum/material/bronze = 100)
	merge_type = /obj/item/stack/tile/bronze

/obj/item/stack/tile/whitemarble
	name = "white marble floor tile"
	singular_name = "white marble floor tile"
	desc = "An easy to fit marble floor tile."
	icon_state = "tile_wmarble"
	turf_type = /turf/open/floor/plasteel/f13/whitemarble
	merge_type = /obj/item/stack/tile/whitemarble

/obj/item/stack/tile/whitemarble/ten
	amount = 10

/obj/item/stack/tile/whitemarble/twenty
	amount = 20

/obj/item/stack/tile/whitemarble/thirty
	amount = 30

/obj/item/stack/tile/whitemarble/fifty
	amount = 50

/obj/item/stack/tile/blackmarble
	name = "black marble floor tile"
	singular_name = "black marble floor tile"
	desc = "An easy to fit black floor tile."
	icon_state = "tile_bmarble"
	turf_type = /turf/open/floor/plasteel/f13/darkmarble
	merge_type = /obj/item/stack/tile/blackmarble

/obj/item/stack/tile/blackmarble/ten
	amount = 10

/obj/item/stack/tile/blackmarble/twenty
	amount = 20

/obj/item/stack/tile/blackmarble/thirty
	amount = 30

/obj/item/stack/tile/blackmarble/fifty
	amount = 50

