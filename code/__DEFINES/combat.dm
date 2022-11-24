/*ALL DEFINES RELATED TO COMBAT GO HERE*/

//Damage and status effect defines

//Damage defines //TODO: merge these down to reduce on defines
#define BRUTE		"brute"
#define BURN		"fire"
#define TOX			"tox"
#define OXY			"oxy"
#define CLONE		"clone"
#define STAMINA 	"stamina"
#define BRAIN		"brain"

//bitflag damage defines used for suicide_act -- also useful for bitflags, not just suicide!!!
#define BRUTELOSS 		(1<<0)
#define FIRELOSS 		(1<<1)
#define TOXLOSS 		(1<<2)
#define OXYLOSS 		(1<<3)
#define SHAME 			(1<<4)
#define MANUAL_SUICIDE	(1<<5)	//suicide_act will do the actual killing.
#define RADIATIONLOSS	(1<<6)
#define CLONELOSS		(1<<7)
#define EMPLOSS			(1<<8)

#define EFFECT_STUN		"stun"
#define EFFECT_KNOCKDOWN		"knockdown"
#define EFFECT_UNCONSCIOUS	"unconscious"
#define EFFECT_IRRADIATE	"irradiate"
#define EFFECT_STUTTER		"stutter"
#define EFFECT_SLUR 		"slur"
#define EFFECT_EYE_BLUR	"eye_blur"
#define EFFECT_DROWSY		"drowsy"
#define EFFECT_JITTER		"jitter"

// mob/living/var/combat_flags variable.
/// Default combat flags for those affected by sprinting (combat mode has been made into its own component)
#define COMBAT_FLAGS_DEFAULT				(COMBAT_FLAG_PARRY_CAPABLE | COMBAT_FLAG_BLOCK_CAPABLE)
/// Default combat flags for everyone else (so literally everyone but humans).
#define COMBAT_FLAGS_SPRINT_EXEMPT			(COMBAT_FLAG_SPRINT_ACTIVE | COMBAT_FLAG_SPRINT_TOGGLED | COMBAT_FLAG_SPRINT_FORCED | COMBAT_FLAG_PARRY_CAPABLE | COMBAT_FLAG_BLOCK_CAPABLE)

/// The user wants sprint mode on
#define COMBAT_FLAG_SPRINT_TOGGLED			(1<<0)
/// Sprint is currently active
#define COMBAT_FLAG_SPRINT_ACTIVE			(1<<1)
/// Currently attempting to crawl under someone
#define COMBAT_FLAG_ATTEMPTING_CRAWL		(1<<2)
/// Currently stamcritted
#define COMBAT_FLAG_HARD_STAMCRIT			(1<<3)
/// Currently attempting to resist up from the ground
#define COMBAT_FLAG_RESISTING_REST			(1<<4)
/// Intentionally resting
#define COMBAT_FLAG_INTENTIONALLY_RESTING	(1<<5)
/// Currently stamcritted but not as violently
#define COMBAT_FLAG_SOFT_STAMCRIT			(1<<6)
/// Force sprint mode on at all times, overrides everything including sprint disable traits.
#define COMBAT_FLAG_SPRINT_FORCED			(1<<7)
/// This mob is capable of using the active parrying system.
#define COMBAT_FLAG_PARRY_CAPABLE			(1<<8)
/// This mob is capable of using the active blocking system.
#define COMBAT_FLAG_BLOCK_CAPABLE			(1<<9)
/// This mob is capable of unarmed parrying
#define COMBAT_FLAG_UNARMED_PARRY			(1<<10)
/// This mob is currently actively blocking
#define COMBAT_FLAG_ACTIVE_BLOCKING			(1<<11)
/// This mob is currently starting an active block
#define COMBAT_FLAG_ACTIVE_BLOCK_STARTING	(1<<12)

// Helpers for getting someone's stamcrit state. Cast to living.
#define NOT_STAMCRIT 0
#define SOFT_STAMCRIT 1
#define HARD_STAMCRIT 2

// Stamcrit check helpers
#define IS_STAMCRIT(mob)					(CHECK_STAMCRIT(mob) != NOT_STAMCRIT)
#define CHECK_STAMCRIT(mob)					((mob.combat_flags & COMBAT_FLAG_HARD_STAMCRIT)? HARD_STAMCRIT : ((mob.combat_flags & COMBAT_FLAG_SOFT_STAMCRIT)? SOFT_STAMCRIT : NOT_STAMCRIT))

//stamina stuff
///Threshold over which attacks start being hindered.
#define STAMINA_NEAR_SOFTCRIT				90
///softcrit for stamina damage. prevents standing up, some actions that cost stamina, etc, but doesn't force a rest or stop movement
#define STAMINA_SOFTCRIT					100
///sanity cap to prevent stamina actions (that are still performable) from sending you into crit.
#define STAMINA_NEAR_CRIT					130
///crit for stamina damage. forces a rest, and stops movement until stamina goes back to stamina softcrit
#define STAMINA_CRIT						140
///same as STAMINA_SOFTCRIT except for the more traditional health calculations
#define STAMINA_SOFTCRIT_TRADITIONAL		0
///ditto, but for STAMINA_CRIT
#define STAMINA_CRIT_TRADITIONAL			-40

#define CRAWLUNDER_DELAY							30 //Delay for crawling under a standing mob

//Bitflags defining which status effects could be or are inflicted on a mob
// This is a bit out of date/inaccurate in light of all the new status effects and is probably pending rework.
#define CANSTUN			(1<<0)
#define CANKNOCKDOWN	(1<<1)
#define CANUNCONSCIOUS	(1<<2)
#define CANPUSH			(1<<3)
#define GODMODE			(1<<4)
#define CANSTAGGER		(1<<5)

//Health Defines
#define HEALTH_THRESHOLD_CRIT 0
#define HEALTH_THRESHOLD_FULLCRIT -30
#define HEALTH_THRESHOLD_DEAD -100

//Actual combat defines

//click cooldowns, in tenths of a second, used for various combat actions
#define CLICK_CD_MELEE 8
#define CLICK_CD_RANGE 5
#define CLICK_CD_RAPID 2
#define CLICK_CD_CLICK_ABILITY 6
#define CLICK_CD_HANDCUFFED 10
#define CLICK_CD_RESIST 20
#define CLICK_CD_GRABBING 10

//Cuff resist speeds
#define FAST_CUFFBREAK 1
#define INSTANT_CUFFBREAK 2

//Grab levels
#define GRAB_PASSIVE				0
#define GRAB_AGGRESSIVE				1
#define GRAB_NECK					2
#define GRAB_KILL					3

