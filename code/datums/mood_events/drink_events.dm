/datum/mood_event/drunk
	mood_change = 3
	description = span_nicegreen("Everything just feels better after a drink or two.")
	timeout = 3000

/datum/mood_event/quality_nice
	description = span_nicegreen("That drink wasn't bad at all.")
	mood_change = 1
	timeout = 2 MINUTES

/datum/mood_event/quality_good
	description = span_nicegreen("That drink was pretty good.")
	mood_change = 2
	timeout = 2 MINUTES

/datum/mood_event/quality_verygood
	description = span_nicegreen("That drink was great!")
	mood_change = 3
	timeout = 2 MINUTES

/datum/mood_event/quality_fantastic
	description = span_nicegreen("That drink was amazing!")
	mood_change = 4
	timeout = 2 MINUTES

/datum/mood_event/race_drink
	description = span_nicegreen("That drink was made for me!")
	mood_change = 6
	timeout = 5 MINUTES

/datum/mood_event/amazingtaste
	description = span_nicegreen("Amazing taste!")
	mood_change = 50 //Is this not really high..?
	timeout = 10 MINUTES
