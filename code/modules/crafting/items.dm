/obj/item/scrap/research
	name = "strange object"
	desc = "What mysteries could this hold?"
	icon = 'icons/obj/assemblies.dmi'

/obj/item/scrap/research/Initialize()
	. = ..()
	icon_state = pick("shock_kit","armor-igniter-analyzer","infra-igniter0","infra-igniter1","radio-multitool","prox-radio1","radio-radio","timer-multitool0","radio-igniter-tank")
	name = "[pick("broken","twisted","spun","improved","silly","regular","badly made")] [pick("device","object","toy","illegal tech","weapon")]"

/obj/item/metaldetector
	name = "metal detector"
	desc = "Detects burried salvage in a 5 tile radius."
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "metaldetect"

/obj/item/metaldetector/attack_self(mob/user)
	. = ..()
	var/turf/t = get_turf(src)
	salvage_scan_pulse(t, 5)

/obj/item/metaldetector/proc/salvage_scan_pulse(turf/T, range = world.view)
	var/list/salvage = list()
	for(var/turf/open/indestructible/ground/outside/desert/M in range(range, T))
		if(M.salvage)
			salvage += M
	if(LAZYLEN(salvage))
		for(var/turf/open/indestructible/ground/outside/desert/M in salvage)
			var/obj/effect/temp_visual/detector_overlay/oldC = locate(/obj/effect/temp_visual/detector_overlay) in M
			if(oldC)
				qdel(oldC)
			new /obj/effect/temp_visual/detector_overlay(M)

/obj/effect/temp_visual/detector_overlay
	plane = FULLSCREEN_PLANE
	layer = FLASH_LAYER
	icon = 'icons/effects/ore_visuals.dmi'
	icon_state = "scan"
	appearance_flags = 0 //to avoid having TILE_BOUND in the flags, so that the 480x480 icon states let you see it no matter where you are
	duration = 35
	pixel_x = -224
	pixel_y = -224

/obj/item/components
	name = "crafting items"
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "blueprint_empty"
	w_class = WEIGHT_CLASS_TINY

/obj/item/blueprint
	name = "crafting blueprint"
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "blueprint_empty"
	w_class = WEIGHT_CLASS_TINY

/obj/item/prefabs
	name = "crafting prefabs"
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "blueprint_empty"
	w_class = WEIGHT_CLASS_TINY

/obj/item/stack/prefabs
	name = "crafting prefabs"
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "blueprint_empty"
	w_class = WEIGHT_CLASS_TINY

//misc blueprints
/obj/item/blueprint/misc
	name = "weapon blueprint"
	desc = "A crafting blueprint for a weapon design."
	icon_state = "blueprint2"

/obj/item/blueprint/research
	name = "mysterious blueprint"
	desc = "... (grants 10k research points when destructively analyzed - the BoS or Vault might want this.)"
	icon_state = "blueprint2"

/obj/item/blueprint/misc/stim
	name = "Stimpack blueprint"
	desc = "Stimpacks"

/obj/item/blueprint/misc/superstims
	name = "Super Stimpack blueprint"
	desc = "Super stims"

//weapon blueprints
/obj/item/blueprint/weapon
	name = "weapon blueprint"
	desc = "A crafting blueprint for a weapon design."
	icon_state = "blueprint1"