//attack visual effects
#define ATTACK_EFFECT_PUNCH		"punch"
#define ATTACK_EFFECT_KICK		"kick"
#define ATTACK_EFFECT_SMASH		"smash"
#define ATTACK_EFFECT_CLAW		"claw"
#define ATTACK_EFFECT_DISARM	"disarm"
#define ATTACK_EFFECT_ASS_SLAP  "ass_slap"
#define ATTACK_EFFECT_FACE_SLAP "face_slap"
#define ATTACK_EFFECT_BITE		"bite"
#define ATTACK_EFFECT_MECHFIRE	"mech_fire"
#define ATTACK_EFFECT_MECHTOXIN	"mech_toxin"
#define ATTACK_EFFECT_BOOP		"boop" //Honk

//intent defines
#define INTENT_HELP   "help"
#define INTENT_GRAB   "grab"
#define INTENT_DISARM "disarm"
#define INTENT_HARM   "harm"
//NOTE: INTENT_HOTKEY_* defines are not actual intents!
//they are here to support hotkeys
#define INTENT_HOTKEY_LEFT  "left"
#define INTENT_HOTKEY_RIGHT "right"

//the define for visible message range in combat
#define COMBAT_MESSAGE_RANGE 3
#define DEFAULT_MESSAGE_RANGE 7

//Shove knockdown lengths (deciseconds)
#define SHOVE_KNOCKDOWN_SOLID 30
#define SHOVE_KNOCKDOWN_HUMAN 30
#define SHOVE_KNOCKDOWN_TABLE 30
#define SHOVE_KNOCKDOWN_COLLATERAL 10
/// how long they're staggered for
#define SHOVE_STAGGER_DURATION 35
/// how long they're off balance for
#define SHOVE_OFFBALANCE_DURATION 30
//Shove disarming item list
GLOBAL_LIST_INIT(shove_disarming_types, typecacheof(list(
	/obj/item/gun)))


//Embedded objects

#define EMBEDDED_PAIN_CHANCE 					15	//Chance for embedded objects to cause pain (damage user)
#define EMBEDDED_ITEM_FALLOUT 					5	//Chance for embedded object to fall out (causing pain but removing the object)
#define EMBED_CHANCE							45	//Chance for an object to embed into somebody when thrown (if it's sharp)
#define EMBEDDED_PAIN_MULTIPLIER				2	//Coefficient of multiplication for the damage the item does while embedded (this*item.w_class)
#define EMBEDDED_FALL_PAIN_MULTIPLIER			5	//Coefficient of multiplication for the damage the item does when it falls out (this*item.w_class)
#define EMBEDDED_IMPACT_PAIN_MULTIPLIER			4	//Coefficient of multiplication for the damage the item does when it first embeds (this*item.w_class)
#define EMBED_THROWSPEED_THRESHOLD				4	//The minimum value of an item's throw_speed for it to embed (Unless it has embedded_ignore_throwspeed_threshold set to 1)
#define EMBEDDED_UNSAFE_REMOVAL_PAIN_MULTIPLIER 8	//Coefficient of multiplication for the damage the item does when removed without a surgery (this*item.w_class)
#define EMBEDDED_UNSAFE_REMOVAL_TIME			30	//A Time in ticks, total removal time = (this*item.w_class)
#define EMBEDDED_JOSTLE_CHANCE					5	//Chance for embedded objects to cause pain every time they move (jostle)
#define EMBEDDED_JOSTLE_PAIN_MULTIPLIER			1	//Coefficient of multiplication for the damage the item does while
#define EMBEDDED_PAIN_STAM_PCT					0.0	//This percentage of all pain will be dealt as stam damage rather than brute (0-1)
#define EMBED_CHANCE_TURF_MOD					-15	//You are this many percentage points less likely to embed into a turf (good for things glass shards and spears vs walls)

#define EMBED_HARMLESS list("pain_mult" = 0, "jostle_pain_mult" = 0, "ignore_throwspeed_threshold" = TRUE)
#define EMBED_HARMLESS_SUPERIOR list("pain_mult" = 0, "jostle_pain_mult" = 0, "ignore_throwspeed_threshold" = TRUE, "embed_chance" = 100, "fall_chance" = 0.1)
#define EMBED_POINTY list("ignore_throwspeed_threshold" = TRUE)
#define EMBED_POINTY_SUPERIOR list("embed_chance" = 100, "ignore_throwspeed_threshold" = TRUE)

//Gun trigger guards
#define TRIGGER_GUARD_ALLOW_ALL -1
#define TRIGGER_GUARD_NONE 0
#define TRIGGER_GUARD_NORMAL 1
//E-gun self-recharge values
#define EGUN_NO_SELFCHARGE 0
#define EGUN_SELFCHARGE 1
#define EGUN_SELFCHARGE_BORG 2

//Gun suppression
#define SUPPRESSED_NONE 0
#define SUPPRESSED_QUIET 1 ///standard suppressed
#define SUPPRESSED_VERY 2 /// no message

//Nice shot bonus
#define NICE_SHOT_RICOCHET_BONUS	20	//if the shooter has the NICE_SHOT trait and they fire a ricocheting projectile, add this to the ricochet chance and auto aim angle

//Object/Item sharpness
#define SHARP_NONE			0
#define SHARP_EDGED			1
#define SHARP_POINTY		2

//His Grace.
#define HIS_GRACE_SATIATED 0 //He hungers not. If bloodthirst is set to this, His Grace is asleep.
#define HIS_GRACE_PECKISH 20 //Slightly hungry.
#define HIS_GRACE_HUNGRY 60 //Getting closer. Increases damage up to a minimum of 20.
#define HIS_GRACE_FAMISHED 100 //Dangerous. Increases damage up to a minimum of 25 and cannot be dropped.
#define HIS_GRACE_STARVING 120 //Incredibly close to breaking loose. Increases damage up to a minimum of 30.
#define HIS_GRACE_CONSUME_OWNER 140 //His Grace consumes His owner at this point and becomes aggressive.
#define HIS_GRACE_FALL_ASLEEP 160 //If it reaches this point, He falls asleep and resets.

#define HIS_GRACE_FORCE_BONUS 4 //How much force is gained per kill.

#define EXPLODE_NONE 0				//Don't even ask me why we need this.
#define EXPLODE_DEVASTATE 1
#define EXPLODE_HEAVY 2
#define EXPLODE_LIGHT 3
#define EXPLODE_GIB_THRESHOLD 50

#define GRENADE_CLUMSY_FUMBLE 1
#define GRENADE_NONCLUMSY_FUMBLE 2
#define GRENADE_NO_FUMBLE 3

#define BODY_ZONE_HEAD		"head"
#define BODY_ZONE_CHEST		"chest"
#define BODY_ZONE_L_ARM		"l_arm"
#define BODY_ZONE_R_ARM		"r_arm"
#define BODY_ZONE_L_LEG		"l_leg"
#define BODY_ZONE_R_LEG		"r_leg"

