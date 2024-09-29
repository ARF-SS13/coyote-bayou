/obj/structure/flora/tree_stump
	name = "tree stump"
	desc = "A stump of a tree."
	icon = 'icons/obj/flora/twigs.dmi'
	icon_state = "tree_stump"
	anchored = TRUE
	density = FALSE

/obj/structure/flora/tree_log
	name = "tree log"
	desc = "Where's the lumps?"
	icon = 'icons/obj/flora/twigs.dmi'
	icon_state = "tree_log"
	anchored = TRUE

/obj/structure/flora/tree_timber
	name = "tree timber"
	desc = "It's going down. I'm yelling Timber."
	icon = 'icons/obj/flora/twigs.dmi'
	icon_state = "tree_timber"
	anchored = TRUE

/obj/structure/flora/timber
	name = "old timber"
	desc = "A slightly decayed piece of timber"
	icon = 'icons/obj/flora/twigs.dmi'
	icon_state = "timber"
	anchored = TRUE

/obj/structure/flora/tree_stump
	name = "tree stump"
	desc = "A stump of a tree."
	icon = 'icons/obj/flora/twigs.dmi'
	icon_state = "tree_stump"
	anchored = TRUE

/obj/structure/flora/branch
	name = "branch"
	desc = "pokey"
	icon = 'icons/obj/flora/twigs.dmi'
	icon_state = "branch"
	anchored = TRUE

/obj/structure/flora/branch_broken
	name = "broken branch"
	desc = "pokey."
	icon = 'icons/obj/flora/twigs.dmi'
	icon_state = "branch_broken"
	anchored = TRUE

/obj/structure/flora/brushwood
	name = "brush wood"
	desc = "several pokeys"
	icon = 'icons/obj/flora/twigs.dmi'
	icon_state = "brushwood"
	anchored = TRUE

/obj/structure/flora/brushwoodalt
	name = "brush wood"
	desc = "several pokeys"
	icon = 'icons/obj/flora/twigs.dmi'
	icon_state = "brushwood_alt"
	anchored = TRUE

//stuff from CIV 13
/obj/structure/flora
	/// Will auto-generate a transparency zone behind this plant when initialized.
	var/do_transparency = TRUE
	/// If do_transparency == TRUE, this is the target alpha that the plant will have.
	var/transparency_alpha = 150
	/// X and Y will be randomized to spread flora around and reduce the amount of plants that are perfectly centered on their tiles. Only works if the plant's x and y are 0.
	var/randomize_xy = TRUE

/obj/structure/flora/Initialize()
	. = ..()
	if(randomize_xy && pixel_y == 0 && pixel_x == 0)
		pixel_y = rand(-12, 12)
		pixel_x = rand(-12, 12)

	if(icon && do_transparency == TRUE && ((layer > MOB_LAYER) || (layer == MOB_LAYER && plane >= ABOVE_ALL_MOB_LAYER)))
		CreateTransparency()

//Creates a generously sized transparency datum which covers the size of the sprite's icon + 1 tile around it.
/obj/structure/flora/proc/CreateTransparency()
	if(icon)
		var/icon/i = icon(icon)
		var/ih = i.Height()
		var/iw = i.Width()
		if(ih > 32 || iw > 32)
			var/xsize = CEILING(iw/32, 1)
			var/ysize = CEILING(ih/32, 1)
			var/x_off = 0 //-(ih/2)/32 //Slide to the left (nvm it already slides automatically)
			var/y_off = 1
			AddComponent(/datum/component/largetransparency, x_off, y_off, xsize, ysize, target_alpha = transparency_alpha)

/obj/structure/flora/tree/oak_one
	name = "tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tree_1"
	anchored = TRUE

/obj/structure/flora/tree/oak_two
	name = "tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tree_2"
	anchored = TRUE

/obj/structure/flora/tree/oak_three
	name = "tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tree_3"
	anchored = TRUE

/obj/structure/flora/tree/oak_four
	name = "tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tree_4"
	anchored = TRUE
	density = FALSE

/obj/structure/flora/tree/oak_five
	name = "tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tree_5"
	anchored = TRUE

/obj/structure/flora/tree/cactus_alt
	name = "cactus"
	desc = "least this one doesn't talk"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "cactus"
	anchored = TRUE

