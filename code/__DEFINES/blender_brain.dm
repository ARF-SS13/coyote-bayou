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
#define STIMULUS_SPOKEN_TO "bbstimulus_spoken_to"
#define STIMULUS_HIYA "bbstimulus_hi"
#define STIMULUS_HIYA_AGAIN "bbstimulus_hi_again"
#define STIMULUS_HEARD_LOVE "bbstimulus_heard_i_love_you"
#define STIMULUS_HEARD_HATE "bbstimulus_heard_i_hate_you"
#define STIMULUS_PAIN "bbstimulus_i_love_pain"

	#define STIMULUS_CLARIFY_YOU_LOVE_ME "bbstimulus_clarify_you_love_me"
	#define STIMULUS_CLARIFY_YOU_HATE_ME "bbstimulus_clarify_you_hate_me"
	#define STIMULUS_CLARIFY_YOU_LOVE_PAIN "bbstimulus_clarify_you_love_pain"
	#define STIMULUS_CLARIFY_YOU_LOVE_WHO "bbstimulus_clarify_you_love_who"
	#define STIMULUS_CLARIFY_YOU_HATE_WHO "bbstimulus_clarify_you_hate_who"
	#define STIMULUS_CLARIFY_WHO_LOVES_ME "bbstimulus_clarify_who_loves_me"
	#define STIMULUS_CLARIFY_WHO_LOVES_PAIN "bbstimulus_clarify_who_loves_pain"
	#define STIMULUS_CLARIFY_WHO_HATES_ME "bbstimulus_clarify_who_hates_me"
	#define STIMULUS_CLARIFY_CLEAR "bbstimulus_clarify_clear"
	#define STIMULUS_CLARIFY_NEVERMIND "bbstimulus_clarify_nm"

#define STIMULUS_LOVE_4REAL "bbstimulus_i_love_you_4real"
#define STIMULUS_HATE_4REAL "bbstimulus_i_hate_you_4real"
#define STIMULUS_PAIN_4REAL "bbstimulus_i_love_pain_4real"
#define STIMULUS_REMEMBER_LOVED "bbstimulus_remember_loved"
#define STIMULUS_REMEMBER_HATED "bbstimulus_remember_hated"

#define STIMULUS_LOVE "bbstimulus_i_love_you"
#define STIMULUS_LOVE_AMOUR "bbstimulus_i_love_you_amour"
#define STIMULUS_HATE "bbstimulus_i_hate_you"
#define STIMULUS_HATE_AMOUR "bbstimulus_i_hate_you_amour"

#define STIMULUS_LOVE_NOT "bbstimulus_i_love_you_not"
#define STIMULUS_HATE_NOT "bbstimulus_i_hate_you_not"
#define STIMULUS_PAIN_NOT "bbstimulus_i_love_pain_not"

#define STIMULUS_STUCK_INSIDE "bbstimulus_something_stuck"
#define STIMULUS_MISSING_HOST "bbstimulus_no_host"
#define STIMULUS_HORRIBLE_NOISES "bbstimulus_horrible_noises"
#define STIMULUS_EXAMINE_TRY "bbstimulus_examine_try"
#define STIMULUS_STATE_NAME "bbstimulus_state_name"
#define STIMULUS_PICKED_UP "bbstimulus_picked_up"
#define STIMULUS_EQUIPPED "bbstimulus_equipped"
#define STIMULUS_CLICKED "bbstimulus_clicked"
#define STIMULUS_DROPPED "bbstimulus_dropped"
#define STIMULUS_IMPACT_THROWN "bbstimulus_impact_thrown"
#define STIMULUS_IMPACT_GENERIC "bbstimulus_impact_generic"
#define STIMULUS_MICROWAVED "bbstimulus_microwaved"
#define STIMULUS_BREAKUP "bbstimulus_breakup"
#define STIMULUS_ADD_LOVER "bbstimulus_add_lover"
#define STIMULUS_INTRODUCE_SELF "bbstimulus_introduce_self"
#define STIMULUS_BEEN_A_WHILE "bbstimulus_been_a_while"

#define STIMULUS_AFFAIR_OWNER "bbstimulus_affair_owner" // an affair where it becomes someone else's owned object
#define STIMULUS_AFFAIR_LOVE "bbstimulus_affair_love" // an affair where it becomes someone else's loved object

#define STIMULUS_WEARER_CRIT "bbstimulus_wearer_crit"
#define STIMULUS_WEARER_CRIT_YELL_HELP "bbstimulus_wearer_crit_yell_help"
#define STIMULUS_WEARER_CRIT_PANIC "bbstimulus_wearer_crit_panic"
#define STIMULUS_WEARER_CRIT_INJECT "bbstimulus_wearer_crit_inject"

