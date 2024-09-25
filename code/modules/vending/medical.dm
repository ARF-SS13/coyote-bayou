/obj/machinery/vending/medical
	name = "\improper Super-Duper Medivendor"
	desc = "Super-Duper Mart has always sold all sorts of products. This is a vendor from the pharmacy section of their stores, refurbished for use."
	icon_state = "med"
	icon_deny = "med-deny"
	product_ads = "Go save some lives- on a budget!;Super-Duper Mart; your one-stop shop for all your needs!.;PROUDLY AMERICAN products!;Super-Duper Mart, in partnership with the US Army!;This stuff saves lives.;Don't you want some?;Ping!"
	products = list(/obj/item/reagent_containers/syringe = 12,
					/obj/item/reagent_containers/dropper = 3,
					/obj/item/healthanalyzer = 4,
					/obj/item/sensor_device = 2,
					/obj/item/pinpointer/crew = 2,
					/obj/item/reagent_containers/medspray/sterilizine = 1,
					/obj/item/stack/medical/gauze = 8,
					/obj/item/reagent_containers/pill/patch/styptic = 5,
					/obj/item/reagent_containers/medspray/styptic = 2,
					/obj/item/reagent_containers/pill/patch/silver_sulf = 5,
					/obj/item/reagent_containers/medspray/silver_sulf = 2,
					/obj/item/reagent_containers/hypospray/medipen/stimpak = 24,
					/obj/item/reagent_containers/hypospray/medipen/stimpak/super = 4,
					/obj/item/reagent_containers/pill/insulin = 10,
					/obj/item/reagent_containers/pill/salbutamol = 2,
					/obj/item/reagent_containers/glass/bottle/charcoal = 4,
					/obj/item/reagent_containers/glass/bottle/epinephrine = 4,
					/obj/item/reagent_containers/glass/bottle/salglu_solution = 3,
					/obj/item/reagent_containers/glass/bottle/morphine = 4,
					/obj/item/reagent_containers/glass/bottle/toxin = 3,
					/obj/item/reagent_containers/syringe/antiviral = 6,
					/obj/item/storage/briefcase/medical = 2,
					/obj/item/stack/sticky_tape/surgical = 3,
					/obj/item/healthanalyzer/wound = 4,
					/obj/item/stack/medical/ointment = 2,
					/obj/item/stack/medical/suture = 2,
					/obj/item/stack/medical/bone_gel = 4,
					/obj/item/stock_parts/chem_cartridge/simple = 4,
					/obj/item/stock_parts/chem_cartridge/pristine = 1)
	contraband = list(/obj/item/reagent_containers/pill/tox = 3,
					/obj/item/reagent_containers/pill/morphine = 4,
					/obj/item/reagent_containers/pill/charcoal = 6)
	premium = list(/obj/item/reagent_containers/medspray/synthflesh = 2,
					/obj/item/storage/box/hug/medical = 1,
					/obj/item/reagent_containers/hypospray/medipen/stimpak/epipak = 12,
					/obj/item/storage/belt/medical = 3,
					/obj/item/wrench/medical = 1,
					/obj/item/storage/belt/medolier = 2,
					///obj/item/gun/syringe/dart = 2,
					/obj/item/plunger/reinforced = 2)


//						/obj/item/storage/pill_bottle/psicodine = 2, was in this

	armor = ARMOR_VALUE_HEAVY
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/medical
	default_price = PRICE_ABOVE_NORMAL
	extra_price = PRICE_ABOVE_NORMAL
	payment_department = ACCOUNT_MED
	cost_multiplier_per_dept = list(ACCOUNT_MED = 0)

/obj/item/vending_refill/medical
	machine_name = "NanoMed Plus"
	icon_state = "refill_medical"

/obj/machinery/vending/medical/syndicate_access
	name = "\improper SyndiMed Plus"
	payment_department = NO_FREEBIES

/obj/machinery/vending/medical/syndicate_access/Initialize()
	. = ..()
	cost_multiplier_per_dept = list("[ACCESS_SYNDICATE]" = 0)

/obj/machinery/vending/medical/free
	force_free = TRUE

