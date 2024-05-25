/// A component that brings up a horrible block of text when examined really closely
/datum/component/lore
	/// The lore to dump
	var/lore_file
	/// the name of the loredump window
	var/lore_name = "Lore Dump"
	COOLDOWN_DECLARE(lore_cooldown)
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/lore/Initialize()
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_PARENT_EXAMINE_MORE),PROC_REF(lore_dump))

/datum/component/lore/proc/lore_dump(datum/source, mob/reader)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src,PROC_REF(dump_lore), reader)

/datum/component/lore/proc/dump_lore(mob/reader)
	if(!reader)
		return
	if(!lore_file)
		return
	if(winexists(reader, "lore_dump"))
		return
	if(!COOLDOWN_FINISHED(src, lore_cooldown))
		return
	COOLDOWN_START(src, lore_cooldown, 10 SECONDS)
	winshow(reader, "lore_dump", TRUE)
	var/datum/browser/popup = new(reader, "lore_dump", "<div align='center'>[lore_name]</div>", 640, 480)
	popup.set_content("[file2text(lore_file)]")
	popup.open(FALSE)
	return TRUE

/datum/component/lore/martini_henry
	lore_file = 'strings/martini_henry.txt'
