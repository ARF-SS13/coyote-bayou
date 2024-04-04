/******************************
	UPGRADE TYPES
******************************/
// 	 REINFORCEMENT: REDUCES TOOL DEGRADATION
//------------------------------------------------

//Heatsink can be attached to any tool that uses fuel or power
/obj/item/tool_upgrade/reinforcement/heatsink
	name = "heatsink"
	desc = "An array of titanium fins which dissipates heat, reducing damage and extending the lifespan of power tools or improving energy weapon cooling."
	icon_state = "heatsink"

/obj/item/tool_upgrade/reinforcement/heatsink/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	/*I.tool_upgrades = list(
		UPGRADE_DEGRADATION_MULT = 0.65,
		UPGRADE_HEALTH_THRESHOLD = 10
		)*/
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-15,-40) * 0.01, 
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(15,40) * 0.01,
		UPGRADE_BULK = 1
	)
	I.prefix = "heatsunk"
	I.req_fuel_cell = REQ_FUEL_OR_CELL
	I.gun_loc_tag = GUN_MECHANISM
	I.req_gun_tags = list(GUN_ENERGY)

/obj/item/tool_upgrade/reinforcement/guard
	name = "metal guard"
	desc = "A bent piece of metal that wraps around sensitive parts of a tool, protecting it from impacts, debris, and stray fingers. Could be added to the back of a gun to help stablize it as well."
	icon_state = "guard"

/obj/item/tool_upgrade/reinforcement/guard/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(15,30) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(-15,-30) * 0.01
	)
	//I.required_qualities = list(QUALITY_CUTTING,QUALITY_DRILLING, QUALITY_SAWING, QUALITY_DIGGING, QUALITY_EXCAVATION, QUALITY_WELDING, QUALITY_HAMMERING)
	I.prefix = "shielded"

// Heat disperser can be attached to any tool that uses fuel or power
/obj/item/tool_upgrade/reinforcement/plasmablock
	name = "Jet coolant radiator"
	desc = "A haphazardly crafted radiator with coils filled with jet coolant wrapped around it."
	icon_state = "plasmablock"

/obj/item/tool_upgrade/reinforcement/plasmablock/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	/*I.tool_upgrades = list(
		UPGRADE_DEGRADATION_MULT = 0.45,
		UPGRADE_HEALTH_THRESHOLD = 10,
		UPGRADE_POWERCOST_MULT = 1.05,
		UPGRADE_FUELCOST_MULT = 1.05
		)*/
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-25,-45) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(30,60) * 0.01
	)
	I.prefix = "plasma-cooled"
	I.req_fuel_cell = REQ_FUEL_OR_CELL
	I.gun_loc_tag = GUN_MECHANISM
	I.req_gun_tags = list(GUN_ENERGY)

// 	 PRODUCTIVITY: INCREASES WORKSPEED
//------------------------------------------------
/obj/item/tool_upgrade/productivity/ergonomic_grip
	name = "ergonomic grip"
	desc = "A replacement grip for a tool or gun which allows it to be more precisely controlled with one hand."
	icon_state = "ergonomic"

/obj/item/tool_upgrade/productivity/ergonomic_grip/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	/*I.tool_upgrades = list(
	UPGRADE_WORKSPEED = 0.15
	)*/
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(-15,-40) * 0.01
	)
	I.gun_loc_tag = GUN_GRIP
	//I.required_qualities = list(QUALITY_BOLT_TURNING, QUALITY_PULSING, QUALITY_PRYING, QUALITY_WELDING, QUALITY_SCREW_DRIVING, QUALITY_WIRE_CUTTING, QUALITY_SHOVELING, QUALITY_DIGGING, QUALITY_EXCAVATION, QUALITY_CLAMPING, QUALITY_CAUTERIZING, QUALITY_RETRACTING, QUALITY_DRILLING, QUALITY_HAMMERING, QUALITY_SAWING, QUALITY_CUTTING, QUALITY_WEAVING)
	I.prefix = "ergonomic"

//Enhances power tools majorly, but also increases costs
/obj/item/tool_upgrade/productivity/motor
	name = "high power motor"
	desc = "A motor for power tools with a higher horsepower than usually expected. Significantly enhances productivity and lifespan, but more expensive to run and harder to control."
	icon_state = "motor"

