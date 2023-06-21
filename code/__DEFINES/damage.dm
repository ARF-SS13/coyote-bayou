
//Damage and status effect defines

/// Bullet act returns a fuckhuge list. This entry will be the part projectiles care about!
#define BULLET_ACT_RETURN_VALUE "BULLET_ACT_RETURN_VALUE"

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

#define SLIME_DAMAGE_LOW 10
#define SLIME_DAMAGE_HIGH 15
#define SLIME_WOUNDING 15
#define SLIME_DAMAGE_TYPE CLONE
#define ADULT_SLIME_DAMAGE_LOW 25
#define ADULT_SLIME_DAMAGE_HIGH 30
#define ADULT_SLIME_WOUNDING 25
#define ADULT_SLIME_DAMAGE_TYPE CLONE
#define SLIME_ARMOR_CHECK ARMOR_ENERGY

#define MONKEY_DAMAGE_LOW 15
#define MONKEY_DAMAGE_HIGH 20
#define MONKEY_WOUNDING 0
#define MONKEY_DAMAGE_TYPE BRUTE
#define LARVA_DAMAGE_LOW 1
#define LARVA_DAMAGE_HIGH 3
#define LARVA_WOUNDING 0
#define LARVA_DAMAGE_TYPE BRUTE

/// Damage Tags - input, and output
#define DAMAGE_FORCE             "force"
#define DAMAGE_FORCE_LOW         "force_low"
#define DAMAGE_FORCE_HIGH        "force_high"
#define DAMAGE_STAMINA           "stamina"
#define DAMAGE_TYPE              "damtype"
#define DAMAGE_ARMOR_CHECK       "damage_armor"
#define DAMAGE_WOUND_BONUS       "wound_bonus"
#define DAMAGE_WOUND_NAKED       "wound_naked"
#define DAMAGE_SHARPNESS         "sharpness"
#define DAMAGE_ARMOR_PENETRATION "armour_penetration"
#define DAMAGE_DT_MODIFIER       "damage_threshold_modifier"
#define DAMAGE_ZONE              "defzone"
#define DAMAGE_FORCE_IT          "force_it"
#define DAMAGE_SPREAD            "spread"
#define DAMAGE_SIGNAL            "signal"
#define DAMAGE_DISMEMBER         "dismember"
#define DAMAGE_ATTACK_VERBS      "attack_verbs"
#define DAMAGE_WEAPON_NAME       "weapon_name"
#define DAMAGE_SHOW_MESSAGE      "show_message"
#define DAMAGE_STAMINA_LOW       "stamina_low"
#define DAMAGE_STAMINA_HIGH      "stamina_high"
#define DAMAGE_EFFECT            "effect"
#define DAMAGE_ATTACKCHAIN_FLAGS "attack_chain_flag"

/// Damage override tags
#define DAMAGE_MULTIPLIER        "multiplier"

/// Damage output tags
#define DAMAGE_SHOULD_RETURN     "should_return" // causes the damage chain to abort and return the damage list
#define CHECK_TRAIT_MELEE        "check_melee_traits"
#define CHECK_TRAIT_UNARMED      "check_unarmed_traits"
#define CHECK_TRAIT_RANGED       "check_ranged_traits"
#define STAM_PENALTY_HANDLED     "stam_penalty_handled"
#define DAMAGE_BLOCK_RETURN      "block_return_list"
#define DAMAGE_BLOCK_FLAGS       "block_flags"
#define DAMAGE_BLOCKED           "damage_blocked"
#define DAMAGE_BLOCKED_PERCENT   "damage_blocked_percent"
#define DAMAGE_ARMOR_BLOCKED     "damage_armor_blocked"
#define DAMAGE_DT_BLOCKED        "damage_dt_blocked"

#define TRAIT_FLAG_MELEE         (1<<0)
#define TRAIT_FLAG_UNARMED       (1<<1)
#define TRAIT_FLAG_RANGED        (1<<2)

#define ARMOR_DR 1
#define ARMOR_DT 2

#define DAMAGE_LIST list(\
	DAMAGE_FORCE = 0,\
	DAMAGE_STAMINA = 0,\
	DAMAGE_FORCE_LOW = 0,\
	DAMAGE_FORCE_HIGH = 0,\
	DAMAGE_STAMINA_LOW = 0,\
	DAMAGE_STAMINA_HIGH = 0,\
	DAMAGE_TYPE = BRUTE,\
	DAMAGE_ARMOR_CHECK = ARMOR_MELEE,\
	DAMAGE_WOUND_BONUS = 0,\
	DAMAGE_WOUND_NAKED = 0,\
	DAMAGE_SHARPNESS = 0,\
	DAMAGE_ARMOR_PENETRATION = 0,\
	DAMAGE_DT_MODIFIER = 0,\
	DAMAGE_ZONE = BODY_ZONE_CHEST,\
	DAMAGE_FORCE_IT = 0,\
	DAMAGE_SPREAD = 0,\
	DAMAGE_SIGNAL = 0,\
	DAMAGE_DISMEMBER = 0,\
	DAMAGE_ATTACK_VERBS = list("hit"),\
	DAMAGE_WEAPON_NAME = "something",\
	DAMAGE_EFFECT = FALSE,\
	DAMAGE_SHOW_MESSAGE = TRUE,\
	)

