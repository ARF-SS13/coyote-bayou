/*
 * ARMOR DEFINES
 */

/* Zero armor values 
 * * * * * * * * * * * */
#define ARMOR_VALUE_ZERO list(\
		"linemelee" = 0, \
		"linebullet" = 0, \
		"linelaser" = 0, \
		"energy" = 0, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 0)

/* Generic item armor
 * Usually isnt actual armor
 * Has some good fire resist, but thats about it
 * * * * * * * * * * * */
#define ARMOR_VALUE_GENERIC_ITEM list(\
		"linemelee" = 0, \
		"linebullet" = 0, \
		"linelaser" = 0, \
		"energy" = 0, \
		"bomb" = 0, \
		"bio" = 10, \
		"rad" = 10, \
		"fire" = 50, \
		"acid" = 50, \
		"wound" = 0, \
		"damage_threshold" = 0)

/* Basic clothing armor values
 * Mild environmental resistances
 * No actual defense
 * * * * * * * * * * * */
#define ARMOR_VALUE_CLOTHES list(\
		"linemelee" = 0, \
		"linebullet" = 0, \
		"linelaser" = 0, \
		"energy" = 0, \
		"bomb" = 0, \
		"bio" = 10, \
		"rad" = 10, \
		"fire" = 10, \
		"acid" = 10, \
		"wound" = 0, \
		"damage_threshold" = 0)

/* Light armor values
 * High mobility
 * Mild environmental resistances
 * Low defense 
 * Low DT
 * 
 * +20 effective HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_LIGHT list(\
		"linemelee" = 20, \
		"linebullet" = 20, \
		"linelaser" = 20, \
		"energy" = 0, \
		"bomb" = 0, \
		"bio" = 10, \
		"rad" = 10, \
		"fire" = 10, \
		"acid" = 10, \
		"wound" = 5, \
		"damage_threshold" = 1)

/* Medium armor values
 * Decent mobility
 * Decent environmental resistances
 * Decent defense 
 * Decent DT
 * 
 * +35 effective HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_MEDIUM list(\
		"linemelee" = 35, \
		"linebullet" = 35, \
		"linelaser" = 35, \
		"energy" = 5, \
		"bomb" = 10, \
		"bio" = 25, \
		"rad" = 25, \
		"fire" = 25, \
		"acid" = 25, \
		"wound" = 10, \
		"damage_threshold" = 3)

/* Heavy armor values
 * Low mobility
 * Decent environmental resistances
 * High defense 
 * Lot of DT
 * 
 * +45 effective HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_HEAVY list(\
		"linemelee" = 45, \
		"linebullet" = 45, \
		"linelaser" = 45, \
		"energy" = 0, \
		"bomb" = 25, \
		"bio" = 25, \
		"rad" = 25, \
		"fire" = 35, \
		"acid" = 35, \
		"wound" = 25, \
		"damage_threshold" = 5)

/* Salvaged PA values
 * Next to no mobility
 * Good environmental resistances
 * Great defense
 * Lots of DT
 * 
 * +80 effective HP
 * +20 laser HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_SALVAGE list(\
		"linemelee" = 80, \
		"linebullet" = 80, \
		"linelaser" = 100, \
		"energy" = 30, \
		"bomb" = 60, \
		"bio" = 80, \
		"rad" = 50, \
		"fire" = 80, \
		"acid" = 80, \
		"wound" = 45, \
		"damage_threshold" = 10)

/* Power armor values
 * High mobility
 * Amazing environmental resistances
 * OP defense
 * 
 * +125 effective HP
 * +25 laser HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_PA list(\
		"linemelee" = 125, \
		"linebullet" = 125, \
		"linelaser" = 150, \
		"energy" = 40, \
		"bomb" = 90, \
		"bio" = 100, \
		"rad" = 50, \
		"fire" = 95, \
		"acid" = 95, \
		"wound" = 100, \
		"damage_threshold" = 12)

/* Armor Subclass multipliers
 * Modifies base armor slots by these values
 * Environmental and wound armors are multiplied by these values
 * Linearmor armors are added / subtracted to the base values
 * Multiple ones can be applied!
 * Also note, armor multipliers scale with the tier of armor they're applied to!!!
 * * * * * * * * * * * */

