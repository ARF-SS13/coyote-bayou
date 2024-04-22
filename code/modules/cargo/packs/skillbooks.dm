//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.
//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Miscellaneous ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/skillbooks
	group = "Literature"

//////////////////////////////////////////////////////////////////////////////
///////////////////////////// Combat / Weapons ///////////////////////////////
//////////////////////////////////////////////////////////////////////////////


/datum/supply_pack/skillbooks/gunslinger
	name = "Tycho: Life of a Lawman"
	desc = "The memoirs of a self-acclaimed companion to a mythical folk hero, between the blustering and tales of Texas Rangers there are snippets of useful information."
	cost = 20000 // Permanent combat traits are game changers. Gotta make them hard to get.
	contains = list(/obj/item/book/granter/trait/gunslinger)

/datum/supply_pack/skillbooks/rifleman
	name = "The Neo-Russian Rifleman's Primer"
	desc = "A book with stains of vodka and...blood? The back is hard to read, but says something about bolt-actions. Or pump-actions. Both, maybe."
	cost = 20000
	contains = list(/obj/item/book/granter/trait/rifleman)

/datum/supply_pack/skillbooks/pawear
	name = "US Army: Mechanized Infantry Handbook"
	desc = "A battered olive-green handbook, detailing lessons to ancient mechanized US Army infantry units."
	cost = 20000
	contains = list(/obj/item/book/granter/trait/pa_wear)

/datum/supply_pack/skillbooks/explosives
	name = "Industrial Society and Its Future"
	desc = "This lengthy manifesto happens to contain a variety of valuable knowledge on how to craft explosives of all kinds."
	cost = 10000
	contains = list(/obj/item/book/granter/trait/explosives)

/datum/supply_pack/skillbooks/explosivesadv
	name = "Advanced Techniques for Winning at Postal Chess"
	desc = "Author: Ted Kaczynski."
	cost = 15000
	contains = list(/obj/item/book/granter/trait/explosives_advanced)

/datum/supply_pack/skillbooks/ironfist
	name = "Brawler's Guide to Fisticuffs"
	desc = "An advanced manual on fistfighting. It has pictures, too!"
	cost = 15000
	contains = list(/obj/item/book/granter/trait/iron_fist)

/datum/supply_pack/skillbooks/bigleague
	name = "Grognak the Barbarian"
	desc = "A pulp fiction paperback detailing the adventures of a violent barbarian. Surprisingly, this was sold to children."
	cost = 15000
	contains = list(/obj/item/book/granter/trait/bigleagues)

/datum/supply_pack/skillbooks/trekking
	name = "Wasteland Survival Guide"
	desc = "This indispensable guidebook contains everything that a survivor in the wasteland would need to know."
	cost = 10000
	contains = list(/obj/item/book/granter/trait/trekking)

/datum/supply_pack/skillbooks/trapper
	name = "Guide to Minelaying"
	desc = "Because you really want someone to have a bad day. At some point. Eventually."
	cost = 10000
	contains = list(/obj/item/book/granter/trait/trekking)

/datum/supply_pack/skillbooks/polis
	name = "Vigilante's Journal"
	desc = "An old journal, written by someone with the will to do right but whose life was cut short..."
	cost = 5000
	contains = list(/obj/item/book/granter/crafting_recipe/polis)

//////////////////////////////////////////////////////////////////////////////
///////////////////////// Medical / Science //////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/skillbooks/chemistry
	name = "Big Book of Science"
	desc = "This heavy textbook can teach basic chemistry, but saw more use as a blunt weapon shortly after the Collapse."
	cost = 1000
	contains = list(/obj/item/book/granter/trait/chemistry)

/datum/supply_pack/skillbooks/lowsurgery
	name = "First Aid Pamphlet"
	desc = "A flimsy collection of vital tips and tricks for the average American with a sudden injury."
	cost = 1500
	contains = list(/obj/item/book/granter/trait/lowsurgery)

/datum/supply_pack/skillbooks/midsurgery
	name = "D.C. Journal of Internal Medicine"
	desc = "A nearly intact guide on surgery for pre-collapse medical students and physicians."
	cost = 3000
	contains = list(/obj/item/book/granter/trait/midsurgery)

/datum/supply_pack/skillbooks/poultice
	name = "On the subject of healing poultice"
	desc = "An old book written by a missionary studying the post-cataclysm tribes of the midwest."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/poultice)