GLOBAL_LIST_INIT(main_body_parts, list(
	BODY_ZONE_HEAD,
	BODY_ZONE_CHEST,
	BODY_ZONE_L_ARM,
	BODY_ZONE_R_ARM,
	BODY_ZONE_L_LEG,
	BODY_ZONE_R_LEG
))

#define BODY_ZONE_PRECISE_EYES		"eyes"
#define BODY_ZONE_PRECISE_MOUTH		"mouth"
#define BODY_ZONE_PRECISE_GROIN		"groin"
#define BODY_ZONE_PRECISE_L_HAND	"l_hand"
#define BODY_ZONE_PRECISE_R_HAND	"r_hand"
#define BODY_ZONE_PRECISE_L_FOOT	"l_foot"
#define BODY_ZONE_PRECISE_R_FOOT	"r_foot"


//We will round to this value in damage calculations.
#define DAMAGE_PRECISION 0.01

//items total mass, used to calculate their attacks' stamina costs. If not defined, the cost will be (w_class * 1.25)
#define TOTAL_MASS_TINY_ITEM		1.25
#define TOTAL_MASS_SMALL_ITEM		2.5
#define TOTAL_MASS_NORMAL_ITEM		3.75
#define TOTAL_MASS_BULKY_ITEM		5
#define TOTAL_MASS_HUGE_ITEM		6.25
#define TOTAL_MASS_GIGANTIC_ITEM	7.5

#define TOTAL_MASS_HAND_REPLACEMENT	5 //standard punching stamina cost. most hand replacements are huge items anyway.
#define TOTAL_MASS_MEDIEVAL_WEAPON	15 //very, very generic average sword/warpick/etc. weight in pounds.
#define TOTAL_MASS_TOY_SWORD 1.5

//stamina cost defines.
#define STAM_COST_ATTACK_OBJ_MULT	1.2
#define STAM_COST_ATTACK_MOB_MULT	1
#define STAM_COST_BATON_MOB_MULT	1
#define STAM_COST_NO_COMBAT_MULT	1.25
#define STAM_COST_W_CLASS_MULT		1.25
#define STAM_COST_THROW_MULT		2
#define STAM_COST_THROW_MOB			2.5 //multiplied by (mob size + 1)^2.

///Multiplier of the (STAMINA_NEAR_CRIT - user current stamina loss) : (STAMINA_NEAR_CRIT - STAMINA_SOFTCRIT) ratio used in damage penalties when stam soft-critted.
#define STAM_CRIT_ITEM_ATTACK_PENALTY	0.66
/// changeNext_move penalty multiplier of the above.
#define STAM_CRIT_ITEM_ATTACK_DELAY		1.75
/// Damage penalty when fighting prone.
#define LYING_DAMAGE_PENALTY			0.7
/// Added delay when firing guns stam-softcritted. Summed with a hardset CLICK_CD_RANGE delay, similar to STAM_CRIT_DAMAGE_DELAY otherwise.
#define STAM_CRIT_GUN_DELAY			2.75

//stamina recovery defines. Blocked if combat mode is on.
#define STAM_RECOVERY_STAM_CRIT		-7.5
#define STAM_RECOVERY_RESTING		-6
#define STAM_RECOVERY_NORMAL		-3
#define STAM_RECOVERY_LIMB			4 //limbs recover stamina separately from handle_status_effects(), and aren't blocked by combat mode.

/**
 * should the current-attack-damage be lower than the item force multiplied by this value,
 * a "inefficiently" prefix will be added to the message.
 */
#define FEEBLE_ATTACK_MSG_THRESHOLD 0.5

/* * * * * * * * * *
 * Bullet defines! *
 * * * * * * * * * */

/// Bullet damage defines
#define BULLET_DAMAGE_PISTOL_LIGHT 20
#define BULLET_DAMAGE_PISTOL_MEDIUM 30
#define BULLET_DAMAGE_PISTOL_HEAVY 40
#define BULLET_DAMAGE_RIFLE_LIGHT 30
#define BULLET_DAMAGE_RIFLE_MEDIUM 45
#define BULLET_DAMAGE_RIFLE_HEAVY 75
#define BULLET_DAMAGE_SHOTGUN_PELLET 11
#define BULLET_DAMAGE_SHOTGUN_SLUG 50

/// Bullet damage falloff per tile defines
#define BULLET_FALLOFF "bullet falloff per tile"
#define BULLET_FALLOFF_PISTOL_LIGHT 3
#define BULLET_FALLOFF_PISTOL_MEDIUM 5
#define BULLET_FALLOFF_PISTOL_HEAVY 6
#define BULLET_FALLOFF_RIFLE_LIGHT 5
#define BULLET_FALLOFF_RIFLE_MEDIUM 10
#define BULLET_FALLOFF_RIFLE_HEAVY 10
#define BULLET_FALLOFF_SHOTGUN_PELLET 4
#define BULLET_FALLOFF_SHOTGUN_SLUG 2

/// Bullet damage falloff starting distance defines
#define BULLET_FALLOFF_START "bullet falloff start distance"
#define BULLET_FALLOFF_START_PISTOL_LIGHT 2
#define BULLET_FALLOFF_START_PISTOL_MEDIUM 4
#define BULLET_FALLOFF_START_PISTOL_HEAVY 5
#define BULLET_FALLOFF_START_RIFLE_LIGHT 3
#define BULLET_FALLOFF_START_RIFLE_MEDIUM 10
#define BULLET_FALLOFF_START_RIFLE_HEAVY 20
#define BULLET_FALLOFF_START_SHOTGUN_PELLET 0
#define BULLET_FALLOFF_START_SHOTGUN_SLUG 5

