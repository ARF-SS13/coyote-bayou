// Special AI/pAI PDAs that cannot explode.
/obj/item/pda/ai
	icon = null
	ttone = "data"
	fon = FALSE
	detonatable = FALSE

/obj/item/pda/ai/pai
	ttone = "assist"

/obj/item/pda/medical
	name = "medical PDA"
	default_cartridge = /obj/item/cartridge/medical
	icon_state = "pda-medical"
	skindex = "Medical PDA"

/obj/item/pda/viro
	name = "virology PDA"
	default_cartridge = /obj/item/cartridge/medical
	icon_state = "pda-virology"
	skindex = "Virology PDA"

/obj/item/pda/engineering
	name = "engineering PDA"
	default_cartridge = /obj/item/cartridge/engineering
	icon_state = "pda-engineer"
	skindex = "Engineering PDA"

/obj/item/pda/security
	name = "security PDA"
	//default_cartridge = /obj/item/cartridge/security
	icon_state = "pda-security"
	skindex = "Security PDA"

/obj/item/pda/detective
	name = "detective PDA"
	//default_cartridge = /obj/item/cartridge/detective
	icon_state = "pda-detective"
	skindex = "Detective PDA"

/obj/item/pda/warden
	name = "warden PDA"
	default_cartridge = /obj/item/cartridge/security
	icon_state = "pda-warden"
	skindex = "Warden PDA"

/obj/item/pda/janitor
	name = "janitor PDA"
	default_cartridge = /obj/item/cartridge/janitor
	icon_state = "pda-janitor"
	ttone = "slip"
	skindex = "Janitor PDA"

/obj/item/pda/toxins
	name = "scientist PDA"
	default_cartridge = /obj/item/cartridge/signal/toxins
	icon_state = "pda-science"
	ttone = "boom"
	skindex = "Scientist PDA"

/obj/item/pda/heads
	default_cartridge = /obj/item/cartridge/head
	icon_state = "pda-hop"
	skindex = "Head of Personnel PDA"

/obj/item/pda/heads/hop
	name = "head of personnel PDA"
	default_cartridge = /obj/item/cartridge/hop
	icon_state = "pda-hop"
	skindex = "Head of Personnel PDA"

/obj/item/pda/heads/hos
	name = "head of security PDA"
	//default_cartridge = /obj/item/cartridge/hos
	icon_state = "pda-hos"
	skindex = "Head of Security PDA"

/obj/item/pda/heads/ce
	name = "chief engineer PDA"
	default_cartridge = /obj/item/cartridge/ce
	icon_state = "pda-ce"
	skindex = "Chief Engineer PDA"

/obj/item/pda/heads/cmo
	name = "chief medical officer PDA"
	default_cartridge = /obj/item/cartridge/cmo
	icon_state = "pda-cmo"
	skindex = "Chief Medical Officer PDA"

/obj/item/pda/heads/rd
	name = "research director PDA"
	default_cartridge = /obj/item/cartridge/rd
	inserted_item = /obj/item/pen/fourcolor
	icon_state = "pda-rd"
	skindex = "Research Director PDA"

/obj/item/pda/captain
	name = "captain PDA"
	default_cartridge = /obj/item/cartridge/captain
	inserted_item = /obj/item/pen/fountain/captain
	icon_state = "pda-captain"
	detonatable = FALSE
	skindex = "Captain PDA"

/obj/item/pda/lieutenant
	name = "lieutenant PDA"
	default_cartridge = /obj/item/cartridge/captain
	inserted_item = /obj/item/pen/fountain/captain
	icon_state = "pda-lieutenant"
	ttone = "bwoink"
	detonatable = FALSE
	hidden = TRUE
	note = "Congratulations, you have chosen the RobCo Pip-Boy 3000 Personal Information Processor Prestige Edition! To help with navigation, we have provided the following definitions. North, South, West, East."
	skindex = "Lieutenant PDA"

/obj/item/pda/cargo
	name = "cargo technician PDA"
	default_cartridge = /obj/item/cartridge/quartermaster
	icon_state = "pda-cargo"
	skindex = "Cargo Technician PDA"

/obj/item/pda/quartermaster
	name = "quartermaster PDA"
	default_cartridge = /obj/item/cartridge/quartermaster
	inserted_item = /obj/item/pen/fountain
	icon_state = "pda-qm"
	skindex = "Quartermaster PDA"

