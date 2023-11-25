//Global defines for most of the unmentionables.
//Be sure to update the min/max of these if you do change them.
//Measurements are in imperial units. Inches, feet, yards, miles. Tsp, tbsp, cups, quarts, gallons, etc

/// Defines for SSgenitals to store both a weakref of a mob, and a fuckhuge list of images
#define GENITAL_MOBREF "mob_weakref"
#define GENITAL_SPRITES "genital"

//Filters
#define CIT_FILTER_STAMINACRIT filter(type="drop_shadow", x=0, y=0, size=-3, color="#04080F")

//organ defines
#define BUTT_LAYER_INDEX		1
#define VAGINA_LAYER_INDEX		2
#define TESTICLES_LAYER_INDEX	3
#define GENITAL_LAYER_INDEX		4
#define PENIS_LAYER_INDEX		5
#define BELLY_LAYER_INDEX		6
#define BREAST_LAYER_INDEX		7

#define GENITAL_LAYER_INDEX_LENGTH 7 //keep it updated with each new index added, thanks.

//cockstring defines
#define CS_BUTT "has_butt"
#define CS_VAG "has_vag"
#define CS_BALLS "has_balls"
#define CS_WOMB "has_womb"
#define CS_MISC "idk"
#define CS_PENIS "has_cock"
#define CS_BELLY "has_belly"
#define CS_BOOB "has_breasts"

//encodes the layering order -- ONLY WORKS FOR VISIBLE GENITALS!!! so keep womb out pls
#define DEF_COCKSTRING "has_butt:has_vag:has_balls:has_cock:has_belly:has_breasts"

//genital flags
#define GENITAL_BLACKLISTED      	(1<<0) //for genitals that shouldn't be added to GLOB.genitals_list.
#define GENITAL_INTERNAL         	(1<<1) //no visibility options~
#define GENITAL_FLUID_PRODUCTION 	(1<<2)
#define CAN_MASTURBATE_WITH      	(1<<3)
#define MASTURBATE_LINKED_ORGAN	 	(1<<4) //used to pass our mission to the linked organ
#define CAN_CLIMAX_WITH          	(1<<5)
#define GENITAL_CAN_AROUSE       	(1<<6)
#define UPDATE_OWNER_APPEARANCE  	(1<<7)
#define GENITAL_CAN_TAUR        	(1<<8)
#define GENITAL_CAN_RECOLOR      	(1<<9)
#define GENITAL_CAN_RESIZE       	(1<<10)
#define GENITAL_CAN_RESHAPE      	(1<<11)
#define GENITAL_CAN_HAVE         	(1<<12) //Sandstorm change
#define HAS_EQUIPMENT				(1<<13) //nother sandstorm change
#define GENITAL_CAN_STUFF       	(1<<14) //Splurt edit, used for pregnancy
#define GENITAL_CHASTENED			(1<<15) //SPLURT edit
#define GENITAL_IMPOTENT			(1<<16) //SPLURT edit
#define GENITAL_EDGINGONLY			(1<<17) //SPLURT edit
#define GENITAL_DISAPPOINTING		(1<<18)	//SPLURT edit
#define GENITAL_OVERSTIM			(1<<19) //SPLURT edit
#define GENITAL_HYPERSENS			(1<<20) //SPLURT edit
#define CAN_CUM_INTO 				(1<<21)

//DEfault genital flags, for preferences
#define DEF_BUTT_FLAGS GENITAL_CAN_RECOLOR | GENITAL_CAN_RESIZE | GENITAL_CAN_HAVE
#define DEF_VAG_FLAGS GENITAL_CAN_RECOLOR | GENITAL_CAN_RESHAPE | GENITAL_CAN_HAVE
#define DEF_WOMB_FLAGS GENITAL_CAN_HAVE
#define DEF_BALLS_FLAGS GENITAL_CAN_RECOLOR | GENITAL_CAN_RESHAPE | GENITAL_CAN_HAVE | GENITAL_CAN_RESIZE
#define DEF_PENIS_FLAGS GENITAL_CAN_RECOLOR | GENITAL_CAN_RESHAPE | GENITAL_CAN_RESIZE | GENITAL_CAN_HAVE
#define DEF_BREASTS_FLAGS GENITAL_CAN_RECOLOR | GENITAL_CAN_RESHAPE | GENITAL_CAN_RESIZE | GENITAL_CAN_HAVE
#define DEF_BELLY_FLAGS GENITAL_CAN_RECOLOR | GENITAL_CAN_RESHAPE | GENITAL_CAN_RESIZE | GENITAL_CAN_HAVE

