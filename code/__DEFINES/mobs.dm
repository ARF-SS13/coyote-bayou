/*ALL MOB-RELATED DEFINES THAT DON'T BELONG IN ANOTHER FILE GO HERE*/

//Misc mob defines

//Ready states at roundstart for mob/dead/new_player
#define PLAYER_NOT_READY 0
#define PLAYER_READY_TO_PLAY 1
#define PLAYER_READY_TO_OBSERVE 2

//movement intent defines for the m_intent var
#define MOVE_INTENT_WALK "walk"
#define MOVE_INTENT_RUN  "run"

/// Normal baseline blood volume
#define BLOOD_VOLUME_NORMAL 1000
/// The amount blood typically regenerates to on its own
#define BLOOD_VOLUME_SAFE (BLOOD_VOLUME_NORMAL * 0.95)
/// First stage of bloodloss, mostly warnings
#define BLOOD_VOLUME_SYMPTOMS_WARN (BLOOD_VOLUME_NORMAL * 0.70)
/// Second stage of bloodloss, minor harmless symptoms
#define BLOOD_VOLUME_SYMPTOMS_MINOR (BLOOD_VOLUME_NORMAL * 0.60)
/// Third stage of bloodloss, annoying, but not particularly disabling, symptoms
#define BLOOD_VOLUME_SYMPTOMS_ANNOYING (BLOOD_VOLUME_NORMAL * 0.40)
/// Fourth stage of bloodloss, worst symptoms begin, combat sucks
#define BLOOD_VOLUME_SYMPTOMS_DEBILITATING (BLOOD_VOLUME_NORMAL * 0.30)
/// Fifth stage of bloodloss, absolutely disabling, combat is impossible, rip~
#define BLOOD_VOLUME_SYMPTOMS_WORST (BLOOD_VOLUME_NORMAL * 0.20)
/// Okay die now
#define BLOOD_VOLUME_DEATH 1
//Blood levels
#define BLOOD_VOLUME_MAX_LETHAL (BLOOD_VOLUME_NORMAL * 2.50)
#define BLOOD_VOLUME_EXCESS (BLOOD_VOLUME_NORMAL * 2.25)
#define BLOOD_VOLUME_MAXIMUM (BLOOD_VOLUME_NORMAL * 2)
#define BLOOD_VOLUME_SLIME_SPLIT (BLOOD_VOLUME_NORMAL * 1.25)

/// Max level blood stretchers can bring your blood up to
#define BLOOD_VOLUME_EXPANDER_MAX BLOOD_VOLUME_SYMPTOMS_MINOR + 10

/// Max level blood will regenerate naturally with nutrition
#define BLOOD_REFILL_PER_TICK 1

/// Max level blood will regenerate naturally with nutrition
#define BLOOD_REFILL_NUTRITION_MAX BLOOD_VOLUME_NORMAL
/// Nutrition cost for one unit of blood
#define BLOOD_UNIT_NUTRITION_COST 1.25 // 600 nutrition = 400 blood
/// Nutrition spent for being stuffed/fat
#define BLOOD_REFILL_NUTRITION_FAT 3 // Eat a lot for quicker blood regen!
/// Nutrition spent for being full
#define BLOOD_REFILL_NUTRITION_FULL 2.5
/// Nutrition spent for being well fed
#define BLOOD_REFILL_NUTRITION_WELL_FED 1.5
/// Nutrition spent for being fed
#define BLOOD_REFILL_NUTRITION_FED 1
/// Nutrition spent for being hungie
#define BLOOD_REFILL_NUTRITION_HUNGRY 0.5
/// Nutrition spent for being starving
#define BLOOD_REFILL_NUTRITION_STARVING 0

/// Lowest amount normal bleeding can take you
#define BLOOD_VOLUME_LOSS_FLOOR (BLOOD_VOLUME_NORMAL * 0.15)

/// Cap for oxyloss in minor blood loss
#define BLOOD_LOSS_OXYLOSS_CAP_MINOR 10
/// Cap for dizziness in minor blood loss
#define BLOOD_LOSS_DIZZINESS_CAP_MINOR 0
/// Cap for confusion in minor blood loss
#define BLOOD_LOSS_CONFUSION_CAP_MINOR 1
/// Cap for blurriness in minor blood loss
#define BLOOD_LOSS_BLUR_CAP_MINOR 1
/// Cap for stamloss in minor blood loss
#define BLOOD_LOSS_STAMLOSS_CAP_MINOR 25
/// Multiplier sprint buffer in minor blood loss
#define BLOOD_LOSS_SPRINT_BUFFER_MULT_MINOR 1
/// How fast the sprint buffer regens in minor blood loss
#define BLOOD_LOSS_SPRINT_REGEN_MULT_MINOR 0.75
/// How much sprinting a tile costs in minor blood loss
#define BLOOD_LOSS_SPRINT_COST_MULT_MINOR 1.25
/// Chance for a random knockdown
#define BLOOD_LOSS_KNOCKDOWN_CHANCE_MINOR 1
/// Length of a random knockdown
#define BLOOD_LOSS_KNOCKDOWN_LENGTH_MINOR 1 SECONDS
/// Slowdown applied in this level of bloodloss
#define BLOOD_LOSS_SLOWDOWN_MINOR 1

