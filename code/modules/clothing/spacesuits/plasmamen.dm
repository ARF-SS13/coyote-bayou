//Suits for the pink and grey skeletons! //EVA version no longer used in favor of the Jumpsuit version


/obj/item/clothing/suit/space/eva/plasmaman
	name = "EVA plasma envirosuit"
	desc = "A special plasma containment suit designed to be space-worthy, as well as worn over other clothing. Like its smaller counterpart, it can automatically extinguish the wearer in a crisis, and holds twice as many charges."
	allowed = list(/obj/item/gun, /obj/item/ammo_casing, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/plasmacutter/sword, /obj/item/restraints/handcuffs, /obj/item/tank)
	resistance_flags = FIRE_PROOF
	icon_state = "plasmaman_suit"
	inhand_icon_state = "plasmaman_suit"
	var/next_extinguish = 0
	var/extinguish_cooldown = 100
	var/extinguishes_left = 10

/obj/item/clothing/suit/space/eva/plasmaman/examine(mob/user)
	. = ..()
	. += span_notice("There [extinguishes_left == 1 ? "is" : "are"] [extinguishes_left] extinguisher charge\s left in this suit.")


/obj/item/clothing/suit/space/eva/plasmaman/proc/Extinguish(mob/living/carbon/human/H)
	if(!istype(H))
		return

	if(H.fire_stacks)
		if(extinguishes_left)
			if(next_extinguish > world.time)
				return
			next_extinguish = world.time + extinguish_cooldown
			extinguishes_left--
			H.visible_message(span_warning("[H]'s suit automatically extinguishes [H.p_them()]!"),span_warning("Your suit automatically extinguishes you."))
			H.ExtinguishMob()
			new /obj/effect/particle_effect/water(get_turf(H))


//I just want the light feature of the hardsuit helmet
/obj/item/clothing/head/helmet/space/plasmaman
	name = "plasma envirosuit helmet"
	desc = "A special containment helmet that allows plasma-based lifeforms to exist safely in an oxygenated environment. It is space-worthy, and may be worn in tandem with other EVA gear."
	icon_state = "plasmaman-helm"
	inhand_icon_state = "plasmaman-helm"
	strip_delay = 80
	resistance_flags = FIRE_PROOF
	light_system = MOVABLE_LIGHT
	light_range = 4
	light_power = 0.8
	light_color = "#FFCC66"
	light_on = FALSE
	var/on = FALSE
	var/light_overlay = "envirohelm-light"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	mutantrace_variation = NONE

/obj/item/clothing/head/helmet/space/plasmaman/attack_self(mob/user)
	if(!light_overlay)
		return
	on = !on
	if(!on)
		cut_overlay(light_overlay)
	else
		add_overlay(light_overlay)
	user.update_inv_head() //So the mob overlay updates

	set_light_on(on)

	for(var/X in actions)
		var/datum/action/A=X
		A.UpdateButtonIcon()

/obj/item/clothing/head/helmet/space/plasmaman/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands && on)
		. += mutable_appearance(icon_file, light_overlay)