//low tier
/*
/obj/item/blueprint/weapon/AEP7
	name = "AEP7 blueprint"

/obj/item/blueprint/weapon/trail_carbine
	name = "Trail Carbine blueprint"

/obj/item/blueprint/weapon/lever_action
	name = "Lever Action shotgun blueprint"

/obj/item/blueprint/weapon/kar98
	name = "Ancient rifle blueprint"

/obj/item/blueprint/weapon/kar98/limited
	name = "Damaged ancient rifle blueprint"

//mid tier
/obj/item/blueprint/weapon/thatgun
	name = ".223 pistol blueprint"

/obj/item/blueprint/weapon/thatgun/limited
	name = "Damaged .223 pistol blueprint"

/obj/item/blueprint/weapon/pps
	name = "Ancient SMG blueprint"

/obj/item/blueprint/weapon/pps/limited
	name = "Damaged ancient SMG blueprint"

/obj/item/blueprint/weapon/mg34
	name = "Ancient machine gun blueprint"

/obj/item/blueprint/weapon/mg34/limited
	name = "Damaged ancient machine gun blueprint"

/obj/item/blueprint/weapon/marksmanrifle
	name = "Marksman Rifle blueprint"

/obj/item/blueprint/weapon/marksmanrifle/limited
	name = "Damaged Marksman Rifle blueprint"

/obj/item/blueprint/weapon/plasmapistol
	name = "Plasma Pistol blueprint"

/obj/item/blueprint/weapon/plasmapistol/limited
	name = "Damaged Plasma Pistol blueprint"

/obj/item/blueprint/weapon/uzi
	name = "UZI blueprint"

/obj/item/blueprint/weapon/uzi/limited
	name = "Damaged UZI blueprint"

/obj/item/blueprint/weapon/smg10mm
	name = "10mm SMG blueprint"

/obj/item/blueprint/weapon/smg10mm/limited
	name = "Damaged 10mm SMG blueprint"

/obj/item/blueprint/weapon/brush
	name = "Brush Gun blueprint"

/obj/item/blueprint/weapon/brush/limited
	name = "Damaged Brush Gun blueprint"

/obj/item/blueprint/weapon/grease_gun
	name = "Grease Gun blueprint"

/obj/item/blueprint/weapon/grease_gun/limited
	name = "Damaged Grease Gun blueprint"

//high tier
/obj/item/blueprint/weapon/R82
	name = "R82 heavy service rifle blueprint"

/obj/item/blueprint/weapon/R82/limited
	name = "Damaged R82 heavy service rifle blueprint"

/obj/item/blueprint/weapon/deagle
	name = "Desert Eagle blueprint"

/obj/item/blueprint/weapon/deagle/limited
	name = "Damaged Desert Eagle blueprint"

/obj/item/blueprint/weapon/R91
	name = "R91 Assault rifle blueprint"

/obj/item/blueprint/weapon/R91/limited
	name = "Damaged R91 Assault rifle blueprint"

/obj/item/blueprint/weapon/sniper
	name = "Sniper Rifle blueprint"

/obj/item/blueprint/weapon/sniper/limited
	name = "Damaged Sniper Rifle blueprint"

/obj/item/blueprint/weapon/breacher
	name = "Breacher Shotgun blueprint"

/obj/item/blueprint/weapon/breacher/limited
	name = "Damaged Breacher Shotgun blueprint"

/obj/item/blueprint/weapon/lmg
	name = "LMG blueprint"

/obj/item/blueprint/weapon/lmg/limited
	name = "Damaged LMG blueprint"

//very high tier
/obj/item/blueprint/weapon/plasmarifle
	name = "Plasma Rifle blueprint"

/obj/item/blueprint/weapon/plasmarifle/limited
	name = "Damaged Plasma Rifle blueprint"

/obj/item/blueprint/weapon/AER9
	name = "AER9 blueprint"

/obj/item/blueprint/weapon/AER9/limited
	name = "Damaged AER9 blueprint"

/obj/item/blueprint/weapon/AM_rifle
	name = "AM Rifle blueprint"

/obj/item/blueprint/weapon/AM_rifle/limited
	name = "Damaged AM Rifle blueprint"

/obj/item/blueprint/weapon/city_killer
	name = "City Killer shotgun blueprint"

/obj/item/blueprint/weapon/city_killer/limited
	name = "Damaged City Killer shotgun blueprint"

/obj/item/blueprint/weapon/rangemaster
	name = "Colt Rangemaster blueprint"

/obj/item/blueprint/weapon/rangemaster/limited
	name = "Damaged Colt Rangemaster blueprint"

/obj/item/blueprint/weapon/bozar
	name = "Bozar blueprint"

/obj/item/blueprint/weapon/bozar/limited
	name = "Damaged bozar blueprint"
*/
//armor blueprints
/obj/item/blueprint/armor
	name = "armor blueprint"
	icon_state = "blueprint4"

/obj/item/blueprint/armor/combat
	name = "combat armor blueprint"

/obj/item/blueprint/armor/reinforced
	name = "reinforced armor blueprint"

/obj/item/advanced_crafting_components
	name = "crafting blueprint"
	icon = 'icons/fallout/objects/crafting.dmi'
	icon_state = "blueprint_empty"
	w_class = WEIGHT_CLASS_TINY

/obj/item/stack/prefabs/mWeaponParts
	name = "Metal Weapon Parts"
	desc = ""
	//icon_state = ""
	merge_type = /obj/item/stack/prefabs/mWeaponParts

/obj/item/stack/prefabs/wWeaponParts
	name = "Wooden Weapon Parts"
	desc = ""
	//icon_state = ""
	merge_type = /obj/item/stack/prefabs/wWeaponParts

/obj/item/stack/prefabs/pWeaponParts
	name = "Plastic Weapon Parts"
	desc = ""
	//icon_state = ""
	merge_type = /obj/item/stack/prefabs/pWeaponParts

/obj/item/stack/prefabs/psWeaponParts
	name = "Plasteel Weapon Parts"
	desc = ""
	//icon_state = ""
	merge_type = /obj/item/stack/prefabs/psWeaponParts

/obj/item/prefabs/complex/simpleWeaponFrame

	var/obj/item/prefabs/complex/action/simple/actionsimple
	var/obj/item/prefabs/complex/action/auto/actionauto

	var/obj/item/prefabs/complex/barrel/m556/m556barrel
	var/obj/item/prefabs/complex/barrel/mm10/mm10barrel
	var/obj/item/prefabs/complex/barrel/mm9/mm9barrel
	var/obj/item/prefabs/complex/barrel/m357/m357barrel
	var/obj/item/prefabs/complex/barrel/m44/m44barrel
	var/obj/item/prefabs/complex/barrel/m45/m45barrel
	var/obj/item/prefabs/complex/barrel/m762/m762barrel
	var/obj/item/prefabs/complex/barrel/m4570/m4570barrel

	var/obj/item/prefabs/complex/trigger/trigger

	var/obj/item/prefabs/complex/bolt/simple/boltsimple
	var/obj/item/prefabs/complex/bolt/high/boltadvanced

	var/obj/item/prefabs/complex/stock/mid/stockplastic
	var/obj/item/prefabs/complex/stock/low/stockwood

	var/obj/item/prefabs/complex/screw/screw

	var/obj/item/advanced_crafting_components/alloys/alloys
	var/obj/item/advanced_crafting_components/receiver/receiver
	var/obj/item/advanced_crafting_components/assembly/assembly
	name = "Simple Weapon Frame"
	desc = ""
	icon_state = "gunframe"