/datum/supply_pack/skillbooks/bitters
	name = "Healing techniques of the midwestern tribes"
	desc = "An old book written by a missionary studying the post-cataclysm tribes of the midwest."
	cost = 5000
	contains = list(/obj/item/book/granter/crafting_recipe/bitters)

//////////////////////////////////////////////////////////////////////////////
////////////////////////////// Blueprints ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/skillbooks/r82
	name = "Blueprint - R82 Heavy Service Rifle"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 5000
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/r82)

/datum/supply_pack/skillbooks/mxcarbine
	name = "Blueprint - Marksman Carbine"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 5000
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/marksman)

/datum/supply_pack/skillbooks/cbtrifle
	name = "Blueprint - Combat Rifle"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 5000
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/combatrifle)

/datum/supply_pack/skillbooks/r84
	name = "Blueprint - R84 Light Machine Gun"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 5000
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/r84)

/datum/supply_pack/skillbooks/service
	name = "Blueprint - Service Rifle"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/service)

/datum/supply_pack/skillbooks/aep7
	name = "Blueprint - AEP7"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/aep7)

/datum/supply_pack/skillbooks/leveraction
	name = "Blueprint - Lever Action Shotgun"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/leveraction)

/datum/supply_pack/skillbooks/trailcarbine
	name = "Blueprint - Trail Carbine"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/trailcarbine)

/datum/supply_pack/skillbooks/thatgun
	name = "Blueprint - .308 Pistol"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/thatgun)

/datum/supply_pack/skillbooks/plaspistol
	name = "Blueprint - Plasma Pistol"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/plasmapistol)

/datum/supply_pack/skillbooks/lplaspistol
	name = "Blueprint - Light Plasma Pistol"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/lightplasmapistol)

/datum/supply_pack/skillbooks/uzi
	name = "Blueprint - Uzi"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/uzi)

/datum/supply_pack/skillbooks/smg10mm
	name = "Blueprint - 10mm SMG"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/smg10mm)

/datum/supply_pack/skillbooks/greasegun
	name = "Blueprint - M3A1 Grease Gun"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 6000
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/greasegun)

/datum/supply_pack/skillbooks/brushgun
	name = "Blueprint - Brush Gun"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 5000
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/brushgun)

/datum/supply_pack/skillbooks/r91
	name = "Blueprint - R91 Assault Rifle"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/r91)

/datum/supply_pack/skillbooks/riotshotgun
	name = "Blueprint - Riot Shotgun"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/riotshotgun)

/datum/supply_pack/skillbooks/sniper
	name = "Blueprint - Sniper Rifle"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/sniper)

/datum/supply_pack/skillbooks/deagle
	name = "Blueprint - Desert Eagle"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/deagle)

/datum/supply_pack/skillbooks/aer9
	name = "Blueprint - AER9"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/aer9)

/datum/supply_pack/skillbooks/plasmarifle
	name = "Blueprint - Plasma Rifle"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/plasmarifle)

/datum/supply_pack/skillbooks/tribeam
	name = "Blueprint - Tribeam Laser Rifle"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/tribeam)

/datum/supply_pack/skillbooks/rangemaster
	name = "Blueprint - Colt Rangemaster"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/rangemaster)

/datum/supply_pack/skillbooks/m1garand
	name = "Blueprint - Battle Rifle"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/m1garand)

/datum/supply_pack/skillbooks/lsw
	name = "Blueprint - LSW"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/lsw)

/datum/supply_pack/skillbooks/m1carbine
	name = "Blueprint - M1 Carbine"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/m1carbine)

/datum/supply_pack/skillbooks/pps
	name = "Blueprint - PPSH-41"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/pps)

/datum/supply_pack/skillbooks/commando
	name = "Blueprint - Commando Carbine"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 2500
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/commando)

/datum/supply_pack/skillbooks/armalite
	name = "Blueprint - Armalite"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 5000
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/armalite)

/datum/supply_pack/skillbooks/rangerrepeater
	name = "Blueprint - Ranger Repeater"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 5000
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/rangerrepeater)

/datum/supply_pack/skillbooks/scoutcarbine
	name = "Blueprint - Scout Carbine"
	desc = "Schematics of a quality weapon for a quality customer."
	cost = 5000
	contains = list(/obj/item/book/granter/crafting_recipe/blueprint/scoutcarbine)
