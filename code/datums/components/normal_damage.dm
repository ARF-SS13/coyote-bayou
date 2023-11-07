#define DEF_NORMAL_DAMAGE_ENDPOINT_DIVISOR		3
#define DEF_NORMAL_DAMAGE_DEVIATION_MULT		0.5
#define DEF_NORMAL_DAMAGE_CRIT_DAM_MULT			2
#define DEF_NORMAL_DAMAGE_CRIT_CHANCE			1

#define NORM_TIER0_MULT 

/**
* Welcome to hell
* This datum holds the variables needed to
* use gaussian/normal distribution damage curves
* on a projectile
*/
/datum/normal_damage_projectile
	/// Mean damage is where the bump of the bell curve is. Your damage will, on average, roll this amount the most and numbers closer to the endpoints the least.
	var/mean = 30
	///Will move the average damage around, but it won't affect the endpoints for min and max damage. ie a 30 mean damage bullet nudged -5 would reduce the mean damage by 5 while retaining its 40 damage max and 20 damage min.
	var/mean_nudge = 0
	/// The right endpoint is derived from dividing the mean damage by the right divisor. For example, a 30 damage bullet with a divisor of 3 would be 30/3=10, so we can roll a max of 30+10=40 damage.
	var/left_endpoint_divisor = DEF_NORMAL_DAMAGE_ENDPOINT_DIVISOR
	/// The left endpoint is derived from dividing the mean damage by the left or right divisor. For example, a 30 damage bullet with a divisor of 3 would be 30/3=10, so we can roll a minimum of 30-10=20 damage.
	var/right_endpoint_divisor = DEF_NORMAL_DAMAGE_ENDPOINT_DIVISOR
	/// Standard deviation controls the flatness of our damage curve. Higher numbers result in flatter curves. By default it should be roughly half of the difference between the right and left endpoints (our damage range).
	var/standard_deviation_mult = DEF_NORMAL_DAMAGE_DEVIATION_MULT
	/// Critical strikes will do their normal damage times this number.
	var/crit_dam_mult = DEF_NORMAL_DAMAGE_CRIT_DAM_MULT
	/// Percentage chance to critically strike and multiply our damage by crit_dam_mult
	var/crit_chance = 1


/**
* Welcome to hell
* This datum holds the variables needed to
* use gaussian/normal distribution damage curves
* on a gun
*/
/datum/normal_damage_gun
	/// The final mean damage will be multiplied by this amount. Be gentle with this.
	var/mean_mult = 1
	/// Adds a flat amount to the mean of our damage. Calculated AFTER mean_mult for true flat damage increase.
	var/mean_add = 0
	/// Guns will add this to the projectile's standard deviation multiplier, which multiplies the mean damage by that much + whatever this is to generate the "flatness" of our damage curve. Higher = flatter.
	var/standard_deviation_mult_add = 0
	/// A gun will multiply the crit chance of its bullet's base crit chance by this much
	var/crit_chance_mult = 1
	/// A gun will flatly add this much crit chance to its projectile
	var/crit_chance_add = 0

/// Returns a gaussian damage calculation based on the normal_damage datums from the projectile and the gun. Also takes in the shooter for quirks later.
/proc/NormalGunDamage(/datum/normal_damage_projectile/P, /datum/normal_damage_gun/G, /mob/living/Shooter, crit)
	if(!P || !G)
		return 0
	var/m = (P.mean * G.mean_mult)+G.mean_add
	var/min = m-(m/P.left_endpoint_divisor)
	var/max = m+(m/P.right_endpoint_divisor)
	var/dev = ((max-min)*(P.standard_deviation_mult+G.standard_deviation_mult_add))
	var/dam = GaussianReacharound(m, dev, min, max)

/// Returns true if this shot is a crit
/proc/NormalGunCrit(/datum/normal_damage_projectile/P, /datum/normal_damage_gun/G, /mob/living/Shooter)
	var/chance = ((P.crit_chance * G.crit_chance_mult) + G.crit_chance_add)
	return prob(chance)