/obj/structure/flora/tree/african_acacia
	name = "acacia tree"
	desc = "That sure is a tree."
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "african_acacia"
	anchored = TRUE

/obj/structure/flora/tree/african_acacia_dead
	name = "acacia tree"
	desc = "That sure is a tree."
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "african_acacia_dead"
	anchored = TRUE

/obj/structure/flora/tree/african_acacia_alt
	name = "acacia tree"
	desc = "That sure is a tree."
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "african_acaciaX"
	anchored = TRUE

/obj/structure/flora/tree/med_pine
	name = "tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "med_pine"
	anchored = TRUE
	density = FALSE

/obj/structure/flora/tree/cherryblossom
	name = "tree"
	desc = "Leaves on the vine, falling so slow."
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "cherry_blossom_1"
	anchored = TRUE

/obj/structure/flora/tree/cherryblossom2
	name = "tree"
	desc = "Leaves on the vine, falling so slow."
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "cherry_blossom_2"
	anchored = TRUE

/obj/structure/flora/tree/cherryblossom2
	name = "tree"
	desc = "Leaves on the vine, falling so slow."
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "cherry_blossom_2"
	anchored = TRUE

/obj/structure/flora/tree/cherryblossom3
	name = "tree"
	desc = "Leaves on the vine, falling so slow."
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "cherry_blossom_3"
	anchored = TRUE

/obj/structure/flora/tree/cherryblossom4
	name = "tree"
	desc = "Leaves on the vine, falling so slow."
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "cherry_blossom_4"
	anchored = TRUE

/obj/structure/flora/tree/med_pine_dead
	name = "tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "med_pine_dead"
	anchored = TRUE
	density = FALSE

/obj/structure/flora/grass/coyote/one
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "1"
	anchored = TRUE

/obj/structure/flora/grass/coyote/two
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "2"
	anchored = TRUE

/obj/structure/flora/grass/coyote/three
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "3"
	anchored = TRUE

/obj/structure/flora/grass/coyote/four
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "4"
	anchored = TRUE

/obj/structure/flora/grass/coyote/five
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "5"
	anchored = TRUE

/obj/structure/flora/grass/coyote/six
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "6"
	anchored = TRUE

/obj/structure/flora/grass/coyote/seven
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "7"
	anchored = TRUE

/obj/structure/flora/grass/coyote/eight
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "8"
	anchored = TRUE

/obj/structure/flora/grass/coyote/nine
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "9"
	anchored = TRUE
/obj/structure/flora/grass/coyote/ten
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "10"
	anchored = TRUE

/obj/structure/flora/grass/coyote/eleven
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "11"
	anchored = TRUE

/obj/structure/flora/grass/coyote/twelve
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "12"
	anchored = TRUE

/obj/structure/flora/grass/coyote/thirteen
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "13"
	anchored = TRUE

/obj/structure/flora/grass/coyote/fourteen
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "14"
	anchored = TRUE

/obj/structure/flora/grass/coyote/fiveteen
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "15"
	anchored = TRUE

/obj/structure/flora/grass/coyote/sixteen
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "16"
	anchored = TRUE

/obj/structure/flora/grass/coyote/seventeen
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "17"
	anchored = TRUE

/obj/structure/flora/grass/coyote/eighteen
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "18"
	anchored = TRUE

/obj/structure/flora/grass/coyote/nineteen
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "19"
	anchored = TRUE

/obj/structure/flora/grass/coyote/twenty
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "20"
	anchored = TRUE

/obj/structure/flora/grass/coyote/twentyone
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "21"
	anchored = TRUE

/obj/structure/flora/grass/coyote/twentytwo
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "22"
	anchored = TRUE

/obj/structure/flora/grass/coyote/twentythree
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "23"
	anchored = TRUE

/obj/structure/flora/grass/coyote/twentyfour
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "24"
	anchored = TRUE

/obj/structure/flora/grass/coyote/twentyfive
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "25"
	anchored = TRUE

/obj/structure/flora/grass/coyote/twentysix
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "26"
	anchored = TRUE

/obj/structure/flora/grass/coyote/twentyseven
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "27"
	anchored = TRUE

