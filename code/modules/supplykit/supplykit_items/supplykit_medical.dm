
/* medical supplies

//primary vars
/datum/supplykit_item/medical/
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

/datum/supplykit_item/medical/emergencykit
	name = "Emergency Aid Kit"
	desc = "A kit containing cheap medical supplies, good for emergency wound treatment."
	item = /obj/item/storage/firstaid/emergency
	cost = 5
	limited_stock = 1 //cheap, but you only get one
	important = TRUE

/datum/supplykit_item/medical/firstaid1
	name = "Type 1 First Aid Kit"
	desc = "A kit containing large amounts of gauze, some sutures, and a stimpak"
	item = /obj/item/storage/firstaid/regular
	cost = 20
	important = TRUE

/datum/supplykit_item/medical/firstaid2
	name = "Type 2 First Aid Kit"
	desc = "A kit containing a wide variety of medical supplies, including gauze, sutures, a stim, and more."
	item = /obj/item/storage/firstaid/ancient
	cost = 20
	important = TRUE

/datum/supplykit_item/medical/blood
	name = "O- Bloodbag"
	desc = "Universal red blood, for emergency transfusions and hematophagy."
	item = /obj/item/reagent_containers/blood/OMinus
	cost = 2
	limited_stock = 3

/datum/supplykit_item/medical/saline
	name = "SalGlu Bottle"
	desc = "A bottle of Saline Glucose, for blood replenishment."
	item = /obj/item/reagent_containers/glass/bottle/salglu_solution
	cost = 1

/datum/supplykit_item/medical/epipak
	name = "Epipak"
	desc = "An autoinjector containing a mix of chemicals that stabilize critical injuries and significantly slow bleeding."
	item = /obj/item/reagent_containers/hypospray/medipen/stimpak/epipak
	cost = 3

/datum/supplykit_item/medical/gauze
	name = "Medical Gauze"
	desc = "Sterile Gauze for tending bleeding wounds and healing animals."
	item = /obj/item/stack/medical/gauze
	cost = 5

/datum/supplykit_item/medical/suture
	name = "Medical Sutures"
	desc = "Sterile thread and a curved needle for sewing wounds shut."
	item = /obj/item/stack/medical/suture
	cost = 10

/datum/supplykit_item/misc/defibprimative
	name = "Improvised Defib"
	desc = "For reviving your friends, can be stuffed in your bag."
	item = /obj/item/defibrillator/primitive
	cost = 5

/datum/supplykit_item/misc/defibcompact
	name = "Compact Defib"
	desc = "For reviving your friends, can be stuffed in your bag, or worn on your belt."
	item = /obj/item/defibrillator/compact
	cost = 15

/datum/supplykit_item/misc/defibsalt
	name = "Smelling Salts"
	desc = "For reviving your friends, its small, but only has 10 uses."
	item = /obj/item/smelling_salts
	cost = 20

/datum/supplykit_item/magic/medbeam
	name = "Medbeam"
	desc = "A powerful medical beam gun that lets you beam your friends back to full health, very consistant and free to use!"
	item = /obj/item/gun/medbeam
	cost = 70

/* burns aren't implimented
/datum/supplykit_item/medical/ointment
	name = "Ointment"
	desc = "A tube of soothing ointment that heals burns and animals."
	item = /obj/item/stack/medical/ointment
	cost = 10
*/

/datum/supplykit_item/medical/charcoalsyringe
	name = "Charcoal Syringe"
	desc = "A syringe of activated charcoal, which purges toxins and chemicals within the bloodstream. Has three doses."
	item = /obj/item/reagent_containers/syringe/charcoal
	cost = 20

/datum/supplykit_item/medical/stimpak
	name = "Stimpak"
	desc = "A quick and easy injector that heals brute and burn damage."
	item = /obj/item/reagent_containers/hypospray/medipen/stimpak
	cost = 15

/datum/supplykit_item/medical/glucose
	name = "Glucose Injector"
	desc = "An injector full of sugar, for replenishing nutrition and blood supply, which together aid in wound healing."
	item = /obj/item/reagent_containers/hypospray/medipen/stimpak/glucose
	cost = 2

/datum/supplykit_item/medical/healingpowder
	name = "Healing Powder"
	desc = "A pouch of ground up herbs, which sooth brute and burn damage over time."
	item = /obj/item/reagent_containers/pill/healingpowder
	cost = 10

/datum/supplykit_item/medical/antivenom
	name = "Antivenom"
	desc = "A flask containing a chemical which purges harmful chemicals and toxins."
	item = /obj/item/reagent_containers/pill/antivenom
	cost = 10

/datum/supplykit_item/medical/purgative
	name = "Fiery Purgative"
	desc = "A foul liquid that violently purges your body of all toxins, chemicals, and radiation via very unpleasant means."
	item = /obj/item/reagent_containers/pill/fiery_purgative
	cost = 10

/datum/supplykit_item/medical/radx
	name = "Rad-x Bottle"
	desc = "A bottle of preventative anti-radiation chemicals, massively reducing the effects of exposure."
	item = /obj/item/storage/pill_bottle/chem_tin/radx
	cost = 5

/datum/supplykit_item/medical/radaway
	name = "Radaway"
	desc = "A bloodpack full of radiation purging chemicals. FAR MORE EFFECTIVE if applied via syringe or IV drip."
	item = /obj/item/reagent_containers/blood/radaway
	cost = 20

/datum/supplykit_item/medical/chloralhydrate
	name = "Chloral Hydrate Bottle"
	desc = "A bottle of sleep inducing chemicals, for knocking out patients for surgery and nothing else."
	item = /obj/item/reagent_containers/glass/bottle/chloralhydrate
	cost = 5

/datum/supplykit_item/medical/randompills
	name = "Strange Pill Bottle"
	desc = "A bottle full of tasty fruit salad."
	item = /obj/item/storage/pill_bottle/random
	cost = 10

/datum/supplykit_item/medical/jet
	name = "Jet"
	desc = "An inhaler containing a dirty chem for a quick and energetic high."
	item = /obj/item/reagent_containers/pill/patch/jet
	cost = 5

/datum/supplykit_item/medical/medx
	name = "Med-X"
	desc = "A syringe containing a military stimulant, which temporary sooths pain and improves health."
	item = /obj/item/reagent_containers/pill/patch/medx
	cost = 5

/datum/supplykit_item/medical/psycho
	name = "Psycho"
	desc = "A cocktail of drugs that gives the user an aggressive high, improving tenacity in melee combat."
	item = /obj/item/reagent_containers/pill/patch/psycho
	cost = 5

/datum/supplykit_item/medical/turbo
	name = "Turbo"
	desc = "A drug that makes the user incredibly hyperactive and speedy."
	item = /obj/item/reagent_containers/pill/patch/turbo
	cost = 5

/datum/supplykit_item/medical/steady
	name = "Steady"
	desc = "A highly addictive cocktail that gives the user laser focus, improving ballistic precision."
	item = /obj/item/reagent_containers/pill/patch/steady
	cost = 5

/datum/supplykit_item/medical/buffout
	name = "Buffout Tin"
	desc = "A tin of steroid pills, which improve endurance and strength in the user, temporarily bolstering health and melee ability."
	item = /obj/item/storage/pill_bottle/chem_tin/buffout
	cost = 20

/datum/supplykit_item/medical/happy
	name = "Happy Pills"
	desc = "A bottle full of pills that are guaranteed to make you happy :)"
	item = /obj/item/storage/pill_bottle/happy
	cost = 10

