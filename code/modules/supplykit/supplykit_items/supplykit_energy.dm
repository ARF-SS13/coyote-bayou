
/* energy

//primary vars
/datum/supplykit_item/energy/
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

/* no starters use MFC yet
/datum/supplykit_item/energy/mfc
	name = "Microfusion Cell"
	desc = "A large power cell for large energy weapons."
	item = /obj/item/stock_parts/cell/ammo/mfc
	cost = 15

/datum/supplykit_item/energy/mfcbad
	name = "Shoddy Microfusion Cell"
	desc = "A low quality microfusion cell with reduced capacity."
	item = /obj/item/stock_parts/cell/ammo/mfc/bad
	cost = 10

/datum/supplykit_item/energy/mfcrecycled
	name = "Recycled Microfusion Cell"
	desc = "A worn out microfusion cell that has lost the ability to be recharged."
	item = /obj/item/stock_parts/cell/ammo/mfc/recycled
	cost = 5
*/

/datum/supplykit_item/energy/ec
	name = "Energy Cell"
	desc = "A small power cell for small energy weapons."
	item = /obj/item/stock_parts/cell/ammo/ec
	cost = 15
	important = TRUE

/datum/supplykit_item/energy/ecbad
	name = "Shoddy Energy Cell"
	desc = "A low quality energy cell with reduced capacity."
	item = /obj/item/stock_parts/cell/ammo/ec/bad
	cost = 10
	important = TRUE

/datum/supplykit_item/energy/ecrecycled
	name = "Recycled Energy Cell"
	desc = "A worn out energy cell that has lost the ability to be recharged."
	item = /obj/item/stock_parts/cell/ammo/ec/recycled
	cost = 5
	important = TRUE

/datum/supplykit_item/energy/ecp
	name = "Electron Charge Pack"
	desc = "A capacitor cluster designed for rapid power draw for rapid-fire energy weapons."
	item = /obj/item/stock_parts/cell/ammo/ecp
	cost = 15
	important = TRUE

/datum/supplykit_item/energy/ecpbad
	name = "Shoddy Electron Charge Pack"
	desc = "A low quality electron charge pack with reduced capacity."
	item = /obj/item/stock_parts/cell/ammo/ecp/bad
	cost = 10
	important = TRUE

/datum/supplykit_item/energy/ecprecycled
	name = "Recycled Electron Charge Pack"
	desc = "A worn out electron charge pack that has lost the ability to be recharged."
	item = /obj/item/stock_parts/cell/ammo/ecp/recycled
	cost = 5
	important = TRUE

/datum/supplykit_item/energy/compactrcw
	name = "Compact RCW"
	desc = "A high capacity rapid fire laser machine-pistol. Takes ECP."
	item = /obj/item/gun/energy/laser/auto/worn

/datum/supplykit_item/energy/compliance
	name = "Compliance Regulator"
	desc = "A simple energy stun gun that does stamina damage. Takes EC."
	item = /obj/item/gun/energy/laser/complianceregulator

/datum/supplykit_item/energy/plasmapistol
	name = "Plasma Pistol"
	desc = "A high power pistol firing bolts of plasma. Takes EC."
	item = /obj/item/gun/energy/laser/plasma/pistol/worn

/datum/supplykit_item/energy/tgcarbine
	name = "Laser Carbine"
	desc = "A small laser carbine with an crank operated battery."
	item = /obj/item/gun/energy/laser/cranklasergun/tg/carbine
	cost = 20

/datum/supplykit_item/energy/tgpistol
	name = "Miniature Laser Pistol"
	desc = "A compact laser pistol with an crank operated battery."
	item = /obj/item/gun/energy/laser/cranklasergun/tg/pistol
	cost = 20

/datum/supplykit_item/energy/covpistol
	name = "Covenant Plasma Pistol"
	desc = "An alien looking plasma pistol with an internal self charging battery."
	item = /obj/item/gun/energy/laser/plasma/covpistol
	cost = 20

/datum/supplykit_item/energy/plasmarifle
	name = "Covenant Plasma Rifle"
	desc = "An alien looking plasma rifle with an internal self charging battery."
	item = /obj/item/gun/energy/laser/plasma/plasmacov
	cost = 20

/datum/supplykit_item/energy/repeater
	name = "Repeating Blaster"
	desc = "A repeating blaster that shoots very quickly. Uses very low power blaster bolts. Can be cranked to be recharged."
	item = /obj/item/gun/energy/laser/cranklasergun/tg/spamlaser
	cost = 40

/datum/supplykit_item/energy/shocker
	name = "Shock Autoblaster"
	desc = "A repeating blaster that uses low power tesla shocks. Can be cranked to recharge."
	item = /obj/item/gun/energy/laser/cranklasergun/tg/spamlaser/shock
	cost = 40

/datum/supplykit_item/energy/smuggledhos
	name = "Smuggled HOS Pistol"
	desc = "A smuggled HOS pistol from a far off space station. Due to a size restricted capacitor to make it fit discreetly in cargo, it takes five seconds to charge."
	item = /obj/item/gun/energy/laser/tg/recharger/loadout
	cost = 40 // 5 second long self charge + 100 dps

/datum/supplykit_item/energy/smuggledhos/captain
	name = "Smuggled Antique Laser Pistol"
	desc = "A smuggled Captain's antique pistol from a far off space station. Statistically the same as the Smuggled HOS Pistol."
	item = /obj/item/gun/energy/laser/tg/recharger/loadout/captainskin

/datum/supplykit_item/energy/wattz
	name = "Wattz 1000"
	desc = "A semi-auto Laser pistol firing high energy bolts. takes EC."
	item = /obj/item/gun/energy/laser/wattz

/datum/supplykit_item/energy/aep
	name = "Worn AEP-7"
	desc = "An old Military laser pistol with high rate of fire. takes EC."
	item = /obj/item/gun/energy/laser/pistol/worn

/datum/supplykit_item/energy/portacharger
	name = "Portable Recharger"
	desc = "A normal size recharger box for recharging powercells and E-Pistols"
	item = /obj/item/storage/battery_box
	cost = 40
