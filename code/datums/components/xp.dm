#define LVL_MASTER var/mob/master = parent; if(!master) return;

#define XP_ALL list(\
	XP_PVP,\
	XP_PVE,\
	XP_HEALER,\
	XP_TRADER,\
	XP_RICHGUY,\
	XP_ERP\
)

/// Mostly just a transducer that converts signals sent to the mob into XP actions
/// THis way we can connect our character to the XP system without having to
/// make any hard references at all!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

/datum/component/xp
	var/list/lvl_data = list()

	var/list/kills = list() // coming soon!

	var/client_loaded = FALSE
	var/my_ckey

	COOLDOWN_DECLARE(next_save)
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/xp/Initialize()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_PARENT_DEALT_DAMAGE),       .proc/adjust_combat_xp)
	RegisterSignal(parent, list(COMSIG_PARENT_HEALED),             .proc/adjust_healer_xp)
	RegisterSignal(parent, list(COMSIG_PARENT_SALVAGED_SOMETHING), .proc/adjust_trader_xp)
	RegisterSignal(parent, list(COMSIG_PARENT_SOLD_SOMETHING),     .proc/adjust_trader_xp)
	RegisterSignal(parent, list(COMSIG_PARENT_DEPOSITED_CASH),     .proc/adjust_rich_guy_xp)
	RegisterSignal(parent, list(COMSIG_PARENT_COMMUNICATED),       .proc/adjust_erp_xp)

/datum/component/xp/proc/adjust_combat_xp(datum/source, mob/living/attacker, mob/living/victim, damage)
	if(!victim)
		return
	if(!attacker)
		return
	if(attacker == victim)
		return
	if(attacker.client)
		SSexperience.adjust_xp(master, XP_PVP, damage, list(attacker, victim))
	else
		SSexperience.adjust_xp(master, XP_PVE, damage, list(attacker, victim))