/// Cap for oxyloss in annoying blood loss
#define BLOOD_LOSS_OXYLOSS_CAP_ANNOYING 30
/// Cap for dizziness in annoying blood loss
#define BLOOD_LOSS_DIZZINESS_CAP_ANNOYING 3
/// Cap for confusion in annoying blood loss
#define BLOOD_LOSS_CONFUSION_CAP_ANNOYING 2
/// Cap for blurriness in annoying blood loss
#define BLOOD_LOSS_BLUR_CAP_ANNOYING 3
/// Cap for stamloss in annoying blood loss
#define BLOOD_LOSS_STAMLOSS_CAP_ANNOYING 50
/// Multiplier sprint buffer in annoying blood loss
#define BLOOD_LOSS_SPRINT_BUFFER_MULT_ANNOYING 1
/// How fast the sprint buffer regens in annoying blood loss
#define BLOOD_LOSS_SPRINT_REGEN_MULT_ANNOYING 0.5
/// How much sprinting a tile costs in annoying blood loss
#define BLOOD_LOSS_SPRINT_COST_MULT_ANNOYING 2
/// Chance for a random knockdown
#define BLOOD_LOSS_KNOCKDOWN_CHANCE_ANNOYING 2
/// Length of a random knockdown
#define BLOOD_LOSS_KNOCKDOWN_LENGTH_ANNOYING 2 SECONDS
/// Slowdown applied in this level of bloodloss
#define BLOOD_LOSS_SLOWDOWN_ANNOYING 1.5

/// Cap for oxyloss in worst blood loss
#define BLOOD_LOSS_OXYLOSS_CAP_DEBILITATING 50
/// Cap for dizziness in worst blood loss
#define BLOOD_LOSS_DIZZINESS_CAP_DEBILITATING 5
/// Cap for confusion in worst blood loss
#define BLOOD_LOSS_CONFUSION_CAP_DEBILITATING 5
/// Cap for blurriness in worst blood loss
#define BLOOD_LOSS_BLUR_CAP_DEBILITATING 5
/// Cap for stamloss in worst blood loss
#define BLOOD_LOSS_STAMLOSS_CAP_DEBILITATING 75
/// Multiplier sprint buffer in worst blood loss
#define BLOOD_LOSS_SPRINT_BUFFER_MULT_DEBILITATING 1
/// How fast the sprint buffer regens in worst blood loss
#define BLOOD_LOSS_SPRINT_REGEN_MULT_DEBILITATING 0.25
/// How much sprinting a tile costs in worst blood loss
#define BLOOD_LOSS_SPRINT_COST_MULT_DEBILITATING 4
/// Chance for a random knockdown
#define BLOOD_LOSS_KNOCKDOWN_CHANCE_DEBILITATING 3
/// Length of a random knockdown
#define BLOOD_LOSS_KNOCKDOWN_LENGTH_DEBILITATING 2 SECONDS
/// Slowdown applied in this level of bloodloss
#define BLOOD_LOSS_SLOWDOWN_DEBILITATING 2

/// Cap for oxyloss in worst blood loss
#define BLOOD_LOSS_OXYLOSS_CAP_WORST 87 // constant random passouts
/// Cap for dizziness in worst blood loss
#define BLOOD_LOSS_DIZZINESS_CAP_WORST 30
/// Cap for confusion in worst blood loss
#define BLOOD_LOSS_CONFUSION_CAP_WORST 30
/// Cap for blurriness in worst blood loss
#define BLOOD_LOSS_BLUR_CAP_WORST 30
/// Cap for stamloss in worst blood loss
#define BLOOD_LOSS_STAMLOSS_CAP_WORST 105
/// Multiplier sprint buffer in worst blood loss
#define BLOOD_LOSS_SPRINT_BUFFER_MULT_WORST 1
/// How fast the sprint buffer regens in worst blood loss
#define BLOOD_LOSS_SPRINT_REGEN_MULT_WORST 0.10
/// How much sprinting a tile costs in worst blood loss
#define BLOOD_LOSS_SPRINT_COST_MULT_WORST 10 // basically you cant sprint
/// Chance for a random knockdown
#define BLOOD_LOSS_KNOCKDOWN_CHANCE_WORST 10
/// Length of a random knockdown
#define BLOOD_LOSS_KNOCKDOWN_LENGTH_WORST 5 SECONDS
/// Slowdown applied in this level of bloodloss
#define BLOOD_LOSS_SLOWDOWN_WORST 3