/obj/machinery/vending/medical/follower
	products = list(/obj/item/reagent_containers/syringe = 12,
					/obj/item/reagent_containers/dropper = 3,
					/obj/item/healthanalyzer = 6,
					/obj/item/reagent_containers/medspray/sterilizine = 1,
					/obj/item/stack/medical/gauze = 8,
					/obj/item/reagent_containers/medspray/styptic = 2,
					/obj/item/reagent_containers/pill/patch/silver_sulf = 5,
					/obj/item/reagent_containers/medspray/silver_sulf = 2,
					/obj/item/reagent_containers/pill/salbutamol = 2,
					/obj/item/reagent_containers/glass/bottle/epinephrine = 4,
					/obj/item/reagent_containers/glass/bottle/charcoal = 4,
					/obj/item/reagent_containers/syringe/antiviral = 6,
					/obj/item/reagent_containers/glass/bottle/vial/small = 5,
					/obj/item/storage/briefcase/medical = 2,
					/obj/item/stack/sticky_tape/surgical = 3,
					/obj/item/stack/medical/ointment = 3,
					/obj/item/stack/medical/suture = 3,
					/obj/item/stack/medical/bone_gel = 4,
					/obj/item/stock_parts/chem_cartridge/simple = 4,
					/obj/item/stock_parts/chem_cartridge/pristine = 1)
	contraband = list(/obj/item/reagent_containers/pill/charcoal = 6)
	premium = list(/obj/item/reagent_containers/medspray/synthflesh = 2,
					/obj/item/storage/box/hug/medical = 1,
					/obj/item/storage/pill_bottle/chem_tin/radx = 2,
					/obj/item/reagent_containers/hypospray/medipen/stimpak/epipak = 12,
					/obj/item/storage/belt/medical = 3,
					/obj/item/storage/belt/medolier = 2)
	force_free = TRUE

/obj/machinery/vending/medical/follower/wallmount
	density = 0
	pixel_x = 30

/obj/machinery/vending/medical/nash
	products = list(/obj/item/reagent_containers/syringe = 12,
					/obj/item/reagent_containers/dropper = 3,
					/obj/item/healthanalyzer = 6,
					/obj/item/reagent_containers/medspray/sterilizine = 1,
					/obj/item/stack/medical/gauze = 8,
					/obj/item/reagent_containers/medspray/styptic = 2,
					/obj/item/reagent_containers/pill/patch/silver_sulf = 5,
					/obj/item/reagent_containers/medspray/silver_sulf = 2,
					/obj/item/reagent_containers/pill/salbutamol = 2,
					/obj/item/reagent_containers/glass/bottle/charcoal = 4,
					/obj/item/reagent_containers/syringe/antiviral = 6,
					/obj/item/reagent_containers/glass/bottle/vial/small = 5,
					/obj/item/storage/briefcase/medical = 2,
					/obj/item/stack/sticky_tape/surgical = 3,
					/obj/item/stack/medical/ointment = 2,
					/obj/item/stack/medical/suture = 2,
					/obj/item/stack/medical/bone_gel = 4,
					/obj/item/stock_parts/chem_cartridge/simple = 2)
	contraband = list(/obj/item/reagent_containers/pill/charcoal = 6)
	premium = list(/obj/item/reagent_containers/medspray/synthflesh = 2,
					/obj/item/storage/box/hug/medical = 1,
					/obj/item/storage/pill_bottle/chem_tin/radx = 2,
					/obj/item/reagent_containers/hypospray/medipen/stimpak/epipak = 12,
					/obj/item/storage/belt/medical = 3,
					/obj/item/wrench/medical = 1,
					/obj/item/storage/belt/medolier = 2)
	force_free = TRUE

