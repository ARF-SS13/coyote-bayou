/// component that, if something is dropped, it'll stick itself back into its home container
/// if the container no longer exists, cease to exist too
/datum/component/storage_bound
	var/obj/item/storage/home

/datum/component/storage_bound/Initialize(obj/item/storage/home)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	var/obj/item/master = parent
	if(isitem(home))
		src.home = home
	else if(SEND_SIGNAL(master.loc, COMSIG_CONTAINS_STORAGE))
		src.home = master.loc
	else
		return COMPONENT_INCOMPATIBLE
	if(master.loc != home)
		SEND_SIGNAL(home, COMSIG_TRY_STORAGE_INSERT, master, null, FALSE, TRUE)
	RegisterSignal(parent, COMSIG_ITEM_DROPPED, .proc/on_drop)

/datum/component/storage_bound/proc/on_drop()
	var/obj/item/master = parent
	if(!home || QDELETED(home))
		qdel(master)
		return
	SEND_SIGNAL(home, COMSIG_TRY_STORAGE_INSERT, master, null, FALSE, TRUE)
	if(master.loc != home)
		master.forceMove(home)
		if(master.loc != home)
			stack_trace("Storage bound item [master] failed to move to home [home]")
			qdel(master)




