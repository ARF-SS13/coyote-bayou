/* 
 * Lagg's Pet Project: A blender you can marry and raise a family with
 */

/// Blender stimulus inputs
#define STIMULUS_FULL "stimulus_full_brevin"
#define STIMULUS_FULL_SECOND "stimulus_full_reservoir"
#define STIMULUS_NOTHING_TO_PROCESS "stimulus_nothing_to_process"
#define STIMULUS_PROCESSING "stimulus_currently_processing"
#define STIMULUS_ROCKY_ABORT "stimulus_hard_abort"
#define STIMULUS_SOFT_ABORT "stimulus_soft_abort"
#define STIMULUS_DONE_BLENDING "stimulus_finished_processing"
#define STIMULUS_GRINDFAIL "stimulus_failed_processing"
#define STIMULUS_NO_RESERVOIR "stimulus_missing_reservoir"
#define STIMULUS_RAT_BLENDER "stimulus_safety_check"
#define STIMULUS_CYBORG_PART "stimulus_is_borg_part"
#define STIMULUS_DRY_FIRST "stimulus_needs_drying"
#define STIMULUS_BATBOX_GONE "stimulus_missing_component_case"
#define STIMULUS_BATBOX_ELSEWHERE "stimulus_misplaced_component_case"
#define STIMULUS_BUFFER_GONE "stimulus_missing_reservoir"
#define STIMULUS_BUFFER_ELSEWHERE "stimulus_misplaced_reservoir"
#define STIMULUS_LOW_POWER "stimulus_low_power"
#define STIMULUS_PART_MISSING "stimulus_missing_part"
#define STIMULUS_NOTHING_TO_EJECT "stimulus_cant_eject"
#define STIMULUS_CANT_DROP_THING "stimulus_cant_drop"
#define STIMULUS_YEET "stimulus_yeet"
#define STIMULUS_DUMP "stimulus_dump_everything"
#define STIMULUS_CANT_CHANGE_WHILE_BLENDING "stimulus_cant_change_while_running"
#define STIMULUS_SET_MODE_A "stimulus_set_mode_a"
#define STIMULUS_SET_MODE_B "stimulus_set_mode_b"
#define STIMULUS_SET_MODE_C "stimulus_set_mode_c"
#define STIMULUS_SET_MODE_D "stimulus_set_mode_d"
	#define STIMULUS_GRIND_NOW STIMULUS_SET_MODE_A
	#define STIMULUS_JUICE_NOW STIMULUS_SET_MODE_B
	#define STIMULUS_SET_TO_DISPENSER STIMULUS_SET_MODE_C
	#define STIMULUS_SET_TO_GRINDER STIMULUS_SET_MODE_D
#define STIMULUS_SWAP_MODE "stimulus_swap_mode"
#define STIMULUS_EXAMINE_EMPTY "stimulus_nothing_to_examine"
#define STIMULUS_EXAMINE_PAPER_COOLDOWN "stimulus_out_of_paper"
#define STIMULUS_EXAMINE_OKAY "stimulus_examining"
#define STIMULUS_EJECT_BREVIN "stimulus_eject_brevin"
#define STIMULUS_SWAP_BREVIN "stimulus_swap_brevin"
#define STIMULUS_INSERT_BREVIN "stimulus_insert_brevin"
#define STIMULUS_BREVIN_FULL "stimulus_brevin_full"
#define STIMULUS_REAGENT_NOT_FOUND "stimulus_reagent_missing"
#define STIMULUS_STOP_RUNNING "stimulus_stop"
#define STIMULUS_NOT_RUNNING "stimulus_not_running"
#define STIMULUS_ALREADY_BLENDER "stimulus_already_mode_d"
#define STIMULUS_ALREADY_DISPENSER "stimulus_already_mode_c"
#define STIMULUS_MUTE "stimulus_mute"
#define STIMULUS_UNMUTE "stimulus_unmute"
#define STIMULUS_HIYA "stimulus_hi"
#define STIMULUS_HIYA_AGAIN "stimulus_hi_again"
#define STIMULUS_LOVE "stimulus_i_love_you"
#define STIMULUS_HATE "stimulus_i_hate_you"
#define STIMULUS_PAIN "stimulus_i_love_pain"
#define STIMULUS_STUCK_INSIDE "stimulus_something_stuck"
#define STIMULUS_MISSING_HOST "stimulus_no_host"
#define STIMULUS_HORRIBLE_NOISES "stimulus_horrible_noises"
#define STIMULUS_EXAMINE_TRY "stimulus_examine_try"

