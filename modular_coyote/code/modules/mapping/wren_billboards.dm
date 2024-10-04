/obj/structure/billboard/hubris1
    name = "Hubris billboard"
    desc = "These types of advertisements used to be popular."
    icon_state = "hubris1"

/obj/structure/billboard/hubris2
    name = "Hubris billboard"
    desc = "These types of advertisements used to be popular.This one appears to be vandalized"
    icon_state = "hubris2"

/obj/structure/billboard/robco
    name = "Robco billboard"
    desc = "An advertisement for RobCo Industries."
    icon_state = "robco1"

/obj/structure/billboard/poseidenenergy1
    name = "Poseiden energy billboard"
    desc = "An advertisement for Poseiden Energy."
    icon_state = "poseiden1"

/obj/structure/billboard/poseidenenergy2
    name = "Poseiden energy billboard"
    desc = "An advertisement for Poseiden Energy.This one appears to be vandalized"
    icon_state = "poseiden2"

/obj/structure/billboard/poseidenenergy3
    name = "Poseiden energy billboard"
    desc = "An advertisement for Poseiden Energy.This one appears to be vandalized"
    icon_state = "poseiden3"

/obj/structure/billboard/sunset
    name = "Sunset sasaparilla billboard"
    desc = "An advertisement for Sunset Sasaparilla."
    icon_state = "sunset1"

/obj/structure/billboard/generalatomics1
    name = "General atomics billboard"
    desc = "An advertisement for RobCo Industries."
    icon_state = "generalatomics1"

/obj/structure/billboard/generalatomics2
    name = "General atomics billboard"
    desc = "An advertisement for RobCo Industries. This one appears to be vandalized"
    icon_state = "generalatomics2"

/obj/structure/billboard/radiationking
    name = "Radiation king billboard"
    desc = "An advertisement for Radiation King."
    icon_state = "radiationking1"

/obj/structure/billboard/nukagirl
    name = "Cosmic cola billboard"
    desc = "An advertisement for Cosmic Cola, featuring Cosmic Girl."
    icon_state = "nukagirl1"

/obj/structure/billboard/nukagirl2
    name = "Cosmic cola billboard"
    desc = "An advertisement for Cosmic Cola, featuring Cosmc Girl.This one has been worn down by the wasteland"
    icon_state = "nukagirl2"

/obj/structure/billboard/redrocket1
    name = "Red rocket billboard"
    desc = "An advertisement for Red Rocket Fuel Station"
    icon_state = "redrocket1"

/obj/structure/billboard/redrocket2
    name = "Red rocket billboard"
    desc = "An advertisement for Red Rocket Fuel Station. It looks like this one has been tagged by the Khans, and is very worn down."
    icon_state = "redrocket2"

/obj/structure/billboard/superduper1
    name = "Super duper billboard"
    desc = "An advertisement for Super Duper Mart."
    icon_state = "superduper1"

/obj/structure/billboard/superduper2
    name = "Super duper billboard"
    desc = "An advertisement for Super Duper Mart. This one has been vandalized and worn down by the wasteland"
    icon_state = "superduper2"

/obj/structure/billboard/random/New()
	..()
	icon_state = pick("hubris1","hubris2","nukagirl1", "nukagirl2", "radiationking1", "redrocket1","redrocket2", "superduper1", "superduper2", "generalatomics1", "generalatomics2", "cola1", "cola2", "cola3", "cola4", "ritas1", "ritas2", "ritas3", "ritas4", "roboco1", "sunset1", "poseiden1", "poseiden2", "poseiden3" )

/obj/structure/billboard/powerlines1
	name = "Broken powerlines"
	desc = "Old broken powerlines, all that remains of the prefall powergrid."
	icon_state = "stolb1"
	density = 0

/obj/structure/billboard/powerlines2
	name = "Broken powerlines"
	desc = "Old broken powerlines, all that remains of the prefall powergrid."
	icon_state ="stolb2"
	density = 0

/obj/structure/billboard/boardedwell
    name = "Boarded up well"
    desc = "An old dryed up well that has been boarded up."
    icon_state = "well"
