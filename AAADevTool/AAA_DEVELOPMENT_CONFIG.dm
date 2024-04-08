/// set to 1 (not TRUE) to make it only load new boston and nothing else
#define SANIC_SPEED 0

#ifdef SANIC_SPEED
#define FORCE_MAP "_maps/pahrump-just_new_boston_only.json"  // quick and dirty exclusion of broken boxstation
#endif
