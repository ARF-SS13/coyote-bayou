
#define WOUND_DAMAGE_EXPONENT 1.2

/// an attack must do this much damage after armor in order to roll for being a wound (incremental pressure damage need not apply)
#define WOUND_MINIMUM_DAMAGE 2
/// an attack must do this much damage after armor in order to be eliigible to dismember a suitably mushed bodypart
#define DISMEMBER_MINIMUM_DAMAGE 10
/// any damage dealt over this is ignored for damage rolls unless the target has the frail quirk (35^1.4=145)
#define WOUND_MAX_CONSIDERED_DAMAGE	100
/// when rolling for wounds, this is the lowest it'll be multiplied by
#define WOUND_DAMAGE_RANDOM_FLOOR_MULT 1
/// when rolling for wounds, this is the highest it'll be multiplied by
#define WOUND_DAMAGE_RANDOM_MAX_MULT 1.5

#define WOUND_SEVERITY_TRIVIAL	0 // for jokey/meme wounds like stubbed toe, no standard messages/sounds or second winds
#define WOUND_SEVERITY_MODERATE	1
#define WOUND_SEVERITY_SEVERE	2
#define WOUND_SEVERITY_CRITICAL	3
#define WOUND_SEVERITY_LOSS		4 // theoretical total limb loss, like dismemberment for cuts

/// any brute weapon/attack that doesn't have sharpness. rolls for blunt bone wounds
#define WOUND_BLUNT 1
/// any brute weapon/attack with sharpness = SHARP_EDGED. rolls for slash wounds
#define WOUND_SLASH 2
/// any brute weapon/attack with sharpness = SHARP_POINTY. rolls for piercing wounds
#define WOUND_PIERCE 3
/// any concentrated burn attack (lasers really). rolls for burning wounds
#define WOUND_BURN 4

/// Wounds considered for paper skin
#define PAPER_SKIN_WOUNDS list(WOUND_SLASH, WOUND_PIERCE, WOUND_BURN)

// How much determination reagent to add each time someone gains a new wound in [/datum/wound/proc/second_wind()]
#define WOUND_DETERMINATION_MODERATE 5
#define WOUND_DETERMINATION_SEVERE 8
#define WOUND_DETERMINATION_CRITICAL 10
#define WOUND_DETERMINATION_LOSS 15

// If limb's bleed damage is above this, cause this level of severity
#define WOUND_BLEED_MODERATE_THRESHOLD 25
#define WOUND_BLEED_SEVERE_THRESHOLD 50
#define WOUND_BLEED_CRITICAL_THRESHOLD 75

/// Below this amount of bleed damage on a limb, remove all bleeding wounds
#define WOUND_BLEED_CLOSE_THRESHOLD (WOUND_BLEED_MODERATE_THRESHOLD * 0.5)

/// How high can wounding on a limb go
#define WOUND_BLEED_CAP 100

// handle_damage check returns
#define WOUND_PROMOTE "promote_wound"
#define WOUND_DEMOTE "demote_wound"
#define WOUND_RENEW "renew_wound"
#define WOUND_DELETE "delete_wound"
#define WOUND_DO_NOTHING "its_fine"

/// the max amount of determination you can have
#define WOUND_DETERMINATION_MAX 20

/// set wound_bonus on an item or attack to this to disable checking wounding for the attack
#define CANT_WOUND -100

// list in order of highest severity to lowest
GLOBAL_LIST_INIT(global_wound_types, list(
	WOUND_BLUNT = list(
		/datum/wound/blunt/critical,
		/datum/wound/blunt/severe,
		/datum/wound/blunt/moderate),
	WOUND_SLASH = list(
		/datum/wound/bleed/slash),
	WOUND_PIERCE = list(
		/datum/wound/bleed/pierce),
	WOUND_BURN = list(
		/datum/wound/burn/critical,
		/datum/wound/burn/severe,
		/datum/wound/burn/moderate)
	))

// List of slash wounds by severity
GLOBAL_LIST_INIT(global_slash_wound_severities, list(
	WOUND_SEVERITY_MODERATE = /datum/wound/bleed/slash/moderate,
	WOUND_SEVERITY_SEVERE = /datum/wound/bleed/slash/severe,
	WOUND_SEVERITY_CRITICAL = /datum/wound/bleed/slash/critical
	))