/// Bullet damage falloff default defines
#define BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT list(BULLET_FALLOFF = BULLET_FALLOFF_PISTOL_LIGHT, BULLET_FALLOFF_START = BULLET_FALLOFF_START_PISTOL_LIGHT)
#define BULLET_FALLOFF_DEFAULT_PISTOL_MEDIUM list(BULLET_FALLOFF = BULLET_FALLOFF_PISTOL_MEDIUM, BULLET_FALLOFF_START = BULLET_FALLOFF_START_PISTOL_MEDIUM)
#define BULLET_FALLOFF_DEFAULT_PISTOL_HEAVY list(BULLET_FALLOFF = BULLET_FALLOFF_PISTOL_HEAVY, BULLET_FALLOFF_START = BULLET_FALLOFF_START_PISTOL_HEAVY)
#define BULLET_FALLOFF_DEFAULT_RIFLE_LIGHT list(BULLET_FALLOFF = BULLET_FALLOFF_RIFLE_LIGHT, BULLET_FALLOFF_START = BULLET_FALLOFF_START_RIFLE_LIGHT)
#define BULLET_FALLOFF_DEFAULT_RIFLE_MEDIUM list(BULLET_FALLOFF = BULLET_FALLOFF_RIFLE_MEDIUM, BULLET_FALLOFF_START = BULLET_FALLOFF_START_RIFLE_MEDIUM)
#define BULLET_FALLOFF_DEFAULT_RIFLE_HEAVY list(BULLET_FALLOFF = BULLET_FALLOFF_RIFLE_HEAVY, BULLET_FALLOFF_START = BULLET_FALLOFF_START_RIFLE_HEAVY)
#define BULLET_FALLOFF_DEFAULT_SHOTGUN_PELLET list(BULLET_FALLOFF = BULLET_FALLOFF_START_PISTOL_LIGHT, BULLET_FALLOFF_START = BULLET_FALLOFF_START_SHOTGUN_PELLET)
#define BULLET_FALLOFF_DEFAULT_SHOTGUN_SLUG list(BULLET_FALLOFF = BULLET_FALLOFF_SHOTGUN_PELLET, BULLET_FALLOFF_START = BULLET_FALLOFF_START_SHOTGUN_SLUG)

/// Minimum bullet damage that falloff can take it to
#define BULLET_FALLOFF_MIN_DAMAGE 3

/// Bullet recoil defines
#define BULLET_RECOIL_PISTOL_LIGHT 3
#define BULLET_RECOIL_PISTOL_MEDIUM 3.5
#define BULLET_RECOIL_PISTOL_HEAVY 4
#define BULLET_RECOIL_RIFLE_LIGHT 4.5
#define BULLET_RECOIL_RIFLE_MEDIUM 5.5
#define BULLET_RECOIL_RIFLE_HEAVY 7
#define BULLET_RECOIL_SHOTGUN_PELLET 40 // The total recoil of the shell, not individual pellets
#define BULLET_RECOIL_SHOTGUN_SLUG 20

/// Rubber bullet damage multiplier
#define RUBBERY_DAMAGE_MULT 0.1

/// Bullet stamloss defines
#define BULLET_STAMINA_PISTOL_LIGHT (BULLET_DAMAGE_PISTOL_LIGHT * 0.5)
#define BULLET_STAMINA_PISTOL_MEDIUM (BULLET_DAMAGE_PISTOL_MEDIUM * 1)
#define BULLET_STAMINA_PISTOL_HEAVY (BULLET_DAMAGE_PISTOL_HEAVY * 1)
#define BULLET_STAMINA_RIFLE_LIGHT (BULLET_DAMAGE_RIFLE_LIGHT * 0.2)
#define BULLET_STAMINA_RIFLE_MEDIUM (BULLET_DAMAGE_RIFLE_MEDIUM * 1)
#define BULLET_STAMINA_RIFLE_HEAVY (BULLET_DAMAGE_RIFLE_HEAVY * 1.5)
#define BULLET_STAMINA_SHOTGUN_PELLET (BULLET_DAMAGE_SHOTGUN_PELLET * 0.1)
#define BULLET_STAMINA_SHOTGUN_SLUG (BULLET_DAMAGE_SHOTGUN_SLUG * 0.2)

/// Rubber/beanbag stamloss defines
#define RUBBERY_STAMINA_PISTOL_LIGHT (BULLET_DAMAGE_PISTOL_LIGHT * 2)
#define RUBBERY_STAMINA_PISTOL_MEDIUM (BULLET_DAMAGE_PISTOL_MEDIUM * 3)
#define RUBBERY_STAMINA_PISTOL_HEAVY (BULLET_DAMAGE_PISTOL_HEAVY * 4)
#define RUBBERY_STAMINA_RIFLE_LIGHT (BULLET_DAMAGE_RIFLE_LIGHT * 2)
#define RUBBERY_STAMINA_RIFLE_MEDIUM (BULLET_DAMAGE_RIFLE_MEDIUM * 3)
#define RUBBERY_STAMINA_RIFLE_HEAVY (BULLET_DAMAGE_RIFLE_HEAVY * 4)
#define RUBBERY_STAMINA_SHOTGUN_PELLET (BULLET_DAMAGE_SHOTGUN_PELLET * 2)
#define RUBBERY_STAMINA_SHOTGUN_SLUG (BULLET_DAMAGE_SHOTGUN_SLUG * 3)

/// Shotgun pellet count defines
#define SHOTGUN_PELLET_BASE 5
#define SHOTGUN_PELLET_IMPROVISED 10

/// Shotgun pellet spread defines
#define SHOTGUN_SPREAD_BASE 18
#define SHOTGUN_SPREAD_IMPROVISED 25

/// Bullet damage modifier defines
#define BULLET_MATCH_MULT 1.25 // rare, pack a punch
#define BULLET_SURPLUS_MULT 1 // standard ammo from an ammobench
#define BULLET_HANDLOAD_MULT 0.75 // trash ammo you can make anywhere with a reloader tool, most common

/// Bullet spread modifier defines
#define BULLET_SPREAD_BASE 2 // Base spread added from 'quality' ammo

/// Bullet spread modifier defines
#define BULLET_SPREAD_MATCH 0 // No extra spread~
#define BULLET_SPREAD_SURPLUS (BULLET_SPREAD_BASE) // Base spread
#define BULLET_SPREAD_HANDLOAD (BULLET_SPREAD_BASE * 2) // More spread!

/// Bullet wound modifier defines
#define BULLET_WOUND_PISTOL_LIGHT 5
#define BULLET_WOUND_PISTOL_MEDIUM 5
#define BULLET_WOUND_PISTOL_HEAVY 10
#define BULLET_WOUND_RIFLE_LIGHT 5
#define BULLET_WOUND_RIFLE_MEDIUM 20
#define BULLET_WOUND_RIFLE_HEAVY 40
#define BULLET_WOUND_SHOTGUN_PELLET 0
#define BULLET_WOUND_SHOTGUN_SLUG 40 // ha get fucked