/// Oxyloss when you actually go unconscious
#define BLOOD_LOSS_OXYLOSS_UNCONSCIOUS 90

/// Defines for getting the right anemia message
/// Warning message
#define BLOOD_ANEMIA_MESSAGE_WARN "warning"
/// Minor. Blood loss. Detected.
#define BLOOD_ANEMIA_MESSAGE_MINOR "minor"
/// Annoying anemia level message
#define BLOOD_ANEMIA_MESSAGE_ANNOYING "annoying"
/// Minor. Blood loss. Detected.
#define BLOOD_ANEMIA_MESSAGE_DEBILITATING "debilitating"
/// Annoying anemia level message
#define BLOOD_ANEMIA_MESSAGE_WORST "worst"

//#define BLOOD_VOLUME_SAFE			475
#define BLOOD_VOLUME_OKAY			336
#define BLOOD_VOLUME_BAD			224
#define BLOOD_VOLUME_SURVIVE		122

//Sizes of mobs, used by mob/living/var/mob_size
#define MOB_SIZE_TINY 0
#define MOB_SIZE_SMALL 1
#define MOB_SIZE_HUMAN 2
#define MOB_SIZE_LARGE 3

//Ventcrawling defines
#define VENTCRAWLER_NONE   0
#define VENTCRAWLER_NUDE   1
#define VENTCRAWLER_ALWAYS 2

//Bloodcrawling defines
#define BLOODCRAWL 1
#define BLOODCRAWL_EAT 2

//Mob bio-types flags
#define MOB_ORGANIC 	(1 << 0)
#define MOB_MINERAL		(1 << 1)
#define MOB_ROBOTIC 	(1 << 2)
#define MOB_UNDEAD		(1 << 3)
#define MOB_HUMANOID 	(1 << 4)
#define MOB_BUG 		(1 << 5)
#define MOB_BEAST		(1 << 6)
#define MOB_EPIC		(1 << 7) //megafauna
#define MOB_REPTILE		(1 << 8)
#define MOB_SPIRIT		(1 << 9)
#define MOB_INORGANIC 	(1 << 10)
#define MOB_FERAL		(1 << 11)
#define MOB_SYNTH		(1 << 12)
//Organ defines for carbon mobs
#define ORGAN_ORGANIC   1
#define ORGAN_ROBOTIC   2

#define BODYPART_ORGANIC   1
#define BODYPART_ROBOTIC   2

#define BODYPART_NOT_DISABLED 0
#define BODYPART_DISABLED_DAMAGE 1
#define BODYPART_DISABLED_PARALYSIS 2
#define BODYPART_DISABLED_WOUND 3

#define DEFAULT_BODYPART_ICON 'icons/mob/human_parts.dmi'
#define DEFAULT_BODYPART_ICON_ORGANIC 'icons/mob/human_parts_greyscale.dmi'
#define DEFAULT_BODYPART_ICON_ROBOTIC 'icons/mob/augmentation/augments.dmi'

#define MONKEY_BODYPART "monkey"
#define ALIEN_BODYPART "alien"
#define LARVA_BODYPART "larva"
#define DEVIL_BODYPART "devil"
#define FERAL_BODYPART "feral"
/*see __DEFINES/inventory.dm for bodypart bitflag defines*/

// Health/damage defines for carbon mobs
#define HUMAN_MAX_OXYLOSS 3
#define HUMAN_CRIT_MAX_OXYLOSS (SSmobs.wait/30)

#define HEAT_DAMAGE_LEVEL_1 2 //Amount of damage applied when your body temperature just passes the 360.15k safety point
#define HEAT_DAMAGE_LEVEL_2 3 //Amount of damage applied when your body temperature passes the 400K point
#define HEAT_DAMAGE_LEVEL_3 8 //Amount of damage applied when your body temperature passes the 460K point and you are on fire

#define COLD_DAMAGE_LEVEL_1 0.5 //Amount of damage applied when your body temperature just passes the 260.15k safety point
#define COLD_DAMAGE_LEVEL_2 1.5 //Amount of damage applied when your body temperature passes the 200K point
#define COLD_DAMAGE_LEVEL_3 3 //Amount of damage applied when your body temperature passes the 120K point

//Note that gas heat damage is only applied once every FOUR ticks.
#define HEAT_GAS_DAMAGE_LEVEL_1 2 //Amount of damage applied when the current breath's temperature just passes the 360.15k safety point
#define HEAT_GAS_DAMAGE_LEVEL_2 4 //Amount of damage applied when the current breath's temperature passes the 400K point
#define HEAT_GAS_DAMAGE_LEVEL_3 8 //Amount of damage applied when the current breath's temperature passes the 1000K point

