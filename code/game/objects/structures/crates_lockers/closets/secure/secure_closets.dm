/obj/structure/closet/secure_closet
	name = "secure locker"
	desc = "It's a card-locked storage unit."
	locked = TRUE
	icon_state = "secure"
	max_integrity = 250
	armor = ARMOR_VALUE_LOCKER
	secure = TRUE

// Exists to work around the minimum 700 cr price for goodies / small items
/obj/structure/closet/secure_closet/goodies
	icon_state = "goodies"
	desc = "A sturdier card-locked storage unit used for bulky shipments."
	max_integrity = 500 // Same as crates.
