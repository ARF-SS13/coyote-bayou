/* Cards
 * Contains:
 *		DATA CARD
 *		ID CARD
 *		FINGERPRINT CARD HOLDER
 *		FINGERPRINT CARD
 */

/*
 * DATA CARDS - Used for the IC data card reader
 */
/obj/item/card
	name = "card"
	desc = "Does card things."
	icon = 'icons/obj/card.dmi'
	w_class = WEIGHT_CLASS_TINY

	/// Can this card be punched in the card puncher?
	var/punchable = FALSE
	/// Has it been punched?
	var/punched = FALSE
	/// what icon_state to use when punched
	var/punched_state = "card-id"
	var/list/files = list()

	/// PRICES ARE IN TENTHS OF A COPPER (cus cargo uses credits, even tho it doesnt look like it)
	/// How much the card is worth
	var/saleprice = 0
	/// How much the puncher gives out for free
	var/punchbonus = 0
	var/this_is_easier_than_actually_removing_them = FALSE


/obj/item/card/Initialize(mapload)
	. = ..()
	if(this_is_easier_than_actually_removing_them)
		// if(prob(50))
		// 	SSartifacts.spawn_random_artifact(loc)
		return INITIALIZE_HINT_QDEL

/obj/item/card/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_GET_VALUE,PROC_REF(tabulate_value))
	RegisterSignal(src, COMSIG_ITEM_GET_RESEARCH_POINTS,PROC_REF(tabulate_research))

/obj/item/card/proc/tabulate_value()
	return saleprice

/obj/item/card/proc/tabulate_research()
	return saleprice * 5

/obj/item/card/proc/punch(mob/living/user)
	if(!punchable)
		to_chat(user, span_alert("[src] can't be punched!"))
		return
	if(punched)
		to_chat(user, span_alert("There's no more room to punch [src]!"))
		return
	user.visible_message(span_good("[user] punches [src]!"))
	icon_state = punched_state
	name = "Punched [name]"
	punched = TRUE
	return TRUE

/obj/item/card/data
	name = "data card"
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one has a stripe running down the middle."
	icon_state = "data_1"
	obj_flags = UNIQUE_RENAME
	var/function = "storage"
	var/data = "null"
	var/special = null
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	var/detail_color = COLOR_ASSEMBLY_ORANGE

/obj/item/card/data/Initialize()
	.=..()
	update_icon()

/obj/item/card/data/update_overlays()
	. = ..()
	if(detail_color == COLOR_FLOORTILE_GRAY)
		return
	var/mutable_appearance/detail_overlay = mutable_appearance('icons/obj/card.dmi', "[icon_state]-color")
	detail_overlay.color = detail_color
	. += detail_overlay

/obj/item/card/data/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/integrated_electronics/detailer))
		var/obj/item/integrated_electronics/detailer/D = I
		detail_color = D.detail_color
		update_icon()
	return ..()

/obj/item/proc/GetCard()

/obj/item/card/data/GetCard()
	return src

/obj/item/card/data/full_color
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one has the entire card colored."
	icon_state = "data_2"

/obj/item/card/data/disk
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one inexplicibly looks like a floppy disk."
	icon_state = "data_3"

/*
 * ID CARDS
 */
/obj/item/card/emag
	desc = "It's a card with a magnetic strip attached to some circuitry."
	name = "cryptographic sequencer"
	icon_state = "emag"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	item_flags = NO_MAT_REDEMPTION | NOBLUDGEON
	var/prox_check = TRUE //If the emag requires you to be in range
	var/uses = 15

/obj/item/card/emag/bluespace
	name = "bluespace cryptographic sequencer"
	desc = "It's a blue card with a magnetic strip attached to some circuitry. It appears to have some sort of transmitter attached to it."
	icon_state = "emag_bs"
	prox_check = FALSE

/obj/item/card/emag/attack()
	return

/obj/item/card/emag/afterattack(atom/target, mob/user, proximity)
	. = ..()
	var/atom/A = target
	if(!proximity && prox_check || !(isobj(A) || issilicon(A) || isbot(A) || isdrone(A)))
		return
	if(istype(A, /obj/item/storage) && !(istype(A, /obj/item/storage/lockbox) || istype(A, /obj/item/storage/pod)))
		return
	if(!uses)
		user.visible_message(span_warning("[src] emits a weak spark. It's burnt out!"))
		playsound(src, 'sound/effects/light_flicker.ogg', 100, 1)
		return
	else if(uses <= 3)
		playsound(src, 'sound/effects/light_flicker.ogg', 30, 1)	//Tiiiiiiny warning sound to let ya know your emag's almost dead
	if(!A.emag_act(user))
		return
	uses = max(uses - 1, 0)
	if(!uses)
		user.visible_message(span_warning("[src] fizzles and sparks. It seems like it's out of charges."))
		playsound(src, 'sound/effects/light_flicker.ogg', 100, 1)

/obj/item/card/emag/examine(mob/user)
	. = ..()
	. += span_notice("It has <b>[uses ? uses : "no"]</b> charges left.")

/obj/item/card/id/examine_more(mob/user)
	var/list/msg = list(span_notice("<i>You examine [src] closer, and note the following...</i>"))

	if(mining_points)
		msg += "There's [mining_points] mining equipment redemption point\s loaded onto this card."
	if(registered_account)
		msg += "The account linked to the ID belongs to '[registered_account.account_holder]' and reports a balance of [registered_account.account_balance] cr."
		if(registered_account.account_job)
			var/datum/bank_account/D = SSeconomy.get_dep_account(registered_account.account_job.paycheck_department)
			if(D)
				msg += "The [D.account_holder] reports a balance of [D.account_balance] cr."
		msg += span_info("Alt-Click the ID to pull money from the linked account in the form of holochips.")
		msg += span_info("You can insert credits into the linked account by pressing holochips, cash, or coins against the ID.")
		if(registered_account.account_holder == user.real_name)
			msg += span_boldnotice("If you lose this ID card, you can reclaim your account by Alt-Clicking a blank ID card while holding it and entering your account ID number.")
	else
		msg += span_info("There is no registered account linked to this card. Alt-Click to add one.")

	return msg

/obj/item/card/emag/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/emagrecharge))
		var/obj/item/emagrecharge/ER = W
		if(ER.uses)
			uses += ER.uses
			to_chat(user, span_notice("You have added [ER.uses] charges to [src]. It now has [uses] charges."))
			playsound(src, "sparks", 100, 1)
			ER.uses = 0
		else
			to_chat(user, span_warning("[ER] has no charges left."))
		return
	. = ..()

/obj/item/card/emag/empty
	uses = 0

