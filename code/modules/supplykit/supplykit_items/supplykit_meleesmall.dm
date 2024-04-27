
/* small melee

//primary vars
/datum/supplykit_item/meleesmall/
	name = 
	desc = 
	item = 
	cost = 

//other vars
	surplus = 100 //if set below 100, reduces chances of being in the surplus crate
	cant_discount = FALSE //if set to true, prevents possible discounts
	limited_stock = -1 //-1 is infinite stock. otherwise, limits how many you can buy. also prevents discounts.
	restricted_roles = list() //for restricting by job type
	*/

/datum/supplykit_item/meleesmall/brassknuckles
	name = "Brass Knuckles"
	desc = "A set of brass rings that give your unarmed punches a hard impact when worn as a glove."
	item = /obj/item/melee/unarmed/brass
	important = TRUE

/datum/supplykit_item/meleesmall/garb
	name = "Black Gar Glasses"
	desc = "A pair of over the top and razor sharp glasses."
	item = /obj/item/clothing/glasses/sunglasses/garb

/datum/supplykit_item/meleesmall/supergarb
	name = "Black Gigga Gar Glasses"
	desc = "A pair of extra over the top and razor sharp glasses."
	item = /obj/item/clothing/glasses/sunglasses/garb/supergarb

/datum/supplykit_item/meleesmall/boomerang
	name = "Boomerang"
	desc = "A wooden melee weapon that will return when thrown."
	item = /obj/item/melee/f13onehanded/boomerang

/datum/supplykit_item/meleesmall/bowie
	name = "Bowie Knife"
	desc = "A hefty bladed knife."
	item = /obj/item/melee/onehanded/knife/bowie

/datum/supplykit_item/meleesmall/club
	name = "Club"
	desc = "A simple, effective blunt wooden instrument."
	item = /obj/item/melee/coyote/club

/datum/supplykit_item/meleesmall/combataxe
	name = "Combat Axe"
	desc = "A heavy iron hafted fighting axe."
	item = /obj/item/melee/coyote/combataxe

/datum/supplykit_item/meleesmall/energykatana
	name = "Energy Katana"
	desc = "A swift eastern energy blade."
	item = /obj/item/melee/transforming/plasmacutter/regular/energykatana

/datum/supplykit_item/meleesmall/fryingpan
	name = "Frying Pan"
	desc = "Hehehe pan go bonk."
	item = /obj/item/melee/onehanded/club/fryingpan

/datum/supplykit_item/meleesmall/supergar
	name = "Gigga Gar Glasses"
	desc = "An incredibly stylish set of razor sharp glasses."
	item = /obj/item/clothing/glasses/sunglasses/gar/supergar

/datum/supplykit_item/meleesmall/mace
	name = "Mace"
	desc = "A weighty iron mace with a leather grip."
	item = /obj/item/melee/coyote/club/mace

/datum/supplykit_item/meleesmall/machete
	name = "Machete"
	desc = "A tarnished machete with a curved blade."
	item = /obj/item/melee/onehanded/machete/forgedmachete

/datum/supplykit_item/meleesmall/mac
	name = "Macuahuitl"
	desc = "A wooden club lined with obsidian shards, originally designed to cause crippling but survivable wounds to capture subjects for aztec blood rituals."
	item = /obj/item/melee/coyote/macuahuitl

/datum/supplykit_item/meleesmall/armingsword
	name = "Arming Sword"
	desc = "A classic western sword commonly used by knights of the high middle ages."
	item = /obj/item/melee/coyote/oldlongsword/armingsword

/datum/supplykit_item/meleesmall/bokken
	name = "Bokken"
	desc = "A wooden katana for practice and nonlethal blunt force trauma."
	item = /obj/item/melee/classic_baton/coyote/oldquarterstaff/oldbokken

/datum/supplykit_item/meleesmall/contractor_baton
	name = "Contractor Baton"
	desc = "A high tech stunningstick that is the unholy triumvirate of stun combat. Perfect for downing bottoms like they're gazelles!"
	item = /obj/item/melee/classic_baton/telescopic/contractor_baton
	cant_discount = TRUE
	cost = 5