// List of pierce wounds by severity
GLOBAL_LIST_INIT(global_pierce_wound_severities, list(
	WOUND_SEVERITY_MODERATE = /datum/wound/bleed/pierce/moderate,
	WOUND_SEVERITY_SEVERE = /datum/wound/bleed/pierce/severe,
	WOUND_SEVERITY_CRITICAL = /datum/wound/bleed/pierce/critical
	))

GLOBAL_LIST_INIT(global_all_wound_types, list(
	/datum/wound/blunt/critical,
	/datum/wound/blunt/severe,
	/datum/wound/blunt/moderate,
	/datum/wound/bleed/slash/critical,
	/datum/wound/bleed/slash/severe,
	/datum/wound/bleed/slash/moderate,
	/datum/wound/bleed/pierce/critical,
	/datum/wound/bleed/pierce/severe,
	/datum/wound/bleed/pierce/moderate,
	/datum/wound/burn/critical,
	/datum/wound/burn/severe,
	/datum/wound/burn/moderate))

// Thresholds for infection for burn wounds, once infestation hits each threshold, things get steadily worse
/// below this has no ill effects from infection
#define WOUND_INFECTION_MODERATE	4
/// then below here, you ooze some pus and suffer minor tox damage, but nothing serious
#define WOUND_INFECTION_SEVERE		8
/// then below here, your limb occasionally locks up from damage and infection and briefly becomes disabled. Things are getting really bad
#define WOUND_INFECTION_CRITICAL	12
/// below here, your skin is almost entirely falling off and your limb locks up more frequently. You are within a stone's throw of septic paralysis and losing the limb
#define WOUND_INFECTION_SEPTIC		20
// above WOUND_INFECTION_SEPTIC, your limb is completely putrid and you start rolling to lose the entire limb by way of paralyzation. After 3 failed rolls (~4-5% each probably), the limb is paralyzed


/// how quickly sanitization removes infestation and decays per tick
#define WOUND_BURN_SANITIZATION_RATE 0.4
/// how much blood you can lose per tick per slash max. 8 is a LOT of blood for one cut so don't worry about hitting it easily
#define WOUND_MAX_BLOODFLOW 14
/// dead people don't bleed, but they can clot! this is the minimum amount of clotting per tick on dead people, so even critical cuts will slowly clot in dead people
#define WOUND_SLASH_DEAD_CLOT_MIN 0.05
/// if we suffer a bone wound to the head that creates brain traumas, the timer for the trauma cycle is +/- by this percent (0-100)
#define WOUND_BONE_HEAD_TIME_VARIANCE 20

/// Threshold for moderate wounds to slow down bleeding if the mob has less than this blood volume
#define WOUND_BLEED_MODERATE_BLOOD_LOSS_THRESHOLD BLOOD_VOLUME_SYMPTOMS_ANNOYING + 50
/// Threshold for severe wounds to slow down bleeding if the mob has less than this blood volume
#define WOUND_BLEED_SEVERE_BLOOD_LOSS_THRESHOLD BLOOD_VOLUME_SYMPTOMS_DEBILITATING + 50
/// Threshold for critical wounds to slow down bleeding if the mob has less than this blood volume
#define WOUND_BLEED_CRITICAL_BLOOD_LOSS_THRESHOLD BLOOD_VOLUME_DEATH + 50

/// Multiplier for moderate wounds to slow down bleeding by below the blood volume threshold
#define WOUND_BLEED_MODERATE_BLOOD_LOSS_MULTIPLIER 0.05
/// Multiplier for severe wounds to slow down bleeding by below the blood volume threshold
#define WOUND_BLEED_SEVERE_BLOOD_LOSS_MULTIPLIER 0.05
/// Multiplier for critical wounds to slow down bleeding by below the blood volume threshold
#define WOUND_BLEED_CRITICAL_BLOOD_LOSS_MULTIPLIER 0.005
/// Multiplier for all wounds to slow down bleeding by if they're lying down
#define WOUND_BLEED_LYING_DOWN_MULTIPLIER 0.50

/// Max time cat spit will stay on someone before falling off
#define LICK_MAX_DURATION 5 MINUTES
/// Max time an improvised bandage will stay on someone before falling off
#define BANDAGE_POOR_MAX_DURATION 10 MINUTES
/// Max time a normal bandage will stay on someone before falling off
#define BANDAGE_OKAY_MAX_DURATION 20 MINUTES
/// Max time a sterilized bandage will stay on someone before falling off
#define BANDAGE_GOOD_MAX_DURATION 1 HOURS
/// Bandage is just barely through its life at this point
#define BANDAGE_GOODLIFE_DURATION 0.70
/// Bandage is at half its life at this point
#define BANDAGE_MIDLIFE_DURATION 0.30
/// Bandage is gonna fall off soon
#define BANDAGE_ENDLIFE_DURATION 0.1

