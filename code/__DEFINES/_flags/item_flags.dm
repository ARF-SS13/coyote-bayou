// Flags for the item_flags var on /obj/item

#define BEING_REMOVED						(1<<0)
///is this item equipped into an inventory slot or hand of a mob? used for tooltips
#define IN_INVENTORY						(1<<1)
///used for tooltips
#define FORCE_STRING_OVERRIDE				(1<<2)
///Used by security bots to determine if this item is safe for public use.
#define NEEDS_PERMIT						(1<<3)
#define SLOWS_WHILE_IN_HAND					(1<<4)
///Stops you from putting things like an RCD or other items into an ORM or protolathe for materials.
#define NO_MAT_REDEMPTION					(1<<5)
///When dropped, it calls qdel on itself
#define DROPDEL								(1<<6)
///when an item has this it produces no "X has been hit by Y with Z" message in the default attackby()
#define NOBLUDGEON							(1<<7)
///for all things that are technically items but used for various different stuff
#define ABSTRACT							(1<<8)
///When players should not be able to change the slowdown of the item (Speed potions, ect)
#define IMMUTABLE_SLOW          			(1<<9)
///Tool commonly used for surgery: won't attack targets in an active surgical operation on help intent (in case of mistakes)
#define SURGICAL_TOOL						(1<<10)
///Can be worn on certain slots (currently belt and id) that would otherwise require an uniform.
#define NO_UNIFORM_REQUIRED					(1<<11)
///Damage when attacking people is not affected by combat mode.
#define NO_COMBAT_MODE_FORCE_MODIFIER		(1<<12)
/// This item can be used to parry. Only a basic check used to determine if we should proceed with parry chain at all.
#define ITEM_CAN_PARRY						(1<<13)
/// This item can be used in the directional blocking system. Only a basic check used to determine if we should proceed with directional block handling at all.
#define ITEM_CAN_BLOCK						(1<<14)
/// Thing is just your hand, and shouldnt block anything
#define HAND_ITEM							(1<<15)
/// Has this thing been run through a blender at least once?
#define BEEN_JUICED							(1<<16)

/// This thing was clicked on, and something said not to pick it up (cus its gonna do something cool)
#define ITEM_CLICKED_NOPICKUP				(1<<1)

// Flags for the clothing_flags var on /obj/item/clothing

#define LAVAPROTECT 			(1<<0)
#define STOPSPRESSUREDAMAGE		(1<<1)	//SUIT and HEAD items which stop pressure damage. To stop you taking all pressure damage you must have both a suit and head item with this flag.
#define BLOCK_GAS_SMOKE_EFFECT	(1<<2)	//blocks the effect that chemical clouds would have on a mob --glasses, mask and helmets ONLY!
#define ALLOWINTERNALS		  	(1<<3)	//mask allows internals
#define NOSLIP                  (1<<4)	//prevents from slipping on wet floors, in space etc
#define NOSLIP_ICE				(1<<5)	 //prevents from slipping on frozen floors
#define THICKMATERIAL			(1<<6)	//prevents syringes, parapens and hypos if the external suit or helmet (if targeting head) has this flag. Example: space suits, biosuit, bombsuits, thick suits that cover your body.
#define VOICEBOX_TOGGLABLE 		(1<<7)	//The voicebox in this clothing can be toggled.
#define VOICEBOX_DISABLED 		(1<<8)	//The voicebox is currently turned off.
#define IGNORE_HAT_TOSS			(1<<9)	//Hats with negative effects when worn (i.e the tinfoil hat).
#define SCAN_REAGENTS			(1<<10)	// Allows helmets and glasses to scan reagents.

// Flags for the organ_flags var on /obj/item/organ

#define ORGAN_SYNTHETIC			(1<<0)	//Synthetic organs, or cybernetic organs. Reacts to EMPs and don't deteriorate or heal
#define ORGAN_FROZEN			(1<<1)	//Frozen organs, don't deteriorate
#define ORGAN_FAILING			(1<<2)	//Failing organs perform damaging effects until replaced or fixed
#define ORGAN_EXTERNAL			(1<<3)	//Was this organ implanted/inserted/etc, if true will not be removed during species change.
#define ORGAN_VITAL				(1<<4)	//Currently only the brain
#define ORGAN_NO_SPOIL			(1<<5)	//Do not spoil under any circumstances
#define ORGAN_NO_DISMEMBERMENT	(1<<6)	//Immune to disembowelment.
#define ORGAN_EDIBLE			(1<<7)	//is a snack? :D

