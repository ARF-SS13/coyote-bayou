/*********************************
	SINGLE USE ICON CHANGER ITEMS
*********************************/
//god help me i dont know what the fuck i am doing - Vide Noir/CrimsonQuiver
//This can be used to have one or more uses to completely reskin a weapon using an item which will destroy itself once used up.

/datum/component/iconmodkit
	var/requireditem = null
	//for weapons and other icon switching things you most likely need to change type, i dont know any other way to get around that.
	var/iconpathtoapply = null
	var/iconstatetoapply = null
	var/numuses = 1
	var/desctoapply = null
	var/nametoapply = null

	//since i got a major skill issue, using this var will just delete the old item and replace it with another.
	//This is for things like weapons which just switch their icons and end up going back to their original state... Fix if you got brains.
	var/typetochangeto = null

//wowza the click to work thing
/datum/component/iconmodkit/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_OBJ_NOHIT,PROC_REF(try_apply))

/datum/component/iconmodkit/proc/try_apply(datum/source, atom/movable/target, mob/living/user)
	apply(target, user)

//the applying begins
/datum/component/iconmodkit/proc/apply(obj/item/A, mob/living/user)
	if(A.type == requireditem)
		if(user)
			if(typetochangeto)
				user.visible_message(span_bolddanger("This action will reset your item, remove all attachments etc or they will be lost."))
			user.visible_message(span_notice("[user] starts applying [parent] to [A]"), span_notice("You start applying \the [parent] to \the [A]"))
			var/obj/item/I = parent
			if(!I.use_tool(user = user, target =  A, delay = WORKTIME_FAST))
				return FALSE
			to_chat(user, span_notice("You have successfully installed \the [parent] in \the [A]"))
			if(typetochangeto)
				new typetochangeto(user.loc)
				user.dropItemToGround(A)
				qdel(A)
			else
				if(iconpathtoapply)
					A.icon = iconpathtoapply
				if(iconstatetoapply)
					A.icon_state = iconstatetoapply
				if(nametoapply)
					A.name = nametoapply
				if(desctoapply)
					A.desc = desctoapply
			numuses -= 1
		if(!numuses)
			to_chat(user, span_notice("Your [parent] is useless now."))
			user.dropItemToGround(parent)
			qdel(parent)
	else
		user.visible_message(span_notice("That is not a compatible item."))
	return TRUE

//an item so it can be held in hand and its not just metaphorical shit
/obj/item/iconmodkit
	name = "A generic single use appearance modkit"
	desc = "Ohgodohfuck you should not be seeing this"
	icon = 'icons/obj/modkits.dmi'
	icon_state = "blankmodkit"
	force = 0
	w_class = WEIGHT_CLASS_SMALL

//putting this item i make with this here to work as an example how to make items with this

/obj/item/iconmodkit/p577
	name = "P-577 Pistol Modkit"
	desc = "This can be applied to change appearance of a p577 pistol"
	icon = 'icons/obj/modkits.dmi'
	icon_state = "p577modkit"

/obj/item/iconmodkit/p577/New()
	..()
	var/datum/component/iconmodkit/I = AddComponent(/datum/component/iconmodkit)
	I.requireditem = /obj/item/gun/ballistic/automatic/pistol/p500/p577
	I.typetochangeto = /obj/item/gun/ballistic/automatic/pistol/p500/p577/crimsondeath
	I.numuses = 1
