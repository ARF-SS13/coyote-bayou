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

//bitflag damage defines used for suicide_act
#define BRUTELOSS 		(1<<0)
#define FIRELOSS 		(1<<1)
#define TOXLOSS 		(1<<2)
#define OXYLOSS 		(1<<3)
#define SHAME 			(1<<4)
#define MANUAL_SUICIDE	(1<<5)	//suicide_act will do the actual killing.

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
#define TOTAL_MASS_MEDIEVAL_WEAPON	3.6 //very, very generic average sword/warpick/etc. weight in pounds.
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
#define BULLET_DAMAGE_PISTOL_LIGHT 10
#define BULLET_DAMAGE_PISTOL_MEDIUM 15
#define BULLET_DAMAGE_PISTOL_HEAVY 20
#define BULLET_DAMAGE_RIFLE_LIGHT 25
#define BULLET_DAMAGE_RIFLE_MEDIUM 40
#define BULLET_DAMAGE_RIFLE_HEAVY 50
#define BULLET_DAMAGE_SHOTGUN_PELLET 10
#define BULLET_DAMAGE_SHOTGUN_SLUG 40

/// Bullet recoil defines
#define BULLET_RECOIL_PISTOL_LIGHT 0
#define BULLET_RECOIL_PISTOL_MEDIUM 0.25
#define BULLET_RECOIL_PISTOL_HEAVY 1
#define BULLET_RECOIL_RIFLE_LIGHT 0.1
#define BULLET_RECOIL_RIFLE_MEDIUM 0.5
#define BULLET_RECOIL_RIFLE_HEAVY 2
#define BULLET_RECOIL_SHOTGUN_PELLET 2 // The total recoil of the shell, not individual pellets
#define BULLET_RECOIL_SHOTGUN_SLUG 2

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
#define RUBBERY_STAMINA_PISTOL_MEDIUM (BULLET_DAMAGE_PISTOL_MEDIUM * 2)
#define RUBBERY_STAMINA_PISTOL_HEAVY (BULLET_DAMAGE_PISTOL_HEAVY * 2)
#define RUBBERY_STAMINA_RIFLE_LIGHT (BULLET_DAMAGE_RIFLE_LIGHT * 0.5)
#define RUBBERY_STAMINA_RIFLE_MEDIUM (BULLET_DAMAGE_RIFLE_MEDIUM * 2)
#define RUBBERY_STAMINA_RIFLE_HEAVY (BULLET_DAMAGE_RIFLE_HEAVY * 3)
#define RUBBERY_STAMINA_SHOTGUN_PELLET (BULLET_DAMAGE_SHOTGUN_PELLET)
#define RUBBERY_STAMINA_SHOTGUN_SLUG (BULLET_STAMINA_SHOTGUN_SLUG * 2)

/// Shotgun pellet count defines
#define SHOTGUN_PELLET_BASE 5
#define SHOTGUN_PELLET_IMPROVISED 10

/// Shotgun pellet spread defines
#define SHOTGUN_SPREAD_BASE 18
#define SHOTGUN_SPREAD_IMPROVISED 25

/// Bullet damage modifier defines
#define BULLET_MATCH_MULT 1.5 // rare, pack a punch
#define BULLET_SURPLUS_MULT 1 // standard ammo from an ammobench
#define BULLET_HANDLOAD_MULT 0.5 // trash ammo you can make anywhere with a reloader tool, most common

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
#define RUBBERY_WOUND_SHOTGUN_SLUG (BULLET_WOUND_SHOTGUN_SLUG * 1.1)

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

/// Max spread recoil can add
#define GUN_RECOIL_MAX_SPREAD 2

/// Sawed-off recoil modifier
#define SAWEDOFF_RECOIL_MULT 2

/// Hobogun recoil modifier
#define HOBO_RECOIL_MULT 2

/// Automatic pistol recoil modifier
#define AUTOPISTOL_RECOIL_MULT 2

/// Gun recoil modifier per shot defines
#define GUN_RECOIL_NONE 0
#define GUN_RECOIL_PISTOL_LIGHT 1
#define GUN_RECOIL_PISTOL_MEDIUM 1.2
#define GUN_RECOIL_PISTOL_HEAVY 1.5
#define GUN_RECOIL_REVOLVER_LIGHT 1
#define GUN_RECOIL_REVOLVER_HEAVY 0.5
#define GUN_RECOIL_REPEATER 0.5
#define GUN_RECOIL_CARBINE 0.5
#define GUN_RECOIL_SMG_LIGHT 2
#define GUN_RECOIL_SMG_HEAVY 1.5
#define GUN_RECOIL_RIFLE_BOLT 0
#define GUN_RECOIL_RIFLE_LIGHT_SEMI 1
#define GUN_RECOIL_RIFLE_LIGHT_AUTO 2
#define GUN_RECOIL_RIFLE_MEDIUM_SEMI 1
#define GUN_RECOIL_RIFLE_MEDIUM_AUTO 2
#define GUN_RECOIL_RIFLE_LMG 1
#define GUN_RECOIL_RIFLE_GAUSS 5
#define GUN_RECOIL_SHOTGUN_FIXED 2
#define GUN_RECOIL_SHOTGUN_PUMP 1
#define GUN_RECOIL_SHOTGUN_AUTO 3

/// Gun recoil timeout Base
#define GUN_RECOIL_TIMEOUT_BASE (1.5 SECONDS)

