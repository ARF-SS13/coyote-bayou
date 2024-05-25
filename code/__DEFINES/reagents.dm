#define SOLID 			1
#define LIQUID			2
#define GAS				3

//reagents reaction var defines
#define REAGENT_NORMAL_PH 7.000
#define REAGENT_PH_ACCURACY 0.001
#define REAGENT_PURITY_ACCURACY 0.001
#define DEFAULT_SPECIFIC_HEAT 200

//reagents_holder_flags defines
#define INJECTABLE		(1<<0)	// Makes it possible to add reagents through droppers and syringes.
#define DRAWABLE		(1<<1)	// Makes it possible to remove reagents through syringes.

#define REFILLABLE		(1<<2)	// Makes it possible to add reagents through any reagent container.
#define DRAINABLE		(1<<3)	// Makes it possible to remove reagents through any reagent container.

#define TRANSPARENT		(1<<4)	// Used on containers which you want to be able to see the reagents off.
#define AMOUNT_VISIBLE	(1<<5)	// For non-transparent containers that still have the general amount of reagents in them visible.
#define NO_REACT        (1<<6)  // Applied to a reagent holder, the contents will not react with each other.

// Is an open container for all intents and purposes.
#define OPENCONTAINER 	(REFILLABLE | DRAINABLE | TRANSPARENT)

//reagents_value defines, basically a multiplier used in reagent containers cargo selling.
#define DEFAULT_REAGENTS_VALUE 1
#define NO_REAGENTS_VALUE 0
#define HARVEST_REAGENTS_VALUE 0.3

/// Standard reagents value defines.
/// Take a grain of salt, only "rare" reagents should have a decent value here, for balance reasons.
/// TL;DR Think of it also like general market request price more than rarity.
#define REAGENT_VALUE_NONE			0	//all the stuff pretty much available in potentially unlimited quantities.
#define REAGENT_VALUE_VERY_COMMON	0.1 //same as above, just not so unlimited.
#define REAGENT_VALUE_COMMON		0.5
#define REAGENT_VALUE_UNCOMMON		1
#define REAGENT_VALUE_RARE			2.5
#define REAGENT_VALUE_VERY_RARE		5
#define REAGENT_VALUE_EXCEPTIONAL	10	//extremely rare or tedious to craft, possibly unsynthetizable, reagents.
#define REAGENT_VALUE_AMAZING		30	//reserved ONLY for non-mass produceable, unsynthetizable reagents.
#define REAGENT_VALUE_GLORIOUS		300	//reagents that shouldn't be possible to get or farm under normal conditions. e.g. Romerol, fungal TB, adminordrazine...

#define TOUCH			1	// splashing
#define INGEST			2	// ingestion
#define VAPOR			3	// foam, spray, blob attack
#define PATCH			4	// patches
#define INJECT			5	// injection

//container_flags
#define PH_WEAK 		(1 << 0)
#define TEMP_WEAK 		(1 << 1)
#define APTFT_VERB		(1 << 2) //APTFT stands for "amount per transfer from this"
#define APTFT_ALTCLICK	(1 << 3)

//defines passed through to the on_reagent_change proc
#define DEL_REAGENT		1	// reagent deleted (fully cleared)
#define ADD_REAGENT		2	// reagent added
#define REM_REAGENT		3	// reagent removed (may still exist)


#define PILL_STYLE_COUNT 22 //Update this if you add more pill icons or you die (literally, we'll toss a nuke at whever your ip turns up)
#define RANDOM_PILL_STYLE 22 //Dont change this one though

#define THRESHOLD_UNHUSK 50 // health threshold for synthflesh/rezadone to unhusk someone

#define SYNTHTISSUE_BORROW_CAP 250	//The cap for synthtissue's borrowed health value when used on someone dead or already having borrowed health.
#define SYNTHTISSUE_DAMAGE_FLIP_CYCLES 45	//After how many cycles the damage will be pure toxdamage as opposed to clonedamage like initially. Gradually changes during its cycles.


