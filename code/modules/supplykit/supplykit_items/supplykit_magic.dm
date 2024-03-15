
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

/datum/supplykit_item/magic/healing
	name = "Staff of Unstable Blessings"
	desc = "A chaotic staff of healing that sooths a random damage type with each cast."
	item = /obj/item/gun/magic/staff/healing/triheal
	cost = 40

/datum/supplykit_item/magic/swampstar
	name = "Bands of the Swampstar"
	desc = "Mystical armbands made for deadly, lightning fast martial arts. Once worn, they cannot be removed. You can prepare a warcry with (alt click) on the gloves."
	item = /obj/item/clothing/gloves/fingerless/pugilist/rapid
	cost = 40

/datum/supplykit_item/magic/berseker
	name = "Berserker's Rights"
	desc = "A ritual scroll granting the reader aggressive and brutal unarmed combos, improved stamina, enhanced reflexes for catching incoming objects, and a loss of ability in operating firearms."
	item = /obj/item/book/granter/martial/berserker
	cost = 40

/datum/supplykit_item/magic/ragingboar
	name = "Raging Boar Scroll"
	desc = "A ritual scroll granting the reader whirlwind attacks, a strike that knocks enemies back, an aversion to drugs, and an unwillingness to utilize firearms."
	item = /obj/item/book/granter/martial/raging_boar
	cost = 40

/datum/supplykit_item/magic/sleepingcarp
	name = "Sleeping Carp Scroll"
	desc = "A ritual scroll granting the reader the ability to deflect bullets with an open hand, at the cost of stamina, improved resistance to incoming stamina damage and stuns, and an aversion to drugs and firearms."
	item = /obj/item/book/granter/martial/carp
	cost = 40