/obj/item/tool_upgrade/productivity/motor/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	/*I.tool_upgrades = list(
	UPGRADE_WORKSPEED = 0.5,
	UPGRADE_FORCE_MULT = 1.15,
	UPGRADE_DEGRADATION_MULT = 1.15,
	UPGRADE_POWERCOST_MULT = 1.35,
	UPGRADE_FUELCOST_MULT = 1.35,
	UPGRADE_PRECISION = -10,
	UPGRADE_HEALTH_THRESHOLD = -10
	)*/
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(35,60) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(35,60) * 0.01,
		//GUN_UPGRADE_DAMAGE_MULT = 1.15,
		GUN_UPGRADE_PEN_MULT=1 + rand(10,30) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-18,-50) * 0.01, // 55 / 2 = 27.5 but I don't know if it'll break because it saw a decimal
		GUN_UPGRADE_MUZZLEFLASH=1 + rand(35,60) * 0.01,
	/*	GUN_UPGRADE_CHARGECOST = 1.25,	*/
		UPGRADE_BULK = 1
	)
	//I.required_qualities = list(QUALITY_SCREW_DRIVING, QUALITY_DRILLING, QUALITY_SAWING, QUALITY_DIGGING, QUALITY_EXCAVATION, QUALITY_HAMMERING)
	I.prefix = "high-power"
	I.req_fuel_cell = REQ_FUEL_OR_CELL
	I.req_gun_tags = list(GUN_ENERGY)
	I.gun_loc_tag = GUN_MECHANISM
/*
/obj/item/tool_upgrade/productivity/antistaining
	name = "anti-staining paint"
	desc = "Applying a thin coat of this paint on a tool prevents blood stains, dirt or dust to adhere to its surface. Everyone works better and faster with clean tools. Once applied, it can't ever be stripped."
	icon_state = "antistaining"
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 2, MATERIAL_PLASMA = 3)
	can_remove = FALSE
	price_tag = 180

/obj/item/tool_upgrade/productivity/antistaining/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.tool_upgrades = list(
	UPGRADE_WORKSPEED = 0.30,
	UPGRADE_PRECISION = 5,
	UPGRADE_ITEMFLAGPLUS = NOBLOODY
	)
	I.prefix = "anti-stain coated"
*/
/obj/item/tool_upgrade/productivity/booster
	name = "booster"
	desc = "When you do not care about energy comsumption and just want to get shit done quickly. This device shunts the power safeties of your tool whether it uses fuel or electricity."
	icon_state = "booster"

/obj/item/tool_upgrade/productivity/booster/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	/*I.tool_upgrades = list(
	UPGRADE_WORKSPEED = 0.35,
	UPGRADE_DEGRADATION_MULT = 1.15,
	UPGRADE_POWERCOST_MULT = 1.25,
	UPGRADE_FUELCOST_MULT = 1.25
	)*/
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(7,20) * 0.01, // halving 
		GUN_UPGRADE_RECOIL_1H=1 + rand(80,120) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(10,35) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(15,25) * 0.01
	)
	I.prefix = "boosted"
	I.req_fuel_cell = REQ_FUEL_OR_CELL
	I.gun_loc_tag = GUN_MECHANISM
	I.req_gun_tags = list(GUN_ENERGY)
// 	 REFINEMENT: INCREASES PRECISION
//------------------------------------------------
/obj/item/tool_upgrade/refinement/laserguide
	name = "Makeshift laser guide"
	desc = "A small laser pointer with duct tape to attach to any tool, giving an accurate representation of its target. Helps improve precision."
	icon_state = "laser_guide"

/obj/item/tool_upgrade/refinement/laserguide/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	/*I.tool_upgrades = list(
		UPGRADE_PRECISION = 10
	)*/
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(-20,-40) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(-5,-20) * 0.01
	)
	I.gun_loc_tag = GUN_UNDERBARREL
	I.prefix = "laser-guided"



//Fits onto generally small tools that require precision, especially surgical tools
//Doesn't work onlarger things like crowbars and drills
/obj/item/tool_upgrade/refinement/stabilized_grip
	name = "gyrostabilized grip"
	desc = "A fancy Pre-war mechanical grip employed by the US Army that partially floats around a tool, absorbing tremors and shocks. Allows precise work with a shaky hand."
	icon_state = "stabilizing"