#define BLENDER_BLENDMODE_GRIND "grinding"
#define BLENDER_BLENDMODE_JUICE "juicing"
#define BLENDER_BELTMODE_BLENDER "grindmode"
#define BLENDER_BELTMODE_DISPENSER "dispenser"

#define CHARGER_LINE_FULL "blenderline_full_brevin"
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
// #define IMPULSE_SWAP_MODE "swap_mode"
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
#define IMPULSE_THEY_DONT_LOVE_PAIN "they_dont_love_pain"
#define IMPULSE_GREET_NEW_OWNER "greet_new_owner"
#define IMPULSE_GREET_OLD_HATER "greet_old_hater"
#define IMPULSE_HARD_RESET "hard_reset"
#define IMPULSE_HARD_RESET2 "hard_reset2"
#define IMPULSE_REMEMBER_PERSON "remember_person"
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

///IMPULSE FLAGS
#define IMPULSE_FLAG_NEEDS_HOST (1<<0)

///IMPULSE PROPS
#define IP_EXTRA1 "%EXTRA1"
#define IP_EXTRA2 "%EXTRA2"

/// SPEAKABLE STIMULI
#define SPEAK_LINE_START "blenderline_start"
#define SPEAK_LINE_FULL "blenderline_full_brevin"
#define SPEAK_LINE_FULL_SECOND "blenderline_full_reservoir"
#define SPEAK_LINE_NOTHING_TO_PROCESS "blenderline_nothing_to_process"
#define SPEAK_LINE_PROCESSING "blenderline_currently_processing"
#define SPEAK_LINE_ROCKY_ABORT "blenderline_hard_abort"
#define SPEAK_LINE_SOFT_ABORT "blenderline_soft_abort"
#define SPEAK_LINE_DONE_BLENDING "blenderline_finished_processing"
#define SPEAK_LINE_GRINDFAIL "blenderline_failed_processing"
#define SPEAK_LINE_NO_RESERVOIR "blenderline_missing_reservoir"
#define SPEAK_LINE_RAT_BLENDER "blenderline_safety_check"
#define SPEAK_LINE_CYBORG_PART "blenderline_is_borg_part"
#define SPEAK_LINE_DRY_FIRST "blenderline_needs_drying"
#define SPEAK_LINE_BATBOX_GONE "blenderline_missing_component_case"
#define SPEAK_LINE_BATBOX_ELSEWHERE "blenderline_misplaced_component_case"
#define SPEAK_LINE_BUFFER_GONE "blenderline_missing_reservoir"
#define SPEAK_LINE_BUFFER_ELSEWHERE "blenderline_misplaced_reservoir"
#define SPEAK_LINE_LOW_POWER "blenderline_low_power"
#define SPEAK_LINE_PART_MISSING "blenderline_missing_part"
#define SPEAK_LINE_NOTHING_TO_EJECT "blenderline_cant_eject"
#define SPEAK_LINE_CANT_DROP_THING "blenderline_cant_drop"
#define SPEAK_LINE_YEET "blenderline_yeet"
#define SPEAK_LINE_DUMP "blenderline_dump_everything"
#define SPEAK_LINE_CANT_CHANGE_WHILE_BLENDING "blenderline_cant_change_while_running"
#define SPEAK_LINE_SET_MODE_A "blenderline_set_mode_a"
#define SPEAK_LINE_SET_MODE_B "blenderline_set_mode_b"
#define SPEAK_LINE_SET_MODE_C "blenderline_set_mode_c"
#define SPEAK_LINE_SET_MODE_D "blenderline_set_mode_d"
	#define SPEAK_LINE_GRIND_NOW SPEAK_LINE_SET_MODE_A
	#define SPEAK_LINE_JUICE_NOW SPEAK_LINE_SET_MODE_B
	#define SPEAK_LINE_SET_TO_DISPENSER SPEAK_LINE_SET_MODE_C
	#define SPEAK_LINE_SET_TO_GRINDER SPEAK_LINE_SET_MODE_D
