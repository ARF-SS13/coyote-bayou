/* 
 * Lagg's Pet Project: A blender you can marry and raise a family with
 */

/// NOTES ABOUT STIMULI AND IMPULSES
/// Stimuli are the things that the blender can sense, and impulses are the things that the blender can do.
/// They are both strings, but impulses 

/// Blender stimulus inputs
#define STIMULUS_FULL "bbstimulus_full_brevin"
#define STIMULUS_FULL_SECOND "bbstimulus_full_reservoir"
#define STIMULUS_NOTHING_TO_PROCESS "bbstimulus_nothing_to_process"
#define STIMULUS_PROCESSING "bbstimulus_currently_processing"
#define STIMULUS_ROCKY_ABORT "bbstimulus_hard_abort"
#define STIMULUS_SOFT_ABORT "bbstimulus_soft_abort"
#define STIMULUS_DONE_BLENDING "bbstimulus_finished_processing"
#define STIMULUS_GRINDFAIL "bbstimulus_failed_processing"
#define STIMULUS_RAT_BLENDER "bbstimulus_safety_check"
#define STIMULUS_CYBORG_PART "bbstimulus_is_borg_part"
#define STIMULUS_DRY_FIRST "bbstimulus_needs_drying"
#define STIMULUS_BATBOX_GONE "bbstimulus_missing_component_case"
#define STIMULUS_BATBOX_ELSEWHERE "bbstimulus_misplaced_component_case"
#define STIMULUS_BUFFER_GONE "bbstimulus_missing_reservoir"
#define STIMULUS_BUFFER_ELSEWHERE "bbstimulus_misplaced_reservoir"
#define STIMULUS_LOW_POWER "bbstimulus_low_power"
#define STIMULUS_PART_MISSING "bbstimulus_missing_part"
#define STIMULUS_NOTHING_TO_EJECT "bbstimulus_cant_eject"
#define STIMULUS_CANT_DROP_THING "bbstimulus_cant_drop"
#define STIMULUS_YEET "bbstimulus_yeet"
#define STIMULUS_DUMP "bbstimulus_dump_everything"
#define STIMULUS_CANT_CHANGE_WHILE_BLENDING "bbstimulus_cant_change_while_running"
#define STIMULUS_SET_MODE_A "bbstimulus_set_mode_a"
#define STIMULUS_SET_MODE_B "bbstimulus_set_mode_b"
#define STIMULUS_SET_MODE_C "bbstimulus_set_mode_c"
#define STIMULUS_SET_MODE_D "bbstimulus_set_mode_d"
	#define STIMULUS_GRIND_NOW STIMULUS_SET_MODE_A
	#define STIMULUS_JUICE_NOW STIMULUS_SET_MODE_B
	#define STIMULUS_SET_TO_DISPENSER STIMULUS_SET_MODE_C
	#define STIMULUS_SET_TO_BLENDER STIMULUS_SET_MODE_D
#define STIMULUS_SWAP_MODE "bbstimulus_swap_mode"
#define STIMULUS_EXAMINE_EMPTY "bbstimulus_nothing_to_examine"
#define STIMULUS_EXAMINE_PAPER_COOLDOWN "bbstimulus_out_of_paper"
#define STIMULUS_EXAMINE_OKAY "bbstimulus_examining"
#define STIMULUS_EJECT_BREVIN "bbstimulus_eject_brevin"
#define STIMULUS_SWAP_BREVIN "bbstimulus_swap_brevin"
#define STIMULUS_INSERT_BREVIN "bbstimulus_insert_brevin"
#define STIMULUS_BREVIN_FULL "bbstimulus_brevin_full"
#define STIMULUS_REAGENT_NOT_FOUND "bbstimulus_reagent_missing"
#define STIMULUS_STOP_RUNNING "bbstimulus_stop"
#define STIMULUS_NOT_RUNNING "bbstimulus_not_running"
#define STIMULUS_ALREADY_MODE_A "bbstimulus_already_mode_a"
#define STIMULUS_ALREADY_MODE_B "bbstimulus_already_mode_b"
#define STIMULUS_ALREADY_MODE_C "bbstimulus_already_mode_c"
#define STIMULUS_ALREADY_MODE_D "bbstimulus_already_mode_d"
	#define STIMULUS_ALREADY_GRINDER STIMULUS_ALREADY_MODE_A
	#define STIMULUS_ALREADY_JUICER STIMULUS_ALREADY_MODE_B
	#define STIMULUS_ALREADY_DISPENSER STIMULUS_ALREADY_MODE_C
	#define STIMULUS_ALREADY_BLENDER STIMULUS_ALREADY_MODE_D