#define COLD_GAS_DAMAGE_LEVEL_1 0.5 //Amount of damage applied when the current breath's temperature just passes the 260.15k safety point
#define COLD_GAS_DAMAGE_LEVEL_2 1.5 //Amount of damage applied when the current breath's temperature passes the 200K point
#define COLD_GAS_DAMAGE_LEVEL_3 3 //Amount of damage applied when the current breath's temperature passes the 120K point

//Brain Damage defines
#define BRAIN_DAMAGE_MILD 20
#define BRAIN_DAMAGE_SEVERE 100
#define BRAIN_DAMAGE_DEATH 200

#define BRAIN_TRAUMA_MILD /datum/brain_trauma/mild
#define BRAIN_TRAUMA_SEVERE /datum/brain_trauma/severe
#define BRAIN_TRAUMA_SPECIAL /datum/brain_trauma/special
#define BRAIN_TRAUMA_MAGIC /datum/brain_trauma/magic

#define TRAUMA_RESILIENCE_BASIC 1      //Curable with chems
#define TRAUMA_RESILIENCE_SURGERY 2    //Curable with brain surgery
#define TRAUMA_RESILIENCE_LOBOTOMY 3   //Curable with lobotomy
#define TRAUMA_RESILIENCE_WOUND 4    //Curable by healing the head wound
#define TRAUMA_RESILIENCE_MAGIC 5      //Curable only with magic
#define TRAUMA_RESILIENCE_ABSOLUTE 6   //This is here to stay

//Limit of traumas for each resilience tier
#define TRAUMA_LIMIT_BASIC 3
#define TRAUMA_LIMIT_SURGERY 2
#define TRAUMA_LIMIT_WOUND 2
#define TRAUMA_LIMIT_LOBOTOMY 3
#define TRAUMA_LIMIT_MAGIC 3
#define TRAUMA_LIMIT_ABSOLUTE INFINITY

#define BRAIN_DAMAGE_INTEGRITY_MULTIPLIER 0.5

//Surgery Defines
#define BIOWARE_GENERIC "generic"
#define BIOWARE_NERVES "nerves"
#define BIOWARE_CIRCULATION "circulation"
#define BIOWARE_LIGAMENTS "ligaments"

//Health hud screws for carbon mobs
#define SCREWYHUD_NONE 0
#define SCREWYHUD_CRIT 1
#define SCREWYHUD_DEAD 2
#define SCREWYHUD_HEALTHY 3

//Threshold levels for beauty for humans
#define BEAUTY_LEVEL_HORRID -66
#define BEAUTY_LEVEL_BAD -33
#define BEAUTY_LEVEL_DECENT 33
#define BEAUTY_LEVEL_GOOD 66
#define BEAUTY_LEVEL_GREAT 100

//Moods levels for humans
#define MOOD_LEVEL_HAPPY4 15
#define MOOD_LEVEL_HAPPY3 10
#define MOOD_LEVEL_HAPPY2 6
#define MOOD_LEVEL_HAPPY1 2
#define MOOD_LEVEL_NEUTRAL 0
#define MOOD_LEVEL_SAD1 -3
#define MOOD_LEVEL_SAD2 -12
#define MOOD_LEVEL_SAD3 -18
#define MOOD_LEVEL_SAD4 -25

//Sanity levels for humans
#define SANITY_AMAZING 150
#define SANITY_GREAT 125
#define SANITY_NEUTRAL 100
#define SANITY_DISTURBED 75
#define SANITY_UNSTABLE 50
#define SANITY_CRAZY 25
#define SANITY_INSANE 0

//Nutrition levels for humans
#define NUTRITION_LEVEL_FAT 600
#define NUTRITION_LEVEL_FULL 550
#define NUTRITION_LEVEL_WELL_FED 450
#define NUTRITION_LEVEL_FED 350
#define NUTRITION_LEVEL_HUNGRY 250
#define NUTRITION_LEVEL_STARVING 150

#define NUTRITION_LEVEL_START_MIN 250
#define NUTRITION_LEVEL_START_MAX 400

//Disgust levels for humans
#define DISGUST_LEVEL_MAXEDOUT 150
#define DISGUST_LEVEL_DISGUSTED 75
#define DISGUST_LEVEL_VERYGROSS 50
#define DISGUST_LEVEL_GROSS 25

//Charge levels for Ethereals
#define ETHEREAL_CHARGE_NONE 0
#define ETHEREAL_CHARGE_LOWPOWER 20
#define ETHEREAL_CHARGE_NORMAL 50
#define ETHEREAL_CHARGE_ALMOSTFULL 75
#define ETHEREAL_CHARGE_FULL 100
#define ETHEREAL_CHARGE_OVERLOAD 125
#define ETHEREAL_CHARGE_DANGEROUS 150

