// Overhauled vore system
#define DM_HOLD "Hold"
#define DM_DIGEST "Digest"
#define DM_HEAL "Heal"
#define DM_NOISY "Noisy"
#define DM_DRAGON "Dragon"
#define DM_ABSORB "Absorb"
#define DM_UNABSORB "Un-absorb"

#define DIGESTABLE 		(1<<0)
#define DEVOURABLE		(1<<1)
#define FEEDING			(1<<2)
#define NO_VORE			(1<<3)
#define ABSORBED		(1<<4)
#define VORE_INIT		(1<<5)
#define VOREPREF_INIT	(1<<6)
#define LICKABLE		(1<<7)
/// Can be smelled?
#define SMELLABLE		(1<<8)
/// Can get absorbed?
#define ABSORBABLE		(1<<9)
/// Can get simplemob vored?
#define MOBVORE			(1<<10)

/// Change this whenever you add a vore flag, must be largest vore flag*2-1
#define MAX_VORE_FLAG	(1<<11)-1

#define isbelly(A) istype(A, /obj/vore_belly)

#define QDEL_NULL_LIST(x) if(x) { for(var/y in x) { qdel(y) } ; x = null }
#define VORE_STRUGGLE_EMOTE_CHANCE 40

// Stance for hostile mobs to be in while devouring someone.
#define HOSTILE_STANCE_EATING	99

/* // removing sizeplay again
GLOBAL_LIST_INIT(player_sizes_list, list("Macro" = SIZESCALE_HUGE, "Big" = SIZESCALE_BIG, "Normal" = SIZESCALE_NORMAL, "Small" = SIZESCALE_SMALL, "Tiny" = SIZESCALE_TINY))
// Edited to make the new travis check go away
*/

#define CHECK_PREFS(mob, pref) SSprefbreak.allowed_by_prefs(mob, pref)

/// Delicious vore defines!
#define CD_VORE_SOUND 1 SECONDS

#define VORE_VOLUME 70
#define VORE_SOUNDRANGE 3

#define VORESOUND_GULP "gulp_pred"
#define VORESOUND_EJECT "splut_pred"
#define VORESOUND_VORE "vore_pred"
#define VORESOUND_STRUGGLE "vore_struggle"
#define VORESOUND_DIGEST "vore_digest"
#define VORESOUND_DEATH "vore_deth"

#define VORE_SWALLOW_HUMAN_TIME 10 SECONDS
#define VORE_SWALLOW_NONHUMAN_TIME 10 SECONDS

#define VORE_MAX_DESCRIPTOR_LENGTH 160
#define VORE_MIN_DESCRIPTOR_LENGTH 10


//vore pref flags
#define VORE_DOGBORGS			(1<<0) // I never got why people dont like dogborgs
#define VORE_EATING_NOISES		(1<<1) // Allows gross vore eating noises
#define VORE_DIGESTION_NOISES	(1<<2) // Allows gross vore gurgling noises
#define VORE_DIGESTION_DAMAGE	(1<<3) // Allows digestion to damage you
#define VORE_ABSORBABLE			(1<<4) // Allows absorbtion to happen
#define VORE_HEALBELLY			(1<<5) // Allows healbellies to heal you
#define VORE_DEATH				(1<<6) // Allows digestion to fuckin murder you
#define VORE_TEXT				(1<<7) // Allows seeing vore messages
#define VORE_TEXT_DEATH			(1<<8) // Allows seeing vore messages about dying
#define VORE_BEING_PREY			(1<<9) // Allows being prey
#define VORE_BEING_FED			(1<<10) // Allows being fed
#define VORE_EXAMINE			(1<<11) // Allows reading descs about bellies
#define VORE_SNIFFABLE			(1<<12) // Allows being sniffed

//belly sound pref things
#define NORMIE_HEARCHECK 4
#define VOREMOTE_COOLDOWN 10 SECONDS

/// prefcheck
#define VOREPREF_EAT_SOUNDS "nyomf"
#define VOREPREF_DIGESTION_SOUNDS "gurgle"
#define VOREPREF_VORE_DIGESTION_DAMAGE "digestable"
#define VOREPREF_ABSORBTION "absorbable"
#define VOREPREF_HEALBELLY "healbellyable"
#define VOREPREF_DEATH "wouldyoulikeyourpossessionsidentified"
#define VOREPREF_EXAMINE "theygotaguttywut"
#define VOREPREF_TEXT "yougosquish"
#define VOREPREF_TEXT_DEATH "youdie"
#define VOREPREF_BEING_PREY "am_prey"
#define VOREPREF_BEING_FED "am_fed_prey"
#define VOREPREF_SNIFFABLE "can_sniff"

