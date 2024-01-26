GLOBAL_LIST_EMPTY(casing_sound_properties)


/* Sound properties for bulletstuffs!
 * HOW 2 USE
 * When these are all initialized, one instance of each will live in GLOB.casing_sound_properties, indexed by their 'category' var
 * From then on, they just chill there and hold their data, waiting to be referenced, like a handy lookup table
 * On an /obj/item/ammo_casing lives a var, sound_properties. This var should be something like CSP_PISTOL_LIGHT
 * This var points to an index of GLOB.casing_sound_properties, the one that specific type of casing should use
 * Once set, you're good! The gun/casing will handle everything else when it needs sound data
 * 
 * How *THIS* works
 * These datums just hold a bunch of sound-related data that is fed to the gun when it wants to play a shoot sound
 * That's about it, really
 * You can make more, easily too. Just make a new ammo_sound_properties entry, give it a unique CSP_AMMOTYPE define [code\__DEFINES\sound.dm]
 * Fill in the vars, and... that's it!
 * Currently this only works for casings, fired by ballistic guns. Energy weapons only use the distant sounds, as they are cursed af
 */
/datum/ammo_sound_properties
	/// its entry on the casing_sound_properties list, usually something like CSP_PISTOL_LIGHT. Check out code\__DEFINES\sound.dm for more~
	var/category = "oops"
	/// the sound the casing makes if the gun shooting it wants it
	var/list/shoot_sound = list('sound/f13weapons/9mm.ogg')
	/// the sound the casing makes if the gun shooting it wants it, and is silenced
	var/shoot_sound_silenced = list('sound/f13weapons/american180.ogg')
	/// How far away still plays the shoot sound?
	var/distance_close = PISTOL_LIGHT_RANGE
	/// How far away can this be heard if the gun shooting it is silenced?
	var/distance_silenced = PISTOL_LIGHT_RANGE
	/// The sound it makes when outside of the close distance
	var/distant_sound = PISTOL_LIGHT_DISTANT_SOUND
	/// Should the sound vary in pitch? Usually shouldnt
	var/vary = FALSE
	/// How loud is it?
	var/volume = PISTOL_LIGHT_VOLUME
	/// How quiet is it?
	var/volume_silenced = PISTOL_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER
	/// does the sound ignore walls? yes, yes it does. unless its silenced, then no
	var/ignore_walls = TRUE
	/// Override the gun's normal sound. currently unused
	var/override_gun_sound = FALSE

/datum/ammo_sound_properties/New(first_one)
	. = ..()
	if(first_one)
		set_up_sound_datums()

/// First one to exist makes everyone else exist
/datum/ammo_sound_properties/proc/set_up_sound_datums()
	GLOB.casing_sound_properties[category] = src
	for(var/some_sound in subtypesof(/datum/ammo_sound_properties))
		if(some_sound == type)
			continue
		var/datum/ammo_sound_properties/loadysound = new some_sound()
		GLOB.casing_sound_properties[loadysound.category] = loadysound

/// returns a list of vars
/datum/ammo_sound_properties/proc/shootlist(silenced)
	. = list()
	.[CSP_INDEX_SOUND_OUT] = silenced ? pick(shoot_sound_silenced) : pick(shoot_sound)
	.[CSP_INDEX_VARY] = vary
	.[CSP_INDEX_DISTANCE] = silenced ? distance_silenced : distance_close
	.[CSP_INDEX_VOLUME] = silenced ? volume_silenced : volume
	.[CSP_INDEX_IGNORE_WALLS] = silenced ? FALSE : ignore_walls
	.[CSP_INDEX_DISTANT_SOUND] = silenced ? null : distant_sound
	.[CSP_INDEX_DISTANT_RANGE] = silenced ? 0 : 300
	// I always thought .["thing"] always looked fancy and 'developer'
	// so I use them to feel like a real boy

/datum/ammo_sound_properties/light_pistol
	category = CSP_PISTOL_LIGHT
	shoot_sound = list('sound/f13weapons/9mm.ogg')
	distance_close = PISTOL_LIGHT_RANGE
	distance_silenced = PISTOL_LIGHT_RANGE
	distant_sound = PISTOL_LIGHT_DISTANT_SOUND
	vary = FALSE
	volume = PISTOL_LIGHT_VOLUME
	volume_silenced = PISTOL_LIGHT_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/light_pistol/m9mm
	category = CSP_PISTOL_9MM

/datum/ammo_sound_properties/light_pistol/c22
	category = CSP_PISTOL_22
	shoot_sound = list('sound/f13weapons/ServiceRifle.ogg')
	distance_close = RIFLE_LIGHT_RANGE
	distance_silenced = RIFLE_LIGHT_RANGE
	distant_sound = RIFLE_LIGHT_DISTANT_SOUND
	vary = FALSE
	volume = RIFLE_LIGHT_VOLUME
	volume_silenced = RIFLE_LIGHT_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/medium_pistol
	category = CSP_PISTOL_MEDIUM
	shoot_sound = list(
		'sound/f13weapons/10mm_fire_01.ogg',
		'sound/f13weapons/10mm_fire_02.ogg',
		'sound/f13weapons/10mm_fire_03.ogg',
		)
	distance_close = PISTOL_MEDIUM_RANGE
	distance_silenced = PISTOL_MEDIUM_RANGE
	distant_sound = PISTOL_MEDIUM_DISTANT_SOUND
	vary = FALSE
	volume = PISTOL_MEDIUM_VOLUME
	volume_silenced = PISTOL_MEDIUM_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/medium_pistol/m10mm
	category = CSP_PISTOL_10MM

