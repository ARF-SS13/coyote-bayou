
#define RECOILID "recoil-[recoil_buildup]-[brace_penalty]-[one_hand_penalty]"

#define RECOIL_BASE "recoil_buildup"
#define RECOIL_TWOHAND "brace_penalty"
#define RECOIL_ONEHAND "one_hand_penalty"
#define RECOIL_BRACE_LEVEL "brace_penalty_level"
#define RECOIL_ONEHAND_LEVEL "one_hand_penalty_level"

/proc/getRecoil(recoil_buildup = 0, brace_penalty = 0, one_hand_penalty = 0)
	. = locate(RECOILID)
	if(!.)
		. = new /datum/recoil(recoil_buildup, brace_penalty, one_hand_penalty)

/datum/recoil
	var/recoil_buildup
	var/brace_penalty
	var/one_hand_penalty

	var/brace_penalty_level = 0
	var/one_hand_penalty_level = 0

/datum/recoil/New(_recoil_buildup = 0, _brace_penalty = 0, _one_hand_penalty = 0)
	recoil_buildup = _recoil_buildup
	brace_penalty = _brace_penalty
	one_hand_penalty = _one_hand_penalty
	if(recoil_buildup)
		brace_penalty_level = brace_penalty / recoil_buildup
		one_hand_penalty_level = one_hand_penalty / (recoil_buildup + brace_penalty)
	tag = RECOILID


/datum/recoil/proc/getRating(rating)
	return vars[rating]

// Better for nanoUI data
/datum/recoil/proc/getFancyList()
	return list("Recoil Buildup" = recoil_buildup, "Unbraced Penalty" = brace_penalty, "Onehanding Penalty" = one_hand_penalty)

#undef RECOILID