/obj/item/clothing/head/helmet/space/plasmaman/security
	name = "security plasma envirosuit helmet"
	desc = "A plasmaman containment helmet designed for security officers, protecting them from being flashed and burning alive, along-side other undesirables."
	icon_state = "security_envirohelm"
	inhand_icon_state = "security_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/security/warden
	name = "warden's plasma envirosuit helmet"
	desc = "A plasmaman containment helmet designed for the warden, a pair of white stripes being added to differeciate them from other members of security."
	icon_state = "warden_envirohelm"
	inhand_icon_state = "warden_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/security/hos
	name = "head of security's plasma envirosuit helmet"
	desc = "A plasmaman containment helmet designed for the head of security, manacing black with red stripes, to differenciate them from other members of security."
	icon_state = "hos_envirohelm"
	inhand_icon_state = "hos_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/medical
	name = "medical's plasma envirosuit helmet"
	desc = "An envirohelmet designed for plasmaman medical doctors, having two stripes down its length to denote as much."
	icon_state = "doctor_envirohelm"
	inhand_icon_state = "doctor_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/cmo
	name = "chief medical officer's plasma envirosuit helmet"
	desc = "A blue and white envirohelmet designed for the chief medical officer."
	icon_state = "cmo_envirohelm"
	inhand_icon_state = "cmo_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/genetics
	name = "geneticist's plasma envirosuit helmet"
	desc = "A plasmaman envirohelmet designed for geneticists."
	icon_state = "geneticist_envirohelm"
	inhand_icon_state = "geneticist_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/viro
	name = "virology plasma envirosuit helmet"
	desc = "The helmet worn by the safest people on the station, those who are completely immune to the monstrosities they create."
	icon_state = "virologist_envirohelm"
	inhand_icon_state = "virologist_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/chemist
	name = "chemistry plasma envirosuit helmet"
	desc = "A plasmaman envirosuit designed for chemists, two orange stripes going down its face."
	icon_state = "chemist_envirohelm"
	inhand_icon_state = "chemist_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/science
	name = "science plasma envirosuit helmet"
	desc = "A plasmaman envirohelmet designed for scientists."
	icon_state = "scientist_envirohelm"
	inhand_icon_state = "scientist_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/rd
	name = "research director's plasma envirosuit helmet"
	desc = "A sturdier plasmaman envirohelmet designed for research directors."
	icon_state = "rd_envirohelm"
	inhand_icon_state = "rd_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/robotics
	name = "robotics plasma envirosuit helmet"
	desc = "A plasmaman envirohelmet designed for roboticists."
	icon_state = "roboticist_envirohelm"
	inhand_icon_state = "roboticist_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/engineering
	name = "engineering plasma envirosuit helmet"
	desc = "A space-worthy helmet specially designed for engineer plasmamen, the usual purple stripes being replaced by engineering's orange."
	icon_state = "engineer_envirohelm"
	inhand_icon_state = "engineer_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/engineering/ce
	name = "chief engineer's plasma envirosuit helmet"
	desc = "A space-worthy helmet specially designed for the chief engineer, white with gold stripes designed for high visibility."
	icon_state = "ce_envirohelm"
	inhand_icon_state = "ce_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/atmospherics
	name = "atmospherics plasma envirosuit helmet"
	desc = "A space-worthy helmet specially designed for atmos technician plasmamen, the usual purple stripes being replaced by engineering's blue."
	icon_state = "atmos_envirohelm"
	inhand_icon_state = "atmos_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/cargo
	name = "cargo plasma envirosuit helmet"
	desc = "An plasmaman envirohelmet designed for cargo techs and quartermasters."
	icon_state = "cargo_envirohelm"
	inhand_icon_state = "cargo_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/mining
	name = "mining plasma envirosuit helmet"
	desc = "A khaki helmet given to plasmamen miners operating on lavaland."
	icon_state = "explorer_envirohelm"
	inhand_icon_state = "explorer_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/chaplain
	name = "chaplain's plasma envirosuit helmet"
	desc = "An envirohelmet specially designed for only the most pious of plasmamen."
	icon_state = "chap_envirohelm"
	inhand_icon_state = "chap_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/white
	name = "white plasma envirosuit helmet"
	desc = "A generic white envirohelm."
	icon_state = "white_envirohelm"
	inhand_icon_state = "white_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/hop
	name = "head of personell's plasma envirosuit helmet"
	desc = "A finely tailored azure envirohelm designed for head of personell."
	icon_state = "hop_envirohelm"
	inhand_icon_state = "hop_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/captain
	name = "captain's plasma envirosuit helmet"
	desc = "A blue and gold envirohelm designed for the station's captain, nonetheless. Made of superior materials to protect them from the station hazards and more."
	icon_state = "captain_envirohelm"
	inhand_icon_state = "captain_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/curator
	name = "curator's plasma envirosuit helmet"
	desc = "A slight modification on a tradiational voidsuit helmet, this helmet was Nano-Trasen's first solution to the *logistical problems* that come with employing plasmamen. Despite their limitations, these helmets still see use by historian and old-styled plasmamen alike."
	icon_state = "prototype_envirohelm"
	inhand_icon_state = "prototype_envirohelm"
	light_overlay = null
	actions_types = list()

/obj/item/clothing/head/helmet/space/plasmaman/botany
	name = "botany plasma envirosuit helmet"
	desc = "A green and blue envirohelmet designating its wearer as a botanist. While not specially designed for it, it would protect against minor planet-related injuries."
	icon_state = "botany_envirohelm"
	inhand_icon_state = "botany_envirohelm"

/obj/item/clothing/head/helmet/space/plasmaman/janitor
	name = "janitor's plasma envirosuit helmet"
	desc = "A grey helmet bearing a pair of purple stripes, designating the wearer as a janitor."
	icon_state = "janitor_envirohelm"
	inhand_icon_state = "janitor_envirohelm"