/obj/structure/flora/grass/coyote/twentyeight
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "28"
	anchored = TRUE

/obj/structure/flora/grass/coyote/twentynine
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "29"
	anchored = TRUE

/obj/structure/flora/grass/coyote/thirty
	name = "dead grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "30"
	anchored = TRUE

/obj/structure/flora/small_bush
	name = "small bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "small_bush"
	anchored = TRUE

/obj/structure/flora/big_bush
	name = "big bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "big_bush"
	anchored = TRUE

/obj/structure/flora/tree/thick_tree
	name = "tree"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "thick_tree"
	anchored = TRUE

/obj/structure/flora/jungle1
	name = "bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "jungle1"
	anchored = TRUE

/obj/structure/flora/jungle2
	name = "bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "jungle2"
	anchored = TRUE

/obj/structure/flora/jungle3
	name = "bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "jungle3"
	anchored = TRUE

/obj/structure/flora/jungle4
	name = "bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "jungle4"
	anchored = TRUE

/obj/structure/flora/jungle5
	name = "bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "jungle5"
	anchored = TRUE

/obj/structure/flora/jungle6
	name = "bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "jungle6"
	anchored = TRUE

/obj/structure/flora/burnedbush1
	name = "burned bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedbush1"
	anchored = TRUE

/obj/structure/flora/burnedbush3
	name = "burned bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedbush3"
	anchored = TRUE

/obj/structure/flora/burnedbush4
	name = "burned bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedbush4"
	anchored = TRUE

/obj/structure/flora/burnedbush5
	name = "burned bush"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedbush5"
	anchored = TRUE

/obj/structure/flora/burnedtree1
	name = "burned tree"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedtree1"
	anchored = TRUE

/obj/structure/flora/burnedtree2
	name = "burned tree"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedtree2"
	anchored = TRUE

/obj/structure/flora/burnedtree3
	name = "burned tree"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedtree3"
	anchored = TRUE

/obj/structure/flora/burnedtree4
	name = "burned tree"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedtree4"
	anchored = TRUE

/obj/structure/flora/burnedtree5
	name = "burned tree"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedtree5"
	anchored = TRUE

/obj/structure/flora/burnedlog
	name = "burned log"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedbush10"
	anchored = TRUE

/obj/structure/flora/twig
	name = "twigs"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedbush6"
	anchored = TRUE

/obj/structure/flora/twig2
	name = "twigs"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedbush7"
	anchored = TRUE

/obj/structure/flora/twig3
	name = "twigs"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedbush8"
	anchored = TRUE

/obj/structure/flora/twig4
	name = "twigs"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "burnedbush9"
	anchored = TRUE

/obj/structure/flora/tallgrass6
	name = "tall grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tall_grass_6"
	anchored = TRUE

/obj/structure/flora/tallgrass7
	name = "tall grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tall_grass_7"
	anchored = TRUE

/obj/structure/flora/tallgrass8
	name = "tall grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tall_grass_8"
	anchored = TRUE

/obj/structure/flora/tallgrass9
	name = "tall grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tall_grass_9"
	anchored = TRUE

/obj/structure/flora/tallgrass1
	name = "tall grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tall_grass_1"
	anchored = TRUE

/obj/structure/flora/tallgrass2
	name = "tall grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tall_grass_2"
	anchored = TRUE

/obj/structure/flora/tallgrass3
	name = "tall grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tall_grass_3"
	anchored = TRUE

/obj/structure/flora/tallgrass4
	name = "tall grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tall_grass_4"
	anchored = TRUE

/obj/structure/flora/tallgrass5
	name = "tall grass"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "tall_grass_5"
	anchored = TRUE

/obj/structure/groundcovering/snow
	name = "snow"
	icon = 'icons/turf/walls/mountain_wall.dmi'
	icon_state = "snow"
	anchored = TRUE

//Flora from Chompers.

//Trees
/obj/structure/flora/tree/chomp/palmtreeb
	name = "palm tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "palmtreeb"
	anchored = TRUE

/obj/structure/flora/tree/chomp/palmtreeb1
	name = "palm tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "palmtreeb1"
	anchored = TRUE

/obj/structure/flora/tree/chomp/palmtreech
	name = "palm tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "palmtree"
	anchored = TRUE