#define STIMULUS_WEARER_DIED "bbstimulus_wearer_died"

#define BB_ADJUST_AMOUR "adjust_amour"


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
#define BBKEY_HEY "bbk_hail" 
#define BBKEY_LISTEN "bbk_heylisten"


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
#define IMPULSE_ATTEMPT_OWNERIZE "attempt_ownerize"
#define IMPULSE_GREET_OLD_HATER "greet_old_hater"
#define IMPULSE_HARD_RESET "hard_reset"
#define IMPULSE_HARD_RESET2 "hard_reset2"
#define IMPULSE_HARD_RESET3 "hard_reset3"
#define IMPULSE_REMEMBER_PERSON "remember_person"
#define IMPULSE_CHECK_MET "check_met"
#define IMPULSE_GREET_NEW_PERSON "greet_new_person"
#define IMPULSE_BEEN_A_WHILE "been_a_while"
#define IMPULSE_STATE_NAME "state_name"
#define IMPULSE_GREET "greet"
#define IMPULSE_PICKED_UP "picked_up"
#define IMPULSE_EQUIPPED "equipped"
#define IMPULSE_SET_LISTENING "listening"

#define IMPULSE_CLICKED "clicked"
#define IMPULSE_DROPPED "dropped"
#define IMPULSE_IMPACT_THROWN "impact_thrown"
#define IMPULSE_IMPACT_GENERIC "impact_generic"
#define IMPULSE_MICROWAVED "microwaved"

#define IMPULSE_AM_LOVED "am_loved"
#define IMPULSE_AM_HATED "am_hated"
#define IMPULSE_BREAKUP "am_hated2"
#define IMPULSE_AM_NOT_LOVED "am_not_loved"
#define IMPULSE_AM_NOT_HATED "am_not_hated"
#define IMPULSE_THEY_LOVE_PAIN "they_love_pain"
#define IMPULSE_THEY_HATE_PAIN "they_dont_love_pain"

#define IMPULSE_BREAKUP_ROLL "breakup_roll"
#define IMPULSE_LOVE_ROLL "love_roll"
#define IMPULSE_OWNER_ROLL "owner_roll"
#define IMPULSE_HATE_ROLL "hate_roll"
#define IMPULSE_AFFAIR_ROLL_LOVE "affair_roll"
#define IMPULSE_AFFAIR_ROLL_OWNER "affair_roll"
#define IMPULSE_AFFAIR_OWNER "affair_owner"
#define IMPULSE_AFFAIR_LOVE "affair_love"
#define IMPULSE_REMEMBER_LOVED "remember_loved"
#define IMPULSE_REMEMBER_HATED "remember_hated"

#define IMPULSE_DISLIKE_DROPPED "dislike_dropped"

#define IMPULSE_GIGGLE "giggle"
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

#define IMPULSE_WEARER_CRIT "wearer_crit"
#define IMPULSE_WEARER_CRIT_YELL_HELP "wearer_crit_yell_help"
#define IMPULSE_WEARER_CRIT_PANIC "wearer_crit_panic"
#define IMPULSE_WEARER_CRIT_INJECT "wearer_crit_inject"

#define IMPULSE_WEARER_DIED "wearer_died"

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
#define SPEAK_LINE_PICKED_UP "bbline_picked_up"
#define SPEAK_LINE_PICKED_UP_AGAIN "bbline_picked_up_again"
#define SPEAK_LINE_PICKED_UP_OWNER "bbline_picked_up_owner"
#define SPEAK_LINE_PICKED_UP_NO_OWNER "bbline_picked_up_no_owner"
#define SPEAK_LINE_EQUIPPED "bbline_equipped"
#define SPEAK_LINE_EQUIPPED_AGAIN "bbline_equipped_again"
#define SPEAK_LINE_EQUIPPED_OWNER "bbline_equipped_owner"

#define SPEAK_LINE_OWNER_AFFAIR "bbline_owner_affair"
#define SPEAK_LINE_LOVE_AFFAIR "bbline_love_affair"
#define SPEAK_LINE_ONLY_ONE_OWNER "bbline_only_one_owner"
#define SPEAK_LINE_ALREADY_HAVE_OWNER "bbline_already_have_owner"
#define SPEAK_LINE_CAN_NOT_BE_OWNED "bbline_can_not_be_owned"
/// love/hate
#define SPEAK_LINE_NEW_LOVE "bbline_i_love_you_new"
#define SPEAK_LINE_LOVE "bbline_i_love_you"
#define SPEAK_LINE_LOVE_OWNER "bbline_i_love_you_owner"
#define SPEAK_LINE_HATE "bbline_i_hate_you"
#define SPEAK_LINE_PAIN "bbline_i_love_pain"
#define SPEAK_LINE_HATE_4REAL "bbline_i_hate_you_4real"
#define SPEAK_LINE_HATE_4REAL_OWNER "bbline_i_hate_you_4real_owner"
#define SPEAK_LINE_NEW_LOVE_OWNER "bbline_i_love_you_owner_new"
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
#define SPEAK_LINE_BREAKUP "bbline_breakup_with_someone"

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
#define SPEAK_LINE_BEEN_A_WHILE "bbline_been_a_while"
#define SPEAK_LINE_AM_LISTENING "bbline_am_listening"