/obj/item/emagrecharge
	name = "electromagnet charging device"
	desc = "A small cell with two prongs lazily jabbed into it. It looks like it's made for charging the small batteries found in electromagnetic devices, sadly this can't be recharged like a normal cell."
	icon = 'icons/obj/module.dmi'
	icon_state = "cell_mini"
	item_flags = NOBLUDGEON
	var/uses = 5	//Dictates how many charges the device adds to compatible items

/obj/item/emagrecharge/examine(mob/user)
	. = ..()
	if(uses)
		. += span_notice("It can add up to [uses] charges to compatible devices")
	else
		. += span_warning("It has a small, red, blinking light coming from inside of it. It's spent.")

/obj/item/card/emagfake
	desc = "It's a card with a magnetic strip attached to some circuitry. Closer inspection shows that this card is a poorly made replica, with a \"DonkCo\" logo stamped on the back."
	name = "cryptographic sequencer"
	icon_state = "emag"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/emagfake/afterattack()
	. = ..()
	playsound(src, 'sound/items/bikehorn.ogg', 50, 1)

/obj/item/card/id
	name = "identification card"
	desc = "A card used to provide ID and determine access."
	icon_state = "id"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	slot_flags = INV_SLOTBIT_ID
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/assignment_name = "identification card"
	var/mining_points = 0 //For redeeming at mining equipment vendors
	var/list/access = list()
	var/registered_name = null // The name registered_name on the card
	var/assignment = null
	var/access_txt // mapping aid
	var/bank_support = ID_FREE_BANK_ACCOUNT
	var/datum/bank_account/registered_account
	var/obj/machinery/paystand/my_store
	var/uses_overlays = TRUE
	var/icon/cached_flat_icon

/obj/item/card/id/Initialize(mapload)
	. = ..()
	if(mapload && access_txt)
		access = text2access(access_txt)
	/* //fortuna removal
	switch(bank_support)
		if(ID_FREE_BANK_ACCOUNT)
			var/turf/T = get_turf(src)
			if(T && is_vr_level(T.z)) //economy is exploitable on VR in so many ways.
				bank_support = ID_NO_BANK_ACCOUNT
		if(ID_LOCKED_BANK_ACCOUNT)
			registered_account = new /datum/bank_account/remote/non_transferable(pick(GLOB.redacted_strings))
	*/
/obj/item/card/id/Destroy()
	if(bank_support == ID_LOCKED_BANK_ACCOUNT)
		QDEL_NULL(registered_account)
	else
		registered_account = null
	if(my_store)
		my_store.my_card = null
		my_store = null
	SEND_SIGNAL(src, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_GOD)
	return ..()

/obj/item/card/id/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if(NAMEOF(src, assignment),NAMEOF(src, registered_name)) //,NAMEOF(src, registered_age))
				update_label()

/obj/item/card/id/attack_self(mob/user)
	if(Adjacent(user))
		user.visible_message(span_notice("[user] shows you: [icon2html(src, viewers(user))] [src.name]."), \
					span_notice("You show \the [src.name]."))
		add_fingerprint(user)

/obj/item/card/id/attackby(obj/item/W, mob/user, params)
	if(!bank_support)
		return ..()
	/* //fortuna removal
	if(istype(W, /obj/item/holochip))
		insert_money(W, user)
	else if(istype(W, /obj/item/stack/spacecash) || istype(W, /obj/item/coin))
		insert_money(W, user, TRUE)
	else if(istype(W, /obj/item/storage/bag/money))
		var/obj/item/storage/bag/money/money_bag = W
		var/list/money_contained = money_bag.contents
		var/money_added = mass_insert_money(money_contained, user)
		if (money_added)
			to_chat(user, span_notice("You stuff the contents into the card! They disappear in a puff of bluespace smoke, adding [money_added] worth of credits to the linked account."))
	*/
	else
		return ..()

/obj/item/card/id/proc/insert_money(obj/item/I, mob/user, physical_currency)
	if(!registered_account)
		to_chat(user, span_warning("[src] doesn't have a linked account to deposit [I] into!"))
		return
	var/cash_money = I.get_item_credit_value()
	if(!cash_money)
		to_chat(user, span_warning("[I] doesn't seem to be worth anything!"))
		return
	registered_account.adjust_money(cash_money)
	if(physical_currency)
		to_chat(user, span_notice("You stuff [I] into [src]. It disappears in a small puff of bluespace smoke, adding [cash_money] credits to the linked account."))
	else
		to_chat(user, span_notice("You insert [I] into [src], adding [cash_money] credits to the linked account."))

	to_chat(user, span_notice("The linked account now reports a balance of [registered_account.account_balance] cr."))
	qdel(I)

/obj/item/card/id/proc/mass_insert_money(list/money, mob/user)
	if(!registered_account)
		to_chat(user, span_warning("[src] doesn't have a linked account to deposit into!"))
		return FALSE

	if (!money || !money.len)
		return FALSE

	var/total = 0

	for (var/obj/item/physical_money in money)
		total += physical_money.get_item_credit_value()
		CHECK_TICK

	registered_account.adjust_money(total)

	QDEL_LIST(money)

	return total

/obj/item/card/id/proc/alt_click_can_use_id(mob/living/user)
	if(!isliving(user))
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	return TRUE

// Returns true if new account was set.
/obj/item/card/id/proc/set_new_account(mob/living/user)
	if(bank_support != ID_FREE_BANK_ACCOUNT)
		to_chat(user, span_warning("This ID has no modular banking support whatsover, must be an older model..."))
		return
	. = FALSE
	var/datum/bank_account/old_account = registered_account

	var/new_bank_id = input(user, "Enter your account ID number.", "Account Reclamation", 111111) as num | null

	if (isnull(new_bank_id))
		return

	if(!alt_click_can_use_id(user))
		return
	if(!new_bank_id || new_bank_id < 111111 || new_bank_id > 999999)
		to_chat(user, span_warning("The account ID number needs to be between 111111 and 999999."))
		return
	if (registered_account && registered_account.account_id == new_bank_id)
		to_chat(user, span_warning("The account ID was already assigned to this card."))
		return

	for(var/A in SSeconomy.bank_accounts)
		var/datum/bank_account/B = A
		if(B.account_id == new_bank_id)
			if (old_account)
				old_account.bank_cards -= src

			B.bank_cards += src
			registered_account = B
			to_chat(user, span_notice("The provided account has been linked to this ID card."))

			return TRUE

	to_chat(user, span_warning("The account ID number provided is invalid."))
	return

