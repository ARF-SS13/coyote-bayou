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
 * Bonus melee (lol) as pity -Kelprunner
 * * * * * * * * * * * */
#define ARMOR_VALUE_CLOTHES list(\
		"linemelee" = 5, \
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
		"wound" = 7, \
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
		"wound" = 15, \
		"damage_threshold" = 3)

/* Heavy armor values
 * Low mobility
 * Decent environmental resistances
 * High defense
 * Lot of DT
 *
 * +60 effective HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_HEAVY list(\
		"linemelee" = 60, \
		"linebullet" = 60, \
		"linelaser" = 60, \
		"energy" = 10, \
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
 * +110 effective HP
 * +130 laser HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_SALVAGE list(\
		"linemelee" = 110, \
		"linebullet" = 110, \
		"linelaser" = 130, \
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
 * +140 effective HP
 * +160 laser HP
 * * * * * * * * * * * */
#define ARMOR_VALUE_PA list(\
		"linemelee" = 140, \
		"linebullet" = 140, \
		"linelaser" = 160, \
		"energy" = 40, \
		"bomb" = 90, \
		"bio" = 100, \
		"rad" = 60, \
		"fire" = 95, \
		"acid" = 95, \
		"wound" = 100, \
		"damage_threshold" = 12)
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
		"melee" = 0, \
		"bullet" = 0, \
		"laser" = 15, \
		"energy" = 20, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 0)

/* Reaver ghoul armor
 * Bullet resistant vest
 * Resists laser and plasma
 * Very weak to melee
 * Low DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_GHOUL_REAVER list(\
		"melee" = -50, \
		"bullet" = 35, \
		"laser" = 20, \
		"energy" = 25, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 2)

/* Glowy ghoul armor
 * trades resistance for sick colors (and DT)
 * Very resistant to laser and plasma
 * Very weak to melee
 * Low DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_GHOUL_GLOWING list(\
		"melee" = -50, \
		"bullet" = -10, \
		"laser" = 25, \
		"energy" = 40, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 3)

/* cold ghoul armor
 * So cold that heat attacks dont hurt em
 * however that works
 * but kinetic stuff smashes em to pieces
 * * * * * * * * * * * */
#define ARMOR_VALUE_GHOUL_COLD list(\
		"melee" = -50, \
		"bullet" = -50, \
		"laser" = 80, \
		"energy" = 80, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 7)

/* colder ghoul armor
 * So cold that heat attacks dont hurt em
 * however that works
 * but kinetic stuff smashes em to pieces
 * * * * * * * * * * * */
#define ARMOR_VALUE_GHOUL_COLDER list(\
		"melee" = -50, \
		"bullet" = -50, \
		"laser" = 95, \
		"energy" = 95, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 7)

/* Ghouls, in armor!
 * combat armor, to be specific
 * * * * * * * * * * * */
#define ARMOR_VALUE_GHOUL_COMBAT list(\
		"melee" = 25, \
		"bullet" = 40, \
		"laser" = 55, \
		"energy" = 95, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 4)

/* Ghouls, in armor!
 * power armor, to be specific
 * * * * * * * * * * * */
#define ARMOR_VALUE_GHOUL_PA list(\
		"melee" = 60, \
		"bullet" = 60, \
		"laser" = 99, \
		"energy" = 99, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 15)

/* Legendary ghoul armor
 * Tough and glowy!
 * Very resistant to laser and plasma
 * Very weak to melee
 * Low DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_GHOUL_LEGEND list(\
		"melee" = 25, \
		"bullet" = 25, \
		"laser" = 95, \
		"energy" = 95, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 11)

/* Supermutant jumpsuit
 * Thicc skin resists melee
 * Green skin weak to lasers and plasma
 * Jumpsuit does nothing
 * Decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_SUPERMUTANT_BASE list(\
		"melee" = 30, \
		"bullet" = 10, \
		"laser" = -5, \
		"energy" = -10, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 3)

/* Supermutant melee guy
 * Thicc skin resists melee
 * Heavy armor resists bullet too
 * Green skin weak to lasers and plasma, leather burns too
 * Decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_SUPERMUTANT_MELEE list(\
		"melee" = 45, \
		"bullet" = 35, \
		"laser" = -5, \
		"energy" = -30, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 3)

/* Supermutant ranger
 * Thicc skin resists melee
 * Medium-ish armor resists bullet too
 * Green skin weak to lasers and plasma, leather burns too
 * Low DT (cus they're the weak ones, gotta use a gun lol)
 * * * * * * * * * * * */
