//#define EXTOOLS_LOGGING // rust_g is used as a fallback if this is undefined

/proc/extools_log_write()

/proc/extools_finalize_logging()

/proc/auxtools_stack_trace(msg)
	CRASH(msg)

GLOBAL_LIST_EMPTY(auxtools_initialized)

/proc/AUXTOOLS_CHECK(LIB)
	if (!GLOB.auxtools_initialized[LIB] && fexists(LIB))
		var/result = call(LIB,"auxtools_init")()
		if(findtext(result,"SUCCESS"))
			GLOB.auxtools_initialized[LIB] = TRUE
		else
			world.log << result

#define AUXTOOLS_SHUTDOWN(LIB)\
	if (GLOB.auxtools_initialized[LIB] && fexists(LIB))\
		call(LIB,"auxtools_shutdown")();\
		GLOB.auxtools_initialized[LIB] = FALSE;\
