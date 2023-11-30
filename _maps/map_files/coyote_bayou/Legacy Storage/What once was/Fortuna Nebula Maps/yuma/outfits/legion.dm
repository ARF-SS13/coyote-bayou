//Legion Outfits

/decl/hierarchy/outfit/job/legion
	name = "Role - Legion"
	id_type = /obj/item/card/id/legion
	l_ear = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/legion_uniform
	shoes = /obj/item/clothing/shoes/legionboots
	pda_type = null

/decl/hierarchy/outfit/job/legion/Initialize()
	. = ..()
	BACKPACK_OVERRIDE_LEGION

/decl/hierarchy/outfit/job/legion/legate
	name = "Role - Legate"

/decl/hierarchy/outfit/job/legion/centurion
	name = "Role - Centurion"
	id_type = /obj/item/card/id/legion/centurion

/decl/hierarchy/outfit/job/legion/veterandecanus
	name = "Role - Veteran Decanus"
	id_type = /obj/item/card/id/legion/veteran

/decl/hierarchy/outfit/job/legion/primedecanus
	name = "Role - Prime Decanus"
	id_type = /obj/item/card/id/legion/prime

/decl/hierarchy/outfit/job/legion/recruitdecanus
	name = "Role - Recruit Decanus"

/decl/hierarchy/outfit/job/legion/vexillarius
	name = "Role - Vexillarius"

/decl/hierarchy/outfit/job/legion/explorer
	name = "Role - Explorer"

/decl/hierarchy/outfit/job/legion/veteranlegionnaire
	name = "Role - Veteran Legionnaire"
	id_type = /obj/item/card/id/legion/veteran

/decl/hierarchy/outfit/job/legion/primelegionnaire
	name = "Role - Prime Legionnaire"
	id_type = /obj/item/card/id/legion/prime

/decl/hierarchy/outfit/job/legion/recruitlegionnaire
	name = "Role - Recruit Legionnaire"

/decl/hierarchy/outfit/job/legion/slavemaster
	name = "Role - Slavemaster"

/decl/hierarchy/outfit/job/legion/forgemaster
	name = "Role - Forgemaster"

/decl/hierarchy/outfit/job/legion/slave
	name = "Role - Slave"
	id_type = /obj/item/card/id/legion/slave
	uniform = null
	shoes = /obj/item/clothing/shoes/sandal

/decl/hierarchy/outfit/job/legion/slave/pre_equip(mob/living/carbon/human/H)
	. = ..()
	switch(H.gender)
		if(MALE)
			uniform = /obj/item/clothing/under/legion_slave_male
		if(FEMALE)
			uniform = /obj/item/clothing/under/legion_slave_female

	if(!uniform)
		uniform = /obj/item/clothing/under/legion_slave_male

/decl/hierarchy/outfit/job/legion/auxilia
	name = "Role - Auxilia"
	uniform = null
	shoes = /obj/item/clothing/shoes/sandal

/decl/hierarchy/outfit/job/legion/auxilia/pre_equip(mob/living/carbon/human/H)
	. = ..()
	switch(H.gender)
		if(MALE)
			uniform = /obj/item/clothing/under/legion_auxilia_male
		if(FEMALE)
			uniform = /obj/item/clothing/under/legion_auxilia_female

	if(!uniform)
		uniform = /obj/item/clothing/under/legion_auxilia_male