#define ARMOR_VALUE_SUPERMUTANT_RANGER list(\
		"melee" = 35, \
		"bullet" = 20, \
		"laser" = -5, \
		"energy" = -10, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 0)

/* Supermutant legendary
 * Thicc skin resists melee super hard
 * Legendary status armor resists bullet too, a lot
 * Green skin weak to lasers and plasma, leather burns too
 * High DT (cus legends never die)
 * * * * * * * * * * * */
#define ARMOR_VALUE_SUPERMUTANT_LEGEND list(\
		"melee" = 40, \
		"bullet" = 40, \
		"laser" = -5, \
		"energy" = -5, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 11)

/* Robot Civvy
 * Low DR across the board
 * Kinda weak to lasers (sensors and shit)
 * Resistant to bullets, kinda (metal)
 * Higher DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_ROBOT_CIVILIAN list(\
		"melee" = 5, \
		"bullet" = 20, \
		"laser" = -5, \
		"energy" = -5, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 5)

/* Robot Seccie
 * Lowish DR across the board
 * Kinda weak to lasers (sensors and shit)
 * Resistant to bullets, kinda (metal)
 * Higher DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_ROBOT_SECURITY list(\
		"melee" = 10, \
		"bullet" = 25, \
		"laser" = -5, \
		"energy" = -5, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 7)

/* Robot Milbot
 * Decent DR across the board
 * Fairly weak to lasers (sensors and shit)
 * Resistant to bullets, kinda (metal)
 * Lot of DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_ROBOT_MILITARY list(\
		"melee" = 15, \
		"bullet" = 30, \
		"laser" = -20, \
		"energy" = -20, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 11)

/* Deathclaw Commonboy
 * Mash 'em
 * Blast 'em
 * Put 'em in the microwave
 * Bar for entry is low because of how many there are and how close they spawn to player spawns. No .22 or buckshot, basically.
 * * * * * * * * * * * */
#define ARMOR_VALUE_DEATHCLAW_COMMON list(\
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
		"damage_threshold" = 18)

/* Deathclaw Mommy
 * Just about impervious to bullets
 * Melee is... okay ish
 * Lasers are a bit better
 * Plasma fucks em to death
 * DT - Specifically 24 so no starting knives can counter it.
 * * * * * * * * * * * */
// Bar for entry is much higher. You see yellow? You run. Also, shares stats with the legendary aethergiest. - Jaeger
#define ARMOR_VALUE_DEATHCLAW_MOTHER list(\
		"melee" = 20, \
		"bullet" = 30, \
		"laser" = 10, \
		"energy" = 10, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 24) // Bar for entry is much higher. You see yellow? You run. Also, shares stats with the legendary aethergiest.

/* Deathclaw power armor - basically a super boss fight
 * Power armor + aethergiest = yeah youre not killing this
 * Doesn't appear anywhere outside of super dangerous areas that DO NOT offer a power fantasy. Has stats to match it. Regular 5.56 will not do here, bring a melee weapon or something bigger.
 * * * * * * * * * * * */
#define ARMOR_VALUE_DEATHCLAW_PA list(\
		"melee" = 95, \
		"bullet" = 85, \
		"laser" = 95, \
		"energy" = 10, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 37)