/// Rubber wound modifier defines
/// intended to break bones, dont make beanbags sharp or everyone dies
#define RUBBERY_WOUND_PISTOL_LIGHT (BULLET_WOUND_PISTOL_LIGHT)
#define RUBBERY_WOUND_PISTOL_MEDIUM (BULLET_WOUND_PISTOL_MEDIUM * 1.5)
#define RUBBERY_WOUND_PISTOL_HEAVY (BULLET_WOUND_PISTOL_HEAVY * 1.5)
#define RUBBERY_WOUND_RIFLE_LIGHT (BULLET_WOUND_RIFLE_LIGHT * 1.5)
#define RUBBERY_WOUND_RIFLE_MEDIUM (BULLET_WOUND_RIFLE_MEDIUM * 2)
#define RUBBERY_WOUND_RIFLE_HEAVY (BULLET_WOUND_RIFLE_HEAVY * 5) // If this starts ripping off limbs... good~
#define RUBBERY_WOUND_SHOTGUN_PELLET (-BULLET_WOUND_SHOTGUN_PELLET * 0.1) // cus negative
#define RUBBERY_WOUND_SHOTGUN_SLUG (BULLET_WOUND_SHOTGUN_SLUG * 3)

/// Bullet wound falloff defines
#define BULLET_WOUND_FALLOFF_PISTOL_LIGHT 0
#define BULLET_WOUND_FALLOFF_PISTOL_MEDIUM 2
#define BULLET_WOUND_FALLOFF_PISTOL_HEAVY 3
#define BULLET_WOUND_FALLOFF_RIFLE_LIGHT 0.5
#define BULLET_WOUND_FALLOFF_RIFLE_MEDIUM 0
#define BULLET_WOUND_FALLOFF_RIFLE_HEAVY 0
#define BULLET_WOUND_FALLOFF_SHOTGUN_PELLET 0
#define BULLET_WOUND_FALLOFF_SHOTGUN_SLUG 0

/// If you're naked, more wounds
#define BULLET_NAKED_RUBBERY_WOUND_MULT 0.5
#define BULLET_NAKED_WOUND_MULT 0.75

/// Bullet speed defines
#define BULLET_SPEED_BASE (TILES_TO_PIXELS(30)) //960 (30 tiles per second, 32 pixels per tile)
// No less than 25 tiles per second (x * 0.83ish), please
#define BULLET_SPEED_PISTOL_LIGHT (BULLET_SPEED_BASE * 0.85)
#define BULLET_SPEED_PISTOL_MEDIUM (BULLET_SPEED_BASE * 0.90)
#define BULLET_SPEED_PISTOL_HEAVY (BULLET_SPEED_BASE * 0.90)
#define BULLET_SPEED_RIFLE_LIGHT (BULLET_SPEED_BASE * 1.2)
#define BULLET_SPEED_RIFLE_MEDIUM (BULLET_SPEED_BASE * 3)
#define BULLET_SPEED_RIFLE_HEAVY (BULLET_SPEED_BASE * 5)
#define BULLET_SPEED_SHOTGUN_PELLET (BULLET_SPEED_BASE * 0.90)
#define BULLET_SPEED_SHOTGUN_SLUG (BULLET_SPEED_BASE * 0.85)

/// Bullet ammo type multiplier defines
/// Acid ammo
#define BULLET_DAMAGE_ACID 0.5
#define BULLET_STAMINA_ACID 0.5
#define BULLET_WOUND_ACID 2
#define BULLET_NAKED_WOUND_ACID 2

/// Fire ammo
#define BULLET_DAMAGE_FIRE 0.5
#define BULLET_STAMINA_FIRE 0.5
#define BULLET_WOUND_FIRE 1
#define BULLET_NAKED_WOUND_FIRE 0

/// Shock ammo
#define BULLET_DAMAGE_SHOCK 0.5
#define BULLET_STAMINA_SHOCK 0.5
#define BULLET_WOUND_SHOCK 0
#define BULLET_NAKED_WOUND_SHOCK 0

/// Microshapnel ammo
#define BULLET_DAMAGE_MICROSHRAPNEL 0.5
#define BULLET_STAMINA_MICROSHRAPNEL 0.5
#define BULLET_WOUND_MICROSHRAPNEL 2.5
#define BULLET_NAKED_WOUND_MICROSHRAPNEL 2.5

/// Explosive ammo
#define BULLET_DAMAGE_EXPLOSIVE 0.5
#define BULLET_STAMINA_EXPLOSIVE 0.5
#define BULLET_WOUND_EXPLOSIVE 2 // I mean it explodes in you
#define BULLET_NAKED_WOUND_EXPLOSIVE 2

/// Poison ammo
#define BULLET_DAMAGE_POISON 0.5
#define BULLET_STAMINA_POISON 0.5
#define BULLET_WOUND_POISON 0
#define BULLET_NAKED_WOUND_POISON 0

/* * * * * * * * *
 * Gun  defines! *
 * * * * * * * * */

/// Gun Firemodes
#define GUN_FIREMODE_SEMIAUTO 1
#define GUN_FIREMODE_BURST 2
#define GUN_FIREMODE_AUTO 3

/// Max spread recoil can add
#define GUN_RECOIL_MAX_SPREAD 30

/// Sawed-off recoil modifier
#define SAWEDOFF_RECOIL_MULT 2

/// Hobogun recoil modifier
#define HOBO_RECOIL_MULT 2

// Gun Akimbo Spread modifier
#define GUN_AKIMBO_RECOIL_MOD 2

// If their other hand is full, multiply recoil by this much
#define GUN_FULL_OTHER_HAND_RECOIL_MOD 2

// Global recoil modifier
#define GUN_RECOIL_GLOBAL_MULT 0.75

/// Gun recoil modifier per shot defines
#define GUN_RECOIL_NONE (GUN_RECOIL_GLOBAL_MULT * 0.1)
#define GUN_RECOIL_PISTOL_LIGHT (GUN_RECOIL_GLOBAL_MULT * 1)
#define GUN_RECOIL_PISTOL_MEDIUM (GUN_RECOIL_GLOBAL_MULT * 2)
#define GUN_RECOIL_PISTOL_HEAVY (GUN_RECOIL_GLOBAL_MULT * 1.5)
#define GUN_RECOIL_REVOLVER_LIGHT (GUN_RECOIL_GLOBAL_MULT * 1.2)
#define GUN_RECOIL_REVOLVER_HEAVY (GUN_RECOIL_GLOBAL_MULT * 1.5)
#define GUN_RECOIL_REPEATER_LIGHT (GUN_RECOIL_GLOBAL_MULT * 1)
#define GUN_RECOIL_REPEATER_HEAVY (GUN_RECOIL_GLOBAL_MULT * 1.2)
#define GUN_RECOIL_CARBINE (GUN_RECOIL_GLOBAL_MULT * 0.5)
#define GUN_RECOIL_SMG_LIGHT (GUN_RECOIL_GLOBAL_MULT * 2)
#define GUN_RECOIL_SMG_HEAVY (GUN_RECOIL_GLOBAL_MULT * 1.5)
#define GUN_RECOIL_RIFLE_BOLT (GUN_RECOIL_GLOBAL_MULT * 1)
#define GUN_RECOIL_RIFLE_LIGHT_SEMI (GUN_RECOIL_GLOBAL_MULT * 1)
#define GUN_RECOIL_RIFLE_LIGHT_AUTO (GUN_RECOIL_GLOBAL_MULT * 2)
#define GUN_RECOIL_RIFLE_MEDIUM_SEMI (GUN_RECOIL_GLOBAL_MULT * 1)
#define GUN_RECOIL_RIFLE_MEDIUM_AUTO (GUN_RECOIL_GLOBAL_MULT * 2)
#define GUN_RECOIL_RIFLE_LMG (GUN_RECOIL_GLOBAL_MULT * 1)
#define GUN_RECOIL_RIFLE_GAUSS (GUN_RECOIL_GLOBAL_MULT * 5)
#define GUN_RECOIL_SHOTGUN_FIXED (GUN_RECOIL_GLOBAL_MULT * 2)
#define GUN_RECOIL_SHOTGUN_PUMP (GUN_RECOIL_GLOBAL_MULT * 1)
#define GUN_RECOIL_SHOTGUN_AUTO (GUN_RECOIL_GLOBAL_MULT * 10)

