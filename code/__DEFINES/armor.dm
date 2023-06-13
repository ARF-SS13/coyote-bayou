/*
 * ARMOR DEFINES
 */

#define ARMOR_LINEMELEE "linemelee"
#define ARMOR_LINEBULLET "linebullet"
#define ARMOR_LINELASER "linelaser"
#define ARMOR_MELEE "melee"
#define ARMOR_BULLET "bullet"
#define ARMOR_LASER "laser"
#define ARMOR_ENERGY "energy"
#define ARMOR_BOMB "bomb"
#define ARMOR_BIO "bio"
#define ARMOR_RAD "rad"
#define ARMOR_FIRE "fire"
#define ARMOR_ACID "acid"
#define ARMOR_MAGIC "magic"
#define ARMOR_WOUND "wound"
#define ARMOR_DAMAGE_THRESHOLD "damage_threshold"


/* Zero armor values
 * * * * * * * * * * * */
#define ARMOR_VALUE_ZERO list(\
		ARMOR_LINEMELEE = 0, \
		ARMOR_LINEBULLET = 0, \
		ARMOR_LINELASER = 0, \
		ARMOR_ENERGY = 0, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 0)

/* Generic item armor
 * Usually isnt actual armor
 * Has some good fire resist, but thats about it
 * * * * * * * * * * * */
#define ARMOR_VALUE_GENERIC_ITEM list(\
		ARMOR_LINEMELEE = 0, \
		ARMOR_LINEBULLET = 0, \
		ARMOR_LINELASER = 0, \
		ARMOR_ENERGY = 0, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 10, \
		ARMOR_RAD = 10, \
		ARMOR_FIRE = 50, \
		ARMOR_ACID = 50, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 0)

/* Basic clothing armor values
 * Mild environmental resistances
 * No actual defense
 * * * * * * * * * * * */
#define ARMOR_VALUE_CLOTHES list(\
		ARMOR_LINEMELEE = 0, \
		ARMOR_LINEBULLET = 0, \
		ARMOR_LINELASER = 0, \
		ARMOR_ENERGY = 0, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 10, \
		ARMOR_RAD = 10, \
		ARMOR_FIRE = 10, \
		ARMOR_ACID = 10, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 0)

/* Light armor values
 * High mobility
 * Mild environmental resistances
 * Low defense
 * Low DT
 *
 * +20 effective HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_LIGHT list(\
		ARMOR_LINEMELEE = 20, \
		ARMOR_LINEBULLET = 20, \
		ARMOR_LINELASER = 20, \
		ARMOR_ENERGY = 0, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 10, \
		ARMOR_RAD = 10, \
		ARMOR_FIRE = 10, \
		ARMOR_ACID = 10, \
		ARMOR_WOUND = 5, \
		ARMOR_DAMAGE_THRESHOLD = 1)

/* Medium armor values
 * Decent mobility
 * Decent environmental resistances
 * Decent defense
 * Decent DT
 *
 * +35 effective HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_MEDIUM list(\
		ARMOR_LINEMELEE = 35, \
		ARMOR_LINEBULLET = 35, \
		ARMOR_LINELASER = 35, \
		ARMOR_ENERGY = 5, \
		ARMOR_BOMB = 10, \
		ARMOR_BIO = 25, \
		ARMOR_RAD = 25, \
		ARMOR_FIRE = 25, \
		ARMOR_ACID = 25, \
		ARMOR_WOUND = 10, \
		ARMOR_DAMAGE_THRESHOLD = 3)

/* Heavy armor values
 * Low mobility
 * Decent environmental resistances
 * High defense
 * Lot of DT
 *
 * +45 effective HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_HEAVY list(\
		ARMOR_LINEMELEE = 45, \
		ARMOR_LINEBULLET = 45, \
		ARMOR_LINELASER = 45, \
		ARMOR_ENERGY = 0, \
		ARMOR_BOMB = 25, \
		ARMOR_BIO = 25, \
		ARMOR_RAD = 25, \
		ARMOR_FIRE = 35, \
		ARMOR_ACID = 35, \
		ARMOR_WOUND = 25, \
		ARMOR_DAMAGE_THRESHOLD = 5)

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
		ARMOR_LINEMELEE = 80, \
		ARMOR_LINEBULLET = 80, \
		ARMOR_LINELASER = 100, \
		ARMOR_ENERGY = 30, \
		ARMOR_BOMB = 60, \
		ARMOR_BIO = 80, \
		ARMOR_RAD = 50, \
		ARMOR_FIRE = 80, \
		ARMOR_ACID = 80, \
		ARMOR_WOUND = 45, \
		ARMOR_DAMAGE_THRESHOLD = 10)

/* Power armor values
 * High mobility
 * Amazing environmental resistances
 * OP defense
 *
 * +125 effective HP
 * +25 laser HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_PA list(\
		ARMOR_LINEMELEE = 125, \
		ARMOR_LINEBULLET = 125, \
		ARMOR_LINELASER = 150, \
		ARMOR_ENERGY = 40, \
		ARMOR_BOMB = 90, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 50, \
		ARMOR_FIRE = 95, \
		ARMOR_ACID = 95, \
		ARMOR_WOUND = 100, \
		ARMOR_DAMAGE_THRESHOLD = 12)
/* * * * * * * * * * * * * * *
 * MOB SPECIFIC ARMOR VALUES *
 * * * * * * * * * * * * * * */