/obj/structure/flora/tree/chomp/palmtreech1
	name = "palm tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "palmtree1"
	anchored = TRUE

/obj/structure/flora/tree/chomp/mpalmtreeb
	name = "palm tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "mpalmtreeb"
	anchored = TRUE

/obj/structure/flora/tree/chomp/mpalmtreeb1
	name = "palm tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "mpalmtreeb1"
	anchored = TRUE

/obj/structure/flora/tree/chomp/mpalmtree
	name = "palm tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "mpalmtree"
	anchored = TRUE

/obj/structure/flora/tree/chomp/spalmtree
	name = "palm tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "spalmtree"
	anchored = TRUE

/obj/structure/flora/tree/chomp/spalmtree1
	name = "palm tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "spalmtree1"
	anchored = TRUE

/obj/structure/flora/tree/chomp/spalmtree3
	name = "palm tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "spalmtree3"
	anchored = TRUE

/obj/structure/flora/tree/chomp/spalmtree4
	name = "palm tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "spalmtree4"
	anchored = TRUE

/obj/structure/flora/tree/chomp/desert_tree
	name = "tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "desert_tree"
	anchored = TRUE

/obj/structure/flora/tree/chomp/desert_tree1
	name = "tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "desert_tree1"
	anchored = TRUE

/obj/structure/flora/tree/chomp/desert_tree3
	name = "tree"
	desc = "woody"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "desert_tree3"
	anchored = TRUE

/obj/structure/flora/chomp/large_boulder
	name = "large rock"
	desc = "best not to be caught between it."
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "large_boulder"
	anchored = TRUE

/obj/structure/flora/chomp/tall_boulder
	name = "large rock"
	desc = "best not to be caught between it."
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "tall_boulder"
	anchored = TRUE

/obj/structure/flora/chomp/boulder
	name = "large rock"
	desc = "best not to be caught between it."
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "boulder"
	anchored = TRUE

/obj/structure/flora/tree/chomp/lcactus
	name = "cactus"
	desc = "Jump on it!"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "lcactus"
	anchored = TRUE

/obj/structure/flora/tree/chomp/lcactus1
	name = "cactus"
	desc = "Jump on it!"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "lcactus1"
	anchored = TRUE

/obj/structure/flora/tree/chomp/lcactus2
	name = "cactus"
	desc = "Jump on it!"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "lcactus2"
	anchored = TRUE

/obj/structure/flora/tree/chomp/lcactus3
	name = "cactus"
	desc = "Jump on it!"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "lcactus3"
	anchored = TRUE

/obj/structure/flora/chomp/palmstump
	name = "palm stump"
	desc = "kinda stumpy"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "palmrs_stump"
	anchored = TRUE
	density = FALSE

/obj/structure/flora/chomp/palmstump1
	name = "palm stump"
	desc = "kinda stumpy"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "palmls_stump"
	anchored = TRUE
	density = FALSE

/obj/structure/flora/chomp/palmstump2
	name = "palm stump"
	desc = "kinda stumpy"
	icon = 'modular_coyote/icons/objects/desert_planet_160x160.dmi'
	icon_state = "palml_stump"
	anchored = TRUE
	density = FALSE

/obj/structure/flora/chomp/palmstump3
	name = "palm stump"
	desc = "kinda stumpy"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "palmr_stump"
	anchored = TRUE
	density = FALSE

/obj/structure/flora/chomp/desertstump
	name = "tree stump"
	desc = "kinda stumpy"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "desert_stump"
	anchored = TRUE
	density = FALSE

/obj/structure/flora/chomp/potplant0
	name = "Potted Plant"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "potplant0"
	anchored = TRUE

/obj/structure/flora/chomp/potplant1
	name = "Potted Plant"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "potplant1"
	anchored = TRUE

/obj/structure/flora/chomp/potplant2
	name = "Potted Plant"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "potplant2"
	anchored = TRUE

/obj/structure/flora/chomp/thicket0
	name = "thicket"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "thicket0"
	anchored = TRUE

/obj/structure/flora/chomp/thicket1
	name = "thicket"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "thicket1"
	anchored = TRUE

/obj/structure/flora/chomp/thicket2
	name = "thicket"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "thicket2"
	anchored = TRUE