#define SPEAK_LINE_DISLIKE_DROPPED_OWNER "bbline_dislike_dropped_owner"
#define SPEAK_LINE_DISLIKE_DROPPED_LOVER "bbline_dislike_dropped_lover"
#define SPEAK_LINE_DISLIKE_DROPPED "bbline_dislike_dropped"

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

#define SPEAK_LINE_WEARER_CRIT "bbline_wearer_crit"
#define SPEAK_LINE_WEARER_CRIT_YELL_HELP "bbline_wearer_crit_yell_help"
#define SPEAK_LINE_WEARER_CRIT_PANIC "bbline_wearer_crit_panic"
#define SPEAK_LINE_WEARER_CRIT_INJECT "bbline_wearer_crit_inject"

#define SPEAK_LINE_WEARER_DIED "bbline_wearer_died"

#define SPEAK_LINE_STATE_NAME "bbline_state_name"
#define SPEAK_LINE_GREET_NEW_PERSON "bbline_greet_new_person"

#define EMOTE_LINE_GIGGLE "bbline_giggle_emote"
#define EMOTE_LINE_SIGH "bbline_sigh_emote"
#define EMOTE_LINE_HORRIBLE_NOISES "bbline_horrible_noises_emote"
#define EMOTE_LINE_QUIET "bbline_quiet_emote"
#define EMOTE_LINE_BUZZ "bbline_buzz_emote"

#define BB_SPEAK_SOUND "bb_speak_sound"

// amour returns
#define HORNY_MSG "horny"
#define NORMAL_MSG "normal"
#define DISLIKE_MSG "dislike"

#define BB_AMOUR_KEYS list(HORNY_MSG, NORMAL_MSG, DISLIKE_MSG)

#define BB_AMOUR_MIN_FOR_HORNY 50
#define BB_AMOUR_POST_HORNY_MULT -0.02
#define BB_AMOUR_POST_HORNY_MIN 100
#define BB_AMOUR_TOO_HORNY 150
#define BB_AMOUR_MAX 200
#define BB_AMOUR_MIN -200
#define BB_AMOUR_MIN_FOR_DISLIKE -75

#define BB_INITIAL_FORGIVENESS_BLENDER 3
#define BB_MAX_FORGIVENESS_BLENDER 5
#define BB_AMOUR_TO_ADD_FORGIVENESS 100
#define BB_AMOUR_COST_PER_FORGIVENESS 50

#define BB_MAX_LISTENABLE_WORDS 10

/// Emotional Events
#define BB_EVENT_LOVED "loved"
#define BB_EVENT_HATED "hated"

//replacement tokens
#define BB_TOKEN_EXTRA1 "%EXTRA1"
#define BB_TOKEN_EXTRA2 "%EXTRA2"
#define BB_TOKEN_USER "%USER"
#define BB_TOKEN_SEX "%SEX"
#define BB_TOKEN_OWNER "%OWNER"
#define BB_TOKEN_MYNAME "%MYNAME"
#define BB_TOKEN_SRC "%SRC"

///memory search types
#define BB_SEARCH_RELATIONSHIP "relationship"

///Amour flags
#define BB_AF_IS_WORK 		(1<<0)
#define BB_AF_IS_PERSONAL 	(1<<1)

//Memory flags
#define BB_MF_IS_OWNER 		(1<<0)
#define BB_MF_WAS_OWNER 	(1<<1)
#define BB_MF_BEGRUDGED 	(1<<2)
#define BB_MF_PICKED_UP 	(1<<3)
#define BB_MF_EQUIPPED 		(1<<4)
#define BB_MF_SAID_HI_TO 	(1<<5)
#define BB_MF_IS_LOVER	 	(1<<6)
#define BB_MF_IS_HATED	 	(1<<7)

//Relationship Values
#define BB_MR_LOVED 	"relationship_loved"
#define BB_MR_FRIEND 	"relationship_friend"
#define BB_MR_NEUTRAL 	"relationship_neutral"
#define BB_MR_DISLIKED	"relationship_disliked"
#define BB_MR_HATED 	"relationship_hated"

