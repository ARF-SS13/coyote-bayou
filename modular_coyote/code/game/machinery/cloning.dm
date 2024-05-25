/obj/machinery/clonepod/advanced

/obj/machinery/clonepod/advanced/Initialize()
	. = ..()
	for(var/obj/item/stock_parts/scanning_module/S in component_parts)
		component_parts.Remove(S)
		component_parts.Add(new /obj/item/stock_parts/scanning_module/adv)
	for(var/obj/item/stock_parts/manipulator/P in component_parts)
		component_parts.Remove(P)
		component_parts.Add(new /obj/item/stock_parts/manipulator/nano)
	RefreshParts()


/obj/machinery/clonepod/superior

/obj/machinery/clonepod/superior/Initialize()
	. = ..()
	for(var/obj/item/stock_parts/scanning_module/S in component_parts)
		component_parts.Remove(S)
		component_parts.Add(new /obj/item/stock_parts/scanning_module/phasic)
	for(var/obj/item/stock_parts/manipulator/P in component_parts)
		component_parts.Remove(P)
		component_parts.Add(new /obj/item/stock_parts/manipulator/pico)
	RefreshParts()


/obj/machinery/clonepod/supreme

/obj/machinery/clonepod/supreme/Initialize()
	. = ..()
	for(var/obj/item/stock_parts/scanning_module/S in component_parts)
		component_parts.Remove(S)
		component_parts.Add(new /obj/item/stock_parts/scanning_module/triphasic)
	for(var/obj/item/stock_parts/manipulator/P in component_parts)
		component_parts.Remove(P)
		component_parts.Add(new /obj/item/stock_parts/manipulator/femto)
	RefreshParts()