/// vore sound channels are in [code\__DEFINES\sound.dm]


GLOBAL_LIST_INIT(pred_vore_sounds, list(
		"Gulp" = 'sound/vore/pred/swallow_01.ogg',
		"Swallow" = 'sound/vore/pred/swallow_02.ogg',
		"Insertion1" = 'sound/vore/pred/insertion_01.ogg',
		"Insertion2" = 'sound/vore/pred/insertion_02.ogg',
		"Tauric Swallow" = 'sound/vore/pred/taurswallow.ogg',
		"Stomach Move"		= 'sound/vore/pred/stomachmove.ogg',
		"Schlorp" = 'sound/vore/pred/schlorp.ogg',
		"Squish1" = 'sound/vore/pred/squish_01.ogg',
		"Squish2" = 'sound/vore/pred/squish_02.ogg',
		"Squish3" = 'sound/vore/pred/squish_03.ogg',
		"Squish4" = 'sound/vore/pred/squish_04.ogg',
		"Rustle (cloth)" = 'sound/effects/rustle5.ogg',
		"Rustle 2 (cloth)"	= 'sound/effects/rustle2.ogg',
		"Rustle 3 (cloth)"	= 'sound/effects/rustle3.ogg',
		"Rustle 4 (cloth)"	= 'sound/effects/rustle4.ogg',
		"Rustle 5 (cloth)"	= 'sound/effects/rustle5.ogg',
		//Extreme SPLURT degeneracy starts here
/* 		"Fart" = 'modular_splurt/sound/voice/farts/fart.ogg',
		"Fart 1" = 'modular_splurt/sound/voice/farts/fart1.ogg',
		"Fart 2" = 'modular_splurt/sound/voice/farts/fart2.ogg',
		"Fart 3" = 'modular_splurt/sound/voice/farts/fart3.ogg',
		"Fart 4" = 'modular_splurt/sound/voice/farts/fart4.ogg',
		"Fart 5" = 'modular_splurt/sound/voice/farts/fart5.ogg',
		"Fart 6" = 'modular_splurt/sound/voice/farts/fart6.ogg',
		"Fart 7" = 'modular_splurt/sound/voice/farts/fart7.ogg',
		"Burp 1" = 'modular_splurt/sound/voice/burps/belch1.ogg',
		"Burp 2" = 'modular_splurt/sound/voice/burps/belch2.ogg',
		"Burp 3" = 'modular_splurt/sound/voice/burps/belch3.ogg',
		"Burp 4" = 'modular_splurt/sound/voice/burps/belch4.ogg',
		"Burp 5" = 'modular_splurt/sound/voice/burps/belch5.ogg',
		"Burp 6" = 'modular_splurt/sound/voice/burps/belch6.ogg',
		"Burp 7" = 'modular_splurt/sound/voice/burps/belch7.ogg',
		"Burp 8" = 'modular_splurt/sound/voice/burps/belch8.ogg',
		"Burp 9" = 'modular_splurt/sound/voice/burps/belch9.ogg',
		"Burp 10" = 'modular_splurt/sound/voice/burps/belch10.ogg',
		"Burp 11" = 'modular_splurt/sound/voice/burps/belch11.ogg',
		"Burp 12" = 'modular_splurt/sound/voice/burps/belch12.ogg',
		"Burp 13" = 'modular_splurt/sound/voice/burps/belch13.ogg',
		"Burp 14" = 'modular_splurt/sound/voice/burps/belch14.ogg',
		"Burp 15" = 'modular_splurt/sound/voice/burps/belch15.ogg', */
		"None" = null
		))

