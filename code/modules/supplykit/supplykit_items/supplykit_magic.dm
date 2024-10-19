
/* magic

//primary vars
/datum/supplykit_item/magic/
	name = 
	desc = 
	item = 
	cost = 

//other vars
	surplus = 100 //if set below 100, reduces chances of being in the surplus crate
	cant_discount = FALSE //if set to true, prevents possible discounts
	limited_stock = -1 //-1 is infinite stock. otherwise, limits how many you can buy. also prevents discounts
	restricted_roles = list() //for restricting by job type
	*/

/datum/supplykit_item/magic/nullrod
	name = "Nullrod"
	desc = "A nullrod, can also be turned into other powerful holy weapons. Like a blocking blue staff, or healing prayer bead"
	item = /obj/item/nullrod
	cost = 40

/datum/supplykit_item/magic/shockwand
	name = "Improvised Rod of Sparks"
	desc = "A simple rod of sparks that slowly recharges."
	item = /obj/item/gun/magic/wand/kelpmagic/basiczappies

/datum/supplykit_item/magic/magicmissile
	name = "Improvised Wand of Magic Missile"
	desc = "A simple wand of magic missile that slowly recharges."
	item = /obj/item/gun/magic/wand/kelpmagic/magicmissile

/datum/supplykit_item/magic/fireball
	name = "Lesser Fireball Staff"
	desc = "A simple staff that launches a fireball blast."
	item = /obj/item/gun/magic/staff/kelpmagic/fireball/lowpower
	cost = 40

/datum/supplykit_item/magic/magma
	name = "Lesser Magma Staff"
	desc = "A short range flamethrower for magicians"
	item = /obj/item/gun/magic/staff/kelpmagic/flamethrower/weak
	cost = 40

/datum/supplykit_item/magic/acid
	name = "Lesser Acid Staff"
	desc = "A simple staff that launches a acid ball."
	item = /obj/item/gun/magic/staff/kelpmagic/acidstaff/lowpower
	cost = 40

/datum/supplykit_item/magic/healing/lowpower
	name = "Lesser Staff of Healing"
	desc = "An apprentice healing mages staff.  Do not cross the beams."
	item = /obj/item/gun/medbeam/magic/lowpower
	cost = 40

/datum/supplykit_item/magic/lightning/lowpower
	name = "Lesser Staff of Lightning"
	desc = "An apprentice lightning mages staff.  Cast lightning bolt on someones ass."
	item = /obj/item/gun/magic/staff/kelpmagic/lightning/lowpower
	cost = 40

/datum/supplykit_item/magic/healing
	name = "Staff of Unstable Healings"
	desc = "A chaotic staff of healing that sooths a random damage type with each cast."
	item = /obj/item/gun/magic/staff/healing/triheal
	cost = 40

// /datum/supplykit_item/magic/swampstar
// 	name = "Bands of the Swampstar"
// 	desc = "Mystical armbands made for deadly, lightning fast martial arts. Once worn, they cannot be removed. You can prepare a warcry with (alt click) on the gloves."
// 	item = /obj/item/clothing/gloves/fingerless/pugilist/rapid
// 	cost = 40

// /datum/supplykit_item/magic/berseker
// 	name = "Berserker's Rights"
// 	desc = "A ritual scroll granting the reader aggressive and brutal unarmed combos, improved stamina, better footing, enhanced reflexes for catching incoming objects, and a loss of ability in operating firearms."
// 	item = /obj/item/book/granter/martial/berserker
// 	cost = 40

// /datum/supplykit_item/magic/ragingboar
// 	name = "Raging Boar Scroll"
// 	desc = "A ritual scroll granting the reader whirlwind attacks, a strike that knocks enemies back, an aversion to drugs, and an unwillingness to utilize firearms."
// 	item = /obj/item/book/granter/martial/raging_boar
// 	cost = 40

// /datum/supplykit_item/magic/sleepingcarp
// 	name = "Sleeping Carp Scroll"
// 	desc = "A ritual scroll granting the reader the ability to deflect bullets with an open hand, at the cost of stamina and increased damage taken, improved resistance to incoming stamina damage and stuns, and an aversion to drugs."
// 	item = /obj/item/book/granter/martial/carp
// 	cost = 40

/datum/supplykit_item/magic/peaceflower
	name = "Peace Flower"
	desc = "A flower that when worn heals you and feeds you for large amounts, but makes you a pacifist. Its behavior can be altered with shift+ctrl click. You can click it to reduce your radiation too!"
	item = /obj/item/clothing/head/peaceflower
	cost = 15

/datum/supplykit_item/magic/mendingwand
	name = "Wand of Mending"
	desc = "A wand that can be used to heal your friends, one of the best healing methods available. And it fits in your bag!"
	item = /obj/item/gun/magic/wand/kelpmagic/healwand
	cost = 65

/datum/supplykit_item/magic/staffofhealing
	name = "Perfected Staff Of Healing"
	desc = "A magic staff that fires a beam of healing at a target, extremely consistant healing to your friends!"
	item = /obj/item/gun/medbeam/magic
	cost = 70

// /datum/supplykit_item/magic/bass
// 	name = "Rising Bass"
// 	desc = "A ritual scroll granting the reader the ability to passively dodge bullets and perform many potent defensive moves, at the cost of ranged weaponry and drugs."
// 	item = /obj/item/book/granter/martial/bass
// 	cost = 40
