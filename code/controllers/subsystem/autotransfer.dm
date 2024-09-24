#define NO_MAXVOTES_CAP -1

SUBSYSTEM_DEF(autotransfer)
	name = "Autotransfer Vote"
	flags = SS_KEEP_TIMING | SS_BACKGROUND
	wait = 1 MINUTES

	var/starttime
	var/targettime = 23.8 HOURS
	var/voteinterval
	var/maxvotes
	var/curvotes = 0
	var/allow_vote_restart = FALSE
	var/allow_vote_transfer = FALSE
	var/min_end_vote_time = INFINITY // lol

	var/use_config = FALSE // if TRUE, use config values instead of the above - cus fuck the config

/datum/controller/subsystem/autotransfer/Initialize(timeofday)
	// hi I'm Dan and I say fuck the config
	if(use_config)
		read_config()
	return ..()

/datum/controller/subsystem/autotransfer/proc/read_config()
	var/init_vote = CONFIG_GET(number/vote_autotransfer_initial)
	if(!init_vote) //Autotransfer voting disabled.
		return
	starttime = world.time
	targettime = starttime + init_vote
	voteinterval = CONFIG_GET(number/vote_autotransfer_interval)
	maxvotes = CONFIG_GET(number/vote_autotransfer_maximum)


/datum/controller/subsystem/autotransfer/Recover()
	starttime = SSautotransfer.starttime
	voteinterval = SSautotransfer.voteinterval
	curvotes = SSautotransfer.curvotes

/datum/controller/subsystem/autotransfer/fire()
	if(world.time < targettime)
		return
	// if(maxvotes == NO_MAXVOTES_CAP || maxvotes > curvotes)
	// 	SSvote.initiate_vote("transfer","server")
	// 	targettime = targettime + voteinterval
	// 	curvotes++
	// else
	SSshuttle.autoEnd()

#undef NO_MAXVOTES_CAP
