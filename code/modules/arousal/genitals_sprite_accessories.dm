/datum/sprite_accessory
	var/alt_aroused = FALSE //CIT CODE if this is TRUE, then the genitals will use an alternate icon_state when aroused.
	var/taur_icon //leave null if the genital doesn't have a taur counterpart.
	var/accepted_taurs = STYLE_HOOF_TAURIC|STYLE_PAW_TAURIC //Types that match with the accessory.
	var/feat_taur //the text string of the dna feature to check for those who want to opt out.
	var/taur_dimension_y = 32
	var/taur_dimension_x = 32

//developer update about future plans for genital code - non devs don't read!
//https://cdn.discordapp.com/attachments/878653810367672433/981703163390337054/notice.png