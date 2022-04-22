/obj/item/smithing
	name = "base class /obj/item/smithing"
	icon = 'icons/obj/smith.dmi'
	icon_state = "unfinished"
	material_flags = MATERIAL_COLOR | MATERIAL_ADD_PREFIX
	var/quality = 0 //quality. Changed by the smithing process.
	var/obj/item/finishingitem = /obj/item/stick //What this item needs to be hit by to create finalitem
	var/obj/item/finalitem
	var/artifact = FALSE

/obj/item/ingot
	name = "ingot"
	icon = 'icons/fallout/objects/blacksmith.dmi'
	icon_state = "ingot"
	material_flags = MATERIAL_COLOR | MATERIAL_ADD_PREFIX
	var/workability = 0


/obj/item/ingot/on_attack_hand(mob/user)
	var/mob/living/carbon/human/H
	if(workability != "shapeable")
		return ..()
	var/prot = 0
	if(ishuman(user))
		H = user
		if(H.gloves)
			var/obj/item/clothing/gloves/G = H.gloves
			if(G.max_heat_protection_temperature)
				prot = (G.max_heat_protection_temperature > 360)
		else
			prot = 0
	if(prot > 0 || HAS_TRAIT(user, TRAIT_RESISTHEAT) || HAS_TRAIT(user, TRAIT_RESISTHEATHANDS))
		to_chat(user, "<span class='notice'>You pick up the [src].</span>")
		return ..()
	else
		to_chat(user, "<span class='warning'>You try to move the [src], but you burn your hand on it!</span>")
	if(H)
		var/obj/item/bodypart/affecting = H.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
		if(affecting && affecting.receive_damage( 0, 5 ))		// 5 burn damage
			H.update_damage_overlays()
		var/list/hand_items = list(H.get_active_held_item(),H.get_inactive_held_item())
		if(src in hand_items)
			H.dropItemToGround(src)

/obj/item/ingot/iron
	custom_materials = list(/datum/material/iron=12000)

/obj/item/ingot/diamond
	custom_materials = list(/datum/material/diamond=12000) //yeah ok

/obj/item/ingot/uranium
	custom_materials = list(/datum/material/uranium=12000)

/obj/item/ingot/plasma
	custom_materials = list(/datum/material/plasma=12000)//yeah ok

/obj/item/ingot/gold
	custom_materials = list(/datum/material/gold=12000)

/obj/item/ingot/silver
	custom_materials = list(/datum/material/silver=12000)

/obj/item/ingot/titanium
	custom_materials = list(/datum/material/titanium=12000)

/obj/item/ingot/adamantine
	custom_materials = list(/datum/material/adamantine=12000)

/obj/item/ingot/cult
	custom_materials = list(/datum/material/runedmetal=12000)

/obj/item/ingot/bronze
	custom_materials = list(/datum/material/bronze=12000)

/obj/item/ingot/ratvar
	custom_materials = list(/datum/material/brass=12000)
	desc = "On closer inspection, what appears to be wholly-unsuitable-for-smithing brass is actually primarily replicant alloy. Nezbere must have switched it while you weren't looking."


/obj/item/smithing/attackby(obj/item/I, mob/user)
	if(istype(I, finishingitem))
		qdel(I)
		startfinish()
	else
		return ..()

/obj/item/smithing/proc/startfinish()
	dofinish()

/obj/item/smithing/proc/dofinish()
	var/qualname
	switch(quality)
		if(-1000 to -5)
			qualname = "awful"
		if(-1000 to -2)
			qualname = "shoddy"
		if(-1000 to -1)
			qualname =  "poor"
		if(-1 to 1)
			qualname = "normal"
		if(10 to INFINITY)
			qualname = "legendary"
		if(7.5 to 10)
			qualname = "masterwork"
		if(5.5 to 7.5)
			qualname = "excellent"
		if(3.5 to 5.5)
			qualname = "good"
		if(0 to 3.5)
			qualname = "above-average"
	var/datum/material/mat = custom_materials[1]
	finalitem.set_custom_materials(custom_materials)
	mat = mat.name
	if(artifact)
		dwarfyartifact(finalitem, mat)
	else
		finalitem.name = "[qualname] [mat] [initial(finalitem.name)]"
		finalitem.desc = "A [qualname] [initial(finalitem.name)]. Its quality is [quality]."
	finalitem.forceMove(get_turf(src))
	qdel(src)


