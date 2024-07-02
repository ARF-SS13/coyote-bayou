/*
* This commented block is just here as a template.______qdel_list_wrapper(list/L)
*
* Dont use this

/datum/job/redwater/townie
	title = "Redwater Townie"
	flag = F13RAIDER
	department_head = list("Captain")
	head_announce = list("Security")
	faction = FACTION_WASTELAND
	social_faction = FACTION_RAIDERS
	total_positions = 16
	spawn_positions = 16
	description = "You are an Outlaw - the choice of why is up to you. You are responsible for making the wasteland unsafe and today is another day to antagonize it. You may be varied in your approaches, but you must have motives that are realistic for your job."
	supervisors = "your conscious if you have one"
	selection_color = "#df80af"
	exp_requirements = 0
	exp_type = EXP_TYPE_WASTELAND

	outfit = /datum/outfit/job/cb/redwater

	access = list()
	minimal_access = list()
	matchmaking_allowed = list(
		/datum/matchmaking_pref/patron = list(
			/datum/job/redwater/townie,
		),
		/datum/matchmaking_pref/protegee = list(
			/datum/job/redwater/townie,
		),
		/datum/matchmaking_pref/outlaw = list(
			/datum/job/redwater/townie,
		),
		/datum/matchmaking_pref/bounty_hunter = list(
			/datum/job/redwater/townie,
		),
	)
	loadout_options = list(
//	/datum/outfit/loadout/raider_sheriff,
	/datum/outfit/loadout/raider_sadist,
//	/datum/outfit/loadout/raider_mobster,
	/datum/outfit/loadout/raider_tribal,
	/datum/outfit/loadout/raider_supafly,
	/datum/outfit/loadout/raider_yankee,
	/datum/outfit/loadout/raider_blast,
	/datum/outfit/loadout/raider_painspike,
	/datum/outfit/loadout/raider_badlands,
	// /datum/outfit/loadout/raider_smith,
	/datum/outfit/loadout/raider_vault,
	/datum/outfit/loadout/raider_ncr,
	// /datum/outfit/loadout/raider_legion,
	/datum/outfit/loadout/raider_bos,
	/datum/outfit/loadout/quack_doctor
	)


/datum/outfit/job/cb/redwater
	name = "Redwater Townie"
	jobtype = /datum/job/redwater/townie
	id = null
	ears = null
	belt = /obj/item/supplykit
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	gloves = /obj/item/clothing/gloves/f13/handwraps
	r_pocket = /obj/item/flashlight/flare
	box = /obj/item/storage/survivalkit/outlaw
	box_two = /obj/item/storage/survivalkit/medical
	backpack_contents = list(
		/obj/item/restraints/handcuffs = 2,
		/obj/item/melee/onehanded/club = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
	//	/obj/item/storage/bag/money/small/raider = 1,
		/obj/item/radio = 1,
		)
*/