/* Environmental armor
 * Multiplies bio, rad, fire, and acid protection
 * T1 - Heavy clothes like jackets and dusters
 * T2 - Hybrid environmental / armor things
 * T3 - Dedicated hazardous environmental suits
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_ENV_T1 list(\
		"bio" = 1.5, \
		"rad" = 1.5, \
		"fire" = 1.5, \
		"acid" = 2)

#define ARMOR_MODIFIER_UP_ENV_T2 list(\
		"bio" = 2, \
		"rad" = 2, \
		"fire" = 2, \
		"acid" = 2)

#define ARMOR_MODIFIER_UP_ENV_T3 list(\
		"bio" = 5, \
		"rad" = 5, \
		"fire" = 3, \
		"acid" = 5)

#define ARMOR_MODIFIER_DOWN_ENV_T1 list(\
		"bio" = 0.5, \
		"rad" = 0.5, \
		"fire" = 0.5, \
		"acid" = 0.5)

#define ARMOR_MODIFIER_DOWN_ENV_T2 list(\
		"bio" = 0.35, \
		"rad" = 0.35, \
		"fire" = 0.35, \
		"acid" = 0.35)

///Actually increases the base damage
#define ARMOR_MODIFIER_DOWN_ENV_T3 list(\
		"bio" = -2, \
		"rad" = -2, \
		"fire" = -2, \
		"acid" = -2)


#define ARMOR_MODIFIER_UP_FIRE_T1 list(\
		"fire" = 1.5)

#define ARMOR_MODIFIER_UP_FIRE_T2 list(\
		"fire" = 2)

#define ARMOR_MODIFIER_UP_FIRE_T3 list(\
		"fire" = 5)

#define ARMOR_MODIFIER_DOWN_FIRE_T1 list(\
		"fire" = 0.5)

#define ARMOR_MODIFIER_DOWN_FIRE_T2 list(\
		"fire" = -1)

#define ARMOR_MODIFIER_DOWN_FIRE_T3 list(\
		"fire" = -2)

#define ARMOR_MODIFIER_UP_BOMB_T1 list(\
		"bomb" = 1.5)

#define ARMOR_MODIFIER_UP_BOMB_T2 list(\
		"bomb" = 3)

#define ARMOR_MODIFIER_UP_BOMB_T3 list(\
		"bomb" = 5)

#define ARMOR_MODIFIER_DOWN_BOMB_T1 list(\
		"bomb" = 0.5)

#define ARMOR_MODIFIER_DOWN_BOMB_T2 list(\
		"bomb" = 0.1)

#define ARMOR_MODIFIER_DOWN_BOMB_T3 list(\
		"bomb" = -2)


/* Bullet armor
 * Adds on bullet protection
 * T1 - A layer of basic protection
 * T2 - Ballistic inserts and such
 * T3 - Dedicated heavy bullet plates
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_BULLET_T1 list(\
		"linebullet" = 2)

#define ARMOR_MODIFIER_UP_BULLET_T2 list(\
		"linebullet" = 3)

#define ARMOR_MODIFIER_UP_BULLET_T3 list(\
		"linebullet" = 3.5)

#define ARMOR_MODIFIER_DOWN_BULLET_T1 list(\
		"linebullet" = 0.80)

#define ARMOR_MODIFIER_DOWN_BULLET_T2 list(\
		"linebullet" = 0.65)

#define ARMOR_MODIFIER_DOWN_BULLET_T3 list(\
		"linebullet" = 0.5)

#define ARMOR_MODIFIER_DOWN_BULLET_T4 list(\
		"linebullet" = 0.35)

/* Melee armor
 * Adds on melee protection
 * T1 - Thicker, padded clothing
 * T2 - Hard metal bits with incomplete coverage
 * T3 - Dedicated heavy plating
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_MELEE_T1 list(\
		"linemelee" = 2)

#define ARMOR_MODIFIER_UP_MELEE_T2 list(\
		"linemelee" = 3)

#define ARMOR_MODIFIER_UP_MELEE_T3 list(\
		"linemelee" = 4.5)

#define ARMOR_MODIFIER_DOWN_MELEE_T1 list(\
		"linemelee" = 0.80)

#define ARMOR_MODIFIER_DOWN_MELEE_T2 list(\
		"linemelee" = 0.65)

#define ARMOR_MODIFIER_DOWN_MELEE_T3 list(\
		"linemelee" = 0.50)

/* Laser armor
 * Adds on laser protection
 * T1 - Thicker, heat resistant clothing
 * T2 - Shiny surface, but not quite polished
 * T3 - Dedicated polished mirror finish
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_LASER_T1 list(\
		"linelaser" = 2)

#define ARMOR_MODIFIER_UP_LASER_T2 list(\
		"linelaser" = 3)

#define ARMOR_MODIFIER_UP_LASER_T3 list(\
		"linelaser" = 3.5)

#define ARMOR_MODIFIER_DOWN_LASER_T1 list(\
		"linelaser" = 0.80)

#define ARMOR_MODIFIER_DOWN_LASER_T2 list(\
		"linelaser" = 0.65)

#define ARMOR_MODIFIER_DOWN_LASER_T3 list(\
		"linelaser" = 0.50)

#define ARMOR_MODIFIER_DOWN_LASER_T4 list(\
		"linelaser" = 0.35)

/* DT tokens
 * Adds on damage threshold
 * T1 - Small plated inserts, or heavy leather
 * T2 - Sturdy plated inserts, or deathclaw plating
 * T3 - Dedicated armor reinforcements
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_DT_T1 list(\
		"damage_threshold" = 0.5)

#define ARMOR_MODIFIER_UP_DT_T2 list(\
		"damage_threshold" = 1)

#define ARMOR_MODIFIER_UP_DT_T3 list(\
		"damage_threshold" = 2)

#define ARMOR_MODIFIER_DOWN_DT_T1 list(\
		"damage_threshold" = -1)

#define ARMOR_MODIFIER_DOWN_DT_T2 list(\
		"damage_threshold" = -2)

#define ARMOR_MODIFIER_DOWN_DT_T3 list(\
		"damage_threshold" = -3)

#define ARMOR_MODIFIER_DOWN_DT_T4 list(\
		"damage_threshold" = -20)

/// Should the modifier MULTiply or ADD the value?
GLOBAL_LIST_INIT(armor_token_operation_legend, list(
		"melee" = "MULT",
		"bullet" = "MULT",
		"laser" = "MULT",
		"linemelee" = "MULT",
		"linebullet" = "MULT",
		"linelaser" = "MULT",
		"energy" = "MULT",
		"bomb" = "MULT",
		"bio" = "MULT",
		"rad" = "MULT",
		"fire" = "MULT",
		"acid" = "MULT",
		"wound" = "MULT",
		"magic" = "MULT",
		"damage_threshold" = "ADD"))


/* Armor slowdowns
 * * * * * * * * * * * */