/obj/item/smithing/proc/dwarfyartifact(obj/item/finalitem, mat)
	var/finaldesc = "A [initial(finalitem.name)] made of [mat], all craftsmanship is of the highest quality. It "
	switch(pick(1,2,3,4,5))
		if(1)
			finaldesc += "is encrusted with [pick("","synthetic ","multi-faceted ","magical ","sparkling ") + pick("rubies","emeralds","jade","opals","lapiz lazuli")]."
		if(2)
			finaldesc += "is laced with studs of [pick("gold","silver","aluminium","titanium")]."
		if(3)
			finaldesc += "is encircled with bands of [pick("durasteel","metallic hydrogen","ferritic-alloy","plasteel","duranium")]."
		if(4)
			finaldesc += "menaces with spikes of [pick("ytterbium","uranium","white pearl","black steel")]."
		if(5)
			finaldesc += "is encrusted with [pick("","synthetic ","multi-faceted ","magical ","sparkling ") + pick("rubies","emeralds","jade","opals","lapis lazuli")],laced with studs of [pick("gold","silver","aluminium","titanium")], encircled with bands of [pick("durasteel","metallic hydrogen","ferritic-alloy","plasteel","duranium")] and menaces with spikes of [pick("ytterbium","uranium","white pearl","black steel")]."
	finalitem.desc = finaldesc
	finalitem.name = pick("Delersibnir", "Nekolangrir", "Zanoreshik","Öntakrítin", "Nogzatan", "Vunomam", "Nazushagsaldôbar", "Sergeb", "Zafaldastot", "Vudnis", "Dostust", "Shotom", "Mugshith", "Angzak", "Oltud", "Deleratîs", "Nökornomal") //one of these is literally BLOOD POOL CREATE.iirc its Nazushagsaldôbar.


//////////////////////
//					//
//  	HANDLES		//
//					//
//////////////////////

// Stick can be made by using a sharp tool on a piece of wood, less time wasted in crafting menu
/obj/item/stick
	name = "wooden rod"
	desc = "It's a rod, suitable for use of a handle of a tool. Also could serve as a weapon, in a pinch."
	icon = 'icons/fallout/objects/blacksmith.dmi'
	icon_state = "stick"
	force = 7

// Using leather strips on a stick to make a weapon handle
/obj/item/stick/attackby/(obj/item/W, mob/user, params)
	if (istype(W, /obj/item/stack/sheet/leatherstrips))
		user.visible_message("[user] begins finishing the [src] into a handle.", \
				"<span class='notice'>You begin wrapping the [src] with leather strips, and shaping the wood into a handle.</span>", \
				"<span class='italics'>You hear faint sounds of handcrafting.</span>")
		// 6 Second Timer
		if(!do_after(user, 60, TRUE, src))
			return
		// Make stick
		var/obj/item/swordhandle/new_item = new(user.loc)
		user.visible_message("[user] finishes making a handle from the [src].", \
				"<span class='notice'>You finish making a weapon handle from the [src].</span>")
		// Prepare to Put xin Hands (if holding wood)
		var/obj/item/stack/sheet/leatherstrips/N = src
		var/replace = (user.get_inactive_held_item() == N)
		// Use up the strips
		N.use(1)
		// If stack depleted, put item in that hand (if it had one)
		if (!N && replace)
			user.put_in_hands(new_item)
	else
		. = ..()


/obj/item/swordhandle
	name = "weapon handle"
	desc = "It's a wooden handle with leather strips, making it comfortable to hold."
	icon = 'icons/fallout/objects/blacksmith.dmi'
	icon_state = "shorthilt"


//////////////////////
//					//
//  SMITHED TOOLS	//
//	METAL PARTS		//
//					//
//////////////////////

/obj/item/smithing/hammerhead
	name = "smithed hammer head"
	finalitem = /obj/item/melee/smith/hammer
	icon = 'icons/fallout/objects/blacksmith.dmi'
	icon_state = "hammer"

/obj/item/smithing/hammerhead/startfinish()
	var/obj/item/melee/smith/hammer/finalforreal = new /obj/item/melee/smith/hammer(src)
	finalforreal.force += quality/2
	finalforreal.qualitymod = quality/2
	finalitem = finalforreal
	..()

/obj/item/smithing/shovelhead
	name = "smithed shovel head"
	finalitem = /obj/item/shovel/smithed
	icon = 'icons/fallout/objects/blacksmith.dmi'
	icon_state = "shovel"

/obj/item/smithing/shovelhead/startfinish()
	finalitem = new /obj/item/shovel/smithed(src)
	finalitem.force += quality/2
	if(quality > 0)
		finalitem.toolspeed = max(0.05,(1-(quality/10)))
	else
		finalitem.toolspeed *= max(1, (quality * -1))
	..()

/obj/item/smithing/pickaxehead
	name = "smithed pickaxe head"
	finalitem = /obj/item/pickaxe/smithed
	icon = 'icons/fallout/objects/blacksmith.dmi'
	icon_state = "pickaxe"