/datum/ammo_sound_properties/medium_pistol/c45
	category = CSP_PISTOL_45
	shoot_sound = list('sound/f13weapons/45revolver.ogg')

/datum/ammo_sound_properties/heavy_pistol
	category = CSP_PISTOL_HEAVY
	shoot_sound = list('sound/f13weapons/magnum_fire.ogg')
	distance_close = PISTOL_HEAVY_RANGE
	distance_silenced = PISTOL_HEAVY_RANGE
	distant_sound = PISTOL_HEAVY_DISTANT_SOUND
	vary = FALSE
	volume = PISTOL_HEAVY_VOLUME
	volume_silenced = PISTOL_HEAVY_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/heavy_pistol/c357
	category = CSP_PISTOL_357
	shoot_sound = list('sound/f13weapons/357magnum.ogg')

/datum/ammo_sound_properties/heavy_pistol/c44
	category = CSP_PISTOL_44
	shoot_sound = list('sound/f13weapons/44mag.ogg')

/datum/ammo_sound_properties/heavy_pistol/flintlock
	category = CSP_FLINTLOCK
	shoot_sound = list('sound/f13weapons/44revolver.ogg')

/datum/ammo_sound_properties/heavy_pistol/m14mm
	category = CSP_PISTOL_14MM

/datum/ammo_sound_properties/light_rifle
	category = CSP_RIFLE_LIGHT
	shoot_sound = list('sound/f13weapons/varmint_rifle.ogg')
	distance_close = RIFLE_LIGHT_RANGE
	distance_silenced = RIFLE_LIGHT_RANGE
	distant_sound = RIFLE_LIGHT_DISTANT_SOUND
	vary = FALSE
	volume = RIFLE_LIGHT_VOLUME
	volume_silenced = RIFLE_LIGHT_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/medium_rifle
	category = CSP_RIFLE_MEDIUM
	shoot_sound = list('sound/f13weapons/hunting_rifle.ogg')
	distance_close = RIFLE_MEDIUM_RANGE
	distance_silenced = RIFLE_MEDIUM_RANGE
	distant_sound = RIFLE_MEDIUM_DISTANT_SOUND
	vary = FALSE
	volume = RIFLE_MEDIUM_VOLUME
	volume_silenced = RIFLE_MEDIUM_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/heavy_rifle
	category = CSP_RIFLE_HEAVY
	shoot_sound = list('sound/f13weapons/antimaterialfire.ogg')
	distance_close = RIFLE_HEAVY_RANGE
	distance_silenced = RIFLE_HEAVY_RANGE
	distant_sound = RIFLE_HEAVY_DISTANT_SOUND
	vary = FALSE
	volume = RIFLE_HEAVY_VOLUME
	volume_silenced = RIFLE_HEAVY_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/shotgun
	category = CSP_SHOTGUN
	shoot_sound = list('sound/f13weapons/shotgun.ogg')
	distance_close = SHOTGUN_RANGE
	distance_silenced = SHOTGUN_RANGE
	distant_sound = SHOTGUN_DISTANT_SOUND
	vary = FALSE
	volume = SHOTGUN_VOLUME
	volume_silenced = SHOTGUN_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/gauss
	category = CSP_GAUSS
	shoot_sound = list('sound/f13weapons/gauss_rifle.ogg')
	distance_close = GAUSS_RANGE
	distance_silenced = GAUSS_RANGE
	distant_sound = GAUSS_DISTANT_SOUND
	vary = FALSE
	volume = GAUSS_VOLUME
	volume_silenced = GAUSS_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/laser
	category = CSP_LASER
	shoot_sound = list('sound/f13weapons/WattzPistolFire.ogg')
	distance_close = LASER_RANGE
	distance_silenced = LASER_RANGE
	distant_sound = LASER_DISTANT_SOUND
	vary = FALSE
	volume = LASER_VOLUME
	volume_silenced = LASER_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/plasma
	category = CSP_PLASMA
	shoot_sound = list('sound/f13weapons/plasma_pistol.ogg')
	distance_close = PLASMA_RANGE
	distance_silenced = PLASMA_RANGE
	distant_sound = PLASMA_DISTANT_SOUND
	vary = FALSE
	volume = PLASMA_VOLUME
	volume_silenced = PLASMA_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/misc
	category = CSP_MISC
	shoot_sound = list('sound/weapons/punchmiss.ogg')
	distance_close = MISC_RANGE
	distance_silenced = MISC_RANGE
	distant_sound = null
	vary = TRUE
	volume = MISC_VOLUME
	volume_silenced = MISC_VOLUME * SILENCED_GUN_RANGE
	ignore_walls = TRUE

/datum/ammo_sound_properties/misc/rock // todo: strangle fuzzy
	category = CSP_ROCK
	shoot_sound = list('sound/weapons/punchmiss.ogg')

/datum/ammo_sound_properties/misc/dart // todo: snatch fuzzy
	category = CSP_DART // also foam
	shoot_sound = list('sound/items/syringeproj.ogg')

/datum/ammo_sound_properties/misc/m40mm
	category = CSP_40MM
	shoot_sound = list('sound/weapons/grenadelaunch.ogg')
