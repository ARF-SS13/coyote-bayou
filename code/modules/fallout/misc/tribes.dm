/datum/gang/tribe
	name = "tribe"
	color = "28D780" //Change this later
	boss_items = list() //Populate this later

/datum/gang/tribe/add_leader(mob/living/carbon/new_leader)
	leader = new_leader

	remove_verb(new_leader,/mob/living/proc/assume_tribe_leader)

	add_verb(new_leader,/mob/living/proc/invite_tribe)
	add_verb(new_leader,/mob/living/proc/remove_tribe)
	add_verb(new_leader,/mob/living/proc/transfer_tribe_leader)
	add_verb(new_leader,/mob/living/proc/set_tribe_welcome)
	if(!round_start)
		add_verb(new_leader,/mob/living/proc/set_tribe_color)
	to_chat(new_leader, "<span class='notice'>You have become a new leader of the [name]! You can now invite and remove members at will.</span>")

	var/obj/item/device/gangtool/gangtool = new(new_leader)
	gangtool.gang = new_leader.gang
	assigned_tool = gangtool

	var/list/slots = list (
		"backpack" = SLOT_IN_BACKPACK,
		"left pocket" = SLOT_L_STORE,
		"right pocket" = SLOT_R_STORE
	)

	var/where = new_leader.equip_in_one_of_slots(gangtool, slots, FALSE)
	if(!where)
		gangtool.forceMove(get_turf(new_leader))

	if(assigned_tool)
		var/obj/item/device/gangtool/tool = assigned_tool
		tool.name = "[initial(tool.name)] - [name]"

/datum/gang/tribe/remove_leader(mob/living/carbon/old_leader)
	leader = null
	remove_verb(old_leader,/mob/living/proc/invite_tribe)
	remove_verb(old_leader,/mob/living/proc/remove_tribe)
	remove_verb(old_leader,/mob/living/proc/transfer_tribe_leader)
	remove_verb(old_leader,/mob/living/proc/set_tribe_welcome)
	if(!round_start)
		remove_verb(old_leader,/mob/living/proc/set_tribe_color)
	add_verb(old_leader,/mob/living/proc/assume_tribe_leader)
	to_chat(old_leader, "<span class='warning'>You are no longer the leader of the [name]!</span>")

/datum/gang/tribe/add_member(mob/living/carbon/new_member)
	members |= new_member
	new_member.faction |= "[name]-gang"
	remove_verb(new_member,/mob/living/proc/create_tribe)

	add_verb(new_member,/mob/living/proc/leave_tribe)

	add_verb(new_member,/mob/living/proc/assume_tribe_leader)
	to_chat(new_member, "<span class='notice'>You are now a member of the [name]! Everyone can recognize your tribe.</span>")
	if(welcome_text)
		to_chat(new_member, "<span class='notice'>Welcome text: </span><span class='purple'>[welcome_text]</span>")

/datum/gang/tribe/remove_member(mob/living/carbon/member)
	members -= member
	member.gang = null
	member.faction -= "[name]-gang"
	add_verb(member,/mob/living/proc/create_tribe)
	remove_verb(member,/mob/living/proc/leave_tribe)
	remove_verb(member,/mob/living/proc/assume_tribe_leader)
	to_chat(member, "<span class='warning'>You are no longer a member of the [name]!</span>")

	if(!members.len && !round_start)
		GLOB.gang_names -= lowertext(name)
		GLOB.all_gangs -= src
		qdel(src)

/mob/living/proc/invite_tribe()
	set name = "Invite To Tribe"
	set desc = "Invite others to your tribe. Only independent wasters and tribals in view can be offered to join!"
	set category = "Tribe"

	var/list/possible_targets = list()
	for(var/mob/living/carbon/target in oview())
		if(target.stat || !target.mind || !target.client)
			continue
		if(target.gang == gang)
			continue
		if(!(target.social_faction in GLOB.allowed_gang_factions))
			continue
		if(target.gang)
			continue
		possible_targets += target

	if(!possible_targets.len)
		return

	var/mob/living/carbon/C
	C = input("Choose who to invite to your tribe!", "Tribe invitation") as null|mob in possible_targets
	if(!C)
		return

	var/datum/gang/tribe/G = gang
	if(alert(C, "[src] invites you to join the [G.name].", "Tribe invitation", "Yes", "No") == "No")
		visible_message(C, "<span class='warning'>[C.name] refused an offer to join the [G.name]!</span>")
		return
	else
		visible_message(C, "<span class='notice'>[C.name] accepted an offer to join the [G.name]!</span>")

	G.add_member(C)
	C.gang = G