/* 
 * Global multiplier for armor slowdown
 * Change this, changes them all
*/
#define ARMOR_SLOWDOWN_GLOBAL_MULT 1

/* 
 * No slowdown
 * Yup
*/
#define ARMOR_SLOWDOWN_NONE 0

/* 
 * Light Armor
 * Basically clothes, but more
*/
#define ARMOR_SLOWDOWN_LIGHT 0

/* 
 * Medium Armor
 * Substantial armor
*/
#define ARMOR_SLOWDOWN_MEDIUM 0.5

/* 
 * Heavy Armor
 * Bulky suits of heavy armor
*/
#define ARMOR_SLOWDOWN_HEAVY 1

/* 
 * Salvaged Power Armor
 * Basically wearing a car
*/
#define ARMOR_SLOWDOWN_SALVAGE 2

/* 
 * Power Armor
 * Basically driving a car
*/
#define ARMOR_SLOWDOWN_PA 1

/* Armor slowdown modifiers
 * Multipliers to armor slowdown 
 * * * * * * * * * * * */

/* 
 * Less armor slowdown, yay!
 * T1 - Slightly lighter materials, less clothes
 * T2 - Lightened materials, streamlined or something
 * T3 - Motorized or super ergonomic design
*/
#define ARMOR_SLOWDOWN_LESS_T1 0.9
#define ARMOR_SLOWDOWN_LESS_T2 0.8
#define ARMOR_SLOWDOWN_LESS_T3 0.7