/// Gun recoil timeout Base
#define GUN_RECOIL_TIMEOUT_BASE (2 SECONDS)

/// Gun recoil timeout modifiers
#define GUN_RECOIL_TIMEOUT_INSTANT (GUN_RECOIL_TIMEOUT_BASE * 0.1)
#define GUN_RECOIL_TIMEOUT_QUICK (GUN_RECOIL_TIMEOUT_BASE * 0.75)
#define GUN_RECOIL_TIMEOUT_NORMAL (GUN_RECOIL_TIMEOUT_BASE * 1)
#define GUN_RECOIL_TIMEOUT_LONG (GUN_RECOIL_TIMEOUT_BASE * 1.5)
#define GUN_RECOIL_TIMEOUT_LONGER (GUN_RECOIL_TIMEOUT_BASE * 2)

/// Gun spread modifiers
#define GUN_SPREAD_NONE 0
#define GUN_SPREAD_NORMAL 1
#define GUN_SPREAD_POOR (GUN_SPREAD_NORMAL * 2)
#define GUN_SPREAD_AWFUL (GUN_SPREAD_NORMAL * 3)

/// Gun fire delay Base
#define GUN_FIRE_DELAY_BASE (1 SECONDS)

/// Gun fire delay modifiers
#define GUN_FIRE_DELAY_FASTEST (GUN_FIRE_DELAY_BASE * 0.1) // Mostly just good for automatics
#define GUN_FIRE_DELAY_FASTER (GUN_FIRE_DELAY_BASE * 0.2) // 0.2s Mostly just good for automatics
#define GUN_FIRE_DELAY_FAST (GUN_FIRE_DELAY_BASE * 0.4) // 0.4s
#define GUN_FIRE_DELAY_NORMAL (GUN_FIRE_DELAY_BASE * 0.6) // 0.6s
#define GUN_FIRE_DELAY_SLOW (GUN_FIRE_DELAY_BASE * 0.8) //0.8s
#define GUN_FIRE_DELAY_SLOWER (GUN_FIRE_DELAY_BASE * 1.5) //1.5s

/// Gun autofire delay Base
#define GUN_AUTOFIRE_DELAY_BASE 1

/// Gun fire delay modifiers
#define GUN_AUTOFIRE_DELAY_FASTEST (GUN_AUTOFIRE_DELAY_BASE * 0.1)
#define GUN_AUTOFIRE_DELAY_FASTER (GUN_AUTOFIRE_DELAY_BASE * 1)
#define GUN_AUTOFIRE_DELAY_FAST (GUN_AUTOFIRE_DELAY_BASE * 2)
#define GUN_AUTOFIRE_DELAY_NORMAL (GUN_AUTOFIRE_DELAY_BASE * 3)
#define GUN_AUTOFIRE_DELAY_SLOW (GUN_AUTOFIRE_DELAY_BASE * 4)
#define GUN_AUTOFIRE_DELAY_SLOWER (GUN_AUTOFIRE_DELAY_BASE * 5)

/// Gun burstfire delay Base
#define GUN_BURSTFIRE_DELAY_BASE 1

/// Gun fire delay modifiers
#define GUN_BURSTFIRE_DELAY_FASTEST (GUN_BURSTFIRE_DELAY_BASE * 0.1)
#define GUN_BURSTFIRE_DELAY_FASTER (GUN_BURSTFIRE_DELAY_BASE * 0.5)
#define GUN_BURSTFIRE_DELAY_FAST (GUN_BURSTFIRE_DELAY_BASE * 1)
#define GUN_BURSTFIRE_DELAY_NORMAL (GUN_BURSTFIRE_DELAY_BASE * 2)
#define GUN_BURSTFIRE_DELAY_SLOW (GUN_BURSTFIRE_DELAY_BASE * 3)
#define GUN_BURSTFIRE_DELAY_SLOWER (GUN_BURSTFIRE_DELAY_BASE * 4)

/// Time after you draw a gun that you're able to shoot it
#define GUN_AIMING_TIME (1.5 SECONDS)

/// Gun draw time modifiers
#define GUN_DRAW_QUICK (GUN_AIMING_TIME * 0.1) // Draw, pardner
#define GUN_DRAW_NORMAL (GUN_AIMING_TIME * 1)
#define GUN_DRAW_LONG (GUN_AIMING_TIME * 1.5)

/// Gun weapon weight
#define GUN_ONE_HAND_AKIMBO 1
#define GUN_ONE_HAND_ONLY 2
#define GUN_TWO_HAND_ONLY 3

/// Gun bullet damage base
/// Multiplies the gun's projectile damage
#define GUN_EXTRA_DAMAGE_0 1
#define GUN_EXTRA_DAMAGE_T1 1.10
#define GUN_EXTRA_DAMAGE_T2 1.15
#define GUN_EXTRA_DAMAGE_T3 1.25
#define GUN_EXTRA_DAMAGE_T4 1.35
#define GUN_EXTRA_DAMAGE_T5 1.50

/// Also multiplies the gun's projectile damage, but so it does less damage
#define GUN_LESS_DAMAGE_T1 0.90
#define GUN_LESS_DAMAGE_T2 0.85
#define GUN_LESS_DAMAGE_T3 0.75
#define GUN_LESS_DAMAGE_T4 0.65
#define GUN_LESS_DAMAGE_T5 0.50
#define GUN_LESS_DAMAGE_T6 0.25

/// Gun melee force base
#define GUN_MELEE_FORCE_BASE 12

