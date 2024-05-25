//-->Weak of Muscles trait and its cursed mechanics
//Coder: Leonzrygin - if broken feel free to yell at me
//<--

/obj/item/equipped(mob/living/user)
	..()
	if(HAS_TRAIT(user, TRAIT_WEAK_OF_MUSCLES))  //we obviously need to check if the user HAS the trait.... DUH! (thank you a lot Blue and Dan)
		if(w_class > WEIGHT_CLASS_NORMAL)
			if( !istype(src, /obj/item/defibrillator/) && \
				!istype(src, /obj/item/storage/))
				user.dropItemToGround(src, TRUE)
				to_chat(user, span_alert("The [src] is too heavy for you!"))
