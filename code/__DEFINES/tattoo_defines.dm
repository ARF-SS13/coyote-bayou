/* 
 * Tattoo defines!
 */
/// Can customize tattoo name
#define TATTOO_CUSTOMIZE_NAME (1<<0)
/// Can customize tattoo desc
#define TATTOO_CUSTOMIZE_DESC (1<<1)
/// Can customize tattoo extras
#define TATTOO_CUSTOMIZE_EXTRA (1<<3)
/// Can customize tattoo time to fade
#define TATTOO_CUSTOMIZE_FADE_TIME (1<<4)
/// Can customize tattoo all of it
#define TATTOO_CUSTOMIZE_ALL TATTOO_CUSTOMIZE_NAME | TATTOO_CUSTOMIZE_DESC | TATTOO_CUSTOMIZE_EXTRA | TATTOO_CUSTOMIZE_FADE_TIME
/// Customize the name
#define TATTOO_NAME "Name"
/// Customize the desc
#define TATTOO_DESC "Desc"
/// Customize the extra
#define TATTOO_EXTRA "Extra Details"
/// Customize time for tattoo to fade
#define TATTOO_FADE_TIME "Fade Time"

#define TATTOO_NOT_FADED 1
#define TATTOO_KINDA_FADED 2
#define TATTOO_VERY_FADED 3

/// Tattoo can be applied as many times as you want
#define UNLIMITED_TATTOO -1

/* 
 * Locations for tattoos to go
 */
#define TATTOO_FUCKUP "Bepis" // Tattoo didnt initialize right or something
#define TATTOO_TRAMP_STAMP "Sacrum"
#define TATTOO_WOMB_TATTOO "Upper Groin" // river tat
#define TATTOO_LEFT_ASS "Left Buttock"
#define TATTOO_RIGHT_ASS "Right Buttock"
#define TATTOO_LEFT_BOOB "Left Breast"
#define TATTOO_RIGHT_BOOB "Right Breast"
#define TATTOO_CHEST "Chest" // totally different from boob
#define TATTOO_BELLY "Abdomen" // monkey bent over, belly button in the right (wrong) place
#define TATTOO_UPPER_BACK "Upper Back"
#define TATTOO_LOWER_BACK "Lower Back"
#define TATTOO_RIGHT_UPPER_ARM "Right Shoulder"
#define TATTOO_RIGHT_LOWER_ARM "Right Forearm"
#define TATTOO_RIGHT_HAND "Right Hand"
#define TATTOO_LEFT_UPPER_ARM "Left Shoulder"
#define TATTOO_LEFT_LOWER_ARM "Left Forearm"
#define TATTOO_LEFT_HAND "Left Hand"
#define TATTOO_RIGHT_UPPER_LEG "Right Hip"
#define TATTOO_RIGHT_LOWER_LEG "Right Calf"
#define TATTOO_RIGHT_FOOT "Right Foot"
#define TATTOO_LEFT_UPPER_LEG "Left Hip"
#define TATTOO_LEFT_LOWER_LEG "Left Calf"
#define TATTOO_LEFT_FOOT "Left Foot"
#define TATTOO_LEFT_CHEEK "Left Cheek"
#define TATTOO_RIGHT_CHEEK "Right Cheek"
#define TATTOO_LEFT_EYE "Left Eyelid"
#define TATTOO_RIGHT_EYE "Right Eyelid"
#define TATTOO_FOREHEAD "Forehead" // somethign something guy with a tattoo'd forehead gonna get us all killed!
#define TATTOO_BIKER_RIGHT_SHOULDER "Right Upper Arm" // used by bikers so that it doesnt overlap with any other tats

#define OUTFIT_TATTOO(tatpath, spot) tatpath = spot

#define TATTOO_IS_HIDDEN_UNDERWEAR(target, location) (ishuman(target) && target.hidden_underwear == FALSE && (location in list(\
	TATTOO_TRAMP_STAMP,\
	TATTOO_WOMB_TATTOO)))

#define TATTOO_IS_HIDDEN_BRA(target, location) (ishuman(target) && target.hidden_undershirt == FALSE && (location in list(\
	TATTOO_LEFT_BOOB,\
	TATTOO_RIGHT_BOOB)))

#define TATTOO_IS_HIDDEN_SOCKS(target, location) (ishuman(target) && target.hidden_socks == FALSE && (location in list(\
	TATTOO_LEFT_FOOT,\
	TATTOO_RIGHT_FOOT)))

/// Lookup table for what locations there are on limbs for tats
/// Kept general, you aim for a limb, and then choose the sub-location
/// TRUE means its free for people to use, FALSE means it can only be applied via outfitting
GLOBAL_LIST_INIT(tattoo_locations, list(
	BODY_ZONE_HEAD = list(
		TATTOO_LEFT_CHEEK = TRUE,
		TATTOO_RIGHT_CHEEK = TRUE,
		TATTOO_LEFT_EYE = TRUE,
		TATTOO_RIGHT_EYE = TRUE,
		TATTOO_FOREHEAD = TRUE,
		),
	BODY_ZONE_CHEST = list(
		TATTOO_TRAMP_STAMP = TRUE,
		TATTOO_WOMB_TATTOO = TRUE,
		TATTOO_CHEST = TRUE,
		TATTOO_BELLY = TRUE,
		TATTOO_UPPER_BACK = TRUE,
		TATTOO_LOWER_BACK = TRUE,
		TATTOO_LEFT_BOOB = TRUE,
		TATTOO_RIGHT_BOOB = TRUE,
	),
	BODY_ZONE_L_ARM = list(
		TATTOO_LEFT_UPPER_ARM = TRUE,
		TATTOO_LEFT_LOWER_ARM = TRUE,
		TATTOO_LEFT_HAND = TRUE,
	),
	BODY_ZONE_R_ARM = list(
		TATTOO_RIGHT_UPPER_ARM = TRUE,
		TATTOO_RIGHT_LOWER_ARM = TRUE,
		TATTOO_RIGHT_HAND = TRUE,
		TATTOO_BIKER_RIGHT_SHOULDER = FALSE,
	),
	BODY_ZONE_L_LEG = list(
		TATTOO_LEFT_UPPER_LEG = TRUE,
		TATTOO_LEFT_LOWER_LEG = TRUE,
		TATTOO_LEFT_ASS = TRUE,
		TATTOO_LEFT_FOOT = TRUE,
	),
	BODY_ZONE_R_LEG = list(
		TATTOO_RIGHT_UPPER_LEG = TRUE,
		TATTOO_RIGHT_LOWER_LEG = TRUE,
		TATTOO_RIGHT_ASS = TRUE,
		TATTOO_RIGHT_FOOT = TRUE,
	),
))