/// Max time an improvised suture will stay on someone before falling off
#define SUTURE_POOR_MAX_DURATION 10 MINUTES
/// Max time a normal suture will stay on someone before falling off
#define SUTURE_OKAY_MAX_DURATION 20 MINUTES
/// Max time a sterilized suture will stay on someone before falling off
#define SUTURE_GOOD_MAX_DURATION 1 HOURS
/// Suture is just barely through its life at this point
#define SUTURE_GOODLIFE_DURATION 0.70
/// Suture is at half its life at this point
#define SUTURE_MIDLIFE_DURATION 0.30
/// Suture is gonna fall off soon
#define SUTURE_ENDLIFE_DURATION 0.1

/// ID for the bandage timer
#define BANDAGE_COOLDOWN_ID "bandage_cooldown_id"
/// ID for the suture timer
#define SUTURE_COOLDOWN_ID "suture_cooldown_id"
/// Minimum time between bleed healing ticks
#define BLEED_HEAL_COOLDOWN_TIME 1 SECONDS

/// Multiplier for bleeding if the wound has enough bandaging on it
#define WOUND_BLEED_BANDAGE_MULTIPLIER 0.05

/// Multiplier for bleeding if the wound has enough bandaging on it
#define WOUND_BLEED_BANDAGE_SW_MULTIPLIER 0.0001

/// Multiplier for bleeding if the wound has a lick on it
#define WOUND_BLEED_LICK_MULTIPLIER 0.35

/// Multiplier for bleeding if the wound has enough sutures on it
#define WOUND_BLEED_SUTURE_MULTIPLIER 0 // no blood!

// The following are for persistent scar save formats
/// The version number of the scar we're saving
#define SCAR_SAVE_VERS				1
/// The body_zone we're applying to on granting
#define SCAR_SAVE_ZONE				2
/// The description we're loading
#define SCAR_SAVE_DESC				3
/// The precise location we're loading
#define SCAR_SAVE_PRECISE_LOCATION	4
/// The severity the scar had
#define SCAR_SAVE_SEVERITY			5
///how many fields there are above (NOT INCLUDING THIS OBVIOUSLY)
#define SCAR_SAVE_LENGTH			5

// increment this number when you update the persistent scarring format in a way that invalidates previous saved scars (new fields, reordering, etc)
/// saved scars with a version lower than this will be discarded
#define SCAR_CURRENT_VERSION				1


// With the wounds pt. 2 update, general dismemberment now requires 2 things for a limb to be dismemberable (bone only creatures just need the second):
// 	1. Skin is mangled: A critical slash or pierce wound on that limb
// 	2. Bone is mangled: At least a severe bone wound on that limb
// see [/obj/item/bodypart/proc/get_mangled_state] for more information
#define BODYPART_MANGLED_NONE	0
#define BODYPART_MANGLED_BONE	1
#define BODYPART_MANGLED_FLESH	2
#define BODYPART_MANGLED_BOTH	3

// What kind of biology we have, and what wounds we can suffer, mostly relies on the HAS_FLESH and HAS_BONE species traits on human species
/// golems and androids, cannot suffer any wounds
#define BIO_INORGANIC	0
/// skeletons and plasmemes, can only suffer bone wounds, only needs mangled bone to be able to dismember
#define BIO_JUST_BONE	1
/// nothing right now, maybe slimepeople in the future, can only suffer slashing, piercing, and burn wounds
#define BIO_JUST_FLESH	2
/// standard humanoids, can suffer all wounds, needs mangled bone and flesh to dismember
#define BIO_FLESH_BONE	3

/// If this wound requires having the HAS_FLESH flag for humanoids
#define FLESH_WOUND		(1<<0)
/// If this wound requires having the HAS_BONE flag for humanaoids
#define BONE_WOUND		(1<<1)
/// If having this wound counts as mangled flesh for dismemberment
#define MANGLES_FLESH	(1<<2)
/// If having this wound counts as mangled bone for dismemberment
#define MANGLES_BONE	(1<<3)
/// If this wound marks the limb as being allowed to have gauze applied
#define ACCEPTS_GAUZE	(1<<4)
/// If this wound marks the limb as being allowed to have sutures applied
#define ACCEPTS_SUTURE	(1<<5)