/obj/item/prefabs/complex/simpleWeaponFrame/attackby(obj/item/W, mob/user, params)//todo me more recipes
	if(istype(W, /obj/item/screwdriver))
		if(src.contents.len > 0)
			to_chat(usr,"You remove the [src.contents[1]] from the [src].")
			usr.transferItemToLoc(src.contents[1],usr.loc)
		else
			to_chat(usr,"The weapon frame does not contain anything.")
	if(istype(W, /obj/item/wrench))
		if(screw&&trigger&&boltsimple&&actionsimple&&mm10barrel)//10mm
			if(istype(src,/obj/item/prefabs/complex/simpleWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/pistol/n99
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltsimple&&actionsimple&&m357barrel)//357
			if(istype(src,/obj/item/prefabs/complex/simpleWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/revolver/colt357
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltsimple&&actionsimple&&m44barrel)//44
			if(istype(src,/obj/item/prefabs/complex/simpleWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/revolver/m29
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltsimple&&actionsimple&&m4570barrel)//hunting revolver
			if(istype(src,/obj/item/prefabs/complex/simpleWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/revolver/hunting
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltadvanced&&actionsimple&&m556barrel)//556 pistol
			if(istype(src,/obj/item/prefabs/complex/simpleWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/revolver/thatgun
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else
			to_chat(usr,"This isn't quite right...")
	if(istype(W, /obj/item/advanced_crafting_components/alloys))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		alloys = W
	if(istype(W, /obj/item/advanced_crafting_components/receiver))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		receiver = W
	if(istype(W, /obj/item/advanced_crafting_components/assembly))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		assembly = W
	if(istype(W, /obj/item/prefabs/complex/action/simple))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		actionsimple = W
	if(istype(W, /obj/item/prefabs/complex/action/auto))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		actionauto = W
	if(istype(W, /obj/item/prefabs/complex/trigger))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		trigger = W
	if(istype(W, /obj/item/prefabs/complex/barrel/m556))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		m556barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/mm9))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		mm9barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/mm10))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		mm10barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/m357))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		m357barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/m44))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		m44barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/m762))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		m762barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/m4570))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		m4570barrel = W
	if(istype(W, /obj/item/prefabs/complex/bolt/simple))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		boltsimple = W
	if(istype(W, /obj/item/prefabs/complex/bolt/high))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		boltadvanced = W
	if(istype(W, /obj/item/prefabs/complex/stock/mid))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		stockplastic = W
	if(istype(W, /obj/item/prefabs/complex/stock/low))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		stockwood = W
	if(istype(W, /obj/item/prefabs/complex/screw))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		screw = W

/obj/item/prefabs/complex/complexWeaponFrame//todo me more recipes

	var/obj/item/prefabs/complex/action/simple/actionsimple
	var/obj/item/prefabs/complex/action/auto/actionauto

	var/obj/item/prefabs/complex/barrel/m556/m556barrel
	var/obj/item/prefabs/complex/barrel/mm10/mm10barrel
	var/obj/item/prefabs/complex/barrel/m357/m357barrel
	var/obj/item/prefabs/complex/barrel/mm9/mm9barrel
	var/obj/item/prefabs/complex/barrel/m44/m44barrel
	var/obj/item/prefabs/complex/barrel/m45/m45barrel
	var/obj/item/prefabs/complex/barrel/m762/m762barrel
	var/obj/item/prefabs/complex/barrel/m4570/m4570barrel

	var/obj/item/prefabs/complex/trigger/trigger

	var/obj/item/prefabs/complex/bolt/simple/boltsimple
	var/obj/item/prefabs/complex/bolt/high/boltadvanced

	var/obj/item/prefabs/complex/stock/mid/stockplastic
	var/obj/item/prefabs/complex/stock/low/stockwood
	var/obj/item/prefabs/complex/screw/screw

	var/obj/item/advanced_crafting_components/alloys/alloys
	var/obj/item/advanced_crafting_components/receiver/receiver
	var/obj/item/advanced_crafting_components/assembly/assembly
	name = "Complex Weapon Frame"
	desc = ""
	icon_state = "gunframe"

