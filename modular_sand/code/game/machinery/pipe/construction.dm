/obj/item/pipe/bluespace/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_MULTITOOL)
		var/new_name = input(user, "Enter identifier for bluespace pipe network", "bluespace pipe", bluespace_network_name) as text|null
		if(!isnull(new_name))
			bluespace_network_name = new_name
	else
		return ..()

/obj/item/pipe/bluespace/directional
	RPD_type = PIPE_UNARY