/mob/living/proc/create_tribe()
	set name = "Create Tribe"
	set category = "Tribe"

	var/input = input(src, "Enter the name of your new tribe!", "Tribe name") as text|null
	if(!input)
		return
	input = copytext(sanitize(input), 1, 30)
	if(lowertext(input) in GLOB.gang_names)
		to_chat(src, "<span class='notice'>This tribe name is already taken!</span>")
		return
	GLOB.gang_names |= lowertext(input)

	var/datum/gang/tribe/G = new()
	G.name = input
	GLOB.all_gangs |= G
	gang = G
	to_chat(src, "<span class='notice'>You have created [G.name]!</span>")

	G.add_member(src)
	G.add_leader(src)

/mob/living/proc/leave_tribe()
	set name = "Leave Tribe"
	set category = "Tribe"

	var/datum/gang/tribe/G = gang
	if(!G)
		to_chat(src, "You are already not in any tribe!")
		return
	if(alert("Are you sure you want to leave [G.name]?", "Leave tribe", "Yes", "No") == "No")
		return

	if(G.leader == src)
		G.remove_leader(src)
	G.remove_member(src)

/mob/living/proc/assume_tribe_leader()
	set name = "Assume Leadership"
	set desc = "Become a new tribe leader if the old one is missing or dead."
	set category = "Tribe"

	var/datum/gang/tribe/G = gang
	if(G && G.leader)
		var/mob/living/L = G.leader
		if(L.stat != DEAD && L.client)
			to_chat(src, "<span class='warning'>Tribe leader is still alive and well!</span>")
			return
		else
			G.remove_leader(L)
			G.add_leader(src)
	else if(G)
		G.add_leader(src)

/mob/living/proc/transfer_tribe_leader()
	set name = "Transfer Leadership"
	set desc = "Transfer your leader position to a different tribe member in view."
	set category = "Tribe"

	var/list/possible_targets = list()
	for(var/mob/living/carbon/target in oview())
		if(target.stat || !target.mind || !target.client)
			continue
		if(target.gang != gang)
			continue
		possible_targets += target

	if(!possible_targets.len)
		return

	var/datum/gang/tribe/G = gang
	if(G && G.leader == src)
		var/mob/living/carbon/new_leader
		new_leader = input(src, "Choose a new tribe leader of the [G.name]!", "Transfer Tribe Leadership") as null|mob in possible_targets
		if(!new_leader || new_leader == src)
			return
		var/mob/living/H = new_leader
		to_chat(src, "<span class='notice'>You have transferred tribe leadership of the [G.name] to [H.real_name]!</span>")
		to_chat(H, "<span class='notice'>You have received tribe leadership of the [G.name] from [src.real_name]!</span>")
		G.remove_leader(src)
		G.add_leader(H)

/mob/living/proc/remove_tribe()
	set name = "Remove Member"
	set desc = "Remove an alive tribe member from the tribe in view."
	set category = "Tribe"

	var/list/possible_targets = list()
	for(var/mob/living/carbon/target in oview())
		if(target.gang != gang)
			continue
		if(target.stat == DEAD)
			continue
		possible_targets += target

	if(!possible_targets.len)
		return

	var/datum/gang/tribe/G = gang
	if(G && G.leader == src)
		var/mob/living/carbon/kicked_member
		kicked_member = input(src, "Choose a tribe member to remove from [G.name]!", "Tribe member removal") as null|mob in possible_targets
		if(!kicked_member || kicked_member == src)
			return

		var/mob/living/H = kicked_member
		to_chat(src, "<span class='notice'>You have removed [H.real_name] from the [G.name]!</span>")
		to_chat(H, "<span class='warning'>You have been kicked from the [G.name] by [src.real_name]!</span>")
		G.remove_member(H)

/mob/living/proc/set_tribe_welcome()
	set name = "Set Welcome Text"
	set desc = "Set a welcome text that will show to all new members of the tribe upon joining."
	set category = "Tribe"

	var/datum/gang/tribe/G = gang
	var/input = input(src, "Set a welcome text for a new tribe members!", "Welcome text", G.welcome_text) as text|null
	if(!input)
		return
	input = copytext(sanitize(input), 1, 300)
	G.welcome_text = input

	to_chat(src, "<span class='notice'>You have set a welcome text for a new tribe members!</span>")

/mob/living/proc/set_tribe_color()
	set name = "Choose Tribe Color"
	set desc = "Set a color of your tribe that will be visible on the tribe members upon examine."
	set category = "Tribe"

	var/datum/gang/tribe/G = gang
	var/picked_color = input(src, "", "Choose Color", color) as color|null
	if(!picked_color)
		return
	G.color = sanitize_color(picked_color)

	to_chat(src, "<span class='notice'>You have chosen a new tribe color!</span>")