/obj/item/prefabs/complex/complexWeaponFrame/attackby(obj/item/W, mob/user, params)//todo me more recipes
	if(istype(W, /obj/item/screwdriver))
		if(src.contents.len > 0)
			to_chat(usr,"You remove the [src.contents[1]] from the [src].")
			usr.transferItemToLoc(src.contents[1],usr.loc)
		else
			to_chat(usr,"The weapon frame does not contain anything.")
	if(istype(W, /obj/item/wrench))
		if(screw&&trigger&&boltsimple&&actionsimple&&m556barrel&&stockplastic)//service
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/service
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/mid))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/service/mid
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/high))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/service/high
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltsimple&&actionsimple&&m556barrel&&stockwood)//varmint
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/varmint
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltsimple&&actionsimple&&m44barrel&&stockwood)//trail carbine
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/shotgun/automatic/hunting/trail
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltsimple&&actionauto&&mm9barrel&&stockwood&&receiver)//pps
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/pps
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/mid))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/pps/mid
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/high))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/pps/high
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltsimple&&actionauto&&mm9barrel&&stockplastic&&receiver)//uzi
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/smg/mini_uzi
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/mid))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/smg/mini_uzi/mid
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/high))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/smg/mini_uzi/high
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltsimple&&actionauto&&mm10barrel&&stockplastic&&receiver)//10mmsmg
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/smg10mm
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/mid))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/smg10mm/mid
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/high))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/smg10mm/high
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltsimple&&actionauto&&m45barrel&&stockplastic&&receiver)//grease gun
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/greasegun
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/mid))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/greasegun/mid
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/high))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/greasegun/high
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltadvanced&&actionsimple&&m762barrel&&stockplastic&&receiver&&assembly)//rangemaster
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/rangemaster/scoped
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/mid))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/rangemaster/scoped/mid
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/high))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/rangemaster/scoped/high
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else if(screw&&trigger&&boltadvanced&&actionauto&&m556barrel&&stockplastic&&receiver&&assembly)//assault rifle
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/low))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/assault_rifle
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/mid))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/assault_rifle/mid
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
			if(istype(src,/obj/item/prefabs/complex/complexWeaponFrame/high))
				var/obj/item/B = new /obj/item/gun/ballistic/automatic/assault_rifle/high
				B.forceMove(usr.loc)
				to_chat(usr,"You make a [B]")
				qdel(src)
		else
			to_chat(usr,"This isn't quite right...")
	if(istype(W, /obj/item/advanced_crafting_components/alloys))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		alloys = W
	if(istype(W, /obj/item/advanced_crafting_components/receiver))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		receiver = W
	if(istype(W, /obj/item/advanced_crafting_components/assembly))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		assembly = W
	if(istype(W, /obj/item/prefabs/complex/action/simple))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		actionsimple = W
	if(istype(W, /obj/item/prefabs/complex/action/auto))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		actionauto = W
	if(istype(W, /obj/item/prefabs/complex/trigger))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		trigger = W
	if(istype(W, /obj/item/prefabs/complex/barrel/m556))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		m556barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/mm10))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		mm10barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/mm9))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		mm9barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/m357))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		m357barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/m44))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		m44barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/m762))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		m762barrel = W
	if(istype(W, /obj/item/prefabs/complex/barrel/m4570))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		m4570barrel = W
	if(istype(W, /obj/item/prefabs/complex/bolt/simple))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		boltsimple = W
	if(istype(W, /obj/item/prefabs/complex/bolt/high))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		boltadvanced = W
	if(istype(W, /obj/item/prefabs/complex/stock/mid))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		stockplastic = W
	if(istype(W, /obj/item/prefabs/complex/stock/low))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		stockwood = W
	if(istype(W, /obj/item/prefabs/complex/screw))
		usr.transferItemToLoc(W,src)
		to_chat(usr,"You install the [W] into the [src]")
		screw = W

/obj/item/prefabs/complex/simpleWeaponFrame/low
	name = "Simple Weapon Frame (crude)"
	desc = ""
	icon_state = "gunframe"

/obj/item/prefabs/complex/complexWeaponFrame/low
	name = "Complex Weapon Frame (crude)"
	desc = ""
	icon_state = "gunframe"

/obj/item/prefabs/complex/simpleWeaponFrame/mid
	name = "Simple Weapon Frame (fair)"
	desc = ""
	//icon_state = ""

/obj/item/prefabs/complex/complexWeaponFrame/mid
	name = "Complex Weapon Frame (fair)"
	desc = ""
	//icon_state = ""

/obj/item/prefabs/complex/simpleWeaponFrame/high
	name = "Simple Weapon Frame (masterwork)"
	desc = ""
	//icon_state = ""

/obj/item/prefabs/complex/complexWeaponFrame/high
	name = "Complex Weapon Frame (masterwork)"
	desc = ""
	//icon_state = ""

//moulds
/obj/item/prefabs/mould
	name = "Mould"
	desc = ""
	icon_state = "mould"

/obj/item/prefabs/mould/action/simple
	name = "Simple Action Mould"
	desc = ""

/obj/item/prefabs/mould/action/auto
	name = "Automatic Action Mould"
	desc = ""

/obj/item/prefabs/mould/barrel/shotgun
	name = "Shotgun Barrel Mould"
	desc = ""
/obj/item/prefabs/mould/barrel/m357
	name = ".357 Barrel Mould"
	desc = ""

/obj/item/prefabs/mould/barrel/mm10
	name = "10mm Barrel Mould"
	desc = ""