/* Naked ghoul armor
 * Basically nothing
 * Resists laser and plasma
 * Weak to melee
 * No DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_GHOUL_NAKED list(\
		ARMOR_MELEE = 0, \
		ARMOR_BULLET = 0, \
		ARMOR_LASER = 15, \
		ARMOR_ENERGY = 20, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 0)

/* Reaver ghoul armor
 * Bullet resistant vest
 * Resists laser and plasma
 * Very weak to melee
 * Low DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_GHOUL_REAVER list(\
		ARMOR_MELEE = -50, \
		ARMOR_BULLET = 35, \
		ARMOR_LASER = 20, \
		ARMOR_ENERGY = 25, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 2)

/* Glowy ghoul armor
 * trades resistance for sick colors (and DT)
 * Very resistant to laser and plasma
 * Very weak to melee
 * Low DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_GHOUL_GLOWING list(\
		ARMOR_MELEE = -50, \
		ARMOR_BULLET = -10, \
		ARMOR_LASER = 25, \
		ARMOR_ENERGY = 40, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 3)

/* Legendary ghoul armor
 * Tough and glowy!
 * Very resistant to laser and plasma
 * Very weak to melee
 * Low DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_GHOUL_LEGEND list(\
		ARMOR_MELEE = 25, \
		ARMOR_BULLET = 25, \
		ARMOR_LASER = 95, \
		ARMOR_ENERGY = 95, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 11)

/* Supermutant jumpsuit
 * Thicc skin resists melee
 * Green skin weak to lasers and plasma
 * Jumpsuit does nothing
 * Decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_SUPERMUTANT_BASE list(\
		ARMOR_MELEE = 30, \
		ARMOR_BULLET = 10, \
		ARMOR_LASER = -5, \
		ARMOR_ENERGY = -10, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 3)

/* Supermutant melee guy
 * Thicc skin resists melee
 * Heavy armor resists bullet too
 * Green skin weak to lasers and plasma, leather burns too
 * Decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_SUPERMUTANT_MELEE list(\
		ARMOR_MELEE = 45, \
		ARMOR_BULLET = 35, \
		ARMOR_LASER = -5, \
		ARMOR_ENERGY = -30, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 3)

/* Supermutant ranger
 * Thicc skin resists melee
 * Medium-ish armor resists bullet too
 * Green skin weak to lasers and plasma, leather burns too
 * Low DT (cus they're the weak ones, gotta use a gun lol)
 * * * * * * * * * * * */