/obj/item/smithing/pickaxehead/startfinish()
	var/obj/item/pickaxe/smithed/finalforreal = new /obj/item/pickaxe/smithed(src)
	finalforreal.force += quality/2
	if(quality > 0)
		finalforreal.toolspeed = max(0.05,(1-(quality/10)))
	else
		finalforreal.toolspeed *= max(1, (quality * -1))
	switch(quality)
		if(10 to INFINITY)
			finalforreal.digrange = 2
		if(5 to 9)
			finalforreal.digrange = 2
		if(3,4)
			finalforreal.digrange = 1
		else
			finalforreal.digrange = 1
	finalitem = finalforreal
	..()

/obj/item/smithing/prospectingpickhead
	name = "smithed prospector's pickaxe head"
	finalitem = /obj/item/mining_scanner/prospector
	icon = 'icons/fallout/objects/blacksmith.dmi'
	icon_state = "minipick"

/obj/item/smithing/prospectingpickhead/startfinish()
	var/obj/item/mining_scanner/prospector/finalforreal = new /obj/item/mining_scanner/prospector(src)
	finalforreal.range = 2 + quality
	if(quality)
		finalforreal.cooldown = 100/quality
	finalitem = finalforreal
	..()


//////////////////////
//					//
//  	BLING		//
//					//
//////////////////////

/obj/item/smithing/jewelry
	icon = 'icons/fallout/objects/blacksmith.dmi'
	icon_state = "ring"
	mob_overlay_icon = 'icons/fallout/onmob/items/misc_righthand.dmi'
	item_state = "ring"
	gender = NEUTER
	w_class = WEIGHT_CLASS_SMALL
	strip_delay = 20
	equip_delay_other = 40
	var/strip_mod = 1 //how much they alter stripping items time by, higher is quicker
	var/strip_silence = TRUE
	var/mood_event_on_equip = /datum/mood_event/equipped_ring/gold

/obj/item/smithing/jewelry/ring
	name = "ring"
	slot_flags = ITEM_SLOT_GLOVES
	attack_verb = list("proposed")

/obj/item/smithing/jewelry/ring/equipped(mob/user, slot)
	. = ..()
	if (slot == SLOT_GLOVES && istype(user))
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "ringbuff", mood_event_on_equip)
	else
		SEND_SIGNAL(user, COMSIG_CLEAR_MOOD_EVENT, "ringbuff")

/obj/item/smithing/jewelry/ring/dropped(mob/user)
	. = ..()
	SEND_SIGNAL(user, COMSIG_CLEAR_MOOD_EVENT, "ringbuff")



/obj/item/smithing/javelinhead
	name = "smithed javelin head"
	finalitem = /obj/item/melee/smith/twohand/javelin
	icon_state = "javelin"

/obj/item/smithing/javelinhead/startfinish()
	var/obj/item/melee/smith/twohand/javelin/finalforreal = new /obj/item/melee/smith/twohand/javelin(src)
	finalforreal.force += quality*2.5
	//finalforreal.armour_penetration += quality*0.0375
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]")
	finalforreal.throwforce = finalforreal.force*2
	finalitem = finalforreal
	..()

/obj/item/smithing/pikehead
	name = "smithed pike head"
	finalitem = /obj/item/melee/smith/twohand/pike
	icon_state = "pike"

/obj/item/smithing/pikehead/startfinish()
	var/obj/item/melee/smith/twohand/pike/finalforreal = new /obj/item/melee/smith/twohand/pike(src)
	finalforreal.force += quality*2.5
	//finalforreal.armour_penetration += quality*0.0375
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]")
	finalforreal.throwforce = finalforreal.force/10 //its a pike not a javelin
	finalitem = finalforreal
	..()




/obj/item/smithing/shortswordblade
	name = "smithed gladius blade"
	finishingitem = /obj/item/swordhandle
	finalitem = /obj/item/melee/smith/shortsword
	icon_state = "gladius"

/obj/item/smithing/shortswordblade/startfinish()
	finalitem = new /obj/item/melee/smith/shortsword(src)
	finalitem.force += quality*2.5
	//finalitem.armour_penetration += quality*0.0375
	..()

/obj/item/smithing/scimitarblade
	name = "smithed scimitar blade"
	finishingitem = /obj/item/swordhandle
	finalitem = /obj/item/melee/smith/shortsword/scimitar
	icon_state = "scimitar"

/obj/item/smithing/scimitarblade/startfinish()
	finalitem = new /obj/item/melee/smith/shortsword/scimitar(src)
	finalitem.force += quality*2.5
	//finalitem.armour_penetration += quality*0.0025
	..()

/obj/item/smithing/wakiblade
	name = "smithed wakizashi blade"
	finishingitem = /obj/item/swordhandle
	finalitem = /obj/item/melee/smith/wakizashi
	icon_state = "waki"

