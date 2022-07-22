/*ALL DEFINES RELATED TO AMMO GO HERE*/

//Caliber defines
#define CALIBER_22LR ".22LR rounds"
#define CALIBER_5MM "5mm rounds"
#define CALIBER_556 "5.56mm / .223 rounds"
#define CALIBER_762 "7.62mm / .308 rounds"
#define CALIBER_9MM "9mm rounds"
#define CALIBER_10MM "10mm rounds"
#define CALIBER_14MM "14mm rounds"
#define CALIBER_38 ".38 special rounds"
#define CALIBER_357 ".357 magnum rounds"
#define CALIBER_44 ".44 magnum rounds"
#define CALIBER_45LC ".45 LC rounds"
#define CALIBER_45ACP ".45 ACP rounds"
#define CALIBER_4570 ".45-70 rounds"
#define CALIBER_50MG ".50MG rounds"
#define CALIBER_2MM "2mmEC gauss slugs"
#define CALIBER_SHOTGUN "12 gauge shells"
#define CALIBER_CASELESS "4.73mm caseless"
#define CALIBER_75 ".75 gyrojets"
#define CALIBER_195 "1.95mm rounds"
#define CALIBER_712 "7.12mm rounds"
#define CALIBER_40MM "40mm rounds"
#define CALIBER_MAGNETIC "magnetic rounds"
#define CALIBER_MAGNETIC_HYPER "hypermagnetic rounds"
#define CALIBER_MUSKET_BALL "musket balls"
#define CALIBER_MUSKET_LASER "laser musket packs"
#define CALIBER_MUSKET_PLASMA "plasma musket packs"
#define CALIBER_NEEDLE "needles"
#define CALIBER_ROCKET "rockets"
#define CALIBER_SPEAR "speargun rounds"
#define CALIBER_LASERGATLING "laser gatling charges"
#define CALIBER_LASER "oldlasers"
#define CALIBER_MWS "mwses"
#define CALIBER_ARROW "arrows"
#define CALIBER_FUEL "flamer fuel"
#define CALIBER_FOAM "foam darts"
#define CALIBER_ANY "anything even remotely ammolike"

GLOBAL_LIST_INIT(pipe_rifle_valid_calibers, list(
	CALIBER_22LR,
	CALIBER_5MM,
	CALIBER_556,
	CALIBER_762,
	CALIBER_9MM,
	CALIBER_10MM,
	CALIBER_14MM,
	CALIBER_38,
	CALIBER_357,
	CALIBER_44,
	CALIBER_45LC,
	CALIBER_45ACP,
	CALIBER_4570,
	CALIBER_50MG,
	CALIBER_FOAM,
	CALIBER_MUSKET_BALL,
	CALIBER_SHOTGUN))

GLOBAL_LIST_INIT(zipgun_valid_calibers, list(
	CALIBER_22LR,
	CALIBER_9MM,
	CALIBER_10MM,
	CALIBER_38,
	CALIBER_45LC,
	CALIBER_45ACP))

GLOBAL_LIST_INIT(hobo_gun_mag_fluff, list(
	"prefix" = list("bullet","casing","cartridge","shell"),
	"suffix" = list("chamber","holder","slot","hole","thing","pit"),
	"postfix" = list("-thingy","-majig","...?"," assembly")
))
#define MAGAZINE_CALIBER_CHANGE_STEP_0 0 // use screwdriver to get to step 1
#define MAGAZINE_CALIBER_CHANGE_STEP_1 1 // used a screwdriver on it, ready for a metal part
#define MAGAZINE_CALIBER_CHANGE_STEP_2 2 // used a metal part on it, ready for welding
#define MAGAZINE_CALIBER_CHANGE_STEP_3 3 // used a welder on it, ready for a new casing