/obj/item/prefabs/mould/barrel/mm9
	name = "9mm Barrel Mould"
	desc = ""

/obj/item/prefabs/mould/barrel/m44
	name = ".44 Barrel Mould"
	desc = ""

/obj/item/prefabs/mould/barrel/m45
	name = ".45 Barrel Mould"
	desc = ""

/obj/item/prefabs/mould/barrel/m4570
	name = ".45-70 Barrel Mould"
	desc = ""

/obj/item/prefabs/mould/barrel/m556
	name = "556 Barrel Mould"
	desc = ""

/obj/item/prefabs/mould/barrel/m762
	name = "762 Barrel Mould"
	desc = ""

/obj/item/prefabs/mould/bolt/simple
	name = "Simple Bolt Mould"
	desc = ""

/obj/item/prefabs/mould/bolt/high
	name = "Advanced Bolt Mould"
	desc = ""

/obj/item/prefabs/mould/trigger
	name = "Trigger Mould"
	desc = ""

/obj/item/prefabs/mould/stock
	name = "Stock Mould"
	desc = ""

/obj/item/prefabs/mould/screw
	name = "Screw Mould"
	desc = ""

/obj/item/prefabs/mould/simpleWeaponFrame
	name = "Simple Weapon Frame Mould"
	desc = ""

/obj/item/prefabs/mould/complexWeaponFrame
	name = "Complex Weapon Frame Mould"
	desc = ""

//components
/obj/item/prefabs/complex/action/simple
	name = "Simple Action"
	desc = ""
	icon_state = "action"

/obj/item/prefabs/complex/action/auto
	name = "Automatic Action"
	desc = ""
	icon_state = "action"

/obj/item/prefabs/complex/barrel
	name = "Barrel"
	desc = ""
	icon_state = "barrel"

/obj/item/prefabs/complex/barrel/mm10
	name = "10mm Barrel"
	desc = ""
	icon_state = "barrel"

/obj/item/prefabs/complex/barrel/mm9
	name = "9mm Barrel"
	desc = ""
	icon_state = "barrel"

/obj/item/prefabs/complex/barrel/m357
	name = ".357 Barrel"
	desc = ""

/obj/item/prefabs/complex/barrel/m44
	name = ".44 Barrel"
	desc = ""

/obj/item/prefabs/complex/barrel/m45
	name = ".45 Barrel"
	desc = ""

/obj/item/prefabs/complex/barrel/m4570
	name = ".45-70 Barrel"
	desc = ""

/obj/item/prefabs/complex/barrel/m556
	name = "556 Barrel"
	desc = ""

/obj/item/prefabs/complex/barrel/m762
	name = "762 Barrel"
	desc = ""

/obj/item/prefabs/complex/bolt
	name = "Bolt"
	desc = ""
	icon_state = "bolt"

/obj/item/prefabs/complex/barrel/shotgun
	name = "Shotgun Barrel"
	desc = ""
	icon_state = "barrel"

/obj/item/prefabs/complex/bolt/simple
	name = "Simple Bolt"
	desc = ""
	icon_state = "bolt"

/obj/item/prefabs/complex/bolt/high
	name = "Advanced Bolt"
	desc = ""

/obj/item/prefabs/complex/trigger
	name = "Trigger"
	desc = ""
	icon_state = "trigger"

/obj/item/prefabs/complex/stock
	name = "Stock"
	desc = ""
	icon_state = "stockwood"

/obj/item/prefabs/complex/stock/low
	name = "Wooden Stock"
	desc = ""
	icon_state = "stockwood"

/obj/item/prefabs/complex/stock/mid
	name = "Plastic Stock"
	desc = ""
	icon_state = "stock"

/obj/item/prefabs/complex/screw
	name = "Screw"
	desc = ""
	icon_state = "screw"

//plasma
/obj/item/advanced_crafting_components/flux
	name = "Flux capacitator"
	desc = "An energy weapon part, a craftsman might want to have this."
	icon_state = "flux"

//lasers
/obj/item/advanced_crafting_components/lenses
	name = "Focused crystal lenses"
	desc = "An energy weapon part, a craftsman might want to have this."
	icon_state = "lenses"

//general energy
/obj/item/advanced_crafting_components/conductors
	name = "Superconductor coil"
	desc = "An energy weapon part, a craftsman might want to have this."
	icon_state = "conductor"

//general ballistics
/obj/item/advanced_crafting_components/receiver
	name = "Advanced modular receiver"
	desc = "A ballistic weapon part, a craftsman might want to have this."
	icon_state = "receiver"

//rifles
/obj/item/advanced_crafting_components/assembly
	name = "Pre-war weapon assembly"
	desc = "A ballistic weapon part, a craftsman might want to have this."
	icon_state = "weapon_parts_1"

//general
/obj/item/advanced_crafting_components/alloys
	name = "Superlight alloys"
	desc = "A general crafting part, a craftsman might want to have this."
	icon_state = "alloys"

/obj/item/attachments
	name = "attachment"
	icon = 'icons/fallout/objects/crafting.dmi'
	icon_state = "alloys"
	w_class = WEIGHT_CLASS_TINY