/obj/item/card/id/AltClick(mob/living/user)
	. = ..()
	/* //fortuna removal
	if(!bank_support || !alt_click_can_use_id(user))
		return

	if(!registered_account && bank_support == ID_FREE_BANK_ACCOUNT)
		set_new_account(user)
		return

	if (world.time < registered_account.withdrawDelay)
		registered_account.bank_card_talk(span_warning("ERROR: UNABLE TO LOGIN DUE TO SCHEDULED MAINTENANCE. MAINTENANCE IS SCHEDULED TO COMPLETE IN [(registered_account.withdrawDelay - world.time)/10] SECONDS."), TRUE)
		return

	var/amount_to_remove =  input(user, "How much do you want to withdraw? Current Balance: [registered_account.account_balance]", "Withdraw Funds", 5) as num|null

	if(!amount_to_remove || amount_to_remove < 0)
		return
	if(!alt_click_can_use_id(user))
		return
	amount_to_remove = FLOOR(min(amount_to_remove, registered_account.account_balance), 1)
	if(amount_to_remove && registered_account.adjust_money(-amount_to_remove))
		var/obj/item/holochip/holochip = new (user.drop_location(), amount_to_remove)
		user.put_in_hands(holochip)
		to_chat(user, span_notice("You withdraw [amount_to_remove] credits into a holochip."))
		return
	registered_account.bank_card_talk(span_warning("ERROR: The linked account has no sufficient credits to perform that withdrawal."), TRUE)
	*/
/obj/item/card/id/examine(mob/user)
	. = ..()
	if(mining_points)
		. += "There's [mining_points] mining equipment redemption point\s loaded onto this card."

/obj/item/card/id/GetAccess()
	return access

/obj/item/card/id/GetID()
	return src

/obj/item/card/id/RemoveID()
	return src

/obj/item/card/id/update_overlays()
	. = ..()
	if(!uses_overlays)
		return
	cached_flat_icon = null
	var/job = assignment ? ckey(GetJobName()) : null
	if(registered_name == "Captain")
		job = "captain"
	if(registered_name && registered_name != "Captain")
		. += mutable_appearance(icon, "assigned")
	if(job)
		. += mutable_appearance(icon, "id[job]")

/obj/item/card/id/proc/get_cached_flat_icon()
	if(!cached_flat_icon)
		cached_flat_icon = getFlatIcon(src)
	return cached_flat_icon


/obj/item/card/id/get_examine_string(mob/user, thats = FALSE)
	if(uses_overlays)
		return "[icon2html(get_cached_flat_icon(), user)] [thats? "That's ":""][get_examine_name(user)]" //displays all overlays in chat
	return ..()

/obj/item/card/id/proc/update_label(newname, newjob)
	if(newname || newjob)
		name = "[(!newname)	? "identification card"	: "[newname]'s ID Card"][(!newjob) ? "" : " ([newjob])"]"
		update_icon()
		return

	name = "[(!registered_name)	? "identification card"	: "[registered_name]'s ID Card"][(!assignment) ? "" : " ([assignment])"]"
	update_icon()

/obj/item/card/id/silver
	name = "silver identification card"
	desc = "A silver card which shows honour and dedication."
	icon_state = "silver"
	inhand_icon_state = "silver_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/id/silver/reaper
	name = "Thirteen's ID Card (Reaper)"
	access = list(ACCESS_MAINT_TUNNELS)
	icon_state = "reaper"
	assignment = "Reaper"
	registered_name = "Thirteen"

/obj/item/card/id/gold
	name = "gold identification card"
	desc = "A golden card which shows power and might."
	icon_state = "gold"
	inhand_icon_state = "gold_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/id/syndicate
	name = "agent card"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SYNDICATE)
	var/anyone = FALSE //Can anyone forge the ID or just syndicate?
	var/forged = FALSE //have we set a custom name and job assignment, or will we use what we're given when we chameleon change?

/obj/item/card/id/syndicate/Initialize()
	. = ..()
	var/datum/action/item_action/chameleon/change/chameleon_action = new(src)
	chameleon_action.chameleon_type = /obj/item/card/id
	chameleon_action.chameleon_name = "ID Card"
	chameleon_action.initialize_disguises()
	if(!anyone)
		AddComponent(/datum/component/identification/syndicate, ID_COMPONENT_DEL_ON_IDENTIFY, ID_COMPONENT_EFFECT_NO_ACTIONS, NONE)		//no deconstructive analyzer usage.

/obj/item/card/id/syndicate/afterattack(obj/item/O, mob/user, proximity)
	if(!proximity)
		return
	if(istype(O, /obj/item/card/id))
		var/obj/item/card/id/I = O
		src.access |= I.access
		if(isliving(user) && user.mind)
			if(user.mind.special_role || anyone)
				to_chat(usr, span_notice("The card's microscanners activate as you pass it over the ID, copying its access."))

/obj/item/card/id/syndicate/attack_self(mob/user)
	if(isliving(user) && user.mind)
		var/first_use = registered_name ? FALSE : TRUE
		if(!(user.mind.special_role || anyone)) //Unless anyone is allowed, only syndies can use the card, to stop metagaming.
			if(first_use) //If a non-syndie is the first to forge an unassigned agent ID, then anyone can forge it.
				anyone = TRUE
			else
				return ..()

		var/popup_input
		if(bank_support == ID_FREE_BANK_ACCOUNT)
			popup_input = alert(user, "Choose Action", "Agent ID", "Show", "Forge/Reset", "Change Account ID")
		else
			popup_input = alert(user, "Choose Action", "Agent ID", "Show", "Forge/Reset")
		if(!user.canUseTopic(src, BE_CLOSE, FALSE))
			return
		if(popup_input == "Forge/Reset" && !forged)
			var/input_name = stripped_input(user, "What name would you like to put on this card? Leave blank to randomise.", "Agent card name", registered_name ? registered_name : (ishuman(user) ? user.real_name : user.name), MAX_NAME_LEN)
			input_name = reject_bad_name(input_name)
			if(!input_name)
				// Invalid/blank names give a randomly generated one.
				if(user.gender == MALE)
					input_name = "[pick(GLOB.first_names_male)] [pick(GLOB.last_names)]"
				else if(user.gender == FEMALE)
					input_name = "[pick(GLOB.first_names_female)] [pick(GLOB.last_names)]"
				else
					input_name = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]"

			var/target_occupation = stripped_input(user, "What occupation would you like to put on this card?\nNote: This will not grant any access levels other than Maintenance.", "Agent card job assignment", assignment ? assignment : "Assistant", 60)
			if(!target_occupation)
				return
			registered_name = input_name
			assignment = target_occupation
			update_label()
			forged = TRUE
			to_chat(user, span_notice("You successfully forge the ID card."))
			log_game("[key_name(user)] has forged \the [initial(name)] with name \"[registered_name]\" and occupation \"[assignment]\".")

			// First time use automatically sets the account id to the user.
			if (first_use && !registered_account)
				if(ishuman(user))
					var/mob/living/carbon/human/accountowner = user

					for(var/bank_account in SSeconomy.bank_accounts)
						var/datum/bank_account/account = bank_account
						if(account.account_id == accountowner.account_id)
							account.bank_cards += src
							registered_account = account
							to_chat(user, span_notice("Your account number has been automatically assigned."))
			return
		else if (popup_input == "Forge/Reset" && forged)
			registered_name = initial(registered_name)
			assignment = initial(assignment)
			log_game("[key_name(user)] has reset \the [initial(name)] named \"[src]\" to default.")
			update_label()
			forged = FALSE
			to_chat(user, span_notice("You successfully reset the ID card."))
			return
		else if (popup_input == "Change Account ID")
			set_new_account(user)
			return
	return ..()