//reagent bitflags, used for altering how they works
#define REAGENT_DEAD_PROCESS		(1<<0)	//calls on_mob_dead() if present in a dead body
#define REAGENT_DONOTSPLIT			(1<<1)	//Do not split the chem at all during processing
#define REAGENT_ONLYINVERSE			(1<<2)	//Only invert chem, no splitting
#define REAGENT_ONMOBMERGE			(1<<3)	//Call on_mob_life proc when reagents are merging.
#define REAGENT_INVISIBLE			(1<<4)	//Doesn't appear on handheld health analyzers.
#define REAGENT_FORCEONNEW			(1<<5)  //Forces a on_new() call without a data overhead
#define REAGENT_SNEAKYNAME          (1<<6)  //When inverted, the inverted chem uses the name of the original chem
#define REAGENT_SPLITRETAINVOL      (1<<7)  //Retains initial volume of chem when splitting

//Chemical reaction flags, for determining reaction specialties
#define REACTION_CLEAR_IMPURE       (1<<0)  //Convert into impure/pure on reaction completion
#define REACTION_CLEAR_INVERSE      (1<<1)  //Convert into inverse on reaction completion when purity is low enough

/// now a bunch of stuff for sodie pops!
#define SODIE_TIER_1 1
#define SODIE_TIER_2 2
#define SODIE_TIER_3 3
#define SODIE_TIER_4 4
#define SODIE_TIER_5 5
#define SODIE_TIER_MAX SODIE_TIER_5
#define SODIE_HEALRANK_NONE 0
#define SODIE_HEALRANK_LOW 0.5
#define SODIE_HEALRANK_MED 1
#define SODIE_HEALRANK_HIGH 1.5
#define SODIE_HEALRANK_HIGHER 2
#define SODIE_HEALRANK_HIGHEST 2.5
#define SODIE_HEALRANK_MAX SODIE_HEALRANK_HIGH

#define SODIE_BRUTE_COEFF 0.5
#define SODIE_BRUTE(tier, rank) (SODIE_BRUTE_COEFF * tier * rank)
#define SODIE_BURN_COEFF 0.5
#define SODIE_BURN(tier, rank) (SODIE_BURN_COEFF * tier * rank)
#define SODIE_TOXIN_COEFF 1
#define SODIE_TOXIN(tier, rank) (SODIE_TOXIN_COEFF * tier * rank)
#define SODIE_OXY_COEFF 1
#define SODIE_OXY(tier, rank) (SODIE_OXY_COEFF * tier * rank)
#define SODIE_BRAIN_COEFF 1.5
#define SODIE_BRAIN(tier, rank) (SODIE_BRAIN_COEFF * tier * rank)

///// OKAY HERES HOW THE WHOLE SODIE TIERING STHING WORKS
// All sodie heals start at med heal rank in all categories
// Base sodies are tier 1,

// Sodies made from a simple mixture that's easy to make,
// These are tier 2

// Sodies made from a mixture that's a bit harder to make, 
// Such as needing multiple steps or an upgraded machine
// These are tier 3

// Sodies made from a mixture that's even harder to make,
// Or are somewhat dangerous to drink a lot of
// These are tier 4

// Sodies made from a mixture that's very hard to make,
// Or are very dangerous to drink a lot of
// These are tier 5

// there are a few sodies: Cosmic, Vim, Sunset, Balls, and Atomic Red
// Vim favors brute heals, cus its invigorating and toughens the guts
// Sunset favors burn heals, cus its hecka refreshing
// Cosmic cola favors toxin heals, cus its a bit radioactive
// Balls favors oxygen and brain heals, cus got guarana for days
// Atomic Red has a higher base heal rank, cus I put a lot of effort into making it and you're gonna drink it
// Alcohol drinks have low or no toxin heals, but higher brute/burn heals
// Fruity drinks have low or no brute/burn heals, but higher toxin heals, cus they're good for you


