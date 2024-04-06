#define STARTING_PAYCHECKS 5

#define PAYCHECK_ASSISTANT 25
#define PAYCHECK_MINIMAL 75
#define PAYCHECK_EASY 125
#define PAYCHECK_MEDIUM 175
#define PAYCHECK_HARD 200
#define PAYCHECK_COMMAND 250

#define MAX_GRANT_CIV 2500
#define MAX_GRANT_ENG 3000
#define MAX_GRANT_SCI 5000
#define MAX_GRANT_SECMEDSRV 3000

#define ACCOUNT_CIV "CIV"
#define ACCOUNT_CIV_NAME "Civil Budget"
#define ACCOUNT_ENG "ENG"
#define ACCOUNT_ENG_NAME "Engineering Budget"
#define ACCOUNT_SCI "SCI"
#define ACCOUNT_SCI_NAME "Scientific Budget"
#define ACCOUNT_MED "MED"
#define ACCOUNT_MED_NAME "Medical Budget"
#define ACCOUNT_SRV "SRV"
#define ACCOUNT_SRV_NAME "Service Budget"
#define ACCOUNT_CAR "CAR"
#define ACCOUNT_CAR_NAME "Cargo Budget"
#define ACCOUNT_SEC "SEC"
#define ACCOUNT_SEC_NAME "Defense Budget"

#define NO_FREEBIES "commies go home"

//ID bank account support defines.
#define ID_NO_BANK_ACCOUNT		0
#define ID_FREE_BANK_ACCOUNT	1
#define ID_LOCKED_BANK_ACCOUNT	2

//Some price defines to help standarize the intended vending value of items. Do not bother adding too many examples.
//CB Change - Pull back cost range for items
#define PRICE_FREE				0    // Free items. like job vendors.
#define PRICE_CHEAP_AS_FREE		2    // -
#define PRICE_REALLY_CHEAP		5    // low end ammo.
#define PRICE_PRETTY_CHEAP		8    // -
#define PRICE_CHEAP				10   //  Normal ammo?
#define PRICE_ALMOST_CHEAP		15   // cosmetic clothing, discounted healing items.
#define PRICE_BELOW_NORMAL		17   // -
#define PRICE_NORMAL			20   // Useful clothing.
#define PRICE_ABOVE_NORMAL		25   // low end healing items
#define PRICE_ALMOST_EXPENSIVE	50   // Stimpaks, t3 machine parts.
#define PRICE_EXPENSIVE			80   // -
#define PRICE_ABOVE_EXPENSIVE	120  // Super Stimpaks, higher end weapons
#define PRICE_REALLY_EXPENSIVE	240  // -
#define PRICE_ULTRA_EXPENSIVE   500  // Better weapons.
#define PRICE_ALMOST_ONE_GRAND	1000 // PA, Super high end equipment.

//Specific items for specific price weighting.
//i.e. if such and such should be as expensive as a stimpak.
#define PRICE_STIMPAK          50  // Normal craftable Stimpak
#define PRICE_SUPER_STIM       120 // Super Stimpak
#define PRICE_RESEARCH         200 // Research Documents
#define PRICE_RESEARCH_PLUS    700 // More Expensive Research Documents

#define QUEST_DIFFICULTY_EASY (1 << 0)
#define QUEST_DIFFICULTY_MED (1 << 1)
#define QUEST_DIFFICULTY_HARD (1 << 2)
#define QUEST_DIFFICULTY_CBT (1 << 3)
#define QUEST_DIFFICULTY_GUARANTEED (1 << 10)

#define QUEST_FULFILL_ALL 1
#define QUEST_FULFILL_ANY 2
#define QUEST_FULFILL_HALF 3

#define QUEST_TURNIN_RETURN_QUEST_COMPLETE 15

/// Increasing difficulty causes an increase in the number of things per quota that need filled.
#define QDF_MORE_TURNINS (1 << 0)
/// Increasing difficulty causes an increase in the number of quotas that need filled.
#define QDF_MORE_FILLED (1 << 1)

#define BOUNTY_QUOTA_ITEMS (1 << 0)
#define BOUNTY_QUOTA_MOBS (1 << 1)
#define BOUNTY_QUOTA_DEAD (1 << 2)

/// Credits to Coins
#define COINS_TO_CREDITS(x) (x * 10)
#define CREDITS_TO_COINS(x) (x / 10)