/obj/item/card/id/syndicate/anyone
	anyone = TRUE

/obj/item/card/id/syndicate/nuke_leader
	name = "lead agent card"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SYNDICATE, ACCESS_SYNDICATE_LEADER)

/obj/item/card/id/syndicate_command
	name = "syndicate ID card"
	desc = "An ID straight from the Syndicate."
	registered_name = "Syndicate"
	assignment = "Syndicate Overlord"
	access = list(ACCESS_SYNDICATE)

/obj/item/card/id/no_banking
	bank_support = ID_NO_BANK_ACCOUNT

/obj/item/card/id/locked_banking
	bank_support = ID_LOCKED_BANK_ACCOUNT

/obj/item/card/id/syndicate/locked_banking
	bank_support = ID_LOCKED_BANK_ACCOUNT

/obj/item/card/id/captains_spare
	name = "Mayor's ID"
	desc = "A special ID handed to anyone with status of Mayor."
	icon_state = "gold"
	inhand_icon_state = "gold_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	registered_name = "Zonq"
	assignment = "High Alderperson"
	access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_CLINIC, ACCESS_KITCHEN, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_FOLLOWER)

/obj/item/card/id/centcom
	name = "\improper CentCom ID"
	desc = "An ID straight from Central Command."
	icon_state = "centcom"
	registered_name = "Central Command"
	assignment = "General"

/obj/item/card/id/centcom/Initialize()
	access = get_all_centcom_access()
	. = ..()

/obj/item/card/id/ert
	name = "\improper CentCom ID"
	desc = "An ERT ID card."
	icon_state = "ert_commander"
	registered_name = "Emergency Response Team Commander"
	assignment = "Emergency Response Team Commander"

/obj/item/card/id/ert/Initialize()
	access = get_all_accesses()+get_ert_access("commander")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/Security
	icon_state = "ert_security"
	registered_name = "Security Response Officer"
	assignment = "Security Response Officer"

/obj/item/card/id/ert/Security/Initialize()
	access = get_all_accesses()+get_ert_access("sec")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/Engineer
	icon_state = "ert_engineer"
	registered_name = "Engineer Response Officer"
	assignment = "Engineer Response Officer"

/obj/item/card/id/ert/Engineer/Initialize()
	access = get_all_accesses()+get_ert_access("eng")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/Medical
	icon_state = "ert_medical"
	registered_name = "Medical Response Officer"
	assignment = "Medical Response Officer"

/obj/item/card/id/ert/Medical/Initialize()
	access = get_all_accesses()+get_ert_access("med")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/chaplain
	icon_state = "ert_chaplain"
	registered_name = "Religious Response Officer"
	assignment = "Religious Response Officer"

/obj/item/card/id/ert/chaplain/Initialize()
	access = get_all_accesses()+get_ert_access("sec")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/prisoner
	name = "prisoner ID card"
	desc = "You are a number, you are not a free man."
	icon_state = "orange"
	inhand_icon_state = "orange-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	assignment = "Prisoner"
	access = list(ACCESS_ENTER_GENPOP)

	//Lavaland labor camp
	var/goal = 0 //How far from freedom?
	var/points = 0
	//Genpop
	var/sentence = 0	//When world.time is greater than this number, the card will have its ACCESS_ENTER_GENPOP access replaced with ACCESS_LEAVE_GENPOP the next time it's checked, unless this value is 0/null
	var/crime= "\[REDACTED\]"

/obj/item/card/id/prisoner/GetAccess()
	if((sentence && world.time >= sentence) || (goal && points >= goal))
		access = list(ACCESS_LEAVE_GENPOP)
	return ..()

/obj/item/card/id/prisoner/process()
	if(!sentence)
		STOP_PROCESSING(SSobj, src)
		return
	if(world.time >= sentence)
		playsound(loc, 'sound/machines/ping.ogg', 50, 1)
		if(isliving(loc))
			to_chat(loc, "<span class='boldnotice'>[src]</span><span class='notice'> buzzes: You have served your sentence! You may now exit prison through the turnstiles and collect your belongings.</span>")
		STOP_PROCESSING(SSobj, src)
	return

/obj/item/card/id/prisoner/examine(mob/user)
	. = ..()
	if(sentence && world.time < sentence)
		. += span_notice("You're currently serving a sentence for [crime]. <b>[DisplayTimeText(sentence - world.time)]</b> left.")
	else if(goal)
		. += span_notice("You have accumulated [points] out of the [goal] points you need for freedom.")
	else if(!sentence)
		. += span_warning("You are currently serving a permanent sentence for [crime].")
	else
		. += span_notice("Your sentence is up! You're free!")

/obj/item/card/id/prisoner/one
	icon_state = "prisoner_001"
	name = "Prisoner #13-001"
	registered_name = "Prisoner #13-001"

/obj/item/card/id/prisoner/two
	icon_state = "prisoner_002"
	name = "Prisoner #13-002"
	registered_name = "Prisoner #13-002"

/obj/item/card/id/prisoner/three
	icon_state = "prisoner_003"
	name = "Prisoner #13-003"
	registered_name = "Prisoner #13-003"

/obj/item/card/id/prisoner/four
	icon_state = "prisoner_004"
	name = "Prisoner #13-004"
	registered_name = "Prisoner #13-004"

/obj/item/card/id/prisoner/five
	icon_state = "prisoner_005"
	name = "Prisoner #13-005"
	registered_name = "Prisoner #13-005"

/obj/item/card/id/prisoner/six
	icon_state = "prisoner_006"
	name = "Prisoner #13-006"
	registered_name = "Prisoner #13-006"

/obj/item/card/id/prisoner/seven
	icon_state = "prisoner_007"
	name = "Prisoner #13-007"
	registered_name = "Prisoner #13-007"

/obj/item/card/id/mining
	name = "mining ID"
	icon_state = "retro"
	access = list(ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM)

