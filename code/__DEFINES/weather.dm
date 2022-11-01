/// Z levels that are more or less above ground and can see the sky
/// For telling players about the weather
#define ABOVE_GROUND_Z_LEVELS list(4, 5, 6, 7, 8)

/// Minimum time between weathers
#define WEATHER_WAIT_MIN 30 MINUTES
/// Maximum time between weathers
#define WEATHER_WAIT_MAX 45 MINUTES

/// Weather tags!

#define WEATHER_HEAT "heat_wave"
#define WEATHER_COLD "cold_snap"
#define WEATHER_SNOW "snow_storm"
#define WEATHER_RAIN "normal_ass_rain"
#define WEATHER_ACID "acid_rain"
#define WEATHER_SAND "sand_storm"
#define WEATHER_RADS "RADSTORM"
#define WEATHER_ALL_AREAS "all_of_em"

/// All weather tags
#define WEATHER_ALL WEATHER_HEAT,\
	WEATHER_COLD,\
	WEATHER_SNOW,\
	WEATHER_RAIN,\
	WEATHER_ACID,\
	WEATHER_SAND,\
	WEATHER_RADS

/// All weather tags,
#define WEATHER_ALL_MINUS_HEAT WEATHER_COLD,\
	WEATHER_SNOW,\
	WEATHER_RAIN,\
	WEATHER_ACID,\
	WEATHER_SAND,\
	WEATHER_RADS