//Remembered events
#define BB_EV_PICKED_UP "event_picked_up"
#define BB_EV_EQUIPPED "event_equipped"
#define BB_EV_DISLIKE_DROPPED "event_dropped_dislike"
#define BB_EV_SAID_HI_TO "event_said_hi_to"
#define BB_EV_LOVEGIGGLE "event_lovegiggled"
#define BB_EV_BEGRUDGED_ACCEPTANCE "event_begrudded_acceptance"
#define BB_EV_OWNERIZE_ATTEMPT "event_ownerize_attmpt"
#define BB_EV_LOVE_ATTEMPT "event_love_attmpt"
#define BB_EV_INTRODUCE "event_introduce"
#define BB_EV_BEEN_A_WHILE "event_introduce"
#define BB_EV_AM_LISTENING "event_am_listening"

//BB cooldowns
#define BB_CD_LOVE_GIGGLE 10 SECONDS
#define BB_CD_BEGRUDGED_ACCEPTANCE 2 HOURS
#define BB_CD_SAID_HI_TO 30 SECONDS
#define BB_CD_PICKED_UP 1 MINUTES
#define BB_CD_EQUIPPED 1 MINUTES
#define BB_CD_DISLIKE_DROPPED 20 MINUTES
#define BB_CD_OWNERIZE_ATTEMPT 5 MINUTES
#define BB_CD_DESPAIR 20 MINUTES
#define BB_CD_LOVE_ATTEMPT 15 SECONDS
#define BB_CD_INTRODUCE 3 HOURS
#define BB_CD_BEEN_A_WHILE 30 MINUTES
#define BB_CD_AM_LISTENING 5 SECONDS

//Memory actions
#define BB_MA_SET_OWNER		"ownerize"
#define BB_MA_DISOWN		"disown"
#define BB_MA_DISOWN_ALL	"disown_all"
#define BB_MA_BEFRIEND		"befriend"
#define BB_MA_UNFRIEND		"unfriend"
#define BB_MA_DISLIKE		"dislike"
#define BB_MA_LOVE			"love"
#define BB_MA_HATE			"hate"
#define BB_MA_FORGIVE		"forgive"
#define BB_MA_FORGET		"forget"
#define BB_MA_PICK_UP		"pick_up"
#define BB_MA_EQUIP			"equip"
#define BB_MA_SAY_HI		"say_hi"

//Memory action returns
#define BB_MAR_HAS_OWNER		"mar_has_owner" // *mar
#define BB_MAR_ONLY_ONE_OWNER	"mar_only_one_owner"
#define BB_MAR_ONLY_ONE_LOVER	"mar_only_one_lover"
#define BB_MAR_NOT_OWNER		"mar_not_owner"
#define BB_MAR_NO_OWNER			"mar_no_owner"
#define BB_MAR_AFFAIR			"mar_affair"
#define BB_MAR_CAN_NOT_BE_OWNED	"mar_can_not_be_owned"
#define BB_MAR_HATES_YOU 		"mar_hates_you"
#define BB_MAR_ALREADY_FRIEND	"mar_already_friend"
#define BB_MAR_NOT_LOVED_ENOUGH	"mar_not_loved_enough"

//Relationship flags
#define BB_RF_CAN_BEFRIEND 			(1<<0)
#define BB_RF_CAN_UNFRIEND 			(1<<1)
#define BB_RF_CAN_BE_OWNED 			(1<<2)
#define BB_RF_CAN_DISOWN 			(1<<3)
#define BB_RF_CAN_HATE 				(1<<4)
#define BB_RF_CAN_LOVE 				(1<<5)
#define BB_RF_ONLY_LOVES_OWNER 		(1<<7)
#define BB_RF_CAN_FORGIVE 			(1<<8)
#define BB_RF_CAN_FORGET 			(1<<9)
#define BB_RF_LOVE_BEFORE_OWNER 	(1<<10)
#define BB_RF_AFFECTS_PERFORMANCE 	(1<<11)
#define BB_RF_VALUES_OWNER 			(1<<12)
#define BB_RF_ONLY_ONE_OWNER		(1<<13)
#define BB_RF_ONLY_ONE_LOVER		(1<<14)
#define BB_RF_DESPERATE				(1<<15)

#define BB_RF_BLENDER (BB_RF_VALUES_OWNER|BB_RF_ONLY_ONE_OWNER|BB_RF_ONLY_ONE_LOVER|BB_RF_ONLY_LOVES_OWNER|BB_RF_CAN_BEFRIEND|BB_RF_CAN_UNFRIEND|BB_RF_CAN_DISOWN|BB_RF_ONLY_LOVES_OWNER|BB_RF_CAN_HATE|BB_RF_CAN_LOVE|BB_RF_CAN_FORGIVE|BB_RF_CAN_FORGET|BB_RF_AFFECTS_PERFORMANCE|BB_RF_CAN_BE_OWNED)