/* Raider leather jacket
 * Basically a leather jacket
 * Melee resistant
 * Laser weak (damn everything is laser weak)
 * Low DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RAIDER_LEATHER_JACKET list(\
		"melee" = 20, \
		"bullet" = 5, \
		"laser" = -10, \
		"energy" = -10, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 1)

/* Raider combat armor (rusty)
 * Resistant to bullet and laser
 * Less resistant to melee
 *
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RAIDER_COMBAT_ARMOR_RUSTY list(\
		"melee" = 25, \
		"bullet" = 35, \
		"laser" = 20, \
		"energy" = 5, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 3)

/* Raider combat armor (good stuff)
 * Rusty combat armor, but better
 * For mango~
 *
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RAIDER_COMBAT_ARMOR_BOSS list(\
		"melee" = 35, \
		"bullet" = 45, \
		"laser" = 30, \
		"energy" = 5, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 4)

/* Raider metal armor
 * Reinforced metal armor
 * Heavy melee and laser resist
 * less good bullet resist
 *
 * high DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RAIDER_METAL_ARMOR list(\
		"melee" = 55, \
		"bullet" = 35, \
		"laser" = 75, \
		"energy" = -40, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 7)

/* Raider raider armor
 * raider armor
 * leather armor, but less laser weak
 * Also resists plasma
 *
 * Lowish DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RAIDER_ARMOR list(\
		"melee" = 25, \
		"bullet" = 5, \
		"laser" = 20, \
		"energy" = 35, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 3)

/* Renegade combat armor
 * Resistant to bullet and laser
 * Less resistant to melee
 * Pretty good, in general
 *
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RENEGADE_COMBAT_ARMOR list(\
		"melee" = 20, \
		"bullet" = 35, \
		"laser" = 20, \
		"energy" = 5, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 3)

/* Renegade reinforced combat armor
 * Resistant to bullet and laser
 * Less resistant to melee
 * Better in general
 *
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RENEGADE_COMBAT_ARMOR_REINFORCED list(\
		"melee" = 25, \
		"bullet" = 40, \
		"laser" = 30, \
		"energy" = 5, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 4)

/* Renegade super combat armor
 * HEAVY melee / bullet resistance
 * less heavy laser resistance
 * Plasma melts thru
 *
 * heavy DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RENEGADE_COMBAT_ARMOR_SUPER list(\
		"melee" = 55, \
		"bullet" = 45, \
		"laser" = 30, \
		"energy" = -5, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 10)

/* Renegade sniper armor
 * Generally low resistances
 * High laser / plasma resist tho
 *
 * low DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_RENEGADE_SNIPER_ARMOR list(\
		"melee" = 15, \
		"bullet" = 20, \
		"laser" = 55, \
		"energy" = 25, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 2)

/* Renegade power armor
 * Its power armor. Heavy. Fuckin. Power armor
 * Good luck
 * Plasma melts thru a little
 *
 * heavy DT
 * * * * * * * * * * * */ //lmfao 85 85 90 lmao lol kek whew lad, maybe not. ~TK
#define ARMOR_VALUE_RENEGADE_POWER_ARMOR list(\
		"melee" = 60, \
		"bullet" = 60, \
		"laser" = 60, \
		"energy" = 35, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 8)