/obj/machinery/vending/medical/redwater
	name = "\improper Jailbroken Super-Duper Medivendor"
	products = list(/obj/item/reagent_containers/syringe = 12,
					/obj/item/reagent_containers/dropper = 3,
					/obj/item/healthanalyzer = 6,
					/obj/item/reagent_containers/medspray/sterilizine = 1,
					/obj/item/stack/medical/gauze = 8,
					/obj/item/reagent_containers/medspray/styptic = 2,
					/obj/item/reagent_containers/pill/patch/silver_sulf = 5,
					/obj/item/reagent_containers/medspray/silver_sulf = 2,
					/obj/item/reagent_containers/pill/salbutamol = 2,
					/obj/item/reagent_containers/glass/bottle/charcoal = 4,
					/obj/item/reagent_containers/syringe/antiviral = 6,
					/obj/item/reagent_containers/glass/bottle/vial/small = 5,
					/obj/item/storage/briefcase/medical = 2,
					/obj/item/stack/sticky_tape/surgical = 3,
					/obj/item/stack/medical/ointment = 2,
					/obj/item/stack/medical/suture = 2,
					/obj/item/stack/medical/bone_gel = 4,
					/obj/item/reagent_containers/medspray/synthflesh = 2,
					/obj/item/storage/box/hug/medical = 1,
					/obj/item/storage/pill_bottle/chem_tin/radx = 2,
					/obj/item/reagent_containers/hypospray/medipen/stimpak/epipak = 12,
					/obj/item/storage/belt/medical = 3,
					/obj/item/wrench/medical = 1,
					/obj/item/storage/belt/medolier = 2,
					/obj/item/stock_parts/chem_cartridge/simple = 2)
	contraband = list(/obj/item/reagent_containers/pill/charcoal = 6)
	premium = list(/obj/item/reagent_containers/glass/bottle/morphine = 4,
					/obj/item/reagent_containers/glass/bottle/nicotine = 4,
					/obj/item/reagent_containers/glass/bottle/toxin = 3,
					/obj/item/reagent_containers/glass/bottle/methamphetamine = 1,
					/obj/item/reagent_containers/glass/bottle/crank = 1)
	default_price = PRICE_ALMOST_CHEAP
	extra_price = PRICE_ALMOST_EXPENSIVE

/obj/machinery/vending/medical/becomingnook
	name = "\improper Becoming Nook"
	desc = "A becoming nook. Useful for becoming an Aristocrat."
	product_ads = "You are very becoming!;Implantations available, upgrade your license chip today."
	product_slogans = "You are very becoming, Aristocrat."
	products = list(/obj/item/implanter = 3,
					/obj/item/implantcase/mindshield = 3,
					/obj/item/implantcase/chem = 3,
					/obj/item/implantcase/adrenaline = 3,
					/obj/item/organ/heart/cybernetic = 5,
					/obj/item/organ/liver/cybernetic = 5,
					/obj/item/organ/eyes/robotic = 5,
					/obj/item/organ/ears/cybernetic = 5,
					/obj/item/organ/tongue/cybernetic = 5,
					/obj/item/organ/lungs/cybernetic = 5,
					/obj/item/organ/stomach = 5,
					/obj/item/organ/liver/cybernetic = 5,
					/obj/item/organ/cyberimp/arm/toolset = 5,
					/obj/item/organ/cyberimp/arm/surgery = 5,
					/obj/item/organ/cyberimp/arm/janitor = 5,
					/obj/item/organ/cyberimp/arm/service = 5)
	contraband = list(/obj/item/organ/cyberimp/arm/esword = 3)
	premium = list(/obj/item/organ/heart/cybernetic/upgraded = 8,
					/obj/item/organ/liver/cybernetic/upgraded = 8,
					/obj/item/organ/eyes/robotic/glow = 8,
					/obj/item/organ/eyes/robotic/flashlight = 2,
					/obj/item/organ/eyes/robotic/shield = 8,
					/obj/item/organ/cyberimp/brain/anti_stun = 8,
					/obj/item/organ/cyberimp/brain/anti_drop = 8)
	default_price = PRICE_ALMOST_EXPENSIVE
	extra_price = PRICE_EXPENSIVE

/obj/machinery/vending/medical/researchgrants
	name = "\improper Research Grants"
	desc = "A vendor that allows the clinic to purchase researchable documents for syncing up with other research facilities."
	product_ads = ""
	product_slogans = ""
	products = list(/obj/item/blueprint/research = 5)
	contraband = list()
	premium = list(/obj/item/documents/syndicate/blue = 3)
	resistance_flags = INDESTRUCTIBLE
	default_price = PRICE_RESEARCH
	extra_price = PRICE_RESEARCH_PLUS
