/obj/item/smithing
	name = "base class /obj/item/smithing"
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "unfinished"
	material_flags = MATERIAL_COLOR | MATERIAL_ADD_PREFIX
	var/quality = 0 //quality. Changed by the smithing process.
	var/obj/item/finishingitem = /obj/item/blacksmith/woodrod //What this item needs to be hit by to create finalitem
	var/obj/item/finalitem
	var/artifact = FALSE

/obj/item/ingot
	name = "ingot"
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "ingot"
	material_flags = MATERIAL_COLOR | MATERIAL_ADD_PREFIX
	var/workability = 0
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.75
	light_color = LIGHT_COLOR_FIRE
	light_on = FALSE

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

// Adapted to suit FO so it can be used.
/obj/item/ingot/adamantine
	custom_materials = list(/datum/material/adamantine=12000)
	name = "pre-war steel ingot"
	desc = "Top quality steel from the old world."
	material_flags = MATERIAL_COLOR

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


//////////////////////////
//						//
//  BLACKSMITH PARTS	//
//						//
//////////////////////////

// Root item code
/obj/item/blacksmith
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	max_integrity = 50
	w_class = WEIGHT_CLASS_SMALL

// Stick can be made by using a sharp tool on a piece of wood, less time wasted in crafting menu
/obj/item/blacksmith/woodrod
	name = "wooden rod"
	desc = "It's a rod, suitable for use of a handle of a tool. Also could serve as a weapon, in a pinch."
	icon_state = "woodrod"
	force = 7
	resistance_flags = FLAMMABLE

// Using leather strips on a wooden rod to make a sword handle
/obj/item/blacksmith/woodrod/attackby/(obj/item/W, mob/user, params)
	if (istype(W, /obj/item/stack/sheet/leatherstrips))
		user.visible_message("[user] begins finishing the [src] into a sword handle.", \
				"<span class='notice'>You begin wrapping the [src] with leather strips, and shaping the wood into a sword handle.</span>", \
				"<span class='italics'>You hear faint sounds of handcrafting.</span>")
		// 6 Second Timer
		if(!do_after(user, 60, TRUE, src))
			return
		// Make stick
		var/obj/item/blacksmith/swordhandle/new_item = new(user.loc)
		user.visible_message("[user] finishes making a sword handle from the [src].", \
				"<span class='notice'>You finish making a sword handle from the [src].</span>")
		qdel(src)
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


/obj/item/blacksmith/swordhandle
	name = "sword handle"
	desc = "It's a wooden handle with leather strips, making it comfortable to hold."
	icon_state = "swordhandle"
	resistance_flags = FLAMMABLE

/obj/item/blacksmith/chain
	name = "length of chain"
	desc = "It rattles and is pretty useless when not attached to stuff"
	icon_state = "chain"

//////////////////////
//					//
//  SMITHED TOOLS	//
//	METAL PARTS		//
//					//
//////////////////////

/obj/item/smithing/hammerhead
	name = "smithed hammer head"
	finalitem = /obj/item/melee/smith/hammer
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
	name = "smithed prospector's pick head"
	icon_state = "prospect_smith"
	finalitem = /obj/item/mining_scanner/prospector
	var/cooldown = null
	var/range = null


/obj/item/smithing/prospectingpickhead/startfinish()
	var/obj/item/mining_scanner/prospector/finalforreal = new /obj/item/mining_scanner/prospector(src)
	finalforreal.range = 2 + quality
	if(quality)
		finalforreal.cooldown = 100/quality
	finalforreal.force += quality
	finalitem = finalforreal
	..()


/obj/item/smithing/crowbar
	name = "unwrapped crowbar"
	desc = "Add leather strips."
	icon_state = "crowbar_smith"
	finishingitem = /obj/item/stack/sheet/leatherstrips
	finalitem = /obj/item/crowbar/smithed