#define QUEST_KIND_KILL_BOSS "kill boss"
#define QUEST_KIND_KILL_MOBS "kill mob"
#define QUEST_KIND_SCAN_MOBS "scan mob"
#define QUEST_KIND_COLLECT_ITEMS "collect item"
#define QUEST_KIND_SCAN_MACHINE "scan machine"

/*
Trash - 4cp (geckos, pillbugs, bloatflies, basic ghouls etc)
Low Tier - 6cp (reavers, glowing ones, eyebots, cazadors etc)
Mid Tier - 10cp/1sp (ants, scorpions, average raiders, mr handys etc)
High Tier - 15cp/1.5sp (spiders, renegades, boss raiders, protectrons etc )
Rare - 20cp/2sp (basic deathclaws, hellpigs, securitrons)
Unique - 50cp/5sp (mango mat, the other fruit guys, etc)
*/

/// Finished quest JSON toqens, for serializzation purposes

#define QF_QUESTER_NAME            "qf_quester_name"
#define QF_QUEST_TYPE              "qf_quest_type"
#define QF_QUEST_NAME              "qf_quest_name"
#define QF_QUEST_DESCRIPTION       "qf_quest_description"
#define QF_QUEST_TIME_COMPLETED    "qf_quest_time_completed"
#define QF_QUEST_ROUND_ID          "qf_quest_round_id"
#define QF_QUEST_DIFFICULTY        "qf_quest_difficulty"
#define QF_QUEST_REWARDED          "qf_quest_rewarded"
#define QF_OBJECTIVES              "qf_objectives"

#define QB_SAVE_QUEST_TYPE         "qb_save_quest_type"
#define QB_SAVE_QUEST_DATA         "qb_save_quest_data"

#define QFBQ_NAME                  "qfbq_name"
#define QFBQ_FLAVOR                "qfbq_flavor"
#define QFBQ_INFO                  "qfbq_info"
#define QFBQ_NEEDED_AMOUNT         "qfbq_needed_amount"
#define QFBQ_GOTTEN_AMOUNT         "qfbq_gotten_amount"
#define QFBQ_DIFFICULTY            "qfbq_difficulty"
#define QFBQ_PRICE_PER_THING       "qfbq_price_per_thing"
#define QFBQ_EASY_MULTIPLIER       "qfbq_easy_multiplier"
#define QFBQ_MEDIUM_MULTIPLIER     "qfbq_medium_multiplier"
#define QFBQ_HARD_MULTIPLIER       "qfbq_hard_multiplier"
#define QFBQ_CBT_MULTIPLIER        "qfbq_cbt_multiplier"
#define QFBQ_MOBS_MUST_BE_DEAD     "qfbq_mobs_must_be_dead"
#define QFBQ_DELETE_THING          "qfbq_delete_thing"
#define QFBQ_CLAIMDELAY            "qfbq_claimdelay"
#define QFBQ_PATHS                 "qfbq_paths"
#define QFBQ_PATHS_EXCLUDE         "qfbq_paths_exclude"
#define QFBQ_PICK_THIS_MANY        "qfbq_pick_this_many"
#define QFBQ_BQ_UID                "qfbq_bq_uid"
#define QFBQ_IS_COPY               "qfbq_is_copy"
#define QFBQ_POST_COPY_FLAGS       "qfbq_post_copy_flags"

#define QFB_NAME                   "qfb_name"
#define QFB_DESCRIPTION            "qfb_description"
#define QFB_UID                    "qfb_uid"
#define QFB_BASE_REWARD            "qfb_base_reward"
#define QFB_MEDIUM_REWARD_BONUS    "qfb_medium_reward_bonus"
#define QFB_HARD_REWARD_BONUS      "qfb_hard_reward_bonus"
#define QFB_CBT_REWARD_BONUS       "qfb_cbt_reward_bonus"
#define QFB_FLAVOR_QUESTGIVERS     "qfb_flavor_questgivers"
#define QFB_FLAVOR_KIND            "qfb_flavor_kind"
#define QFB_FLAVOR_FOCUS           "qfb_flavor_focus"
#define QFB_PAID_OUT               "qfb_paid_out"
#define QFB_COMPLETED              "qfb_completed"
#define QFB_CLAIMED                "qfb_claimed"
#define QFB_HIGH_PRIORITY          "qfb_high_priority"
#define QFB_WEIGHT                 "qfb_weight"
#define QFB_CANDUPE                "qfb_candupe"
#define QFB_RESPECT_EXTINCTION     "qfb_respect_extinction"
#define QFB_REQUEST_MODE           "qfb_request_mode"
#define QFB_INIT_WANTEDS           "qfb_init_wanteds"
#define QFB_WANTED_THINGS          "qfb_wanted_things"
#define QFB_NERFED                 "qfb_nerfed"
#define QFB_DIFFICULTY             "qfb_difficulty"
#define QFB_DIFFICULTY_FLAGS       "qfb_difficulty_flags"
#define QFB_IS_LAGGY_AS_HELL       "qfb_is_laggy_as_hell"
#define QFB_CONGRATS_PHRASES       "qfb_congrats_phrases"
#define QFB_ACCOMPLISHMENT_PHRASES "qfb_accomplishment_phrases"

