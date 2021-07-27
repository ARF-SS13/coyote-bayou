/datum/wires/taperecorder
	holder_type = /obj/item/taperecorder
	proper_name = "Universal Recorder"
	req_knowledge = JOB_SKILL_TRAINED
	req_skill = JOB_SKILL_UNTRAINED

/datum/wires/taperecorder/New(atom/holder)
	wires = list(
		WIRE_RECORD,
		WIRE_STOP, WIRE_PLAY
	)
	return ..()

/datum/wires/taperecorder/interactable(mob/user)
	var/obj/item/taperecorder/recorder = holder
	if(recorder.panel_open)
		return TRUE
	return FALSE

/datum/wires/taperecorder/on_pulse(wire)
	var/obj/item/taperecorder/recorder = holder
	switch(wire)
		if(WIRE_RECORD)
			recorder.record()
		if(WIRE_STOP)
			recorder.stop()
		if(WIRE_PLAY)
			recorder.play()