#define STIMULUS_MUTE "bbstimulus_mute"
#define STIMULUS_UNMUTE "bbstimulus_unmute"
#define STIMULUS_HIYA "bbstimulus_hi"
#define STIMULUS_HIYA_AGAIN "bbstimulus_hi_again"
#define STIMULUS_LOVE "bbstimulus_i_love_you"
#define STIMULUS_HATE "bbstimulus_i_hate_you"
#define STIMULUS_PAIN "bbstimulus_i_love_pain"
#define STIMULUS_STUCK_INSIDE "bbstimulus_something_stuck"
#define STIMULUS_MISSING_HOST "bbstimulus_no_host"
#define STIMULUS_HORRIBLE_NOISES "bbstimulus_horrible_noises"
#define STIMULUS_EXAMINE_TRY "bbstimulus_examine_try"
#define STIMULUS_STATE_NAME "bbstimulus_state_name"
#define STIMULUS_PICKED_UP "bbstimulus_picked_up"

/// Blender word-to-stimulus keys
#define BBKEY_STOP "bbk_stop"
#define BBKEY_MODE_A "bbk_mode_a"
#define BBKEY_MODE_B "bbk_mode_b"
#define BBKEY_MODE_C "bbk_mode_c"
#define BBKEY_MODE_D "bbk_mode_d"
#define BBKEY_GRIND BBKEY_MODE_A
#define BBKEY_JUICE BBKEY_MODE_B
#define BBKEY_BLENDER BBKEY_MODE_C
#define BBKEY_DISPENSER BBKEY_MODE_D
#define BBKEY_SWAP_MODE "bbk_swap_mode"
#define BBKEY_EJECT "bbk_eject"
#define BBKEY_EXAMINE "bbk_examine"
#define BBKEY_MUTE "bbk_mute"
#define BBKEY_UNMUTE "bbk_unmute"
#define BBKEY_LOVE "bbk_love"
#define BBKEY_HATE "bbk_hate"
#define BBKEY_PAIN "bbk_pain"
#define BBKEY_NEGATE "bbk_negate"
#define BBKEY_YES "bbk_yes"
#define BBKEY_I "bbk_i"
#define BBKEY_YOU "bbk_you"
#define BBKEY_NAME "bbk_name"


#define BLENDER_BLENDMODE_GRIND "grinding"
#define BLENDER_BLENDMODE_JUICE "juicing"
#define BLENDER_BELTMODE_BLENDER "grindmode"
#define BLENDER_BELTMODE_DISPENSER "dispenser"

#define CHARGER_LINE_FULL "bbline_full_brevin"
#define CHARGER_LINE_EMPTY "am_empty"
#define CHARGER_LINE_CHARGING "charging"
#define CHARGER_LINE_CHARGED "charged"
#define CHARGER_LINE_DISCHARGING "discharging"
#define CHARGER_LINE_DISCHARGED "discharged"
#define CHARGER_LINE_MODE_CHARGE "charge"
#define CHARGER_LINE_MODE_DISCHARGE "discharge"
#define CHARGER_LINE_NO_CAPACITOR "no_capacitor"

