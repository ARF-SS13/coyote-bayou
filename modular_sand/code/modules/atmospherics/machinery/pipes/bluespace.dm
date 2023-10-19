/obj/machinery/atmospherics/pipe/bluespace/attackby(obj/item/W, mob/user, params)
	var/old_net = bluespace_network_name
	if(W.tool_behaviour == TOOL_MULTITOOL)
		var/new_name = input(user, "Enter identifier for bluespace pipe network", "bluespace pipe", bluespace_network_name) as text|null
		if(!isnull(new_name))
			bluespace_network_name = new_name
			update_net(old_net)
	else
		return ..()

/obj/machinery/atmospherics/pipe/bluespace/proc/update_net(net)
	if(GLOB.bluespace_pipe_networks[net])
		GLOB.bluespace_pipe_networks[net] -= src
		for(var/p in GLOB.bluespace_pipe_networks[bluespace_network_name])
			var/obj/machinery/atmospherics/pipe/bluespace/P = p
			QDEL_NULL(P.parent)
			P.build_network()
	if(bluespace_network_name)
		if(!GLOB.bluespace_pipe_networks[bluespace_network_name])
			GLOB.bluespace_pipe_networks[bluespace_network_name] = list()
		GLOB.bluespace_pipe_networks[bluespace_network_name] |= src
