SUBSYSTEM_DEF(interactions)
	name = "Interactions"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_INTERACTIONS
	var/list/interactions
	VAR_PROTECTED/list/blacklisted_mobs = list(
		/mob/dead,
	)
	VAR_PROTECTED/initialized_blacklist

	/// Order of initialization. Higher numbers are initialized first, lower numbers later. Use or create defines such as [INIT_ORDER_DEFAULT] so we can see the order in one file.
	init_order = INIT_ORDER_DEFAULT

/datum/controller/subsystem/interactions/Initialize(timeofday)
	prepare_interactions()
	prepare_blacklisted_mobs()
	return ..()

/// Makes the interactions, they're also a global list because having it as a list and just hanging around there is stupid
/datum/controller/subsystem/interactions/proc/prepare_interactions()
	QDEL_NULL_LIST(interactions)
	interactions = list()
	for(var/itype in subtypesof(/datum/interaction))
		var/datum/interaction/I = new itype()
		interactions["[itype]"] = I

/// Blacklisting!
/datum/controller/subsystem/interactions/proc/prepare_blacklisted_mobs()
	blacklisted_mobs = typecacheof(blacklisted_mobs)
	initialized_blacklist = TRUE

/*
 * Lewd interactions have a blacklist for certain mobs. When we evalute the user and target, both of
 * their requirements must be satisfied, and the mob must not be of a blacklisted type.
*/
/datum/controller/subsystem/interactions/proc/is_blacklisted(mob/living/creature)
	if(!creature || !initialized_blacklist)
		return TRUE
	if(is_type_in_typecache(creature, blacklisted_mobs))
		return TRUE

// Splurt defines, because I'm a lazy shitbag. ~TK

/*
 * # lewd_prefs_choices
 * Used for determining the possible choices for lewd prefs,
 * downstreams can modify this and i don't know,
 * remove "Ask"? or make a very confusing list of options which will make players hate you for it.
*/
GLOBAL_LIST_INIT(lewd_prefs_choices, list(
	"Yes",
	"Ask",
	"No"
	))

#define CUM_TARGET_MOUTH "mouth"
#define CUM_TARGET_THROAT "throat"
#define CUM_TARGET_VAGINA "vagina"
#define CUM_TARGET_ANUS "anus"
#define CUM_TARGET_HAND "hand"
#define CUM_TARGET_BREASTS "breasts"
#define CUM_TARGET_FEET "feet"
#define CUM_TARGET_PENIS "penis"
//Weird defines go here
#define CUM_TARGET_EARS "ears"
#define CUM_TARGET_EYES "eyes"
//
#define GRINDING_FACE_WITH_ANUS "faceanus"
#define GRINDING_FACE_WITH_FEET "facefeet"
#define GRINDING_MOUTH_WITH_FEET "mouthfeet"
#define THIGH_SMOTHERING "thigh_smother"
#define NUTS_TO_FACE "nut_face"

#define NORMAL_LUST 10
#define LOW_LUST 1

#define REQUIRE_NONE 0
#define REQUIRE_EXPOSED 1
#define REQUIRE_UNEXPOSED 2
#define REQUIRE_ANY 3

/*
 * From /mob/living/cum(): (mob/source, mob/living/partner, target_orifice)
 * This one may return TRUE to prevent cumming.
 *
*/
#define COMSIG_MOB_PRE_CAME "mob_pre_came"
/// From /mob/living/cum(): (mob/source, mob/living/partner, target_orifice)
#define COMSIG_MOB_POST_CAME "mob_post_came"


/*
 * # INIT_ORDER_INTERACTIONS
 * Used by the Interactions subsystems, used to set it's own position in the queue.
 * This puts this last on priority, very far from other subsystems,
 * if citadel ever manages to get this far, push it ever lower.
*/