/// Extra Things for Stimulus Defines
#define SPEAK_LINE_EXTRA_1 "extra1"
#define SPEAK_LINE_EXTRA_2 "extra2"

/// List of things that could be requested
#define REQUEST_STILL_WORKING "still_working"
#define REQUEST_IS_MODE_A "is_mode_a"
#define REQUEST_IS_MODE_B "is_mode_b"
#define REQUEST_IS_MODE_C "is_mode_c"
#define REQUEST_IS_MODE_D "is_mode_d"
	#define REQUEST_IS_GRINDER REQUEST_IS_MODE_A
	#define REQUEST_IS_JUICER REQUEST_IS_MODE_B
	#define REQUEST_IS_DISPENSER REQUEST_IS_MODE_C
	#define REQUEST_IS_BLENDER REQUEST_IS_MODE_D

/// List of impulses that could be requested
#define IMPULSE_SPEAK_LINE "speak_line"
#define IMPULSE_AUDIBLE_EMOTE "audible_emote"
#define IMPULSE_START "start"
#define IMPULSE_STOP "stop"
#define IMPULSE_SET_MODE_A "set_mode_a"
#define IMPULSE_SET_MODE_B "set_mode_b"
#define IMPULSE_SET_MODE_C "set_mode_c"
#define IMPULSE_SET_MODE_D "set_mode_d"
	#define IMPULSE_SET_GRINDER IMPULSE_SET_MODE_A
	#define IMPULSE_SET_JUICER IMPULSE_SET_MODE_B
	#define IMPULSE_SET_DISPENSER IMPULSE_SET_MODE_C
	#define IMPULSE_SET_BLENDER IMPULSE_SET_MODE_D
#define IMPULSE_EJECT "eject"
#define IMPULSE_EXAMINE "examine"
#define IMPULSE_HORRIBLE_NOISES "horrible_noises"
// #define IMPULSE_JUICE "juice"
// #define IMPULSE_BLENDER_MODE "blender_mode"
// #define IMPULSE_DISPENSER_MODE "dispenser_mode"
#define IMPULSE_SWAP_MODE "swap_mode"
#define IMPULSE_HIYA "hiya"
#define IMPULSE_MUTE "mute"
#define IMPULSE_UNMUTE "unmute"
#define IMPULSE_AM_LOVED "am_loved"
#define IMPULSE_AM_HATED "am_hated"
#define IMPULSE_AM_HATED2 "am_hated2"
#define IMPULSE_AM_NOT_LOVED "am_not_loved"
#define IMPULSE_AM_NOT_HATED "am_not_hated"
// #define IMPULSE_OTHER_LOVED "other_loved"
// #define IMPULSE_OTHER_HATED "other_hated"
#define IMPULSE_THEY_LOVE_PAIN "they_love_pain"
#define IMPULSE_THEY_HATE_PAIN "they_dont_love_pain"
#define IMPULSE_GREET_NEW_OWNER "greet_new_owner"
#define IMPULSE_GREET_OLD_HATER "greet_old_hater"
#define IMPULSE_HARD_RESET "hard_reset"
#define IMPULSE_HARD_RESET2 "hard_reset2"
#define IMPULSE_HARD_RESET3 "hard_reset3"
#define IMPULSE_REMEMBER_PERSON "remember_person"
#define IMPULSE_STATE_NAME "state_name"
#define IMPULSE_PICKED_UP "picked_up"
//#define IMPULSE_BEGRUDGING_OBEDIENCE "begrudging_obedience"
//#define IMPULSE_RETURN_ME "return_me"