#define ARMOR_VALUE_SUPERMUTANT_RANGER list(\
		ARMOR_MELEE = 35, \
		ARMOR_BULLET = 20, \
		ARMOR_LASER = -5, \
		ARMOR_ENERGY = -10, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 0)

/* Supermutant legendary
 * Thicc skin resists melee super hard
 * Legendary status armor resists bullet too, a lot
 * Green skin weak to lasers and plasma, leather burns too
 * High DT (cus legends never die)
 * * * * * * * * * * * */
#define ARMOR_VALUE_SUPERMUTANT_LEGEND list(\
		ARMOR_MELEE = 40, \
		ARMOR_BULLET = 40, \
		ARMOR_LASER = -5, \
		ARMOR_ENERGY = -5, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 11)

/* Robot Civvy
 * Low DR across the board
 * Kinda weak to lasers (sensors and shit)
 * Resistant to bullets, kinda (metal)
 * Higher DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_ROBOT_CIVILIAN list(\
		ARMOR_MELEE = 5, \
		ARMOR_BULLET = 20, \
		ARMOR_LASER = -5, \
		ARMOR_ENERGY = -5, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 5)

/* Robot Seccie
 * Lowish DR across the board
 * Kinda weak to lasers (sensors and shit)
 * Resistant to bullets, kinda (metal)
 * Higher DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_ROBOT_SECURITY list(\
		ARMOR_MELEE = 10, \
		ARMOR_BULLET = 25, \
		ARMOR_LASER = -5, \
		ARMOR_ENERGY = -5, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 7)

/* Robot Milbot
 * Decent DR across the board
 * Fairly weak to lasers (sensors and shit)
 * Resistant to bullets, kinda (metal)
 * Lot of DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_ROBOT_MILITARY list(\
		ARMOR_MELEE = 15, \
		ARMOR_BULLET = 30, \
		ARMOR_LASER = -20, \
		ARMOR_ENERGY = -20, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 11)

/* Deathclaw Commonboy
 * Just about impervious to bullets
 * Melee is... okay ish
 * Lasers also kinda pathetic
 * Plasma fucks em to death
 * Lot of DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_DEATHCLAW_COMMON list(\
		ARMOR_MELEE = 0, \
		ARMOR_BULLET = 0, \
		ARMOR_LASER = 0, \
		ARMOR_ENERGY = 0, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 15)

/* Deathclaw Mommy
 * Just about impervious to bullets
 * Melee is... okay ish
 * Lasers are a bit better
 * Plasma fucks em to death
 * Lot of DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_DEATHCLAW_MOTHER list(\
		ARMOR_MELEE = 0, \
		ARMOR_BULLET = 0, \
		ARMOR_LASER = 0, \
		ARMOR_ENERGY = 0, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 15)

/* Deathclaw power armor - basically a suer boss fight
 * Power armor + deathclaw = yeah youre not killing this
 * Lot of DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_DEATHCLAW_PA list(\
		ARMOR_MELEE = 85, \
		ARMOR_BULLET = 85, \
		ARMOR_LASER = 95, \
		ARMOR_ENERGY = 10, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 25)

/* Raider leather jacket
 * Basically a leather jacket
 * Melee resistant
 * Laser weak (damn everything is laser weak)
 * Low DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RAIDER_LEATHER_JACKET list(\
		ARMOR_MELEE = 20, \
		ARMOR_BULLET = 5, \
		ARMOR_LASER = -10, \
		ARMOR_ENERGY = -10, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 1)

/* Raider combat armor (rusty)
 * Resistant to bullet and laser
 * Less resistant to melee
 *
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY list(\
		ARMOR_MELEE = 25, \
		ARMOR_BULLET = 35, \
		ARMOR_LASER = 20, \
		ARMOR_ENERGY = 5, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 3)

/* Raider combat armor (good stuff)
 * Rusty combat armor, but better
 * For mango~
 *
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS list(\
		ARMOR_MELEE = 35, \
		ARMOR_BULLET = 45, \
		ARMOR_LASER = 30, \
		ARMOR_ENERGY = 5, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 4)

/* Raider metal armor
 * Reinforced metal armor
 * Heavy melee and laser resist
 * less good bullet resist
 *
 * high DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RAIDER_METAL_ARMOR list(\
		ARMOR_MELEE = 55, \
		ARMOR_BULLET = 35, \
		ARMOR_LASER = 75, \
		ARMOR_ENERGY = -40, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 7)

/* Raider raider armor
 * raider armor
 * leather armor, but less laser weak
 * Also resists plasma
 *
 * Lowish DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RAIDER_ARMOR list(\
		ARMOR_MELEE = 25, \
		ARMOR_BULLET = 5, \
		ARMOR_LASER = 20, \
		ARMOR_ENERGY = 35, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 3)

/* Renegade combat armor
 * Resistant to bullet and laser
 * Less resistant to melee
 * Pretty good, in general
 *
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RENEGADE_COMBAT_ARMOR list(\
		ARMOR_MELEE = 20, \
		ARMOR_BULLET = 35, \
		ARMOR_LASER = 20, \
		ARMOR_ENERGY = 5, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 3)

/* Renegade reinforced combat armor
 * Resistant to bullet and laser
 * Less resistant to melee
 * Better in general
 *
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RENEGADE_COMBAT_ARMOR_REINFORCED list(\
		ARMOR_MELEE = 25, \
		ARMOR_BULLET = 40, \
		ARMOR_LASER = 30, \
		ARMOR_ENERGY = 5, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 4)

/* Renegade super combat armor
 * HEAVY melee / bullet resistance
 * less heavy laser resistance
 * Plasma melts thru
 *
 * heavy DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RENEGADE_COMBAT_ARMOR_SUPER list(\
		ARMOR_MELEE = 55, \
		ARMOR_BULLET = 45, \
		ARMOR_LASER = 30, \
		ARMOR_ENERGY = -5, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 10)

/* Renegade sniper armor
 * Generally low resistances
 * High laser / plasma resist tho
 *
 * low DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RENEGADE_SNIPER_ARMOR list(\
		ARMOR_MELEE = 15, \
		ARMOR_BULLET = 20, \
		ARMOR_LASER = 55, \
		ARMOR_ENERGY = 25, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 2)

/* Renegade power armor
 * Its power armor. Heavy. Fuckin. Power armor
 * Good luck
 * Plasma melts thru a little
 *
 * heavy DT
 * * * * * * * * * * * */ //lmfao 85 85 90 lmao lol kek whew lad, maybe not. ~TK