/* Syndicate simplemob
 * Resistant to laser and plasma (cus nanotrasen)
 * Less resistant to bullet (thanks goofball)
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_SYNDIE_VEST list(\
		"melee" = 25, \
		"bullet" = 35, \
		"laser" = 50, \
		"energy" = 50, \
		"bomb" = 100, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 4)

/* Syndicate simplemob, melee form
 * Resistant to laser and plasma (cus nanotrasen)
 * Less resistant to bullet (thanks goofball)
 * better DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_SYNDIE_VEST_MELEE list(\
		"melee" = 25, \
		"bullet" = 35, \
		"laser" = 50, \
		"energy" = 50, \
		"bomb" = 100, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 8)

/* Syndicate armor simplemob
 * Resistant to laser and plasma (cus nanotrasen)
 * Less resistant to bullet (thanks goofball)
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_SYNDIE_REDSUIT list(\
		"melee" = 25, \
		"bullet" = 35, \
		"laser" = 65, \
		"energy" = 75, \
		"bomb" = 100, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 6)

/* Syndicate armor simplemob
 * Resistant to laser and plasma (cus nanotrasen)
 * Less resistant to bullet (thanks goofball)
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_SYNDIE_REDSUIT_MELEE list(\
		"melee" = 50, \
		"bullet" = 35, \
		"laser" = 65, \
		"energy" = 75, \
		"bomb" = 100, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 11)

/* Elite Syndicate armor simplemob
 * Very Resistant to laser and plasma (cus nanotrasen + shield)
 * Also resistant to melee cus assistant proof
 * Less resistant to bullet (thanks goofball)
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_SYNDIE_ELITE list(\
		"melee" = 75, \
		"bullet" = 35, \
		"laser" = 85, \
		"energy" = 80, \
		"bomb" = 100, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 10)

/* Elite Syndicate armor simplemob, melee form
 * Very Resistant to laser and plasma (cus nanotrasen + shield)
 * Also resistant to melee cus assistant proof
 * Less resistant to bullet (thanks goofball)
 * better DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_SYNDIE_ELITE_MELEE list(\
		"melee" = 80, \
		"bullet" = 35, \
		"laser" = 85, \
		"energy" = 80, \
		"bomb" = 100, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 12)

/* Skeleton!
 * Projectiles go right through em!
 * But they're weak to melee cus they didnt get their calcium
 * decent DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_SKELETON list(\
		"melee" = -100, \
		"bullet" = 90, \
		"laser" = 90, \
		"energy" = 90, \
		"bomb" = 100, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 0)

/* Ant
 * Good melee / bullet resist
 * meh laser / plas
 * heavy DT
 * * * * * * * * * * * */
#define ARMOR_VALUE_ANTS list(\
		"melee" = 30, \
		"bullet" = 25, \
		"laser" = 5, \
		"energy" = 5, \
		"bomb" = 0, \
		"bio" = 0, \
		"rad" = 0, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 0, \
		"damage_threshold" = 5)

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
		"linemelee" = 35, \
		"linebullet" = -10, \
		"linelaser" = -10, \
		"energy" = -50, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 0, \
		"acid" = 0, \
		"wound" = 5, \
		"damage_threshold" = 3)

/* gross mob spawner pre-spawner thing armor
 * * * * * * * * * * * */
#define ARMOR_VALUE_RIFT list(\
		"melee" = 15, \
		"bullet" = 25, \
		"laser" = 15, \
		"energy" = -1000, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 100, \
		"acid" = 100, \
		"wound" = 100, \
		"damage_threshold" = 5)

/* Bear armor!
 * Unbearable in melee
 * Rather bearable otherwise
 * * * * * * * * * * * */
#define ARMOR_VALUE_BEAR list(\
		"melee" = 25, \
		"bullet" = 15, \
		"laser" = 10, \
		"energy" = 0, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 100, \
		"acid" = 100, \
		"wound" = 100, \
		"damage_threshold" = 4)

/* Bear armor!
 * Unbearable in melee
 * And also in ranged
 * * * * * * * * * * * */
#define ARMOR_VALUE_BEAR_ARMOR list(\
		"melee" = 35, \
		"bullet" = 35, \
		"laser" = 10, \
		"energy" = 0, \
		"bomb" = 0, \
		"bio" = 100, \
		"rad" = 100, \
		"fire" = 100, \
		"acid" = 100, \
		"wound" = 100, \
		"damage_threshold" = 7)

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
		"bio" = 3, \
		"rad" = 3, \
		"fire" = 3, \
		"acid" = 3)

/// total protection!!!
#define ARMOR_MODIFIER_UP_ENV_T4 list(\
		"bio" = 20, \
		"rad" = 20, \
		"fire" = 20, \
		"acid" = 20)

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
		"linebullet" = 10)

#define ARMOR_MODIFIER_UP_BULLET_T2 list(\
		"linebullet" = 25)

#define ARMOR_MODIFIER_UP_BULLET_T3 list(\
		"linebullet" = 50)

#define ARMOR_MODIFIER_DOWN_BULLET_T1 list(\
		"linebullet" = -10)

#define ARMOR_MODIFIER_DOWN_BULLET_T2 list(\
		"linebullet" = -25)

#define ARMOR_MODIFIER_DOWN_BULLET_T3 list(\
		"linebullet" = -50)

