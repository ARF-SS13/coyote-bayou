/datum/movespeed_modifier/strained_muscles
	multiplicative_slowdown = -1
	blacklisted_movetypes = (FLYING|FLOATING)

/datum/movespeed_modifier/pai_spacewalk
	multiplicative_slowdown = 2
	flags = IGNORE_NOSLOW

/datum/movespeed_modifier/species
	movetypes = ~FLYING
	variable = TRUE

/datum/movespeed_modifier/dna_vault_speedup
	blacklisted_movetypes = (FLYING|FLOATING)
	multiplicative_slowdown = -1

/datum/movespeed_modifier/small_stride
	blacklisted_movetypes = (FLOATING|CRAWLING)
	variable = TRUE
	flags = IGNORE_NOSLOW

/datum/movespeed_modifier/ghoulhealone
	multiplicative_slowdown = 0.5

/datum/movespeed_modifier/ghoulhealtwo
	multiplicative_slowdown = 0.8

/datum/movespeed_modifier/ghoulhealthree
	multiplicative_slowdown = 1.5
