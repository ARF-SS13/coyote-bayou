//NCR Outfits

/decl/hierarchy/outfit/job/ncr
	name = "Role - NCR"
	id_type = /obj/item/card/id/ncr
	l_ear = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/ncr_uniform
	shoes = /obj/item/clothing/shoes/patrolboots
	pda_type = null

/decl/hierarchy/outfit/job/ncr/Initialize()
	. = ..()
	BACKPACK_OVERRIDE_NCR

/decl/hierarchy/outfit/job/ncr/colonel
	name = "Role - Colonel"
	id_type = /obj/item/card/id/ncr/captain
	uniform = /obj/item/clothing/under/ncr_uniform_dress

/decl/hierarchy/outfit/job/ncr/personalaide
	name = "Role - Personal Aide"
	uniform = /obj/item/clothing/under/ncr_uniform_dress

/decl/hierarchy/outfit/job/ncr/captain
	name = "Role - Captain"
	id_type = /obj/item/card/id/ncr/captain
	uniform = /obj/item/clothing/under/ncr_uniform_dress

/decl/hierarchy/outfit/job/ncr/lieutenant
	name = "Role - Lieutenant"
	id_type = /obj/item/card/id/ncr/officer
	uniform = /obj/item/clothing/under/ncr_uniform_dress

/decl/hierarchy/outfit/job/ncr/medicalofficer
	name = "Role - Medical Officer"
	id_type = /obj/item/card/id/ncr/officer
	uniform = /obj/item/clothing/under/ncr_uniform_dress

/decl/hierarchy/outfit/job/ncr/logisticsofficer
	name = "Role - Logistics Officer"
	id_type = /obj/item/card/id/ncr/officer
	uniform = /obj/item/clothing/under/ncr_uniform_dress

/decl/hierarchy/outfit/job/ncr/representative
	name = "Role - Representative"
	uniform = /obj/item/clothing/under/ncr_uniform_dress

/decl/hierarchy/outfit/job/ncr/militarypolice
	name = "Role - Military Police"
	id_type = /obj/item/card/id/ncr/sergeant

/decl/hierarchy/outfit/job/ncr/sergeant
	name = "Role - Sergeant"
	id_type = /obj/item/card/id/ncr/sergeant

/decl/hierarchy/outfit/job/ncr/heavytrooper
	name = "Role - Heavy Trooper"
	id_type = /obj/item/card/id/ncr/sergeant

/decl/hierarchy/outfit/job/ncr/veteranranger
	name = "Role - Veteran Ranger"
	id_type = /obj/item/card/id/ncr/veteranranger
	uniform = /obj/item/clothing/under/ncr_ranger_flannel

/decl/hierarchy/outfit/job/ncr/ranger
	name = "Role - Ranger"
	id_type = /obj/item/card/id/ncr/ranger
	uniform = /obj/item/clothing/under/ncr_ranger

/decl/hierarchy/outfit/job/ncr/corporal
	name = "Role - Corporal"

/decl/hierarchy/outfit/job/ncr/combatengineer
	name = "Role - Combat Engineer"

/decl/hierarchy/outfit/job/ncr/combatmedic
	name = "Role - Combat Medic"

/decl/hierarchy/outfit/job/ncr/trooper
	name = "Role - Trooper"

/decl/hierarchy/outfit/job/ncr/rearechelon
	name = "Role - Rear Echelon"