/// Gun weapon weight
#define GUN_MELEE_FORCE_PISTOL_LIGHT (GUN_MELEE_FORCE_BASE * 1) // 12
#define GUN_MELEE_FORCE_PISTOL_HEAVY (GUN_MELEE_FORCE_BASE * 1.25) //15
#define GUN_MELEE_FORCE_RIFLE_LIGHT (GUN_MELEE_FORCE_BASE * 1.5) //18
#define GUN_MELEE_FORCE_RIFLE_HEAVY (GUN_MELEE_FORCE_BASE * 2) // 24
#define GUN_MELEE_FORCE_RIFLE_GUNBLADE (GUN_MELEE_FORCE_BASE * 2.5) //30
#define GUN_MELEE_FORCE_RIFLE_HEAVIER (GUN_MELEE_FORCE_BASE * 3) //36

/// Gun slowdown
#define GUN_SLOWDOWN_NONE 0.1
#define GUN_SLOWDOWN_PISTOL_LIGHT 0.05
#define GUN_SLOWDOWN_PISTOL_MEDIUM 0.10
#define GUN_SLOWDOWN_PISTOL_HEAVY 0.15
#define GUN_SLOWDOWN_REVOLVER_LIGHT 0.10
#define GUN_SLOWDOWN_REVOLVER_HEAVY 0.15
#define GUN_SLOWDOWN_REPEATER 0.20
#define GUN_SLOWDOWN_CARBINE 0.20
#define GUN_SLOWDOWN_SMG_LIGHT 0.10
#define GUN_SLOWDOWN_SMG_HEAVY 0.25
#define GUN_SLOWDOWN_RIFLE_BOLT 0.30
#define GUN_SLOWDOWN_RIFLE_LIGHT_SEMI 0.25
#define GUN_SLOWDOWN_RIFLE_LIGHT_AUTO 0.35
#define GUN_SLOWDOWN_RIFLE_MEDIUM_SEMI 0.30
#define GUN_SLOWDOWN_RIFLE_MEDIUM_AUTO 0.40
#define GUN_SLOWDOWN_RIFLE_LMG 0.60
#define GUN_SLOWDOWN_RIFLE_GAUSS 1
#define GUN_SLOWDOWN_SHOTGUN_FIXED 0.05
#define GUN_SLOWDOWN_SHOTGUN_PUMP 0.10
#define GUN_SLOWDOWN_SHOTGUN_AUTO 0.40

/// Cock length
/// Delay between cocking your gun
#define GUN_COCK_BASE (1 SECONDS)

#define GUN_COCK_INSTANT 0.1
#define GUN_COCK_SHOTGUN_BASE (GUN_COCK_BASE)
#define GUN_COCK_SHOTGUN_FAST (GUN_COCK_BASE * 0.4)
#define GUN_COCK_SHOTGUN_LIGHTNING (GUN_COCK_BASE * 0.1)
#define GUN_COCK_RIFLE_BASE (GUN_COCK_BASE)
#define GUN_COCK_RIFLE_FAST (GUN_COCK_BASE * 0.75)
#define GUN_COCK_RIFLE_LIGHTNING (GUN_COCK_BASE * 0.5)

/// Refire speed multiplier for manual action guns, cus we no longer care about your cock length
#define GUN_RIFLEMAN_REFIRE_DELAY_MULT 0.8

/// Refire speed multiplier for manual action guns if you're not a pr0 and click-to-cycle it
#define GUN_AUTOPUMP_REFIRE_DELAY_MULT 1.8

//#define RECOIL_SPREAD_CALC(x)  (0.0075 * (x ** 4)) // Funky way of exponentiating bullet spread from recoil
#define RECOIL_SPREAD_CALC(x)  (x) // funky recoil kidna turbofucks things in wierd says, maybe
#define MAX_ACCURACY_OFFSET  45 //It's both how big gun recoil can build up, and how hard you can miss
#define RECOIL_REDUCTION_TIME 1 SECONDS // unused

#define EMBEDDED_RECOIL(x)     list(1.3 *x, 0  *x, 0  *x )
#define HANDGUN_RECOIL(x)      list(1.15*x, 0.1*x, 0.6*x )
#define SMG_RECOIL(x)          list(1   *x, 0.2*x, 1.2*x )
#define CARBINE_RECOIL(x)      list(0.85*x, 0.3*x, 1.8*x )
#define RIFLE_RECOIL(x)        list(0.7 *x, 0.4*x, 2.4*x )
#define LMG_RECOIL(x)          list(0.55*x, 0.5*x, 3*x   )
#define HMG_RECOIL(x)          list(0.4 *x, 0.6*x, 3.6*x )

//Quick defines for fire modes
#define FULL_AUTO_150		list(mode_name = "full auto",  mode_desc = "200 rounds per minute",   automatic = 1, autofire_shot_delay = 4, burst_size = 1, icon="auto")
#define FULL_AUTO_200		list(mode_name = "full auto",  mode_desc = "200 rounds per minute",   automatic = 1, autofire_shot_delay = 3, burst_size = 1, icon="auto")
#define FULL_AUTO_300		list(mode_name = "full auto",  mode_desc = "300 rounds per minute",   automatic = 1, autofire_shot_delay = 2, burst_size = 1, icon="auto")
#define FULL_AUTO_400		list(mode_name = "full auto",  mode_desc = "400 rounds per minute",   automatic = 1, autofire_shot_delay = 1.5, burst_size = 1, icon="auto")
#define FULL_AUTO_600		list(mode_name = "full auto",  mode_desc = "600 rounds per minute",   automatic = 1, autofire_shot_delay = 1, burst_size = 1, icon="auto")
#define FULL_AUTO_800		list(mode_name = "fuller auto",  mode_desc = "800 rounds per minute",   automatic = 1, autofire_shot_delay = 0.8, burst_size = 1, icon="auto")
#define FULL_AUTO_1000		list(mode_name = "fullerer auto",  mode_desc = "1000 rounds per minute",   automatic = 1, autofire_shot_delay = 0.6, burst_size = 1, icon="auto")
#define FULL_AUTO_1200		list(mode_name = "ludicrous auto",  mode_desc = "1200 rounds per minute",   automatic = 1, autofire_shot_delay = 0.5, burst_size = 1, icon="auto")

#define SEMI_AUTO_NODELAY	list(mode_name = "semiauto",  mode_desc = "Fire as fast as you can pull the trigger", automatic = 0, burst_size=1, icon="semi")

//Cog firemode
#define BURST_2_BEAM		list(mode_name="2-beam bursts", mode_desc = "Short, controlled bursts", automatic = 0, burst_size=2, fire_delay=null, icon="burst")