/obj/item/smithing/crowbar/startfinish()
	var/obj/item/crowbar/smithed/finalforreal = new /obj/item/crowbar/smithed(src)
	finalforreal.force += quality
	if(quality > 0)
		finalforreal.toolspeed = max(0.05,(1-(quality/10)))
	else
		finalforreal.toolspeed *= max(1, (quality * -1))	
	finalitem = finalforreal
	..()

// Does not produce the expected result with force dependent on quality, instead just uses the base one. The finished item is a placeholder, it works though.
/obj/item/smithing/unitool
	name = "unwrapped universal tool"
	desc = "Add leather strips."
	icon_state = "unitool_smith"
	finishingitem = /obj/item/stack/sheet/leatherstrips
	finalitem = /obj/item/crowbar/smithedunitool

/obj/item/smithing/unitool/startfinish()
	var/obj/item/crowbar/smithedunitool/finalforreal = new /obj/item/crowbar/smithedunitool(src)
	finalforreal.force += quality
	finalitem = finalforreal
	..()


/obj/item/smithing/knifeblade
	name = "smithed knife blade"
	icon_state = "knife_smith"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/kitchen/knife

/obj/item/smithing/knifeblade/startfinish()
	var/obj/item/smithing/knifeblade/finalforreal = new /obj/item/smithing/knifeblade(src)
	finalitem = new /obj/item/kitchen/knife(src)
	finalforreal.force += quality*3
	finalitem = finalforreal
	finalitem.icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	finalitem.icon_state = "knife_smith"
	finalitem.name = "kitchen knife"
	finalitem.desc = "A handmade kitchen knife."
	var/mutable_appearance/overlay = mutable_appearance('icons/fallout/objects/crafting/blacksmith.dmi', "hilt_knife")
	overlay.appearance_flags = RESET_COLOR
	finalitem.add_overlay(overlay)
	if(finalitem.force < 0)
		finalitem.force = 0
	finalitem.material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	..()


//////////////////////
//					//
//  	BLING		//
//					//
//////////////////////

/obj/item/smithing/special
	mob_overlay_icon = 'icons/fallout/onmob/items/miscellaneous.dmi'
	gender = NEUTER
	w_class = WEIGHT_CLASS_SMALL

/obj/item/smithing/special/jewelry
	icon_state = "ring"
	item_state = "ring"
	strip_delay = 20
	equip_delay_other = 40
	var/strip_mod = 1 //how much they alter stripping items time by, higher is quicker
	var/strip_silence = TRUE
	var/mood_event_on_equip = /datum/mood_event/equipped_ring/gold

/obj/item/smithing/special/jewelry/ring
	name = "ring"
	slot_flags = ITEM_SLOT_GLOVES
	attack_verb = list("proposed")

/obj/item/smithing/special/jewelry/ring/equipped(mob/user, slot)
	. = ..()
	if (slot == SLOT_GLOVES && istype(user))
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "ringbuff", mood_event_on_equip)
	else
		SEND_SIGNAL(user, COMSIG_CLEAR_MOOD_EVENT, "ringbuff")

/obj/item/smithing/special/jewelry/ring/dropped(mob/user)
	. = ..()
	SEND_SIGNAL(user, COMSIG_CLEAR_MOOD_EVENT, "ringbuff")


/obj/item/clothing/shoes/ballandchain
	name = "ball and chain"
	desc = "An unpopular alternative to shoes."
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "ballandchain"
	mob_overlay_icon = 'icons/fallout/onmob/items/miscellaneous.dmi'
	item_state = "ballandchain"
	strip_delay = 300
	equip_delay_other = 50
	can_be_tied = FALSE
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 8
	material_flags = MATERIAL_COLOR | MATERIAL_ADD_PREFIX
	hitsound = 'sound/weapons/chainhit.ogg'
	var/quality = null