#define ARMOR_VALUE_RENEGADE_POWER_ARMOR list(\
		ARMOR_MELEE = 60, \
		ARMOR_BULLET = 60, \
		ARMOR_LASER = 60, \
		ARMOR_ENERGY = 35, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 8)


/* Ant
 * Good melee / bullet resist
 * meh laser / plas
 * heavy DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_ANTS list(\
		ARMOR_MELEE = 30, \
		ARMOR_BULLET = 25, \
		ARMOR_LASER = 5, \
		ARMOR_ENERGY = 5, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 5)

/* Catslug armor
 * Fairly low
 * Decent mob protection
 * Squooshy hide doesnt help with bullets
 * Lasers
 * Mainly so they can survive mobs a bit more
 * But arent too tricky for players to kill
 * Just in case they get annoying
 * Low DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_CATSLUG list(\
		ARMOR_LINEMELEE = 35, \
		ARMOR_LINEBULLET = -10, \
		ARMOR_LINELASER = -10, \
		ARMOR_ENERGY = -50, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 100, \
		ARMOR_RAD = 100, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 5, \
		ARMOR_DAMAGE_THRESHOLD = 3)

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
 * T4 - Super duper protection
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_ENV_T1 list(\
		ARMOR_BIO = 1.5, \
		ARMOR_RAD = 1.5, \
		ARMOR_FIRE = 1.5, \
		ARMOR_ACID = 2)

#define ARMOR_MODIFIER_UP_ENV_T2 list(\
		ARMOR_BIO = 2, \
		ARMOR_RAD = 2, \
		ARMOR_FIRE = 2, \
		ARMOR_ACID = 2)

#define ARMOR_MODIFIER_UP_ENV_T3 list(\
		ARMOR_BIO = 3, \
		ARMOR_RAD = 3, \
		ARMOR_FIRE = 3, \
		ARMOR_ACID = 3)

/// total protection!!!
#define ARMOR_MODIFIER_UP_ENV_T4 list(\
		ARMOR_BIO = 20, \
		ARMOR_RAD = 20, \
		ARMOR_FIRE = 20, \
		ARMOR_ACID = 20)

#define ARMOR_MODIFIER_DOWN_ENV_T1 list(\
		ARMOR_BIO = 0.5, \
		ARMOR_RAD = 0.5, \
		ARMOR_FIRE = 0.5, \
		ARMOR_ACID = 0.5)

#define ARMOR_MODIFIER_DOWN_ENV_T2 list(\
		ARMOR_BIO = 0.35, \
		ARMOR_RAD = 0.35, \
		ARMOR_FIRE = 0.35, \
		ARMOR_ACID = 0.35)

///Actually increases the base damage
#define ARMOR_MODIFIER_DOWN_ENV_T3 list(\
		ARMOR_BIO = -2, \
		ARMOR_RAD = -2, \
		ARMOR_FIRE = -2, \
		ARMOR_ACID = -2)


#define ARMOR_MODIFIER_UP_FIRE_T1 list(\
		ARMOR_FIRE = 1.5)

#define ARMOR_MODIFIER_UP_FIRE_T2 list(\
		ARMOR_FIRE = 2)

#define ARMOR_MODIFIER_UP_FIRE_T3 list(\
		ARMOR_FIRE = 5)

#define ARMOR_MODIFIER_DOWN_FIRE_T1 list(\
		ARMOR_FIRE = 0.5)

#define ARMOR_MODIFIER_DOWN_FIRE_T2 list(\
		ARMOR_FIRE = -1)

#define ARMOR_MODIFIER_DOWN_FIRE_T3 list(\
		ARMOR_FIRE = -2)

#define ARMOR_MODIFIER_UP_BOMB_T1 list(\
		ARMOR_BOMB = 1.5)

#define ARMOR_MODIFIER_UP_BOMB_T2 list(\
		ARMOR_BOMB = 3)

#define ARMOR_MODIFIER_UP_BOMB_T3 list(\
		ARMOR_BOMB = 5)

#define ARMOR_MODIFIER_DOWN_BOMB_T1 list(\
		ARMOR_BOMB = 0.5)

#define ARMOR_MODIFIER_DOWN_BOMB_T2 list(\
		ARMOR_BOMB = 0.1)

#define ARMOR_MODIFIER_DOWN_BOMB_T3 list(\
		ARMOR_BOMB = -2)


/* Bullet armor
 * Adds on bullet protection
 * T1 - A layer of basic protection
 * T2 - Ballistic inserts and such
 * T3 - Dedicated heavy bullet plates
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_BULLET_T1 list(\
		ARMOR_LINEBULLET = 10)

#define ARMOR_MODIFIER_UP_BULLET_T2 list(\
		ARMOR_LINEBULLET = 25)

#define ARMOR_MODIFIER_UP_BULLET_T3 list(\
		ARMOR_LINEBULLET = 50)

#define ARMOR_MODIFIER_DOWN_BULLET_T1 list(\
		ARMOR_LINEBULLET = -10)

#define ARMOR_MODIFIER_DOWN_BULLET_T2 list(\
		ARMOR_LINEBULLET = -25)

#define ARMOR_MODIFIER_DOWN_BULLET_T3 list(\
		ARMOR_LINEBULLET = -50)

#define ARMOR_MODIFIER_DOWN_BULLET_T4 list(\
		ARMOR_LINEBULLET = -200)

/* Melee armor
 * Adds on melee protection
 * T1 - Thicker, padded clothing
 * T2 - Hard metal bits with incomplete coverage
 * T3 - Dedicated heavy plating
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_MELEE_T1 list(\
		ARMOR_LINEMELEE = 10)

#define ARMOR_MODIFIER_UP_MELEE_T2 list(\
		ARMOR_LINEMELEE = 25)

#define ARMOR_MODIFIER_UP_MELEE_T3 list(\
		ARMOR_LINEMELEE = 50)

#define ARMOR_MODIFIER_DOWN_MELEE_T1 list(\
		ARMOR_LINEMELEE = -10)

#define ARMOR_MODIFIER_DOWN_MELEE_T2 list(\
		ARMOR_LINEMELEE = -25)

#define ARMOR_MODIFIER_DOWN_MELEE_T3 list(\
		ARMOR_LINEMELEE = -50)

/* Laser armor
 * Adds on laser protection
 * T1 - Thicker, heat resistant clothing
 * T2 - Shiny surface, but not quite polished
 * T3 - Dedicated polished mirror finish
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_LASER_T1 list(\
		ARMOR_LINELASER = 10)

#define ARMOR_MODIFIER_UP_LASER_T2 list(\
		ARMOR_LINELASER = 25)

#define ARMOR_MODIFIER_UP_LASER_T3 list(\
		ARMOR_LINELASER = 50)

#define ARMOR_MODIFIER_DOWN_LASER_T1 list(\
		ARMOR_LINELASER = -10)

#define ARMOR_MODIFIER_DOWN_LASER_T2 list(\
		ARMOR_LINELASER = -25)

#define ARMOR_MODIFIER_DOWN_LASER_T3 list(\
		ARMOR_LINELASER = -50)

#define ARMOR_MODIFIER_DOWN_LASER_T4 list(\
		ARMOR_LINELASER = -200)

/* Energy (Plasma / Tesla) armor
 * Adds on energy protection
 * T1 - Thick, heat, and fire resistant clothing
 * T2 - Heavy duty heat shielding, emergency firesuit-like; big jump from T1
 * T3 - Dedicated heat shielding,  advanced firesuit-like (atmos firesuit); +1.5 tiers from this alone
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_ENERGY_T1 list(\
		ARMOR_ENERGY = 10)

#define ARMOR_MODIFIER_UP_ENERGY_T2 list(\
		ARMOR_ENERGY = 25)

#define ARMOR_MODIFIER_UP_ENERGY_T3 list(\
		ARMOR_ENERGY = 50)

#define ARMOR_MODIFIER_DOWN_ENERGY_T1 list(\
		ARMOR_ENERGY = -10)

#define ARMOR_MODIFIER_DOWN_ENERGY_T2 list(\
		ARMOR_ENERGY = -25)

#define ARMOR_MODIFIER_DOWN_ENERGY_T3 list(\
		ARMOR_ENERGY = -50)

#define ARMOR_MODIFIER_DOWN_ENERGY_T4 list(\
		ARMOR_ENERGY = -200)

/* DT tokens
 * Adds on damage threshold
 * T1 - Small plated inserts, or heavy leather
 * T2 - Sturdy plated inserts, or deathclaw plating
 * T3 - Dedicated armor reinforcements
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_DT_T1 list(\
		ARMOR_DAMAGE_THRESHOLD = 0.5)

#define ARMOR_MODIFIER_UP_DT_T2 list(\
		ARMOR_DAMAGE_THRESHOLD = 1)

#define ARMOR_MODIFIER_UP_DT_T3 list(\
		ARMOR_DAMAGE_THRESHOLD = 2)

#define ARMOR_MODIFIER_DOWN_DT_T1 list(\
		ARMOR_DAMAGE_THRESHOLD = -1)

#define ARMOR_MODIFIER_DOWN_DT_T2 list(\
		ARMOR_DAMAGE_THRESHOLD = -2)

#define ARMOR_MODIFIER_DOWN_DT_T3 list(\
		ARMOR_DAMAGE_THRESHOLD = -3)

#define ARMOR_MODIFIER_DOWN_DT_T4 list(\
		ARMOR_DAMAGE_THRESHOLD = -20)

/// Should the modifier MULTiply or ADD the value?
GLOBAL_LIST_INIT(armor_token_operation_legend, list(
		ARMOR_MELEE = "MULT",
		ARMOR_BULLET = "MULT",
		ARMOR_LASER = "MULT",
		ARMOR_LINEMELEE = "ADD",
		ARMOR_LINEBULLET = "ADD",
		ARMOR_LINELASER = "ADD",
		ARMOR_ENERGY = "MULT",
		ARMOR_BOMB = "MULT",
		ARMOR_BIO = "MULT",
		ARMOR_RAD = "MULT",
		ARMOR_FIRE = "MULT",
		ARMOR_ACID = "MULT",
		ARMOR_WOUND = "MULT",
		ARMOR_MAGIC = "MULT",
		ARMOR_DAMAGE_THRESHOLD = "ADD"))


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
#define ARMOR_CAP_BIO 95
#define ARMOR_CAP_RAD 95
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
GLOBAL_LIST_INIT(damage_threshold_valid_types, list("brute", "fire", "oxy", "stamina"))

/// All armor types
GLOBAL_LIST_INIT(all_armor_types, list(
		ARMOR_MELEE,
		ARMOR_BULLET,
		ARMOR_LASER,
		ARMOR_ENERGY,
		ARMOR_BOMB,
		ARMOR_BIO,
		ARMOR_RAD,
		ARMOR_FIRE,
		ARMOR_ACID,
		ARMOR_WOUND,
		ARMOR_DAMAGE_THRESHOLD
))

/* DEBUG ARMOR VALUES, DONT ACTUALLY USE
 * 50 armor across the board
 * * * * * * * * * * * */
