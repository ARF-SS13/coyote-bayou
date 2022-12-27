/// VALIDBALL DEFINES

// list defines
#define VB_CKEY "ckey"
#define VB_MOBNAME "mob_name"
#define VB_JOBNAME "job_name"
#define VB_PREV_HOLDER_WEAKREF "someones_weakref"

// dummy ckey that tells the endgame screen that nobody touched the darn thing
#define VB_DUMMY_CKEY "OHWOWnobodytouchedit+-!~~"

// list macros
#define VB_CKEY_UPDATE(mob, name, job) list(VB_PREV_HOLDER_WEAKREF = WEAKREF(mob), VB_MOBNAME = name, VB_JOBNAME = job)



