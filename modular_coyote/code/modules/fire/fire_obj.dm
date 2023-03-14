// The fire effect!!


/obj/effect/fire
	name "fire"
	desc "IT'S FIRE!!!"

	var/m_growthRate
	var/m_potency
	var/m_fuel

/obj/effect/fire/Initialize()
	. = ..()
	SSFire.AddFire(src)

/obj/effect/fire/Destroy()
	SSFire.RemoveFire(src)
	return ..()

/obj/effect/fire/HandleFire()
	if(potency <= 0)
		qdel(src)

/obj/effect/fire/HandleFuel(_currentGrowth)
/obj/effect/fire/HandlePotency()