/obj/item/card/id/away
	name = "a perfectly generic identification card"
	desc = "A perfectly generic identification card. Looks like it could use some flavor."
	icon_state = "retro"
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/hotel
	name = "Staff ID"
	desc = "A staff ID used to access the hotel's doors."
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT)

/obj/item/card/id/away/hotel/securty
	name = "Officer ID"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_AWAY_SEC)

/obj/item/card/id/away/old
	name = "a perfectly generic identification card"
	desc = "A perfectly generic identification card. Looks like it could use some flavor."
	icon_state = "centcom"

/obj/item/card/id/away/old/sec
	name = "Charlie Station Security Officer's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Security Officer\"."
	assignment = "Charlie Station Security Officer"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_SEC)

/obj/item/card/id/away/old/sci
	name = "Charlie Station Scientist's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Scientist\"."
	assignment = "Charlie Station Scientist"
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/old/eng
	name = "Charlie Station Engineer's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Station Engineer\"."
	assignment = "Charlie Station Engineer"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_ENGINE)

/obj/item/card/id/away/old/apc
	name = "APC Access ID"
	desc = "A special ID card that allows access to APC terminals."
	access = list(ACCESS_ENGINE_EQUIP)

/obj/item/card/id/departmental_budget
	name = "departmental card (FUCK)"
	desc = "Provides access to the departmental budget."
	icon_state = "budgetcard"
	var/department_ID = ACCOUNT_CIV
	var/department_name = ACCOUNT_CIV_NAME

/obj/item/card/id/departmental_budget/Initialize()
	. = ..()
	var/datum/bank_account/B = SSeconomy.get_dep_account(department_ID)
	if(B)
		registered_account = B
		if(!B.bank_cards.Find(src))
			B.bank_cards += src
		name = "departmental card ([department_name])"
		desc = "Provides access to the [department_name]."
		icon_state = "[lowertext(department_ID)]_budget"
	SSeconomy.dep_cards += src

/obj/item/card/id/departmental_budget/Destroy()
	SSeconomy.dep_cards -= src
	return ..()

/obj/item/card/id/departmental_budget/update_label()
	return

/obj/item/card/id/departmental_budget/car
	department_ID = ACCOUNT_CAR
	department_name = ACCOUNT_CAR_NAME

//Polychromatic Knight Badge

/obj/item/card/id/knight
	name = "knight badge"
	icon_state = "knight"
	desc = "A badge denoting the owner as a knight! It has a strip for swiping like an ID"
	var/id_color = "#00FF00" //defaults to green
	var/mutable_appearance/id_overlay

/obj/item/card/id/knight/Initialize()
	. = ..()
	id_overlay = mutable_appearance(icon, "knight_overlay")
	update_icon()

/obj/item/card/id/knight/update_label(newname, newjob)
	if(newname || newjob)
		name = "[(!newname)	? "knight badge"	: "[newname]'s Knight Badge"][(!newjob) ? "" : " ([newjob])"]"
		return

	name = "[(!registered_name)	? "knight badge"	: "[registered_name]'s Knight Badge"][(!assignment) ? "" : " ([assignment])"]"

/obj/item/card/id/knight/update_overlays()
	. = ..()
	id_overlay.color = id_color
	. += id_overlay

/obj/item/card/id/knight/AltClick(mob/living/user)
	. = ..()
	if(!in_range(src, user))	//Basic checks to prevent abuse
		return
	if(user.incapacitated(allow_crit = TRUE) || !istype(user))
		to_chat(user, span_warning("You can't do that right now!"))
		return TRUE
	if(alert("Are you sure you want to recolor your id?", "Confirm Repaint", "Yes", "No") == "Yes")
		var/energy_color_input = input(usr,"","Choose Energy Color",id_color) as color|null
		if(!in_range(src, user) || !energy_color_input)
			return TRUE
		if(user.incapacitated(allow_crit = TRUE) || !istype(user))
			to_chat(user, span_warning("You can't do that right now!"))
			return TRUE
		id_color = sanitize_hexcolor(energy_color_input, desired_format=6, include_crunch=1)
		update_icon()
		return TRUE

/obj/item/card/id/knight/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to recolor it.")

/obj/item/card/id/knight/blue
	id_color = "#0000FF"

/obj/item/card/id/knight/captain
	id_color = "#FFD700"

/obj/item/card/id/debug
	name = "\improper Debug ID"
	desc = "A debug ID card. Has ALL the all access, you really shouldn't have this."
	icon_state = "ert_janitor"
	assignment = "Jannie"

/obj/item/card/id/debug/Initialize()
	access = get_all_accesses()+get_all_centcom_access()+get_all_syndicate_access()
	registered_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	. = ..()



////////Dogtag types/////////
//All one subtype for making item path pretty/easily telling what ID cards are dogtags, for gravemarkers

/obj/item/card/id/dogtag
	name = "holo dogtag"
	desc = "An advanced holographic dogtag, that shows the duty of a BoS member."
	icon_state = "holodogtag"
	assignment = "ID tags"
	uses_overlays = FALSE

/obj/item/card/id/dogtag/enclave
	desc = "An advanced holographic dogtag, that shows the duty of a BoS member. This one seems a bit off somewhow..."

/obj/item/card/id/dogtag/enclave/recruit
	access = list(ACCESS_ENCLAVE)

/obj/item/card/id/dogtag/enclave/recruit/attack_self(mob/user)
	if(isliving(user))
		var/mob/living/living_user = user
		if(alert(user, "Action", "Agent ID", "Show", "Forge") == "Forge")
			registered_name = living_user.real_name
			assignment = "Enclave Recruit"
			update_label()
			to_chat(user, span_notice("You successfully update your holotag."))
			return
	..()

/obj/item/card/id/selfassign/attack_self(mob/user)
	var/input_name = null
	var/target_occupation = null
	if(isliving(user))
		var/mob/living/living_user = user
		if(alert(user, "Action", "Reprogrammable ID", "Show", "Forge") == "Forge")
			input_name = stripped_input(user, "What name would you like to put on this card? Leave blank for your actual name.", "Reprogrammable ID", registered_name ? registered_name : (ishuman(user) ? user.real_name : user.name), MAX_NAME_LEN)
			input_name = reject_bad_name(input_name)
			if(!input_name)
				input_name = living_user.real_name
			target_occupation = stripped_input(user, "What occupation would you like to put on this card?", "Reprogrammable ID", assignment ? assignment : "Wastelander", 60)
			if(!target_occupation)
				target_occupation = "Wastelander"
				return
			registered_name = input_name
			assignment = target_occupation
			update_label()
			to_chat(user, span_notice("You successfully forge the ID card."))
			return
		else
	..()

/obj/item/card/id/selfassign
	icon_state = "silver"
	inhand_icon_state = "silver_id"
	desc = "A rewritable card that allows you to put your name and assignment on it."

