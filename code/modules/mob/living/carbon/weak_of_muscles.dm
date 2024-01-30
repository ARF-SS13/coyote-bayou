//-->Weak of Muscles trait and its cursed mechanics
//Coder: Leonzrygin - if broken feel free to yell at me
//<--

/obj/item/equipped(mob/living/user)
	. = ..()
	if(w_class > WEIGHT_CLASS_NORMAL)
		if(!istype(src, /obj/item/defibrillator))  //this is a core item, we cannot remove the ability for players to reanimate others
			user.dropItemToGround(src, TRUE)
			to_chat(user, span_alert("The [src] is too heavy for you!"))