/datum/supplykit_item/meleesmall/broadsword
	name = "Broadsword"
	desc = "A classic, straight bladed steel sword."
	item = /obj/item/melee/coyote/oldlongsword/broadsword

/datum/supplykit_item/meleesmall/longquan
	name = "Chinese Sword"
	desc = "An ancient straight bladed sword with a gold filagreed guard."
	item = /obj/item/melee/coyote/oldlongsword/longquan

/datum/supplykit_item/meleesmall/cutlass
	name = "Cutlass"
	desc = "A curved sword for butchering and swashbuckling."
	item = /obj/item/melee/coyote/oldcutlass

/datum/supplykit_item/meleesmall/dervish
	name = "Dervish Blade"
	desc = "A single bladed middle-eastern sword with a curved grip."
	item = /obj/item/melee/coyote/olddervish

/datum/supplykit_item/meleesmall/khopesh
	name = "Khopesh"
	desc = "An ancient bronze weapon that crosses the line between sword and axe."
	item = /obj/item/melee/coyote/oldkhopesh

/datum/supplykit_item/meleesmall/longsword
	name = "Longsword"
	desc = "A long bladed steel sword, used by the knights of old."
	item = /obj/item/melee/coyote/oldlongsword

/datum/supplykit_item/meleesmall/quarterstaff
	name = "Quarterstaff"
	desc = "A simple, sturdy pole that allows very defensive combat."
	item = /obj/item/melee/classic_baton/coyote/oldquarterstaff

/datum/supplykit_item/meleesmall/spadroon
	name = "Spadroon"
	desc = "A light military blade with a brass basket hilt."
	item = /obj/item/melee/coyote/oldlongsword/spadroon

/datum/supplykit_item/meleesmall/tanto
	name = "Tanto"
	desc = "A curved eastern heavy bladed dagger."
	item = /obj/item/melee/coyote/tantoold

/datum/supplykit_item/meleesmall/wakazashi
	name = "Wakazashi"
	desc = "An eastern short sword with a curved blade."
	item = /obj/item/melee/coyote/wakazashiold

/datum/supplykit_item/meleesmall/xiphos
	name = "Xiphos"
	desc = "A short bladed Roman dagger with a tapered thrusting blade."
	item = /obj/item/melee/coyote/oldlongsword/xiphos

/datum/supplykit_item/meleesmall/gar
	name = "Orange Gar Glasses"
	desc = "A stylish set of sharp pointy glasses."
	item = /obj/item/clothing/glasses/sunglasses/gar

/datum/supplykit_item/meleesmall/plasma
	name = "Plasma Slicer"
	desc = "A green plasma blade, augmented for boosted damage."
	item = /obj/item/melee/transforming/plasmacutter/regular

/datum/supplykit_item/meleesmall/celestia
	name = "Plasma Slicer Celestia"
	desc = "A blue plasma blade, augmented to deflect attacks."
	item = /obj/item/melee/transforming/plasmacutter/regular/celestia

/datum/supplykit_item/meleesmall/eve
	name = "Plasma Slicer Eve"
	desc = "A purple plasma blade, augmented for swift strikes."
	item = /obj/item/melee/transforming/plasmacutter/regular/eve

/datum/supplykit_item/meleesmall/smallsword
	name = "Small Sword"
	desc = "A light, narrow blade made for thrusting. The lethal version of a fencing foil."
	item = /obj/item/melee/coyote/smallsword

/datum/supplykit_item/meleesmall/switchblade
	name = "Switchblade"
	desc = "A swift folding blade that can fit in wallets and other small spaces."
	item = /obj/item/melee/onehanded/knife/switchblade

/datum/supplykit_item/meleesmall/warclub
	name = "War Club"
	desc = "A carved wooden tribal club with turquoise decoration."
	item = /obj/item/melee/onehanded/club/warclub