/obj/item/card/id/selfassign/brotherenclave
	icon_state = "holodogtag"
	desc = "A rewritable card that allows you to put your name and assignment on it."

/obj/item/card/id/selfassign/brotherenclave/attack_self(mob/user)
	var/input_name = null
	var/target_occupation = null
	if(isliving(user))
		var/mob/living/living_user = user
		if(alert(user, "Action", "Reprogrammable ID", "Show", "Forge") == "Forge")
			input_name = stripped_input(user, "What name would you like to put on this card? Leave blank for your actual name.", "Reprogrammable ID", registered_name ? registered_name : (ishuman(user) ? user.real_name : user.name), MAX_NAME_LEN)
			input_name = reject_bad_name(input_name)
			if(!input_name)
				input_name = living_user.real_name
			target_occupation = stripped_input(user, "What occupation would you like to put on this card?", "Reprogrammable ID", assignment ? assignment : "Wastelander", 60)
			if(!target_occupation)
				target_occupation = "Wastelander"
				return
			registered_name = input_name
			assignment = target_occupation
			update_label()
			to_chat(user, span_notice("You successfully forge the ID card."))
			return
		else
	..()

/obj/item/card/id/dogtag/vigilante
	name = "vigilante's badge"
	desc = "An old silver badge."
	assignment = "Vigilante"
	icon_state = "deputy"
	inhand_icon_state = "badge-deputy"


/obj/item/card/id/dogtag/deputy
	name = "deputy's badge"
	desc = "A silver badge which shows honour and dedication."
	assignment = "Deputy"
	icon_state = "deputy"
	inhand_icon_state = "badge-deputy"
	access = list(ACCESS_BAR, ACCESS_GATEWAY)

/obj/item/card/id/dogtag/deputy/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/card/id/dogtag/sheriff))
		var/newname = stripped_input(user, "Who do you want to designate as your deputy?", , "", MAX_NAME_LEN)
		if(newname)
			to_chat(user, "You scribble the [registered_name] for the name on the badge.")
			registered_name = newname
			update_label()
	return ..()

/obj/item/card/id/dogtag/sheriff
	name = "sheriff's badge"
	desc = "A golden Sheriff's badge."
	assignment = "badge"
	icon_state = "sheriff"
	inhand_icon_state = "badge-sheriff"

/obj/item/card/id/dogtag/ranger
	name = "ranger's badge"
	desc = "A silver badge with special engravings to denote ranger status."
	assignment = "Deputy"
	icon_state = "deputy"
	inhand_icon_state = "badge-deputy"
	access = list(ACCESS_BAR, ACCESS_GATEWAY)

/obj/item/card/id/dogtag/town
	name = "citizenship permit"
	desc = "A permit identifying the holder as a citizen of a nearby town."
	icon_state = "doctor"
	inhand_icon_state = "card-doctor"
	assignment = "citizenship permit"
	access = list(ACCESS_BAR)

/obj/item/card/id/dogtag/vaultiecard
	name = "Vault Citizenship"
	desc = "Proof of citizenship to a vault."
	icon_state = "doctor"
	inhand_icon_state = "card-doctor"
	assignment = "citizenship permit"
	access = list(ACCESS_BAR)

/obj/item/card/id/dogtag/MDfakepermit
	name = "faded medical license"
	desc = "a revoked medical license. This is why we do not remove people's skeletons "
	access = list()

/obj/item/card/id/dogtag/town/ncr
	name = "NCR citizenship permit"
	desc = "A permit identifying the holder as a citizen of New Californian Republic."
	assignment = "NCR Citizen"
	access = list()

/obj/item/card/id/dogtag/town/legion
	name = "Larper Shitizen Snermit"
	desc = "A permit identifying the holder as a citizen of Caesar's Legion."
	assignment = "Legion Citizen"
	access = list()

/obj/item/card/id/dogtag/town/enclave
	name = "American citizenship permit"
	desc = "A permit identifying the holder as a citizen of United States of America."
	assignment = "American Citizen"
	access = list()

/obj/item/card/id/dogtag/town/mafia
	name = "citizenship permit"
	desc = "A permit identifying the holder as a citizen of a nearby town."
	icon_state = "doctor"
	inhand_icon_state = "card-doctor"
	assignment = "Settler"
	obj_flags = UNIQUE_RENAME
	access = list(ACCESS_BAR)

/obj/item/card/id/dogtag/town/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/card/id/silver/mayor))
		var/newname = stripped_input(user, "Who do you want to grant citizenship to?", , "", MAX_NAME_LEN)
		if(newname)
			to_chat(user, "You scribble the [registered_name] for the name on the permit.")
			registered_name = newname
			update_label()
	return ..()

/obj/item/card/id/dogtag/ncrambassador
	name = "ambassador's permit"
	desc = "An silver encrusted ambassador's permit in a plastic holder."
	icon_state = "silver"
	inhand_icon_state = "silver"
	assignment = "ambassador's permit"

/obj/item/card/id/dogtag/ncradmin
	name = "Administrators ID"
	desc = "An silver encrusted admins ID in a plastic holder."
	icon_state = "silver"
	inhand_icon_state = "silver"

/obj/item/card/id/dogtag/ncrtrooper
	name = "trooper's tags"
	desc = "A dog tag proving enlistment."
	icon_state = "ncrdogtagrecruit"

/obj/item/card/id/dogtag/ncrmp
	name = "military police tags"
	desc = "A dog tag that associates one with the NCROSI."
	icon_state = "ncrdogtagrecruit"

/obj/item/card/id/dogtag/ncrht
	name = "heavy trooper's tags"
	desc = "A dog tag proving the elite status of the heavy trooper."
	icon_state = "ncrdogtagrecruit"

/obj/item/card/id/dogtag/ncrsergeant
	name = "sergeant's tags"
	desc = "A chevron decorated dog tag showing NCO-ship."
	icon_state = "ncrdogtagsergeant"

/obj/item/card/id/dogtag/ncrrep
	name = "representative's tags"
	desc = "A special dog tag belonging to the NCR representative."
	icon_state = "ncrdogtagofficer"

/obj/item/card/id/dogtag/ncrlieutenant
	name = "lieutenant's tags"
	desc = "A silver bar dog tag that denotes a member of the NCR military with a lieutenant commission."
	icon_state = "ncrdogtagofficer"

/obj/item/card/id/dogtag/ncrcaptain
	name = "captain's tags"
	desc = "A dog tag that demands respect from all those subordinate to it. This one belongs to an NCR captain."
	icon_state = "ncrdogtagcaptain"

/obj/item/card/id/dogtag/ncrranger
	name = "ranger badge"
	desc = "A badge formed out of a Legion denarius that invokes fear in those who see it, belonging to someone with a big iron on their hip."
	icon_state = "ranger"