//NEW genital flags
#define GENITAL_NO_OVERRIDE       (1<<0) // Not actually used, passed to the visibility toggle to unset the lower two
#define GENITAL_ALWAYS_HIDDEN     (1<<1) // Always hidden
#define GENITAL_ALWAYS_VISIBLE    (1<<2) // Always visible
#define GENITAL_ABOVE_UNDERWEAR   (1<<3) // If visible, is it above underwear?
#define GENITAL_ABOVE_CLOTHING    (1<<4) // If visible, is it above clothing?
#define GENITAL_UNDER_UNDERWEAR   (1<<5) // If visible, is it above clothing?
#define GENITAL_RESPECT_UNDERWEAR (1<<6) // Does it factor in underwear as coverage?
#define GENITAL_RESPECT_CLOTHING  (1<<7) // Does it factor in uniform/suit as coverage?
#define GENITAL_MAX               (1<<8) // The absolute maximum value that can be set

#define GENITAL_FLAGS_MIN GENITAL_ALWAYS_HIDDEN // update this if you add/remove flags
#define GENITAL_FLAGS_MAX GENITAL_MAX // update this if you add/remove flags
//We cannot set the max to GENITAL_RESPECT_CLOTHING because if we respect clothing and do ANYTHING ELSE, we exceed the max and it gets reset

#define GEN_VIS_FLAG_DEFAULT GENITAL_RESPECT_UNDERWEAR | GENITAL_RESPECT_CLOTHING
#define GEN_VIS_OVERALL_FLAG_DEFAULT GENITAL_ABOVE_UNDERWEAR
#define IS_GENITAL_VIS_OVERRIDE(x) (CHECK_BITFIELD(x,GENITAL_NO_OVERRIDE) || CHECK_BITFIELD(x,GENITAL_ALWAYS_HIDDEN) || CHECK_BITFIELD(x,GENITAL_ALWAYS_VISIBLE))

//genital dislike flags
#define HIDE_BUTT	(1<<0)
#define HIDE_VAG	(1<<1)
#define HIDE_BALLS	(1<<2)
#define HIDE_PENIS	(1<<3)
#define HIDE_BELLY	(1<<4)
#define HIDE_BOOBS	(1<<5)
#define HIDE_MISC	(1<<6)

#define DEF_VAGINA_SHAPE	"Human"

#define COCK_SIZE_DEF		6

#define COCK_DIAMETER_RATIO_MAX		0.42
#define COCK_DIAMETER_RATIO_DEF		0.25
#define COCK_DIAMETER_RATIO_MIN		0.15

#define DEF_COCK_SHAPE		"Human"

#define BALLS_VOLUME_BASE	25
#define BALLS_VOLUME_MULT	1

#define DEF_BALLS_SHAPE		"Pair of testicles"

#define BALLS_SIZE_MIN		1
#define BALLS_SIZE_DEF		2
#define BALLS_SIZE_MAX		5

#define CUM_RATE			2 // units per 10 seconds
#define CUM_RATE_MULT		1
#define CUM_EFFICIENCY		1 //amount of nutrition required per life()

#define BREASTS_VOLUME_BASE	50	//base volume for the reagents in the breasts, multiplied by the size then multiplier. 50u for A cups, 850u for HH cups.
#define BREASTS_VOLUME_MULT	1	//global multiplier for breast volume.