//Slime evolution threshold. Controls how fast slimes can split/grow
#define SLIME_EVOLUTION_THRESHOLD 10

//Slime extract crossing. Controls how many extracts is required to feed to a slime to core-cross.
#define SLIME_EXTRACT_CROSSING_REQUIRED 10

//Slime commands defines
#define SLIME_FRIENDSHIP_FOLLOW 			3 //Min friendship to order it to follow
#define SLIME_FRIENDSHIP_STOPEAT 			5 //Min friendship to order it to stop eating someone
#define SLIME_FRIENDSHIP_STOPEAT_NOANGRY	7 //Min friendship to order it to stop eating someone without it losing friendship
#define SLIME_FRIENDSHIP_STOPCHASE			4 //Min friendship to order it to stop chasing someone (their target)
#define SLIME_FRIENDSHIP_STOPCHASE_NOANGRY	6 //Min friendship to order it to stop chasing someone (their target) without it losing friendship
#define SLIME_FRIENDSHIP_STAY				3 //Min friendship to order it to stay
#define SLIME_FRIENDSHIP_ATTACK				8 //Min friendship to order it to attack

//Sentience types, to prevent things like sentience potions from giving bosses sentience
#define SENTIENCE_ORGANIC 1
#define SENTIENCE_ARTIFICIAL 2
// #define SENTIENCE_OTHER 3 unused
#define SENTIENCE_MINEBOT 4
#define SENTIENCE_BOSS 5

//Mob AI Status

//Hostile simple animals
//If you add a new status, be sure to add a list for it to the simple_animals global in _globalvars/lists/mobs.dm
#define AI_ON		1
#define AI_IDLE		2
#define AI_OFF		3
#define AI_Z_OFF	4

//determines if a mob can smash through it
#define ENVIRONMENT_SMASH_NONE			0
#define ENVIRONMENT_SMASH_STRUCTURES	(1<<0) 	//crates, lockers, ect
#define ENVIRONMENT_SMASH_WALLS			(1<<1)  //walls
#define ENVIRONMENT_SMASH_RWALLS		(1<<2)	//rwalls

#define NO_SLIP_WHEN_WALKING	(1<<0)
#define SLIDE					(1<<1)
#define GALOSHES_DONT_HELP		(1<<2)
#define FLYING_DOESNT_HELP		(1<<3)
#define SLIDE_ICE				(1<<4)
#define SLIP_WHEN_CRAWLING		(1<<5) //clown planet ruin amongst others
#define SLIP_WHEN_JOGGING		(1<<6) //slips prevented by walking are also dodged if the mob is nor sprinting or fatigued... unless this flag is on.


#define MAX_CHICKENS 50
#define MAX_MOTHERCLAWS 25

///Flags used by the flags parameter of electrocute act.

///Makes it so that the shock doesn't take gloves into account.
#define SHOCK_NOGLOVES (1 << 0)
///Used when the shock is from a tesla bolt.
#define SHOCK_TESLA (1 << 1)
///Used when an illusion shocks something. Makes the shock deal stamina damage and not trigger certain secondary effects.
#define SHOCK_ILLUSION (1 << 2)
///The shock doesn't stun.
#define SHOCK_NOSTUN (1 << 3)


#define INCORPOREAL_MOVE_BASIC 1
#define INCORPOREAL_MOVE_SHADOW 2 // leaves a trail of shadows
#define INCORPOREAL_MOVE_JAUNT 3 // is blocked by holy water/salt

//Secbot and ED209 judgement criteria bitflag values
#define JUDGE_EMAGGED		(1<<0)
#define JUDGE_IDCHECK		(1<<1)
#define JUDGE_WEAPONCHECK	(1<<2)
#define JUDGE_RECORDCHECK	(1<<3)
//ED209's ignore monkeys
#define JUDGE_IGNOREMONKEYS	(1<<4)

#define MEGAFAUNA_DEFAULT_RECOVERY_TIME 5

#define SHADOW_SPECIES_LIGHT_THRESHOLD 0.05

// Offsets defines

#define OFFSET_UNIFORM "uniform"
#define OFFSET_ID "id"
#define OFFSET_GLOVES "gloves"
#define OFFSET_GLASSES "glasses"
#define OFFSET_EARS "ears"
#define OFFSET_SHOES "shoes"
#define OFFSET_S_STORE "s_store"
#define OFFSET_FACEMASK "mask"
#define OFFSET_HEAD "head"
#define OFFSET_EYES "eyes"
#define OFFSET_LIPS "lips"
#define OFFSET_BELT "belt"
#define OFFSET_BACK "back"
#define OFFSET_SUIT "suit"
#define OFFSET_NECK "neck"
#define OFFSET_HAIR "hair"
#define OFFSET_FHAIR "fhair"
#define OFFSET_MUTPARTS "mutantparts"