/obj/item/card/id/dogtag/ncrvetranger
	name = "veteran ranger badge"
	desc = "A badge formed out of a Legion aureus that is worn by the most feared men and women of the Republic."
	icon_state = "vetranger"

/obj/item/card/id/dogtag/ncrcolonel
	name = "colonel's tags"
	desc = "A dog tag that demands respect from all those subordinate to it. This one belongs to an NCR colonel."
	icon_state = "ncrdogtagcaptain"

/obj/item/card/id/dogtag/legforgemaster
	name = "forgemasters' medallion"
	desc = "A silver disc stamped with the Legion's Bull insignia. Belongs to the Forgemaster."
	icon_state = "legionmedallionrecruit"
	assignment = "forgmaster medallion"

/obj/item/card/id/dogtag/legslavemaster
	name = "slavemaster medallion"
	desc = "A marked silver disc stamped with the Legion's Bull insignia. Belongs to the dreaded Slavemaster."
	icon_state = "legionmedallionprime"
	assignment = "slavemaster medallion"

/obj/item/card/id/dogtag/legauxilia
	name = "auxilia medallion"
	desc = "A heavily marked silver disc stamped with the Legion's Bull insignia. Belongs to a respected auxilia of the Legion."
	icon_state = "legionmedallionveteran"
	inhand_icon_state = "card-id_leg"
	assignment = "auxilia medallion"

/obj/item/card/id/dogtag/legrecruit
	name = "recruit medallion"
	desc = "A silver disc stamped with the Legion's Bull insignia. Belongs to a recruit."
	icon_state = "legionmedallionrecruit"
	inhand_icon_state = "card-id_leg"
	assignment = "recruit medallion"

/obj/item/card/id/dogtag/legprime
	name = "prime medallion"
	desc = "A marked silver disc stamped with the Legion's Bull insignia. Belongs to a prime."
	icon_state = "legionmedallionprime"
	inhand_icon_state = "card-id_leg"
	assignment = "prime medallion"

/obj/item/card/id/dogtag/legimmune
	name = "immune medallion"
	desc = "A marked silver disc stamped with the Legion's Bull insignia. Worn by legionnaires on camp duty."
	icon_state = "legionmedallionprime"
	inhand_icon_state = "card-id_leg"
	assignment = "immune medallion"

/obj/item/card/id/dogtag/legveteran
	name = "veteran medallion"
	desc = "A heavily marked silver disc stamped with the Legion's Bull insignia. Belongs to a veteran, and reeks of iron."
	icon_state = "legionmedallionveteran"
	inhand_icon_state = "card-id_leg"
	assignment = "veteran medallion"

/obj/item/card/id/dogtag/legcenturion
	name = "centurion medallion"
	desc = "A golden disc awarded to the most fierce men in the whole legion. If you are close enough to read the insignia you won't be alive much longer."
	icon_state = "legionmedallioncent"
	inhand_icon_state = "card-id_leg2"
	assignment = "centurion medallion"

/obj/item/card/id/dogtag/legvenator
	name = "explorer medallion"
	desc = "A golden disc awarded to the elite hunters of the legion. If you are close enough to read the insignia you won't be alive much longer."
	icon_state = "legionmedallioncent"
	inhand_icon_state = "card-id_leg2"
	assignment = "Venator"


/obj/item/card/id/dogtag/legpriest
	name = "priestess medallion"
	desc = "A golden disc awarded to the trusted spiritual guide to the nearby Legion."
	icon_state = "legionmedallioncent"
	inhand_icon_state = "card-id_leg2"
	assignment = "priestess medallion"

/obj/item/card/id/dogtag/legorator
	name = "orator medallion"
	desc = "A golden disc awarded to the one who is a dedicated ambassador for Caesar's Legion."
	icon_state = "legionmedallioncent"
	inhand_icon_state = "card-id_leg2"
	assignment = "orator medallion"

//For PilotBland's frumentarii custom loadout
/obj/item/card/id/dogtag/legfrumentariiremus
	name = "Remus Amius' frumentarius medallion"
	desc = "A golden disc with a string threaded through the top, displaying official markings confirming a frumentarius' status."
	icon_state = "legionmedallioncent"
	inhand_icon_state = "card-id_leg2"
	assignment = "frumentarius medallion"

/obj/item/card/id/legionbrand
	name = "Legion's brand"
	desc = "A brand for identifying Caesar's Legion's slaves."
	icon_state = "legionbrand"
	inhand_icon_state = "slave"
	assignment = "Slave brand"
	uses_overlays = FALSE

/obj/item/card/id/legionbrand/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

///OUTLAW TAGS////

/obj/item/card/id/rusted
	name = "rusted tags"
	desc = "Decrepit uncared for dogtags, kept as a reminder to something."
	icon_state = "rustedncrtag"
	inhand_icon_state = "rustedncrtag"
	uses_overlays = FALSE

/obj/item/card/id/rusted/rustedmedallion
	name = "rusted medallion"
	desc = "A battered and unkempt medallion, kept as a reminder to something."
	icon_state = "rustedmedallion"
	inhand_icon_state = "rustedmedallion"
	uses_overlays = FALSE

/obj/item/card/id/rusted/fadedvaultid
	name = "faded id card"
	desc = "A and worn Vault-Tech issued ID card, broken beyond use, kept as a reminder to something."
	icon_state = "fadedvaultid"
	inhand_icon_state = "fadedvaultid"
	uses_overlays = FALSE

/obj/item/card/id/rusted/brokenholodog
	name = "broken holotag"
	desc = "A BoS issue holotag, it isnt working now though, kept as a reminder to something."
	icon_state = "brokenholodog"
	inhand_icon_state = "brokenholodog"
	uses_overlays = FALSE

/obj/item/card/id/rusted/brokenholodog/enclave
	name = "malfunctioning holotag"
	desc = "A would-be advanced holographic dogtag, if it was working. Kept as a reminder to something."

/obj/item/card/id/denid
	name = "Redwater Mark"
	desc = "A shady card for shady people. it might let you in to some of the bleaker parts of Nash's underground. Best not be seen with one of these. better yet, just avoid having it"
	assignment = "gang tattoo"

	access = list(ACCESS_DEN)

/obj/item/card/id/denid/truedark
	name = "Lytmon Labs"
	desc = "A Vault ID with the vault number replaced with \"Lytmon Labs\"."

/obj/item/card/id/khantattoo
	name = "Great Khan tattoo"
	desc = "A tattoo of the symbol of the Great Khans."
	icon = 'icons/fallout/clothing/khans.dmi'
	icon_state = "khan_id"
	inhand_icon_state = null
	assignment = "gang tattoo"
	uses_overlays = FALSE
	access = list(ACCESS_KHAN, ACCESS_BAR, ACCESS_GATEWAY, ACCESS_MINING)