/// Limb reports new bandage was applied
#define BANDAGE_NEW_APPLIED (1<<0)
/// Limb reports old bandage was repaired
#define BANDAGE_WAS_REPAIRED (1<<1)
/// Limb reports old bandage was repaired to full
#define BANDAGE_WAS_REPAIRED_TO_FULL (1<<2)
/// Limb reports old bandage's timer was refilled
#define BANDAGE_TIMER_REFILLED (1<<3)
/// Limb reports bandage was not applied
#define BANDAGE_NOT_APPLIED (1<<4)
/// Limb reports bandage was checked for time and it still had time left
#define BANDAGE_STILL_INTACT (1<<5)
/// Limb reports bandage was checked for time and it ran out
#define BANDAGE_TIMED_OUT (1<<6)
/// Limb reports bandage does not exist
#define BANDAGE_NOT_FOUND (1<<7)

/// Limb reports new suture was applied
#define SUTURE_NEW_APPLIED (1<<8)
/// Limb reports old suture was repaired
#define SUTURE_WAS_REPAIRED (1<<9)
/// Limb reports old suture was repaired to full
#define SUTURE_WAS_REPAIRED_TO_FULL (1<<10)
/// Limb reports old suture's timer was refilled
#define SUTURE_TIMER_REFILLED (1<<11)
/// Limb reports suture was not applied
#define SUTURE_NOT_APPLIED (1<<12)
/// Limb reports suture was checked for time and it still had time left
#define SUTURE_STILL_INTACT (1<<13)
/// Limb reports suture was checked for time and it ran out
#define SUTURE_TIMED_OUT (1<<14)
/// Limb reports suture does not exist
#define SUTURE_NOT_FOUND (1<<15)

/// Damage required to damage a bandage by 1 point, enough to destroy improv bandages
#define BANDAGE_DAMAGE_THRESHOLD_LOW 5
/// Damage required to damage a bandage by 3 points, enough to destroy good bandages
#define BANDAGE_DAMAGE_THRESHOLD_MED 20
/// Damage required to destroy a bandage outright
#define BANDAGE_DAMAGE_THRESHOLD_MAX 45
/// How much burn damage is multiplied for bandage damage calcs
#define BANDAGE_BURN_MULT 3 // its very flammable

/// Bandage base heal per tick
#define BANDAGE_HEAL_OVER_TIME_BASE 0.1

/// Bandage heal over time for improvised bandages
#define BANDAGE_IMPROVISED_HEAL_OVER_TIME (BANDAGE_HEAL_OVER_TIME_BASE * 0.5)
/// Bandage heal over time for normal bandages
#define BANDAGE_NORMAL_HEAL_OVER_TIME (BANDAGE_HEAL_OVER_TIME_BASE * 1)
/// Bandage heal over time for PRO bandages
#define BANDAGE_MEDICAL_HEAL_OVER_TIME (BANDAGE_HEAL_OVER_TIME_BASE * 2)

/// Bandage heal rate
//#define BANDAGE_HEAL_RATE_BASE 0.005 // 0.3 brute/tick
/// Bandage heal rate for improvised bandages
//#define BANDAGE_IMPROVISED_HEAL_RATE (BANDAGE_IMPROVISED_HEAL_OVER_TIME * BANDAGE_HEAL_RATE_BASE * 0.5)
/// Bandage heal rate for normal bandages
//#define BANDAGE_NORMAL_HEAL_RATE (BANDAGE_IMPROVISED_HEAL_OVER_TIME * BANDAGE_HEAL_RATE_BASE * 1)
/// Bandage heal rate for PRO bandages
//#define BANDAGE_MEDICAL_HEAL_RATE (BANDAGE_MEDICAL_HEAL_OVER_TIME * BANDAGE_HEAL_RATE_BASE * 2)

/// Suture base heal over time
#define SUTURE_HEAL_OVER_TIME_BASE 0.2

/// Suture heal over time for improvised sutures
#define SUTURE_IMPROVISED_HEAL_OVER_TIME (SUTURE_HEAL_OVER_TIME_BASE * 0.5)
/// Suture heal over time for normal sutures
#define SUTURE_NORMAL_HEAL_OVER_TIME (SUTURE_HEAL_OVER_TIME_BASE * 1)
/// Suture heal over time for PRO sutures
#define SUTURE_MEDICAL_HEAL_OVER_TIME (SUTURE_HEAL_OVER_TIME_BASE * 2)

