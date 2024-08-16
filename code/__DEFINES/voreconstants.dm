// WANNA CUM?
#define NOTMERP_AUTOCLIMAX "lol_this_wishes_it_were_merp"
#define NOTMERP_LEWD_SOUNDS "squish_plsorkioefer"
#define NOTMERP_LEWD_WORDS "youthingthething"

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

/* // removing sizeplay again // wtf sizeplay rules
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


//belly sound pref things
#define NORMIE_HEARCHECK 4
#define VOREMOTE_COOLDOWN 10 SECONDS

/// prefcheck
#define VOREPREF_DOGBORGS "i_like_dogs"
#define VOREPREF_EAT_SOUNDS "vore_eating_sound"
#define VOREPREF_DIGESTION_SOUNDS "gurgle_sound"
#define VOREPREF_DIGESTION_DAMAGE "gurgle_damage"
#define VOREPREF_DIGESTION_DEATH "gurgle_to_death"
#define VOREPREF_ABSORBTION "absorbable"
#define VOREPREF_HEALBELLY "healbellyable"
#define VOREPREF_VORE_MESSAGES "you_feel_all_wet"
#define VOREPREF_DEATH_MESSAGES "someone_gurgled_to_death"
#define VOREPREF_TRASH_MESSAGES "someone_horked_trash"
#define VOREPREF_BEING_PREY "am_prey"
#define VOREPREF_BEING_FED_PREY "am_fed_prey"
#define VOREPREF_BEING_FED_TO_OTHERS "am_fed_to_someone_else"
#define VOREPREF_EXAMINE "you_see_a_gut"
#define VOREPREF_SNIFFABLE "am_smellable"
#define VOREPREF_SPIT_UP_TRASH "i_like_trash"
#define VOREPREF_MASTER "master_voer_thing"

/// vore message types
#define VORE_MESSAGE_TYPE_STRUGGLE "struggle"
#define VORE_MESSAGE_TYPE_STRUGGLE_ABSORBING "strubsorbed"
#define VORE_MESSAGE_TYPE_DIGEST "digest"
#define VORE_MESSAGE_TYPE_ABSORBED "absorbed"
#define VORE_MESSAGE_TYPE_UNABSORBED "unabsorbed"
#define VORE_MESSAGE_TYPE_TRASH "trash"

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

/// aight so you get to sit here under all the nonexistant burps and farts and think about what you did
#define WHO_SHOWS_ME (1<<0)
#define WHO_SHOWS_WHERE (1<<1)
#define WHO_SHOWS_COORDS (1<<2)
#define WHO_SHOWS_NAME (1<<3)
#define WHO_SHOWS_ROLE (1<<4)
#define WHO_SHOWS_POSE (1<<5)

#define DEFAULT_WHO_FLAGS (WHO_SHOWS_ME | WHO_SHOWS_NAME | WHO_SHOWS_POSE | WHO_SHOWS_WHERE)

#define WHO_LOCKOUT_NAME (1<<0)
#define WHO_LOCKOUT_ROLE (1<<1)
#define WHO_LOCKOUT_WHERE (1<<2)
#define WHO_LOCKOUT_POSE (1<<3)

#define MAX_STATUS_LEN 86

/////////////////////////
// Interaction Categories
#define ICAT_LEWD "Lewd"
#define ICAT_SELF "Solo"
#define ICAT_CROTCH "Crotch"
#define ICAT_BUTT "Butt"
#define ICAT_BELLY "Belly"
#define ICAT_CHEST "Chest"
#define ICAT_MOUTH "Mouth"
#define ICAT_HANDS "Hands"
#define ICAT_FEET "Feet"
#define ICAT_TAIL "Tail"
#define ICAT_OTHER "Other"
#define ICAT_VAGINA "Vagina"
#define ICAT_PENIS "Penis"
#define ICAT_BREASTS "Breasts"
/// Also here cus they know what they did

#define LEWD_VERB_COOLDOWN 0.25 SECONDS
#define LEWD_VERB_SOUND_COOLDOWN 0.25 SECONDS
#define LEWD_VERB_MESSAGE_COOLDOWN 4 SECONDS
#define LEWD_VERB_MOAN_COOLDOWN 5 SECONDS
#define LUST_USER (1<<1)
#define LUST_TARGET (1<<2)

#define RADIOPREF_HEAR_RADIO_BLURBLES "hear_staticky_chittering"
#define RADIOPREF_HEAR_RADIO_STATIC "hear_staticky_clicks"

#define ADMIN_CHAT_FILTER_DMS "ADMIN_CHAT_FILTER_DMS"

#define SEE_FANCY_OFF_SCREEN_RUNECHAT "SEE_FANCY_OFF_SCREEN_RUNECHAT"
#define SHOW_ME_HORNY_FURRIES "SHOW_ME_HORNY_FURRIES"