/obj/item/clothing/shoes/ballandchain/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(loc == user && user.get_item_by_slot(SLOT_SHOES))
		playsound(usr.loc, 'sound/weapons/chainhit.ogg', 75, 1)
		to_chat(user, "<span class='warning'>The ball and chain are too hard to remove by yourself! You'll need help taking this off!</span>")
		return
	return ..()

/obj/item/smithing/ballandchain
	name = "unchained ball"
	desc = "Finish by attaching a chain to it."
	icon_state = "ball"
	finishingitem = /obj/item/blacksmith/chain
	finalitem = /obj/item/clothing/shoes/ballandchain

/obj/item/smithing/ballandchain/startfinish()
	var/obj/item/smithing/ballandchain/finalforreal = new /obj/item/clothing/shoes/ballandchain(src)
	finalitem = new /obj/item/clothing/shoes/ballandchain(src)
	finalforreal.force += quality*2
	finalitem = finalforreal
	finalitem.icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	finalitem.icon_state = "ballandchain"
	finalitem.name = "ball and chain"
	finalitem.desc = "Makes the captive even more miserable."
	finalitem.material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	..()


///////////////
// NEW STUFF //
///////////////

/obj/item/smithing/swordblade
	name = "smithed swordblade"
	icon_state = "sword_smith"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/melee/smith/sword

/obj/item/smithing/swordblade/startfinish()
	finalitem = new /obj/item/melee/smith/sword(src)
	finalitem.force += quality*1.5
	..()

/obj/item/smithing/sabreblade
	name = "smithed sabre blade"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/melee/smith/sword/sabre
	icon_state = "sabre_smith"

/obj/item/smithing/sabreblade/startfinish()
	finalitem = new /obj/item/melee/smith/sword/sabre(src)
	finalitem.force += quality*1.5
	..()

/obj/item/smithing/spathablade
	name = "smithed spathablade"
	icon_state = "spatha_smith"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/melee/smith/sword/spatha

/obj/item/smithing/spathablade/startfinish()
	finalitem = new /obj/item/melee/smith/sword/spatha(src)
	finalitem.force += quality*1.5
	..()

/obj/item/smithing/spearhead
	name = "smithed spearhead"
	finalitem = /obj/item/melee/smith/twohand/spear
	icon_state = "spear_smith"

/obj/item/smithing/spearhead/startfinish()
	var/obj/item/melee/smith/twohand/spear/finalforreal = new /obj/item/melee/smith/twohand/spear(src)
	finalforreal.force += quality*1.5
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]2")
	finalforreal.throwforce = finalforreal.force/10
	finalitem = finalforreal
	..()


/obj/item/smithing/lancehead
	name = "smithed lancehead"
	finalitem = /obj/item/melee/smith/twohand/spear/lance
	icon_state = "lance_smith"

/obj/item/smithing/lancehead/startfinish()
	var/obj/item/melee/smith/twohand/spear/lance/finalforreal = new /obj/item/melee/smith/twohand/spear/lance(src)
	finalforreal.force += quality*1.5
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]2")
	finalforreal.throwforce = finalforreal.force/10
	finalitem = finalforreal
	..()

// Axe
/obj/item/smithing/axehead
	name = "smithed axehead"
	icon_state = "axe_smith"
	finalitem = /obj/item/melee/smith/twohand/axe

/obj/item/smithing/axehead/startfinish()
	var/obj/item/melee/smith/twohand/axe/finalforreal = new /obj/item/melee/smith/twohand/axe(src)
	finalforreal.force += quality*1.5
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]2")
	finalitem = finalforreal
	..()

/obj/item/smithing/scrapblade
	name = "smithed scrap blade"
	icon_state = "scrap_smith"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/melee/smith/twohand/axe/scrapblade

/obj/item/smithing/scrapblade/startfinish()
	var/obj/item/melee/smith/twohand/axe/scrapblade/finalforreal = new /obj/item/melee/smith/twohand/axe/scrapblade(src)
	finalforreal.force += quality*1.5
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]2")
	finalitem = finalforreal
	..()


