/// processing subsystem for generating and ticking artifacts
/// Artifacts are basically diablo 2 style magic items
SUBSYSTEM_DEF(artifacts)
	name = "Artifacts"
	flags = SS_BACKGROUND|SS_NO_INIT
	wait = 1 SECONDS

	/// irradiated mobs, to be blasted with radiation every tick
	/// list("mob_whatever" = rad_level)
	var/list/irradiated_mobs = list()

/datum/controller/subsystem/artifacts/fire(resumed)
	

/datum/controller/subsystem/artifacts/fire(resumed)
	