/obj/item/tool_upgrade/refinement/stabilized_grip/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	/*I.tool_upgrades = list(
		UPGRADE_PRECISION = 10,
		UPGRADE_HEALTH_THRESHOLD = 10
	)*/
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(-5,-20) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(-20,-40) * 0.01
	)
	I.gun_loc_tag = GUN_GRIP
	//I.required_qualities = list(QUALITY_CUTTING,QUALITY_WIRE_CUTTING, QUALITY_SCREW_DRIVING, QUALITY_WELDING,QUALITY_PULSING, QUALITY_CLAMPING, QUALITY_CAUTERIZING, QUALITY_BONE_SETTING, QUALITY_LASER_CUTTING, QUALITY_SHOVELING, QUALITY_DIGGING, QUALITY_WEAVING)
	I.prefix = "stabilized"
/*
/obj/item/tool_upgrade/refinement/magbit
	name = "magnetic bit"
	desc = "Magnetises tools used for handling small objects, reducing instances of dropping screws and bolts."
	icon_state = "magnetic"
	matter = list(MATERIAL_STEEL = 2, MATERIAL_PLASTEEL = 2)
	price_tag = 100

/obj/item/tool_upgrade/refinement/magbit/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.tool_upgrades = list(
	UPGRADE_PRECISION = 10
	)
	I.required_qualities = list(QUALITY_SCREW_DRIVING, QUALITY_BOLT_TURNING, QUALITY_CLAMPING, QUALITY_BONE_SETTING, QUALITY_PULSING, QUALITY_SHOVELING, QUALITY_DIGGING)
	I.prefix = "magnetic"
*/
/obj/item/tool_upgrade/refinement/ported_barrel
	name = "ported barrel"
	desc = "A barrel extension for a welding tool (or gun) which helps manage gas pressure and keep the torch (or barrel) steady. When attached to a gun it allows for greater recoil control and a smaller flash at the cost of stopping power."
	icon_state = "ported_barrel"

/obj/item/tool_upgrade/refinement/ported_barrel/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	/*I.tool_upgrades = list(
	UPGRADE_PRECISION = 12,
	UPGRADE_DEGRADATION_MULT = 1.15,
	UPGRADE_BULK = 1,
	UPGRADE_HEALTH_THRESHOLD = 10
	)*/
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-15,-35) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-5,-15) * 0.01,
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(-4,-18) * 0.01,
		GUN_UPGRADE_MUZZLEFLASH=1 + rand(-15,-40) * 0.01,
		GUN_UPGRADE_RECOIL_1H=1 + rand(-5,-20) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(-5,-35) * 0.01
	)
	I.req_gun_tags = list(GUN_PROJECTILE)
	I.gun_loc_tag = GUN_MUZZLE
	//I.required_qualities = list(QUALITY_WELDING)
	I.prefix = "ported"

/obj/item/tool_upgrade/refinement/vibcompensator
	name = "vibration compensator"
	desc = "A ground-breaking innovation that dampens the vibration of a tool or gun by emitting sound waves in a frequency nobody can hear. It bears the logo of a certain \"Big MT\", whatever that is."
	icon_state = "vibcompensator"

/obj/item/tool_upgrade/refinement/vibcompensator/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	/*I.tool_upgrades = list(
	UPGRADE_PRECISION = 15,
	UPGRADE_HEALTH_THRESHOLD = 5,
	UPGRADE_ITEMFLAGPLUS = SILENT
	)*/
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(-20,-40) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(-40,-60) * 0.01
	)
	I.gun_loc_tag = GUN_GRIP
	//I.required_qualities = list(QUALITY_CUTTING, QUALITY_WIRE_CUTTING, QUALITY_SCREW_DRIVING, QUALITY_WELDING ,QUALITY_PULSING, QUALITY_CLAMPING, QUALITY_CAUTERIZING, QUALITY_BONE_SETTING, QUALITY_LASER_CUTTING)
	I.prefix = "vibration-compensated"

// 		AUGMENTS: MISCELLANEOUS AND UTILITY
//------------------------------------------------

/obj/item/tool_upgrade/augment/ai_tool
	name = "Vault-Tec Integrated ZAX module"
	desc = "A forgotten miracle of computing, the Vault-Tec I-ZAX contains a miniaturized artificial intelligence ready to take over any tool or weapon, \
			extending hooks and wires to take control of whatever it's pushed against."
	icon_state = "ai_tool"