#define QUEST_BOOK_README "\
	C:/README.txt<br /> \
	=================<br /> \
	Welcome to the Adventurer's Guild Quest Console, helping connect our \
	shattered world through the power of quests! Now partnered with \
	Gekkertec, we are now able to offer a wider variety of quests on a \
	wider variety of platforms running FoxEye 1.0 or higher.<br /> \
	<br /> \
	This console is your one-stop shop for all things quest-related. You can \
	take on quests, complete them, and earn rewards for your efforts. You can \
	also see how you stack up against your fellow adventurers and earn the \
	title of Top Earner or Top Quester!<br /> \
	<br /> \
	At the top of the console, you'll see your username. Please verify that \
	this is in fact you, and if it's not, please contact your local system \
	administrator. To the right, you'll see the unclaimed balance for your \
	work. If this number is greater than 0, you can tap the button to print \
	out a voucher for your earnings, good for use at any participating \
	Adventurer's Guild location. For a list of participating locations, \
	please consult the Adventurer's Guild website.<br /> \
	<br /> \
	Below your username, you'll see your region's Quest Statistics. The \
	left-hand side of the panel lists information relating to the quests \
	completed in this Adventure Cycle. The top number is the number of quests \
	you've completed, the number in the middle is the highest number of \
	quests completed by any adventurer in this cycle, and the bottom number \
	is the total number of quests completed by all adventurers in this cycle.<br /> \
	<br /> \
	The right-hand side of the panel lists information relating to the \
	rewards earned in this Adventure Cycle. The top number is the total \
	amount of your region's currency you've earned this cycle, the middle \
	number is the highest amount of currency earned by any adventurer in this \
	cycle, and the bottom number is the total amount of currency earned by \
	all adventurers in this cycle.<br /> \
	<br /> \
	Below the Quest Statistics panel, you'll see the Quest Console. This \
	panel is divided into three tabs: Active Quests, Available Quests, and \
	Finished Quests. The Active Quests tab lists all the quests you have \
	currently accepted. The Available Quests tab lists all the quests \
	available to your region. The Finished Quests tab lists all the quests \
	you have completed in this cycle.<br /> \
	<br /> \
	Each quest card in the Active Quests and Available Quests tabs lists, \
	from left to right, the quest's difficulty, name, and reward. The quest's \
	difficulty is a rough indicator of the recommended dedication for this \
	quest, as opposed to the actual skill required to do it, and often \
	comes with a higher reward for higher difficulties. To see more information, \
	and to accept or complete the quest, simply tap the card. If you are \
	unable to accept a quest, it will be greyed out.<br /> \
	<br /> \
	At the bottom of the console, you'll see a timer counting down to the \
	next batch of available quests. If you'd like to be alerted when the \
	quests refresh, you can tap the speaker icon to toggle the alert on or \
	off. To the right, you'll see a button to retrieve a Quest Scanner.<br /> \
	<br /> \
	The Quest Scanner is your key to interacting with your quests. To use \
	it, simply use the scanner on the item, creature, or device you want \
	to submit, and if it corresponds to a quest objective, it will attempt \
	to turn it in. The Quest Scanner also comes with an active Quest \
	Detector, which if you use it in hand, will highlight all quest \
	relevant objects within a 7 meter radius.<br /> \
	<br /> \
	If you have any questions, comments, or concerns, please contact your \
	local system administrator. Thank you for using the Adventurer's Guild \
	Quest Console, making whats left of the world a better place, one quest \
	at a time.<br /> \
	<br /> \
	- The Adventurer's Guild \
	<br /> \
	=================<br /> \
	END OF FILE<br />"