#define IMPULSE_CLARIFY "clarify"
	#define IMPULSE_CLARIFY_YOU_LOVE_ME "clarify_you_love_me"
	#define IMPULSE_CLARIFY_YOU_HATE_ME "clarify_you_hate_me"
	#define IMPULSE_CLARIFY_YOU_LOVE_PAIN "clarify_you_love_pain"
	#define IMPULSE_CLARIFY_YOU_LOVE_WHO "clarify_you_love_who"
	#define IMPULSE_CLARIFY_YOU_HATE_WHO "clarify_you_hate_who"
	#define IMPULSE_CLARIFY_WHO_LOVES_ME "clarify_who_loves_me"
	#define IMPULSE_CLARIFY_WHO_LOVES_PAIN "clarify_who_loves_pain"
	#define IMPULSE_CLARIFY_WHO_HATES_ME "clarify_who_hates_me"
	#define IMPULSE_CLARIFY_CLEAR "clarify_clear"
	#define IMPULSE_CLARIFY_NEVERMIND "clarify_nm"

#define BELTCLARIFY_I_LOVEHATE "life_is_pain" // If you say "pain", it turns on the horrible noises
#define BELTCLARIFY_I_LOVE "i_luv"
#define BELTCLARIFY_I_HATE "i_hat"
#define BELTCLARIFY_LOVEHATE_YOU "who_do_ya" 
#define BELTCLARIFY_LOVE_YOU "who_luvs_ya" 
#define BELTCLARIFY_HATE_YOU "who_hats_ya" 
#define BELTCLARIFY_LOVEHATE "idk"
#define BELTCLARIFY_LOVE_MEAN_IT "orly-love"
#define BELTCLARIFY_HATE_MEAN_IT "orly-hate"
#define BELTCLARIFY_PAIN_MEAN_IT "orly-pain"

///IMPULSE FLAGS
#define IMPULSE_FLAG_NEEDS_HOST (1<<0)

/// SPEAKABLE STIMULI
#define SPEAK_LINE_START "bbline_start"
#define SPEAK_LINE_FULL "bbline_full_brevin"
#define SPEAK_LINE_FULL_SECOND "bbline_full_reservoir"
#define SPEAK_LINE_NOTHING_TO_PROCESS "bbline_nothing_to_process"
#define SPEAK_LINE_PROCESSING "bbline_currently_processing"
#define SPEAK_LINE_ROCKY_ABORT "bbline_hard_abort"
#define SPEAK_LINE_SOFT_ABORT "bbline_soft_abort"
#define SPEAK_LINE_DONE_BLENDING "bbline_finished_processing"
#define SPEAK_LINE_GRINDFAIL "bbline_failed_processing"
#define SPEAK_LINE_NO_RESERVOIR "bbline_missing_reservoir"
#define SPEAK_LINE_RAT_BLENDER "bbline_safety_check"
#define SPEAK_LINE_CYBORG_PART "bbline_is_borg_part"
#define SPEAK_LINE_DRY_FIRST "bbline_needs_drying"
#define SPEAK_LINE_BATBOX_GONE "bbline_missing_component_case"
#define SPEAK_LINE_BATBOX_ELSEWHERE "bbline_misplaced_component_case"
#define SPEAK_LINE_BUFFER_GONE "bbline_missing_reservoir"
#define SPEAK_LINE_BUFFER_ELSEWHERE "bbline_misplaced_reservoir"
#define SPEAK_LINE_LOW_POWER "bbline_low_power"
#define SPEAK_LINE_PART_MISSING "bbline_missing_part"
#define SPEAK_LINE_NOTHING_TO_EJECT "bbline_cant_eject"
#define SPEAK_LINE_CANT_DROP_THING "bbline_cant_drop"
#define SPEAK_LINE_YEET "bbline_yeet"
#define SPEAK_LINE_DUMP "bbline_dump_everything"
#define SPEAK_LINE_CANT_CHANGE_WHILE_BLENDING "bbline_cant_change_while_running"
#define SPEAK_LINE_SET_MODE_A "bbline_set_mode_a"
#define SPEAK_LINE_SET_MODE_B "bbline_set_mode_b"
#define SPEAK_LINE_SET_MODE_C "bbline_set_mode_c"
#define SPEAK_LINE_SET_MODE_D "bbline_set_mode_d"
	#define SPEAK_LINE_GRIND_NOW SPEAK_LINE_SET_MODE_A
	#define SPEAK_LINE_JUICE_NOW SPEAK_LINE_SET_MODE_B
	#define SPEAK_LINE_SET_TO_DISPENSER SPEAK_LINE_SET_MODE_C
	#define SPEAK_LINE_SET_TO_GRINDER SPEAK_LINE_SET_MODE_D