/obj/item/smithing/wakiblade/startfinish()
	finalitem = new /obj/item/melee/smith/wakizashi(src)
	finalitem.force += quality*2.5
	//finalitem.armour_penetration += quality*0.0375
	..()

/obj/item/smithing/sabreblade
	name = "smithed sabre blade"
	finishingitem = /obj/item/swordhandle
	finalitem = /obj/item/melee/smith/sabre
	icon_state = "sabre"

/obj/item/smithing/sabreblade/startfinish()
	finalitem = new /obj/item/melee/smith/sabre(src)
	finalitem.force += quality*2.5
	//finalitem.armour_penetration += quality*0.0375
	..()

/obj/item/smithing/rapierblade
	name = "smithed rapier blade"
	finishingitem = /obj/item/swordhandle
	finalitem = /obj/item/melee/smith/sabre/rapier
	icon_state = "rapier"

/obj/item/smithing/rapierblade/startfinish()
	finalitem = new /obj/item/melee/smith/sabre/rapier(src)
	finalitem.force += quality*2.5
	//finalitem.armour_penetration += quality*0.0375
	..()

/obj/item/smithing/knifeblade
	name = "smithed knife blade"
	finishingitem = /obj/item/swordhandle
	finalitem = /obj/item/kitchen/knife
	icon_state = "dagger"

/obj/item/smithing/knifeblade/startfinish()
	finalitem = new /obj/item/kitchen/knife(src)
	finalitem.force = 4 + quality/2
	finalitem.armour_penetration += quality*0.0375
	finalitem.icon = 'icons/obj/smith.dmi'
	finalitem.icon_state = "dagger"
	finalitem.name = "dagger"
	finalitem.desc = "A dagger."
	var/mutable_appearance/overlay = mutable_appearance('icons/obj/smith.dmi', "daggerhilt")
	overlay.appearance_flags = RESET_COLOR
	finalitem.add_overlay(overlay)
	if(finalitem.force < 0)
		finalitem.force = 0
	finalitem.material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	..()

/obj/item/smithing/broadblade
	name = "smithed broadsword blade"
	finishingitem = /obj/item/swordhandle
	finalitem = /obj/item/melee/smith/twohand/broadsword
	icon_state = "broadsword"

/obj/item/smithing/broadblade/startfinish()
	var/obj/item/melee/smith/twohand/broadsword/finalforreal = new /obj/item/melee/smith/twohand/broadsword(src)
	finalforreal.force += quality*2.5
	//finalforreal.armour_penetration += quality*0.0375
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]")
	finalitem = finalforreal
	..()

/obj/item/smithing/zweiblade
	name = "smithed zweihander blade"
	finishingitem = /obj/item/swordhandle
	finalitem = /obj/item/melee/smith/twohand/zweihander
	icon_state = "zwei"

/obj/item/smithing/zweiblade/startfinish()
	var/obj/item/melee/smith/twohand/zweihander/finalforreal = new /obj/item/melee/smith/twohand/zweihander(src)
	finalforreal.force += quality*2.5
	//finalforreal.armour_penetration += quality*0.0375
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]")
	finalitem = finalforreal
	..()

/obj/item/smithing/halberdhead
	name = "smithed halberd head"
	finalitem = /obj/item/melee/smith/twohand/halberd
	icon_state = "halberd"

/obj/item/smithing/halberdhead/startfinish()
	var/obj/item/melee/smith/twohand/halberd/finalforreal = new /obj/item/melee/smith/twohand/halberd(src)
	finalforreal.force += quality*2.5
	//finalforreal.armour_penetration += quality*0.025
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.throwforce = finalforreal.force/3
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]")
	finalitem = finalforreal
	..()

/obj/item/smithing/glaivehead
	name = "smithed glaive head"
	finalitem = /obj/item/melee/smith/twohand/glaive
	icon_state = "glaive"

/obj/item/smithing/glaivehead/startfinish()
	var/obj/item/melee/smith/twohand/glaive/finalforreal = new /obj/item/melee/smith/twohand/glaive(src)
	finalforreal.force += quality*2.5
	//finalforreal.armour_penetration += quality*0.0025
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.throwforce = finalforreal.force
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]")
	finalitem = finalforreal
	..()

/obj/item/smithing/katanablade
	name = "smithed katana blade"
	finishingitem = /obj/item/swordhandle
	finalitem = /obj/item/melee/smith/twohand/katana
	icon_state = "katana"


/obj/item/smithing/katanablade/startfinish()
	var/obj/item/melee/smith/twohand/katana/finalforreal = new /obj/item/melee/smith/twohand/katana(src)
	finalforreal.force += quality*2.5
	//finalforreal.armour_penetration += quality*0.0375
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]")
	finalitem = finalforreal
	..()