//MINOR TWEAKS/MISC
#define PIXELSHIFT_MIN		-12	//more shifted you can be
#define PIXELSHIFT_MAX		12	//most shifted you can be
#define AGE_MIN				18	//youngest a character can be //CITADEL EDIT - 17 --> 18
#define AGE_MAX				999999999	// If I see one fucking loli dragon I am fucking exploding you people.
#define WIZARD_AGE_MIN		30	//youngest a wizard can be
#define APPRENTICE_AGE_MIN	29	//youngest an apprentice can be
#define SHOES_SLOWDOWN		0	//How much shoes slow you down by default. Negative values speed you up
#define SHOES_SPEED_SLIGHT  SHOES_SLOWDOWN - 1 // slightest speed boost to movement
#define POCKET_STRIP_DELAY			40	//time taken (in deciseconds) to search somebody's pockets
#define DOOR_CRUSH_DAMAGE	15	//the amount of damage that airlocks deal when they crush you
#define WADDLE_MIN		0//waddling animation min/maxes for character creation
#define WADDLE_MAX		6
#define UP_WADDLE_MIN	0
#define UP_WADDLE_MAX	3
#define SIDE_WADDLE_MIN	0
#define SIDE_WADDLE_MAX	4

#define	HUNGER_FACTOR		0.1	//factor at which mob nutrition decreases
#define	ETHEREAL_CHARGE_FACTOR	0.08 //factor at which ethereal's charge decreases
#define	REAGENTS_METABOLISM 0.4	//How many units of reagent are consumed per tick, by default.
#define REAGENTS_EFFECT_MULTIPLIER (REAGENTS_METABOLISM / 0.4)	// By defining the effect multiplier this way, it'll exactly adjust all effects according to how they originally were with the 0.4 metabolism
#define REM (REAGENTS_EFFECT_MULTIPLIER * effect_mult)

// Roundstart trait system

#define MAX_REVIVE_FIRE_DAMAGE 180
#define MAX_REVIVE_BRUTE_DAMAGE 180

// AI Toggles
#define AI_CAMERA_LUMINOSITY	5
#define AI_VOX // Comment out if you don't want VOX to be enabled and have players download the voice sounds.

// /obj/item/bodypart on_mob_life() retval flag
#define BODYPART_LIFE_UPDATE_HEALTH (1<<0)

#define HUMAN_FIRE_STACK_ICON_NUM	3

#define TYPING_INDICATOR_TIMEOUT 20 MINUTES

#define GRAB_PIXEL_SHIFT_PASSIVE 6
#define GRAB_PIXEL_SHIFT_AGGRESSIVE 12
#define GRAB_PIXEL_SHIFT_NECK 16

#define SLEEP_CHECK_DEATH(X) sleep(X); if(QDELETED(src) || stat == DEAD) return;
#define INTERACTING_WITH(X, Y) (Y in X.do_afters)
#define START_INTERACTING_WITH(X, Y) LAZYADD(X.do_afters, Y)
#define STOP_INTERACTING_WITH(X, Y) LAZYREMOVE(X.do_afters, Y)

/// Field of vision defines.
#define FOV_90_DEGREES	90
#define FOV_180_DEGREES	180
#define FOV_270_DEGREES	270

/// How far away you can be to make eye contact with someone while examining
#define EYE_CONTACT_RANGE	5

/// If you examine the same atom twice in this timeframe, we call examine_more() instead of examine()
#define EXAMINE_MORE_TIME	1 SECONDS
//simplemob flagf

#define SILENCE_RANGED_MESSAGE (1<<0)

//living flag
#define HIDE_OFFLINE_INDICATOR (1<<0)

//Saves a proc call, life is suffering. If who has no targets_from var, we assume it's just who
#define GET_TARGETS_FROM(who) (who.targets_from ? who.get_targets_from() : who)

//Respawn timer
#define RESPAWN_TIMER 1

///Define for spawning megafauna instead of a mob for cave gen
#define SPAWN_MEGAFAUNA "bluh bluh huge boss"

// / Breathing types. Lungs can access either by these or by a string, which will be considered a gas ID.
#define BREATH_OXY		/datum/breathing_class/oxygen
#define BREATH_PLASMA	/datum/breathing_class/plasma

/// Mob variation defines
/// Varied mob name
#define MOB_VARIED_NAME_LIST "varied_names"
/// Varied name
#define MOB_NAME_LIST(x...) MOB_VARIED_NAME_LIST = list(x)