#define ARMOR_MODIFIER_DOWN_BULLET_T4 list(\
		"linebullet" = -200)

/* Melee armor
 * Adds on melee protection
 * T1 - Thicker, padded clothing
 * T2 - Hard metal bits with incomplete coverage
 * T3 - Dedicated heavy plating
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_MELEE_T1 list(\
		"linemelee" = 10)

#define ARMOR_MODIFIER_UP_MELEE_T2 list(\
		"linemelee" = 25)

#define ARMOR_MODIFIER_UP_MELEE_T3 list(\
		"linemelee" = 50)

#define ARMOR_MODIFIER_DOWN_MELEE_T1 list(\
		"linemelee" = -10)

#define ARMOR_MODIFIER_DOWN_MELEE_T2 list(\
		"linemelee" = -25)

#define ARMOR_MODIFIER_DOWN_MELEE_T3 list(\
		"linemelee" = -50)

/* Laser armor
 * Adds on laser protection
 * T1 - Thicker, heat resistant clothing
 * T2 - Shiny surface, but not quite polished
 * T3 - Dedicated polished mirror finish
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_LASER_T1 list(\
		"linelaser" = 10)

#define ARMOR_MODIFIER_UP_LASER_T2 list(\
		"linelaser" = 25)

#define ARMOR_MODIFIER_UP_LASER_T3 list(\
		"linelaser" = 50)

#define ARMOR_MODIFIER_DOWN_LASER_T1 list(\
		"linelaser" = -10)

#define ARMOR_MODIFIER_DOWN_LASER_T2 list(\
		"linelaser" = -25)

#define ARMOR_MODIFIER_DOWN_LASER_T3 list(\
		"linelaser" = -50)

#define ARMOR_MODIFIER_DOWN_LASER_T4 list(\
		"linelaser" = -200)

/* Energy (Plasma / Tesla) armor
 * Adds on energy protection
 * T1 - Thick, heat, and fire resistant clothing
 * T2 - Heavy duty heat shielding, emergency firesuit-like; big jump from T1
 * T3 - Dedicated heat shielding,  advanced firesuit-like (atmos firesuit); +1.5 tiers from this alone
 * * * * * * * * * * * */
#define ARMOR_MODIFIER_UP_ENERGY_T1 list(\
		"energy" = 10)

#define ARMOR_MODIFIER_UP_ENERGY_T2 list(\
		"energy" = 25)

#define ARMOR_MODIFIER_UP_ENERGY_T3 list(\
		"energy" = 50)

#define ARMOR_MODIFIER_DOWN_ENERGY_T1 list(\
		"energy" = -10)

#define ARMOR_MODIFIER_DOWN_ENERGY_T2 list(\
		"energy" = -25)

#define ARMOR_MODIFIER_DOWN_ENERGY_T3 list(\
		"energy" = -50)

#define ARMOR_MODIFIER_DOWN_ENERGY_T4 list(\
		"energy" = -200)

/* DT tokens
 * Adds on damage threshold
 * T1 - Small plated inserts, or heavy leather
 * T2 - Sturdy plated inserts, or aethergiest plating
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
		"linemelee" = "ADD",
		"linebullet" = "ADD",
		"linelaser" = "ADD",
		"energy" = "ADD",
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
#define ARMOR_SLOWDOWN_LIGHT 0.15

/*
 * Medium Armor
 * Substantial armor
*/
#define ARMOR_SLOWDOWN_MEDIUM 0.35

/*
 * Heavy Armor
 * Bulky suits of heavy armor
*/
#define ARMOR_SLOWDOWN_HEAVY 0.7

/*
 * Salvaged Power Armor
 * Basically wearing a car
*/
#define ARMOR_SLOWDOWN_SALVAGE 1.7

/*
 * Refurbished Power Armor
 * Basically driving a crappy car
*/
#define ARMOR_SLOWDOWN_REPA 1.2

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
		"melee",
		"bullet",
		"laser",
		"energy",
		"bomb",
		"bio",
		"rad",
		"fire",
		"acid",
		"wound",
		"damage_threshold"
))

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
