#define LVL_MASTER var/mob/master = parent; if(!master) return;

/datum/component/xp
	var/pvp_lvl = 0
	var/pvp_xp = 0
	var/pvp_xp_total = 0

	var/pve_lvl = 0
	var/pve_xp = 0
	var/pve_xp_total = 0

	var/healer_lvl = 0
	var/healer_xp = 0
	var/healer_xp_total = 0

	var/trader_lvl = 0
	var/trader_xp = 0
	var/trader_xp_total = 0

	var/richguy_lvl = 0
	var/richguy_xp = 0
	var/richguy_xp_total = 0

	var/erp_lvl = 0
	var/erp_xp = 0
	var/erp_xp_total = 0

	var/list/kills = list() // coming soon!

	var/client_loaded = FALSE
	var/my_ckey

	COOLDOWN_DECLARE(next_save)
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/xp/Initialize()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_MOB_CLIENT_LOGIN), .proc/load_from_prefs)
	RegisterSignal(parent, list(COMSIG_MOB_GHOSTIZE_FINAL), .proc/save_to_prefs)
	RegisterSignal(parent, list(COMSIG_PARENT_DEALT_DAMAGE), .proc/adjust_combat_xp)
	RegisterSignal(parent, list(COMSIG_PARENT_HEALED), .proc/adjust_healer_xp)
	RegisterSignal(parent, list(COMSIG_PARENT_SALVAGED_SOMETHING), .proc/adjust_trader_xp)
	RegisterSignal(parent, list(COMSIG_PARENT_SOLD_SOMETHING), .proc/adjust_trader_xp)
	RegisterSignal(parent, list(COMSIG_PARENT_DEPOSITED_CASH), .proc/adjust_rich_guy_xp)
	RegisterSignal(parent, list(COMSIG_PARENT_COMMUNICATED), .proc/adjust_erp_xp)

/datum/component/xp/proc/load_from_prefs()
	LVL_MASTER
	if(!master.client)
		return
	if(client_loaded)
		return // Don't load from prefs if we've already loaded in their prefs
	var/datum/preferences/P = master.client.prefs
	if(!P)
		return
	pvp_xp_total = P.pvp_xp_total
	pve_xp_total = P.pve_xp_total
	healer_xp_total = P.healer_xp_total
	trader_xp_total = P.trader_xp_total
	richguy_xp_total = P.richguy_xp_total
	erp_xp_total = P.erp_xp_total
	calc_xp(XP_ALL, TRUE)

/datum/component/xp/proc/save_to_prefs(silent = FALSE)
	LVL_MASTER
	if(!master.client)
		return
	var/datum/preferences/P = master.client.prefs
	if(!P)
		return
	P.pvp_xp_total = pvp_xp_total
	P.pve_xp_total = pve_xp_total
	P.healer_xp_total = healer_xp_total
	P.trader_xp_total = trader_xp_total
	P.richguy_xp_total = richguy_xp_total
	P.erp_xp_total = erp_xp_total
	if(P.save_character() && !silent)
		to_chat(master.client, span_green("Your XP has been saved!"))

/datum/component/xp/proc/calc_xp(recalc_flags, silent = FALSE)
	if(CHECK_BITFIELD(recalc_flags, XP_PVP))
		calc_lvl(pvp_xp_total)
		calc_current(pvp_xp_total)
	if(CHECK_BITFIELD(recalc_flags, XP_PVE))
		calc_lvl(pve_xp_total)
		calc_current(pve_xp_total)
	if(CHECK_BITFIELD(recalc_flags, XP_HEALER))
		calc_lvl(healer_xp_total)
		calc_current(healer_xp_total)
	if(CHECK_BITFIELD(recalc_flags, XP_TRADER))
		calc_lvl(trader_xp_total)
		calc_current(trader_xp_total)
	if(CHECK_BITFIELD(recalc_flags, XP_RICHGUY))
		calc_lvl(richguy_xp_total)
		calc_current(richguy_xp_total)
	if(CHECK_BITFIELD(recalc_flags, XP_ERP))
		calc_lvl(erp_xp_total)
		calc_current(erp_xp_total)
	
	if(silent)






