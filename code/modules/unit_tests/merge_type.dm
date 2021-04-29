/datum/unit_test/merge_type/Run()
	var/list/blacklist = list(/obj/item/stack/sheet,
							  /obj/item/stack/sheet/mineral,
							  /obj/item/stack/ore,
							  /obj/item/stack/spacecash,
							  /obj/item/stack/spacecash/random,
							  /obj/item/stack/tile/mineral,
							  /obj/item/stack/tile,
							  /obj/item/stack/sheet/animalhide,
							  /obj/item/stack/crafting,
							  /obj/item/stack/prefabs,
							  /obj/item/stack/f13Cash/caps/fivezerozero,
							  /obj/item/stack/f13Cash/random/low,
							  /obj/item/stack/f13Cash/random/med,
							  /obj/item/stack/f13Cash/random/high,
							  /obj/item/stack/f13Cash/random/banker,
							  /obj/item/stack/f13Cash/random,
							  /obj/item/stack/f13Cash/random/denarius/low,
							  /obj/item/stack/f13Cash/random/denarius/med,
							  /obj/item/stack/f13Cash/random/denarius/high,
							  /obj/item/stack/f13Cash/random/denarius/legionpay_basic,
							  /obj/item/stack/f13Cash/random/denarius/legionpay_veteran,
							  /obj/item/stack/f13Cash/random/denarius/legionpay_officer,
							  /obj/item/stack/f13Cash/random/denarius,
							  /obj/item/stack/f13Cash/random/aureus/low,
							  /obj/item/stack/f13Cash/random/aureus/med,
							  /obj/item/stack/f13Cash/random/aureus/high,
							  /obj/item/stack/f13Cash/random/aureus,
							  /obj/item/stack/f13Cash/random/ncr/low,
							  /obj/item/stack/f13Cash/random/ncr/med,
							  /obj/item/stack/f13Cash/random/ncr/high,
							  /obj/item/stack/f13Cash/random/ncr/ncrpay_basic,
							  /obj/item/stack/f13Cash/random/ncr/ncrpay_veteran,
							  /obj/item/stack/f13Cash/random/ncr/ncrpay_officer,
							  /obj/item/stack/f13Cash/random/ncr)

	var/list/paths = subtypesof(/obj/item/stack) - blacklist

	for(var/stackpath in paths)
		var/obj/item/stack/stack = stackpath
		if(!initial(stack.merge_type))
			Fail("([stack]) lacks set merge_type variable!")