#define DAMLOG_DEFENDER_BEFORE_HP      "damage_log_defender_before_HP"
#define DAMLOG_DEFENDER_MAX_HP         "damage_log_defender_before_HP_max"
#define DAMLOG_DEFENDER_BEFORE_STAMINA "damage_log_defender_before_stamina"
#define DAMLOG_ATTACKER_BEFORE_HP      "damage_log_attacker_before_HP"
#define DAMLOG_ATTACKER_MAX_HP         "damage_log_attacker_before_HP_max"
#define DAMLOG_ATTACKER_BEFORE_STAMINA "damage_log_attacker_before_stamina"
#define DAMLOG_ATTACKER_IS_LIVING      "damage_log_attacker_is_living"
#define DAMLOG_DEFENDER_AFTER_HP       "damage_log_defender_after_HP"
#define DAMLOG_DEFENDER_AFTER_STAMINA  "damage_log_defender_after_stamina"
#define DAMLOG_DEFENDER_DID_DISMEMBER  "damage_log_defender_dismembered"

/// Literally just LAZYACCESS and LAZYSET, just here cus this file loads before _lists.dm. dont use
#define LA(L, I) (islist(L) ? L[I] : null)
#define LS(L, K, V) (islist(L) && L[K] = V)
/// Use these defines to extract damage tags from the damage_list, if the proc happens after SSdamage.damage_target_with_obj
#define GET_DAMAGE(X)            (LA(X, DAMAGE_FORCE) || 0)
#define SET_DAMAGE(L, X)         (LS(L, DAMAGE_FORCE, X))

#define GET_DAMAGE_TYPE(X)       (LA(X, DAMAGE_TYPE) || BRUTE )

#define GET_STAMINA(X)           (LA(X, DAMAGE_STAMINA) || 0 )
#define SET_STAMINA(L, X)        (LS(L, DAMAGE_TYPE, X))

#define GET_ARMOR_CHECK(X)         (LA(X, DAMAGE_ARMOR_CHECK)       || ARMOR_MELEE    )
#define GET_WOUND_BONUS(X)         (LA(X, DAMAGE_WOUND_BONUS)       || 0              )
#define GET_WOUND_NAKED(X)         (LA(X, DAMAGE_WOUND_NAKED)       || 0              )
#define GET_SHARPNESS(X)           (LA(X, DAMAGE_SHARPNESS)         || 0              )
#define GET_ARMOR_PENETRATION(X)   (LA(X, DAMAGE_ARMOR_PENETRATION) || 0              )
#define GET_DT_MODIFIER(X)         (LA(X, DAMAGE_DT_MODIFIER)       || 0              )
#define GET_ZONE(X)                (LA(X, DAMAGE_ZONE)              || BODY_ZONE_CHEST)
#define GET_FORCE_IT(X)            (LA(X, DAMAGE_FORCE_IT)          || 0              )
#define GET_SPREAD(X)              (LA(X, DAMAGE_SPREAD)            || 0              )
#define GET_SIGNAL(X)              (LA(X, DAMAGE_SIGNAL)            || 0              )
#define GET_DISMEMBER(X)           (LA(X, DAMAGE_DISMEMBER)         || 0              )
#define GET_ATTACK_VERBS(X)        (LA(X, DAMAGE_ATTACK_VERBS)      || list("hit")    )
#define GET_SHOULD_RETURN(X)       (LA(X, DAMAGE_SHOULD_RETURN)     || 0              )
#define GET_WEAPON_NAME(X)         (LA(X, DAMAGE_WEAPON_NAME)       || "something"    )
#define GET_ATTACKCHAIN_FLAGS(X)   (LA(X, DAMAGE_ATTACKCHAIN_FLAGS) || 0              )
#define GET_MULTIPLIER(X)          (LA(X, DAMAGE_MULTIPLIER)        || 1              )
#define GET_ARMOR_BLOCKED(X)       (LA(X, DAMAGE_ARMOR_BLOCKED)     || 0              )
#define GET_CHECK_TRAIT_MELEE(X)   (LA(X, CHECK_TRAIT_MELEE)        || 0              )
#define GET_CHECK_TRAIT_UNARMED(X) (LA(X, CHECK_TRAIT_UNARMED)      || 0              )
#define GET_CHECK_TRAIT_RANGED(X)  (LA(X, CHECK_TRAIT_RANGED)       || 0              )
#define GET_BULLET_RETURN(X)       (LA(X, BULLET_ACT_RETURN_VALUE)  || 0              )
#define GET_BLOCKED_PERCENT(X)     (LA(X, DAMAGE_BLOCKED_PERCENT)   || 0              )