/// Use either the above or this one, not both!!! (this one takes priority if you do tho)
/// Varied mob name, using global name lists!
#define MOB_VARIED_NAME_GLOBAL_LIST "varied_global_names"
/// Varied name, with global shit
#define MOB_NAME_FROM_GLOBAL_LIST(x...) MOB_VARIED_NAME_GLOBAL_LIST = list(x)

/// Random name special keys
#define MOB_NAME_RANDOM_MALE "some_male_name"
#define MOB_NAME_RANDOM_FEMALE "some_female_name"
#define MOB_NAME_RANDOM_LIZARD_MALE "some_male_liz_name"
#define MOB_NAME_RANDOM_LIZARD_FEMALE "some_female_liz_name"
#define MOB_NAME_RANDOM_PLASMAMAN "some_plasmeme_name"
#define MOB_NAME_RANDOM_ETHERIAL "some_etherial_name"
#define MOB_NAME_RANDOM_MOTH "some_moff_name"
#define MOB_NAME_RANDOM_ALL_OF_THEM "please_dont_use_this"
/// use this for random pool names, please. Multiples are usable!
#define MOB_RANDOM_NAME(key, count) key = count

/// Varied mob color holder
#define MOB_VARIED_COLOR "varied_color"
/// Varied mob color min
#define MOB_VARIED_COLOR_MIN "colored_min"
/// Varied mob color max
#define MOB_VARIED_COLOR_MAX "colored_max"
/// Varied mob color value setter upper - first 3 numbers are the LOWEST R, G, B values, second 3 numbers are the HIGHEST R, G, B values
#define MOB_COLOR_VARIATION(R1, G1, B1, R2, B2, G2) MOB_VARIED_COLOR = list(MOB_VARIED_COLOR_MIN = list(R1 ? R1 : 255, G1 ? G1 : 255, B1 ? B1 : 255), MOB_VARIED_COLOR_MAX = list(R2 ? R2 : 255, G2 ? G2 : 255, B2 ? B2 : 255))

/// Varied view range define
#define MOB_VARIED_VIEW_RANGE "varied_view_range"
/// Varied view ranges
#define MOB_VIEW_RANGE_LIST(x...) MOB_VARIED_VIEW_RANGE = list(x)

/// Varied aggro range define
#define MOB_VARIED_AGGRO_RANGE "varied_aggro_range"
/// Varied aggro ranges
#define MOB_AGGRO_RANGE_LIST(x...) MOB_VARIED_AGGRO_RANGE = list(x)

/// Varied speed define
#define MOB_VARIED_SPEED "varied_speed"
/// Varied speed chance define
#define MOB_VARIED_SPEED_CHANCE "varied_speed_chance"
/// Varied speed list
#define MOB_SPEED_LIST(x...) MOB_VARIED_SPEED = list(x)
/// Varied speed list chance
#define MOB_SPEED_CHANGE_PER_TURN_CHANCE(x) MOB_VARIED_SPEED_CHANCE = x

/// Varied health define
#define MOB_VARIED_HEALTH "varied_health"
/// Varied health list
#define MOB_HEALTH_LIST(x...) MOB_VARIED_HEALTH = list(x)

/// Varied retreat define
#define MOB_RETREAT_DISTANCE "varied_retreat_distance"
/// Varied retreat define chance
#define MOB_RETREAT_DISTANCE_CHANCE "varied_retreat_distance_chance"
/// Varied retreat list
#define MOB_RETREAT_DISTANCE_LIST(x...) MOB_RETREAT_DISTANCE = list(x)
/// Varied retreat list chance
#define MOB_RETREAT_DISTANCE_CHANGE_PER_TURN_CHANCE(x) MOB_RETREAT_DISTANCE_CHANCE = x

/// Varied minimum define
#define MOB_MINIMUM_DISTANCE "varied_minimum_distance"
/// Varied minimum define chance
#define MOB_MINIMUM_DISTANCE_CHANCE "varied_minimum_distance_chance"
/// Varied minimum list
#define MOB_MINIMUM_DISTANCE_LIST(x...) MOB_MINIMUM_DISTANCE = list(x)
/// Varied minimum list chance
#define MOB_MINIMUM_DISTANCE_CHANGE_PER_TURN_CHANCE(x) MOB_MINIMUM_DISTANCE_CHANCE = x

/// Varied projectile define
#define MOB_PROJECTILE "varied_projectile"
/// Varied projectile list
#define MOB_PROJECTILE_LIST(x...) MOB_PROJECTILE = list(x)
/// Varied projectiles they can shoot, weighted chance to do the thing too
#define MOB_PROJECTILE_ENTRY(proj, chance) proj = chance

/// Mob EMP reaction flags
/// For mobs that react to EMP to do something other than take a little damage