/* 
 * More armor slowdown, ack!
 * T1 - Heavier clothing or padding
 * T2 - Substantial extra plating
 * T3 - Huge slabs of metal
*/
#define ARMOR_SLOWDOWN_MORE_T1 1.1
#define ARMOR_SLOWDOWN_MORE_T2 1.25
#define ARMOR_SLOWDOWN_MORE_T3 1.35

/// Extra tag saying what armor tier this armor is, for description purposes
#define ARMOR_CLOTHING_DESC "This is just a set of clothes, light and breezy, totally unencumbering. Also totally unprotected."

/// Extra tag saying what armor tier this armor is, for description purposes
#define ARMOR_CLOTHING_LIGHT "This is a set of light armor, virtually weightless on your frame, and about as protective as you'd expect."

/// Extra tag saying what armor tier this armor is, for description purposes
#define ARMOR_CLOTHING_MEDIUM "This is a set of medium armor, trading a degree of mobility for increased protection."

/// Extra tag saying what armor tier this armor is, for description purposes
#define ARMOR_CLOTHING_HEAVY "This is a set of heavy armor, heavy, bulky, and built to take a beating."

/// Extra tag saying what armor tier this armor is, for description purposes
#define ARMOR_CLOTHING_SALVAGE "This is a set of salvaged power armor, nigh impenetrable, but weighs about as much as a small car."

/// Extra tag saying what armor tier this armor is, for description purposes
#define ARMOR_CLOTHING_PA "This is a suit of power armor, able to withstand a tank shell and still finish a marathon."

/// Armor caps!
#define ARMOR_CAP_BOMB 100
#define ARMOR_CAP_BIO 90
#define ARMOR_CAP_RAD 90
#define ARMOR_CAP_FIRE 90
#define ARMOR_CAP_ACID 90
#define ARMOR_CAP_MAGIC 100
#define ARMOR_CAP_WOUND 100
#define ARMOR_CAP_DT 40
#define ARMOR_CAP_DR 95

/// Armor stiffness - How much recoil we get while running and gunning!
#define LIGHT_STIFFNESS 1
#define MEDIUM_STIFFNESS 1.5
#define HEAVY_STIFFNESS 2

/// Damages DT is effective with
GLOBAL_LIST_INIT(damage_threshold_valid_types, list("brute", "fire"))

/* DEBUG ARMOR VALUES, DONT ACTUALLY USE
 * 50 armor across the board
 * * * * * * * * * * * */
#define ARMOR_VALUE_DEBUG_50ARMOR_0DT list(\
		"melee" = 50, \
		"bullet" = 50, \
		"laser" = 50, \
		"energy" = 50, \
		"bomb" = 50, \
		"bio" = 50, \
		"rad" = 50, \
		"fire" = 50, \
		"acid" = 50, \
		"wound" = 50, \
		"damage_threshold" = 0)

/* DEBUG ARMOR VALUES, DONT ACTUALLY USE
 * 50 armor across the board
 * 10 DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_DEBUG_50ARMOR_10DT list(\
		"melee" = 50, \
		"bullet" = 50, \
		"laser" = 50, \
		"energy" = 50, \
		"bomb" = 50, \
		"bio" = 50, \
		"rad" = 50, \
		"fire" = 50, \
		"acid" = 50, \
		"wound" = 50, \
		"damage_threshold" = 10)

/* DEBUG ARMOR VALUES, DONT ACTUALLY USE
 * 0 armor across the board
 * 10 DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_DEBUG_0ARMOR_10DT list(\
		"melee" = 0, \
		"bullet" = 0, \
		"laser" = 0, \
		"energy" = 0, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 10)