/obj/structure/flora/chomp/thicket3
	name = "thicket"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "thicket3"
	anchored = TRUE

/obj/structure/flora/chomp/thicket4
	name = "thicket"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "thicket4"
	anchored = TRUE

/obj/structure/flora/chomp/thicket5
	name = "thicket"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "thicket5"
	anchored = TRUE

/obj/structure/flora/chomp/thicket6
	name = "thicket"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "thicket6"
	anchored = TRUE

/obj/structure/flora/chomp/shrub0
	name = "shrub"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "shrub0"
	anchored = TRUE

/obj/structure/flora/chomp/shrub1
	name = "shrub"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "shrub1"
	anchored = TRUE

/obj/structure/flora/chomp/shrub2
	name = "shrub"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "shrub2"
	anchored = TRUE

/obj/structure/flora/chomp/shrub3
	name = "shrub"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "shrub3"
	anchored = TRUE

/obj/structure/flora/chomp/shrub4
	name = "shrub"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "shrub4"
	anchored = TRUE

/obj/structure/flora/chomp/shrub5
	name = "shrub"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "shrub5"
	anchored = TRUE

/obj/structure/flora/chomp/bush0
	name = "bush"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "bush0"
	anchored = TRUE

/obj/structure/flora/chomp/bush1
	name = "bush"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "bush1"
	anchored = TRUE

/obj/structure/flora/chomp/bush2
	name = "bush"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "bush2"
	anchored = TRUE

/obj/structure/flora/chomp/bush3
	name = "bush"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "bush3"
	anchored = TRUE

/obj/structure/flora/chomp/bush5
	name = "bush"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "bush5"
	anchored = TRUE

/obj/structure/flora/chomp/barrelcacti0
	name = "barrel cactus"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "barrelcacti0"
	anchored = TRUE

/obj/structure/flora/chomp/barrelcacti1
	name = "barrel cactus"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "barrelcacti1"
	anchored = TRUE

/obj/structure/flora/chomp/barrelcacti2
	name = "barrel cactus"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "barrelcacti2"
	anchored = TRUE

/obj/structure/flora/chomp/barrelcacti3
	name = "barrel cactus"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "barrelcacti3"
	anchored = TRUE

/obj/structure/flora/chomp/anthill0
	name = "ant hill"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "anthill0"
	anchored = TRUE

/obj/structure/flora/chomp/anthill1
	name = "ant hill"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "anthill1"
	anchored = TRUE

/obj/structure/flora/chomp/anthill2
	name = "ant hill"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "anthill2"
	anchored = TRUE

/obj/structure/flora/chomp/palmy0
	name = "palm bush"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "palmy0"
	anchored = TRUE

/obj/structure/flora/chomp/palmy1
	name = "palm bush"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "palmy1"
	anchored = TRUE

/obj/structure/flora/chomp/palmy2
	name = "palm bush"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "palmy2"
	anchored = TRUE

/obj/structure/flora/chomp/shrubber0
	name = "shrubbery"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "shrubber0"
	anchored = TRUE

/obj/structure/flora/chomp/shrubber1
	name = "shrubbery"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "shrubber1"
	anchored = TRUE

/obj/structure/flora/chomp/shrubber2
	name = "shrubbery"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "shrubber2"
	anchored = TRUE

/obj/structure/flora/chomp/lbarrelcacti0
	name = "barrel cactus"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "lbarrelcacti0"
	anchored = TRUE

/obj/structure/flora/chomp/lbarrelcacti1
	name = "barrel cactus"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "lbarrelcacti1"
	anchored = TRUE

/obj/structure/flora/chomp/lbarrelcacti2
	name = "barrel cactus"
	icon = 'modular_coyote/icons/objects/desert_plant.dmi'
	icon_state = "lbarrelcacti2"
	anchored = TRUE

/obj/structure/flora/chomp/palmuria
	name = "palmuria"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "palmuria"
	anchored = TRUE

/obj/structure/flora/chomp/palmuria1
	name = "palmuria"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "palmuria1"
	anchored = TRUE

/obj/structure/flora/chomp/bones/lribs
	name = "ribs"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "lribs"
	anchored = TRUE