GLOBAL_LIST_INIT(prey_vore_sounds, list(
		"Gulp" = 'sound/vore/prey/swallow_01.ogg',
		"Swallow" = 'sound/vore/prey/swallow_02.ogg',
		"Insertion1" = 'sound/vore/prey/insertion_01.ogg',
		"Insertion2" = 'sound/vore/prey/insertion_02.ogg',
		"Tauric Swallow" = 'sound/vore/prey/taurswallow.ogg',
		"Stomach Move"		= 'sound/vore/prey/stomachmove.ogg',
		"Schlorp" = 'sound/vore/prey/schlorp.ogg',
		"Squish1" = 'sound/vore/prey/squish_01.ogg',
		"Squish2" = 'sound/vore/prey/squish_02.ogg',
		"Squish3" = 'sound/vore/prey/squish_03.ogg',
		"Squish4" = 'sound/vore/prey/squish_04.ogg',
		"Rustle (cloth)" = 'sound/effects/rustle5.ogg',
		"Rustle 2 (cloth)"	= 'sound/effects/rustle2.ogg',
		"Rustle 3 (cloth)"	= 'sound/effects/rustle3.ogg',
		"Rustle 4 (cloth)"	= 'sound/effects/rustle4.ogg',
		"Rustle 5 (cloth)"	= 'sound/effects/rustle5.ogg',
		//Extreme SPLURT degeneracy starts here
/*		"Fart" = 'modular_splurt/sound/voice/farts/fart.ogg',
		"Fart 1" = 'modular_splurt/sound/voice/farts/fart1.ogg',
		"Fart 2" = 'modular_splurt/sound/voice/farts/fart2.ogg',
		"Fart 3" = 'modular_splurt/sound/voice/farts/fart3.ogg',
		"Fart 4" = 'modular_splurt/sound/voice/farts/fart4.ogg',
		"Fart 5" = 'modular_splurt/sound/voice/farts/fart5.ogg',
		"Fart 6" = 'modular_splurt/sound/voice/farts/fart6.ogg',
		"Fart 7" = 'modular_splurt/sound/voice/farts/fart7.ogg',
		"Burp 1" = 'modular_splurt/sound/voice/burps/belch1.ogg',
		"Burp 2" = 'modular_splurt/sound/voice/burps/belch2.ogg',
		"Burp 3" = 'modular_splurt/sound/voice/burps/belch3.ogg',
		"Burp 4" = 'modular_splurt/sound/voice/burps/belch4.ogg',
		"Burp 5" = 'modular_splurt/sound/voice/burps/belch5.ogg',
		"Burp 6" = 'modular_splurt/sound/voice/burps/belch6.ogg',
		"Burp 7" = 'modular_splurt/sound/voice/burps/belch7.ogg',
		"Burp 8" = 'modular_splurt/sound/voice/burps/belch8.ogg',
		"Burp 9" = 'modular_splurt/sound/voice/burps/belch9.ogg',
		"Burp 10" = 'modular_splurt/sound/voice/burps/belch10.ogg',
		"Burp 11" = 'modular_splurt/sound/voice/burps/belch11.ogg',
		"Burp 12" = 'modular_splurt/sound/voice/burps/belch12.ogg',
		"Burp 13" = 'modular_splurt/sound/voice/burps/belch13.ogg',
		"Burp 14" = 'modular_splurt/sound/voice/burps/belch14.ogg',
		"Burp 15" = 'modular_splurt/sound/voice/burps/belch15.ogg', */
		"None" = null
		))

GLOBAL_LIST_INIT(pred_release_sounds, list(
		"Rustle (cloth)" = 'sound/effects/rustle1.ogg',
		"Rustle 2 (cloth)" = 'sound/effects/rustle2.ogg',
		"Rustle 3 (cloth)" = 'sound/effects/rustle3.ogg',
		"Rustle 4 (cloth)" = 'sound/effects/rustle4.ogg',
		"Rustle 5 (cloth)" = 'sound/effects/rustle5.ogg',
		"Stomach Move" = 'sound/vore/pred/stomachmove.ogg',
		"Pred Escape" = 'sound/vore/pred/escape.ogg',
		"Splatter" = 'sound/effects/splat.ogg',
		//Extreme SPLURT degeneracy starts here
/*		"Fart" = 'modular_splurt/sound/voice/farts/fart.ogg',
		"Fart 1" = 'modular_splurt/sound/voice/farts/fart1.ogg',
		"Fart 2" = 'modular_splurt/sound/voice/farts/fart2.ogg',
		"Fart 3" = 'modular_splurt/sound/voice/farts/fart3.ogg',
		"Fart 4" = 'modular_splurt/sound/voice/farts/fart4.ogg',
		"Fart 5" = 'modular_splurt/sound/voice/farts/fart5.ogg',
		"Fart 6" = 'modular_splurt/sound/voice/farts/fart6.ogg',
		"Fart 7" = 'modular_splurt/sound/voice/farts/fart7.ogg',
		"Fart 8" = 'modular_splurt/sound/voice/farts/fart8.ogg',
		"Burp 1" = 'modular_splurt/sound/voice/burps/belch1.ogg',
		"Burp 2" = 'modular_splurt/sound/voice/burps/belch2.ogg',
		"Burp 3" = 'modular_splurt/sound/voice/burps/belch3.ogg',
		"Burp 4" = 'modular_splurt/sound/voice/burps/belch4.ogg',
		"Burp 5" = 'modular_splurt/sound/voice/burps/belch5.ogg',
		"Burp 6" = 'modular_splurt/sound/voice/burps/belch6.ogg',
		"Burp 7" = 'modular_splurt/sound/voice/burps/belch7.ogg',
		"Burp 8" = 'modular_splurt/sound/voice/burps/belch8.ogg',
		"Burp 9" = 'modular_splurt/sound/voice/burps/belch9.ogg',
		"Burp 10" = 'modular_splurt/sound/voice/burps/belch10.ogg',
		"Burp 11" = 'modular_splurt/sound/voice/burps/belch11.ogg',
		"Burp 12" = 'modular_splurt/sound/voice/burps/belch12.ogg',
		"Burp 13" = 'modular_splurt/sound/voice/burps/belch13.ogg',
		"Burp 14" = 'modular_splurt/sound/voice/burps/belch14.ogg',
		"Burp 15" = 'modular_splurt/sound/voice/burps/belch15.ogg', */
		"None" = null
		))