/// Mob gets stunned for a moment
#define MOB_EMP_STUN "mob_gets_stunned"
/// Mob goes berserk for a moment
#define MOB_EMP_BERSERK "mob_goes_nuts"
/// Mob takes damage
#define MOB_EMP_DAMAGE "mob_gets_hurt"
/// Mob gets their combat setting scrambled
#define MOB_EMP_SCRAMBLE "mob_gets_geckoed"

/// cooldown for being spammed with projectile messages
#define ATTACK_MESSAGE_ANTISPAM_TIME 3 SECONDS
/// cooldown for making the DING
#define SIMPLE_MOB_DING_COOLDOWN 3 SECONDS

///living players needed to jump into big mobs
#define BIG_MOB_MIN_PLAYERS 12
///living players needed to jump into medium mobs
#define MED_MOB_MIN_PLAYERS 9
///living players needed to jump into medium mobs
#define SMALL_MOB_MIN_PLAYERS 7
///living players needed to activate full mob ability powers
#define MOB_POWER_FULL_MIN_PLAYERS 12
///living players needed to activate limited mob ability powers
#define MOB_POWER_SOME_MIN_PLAYERS 9

/// Drop everything in the mob loot list
#define MOB_LOOT_ALL "allofit"

/// Simple mob cannot be stamcrit
#define SIMPLEMOB_NO_STAMCRIT -1

/// Max distance you can see tats
#define TATTOO_VISIBILITY_RANGE 50

#define SIMPLEMOB_IGNORE 1

#define PHUD_NONE  "GENITAL_HUD_NONE"
#define PHUD_BUTT  "GENITAL_HUD_BUTT"
#define PHUD_BOOB  "GENITAL_HUD_BREASTS"
#define PHUD_TALLYWHACKER "GENITAL_HUD_PEEN" // COH BLOYME GUV COPOYLOT GOT THEY KNICKAS IN A TWIST OVER THE WORD PENIS WOT WOT
#define PHUD_BALLS "GENITAL_HUD_BALLS"
#define PHUD_VAG   "GENITAL_HUD_VAG"
#define PHUD_BELLY "GENITAL_HUD_BELLY"
#define PHUD_TAIL  "GENITAL_HUD_TAIL"
#define PHUD_WINGS "GENITAL_HUD_WINGS"
#define PHUD_SHIRT "GENITAL_HUD_SHIRT"
#define PHUD_PANTS "GENITAL_HUD_PANTS"
#define PHUD_SOCKS "GENITAL_HUD_SOCKS"
#define PHUD_PVP_FLAG "GENITAL_HUD_pvp_flag"
#define GENITAL_LAYER_OFFSET 0.1  // keep genitals close to the body
#define SOCKS_LAYER_OFFSET 0.2   // undies go over genitals (sometimes)
#define PANTS_LAYER_OFFSET 0.21   // undies go over genitals (sometimes)
#define SHIRT_LAYER_OFFSET 0.22   // undies go over genitals (sometimes)
#define WINGS_LAYER_OFFSET 0.3    // wings go over undies and genitals
#define TAIL_LAYER_OFFSET 0.4     // Tail on the outermost of everything
#define pvp_flag_LAYER_OFFSET 1      // Sexhole warmcock's no-pvp-for-me offset over everything everyuthing
#define MUTANT_PORNHUD_WINGS "wings","wingsopen","deco_wings","insect_wings","insect_fluff"
#define MUTANT_PORNHUD_TAIL "tail", "tailwag", "mam_tail", "mam_tail_animated", "tail_lizard", "tail_human", "spines" ,"waggingtail_human" ,"waggingtail_lizard" ,"waggingspines" ,"mam_waggingtail", "xenotail"

#define MUTANT_PORNHUD_PARTS MUTANT_PORNHUD_TAIL, MUTANT_PORNHUD_WINGS // WHY YES WE DO NEED 5 SEPARATE tails THAT ARE IDENTICAL< WHY DO YOU ASK??
//Gremlins
#define NPC_TAMPER_ACT_FORGET 1 //Don't try to tamper with this again
#define NPC_TAMPER_ACT_NOMSG  2 //Don't produce a visible message

//Game mode list indexes
#define CURRENT_LIVING_PLAYERS	"living_players_list"
#define CURRENT_LIVING_ANTAGS	"living_antags_list"
#define CURRENT_DEAD_PLAYERS	"dead_players_list"
#define CURRENT_OBSERVERS		"current_observers_list"


#define HOSTILES_ATTACK_UNTIL_THIS_FAR_INTO_CRIT 2500

#define PVP_NEUTRAL "pvp_neutral"
#define PVP_YES     "pvp_yes"
#define PVP_NO      "pvp_no"