#define SPEAK_LINE_SWAP_MODE "blenderline_swap_mode"
#define SPEAK_LINE_EXAMINE_EMPTY "blenderline_nothing_to_examine"
#define SPEAK_LINE_EXAMINE_PAPER_COOLDOWN "blenderline_out_of_paper"
#define SPEAK_LINE_EXAMINE_OKAY "blenderline_examining"
#define SPEAK_LINE_EJECT_BREVIN "blenderline_eject_brevin"
#define SPEAK_LINE_SWAP_BREVIN "blenderline_swap_brevin"
#define SPEAK_LINE_INSERT_BREVIN "blenderline_insert_brevin"
#define SPEAK_LINE_BREVIN_FULL "blenderline_brevin_full"
#define SPEAK_LINE_REAGENT_NOT_FOUND "blenderline_reagent_missing"
#define SPEAK_LINE_STOP_RUNNING "blenderline_stop"
#define SPEAK_LINE_NOT_RUNNING "blenderline_not_running"
#define SPEAK_LINE_ALREADY_BLENDER "blenderline_already_mode_d"
#define SPEAK_LINE_ALREADY_DISPENSER "blenderline_already_mode_c"
#define SPEAK_LINE_MUTE "blenderline_mute"
#define SPEAK_LINE_UNMUTE "blenderline_unmute"
#define SPEAK_LINE_HIYA "blenderline_hi"
#define SPEAK_LINE_HIYA_AGAIN "blenderline_hi_again"
/// love/hate
#define SPEAK_LINE_LOVE "blenderline_i_love_you"
#define SPEAK_LINE_HATE "blenderline_i_hate_you"
#define SPEAK_LINE_PAIN "blenderline_i_love_pain"
#define SPEAK_LINE_LOVE_OWNER "blenderline_i_love_you_owner"
#define SPEAK_LINE_HATE_OWNER "blenderline_i_hate_you_owner"
#define SPEAK_LINE_PAIN_OWNER "blenderline_i_love_pain_owner"
#define SPEAK_LINE_NOT_LOVE "blenderline_i_love_you_not"
#define SPEAK_LINE_NOT_HATE "blenderline_i_hate_you_not"
#define SPEAK_LINE_NOT_PAIN "blenderline_i_love_pain_not"
#define SPEAK_LINE_NOT_LOVE_OWNER "blenderline_i_love_you_not_owner"
#define SPEAK_LINE_NOT_HATE_OWNER "blenderline_i_hate_you_not_owner"
#define SPEAK_LINE_NOT_PAIN_OWNER "blenderline_i_love_pain_not_owner"
///
#define SPEAK_LINE_BREAKUP_OWNER "blenderline_breakup_with_owner"

///
#define SPEAK_LINE_STUCK_INSIDE "blenderline_something_stuck"
#define SPEAK_LINE_MISSING_HOST "blenderline_no_host"
#define SPEAK_LINE_HORRIBLE_NOISES "blenderline_horrible_noises"
#define SPEAK_LINE_EXAMINE_TRY "blenderline_examine_try"
#define SPEAK_LINE_CRUSHED "blenderline_crushed"
#define SPEAK_LINE_BEGRUDGING_OBEDIENCE "blenderline_begrudging_obedience"
#define SPEAK_LINE_HARD_RESET1 "blenderline_hard_reset_1"
#define SPEAK_LINE_HARD_RESET2 "blenderline_hard_reset_2"
#define SPEAK_LINE_RETURN_ME_TO_OWNER "blenderline_return_me_to_owner"
#define SPEAK_LINE_GREET_NEW_OWNER "blenderline_greet_new_owner"


#define SPEAK_LINE_CLARIFY_YOU_LOVE_ME "blenderline_clarify_you_love_me"
#define SPEAK_LINE_CLARIFY_YOU_HATE_ME "blenderline_clarify_you_hate_me"
#define SPEAK_LINE_CLARIFY_YOU_LOVE_PAIN "blenderline_clarify_you_love_pain"
#define SPEAK_LINE_CLARIFY_YOU_LOVE_WHO "blenderline_clarify_you_love_who"
#define SPEAK_LINE_CLARIFY_YOU_HATE_WHO "blenderline_clarify_you_hate_who"
#define SPEAK_LINE_CLARIFY_WHO_LOVES_ME "blenderline_clarify_who_loves_me"
#define SPEAK_LINE_CLARIFY_WHO_LOVES_PAIN "blenderline_clarify_who_loves_pain"
#define SPEAK_LINE_CLARIFY_WHO_HATES_ME "blenderline_clarify_who_hates_me"
#define SPEAK_LINE_CLARIFY_CLEAR "blenderline_clarify_clear"
#define SPEAK_LINE_CLARIFY_MISHEARD "blenderline_clarify_misheard"

#define EMOTE_LINE_GIGGLE "blenderline_giggle_emote"
#define EMOTE_LINE_SIGH "blenderline_sigh_emote"
#define EMOTE_LINE_HORRIBLE_NOISES "blenderline_horrible_noises_emote"
#define EMOTE_LINE_QUIET "blenderline_quiet_emote"
#define EMOTE_LINE_BUZZ "blenderline_buzz_emote"


/// Impulses that don't require a host
#define IMPULSE_NOHOST \
			IMPULSE_EXAMINE,\
			IMPULSE_HIYA,\
			IMPULSE_MUTE,\
			IMPULSE_UNMUTE