#define SPEAK_LINE_SWAP_MODE "bbline_swap_mode"
#define SPEAK_LINE_EXAMINE_EMPTY "bbline_nothing_to_examine"
#define SPEAK_LINE_EXAMINE_PAPER_COOLDOWN "bbline_out_of_paper"
#define SPEAK_LINE_EXAMINE_OKAY "bbline_examining"
#define SPEAK_LINE_EJECT_BREVIN "bbline_eject_brevin"
#define SPEAK_LINE_SWAP_BREVIN "bbline_swap_brevin"
#define SPEAK_LINE_INSERT_BREVIN "bbline_insert_brevin"
#define SPEAK_LINE_BREVIN_FULL "bbline_brevin_full"
#define SPEAK_LINE_REAGENT_NOT_FOUND "bbline_reagent_missing"
#define SPEAK_LINE_STOP_RUNNING "bbline_stop"
#define SPEAK_LINE_NOT_RUNNING "bbline_not_running"
#define SPEAK_LINE_ALREADY_BLENDER "bbline_already_mode_d"
#define SPEAK_LINE_ALREADY_DISPENSER "bbline_already_mode_c"
#define SPEAK_LINE_MUTE "bbline_mute"
#define SPEAK_LINE_UNMUTE "bbline_unmute"
#define SPEAK_LINE_HIYA "bbline_hi"
#define SPEAK_LINE_HIYA_AGAIN "bbline_hi_again"
/// love/hate
#define SPEAK_LINE_LOVE "bbline_i_love_you"
#define SPEAK_LINE_HATE "bbline_i_hate_you"
#define SPEAK_LINE_PAIN "bbline_i_love_pain"
#define SPEAK_LINE_LOVE_OWNER "bbline_i_love_you_owner"
#define SPEAK_LINE_HATE_OWNER "bbline_i_hate_you_owner"
#define SPEAK_LINE_PAIN_OWNER "bbline_i_love_pain_owner"
#define SPEAK_LINE_PAIN_OWNER_NOHOST "bbline_i_love_pain_owner_nohost"
#define SPEAK_LINE_NOT_LOVE "bbline_i_love_you_not"
#define SPEAK_LINE_NOT_HATE "bbline_i_hate_you_not"
#define SPEAK_LINE_NOT_PAIN "bbline_i_love_pain_not"
#define SPEAK_LINE_NOT_LOVE_OWNER "bbline_i_love_you_not_owner"
#define SPEAK_LINE_NOT_HATE_OWNER "bbline_i_hate_you_not_owner"
#define SPEAK_LINE_NOT_PAIN_OWNER "bbline_i_love_pain_not_owner"
///
#define SPEAK_LINE_BREAKUP_OWNER "bbline_breakup_with_owner"

///
#define SPEAK_LINE_STUCK_INSIDE "bbline_something_stuck"
#define SPEAK_LINE_MISSING_HOST "bbline_no_host"
#define SPEAK_LINE_HORRIBLE_NOISES "bbline_horrible_noises"
#define SPEAK_LINE_EXAMINE_TRY "bbline_examine_try"
#define SPEAK_LINE_EXAMINE_SHELL "bbline_examine_shell"
#define SPEAK_LINE_CRUSHED "bbline_crushed"
#define SPEAK_LINE_BEGRUDGING_OBEDIENCE "bbline_begrudging_obedience"
#define SPEAK_LINE_HARD_RESET1 "bbline_hard_reset_1"
#define SPEAK_LINE_HARD_RESET2 "bbline_hard_reset_2"
#define SPEAK_LINE_RETURN_ME_TO_OWNER "bbline_return_me_to_owner"
#define SPEAK_LINE_GREET_NEW_OWNER "bbline_greet_new_owner"