GLOBAL_LIST_INIT(prey_release_sounds, list(
		"Rustle (cloth)" = 'sound/effects/rustle1.ogg',
		"Rustle 2 (cloth)" = 'sound/effects/rustle2.ogg',
		"Rustle 3 (cloth)" = 'sound/effects/rustle3.ogg',
		"Rustle 4 (cloth)" = 'sound/effects/rustle4.ogg',
		"Rustle 5 (cloth)" = 'sound/effects/rustle5.ogg',
		"Stomach Move" = 'sound/vore/prey/stomachmove.ogg',
		"Pred Escape" = 'sound/vore/prey/escape.ogg',
		"Splatter" = 'sound/effects/splat.ogg',
		//Extreme SPLURT degeneracy starts here
/* 		"Fart" = 'modular_splurt/sound/voice/farts/fart.ogg',
		"Fart 1" = 'modular_splurt/sound/voice/farts/fart1.ogg',
		"Fart 2" = 'modular_splurt/sound/voice/farts/fart2.ogg',
		"Fart 3" = 'modular_splurt/sound/voice/farts/fart3.ogg',
		"Fart 4" = 'modular_splurt/sound/voice/farts/fart4.ogg',
		"Fart 5" = 'modular_splurt/sound/voice/farts/fart5.ogg',
		"Fart 6" = 'modular_splurt/sound/voice/farts/fart6.ogg',
		"Fart 7" = 'modular_splurt/sound/voice/farts/fart7.ogg',
		"Fart 8" = 'modular_splurt/sound/voice/farts/fart8.ogg',
		"Burp 1" = 'modular_splurt/sound/voice/burps/belch1.ogg',
		"Burp 2" = 'modular_splurt/sound/voice/burps/belch2.ogg',
		"Burp 3" = 'modular_splurt/sound/voice/burps/belch3.ogg',
		"Burp 4" = 'modular_splurt/sound/voice/burps/belch4.ogg',
		"Burp 5" = 'modular_splurt/sound/voice/burps/belch5.ogg',
		"Burp 6" = 'modular_splurt/sound/voice/burps/belch6.ogg',
		"Burp 7" = 'modular_splurt/sound/voice/burps/belch7.ogg',
		"Burp 8" = 'modular_splurt/sound/voice/burps/belch8.ogg',
		"Burp 9" = 'modular_splurt/sound/voice/burps/belch9.ogg',
		"Burp 10" = 'modular_splurt/sound/voice/burps/belch10.ogg',
		"Burp 11" = 'modular_splurt/sound/voice/burps/belch11.ogg',
		"Burp 12" = 'modular_splurt/sound/voice/burps/belch12.ogg',
		"Burp 13" = 'modular_splurt/sound/voice/burps/belch13.ogg',
		"Burp 14" = 'modular_splurt/sound/voice/burps/belch14.ogg',
		"Burp 15" = 'modular_splurt/sound/voice/burps/belch15.ogg', */
		"None" = null
		))
