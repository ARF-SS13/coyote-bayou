// The fire effect!!

// Current concept:
// When created, give it an initial energy value.
// Based on energy provided, set the potency to a certain fraction of the energy.

// On tick, increase growth rate.

// potency is increased, fuel is increased, higher growth rate increases the potency and fuel consumption, capped at certain amount.

// If energy runs out, slowly decrease potency. Reuse growth rate and have it slowly decrease potency at first but then decrease at a
// higher rate the longer it goes without energy.

// Potency is the energy which increases the size and severity of the fire.

// If potency is over a certain level, take a chunk off of it's additional potency to create a new fire on an adjacent turf.
// New fire will have a bit of free energy provided for gameplay reasons

// Will check the turf for any flammable contents to add to the energy, add it to the energy var and call fire_act, will blacklist the item from adding fuel again.

// on_enter datum to trigger any atoms entering the object a fire_act proc.

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