/obj/item/attachments/scope
	name = "weapon optics"
	desc = "A long-range scope, attach to a compatible weapon. Remove with a screwdriver. Makes the weapon slightly slower to fire."
	icon_state = "scope"

/obj/item/attachments/recoil_decrease
	name = "recoil compensator"
	desc = "Improves stability and recoil, attach to a compatible weapon. Cannot be removed."
	icon_state = "recoilcomp"

/obj/item/attachments/burst_improvement
	name = "burst cam"
	desc = "Increases burst size, attach to a compatible weapon. Cannot be removed."
	icon_state = "burstcam"

/obj/item/attachments/auto_sear
	name = "auto sear"
	desc = "A rare gun part that allows certain weapons to have select fire capabilities. Cannot be removed."
	icon_state = "auto_sear"

//salvage
/obj/item/salvage
	name = "salvage"
	icon = 'icons/fallout/objects/items.dmi'
	icon_state = "blueprint_empty"
	w_class = WEIGHT_CLASS_NORMAL
	var/list/Loot = list() //List of items

/obj/item/salvage/low
	name = "Pre-war salvage"
	desc = "Some pre-war salvage, it could contain some useful materials if dissasembled using a workbench..."
	icon_state = "salvage"
	Loot = list(/obj/item/stack/crafting/metalparts/five,
				/obj/item/stack/ore/blackpowder/two,
				/obj/item/stack/crafting/electronicparts/three,
				/obj/item/stack/sheet/lead/five,
				/obj/item/stack/sheet/metal/ten,
				/obj/item/stack/sheet/cloth/five,
				/obj/item/stack/sheet/leather/five,
				/obj/item/scrap/research,
				/obj/item/stock_parts/cell/ammo/ec,
				/obj/item/stack/crafting/goodparts
				)

/obj/item/salvage/crafting
	name = "salvaged components"
	desc = "Some salvaged components, it could contain some useful materials if dissasembled using a workbench..."
	icon_state = "salvagecomponents"
	Loot = list(/obj/item/crafting/diode,
				/obj/item/crafting/transistor,
				/obj/item/crafting/capacitor,
				/obj/item/crafting/fuse,
				/obj/item/crafting/resistor,
				/obj/item/crafting/switch_crafting,
				/obj/item/crafting/bulb,
				/obj/item/crafting/board,
				/obj/item/crafting/buzzer,
				/obj/item/crafting/frame,
				/obj/item/crafting/small_gear,
				/obj/item/crafting/large_gear,
				/obj/item/crafting/duct_tape,
				/obj/item/crafting/coffee_pot,
				/obj/item/crafting/wonderglue,
				/obj/item/crafting/turpentine,
				/obj/item/crafting/abraxo,
				/obj/item/crafting/igniter,
				/obj/item/crafting/timer,
				/obj/item/crafting/sensor,
				/obj/item/crafting/lunchbox)


/obj/item/salvage/high
	name = "Advanced pre-war salvage"
	desc = "Some advanced pre-war salvage, it could contain some useful materials if dissasembled using a workbench..."
	icon_state = "goodsalvage"
	Loot = list(/obj/item/blueprint/research,
				/obj/item/advanced_crafting_components/receiver,
				/obj/item/advanced_crafting_components/assembly,
				/obj/item/advanced_crafting_components/alloys,
				/obj/item/reagent_containers/hypospray/medipen/stimpak,
				/obj/item/weldingtool/advanced,
				/obj/item/stock_parts/cell/ammo/mfc,
				/obj/item/stock_parts/cell/ammo/ecp,
				/obj/item/megaphone)

/obj/item/experimental
	name = "Experimental component"
	desc = "What could this do..."
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "radio-multitool"

/obj/item/experimental/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/gun/ballistic/shotgun))
		to_chat(usr, "You can't improve [W.name]...")
		return
	if(istype(W, /obj/item/gun/ballistic))
		gun(W, user)
		return
	if(istype(W, /obj/item/gun/energy))
		egun(W, user)
		return
	if(istype(W, /obj/item/clothing/suit/armor/f13/power_armor))
		parmor(W, user)
		return
	if(istype(W, /obj/item/clothing/head/helmet/f13/power_armor))
		pahat(W, user)
		return
	if(istype(W, /obj/item/clothing/suit/armor))
		armor(W, user)
		return
	if(istype(W, /obj/item/clothing/head))
		hat(W, user)
		return
	
/obj/item
	var/tinkered = 0
	var/untinkerable = FALSE
	
/obj/item/experimental/proc/reroll(obj/item/W, mob/user)
	var/obj/item/item = W.type
	qdel(W)
	if(prob(70))
		new item(user.loc)
		return
	to_chat(user,"You destroy the item in the process.")