// hey can I just leave these here thanks
#define BLENDER_LINE_FULL "am_full"
#define BLENDER_LINE_FULL_SECOND "am_full2"
#define BLENDER_LINE_NOTHING_TO_PROCESS "nothing_to_blend"
#define BLENDER_LINE_PROCESSING "proccessing"
#define BLENDER_LINE_ROCKY_ABORT "abort"
#define BLENDER_LINE_SOFT_ABORT "turn_off"
#define BLENDER_LINE_DONE_BLENDING "done_blending"
#define BLENDER_LINE_GRINDFAIL "faileddd"
#define BLENDER_LINE_NO_RESERVOIR "my_sack_is_gone"
#define BLENDER_LINE_RAT_BLENDER "rat_in_a_blender"
#define BLENDER_LINE_CYBORG_PART "isborg"
#define BLENDER_LINE_DRY_FIRST "needry"
#define BLENDER_LINE_BATBOX_GONE "no_batbox"
#define BLENDER_LINE_BATBOX_ELSEWHERE "batbox_elsewhere"
#define BLENDER_LINE_BUFFER_GONE "no_buffer"
#define BLENDER_LINE_BUFFER_ELSEWHERE "buffer_elsewhere"
#define BLENDER_LINE_LOW_POWER "not_enuf_power"
#define BLENDER_LINE_PART_MISSING "missing_part"
#define BLENDER_LINE_NOTHING_TO_EJECT "cant_eject"
#define BLENDER_LINE_CANT_DROP_THING "cant_drop"
#define BLENDER_LINE_YEET "yeet"
#define BLENDER_LINE_DUMP "dumpeet"
#define BLENDER_LINE_CANT_CHANGE_WHILE_BLENDING "imworking"
#define BLENDER_LINE_SET_TO_DISPENSER "erectin"
#define BLENDER_LINE_SET_TO_GRINDER "grindin"
#define BLENDER_LINE_EXAMINE_EMPTY "out_of_stuff"
#define BLENDER_LINE_EXAMINE_PAPER_COOLDOWN "no_paper"
#define BLENDER_LINE_EXAMINE_OKAY "examining"
#define BLENDER_LINE_EJECT_BREVIN "brevout"
#define BLENDER_LINE_SWAP_BREVIN "brevswap"
#define BLENDER_LINE_INSERT_BREVIN "brevin"
#define BLENDER_LINE_BREVIN_FULL "brevull"
#define BLENDER_LINE_REAGENT_NOT_FOUND "reagent_missing"
#define BLENDER_LINE_STOP_RUNNING "stopnow"
#define BLENDER_LINE_NOT_RUNNING "notrunning"
#define BLENDER_LINE_GRIND_NOW "grindpls"
#define BLENDER_LINE_JUICE_NOW "juicepls"
#define BLENDER_LINE_ALREADY_BLENDER "am_blender"
#define BLENDER_LINE_ALREADY_DISPENSER "am_erect"
#define BLENDER_LINE_MUTE "shush"
#define BLENDER_LINE_UNMUTE "speak"
#define BLENDER_LINE_HIYA "heyo"
#define BLENDER_LINE_HIYA_AGAIN "heyoagan"
#define BLENDER_LINE_LOVE_ORLY "ilu"
#define BLENDER_LINE_HATE_ORLY "ihu"
#define BLENDER_LINE_PAIN_ORLY "ilp"
#define BLENDER_LINE_STUCK_INSIDE "dorkstiuck"

#define BLENDER_BLENDMODE_GRIND "grinding"
#define BLENDER_BLENDMODE_JUICE "juicing"
#define BLENDER_BELTMODE_GRINDER "grindmode"
#define BLENDER_BELTMODE_DISPENSER "dispenser"

#define CHARGER_LINE_FULL "am_full"
#define CHARGER_LINE_EMPTY "am_empty"
#define CHARGER_LINE_CHARGING "charging"
#define CHARGER_LINE_CHARGED "charged"
#define CHARGER_LINE_DISCHARGING "discharging"
#define CHARGER_LINE_DISCHARGED "discharged"
#define CHARGER_LINE_MODE_CHARGE "charge"
#define CHARGER_LINE_MODE_DISCHARGE "discharge"
#define CHARGER_LINE_NO_CAPACITOR "no_capacitor"