#define BURST_2_ROUND		list(mode_name="2-round bursts", mode_desc = "Short, controlled bursts", automatic = 0, burst_size=2, fire_delay=null, icon="burst")
#define BURST_3_ROUND		list(mode_name="3-round bursts", mode_desc = "Short, controlled bursts", automatic = 0, burst_size=3, fire_delay=null, icon="burst")
#define BURST_3_ROUND_RAPID		list(mode_name=" High-delay Rapid 3-round bursts", mode_desc = "Short, fast bursts with a higher delay between bursts", automatic = 0, burst_size=3, fire_delay=15, icon="auto", burst_shot_delay = 0.9)
#define BURST_5_ROUND		list(mode_name="5-round bursts", mode_desc = "Short, controlled bursts", automatic = 0, burst_size=5, fire_delay=null, icon="burst")
#define BURST_8_ROUND		list(mode_name="8-round bursts", mode_desc = "Short, uncontrolled bursts", automatic = 0, burst_size=8, fire_delay=null, icon="burst")
#define BURST_10_ROUND		list(mode_name="10-round bursts", mode_desc = "Short, uncontrolled bursts", automatic = 0, burst_size=10, fire_delay=null, icon="burst")

#define WEAPON_NORMAL		list(mode_name="standard", burst_size=1, icon="semi")

/// Bullet zone favoring defines
/// High accuracy, generally goes where you mean to put it, for precision rifles and such
#define ZONE_WEIGHT_PRECISION "precision_aim"
/// Typical accuracy, based a bit on range
#define ZONE_WEIGHT_SEMI_AUTO "semiauto_aim"
/// Heavily weights limbs after its effective distance
#define ZONE_WEIGHT_AUTOMATIC "automatic_aim"
/// Always weights limbs heavily
#define ZONE_WEIGHT_SHOTGUN "shotgun_aim"
/// Always defers to the gun's setting, defaults to semi-auto if not defined
#define ZONE_WEIGHT_GUNS_CHOICE "gun's_choice"

/// Typical accuracy falloff
#define ZONE_WEIGHT_FALLOFF_SEMI_AUTO 7
/// Zone accuracy falls off quickly
#define ZONE_WEIGHT_FALLOFF_AUTOMATIC 20
/// You're hitting limbs most of the time
#define ZONE_WEIGHT_FALLOFF_SHOTGUN 100

/// Default zone weight list
#define ZONE_WEIGHT_LIST_DEFAULT list(\
	BODY_ZONE_HEAD = 6,\
	BODY_ZONE_CHEST = 6,\
	BODY_ZONE_L_ARM = 22,\
	BODY_ZONE_R_ARM = 22,\
	BODY_ZONE_L_LEG = 22,\
	BODY_ZONE_R_LEG = 22)
/// Precision zone weight list
#define ZONE_WEIGHT_LIST_PRECISION list(\
	BODY_ZONE_HEAD = 20,\
	BODY_ZONE_CHEST = 40,\
	BODY_ZONE_L_ARM = 5,\
	BODY_ZONE_R_ARM = 5,\
	BODY_ZONE_L_LEG = 5,\
	BODY_ZONE_R_LEG = 5)
/// Autofire zone weight list
#define ZONE_WEIGHT_LIST_AUTOMATIC list(\
	BODY_ZONE_HEAD = 1,\
	BODY_ZONE_CHEST = 3,\
	BODY_ZONE_L_ARM = 22,\
	BODY_ZONE_R_ARM = 22,\
	BODY_ZONE_L_LEG = 22,\
	BODY_ZONE_R_LEG = 22)
/// Pellet zone weight list
#define ZONE_WEIGHT_LIST_SHOTGUN list(\
	BODY_ZONE_HEAD = 1,\
	BODY_ZONE_CHEST = 1,\
	BODY_ZONE_L_ARM = 22,\
	BODY_ZONE_R_ARM = 22,\
	BODY_ZONE_L_LEG = 22,\
	BODY_ZONE_R_LEG = 22)

/// Gun skill flags
/// Gun is affected by rifleman skill
#define AFFECTED_BY_FAST_PUMP (1<<0)
/// If you autopump this gun, it'll have a debuff to its refire rate till you fire again
#define AFFECTED_BY_AUTO_PUMP (1<<1)

/// Gun cooldown mod flags
/// Gun is slower to refire if you autopump it (without fast pump)
#define GUN_AUTO_PUMPED (1<<0)

/// Gun handedness defines -- for picking which direction to toss casings
#define GUN_EJECTOR_RIGHT 1
#define GUN_EJECTOR_LEFT 2
#define GUN_EJECTOR_ANY 3

/// Gun misfire actions
#define GUN_MF_CHANCE "misfire_chance"

/// Gun does damage when it misfires
/// Gun hurts you define
#define GUN_MF_HURTS_YOU "pow_ow"
/// Gun hurts you low damage define
#define GUN_MF_HURTS_YOU_DAMAGE_LOW "low_end_damage_it_hurts_you_you_when_it_pows"
/// Gun hurts you high damage define
#define GUN_MF_HURTS_YOU_DAMAGE_HIGH "high_end_damage_it_hurts_you_you_when_it_pows"
/// Gun hurts you with this type of damage define
#define GUN_MF_HURTS_YOU_DAMAGE_TYPE "damage_type_it_hurts_you_you_when_it_pows"
/// Varied minimum list
#define GUN_MISFIRE_HURTS_USER(chance, dmg_low, dmg_high, dmg_type) GUN_MF_HURTS_YOU = list(\
	GUN_MF_CHANCE = chance,\
	GUN_MF_HURTS_YOU_DAMAGE_LOW = dmg_low,\
	GUN_MF_HURTS_YOU_DAMAGE_HIGH = dmg_high,\
	GUN_MF_HURTS_YOU_DAMAGE_TYPE = dmg_type)

/// Gun yeets itself out of your hand when it misfires
/// Gun yeets define
#define GUN_MF_YEET "pow_yeet"
/// Gun yeets the gun entry
#define GUN_MISFIRE_THROWS_GUN(chance) GUN_MF_YEET = list(\
	GUN_MF_CHANCE = chance)

/// Gun dumps out its ammo
/// Gun dump define
#define GUN_MF_DUMP "pow_dump"
/// Gun dump throw it define
#define GUN_MF_DUMP_THROW "dump_yeet_chance"
/// Gun dump the gun entry
#define GUN_MISFIRE_UNLOADS_GUN(chance, throw_chance) GUN_MF_DUMP = list(\
	GUN_MF_CHANCE = chance,\
	GUN_MF_DUMP_THROW = throw_chance)

/// cooldown for being spammed with messages you're holding the stupid gun wrong
#define GUN_HOLD_IT_RIGHT_MESSAGE_ANTISPAM_TIME 1 SECONDS

/// cooldown for being spammed with messages that you shot the gun
#define GUN_SHOOT_MESSAGE_ANTISPAM_TIME 0.5 SECONDS