/obj/item/experimental/proc/gun(obj/item/W, mob/user)
	if(W.untinkerable == TRUE)
		to_chat(usr, "You can't improve [W.name]...")
		return
	var/obj/item/gun/ballistic/B = W 

	var/dmgmod = rand(-10,10)
	var/penmod = rand(-10,10)
	var/spdmod = rand(-10,10)
	var/overall = dmgmod+penmod-spdmod
	var/prefix

	if(HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		dmgmod += 4
		penmod += 4
		spdmod -= 4
		overall = dmgmod+penmod-spdmod

	if(B.tinkered > 0 && !HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		to_chat(usr, "You have already tinkered with this item.")
		return
	if(B.tinkered == 1)
		reroll(B,user)
		return
	if(B.tinkered > 1 && HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		to_chat(usr, "You have already tinkered with this item too much.")
		return

	switch(overall)
		if(-30 to -15)
			prefix = "Ruined "
		if(-15 to 0)
			prefix = "Inferior "
		if(0 to 15)
			prefix = "Improved "
		if(15 to 30)
			prefix = "Superior "
		if(30 to 100)
			prefix = "Legendary "
	
	B.extra_damage += (dmgmod/2) //edited from /1 
	B.extra_penetration += (penmod/120) //edited from /60
	B.fire_delay += (spdmod/10) //edited from/5
	B.name = prefix + B.name
	B.tinkered += 1
	B.desc += " Extra damage: [B.extra_damage]; Extra penetration: [B.extra_penetration]; Fire delay: [B.fire_delay]"

	to_chat(usr, "You tinker with the gun making [W.name]...")
	qdel(src)


/obj/item/experimental/proc/egun(obj/item/W, mob/user)
	var/obj/item/gun/energy/E = W

	var/dmgmod = rand(-10,10)
	var/penmod = rand(-10,10)
	var/spdmod = rand(-10,10)
	var/overall = dmgmod+penmod-spdmod
	var/prefix

	if(HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		dmgmod += 4
		penmod += 4
		spdmod -= 4
		overall = dmgmod+penmod-spdmod
	
	if(E.tinkered > 0 && !HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		to_chat(usr, "You have already tinkered with this item.")
		return
	if(E.tinkered == 1)
		reroll(E,user)
		return
	if(E.tinkered > 1 && HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		to_chat(usr, "You have already tinkered with this item too much.")
		return

	switch(overall)
		if(-30 to -15)
			prefix = "Ruined "
		if(-15 to 0)
			prefix = "Inferior "
		if(0 to 15)
			prefix = "Improved "
		if(15 to 30)
			prefix = "Superior "
		if(30 to 100)
			prefix = "Legendary "
	
	E.extra_damage += (dmgmod/2)
	E.extra_penetration += (penmod/120)
	E.fire_delay += (spdmod/10)
	//E.ammo_type[1].delay += spdmod
	E.name = prefix + E.name
	E.tinkered += 1
	E.desc += " Extra damage: [E.extra_damage]; Extra penetration: [E.extra_penetration]; Fire delay: [E.fire_delay]"

	to_chat(usr, "You tinker with the energy gun making [W.name]...")
	qdel(src)

/obj/item/experimental/proc/armor(obj/item/W, mob/user)
	var/obj/item/clothing/suit/armor/A = W

	var/tiermod = rand(-10,10)
	var/prefix
	var/overall = tiermod

	if(HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		tiermod += 4

	if(A.tinkered > 0 && !HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		to_chat(usr, "You have already tinkered with this item.")
		return
	if(A.tinkered == 1)
		reroll(A,user)
		return
	if(A.tinkered > 1 && HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		to_chat(usr, "You have already tinkered with this item too much.")
		return

	switch(overall)
		if(-10 to -5)
			prefix = "Ruined "
		if(-5 to 0)
			prefix = "Inferior "
		if(0 to 5)
			prefix = "Improved "
		if(5 to 10)
			prefix = "Superior "
		if(10 to 100)
			prefix = "Legendary "

	A.armor.linemelee += tiermod*2
	A.armor.linebullet += tiermod*2
	A.armor.linelaser += tiermod*2
	A.name = prefix + A.name
	A.tinkered += 1
	A.desc += " Armor: Melee: [A.armor.linemelee], Bullet: [A.armor.linebullet], Laser: [A.armor.linelaser]"

	to_chat(usr, "You tinker with the armor making [W.name]...")
	qdel(src)

/obj/item/experimental/proc/hat(obj/item/W, mob/user)
	var/obj/item/clothing/head/H = W

	var/tiermod = rand(-10,10)
	var/prefix
	var/overall = tiermod

	if(HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		tiermod += 4

	if(H.tinkered > 0 && !HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		to_chat(usr, "You have already tinkered with this item.")
		return
	if(H.tinkered == 1)
		reroll(H,user)
		return
	if(H.tinkered > 1 && HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		to_chat(usr, "You have already tinkered with this item too much.")
		return

	switch(overall)
		if(-10 to -5)
			prefix = "Ruined "
		if(-5 to 0)
			prefix = "Inferior "
		if(0 to 5)
			prefix = "Improved "
		if(5 to 10)
			prefix = "Superior "
		if(10 to 100)
			prefix = "Legendary "

	H.armor.linemelee += tiermod*2
	H.armor.linebullet += tiermod*2
	H.armor.linelaser += tiermod*2
	H.name = prefix + H.name
	H.tinkered += 1
	H.desc += " Armor: Melee: [H.armor.linemelee], Bullet: [H.armor.linebullet], Laser: [H.armor.linelaser]"

	to_chat(usr, "You tinker with the armor making [W.name]...")
	qdel(src)
			
/obj/item/experimental/proc/parmor(obj/item/W, mob/user)
	var/obj/item/clothing/suit/armor/f13/power_armor/A = W
	//chance to upgrade all t45b versions to salvaged t45b, chance to upgrade salvaged t45b to t45b (new sprotes, t8 armor with no slowdown)
	if(A.powered)
		to_chat(user,"You cannot improve this any further.")
		return
	if(prob(20))
		to_chat(user,"You manage to restore the Power Armor!")
		if(istype(A,/obj/item/clothing/suit/armor/f13/power_armor/raiderpa))
			new /obj/item/clothing/suit/armor/f13/power_armor/t45b/restored(user.loc)
			qdel(A)
			return
		if(istype(A,/obj/item/clothing/suit/armor/f13/power_armor/hotrod))
			new /obj/item/clothing/suit/armor/f13/power_armor/t45b/restored(user.loc)
			qdel(A)
			return
		if(istype(A, /obj/item/clothing/suit/armor/f13/power_armor/t45b))
			new /obj/item/clothing/suit/armor/f13/power_armor/t45b/restored(user.loc)
			qdel(A)
			return
	if(prob(10)&&!HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		qdel(A)
		to_chat(user,"You ruin the armor completely, destroying it in the process...")
	if(prob(5)&&HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		qdel(A)
		to_chat(user,"You ruin the armor completely, destroying it in the process...")
	qdel(src)

/obj/item/experimental/proc/pahat(obj/item/W, mob/user)
	var/obj/item/clothing/head/helmet/f13/power_armor/H = W
	if(H.powered)
		to_chat(user,"You cannot improve this any further.")
		return
	if(prob(20))
		to_chat(user,"You manage to restore the Power Armor helmet!")
		if(istype(H,/obj/item/clothing/head/helmet/f13/power_armor/raiderpa_helm))
			new /obj/item/clothing/head/helmet/f13/power_armor/t45b/restored(user.loc)
			qdel(H)
			return
		if(istype(H,/obj/item/clothing/head/helmet/f13/power_armor/hotrod))
			new /obj/item/clothing/head/helmet/f13/power_armor/t45b/restored(user.loc)
			qdel(H)
			return
		if(istype(H, /obj/item/clothing/head/helmet/f13/power_armor/t45b))
			new /obj/item/clothing/head/helmet/f13/power_armor/t45b/restored(user.loc)
			qdel(H)
			return
	if(prob(10)&&!HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		qdel(H)
		to_chat(user,"You ruin the helmet completely, destroying it in the process...")
	if(prob(5)&&HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		qdel(H)
		to_chat(user,"You ruin the helmet completely, destroying it in the process...")
	qdel(src)

/obj/item/invention
	name = "Invention"
	desc = "What could this be..."
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "radio-multitool"

/obj/item/invention/attack_self(mob/user)
	. = ..()
	makething(user)

/obj/item/invention/proc/makething(mob/user)
	qdel(src)

	var/obj/item/item

	var/list/vhigh = list(/obj/item/melee/powerfist, /obj/item/nullrod/claymore/chainsaw_sword)

	var/list/high = list(/obj/item/shishkebabpack, /obj/item/gun/energy/gammagun, /obj/item/clothing/suit/armor/f13/sulphitearmor,
	/obj/item/clothing/head/helmet/f13/sulphitehelm, /obj/item/melee/powerfist/moleminer, /obj/item/circuitboard/machine/chem_master, 
	/obj/item/circuitboard/machine/cell_charger)

	var/list/mid = list(/obj/item/twohanded/fireaxe/bmprsword, /obj/item/twohanded/sledgehammer, /obj/item/shield/riot/scrapshield,/obj/item/gun/ballistic/automatic/autopipe,
	/obj/item/gun/ballistic/shotgun/lasmusket, /obj/item/gun/ballistic/shotgun/plasmacaster, /obj/item/clothing/suit/armor/f13/metalarmor,
	/obj/item/clothing/head/helmet/f13/raider/eyebot, /obj/item/clothing/head/helmet/knight/f13/metal/reinforced)

	var/list/low = list(/obj/item/gun/ballistic/revolver/zipgun,/obj/item/gun/ballistic/revolver/pipe_rifle,/obj/item/fishingrod,/obj/item/grenade/iedcasing,
	/obj/item/clothing/suit/armor/f13/slam, /obj/item/clothing/suit/armor/f13/raider/raidermetal,/obj/item/clothing/head/helmet/f13/raidermetal,
	/obj/item/clothing/head/helmet/knight/f13/metal, /obj/item/melee/unarmed/punchdagger)

	if(prob(60)||prob(30)&&HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		item = pick(low)
		new item(user.loc)
	if(prob(30)||prob(15)&&HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		item = pick(mid)
		new item(user.loc)
	if(prob(9)||prob(4.5)&&HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		item = pick(high)
		new item(user.loc)
	if(prob(1)||prob(0.5)&&HAS_TRAIT(user,TRAIT_MASTER_GUNSMITH))
		item = pick(vhigh)
		new item(user.loc)

	//to_chat(usr, "You tinker and manage to create [item.name].") wat