/// Gun recoil timeout modifiers
#define GUN_RECOIL_TIMEOUT_INSTANT (GUN_RECOIL_TIMEOUT_BASE * 0)
#define GUN_RECOIL_TIMEOUT_QUICK (GUN_RECOIL_TIMEOUT_BASE * 0.5)
#define GUN_RECOIL_TIMEOUT_NORMAL (GUN_RECOIL_TIMEOUT_BASE * 1)
#define GUN_RECOIL_TIMEOUT_LONG (GUN_RECOIL_TIMEOUT_BASE * 1.5)

/// Gun spread Base
#define GUN_SPREAD_BASE 1

/// Gun spread modifiers
#define GUN_SPREAD_NONE (GUN_SPREAD_BASE * 0)
#define GUN_SPREAD_ACCURATE (GUN_SPREAD_BASE * 0.5)
#define GUN_SPREAD_NORMAL (GUN_SPREAD_BASE * 1)
#define GUN_SPREAD_POOR (GUN_SPREAD_BASE * 1.5)

/// Gun fire delay Base
#define GUN_FIRE_DELAY_BASE (1 SECOND)

/// Gun fire delay modifiers
#define GUN_FIRE_DELAY_FASTEST (GUN_FIRE_DELAY_BASE * 0) // Mostly just good for automatics
#define GUN_FIRE_DELAY_FASTER (GUN_FIRE_DELAY_BASE * CLICK_CD_RAPID * 0.1) // 0.2s Mostly just good for automatics
#define GUN_FIRE_DELAY_FAST (GUN_FIRE_DELAY_BASE * CLICK_CD_RANGE * 0.1) // 0.5s
#define GUN_FIRE_DELAY_NORMAL (GUN_FIRE_DELAY_BASE * 0.6) // 0.6s
#define GUN_FIRE_DELAY_SLOW (GUN_FIRE_DELAY_BASE * CLICK_CD_MELEE * 0.1) //0.8s
#define GUN_FIRE_DELAY_SLOWER (GUN_FIRE_DELAY_BASE) //1.0s

/// Gun autofire delay Base
#define GUN_AUTOFIRE_DELAY_BASE (1 DECISECOND)

/// Gun fire delay modifiers
#define GUN_AUTOFIRE_DELAY_FASTEST (GUN_AUTOFIRE_DELAY_BASE * 0)
#define GUN_AUTOFIRE_DELAY_FASTER (GUN_AUTOFIRE_DELAY_BASE * 1)
#define GUN_AUTOFIRE_DELAY_FAST (GUN_AUTOFIRE_DELAY_BASE * 2)
#define GUN_AUTOFIRE_DELAY_NORMAL (GUN_AUTOFIRE_DELAY_BASE * 3)
#define GUN_AUTOFIRE_DELAY_SLOW (GUN_AUTOFIRE_DELAY_BASE * 4)
#define GUN_AUTOFIRE_DELAY_SLOWER (GUN_AUTOFIRE_DELAY_BASE * 5)

/// Gun burstfire delay Base
#define GUN_BURSTFIRE_DELAY_BASE (1 DECISECOND)

/// Gun fire delay modifiers
#define GUN_BURSTFIRE_DELAY_FASTEST (GUN_BURSTFIRE_DELAY_BASE * 0)
#define GUN_BURSTFIRE_DELAY_FASTER (GUN_BURSTFIRE_DELAY_BASE * 1)
#define GUN_BURSTFIRE_DELAY_FAST (GUN_BURSTFIRE_DELAY_BASE * 2)
#define GUN_BURSTFIRE_DELAY_NORMAL (GUN_BURSTFIRE_DELAY_BASE * 3)
#define GUN_BURSTFIRE_DELAY_SLOW (GUN_BURSTFIRE_DELAY_BASE * 4)
#define GUN_BURSTFIRE_DELAY_SLOWER (GUN_BURSTFIRE_DELAY_BASE * 5)

/// Time after you draw a gun that you're able to shoot it
#define GUN_AIMING_TIME (1.5 SECONDS)

/// Gun draw time modifiers
#define GUN_DRAW_QUICK (GUN_AIMING_TIME * 0) // Draw, pardner
#define GUN_DRAW_NORMAL (GUN_AIMING_TIME * 1)
#define GUN_DRAW_LONG (GUN_AIMING_TIME * 1.5)

/// Gun weapon weight
#define GUN_ONE_HAND_AKIMBO 1
#define GUN_ONE_HAND_ONLY 2
#define GUN_TWO_HAND_ONLY 3

/// Gun bullet damage base
/// Multiplied against the gun's default bullet and added to the damage
/// A value of 1 would couble the gun's damage per shot
#define GUN_EXTRA_DAMAGE_0 0
#define GUN_EXTRA_DAMAGE_T1 0.10
#define GUN_EXTRA_DAMAGE_T2 0.15
#define GUN_EXTRA_DAMAGE_T3 0.25
#define GUN_EXTRA_DAMAGE_T4 0.35
#define GUN_EXTRA_DAMAGE_T5 0.50

/// Gun melee force base
#define GUN_MELEE_FORCE_BASE 12

/// Gun weapon weight
#define GUN_MELEE_FORCE_PISTOL_LIGHT (GUN_MELEE_FORCE_BASE * 1) // 12
#define GUN_MELEE_FORCE_PISTOL_HEAVY (GUN_MELEE_FORCE_BASE * 1.25) //15
#define GUN_MELEE_FORCE_RIFLE_LIGHT (GUN_MELEE_FORCE_BASE * 1.5) //18
#define GUN_MELEE_FORCE_RIFLE_HEAVY (GUN_MELEE_FORCE_BASE * 2) // 24
#define GUN_MELEE_FORCE_RIFLE_GUNBLADE (GUN_MELEE_FORCE_BASE * 2.5) //30