#define ARMOR_VALUE_DEBUG_50ARMOR_0DT list(\
		ARMOR_MELEE = 50, \
		ARMOR_BULLET = 50, \
		ARMOR_LASER = 50, \
		ARMOR_ENERGY = 50, \
		ARMOR_BOMB = 50, \
		ARMOR_BIO = 50, \
		ARMOR_RAD = 50, \
		ARMOR_FIRE = 50, \
		ARMOR_ACID = 50, \
		ARMOR_WOUND = 50, \
		ARMOR_DAMAGE_THRESHOLD = 0)

/* DEBUG ARMOR VALUES, DONT ACTUALLY USE
 * 50 armor across the board
 * 10 DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_DEBUG_50ARMOR_10DT list(\
		ARMOR_MELEE = 50, \
		ARMOR_BULLET = 50, \
		ARMOR_LASER = 50, \
		ARMOR_ENERGY = 50, \
		ARMOR_BOMB = 50, \
		ARMOR_BIO = 50, \
		ARMOR_RAD = 50, \
		ARMOR_FIRE = 50, \
		ARMOR_ACID = 50, \
		ARMOR_WOUND = 50, \
		ARMOR_DAMAGE_THRESHOLD = 10)

/* DEBUG ARMOR VALUES, DONT ACTUALLY USE
 * 0 armor across the board
 * 10 DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_DEBUG_0ARMOR_10DT list(\
		ARMOR_MELEE = 0, \
		ARMOR_BULLET = 0, \
		ARMOR_LASER = 0, \
		ARMOR_ENERGY = 0, \
		ARMOR_BOMB = 0, \
		ARMOR_BIO = 0, \
		ARMOR_RAD = 0, \
		ARMOR_FIRE = 0, \
		ARMOR_ACID = 0, \
		ARMOR_WOUND = 0, \
		ARMOR_DAMAGE_THRESHOLD = 10)