/// Suture heal rate
//#define SUTURE_HEAL_RATE_BASE 0.01 // 0.4 brute/tick
/// Suture heal rate for improvised sutures
//#define SUTURE_IMPROVISED_HEAL_RATE (SUTURE_IMPROVISED_HEAL_OVER_TIME * SUTURE_HEAL_RATE_BASE * 0.5)
/// Suture heal rate for normal sutures
//#define SUTURE_NORMAL_HEAL_RATE (SUTURE_IMPROVISED_HEAL_OVER_TIME * SUTURE_HEAL_RATE_BASE * 1)
/// Suture heal rate for PRO sutures
//#define SUTURE_MEDICAL_HEAL_RATE (SUTURE_MEDICAL_HEAL_OVER_TIME * SUTURE_HEAL_RATE_BASE * 2)

/// Damage required to damage a suture by 1 point, enough to destroy improv sutures
#define SUTURE_DAMAGE_THRESHOLD_LOW 1
/// Damage required to damage a suture by 3 points, enough to destroy good sutures
#define SUTURE_DAMAGE_THRESHOLD_MED 20
/// Damage required to destroy a suture outright
#define SUTURE_DAMAGE_THRESHOLD_MAX 35
/// How much burn damage is multiplied for suture damage calcs
#define SUTURE_BURN_MULT 5 // its very flammable

/// Base amount sutures assist wound closure
#define SUTURE_BASE_WOUND_CLOSURE 0.15
/// Amount normal sutures close wounds
#define SUTURE_GOOD_WOUND_CLOSURE (SUTURE_BASE_WOUND_CLOSURE * 1.5)
/// Amount top tier sutures close wounds
#define SUTURE_BEST_WOUND_CLOSURE (SUTURE_BASE_WOUND_CLOSURE * 3)

/// Base amount bandages assist wound closure
#define BANDAGE_BASE_WOUND_CLOSURE (SUTURE_BASE_WOUND_CLOSURE * 0.5)
/// Amount normal bandages close wounds
#define BANDAGE_GOOD_WOUND_CLOSURE (BANDAGE_BASE_WOUND_CLOSURE * 1.5)
/// Amount top tier bandages close wounds
#define BANDAGE_BEST_WOUND_CLOSURE (BANDAGE_BASE_WOUND_CLOSURE * 3)

/// Base amount cat spit assist wound closure
#define LICK_BASE_WOUND_CLOSURE (BANDAGE_BASE_WOUND_CLOSURE * 0.20)

/// max amount of bleed_dam that bandages are able to fix
#define BANDAGE_BASE_WOUND_MAX (WOUND_BLEED_MODERATE_THRESHOLD)
/// Amount normal bandages close wounds
#define BANDAGE_GOOD_WOUND_MAX (WOUND_BLEED_SEVERE_THRESHOLD)
/// Amount top tier bandages close wounds
#define BANDAGE_BEST_WOUND_MAX (WOUND_BLEED_SEVERE_THRESHOLD)

/// Extra wound healing done if we have both sutures and a bandage
#define SUTURE_AND_BANDAGE_BONUS 2

/// Nutrition cost for one unit of wound healing
#define WOUND_HEAL_NUTRITION_COST 4 // 4 nutrition = 1 less bleed_dam, 400 nutrition = 100 wound heal
/// Nutrition spent for being well fed
#define WOUND_HEAL_FULL 5 // Eat a lot for quicker wound regen!
/// Nutrition spent for being not hungry
#define WOUND_HEAL_FED 1
/// Nutrition spent for being hungie
#define WOUND_HEAL_HUNGRY 1

/// Nutrition cost for one unit of wound healing
#define DAMAGE_HEAL_NUTRITION_COST 2 // 2 nutrition = 1 burn+brute heal, 200 nutrition = 100 damage heal
/// Nutrition spent for being well fed
#define DAMAGE_HEAL_FULL 3 // Eat a lot for quicker health regen!
/// Nutrition spent for being not hungry
#define DAMAGE_HEAL_FED 2
/// Nutrition spent for being hungie
#define DAMAGE_HEAL_HUNGRY 1

/// looking for a suture
#define COVERING_SUTURE "suture"
/// looking for a bandage
#define COVERING_BANDAGE "bandage"

/// Requesting true time in deciseconds
#define COVERING_TIME_TRUE "time in deciseconds"
/// Requesting time in minutes
#define COVERING_TIME_MINUTE "time in minutes"
/// Requesting time in minutes, but inaccurate
#define COVERING_TIME_MINUTE_FUZZY "fuzzy time in minutes"
/// How much to be off when fuzzy
#define COVERING_TIME_MINUTE_FUZZY_DELTA (5 MINUTES)