#define BREASTS_SIZE_DEF	"c" //lowercase cause those sprite accessory don't use uppercased letters.

#define DEF_BREASTS_SHAPE	"Pair"

#define MILK_RATE			3
#define MILK_RATE_MULT		1
#define MILK_EFFICIENCY		1

#define DEF_BUTT_SHAPE		"Pair"
#define BUTT_SIZE_DEF		1
#define BUTT_SIZE_MIN		1
#define BUTT_SIZE_MAX		8  //butt genitals are special in that they have caps. if there's the event there's even bigger butt sprites, raise this number.

#define DEF_BELLY_SHAPE	"Tummy"
#define BELLY_SHAPE_TUMMY "Tummy" // cute lil round belly
#define BELLY_SHAPE_OBESE "Obese" // blubbery fatass landwhale
#define BELLY_SHAPE_UDDERS "Udders" // haha, udders
#define BELLY_SIZE_DEF 1
#define BELLY_SIZE_MIN 1
#define BELLY_SIZE_MAX 11 // our bellies go up to 11~

//visibility toggles defines to avoid errors typos code errors.
#define GEN_VISIBLE_ALWAYS "Always exposed"
#define GEN_VISIBLE_OVERCLOTHES "Layered over clothes if visible"
#define GEN_VISIBLE_NO_CLOTHES "Layered under clothes if visible"
#define GEN_VISIBLE_NO_UNDIES "Hidden by underwear"
#define GEN_VISIBLE_NEVER "Never exposed"

//Individual logging define
#define INDIVIDUAL_LOOC_LOG "LOOC log"

#define ADMIN_MARKREAD(client) "(<a href='?_src_=holder;markedread=\ref[client]'>MARK READ</a>)"//marks an adminhelp as read and under investigation
#define ADMIN_IC(client) "(<a href='?_src_=holder;icissue=\ref[client]'>IC</a>)"//marks and adminhelp as an IC issue
#define ADMIN_REJECT(client) "(<a href='?_src_=holder;rejectadminhelp=\ref[client]'>REJT</a>)"//Rejects an adminhelp for being unclear or otherwise unhelpful. resets their adminhelp timer

//Citadel istypes
#define isgenital(A) (istype(A, /obj/item/organ/genital))

#define CITADEL_MENTOR_OOC_COLOUR "#224724"

//xenobio console upgrade stuff
#define XENOBIO_UPGRADE_MONKEYS				1
#define XENOBIO_UPGRADE_SLIMEBASIC			2
#define XENOBIO_UPGRADE_SLIMEADV			4

//Citadel toggles because bitflag memes
#define TOGGLES_CITADEL 0 //Master toggle
#define VOREALLOW_DOGBORGS			(1<<0)
#define EATING_NOISES				(1<<1)
#define DIGESTION_NOISES			(1<<2)
#define BREAST_ENLARGEMENT			(1<<3)
#define PENIS_ENLARGEMENT			(1<<4)
#define FORCED_FEM					(1<<5)
#define FORCED_MASC					(1<<6)
#define HYPNO						(1<<7)
#define NEVER_HYPNO					(1<<8)
#define NO_APHRO					(1<<9)
#define NO_ASS_SLAP					(1<<10)
#define BIMBOFICATION				(1<<11)
#define NO_AUTO_WAG					(1<<12)
#define GENITAL_EXAMINE				(1<<13)
#define VOREALLOW_SEEING_BELLY_DESC	(1<<14)
#define BUTT_ENLARGEMENT			(1<<15)
#define BELLY_ENLARGEMENT			(1<<16)
#define BELLY_INFLATION				(1<<17)
#define CHASTITY					(1<<18)
#define STIMULATION					(1<<19)
#define EDGING						(1<<20)
#define CUM_ONTO					(1<<21)

//icon states for the default eyes and for a state for no eye
#define DEFAULT_EYES_TYPE			"normal"
#define DEFAULT_LEFT_EYE_STATE		"normal_left_eye"
#define DEFAULT_RIGHT_EYE_STATE		"normal_right_eye"
#define DEFAULT_NO_EYE_STATE		"no_eye"