/obj/item/pda/shaftminer
	name = "shaft miner PDA"
	icon_state = "pda-miner"
	skindex = "Shaft Miner PDA"

/obj/item/pda/syndicate
	default_cartridge = /obj/item/cartridge/virus/syndicate
	icon_state = "pda-syndi"
	name = "military PDA"
	owner = "John Doe"
	hidden = 1
	skindex = "Military PDA"

/obj/item/pda/chaplain
	name = "chaplain PDA"
	icon_state = "pda-chaplain"
	ttone = "holy"
	skindex = "Chaplain PDA"

/obj/item/pda/lawyer
	name = "lawyer PDA"
	default_cartridge = /obj/item/cartridge/lawyer
	inserted_item = /obj/item/pen/fountain
	icon_state = "pda-lawyer"
	ttone = "objection"
	skindex = "Lawyer PDA"

/obj/item/pda/botanist
	name = "botanist PDA"
	//default_cartridge = /obj/item/cartridge/botanist
	icon_state = "pda-hydro"
	skindex = "Botanist PDA"

/obj/item/pda/roboticist
	name = "roboticist PDA"
	icon_state = "pda-roboticist"
	default_cartridge = /obj/item/cartridge/roboticist
	skindex = "Roboticist PDA"

/obj/item/pda/curator
	name = "curator PDA"
	icon_state = "pda-library"
	desc = "A portable microcomputer by RobCo Industries. This model is a WGW-11 series e-reader."
	note = "Congratulations, your Vault has chosen the RobCo Pip-Boy 3000 E-reader and Personal Information Processor! To help with navigation, we have provided the following definitions. North, South, West, East."
	silent = TRUE //Quiet in the library!
	// current_overlays = list("pda-r-library","blank","id_overlay","insert_overlay", "light_overlay", "pai_overlay")
	// default_cartridge = /obj/item/cartridge/curator
	// inserted_item = /obj/item/pen/fountain
	// overlays_offsets = list('icons/obj/pda.dmi' = list(-3,0))
	// overlays_x_offset = -3
	skindex = "Curator PDA"

/obj/item/pda/clear
	name = "clear PDA"
	icon_state = "pda-clear"
	desc = "A portable microcomputer by RobCo Industries. This model is a special edition with a transparent case."
	note = "Congratulations, your Vault has chosen the RobCo Pip-Boy 3000 Personal Information Processor Deluxe Special Max Turbo Limited Edition! To help with navigation, we have provided the following definitions. North, South, West, East."
	skindex = "Clear PDA"

/obj/item/pda/neko
	name = "neko PDA"
	icon_state = "pda-neko"
	// overlays_icons = list('icons/obj/pda_alt.dmi' = list("pda-r", "screen_neko", "id_overlay", "insert_overlay", "light_overlay", "pai_overlay"))
	desc = "A portable microcomputer by RobCo Industries. This model is a special feline edition."
	note = "Congratulations, your Vault has chosen the RobCo Pip-Boy 3000 Personal Information Processor Deluxe Special Max Turbo Limited Edition NYA~!  To help with navigation, we have provided the following definitions. North, South, West, East."
	skindex = "Neko PDA"

/obj/item/pda/cook
	name = "cook PDA"
	icon_state = "pda-cook"
	skindex = "Cook PDA"

/obj/item/pda/bar
	name = "bartender PDA"
	icon_state = "pda-bartender"
	inserted_item = /obj/item/pen/fountain
	skindex = "Bartender PDA"

/obj/item/pda/atmos
	name = "atmospherics PDA"
	default_cartridge = /obj/item/cartridge/atmos
	icon_state = "pda-atmos"
	skindex = "Atmospherics PDA"

/obj/item/pda/chemist
	name = "chemist PDA"
	default_cartridge = /obj/item/cartridge/chemistry
	icon_state = "pda-chemistry"
	skindex = "Chemist PDA"

/obj/item/pda/geneticist
	name = "geneticist PDA"
	default_cartridge = /obj/item/cartridge/medical
	icon_state = "pda-genetics"
	skindex = "Geneticist PDA"

/obj/item/pda/teachboy
	name = "refurbished Teach-Boy 2000"
	desc = "A portable microcomputer by RobCo Industries. This model is a EDU-2 series educational device- or atleast that's what you can make from the rusty tin case with wires jammed into it- someone's repaired this thing."
	icon_state = "pda-teachboy-unfolded"
	inserted_item = /obj/item/pen/charcoal
	skindex = "Teachboy PDA"