#define SPEAK_LINE_INCOMPATIBLE "bbline_incompatible"
#define SPEAK_LINE_COMPATIBLE_FAVORED "bbline_compatible_favored"
#define SPEAK_LINE_COMPATIBLE_UNKNOWN "bbline_compatible_unknown"
#define SPEAK_LINE_COMPATIBLE_FAILED "bbline_compatible_failed"

#define SPEAK_LINE_CLARIFY_YOU_LOVE_ME "bbline_clarify_you_love_me"
#define SPEAK_LINE_CLARIFY_YOU_HATE_ME "bbline_clarify_you_hate_me"
#define SPEAK_LINE_CLARIFY_YOU_LOVE_PAIN "bbline_clarify_you_love_pain"
#define SPEAK_LINE_CLARIFY_YOU_LOVE_WHO "bbline_clarify_you_love_who"
#define SPEAK_LINE_CLARIFY_YOU_HATE_WHO "bbline_clarify_you_hate_who"
#define SPEAK_LINE_CLARIFY_WHO_LOVES_ME "bbline_clarify_who_loves_me"
#define SPEAK_LINE_CLARIFY_WHO_LOVES_PAIN "bbline_clarify_who_loves_pain"
#define SPEAK_LINE_CLARIFY_WHO_HATES_ME "bbline_clarify_who_hates_me"
#define SPEAK_LINE_CLARIFY_CLEAR "bbline_clarify_clear"
#define SPEAK_LINE_CLARIFY_MISHEARD "bbline_clarify_misheard"

#define SPEAK_LINE_STATE_NAME "bbline_state_name"

#define EMOTE_LINE_GIGGLE "bbline_giggle_emote"
#define EMOTE_LINE_SIGH "bbline_sigh_emote"
#define EMOTE_LINE_HORRIBLE_NOISES "bbline_horrible_noises_emote"
#define EMOTE_LINE_QUIET "bbline_quiet_emote"
#define EMOTE_LINE_BUZZ "bbline_buzz_emote"

// amour returns
#define HORNY_MSG "horny"
#define NORMAL_MSG "normal"
#define DISLIKE_MSG "dislike"

#define AMOUR_KEYS list(HORNY_MSG, NORMAL_MSG, DISLIKE_MSG)

#define AMOUR_MIN_FOR_HORNY 50
#define AMOUR_POST_HORNY_MULT 0.8
#define AMOUR_POST_HORNY_MIN 20
#define AMOUR_MAX 150
#define AMOUR_MIN -200

//replacement tokens
#define BB_TOKEN_EXTRA1 "%EXTRA1"
#define BB_TOKEN_EXTRA2 "%EXTRA2"
#define BB_TOKEN_USER "%USER"
#define BB_TOKEN_SEX "%SEX"
#define BB_TOKEN_OWNER "%OWNER"
#define BB_TOKEN_MYNAME "%MYNAME"
#define BB_TOKEN_SRC "%SRC"

//Memory flags
#define BB_IS_OWNER (1<<0)
#define BB_WAS_OWNER (1<<1)
#define BB_WAS_MEAN (1<<2)

/// If it hasnt had an owner for this long, and its former mean owner tries to use it, it will wipe its memory and become owned by them again
#define BB_OWNERLESS_DESPAIR_TIME 20 MINUTES

/// If the compatible thing has a storage that isnt the main thing making signals, but is where the core should be, check the loc of its loc
#define BB_USE_LOC_OF_LOC (1<<10)

//Spoken Command Priorities