//special species definitions
#define MINIMUM_MUTANT_COLOR	"#000000" //I hate poojawa I hate poojawa I hate poojawa I hate poojawa I hate poojawa I hate poojawa I hate poojawa I hate poojawa ~TK

//defines for different matrix sections
#define MATRIX_RED			"red"
#define MATRIX_GREEN		"green"
#define MATRIX_BLUE			"blue"
#define MATRIX_RED_GREEN	"red_green"
#define MATRIX_RED_BLUE		"red_blue"
#define MATRIX_GREEN_BLUE	"green_blue"
#define MATRIX_ALL			"red_green_blue"
#define MATRIX_NONE			"none"

//defines for the two colour schemes, advanced and old
#define OLD_CHARACTER_COLORING			"old_color_system"
#define ADVANCED_CHARACTER_COLORING		"advanced_color_system"

#define GENITAL_VIS_OVERRIDE_SET "cock_visibility_override",\
	"balls_visibility_override",\
	"vag_visibility_override",\
	"breasts_visibility_override",\
	"belly_visibility_override",\
	"butt_visibility_override"
#define GENITAL_VIS_FLAGS_SET "cock_visibility_flags",\
	"balls_visibility_flags",\
	"vag_visibility_flags",\
	"breasts_visibility_flags",\
	"belly_visibility_flags",\
	"butt_visibility_flags"
#define GENITAL_VIS_FLAGS_LIST list("cock_visibility_flags",\
	"balls_visibility_flags",\
	"vag_visibility_flags",\
	"breasts_visibility_flags",\
	"belly_visibility_flags",\
	"butt_visibility_flags")
#define GENITAL_VIS_FLAG_LIST list("Always Visible" = GENITAL_ALWAYS_VISIBLE, "Always Hidden" = GENITAL_ALWAYS_HIDDEN, "Check Coverage" = 0)
#define GENITAL_VIS_FLAG_LIST_CARBON list("Always Visible" = GENITAL_ALWAYS_VISIBLE, "Always Hidden" = GENITAL_ALWAYS_HIDDEN, "Check Coverage" = GENITAL_NO_OVERRIDE)
#define GENITAL_CLOTHING_FLAG_LIST list("Over Clothing" = GENITAL_ABOVE_CLOTHING, "Over Underwear" = GENITAL_ABOVE_UNDERWEAR, "Under Underwear" = 0)
#define GENITAL_CLOTHING_FLAG_LIST_CARBON list("Over Clothing" = GENITAL_ABOVE_CLOTHING, "Over Underwear" = GENITAL_ABOVE_UNDERWEAR, "Under Underwear" = GENITAL_UNDER_UNDERWEAR)
#define GENITAL_VIS_OVERRIDE2FLAGS_LIST list(\
	"cock_visibility_override" = "cock_visibility_flags",\
	"balls_visibility_override" = "balls_visibility_flags",\
	"vag_visibility_override" = "vag_visibility_flags",\
	"breasts_visibility_override" = "breasts_visibility_flags",\
	"belly_visibility_override" = "belly_visibility_flags",\
	"butt_visibility_override" = "butt_visibility_flags")

GLOBAL_LIST_INIT(hasgenital2genital, list(
	"has_butt" = "Butt",
	"has_vag" = "Vagina",
	"has_balls" = "Testicles",
	"has_cock" = "Penis",
	"has_belly" = "Belly",
	"has_womb" = "Womb",
	"has_breasts" = "Breasts"))


/// how many times am I gonna write this shit
#define PREFS_ALL_HAS_GENITALS_SET \
	"has_vag",\
	"has_womb",\
	"has_cock",\
	"has_balls",\
	"has_breasts",\
	"has_butt",\
	"has_belly"
#define PREFS_ALL_HAS_GENITALS list(PREFS_ALL_HAS_GENITALS_SET)
