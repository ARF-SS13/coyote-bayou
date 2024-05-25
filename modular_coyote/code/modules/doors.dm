/obj/machinery/door/airlock/ckey
	desc = "Looks like this airlock has been fitted with a DNA scanner to only allow certain people through."
	var/list/req_one_ckey = list() //If you have a key in this list you can open the door. NO CAPITALIZATION

/obj/machinery/door/airlock/ckey/highsecurity
	name = "high tech security airlock"
	icon = 'icons/obj/doors/airlocks/highsec/highsec.dmi'
	overlays_file = 'icons/obj/doors/airlocks/highsec/overlays.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_highsecurity
	explosion_block = 100
	max_integrity = 10000
	security_level = 1
	damage_deflection = 38
	obj_flags = INDESTRUCTIBLE

/obj/machinery/door/airlock/ckey/highsecurity/andy
	req_one_ckey = list("andyman105", "dameonowen", "dwagin", "foxyrose", "thingpony", "brimcon", "aldrictalvalin", "dwaggy90", "roguenoob")

/obj/machinery/door/airlock/ckey/allowed(mob/M)
	if(locked)
		return 0
	if(!LAZYLEN(req_one_ckey) || !M.ckey)
		return ..(M)//No ckey list or no ckey. Callback
	if(M.ckey in req_one_ckey)
		return 1	//Ckey is in the list, let them pass.
	if(LAZYLEN(req_access) || LAZYLEN(req_one_access))
		return ..(M)//If the door has normal acces requirements, check those too; even if they aren't on the ckey list. Allows for master door keys and the likes.
	return 0		//Otherwise, deny access.

/obj/machinery/door/airlock/ckey/highsecurity/tox
	req_one_ckey = list("seermankhajiit00", "darknova92", "deadwolf411", "kathrinbailey")

/obj/machinery/door/airlock/ckey/allowed(mob/M)
	if(locked)
		return 0
	if(!LAZYLEN(req_one_ckey) || !M.ckey)
		return ..(M)//No ckey list or no ckey. Callback
	if(M.ckey in req_one_ckey)
		return 1	//Ckey is in the list, let them pass.
	if(LAZYLEN(req_access) || LAZYLEN(req_one_access))
		return ..(M)//If the door has normal acces requirements, check those too; even if they aren't on the ckey list. Allows for master door keys and the likes.
	return 0		//Otherwise, deny access.