/obj/item/smithing/daggerblade
	name = "smithed dagger blade"
	icon_state = "dagger_smith"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/melee/smith/dagger

/obj/item/smithing/daggerblade/startfinish()
	finalitem = new /obj/item/melee/smith/dagger(src)
	finalitem.force += quality*1.5
	finalitem.armour_penetration += quality*0.0375
	..()


/obj/item/smithing/macheteblade
	name = "smithed machete blade"
	icon_state = "machete_smith"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/melee/smith/machete

/obj/item/smithing/macheteblade/startfinish()
	finalitem = new /obj/item/melee/smith/machete(src)
	finalitem.force += quality*1.5
	..()


/obj/item/smithing/gladiusblade
	name = "smithed gladius blade"
	icon_state = "gladius_smith"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/melee/smith/machete/gladius

/obj/item/smithing/gladiusblade/startfinish()
	finalitem = new /obj/item/melee/smith/machete/gladius(src)
	finalitem.force += quality*1.5
	..()


/obj/item/smithing/macheterblade
	name = "reforged machete blade"
	icon_state = "macheter_smith"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/melee/smith/machete/reforged

/obj/item/smithing/macheterblade/startfinish()
	finalitem = new /obj/item/melee/smith/machete/reforged(src)
	finalitem.force += quality*1.5
	..()

/obj/item/smithing/macehead
	name = "smithed macehead"
	icon_state = "mace_smith"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/melee/smith/mace

/obj/item/smithing/macehead/startfinish()
	finalitem = new /obj/item/melee/smith/mace(src)
	finalitem.force += quality*1.5
	finalitem.armour_penetration += quality*0.05
	..()



/obj/item/smithing/wakiblade
	name = "smithed wakizashi blade"
	icon_state = "waki_smith"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/melee/smith/wakizashi

/obj/item/smithing/wakiblade/startfinish()
	finalitem = new /obj/item/melee/smith/wakizashi(src)
	finalitem.force += quality*1.5
	..()


/obj/item/smithing/katanablade
	name = "smithed katana blade"
	icon_state = "katana_smith"
	finishingitem = /obj/item/blacksmith/swordhandle
	finalitem = /obj/item/melee/smith/twohand/katana

/obj/item/smithing/katanablade/startfinish()
	var/obj/item/melee/smith/twohand/katana/finalforreal = new /obj/item/melee/smith/twohand/katana(src)
	finalforreal.force += quality*1.5
	finalforreal.wield_force = finalforreal.force*finalforreal.wielded_mult
	finalforreal.AddComponent(/datum/component/two_handed, force_unwielded=finalforreal.force, force_wielded=finalforreal.wield_force, icon_wielded="[icon_state]2")
	finalitem = finalforreal
	..()


/obj/item/smithing/javelinhead
	name = "smithed javelin head"
	icon_state = "javelin_smith"
	finalitem = /obj/item/melee/smith/javelin

/obj/item/smithing/javelinhead/startfinish()
	var/obj/item/melee/smith/javelin/finalforreal = new /obj/item/melee/smith/javelin(src)
	finalforreal.force += quality*1.5
	finalforreal.throwforce = finalforreal.force*1.5
	finalitem = finalforreal
	..()


/obj/item/smithing/throwingknife
	name = "unfinished throwing knife"
	desc = "Add leather strips."
	icon_state = "throwing_smith"
	finishingitem = /obj/item/stack/sheet/leatherstrips
	finalitem = /obj/item/melee/smith/throwingknife

/obj/item/smithing/throwingknife/startfinish()
	var/obj/item/melee/smith/throwingknife/finalforreal = new /obj/item/melee/smith/throwingknife(src)
	finalforreal.force += quality*1.4
	finalforreal.throwforce = finalforreal.force*1.4
	finalitem = finalforreal
	..()