/obj/item/card/id/khantattoo/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

/obj/item/card/id/khanleadertattoo
	name = "Great Khan leader tattoo"
	desc = "A tattoo of the symbol of the Great Khans."
	icon = 'icons/fallout/clothing/khans.dmi'
	icon_state = "khan_id"
	inhand_icon_state = null
	assignment = "gang tattoo"
	uses_overlays = FALSE
	access = list(ACCESS_KHAN, ACCESS_BAR, ACCESS_CLINIC, ACCESS_GATEWAY, ACCESS_MINT_VAULT, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLONING)

/obj/item/card/id/khanleadertattoo/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)


/obj/item/card/id/outcasttattoo
	name = "faded tribal tattoos"
	desc = "Tattoos marking the wearer as a tribal, worn and faded colors."
	icon_state = "skin"
	inhand_icon_state = "skin"
	assignment = "gang tattoo"
	uses_overlays = FALSE

/obj/item/card/id/outcasttattoo/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)

/* Tribal Tags
*/

/obj/item/card/id/tribetattoo
	name = "Tattoo of the machine spirits"
	desc = "A tattoo depicting the five machine spirits in harmony."
	icon_state = "tribalID"
	inhand_icon_state = "tribalID"
	assignment = "tribe tattoo"
	uses_overlays = FALSE

	access = list(ACCESS_TRIBE)

/obj/item/card/id/silver/mayor
	name = "Mayor's mayoral permit"
	desc = "A silver encrusted identification permit reserved for the Mayor of Oasis."
	icon_state = "silver"
	inhand_icon_state = "silver_id"
	assignment = "mayoral permit"
	uses_overlays = FALSE

/obj/item/card/id/dendoctor
	name = "doctor's name badge"
	desc = "A plastic-sealed name badge certifying the medical expertise of its holder."
	icon_state = "doctor"
	inhand_icon_state = "card-doctor"
	assignment = "name badge"
	uses_overlays = FALSE

/obj/item/card/id/chief
	name = "crimson identification card"
	desc = "A red card which shows dedication and leadership to the Vaults safety and security."
	icon_state = "chief"
	inhand_icon_state = "sec_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	uses_overlays = FALSE

/obj/item/card/id/sec
	name = "red identification card"
	desc = "A red card which shows dedication to the Security department."
	icon_state = "sec"
	inhand_icon_state = "sec_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	uses_overlays = FALSE

//ENCLAVE ID

/obj/item/card/id/dogtag/enclave/officer
	name = "US officer dogtags"
	desc = "Worn by Enclave officers."
	icon_state = "enclaveofficer"
	inhand_icon_state = "card-id_leg"
	assignment = "US dogtags"
	access = list(ACCESS_ENCLAVE)

/obj/item/card/id/dogtag/enclave/trooper
	name = "US dogtags"
	desc = "Worn by Enclave NCOs."
	icon_state = "enclavetrooper"
	inhand_icon_state = "card-id_leg"
	assignment = "US dogtags"
	access = list(ACCESS_ENCLAVE)

/obj/item/card/id/dogtag/enclave/noncombatant
	name = "US identity card"
	desc = "Issued to Enclave Non-Combat Personnel with a photograph and fingerprints."
	icon_state = "enclavenoncombat"
	inhand_icon_state = "card-id_leg"
	assignment = "US dogtags"
	access = list(ACCESS_ENCLAVE)

GLOBAL_LIST_INIT(fuzzy_license, list(
	"hug",
	"snuggle",
	"cuddle",
	"kiss",
	"hold hands",
	"num",
	"flop",
	"squeak",
	"weh",
	"cute",
	"love",
	"pat",
	"sex",
	"bottom",
	"decorate",
	"nerd",
	"dork",
	"gecker",
	"gekker",
	"Willow's butt",
	"feed Willow",
	"hoard Dennis",
	"spoil friends",
	"have this license",
	"administer plushies",
	"distribute cookies"
	))

/// Nerd reward for Fuzlet the nerd
/obj/item/card/fuzzy_license
	name = "license to hug"
	desc = "The most official license known to (and recognized exclusively by) shirtless foxes."
	icon_state = "retro"

/obj/item/card/fuzzy_license/attack_self(mob/user)
	if(Adjacent(user))
		user.visible_message(
			span_notice("[user] shows you: [icon2html(src, viewers(user))] [src.name]."),
			span_notice("You show \the [src.name]."))
		add_fingerprint(user)

/obj/item/card/fuzzy_license/attackby(obj/item/used, mob/living/user, params)
	if(istype(used, /obj/item/pen) || istype(used, /obj/item/toy/crayon))
		var/choice = input(user, "Select the license type", "License Type Selection") as null|anything in GLOB.fuzzy_license
		if(!isnull(choice))
			name = "license to [choice]"

//Bounty Cards//
/obj/item/card/lowbounty
	name = "Small Roller Bounty Ticket"
	color = "#00ff00"
	desc = "Turn this in at the bank's vending machine or the shop for fast coins!"
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	punchable = TRUE
	punched_state = "punchedticket"
	saleprice = COINS_TO_CREDITS(120)
	punchbonus = COINS_TO_CREDITS(40)
	this_is_easier_than_actually_removing_them = TRUE

/obj/item/card/midbounty
	name = "Medium Roller Bounty Ticket"
	color = "#0000ff"
	desc = "Turn this in at the bank's vending machine or the shop for fast coins!"
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	punchable = TRUE
	punched_state = "punchedticket"
	saleprice = COINS_TO_CREDITS(225)
	punchbonus = COINS_TO_CREDITS(56) // total of a lot
	this_is_easier_than_actually_removing_them = TRUE

/obj/item/card/highbounty
	name = "High Roller Bounty Ticket"
	color = "#ff0000"
	desc = "Turn this in at the bank's vending machine or the shop for fast coins!"
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	punchable = TRUE
	punched_state = "punchedticket"
	saleprice = COINS_TO_CREDITS(450)
	punchbonus = COINS_TO_CREDITS(75) // total of a lot
	this_is_easier_than_actually_removing_them = TRUE

/obj/item/card/kingbounty
	name = "King's Bounty Ticket"
	color = "#ffe600"
	desc = "At last, your just reward! Turn this in at the bank's vending machine or the shop for fast coins!"
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	punchable = TRUE
	punched_state = "punchedticket"
	saleprice = COINS_TO_CREDITS(900)
	punchbonus = COINS_TO_CREDITS(150) // total of a lot
	this_is_easier_than_actually_removing_them = TRUE