/obj/item/tool_upgrade/augment/ai_tool/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	/*I.tool_upgrades = list(
	UPGRADE_POWERCOST_MULT = 1.20,
	UPGRADE_PRECISION = 12,
	UPGRADE_WORKSPEED = 3,
	UPGRADE_HEALTH_THRESHOLD = -10,
	)*/
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(-5,-20) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(-5,-20) * 0.01,
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(11,21) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-7,-28) * 0.01,
		GUN_UPGRADE_MUZZLEFLASH=1 + rand(-5,-20) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(-21,-11) * 0.01
	)
	I.prefix = "intelligent"
	I.req_fuel_cell = null

// Paint: For Modifying specific traits
//_____________________________________

/obj/item/tool_upgrade/paint/red
	name = "red paint"
	desc = "Red paint increases the guns overall speed in its abilities, and magazine size, or makes it worse."
	icon_state = "paint_red"

/obj/item/tool_upgrade/paint/red/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-35,10) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-15,50) * 0.01,
		UPGRADE_COLOR = "#FF4444"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "red"

/obj/item/tool_upgrade/paint/blue
	name = "blue paint"
	desc = "Blue paint reduces recoil and increases ricochet, while also reducing charge cost of a laser gun, or makes it worse."
	icon_state = "blue_paint"

/obj/item/tool_upgrade/paint/blue/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H=1 + rand(-40,25) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(-28,17) * 0.01,
		GUN_UPGRADE_RICO_MULT=1 + rand(-40,25) * 0.01,
		UPGRADE_COLOR = "#00356b"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "blue"

/obj/item/tool_upgrade/paint/yellow
	name = "yellow paint"
	desc = "Yellow paint reduces movement delay and recoil, while increasing gun damage, or makes them worse."
	icon_state = "yellow_paint"

/obj/item/tool_upgrade/paint/yellow/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_MOVE_DELAY_MULT=1 + rand(-70,-50) * 0.01,
		GUN_UPGRADE_RECOIL_1H=1 + rand(-40,25) * 0.01,
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(-20,34) * 0.01,
		UPGRADE_COLOR = "#FFFF00"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "yellow"

/obj/item/tool_upgrade/paint/orange //red + yellow
	name = "orange paint"
	desc = "Orange paint combines the effects of red and yellow for a more pronounced paint quality."
	icon_state = "orange_paint"

/obj/item/tool_upgrade/paint/orange/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-40,5) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-10,55) * 0.01,
		GUN_UPGRADE_MOVE_DELAY_MULT=1 + rand(-75,-55) * 0.01,
		GUN_UPGRADE_RECOIL_1H=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(-14,40) * 0.01,
		UPGRADE_COLOR = "#FFA500"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "orange"

/obj/item/tool_upgrade/paint/purple //blue + red
	name = "purple paint"
	desc = " Purple paint combines the effects of red and blue for a more pronounced paint quality."
	icon_state = "violet_paint"

/obj/item/tool_upgrade/paint/purple/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-40,5) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-10,55) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(-35,10) * 0.01,
		GUN_UPGRADE_RICO_MULT=1 + rand(-45,20) * 0.01,
		UPGRADE_COLOR = "#8F00FF"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "purple"

/obj/item/tool_upgrade/paint/green //yellow + blue
	name = "green paint"
	desc = " Green paint combines the effects of blue and yellow for a more pronounced paint quality."
	icon_state = "green_paint"

/obj/item/tool_upgrade/paint/green/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(-35,10) * 0.01,
		GUN_UPGRADE_RICO_MULT=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-40,5) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-10,55) * 0.01,
		UPGRADE_COLOR = "#007958"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "green"

/obj/item/tool_upgrade/paint/black //yellow + blue + red
	name = "black paint"
	desc = "A combination of all three main colors. This makes a paint that has a maximized chance of being perfect."
	icon_state = "black_paint"

/obj/item/tool_upgrade/paint/black/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(-35,10) * 0.01,
		GUN_UPGRADE_RICO_MULT=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-40,5) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-10,55) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-40,5) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-10,55) * 0.01,
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(-10,44) * 0.01,
		UPGRADE_COLOR = "#000000"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "black"
