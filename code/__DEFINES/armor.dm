/*
 * ARMOR DEFINES
 */
change it to linearmors
/// Zero armor values
#define ARMOR_VALUE_ZERO list(\
		"melee" = 0, \
		"bullet" = 0, \
		"laser" = 0, \
		"energy" = 0, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0)

/* Basic clothing armor values
 * Mild environmental resistances
 * No actual defense */
#define ARMOR_VALUE_CLOTHES list(\
		"melee" = 0, \
		"bullet" = 0, \
		"laser" = 0, \
		"energy" = 0, \
		"bomb" = 0, \
		"bio" = 10, \
		"rad" = 10, \
		"fire" = 10, \
		"acid" = 10)

/* Light armor values
 * High mobility
 * Mild environmental resistances
 * Low defense */
#define ARMOR_VALUE_LIGHT list(
		"melee" = 10, 
		"bullet" = 10, 
		"laser" = 10, 
		"energy" = 0, 
		"bomb" = 0, 
		"bio" = 10, 
		"rad" = 10, 
		"fire" = 10, 
		"acid" = 0)