/obj/structure/flora/chomp/bones/lribs1
	name = "ribs"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "lribs1"
	anchored = TRUE

/obj/structure/flora/chomp/bones/lskull
	name = "skull"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "lskull"
	anchored = TRUE

/obj/structure/flora/chomp/bones/lskull_w
	name = "forested skull"
	desc = "\"If we are really dying, let us hear the rattle in our throats and feel cold in the extremities; if we are alive, let us go about our business.\" <br> <br> Beast, what were you, how did you die?"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "lskull_wood"
	anchored = TRUE

/obj/structure/flora/chomp/bones/lbone
	name = "bone"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "lbone"
	anchored = TRUE


/obj/structure/flora/chomp/bones/lrock
	name = "rock"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "lrock"
	anchored = TRUE
	opacity = 1
	density = 1
	resistance_flags = INDESTRUCTIBLE

/obj/structure/flora/chomp/bones/lrock1
	name = "rock"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "lrock1"
	anchored = TRUE
	opacity = 1
	density = 1
	resistance_flags = INDESTRUCTIBLE

/obj/structure/flora/chomp/bones/lrock2
	name = "rock"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "lrock2"
	anchored = TRUE
	opacity = 1
	density = 1
	resistance_flags = INDESTRUCTIBLE

/obj/structure/flora/chomp/bones/lrock3
	name = "rock"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "lrock3"
	anchored = TRUE
	opacity = 1
	density = 1
	resistance_flags = INDESTRUCTIBLE

/obj/structure/flora/chomp/bones/lrock4
	name = "rock"
	icon = 'modular_coyote/icons/objects/desert_props_64x64.dmi'
	icon_state = "lrock4"
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE

/obj/structure/flora/wild_plant/thistle
	name = "thistle"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "thistle"
	anchored = TRUE

/obj/structure/flora/wild_plant/petunia
	name = "Petunia"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "petunia"
	anchored = TRUE

/obj/structure/flora/wild_plant/petunia/blue
	name = "Petunia"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "petunia_blue"
	anchored = TRUE

/obj/structure/flora/wild_plant/petunia/purple
	name = "Petunia"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "petunia_purple"
	anchored = TRUE

/obj/structure/flora/wild_plant/petunia/purplewhite
	name = "Petunia"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "petunia_purplewhite"
	anchored = TRUE

/obj/structure/flora/wild_plant/petunia/redwhite
	name = "Petunia"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "petunia_redwhite"
	anchored = TRUE

/obj/structure/flora/wild_plant/petunia/bluewhite
	name = "Petunia"
	icon = 'modular_coyote/icons/objects/flora.dmi'
	icon_state = "petunia_bluewhite"
	anchored = TRUE

/obj/structure/flora/tree/pink_tree
	name = "Pink tree"
	icon = 'modular_coyote/icons/objects/trees.dmi'
	icon_state = "pink_tree"
	anchored = TRUE

/obj/structure/flora/tree/cypress_tree
	name = "cypress tree"
	icon = 'modular_coyote/icons/objects/cypress.dmi'
	icon_state = "cypress_tree"
	anchored = TRUE
	pixel_x = -48

/obj/structure/flora/tree/rainforest_tree
	name = "rainforest tree"
	icon = 'modular_coyote/icons/objects/cypress.dmi'
	icon_state = "rainforest_tree"
	anchored = TRUE



//flowers

/obj/structure/flora/wild_plant/flower/orange
	name = "orange flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_orange"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/blue
	name = "blue flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_blue"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/pink
	name = "pink flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_pink"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/purple
	name = "purple flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_purple"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/red
	name = "red flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_red"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/white
	name = "white flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_white"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/pink_two
	name = "pink flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_pink2"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/red_two
	name = "red flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_red2"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/blue_two
	name = "blue flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_blue2"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/purple_two
	name = "purple flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_purple2"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/yellowhite
	name = "yellow and white flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_yw"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/pink_three
	name = "pink flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_pink3"
	anchored = TRUE

/obj/structure/flora/wild_plant/flower/pink_four
	name = "pink flowers"
	icon = 'modular_coyote/icons/objects/flowers.dmi'
	icon_state = "flower_pink4"
	anchored = TRUE
