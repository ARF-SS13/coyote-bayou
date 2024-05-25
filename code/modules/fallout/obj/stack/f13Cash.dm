#define maxCoinIcon 6
#define CASH_CAP 1

/* exchange rates X * CAP*/
#define CASH_AUR 100 /* 100 copper to 1 gold */
#define CASH_DEN 10 /* 10 copper to 1 silver */
#define CASH_NCR 0.5 /* $100 to 50 copper */

/* value of coins to spawn, use as-is for caps */
/* LOW_MIN / AUR = amount in AUR */

// A low value cash spawn is on average worth 25
#define LOW_MIN 7
#define LOW_MAX 19

// A medium value cash spawn is on average worth 60ish
#define MED_MIN 20
#define MED_MAX 35


// A high value cash spawn is on average worth 280
#define HIGH_MIN 36
#define HIGH_MAX 45


// Bad Pebbles fix to NCR money fudgery
#define TEMP3_MIN 0
#define TEMP3_MAX 0
#define TEMP_MIN 0
#define TEMP_MAX 0
#define TEMP2_MIN 0
#define TEMP2_MAX 0

// The Bankers Vault-Stash, done like this make it so it only spawns on his person to stop metarushing. Average 8500.
#define BANKER_MIN 2000
#define BANKER_MAX 15000

// The amount of money a ticket puncher can give.
#define TICKET_MIN 50
#define TICKET_MAX 200

// Amounts of coins that, under which, it makes a noise
#define DINGLE_LOW 5
#define DINGLE_MED 15
#define DINGLE_HIGH 30

// Scrip vendor stack?
#define SCRIP_MID 10


/obj/item/stack/f13Cash //DO NOT USE THIS
	name = "copper coin"
	singular_name = "copper coin"
	icon = 'icons/obj/economy.dmi'
	icon_state = "bottle_cap"
	amount = 1
	max_amount = 500
	throwforce = 0
	throw_speed = 2
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	var/flavor_desc =	"A copper coin, commonly used for trade."
	var/value = CASH_CAP
	var/flippable = TRUE
	var/cooldown = 0
	var/coinflip
	var/list/sideslist = list("heads","tails")
	var/pitch = 100
	merge_type = /obj/item/stack/f13Cash
	custom_materials = list(/datum/material/f13cash=MINERAL_MATERIAL_AMOUNT)

/obj/item/stack/f13Cash/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_MOB_DROPPED,PROC_REF(dingaling))

/obj/item/stack/f13Cash/attack_self(mob/user)
	if (flippable)
		if(cooldown < world.time)
			coinflip = pick(sideslist)
			cooldown = world.time + 15
			//flick("coin_[cmineral]_flip", src)
			//icon_state = "coin_[cmineral]_[coinflip]"
			playsound(user.loc, 'sound/items/coinflip.ogg', 50, 1)
			var/oldloc = loc
			sleep(15)
			if(loc == oldloc && user && !user.incapacitated(allow_crit = TRUE))
				user.visible_message("[user] has flipped [src]. It lands on [coinflip].", \
									span_notice("You flip [src]. It lands on [coinflip]."), \
									span_italic("You hear the clattering of loose change."))
		return TRUE//did the coin flip? Not really useful anymore!

/obj/item/stack/f13Cash/caps
	merge_type = /obj/item/stack/f13Cash/caps

/obj/item/stack/f13Cash/caps/twofive
	amount = 25
	merge_type = /obj/item/stack/f13Cash/caps

/obj/item/stack/f13Cash/caps/fivezero
	amount = 50
	merge_type = /obj/item/stack/f13Cash/caps

/obj/item/stack/f13Cash/caps/onezerozero
	amount = 100
	merge_type = /obj/item/stack/f13Cash/caps

/obj/item/stack/f13Cash/caps/onefivezero
	amount = 150
	merge_type = /obj/item/stack/f13Cash/caps

/obj/item/stack/f13Cash/caps/twozerozero
	amount = 200
	merge_type = /obj/item/stack/f13Cash/caps

/obj/item/stack/f13Cash/caps/twofivezero
	amount = 250
	merge_type = /obj/item/stack/f13Cash/caps

/obj/item/stack/f13Cash/caps/threezerozero
	amount = 300
	merge_type = /obj/item/stack/f13Cash/caps

/obj/item/stack/f13Cash/caps/threefivezero
	amount = 350
	merge_type = /obj/item/stack/f13Cash/caps

/obj/item/stack/f13Cash/caps/fivezerozero
	amount = 500
	merge_type = /obj/item/stack/f13Cash/caps

/obj/item/stack/f13Cash/caps/onezerozerozero
	amount = 1000
	merge_type = /obj/item/stack/f13Cash/caps

/obj/item/stack/f13Cash/Initialize()
	. = ..()
	update_desc()
	update_icon()

/obj/item/stack/f13Cash/proc/update_desc()
	var/total_worth = get_item_credit_value()
	desc = "It's worth [total_worth] [singular_name][ (latin) ? (( amount > 1 ) ? "i" : "us") : (( amount > 1 ) ? "s each" : "")].\n[flavor_desc]"

/obj/item/stack/f13Cash/get_item_credit_value()
	return (amount*value)

/obj/item/stack/f13Cash/merge(obj/item/stack/S)
	. = ..()
	update_desc()
	update_icon()

/obj/item/stack/f13Cash/use(used, transfer = FALSE, check = TRUE)
	. = ..()
	update_desc()
	update_icon()

/obj/item/stack/f13Cash/random
	var/money_type = /obj/item/stack/f13Cash/caps
	var/min_qty = LOW_MIN
	var/max_qty = LOW_MAX
	var/spawn_nothing_chance = 0 //chance no money at all spawns

/obj/item/stack/f13Cash/random/Initialize()
	..()
	if(!prob(spawn_nothing_chance))
		spawn_money()
	return INITIALIZE_HINT_QDEL

/obj/item/stack/f13Cash/random/proc/spawn_money()
	var/obj/item/stack/f13Cash/stack = new money_type
	stack.loc = loc
	stack.amount = round(rand(min_qty, max_qty))
	stack.update_icon()

/* we have 6 icons, so we will use our own, instead of stack's   */
/obj/item/stack/f13Cash/update_icon()
	switch(amount)
		if(1)
			icon_state = "[initial(icon_state)]"
		if(2 to 5)
			icon_state = "[initial(icon_state)]2"
		if(6 to 50)
			icon_state = "[initial(icon_state)]3"
		if(51 to 100)
			icon_state = "[initial(icon_state)]4"
		if(101 to 500)
			icon_state = "[initial(icon_state)]5"
		if(501 to 15000)
			icon_state = "[initial(icon_state)]6"

/obj/item/stack/f13Cash/proc/dingaling()
	var/snd = 'sound/items/dropped/coin_1.ogg'
	switch(amount)
		if(0 to DINGLE_LOW)
			snd = 'sound/items/dropped/coin_1.ogg'
		if(DINGLE_LOW to DINGLE_MED)
			snd = 'sound/items/dropped/coin_low.ogg'
		if(DINGLE_MED to DINGLE_HIGH)
			snd = 'sound/items/dropped/coin_med.ogg'
		if(DINGLE_HIGH to INFINITY)
			snd = 'sound/items/dropped/coin_high.ogg'
	playsound(loc, snd, 50, vary = FALSE, frequency = SOUND_FREQ_NORMALIZED(pitch, 0, 0))
	if(!(locate(/mob/living) in loc))
		return
	var/list/okplaces = list()
	for(var/turf/T in range(1, src))
		if(T.density)
			continue
		if(locate(/mob/living) in T)
			continue
		okplaces |= T
	if(LAZYLEN(okplaces))
		step_to(src, pick(okplaces))

/obj/item/debug_clicker/dingalinger
	name = "Debug Dingalinger"
	desc = "Click to dingalinger"
	icon = 'icons/obj/economy.dmi'
	icon_state = "rupee"
	max_reach = 10
	var/amtt = 1

/obj/item/debug_clicker/dingalinger/attack_self(mob/user)
	. = ..()
	amtt = input(user, "How many?") as null|num
	to_chat(user, "Dingalingering [amtt] times")

/obj/item/debug_clicker/dingalinger/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(isturf(target))
		var/obj/item/stack/f13Cash/caps/cap = new(get_turf(target), amtt)
		SEND_SIGNAL(cap, COMSIG_ITEM_MOB_DROPPED)
		return
	SEND_SIGNAL(target, COMSIG_ITEM_MOB_DROPPED)

/obj/item/stack/f13Cash/random/low
	min_qty = LOW_MIN / CASH_CAP
	max_qty = LOW_MAX / CASH_CAP

/obj/item/stack/f13Cash/random/low/lowchance
	spawn_nothing_chance = 75

/obj/item/stack/f13Cash/random/low/medchance
	spawn_nothing_chance = 50

/obj/item/stack/f13Cash/random/med
	min_qty = MED_MIN / CASH_CAP
	max_qty = MED_MAX / CASH_CAP

/obj/item/stack/f13Cash/random/high
	min_qty = HIGH_MIN / CASH_CAP
	max_qty = HIGH_MAX / CASH_CAP

/obj/item/stack/f13Cash/random/banker
	min_qty = BANKER_MIN / CASH_CAP
	max_qty = BANKER_MAX / CASH_CAP

/obj/item/stack/f13Cash/random/bankerticket
	min_qty = TICKET_MIN / CASH_CAP
	max_qty = TICKET_MAX / CASH_CAP

/obj/item/stack/f13Cash/denarius
	name = "silver coin"
	latin = 0
	singular_name = "Sliver Coin" // -us or -i
	icon = 'icons/obj/economy.dmi'
	icon_state = "denarius"
	flavor_desc =	"A sliver, shiny coin, used mainly by the middle class. Worth the same as 10 copper coins."
	merge_type = /obj/item/stack/f13Cash/denarius
	pitch = 0

/obj/item/stack/f13Cash/denarius/five
	amount = 5
	merge_type = /obj/item/stack/f13Cash/denarius

/obj/item/stack/f13Cash/denarius/ten
	amount = 10
	merge_type = /obj/item/stack/f13Cash/denarius

/obj/item/stack/f13Cash/denarius/twenty
	amount = 20
	merge_type = /obj/item/stack/f13Cash/denarius

/obj/item/stack/f13Cash/denarius/hundo
	amount = 100
	merge_type = /obj/item/stack/f13Cash/denarius


/obj/item/stack/f13Cash/random/denarius
	money_type = /obj/item/stack/f13Cash/denarius

/obj/item/stack/f13Cash/random/denarius/low
	min_qty = LOW_MIN / CASH_DEN
	max_qty = LOW_MAX / CASH_DEN

/obj/item/stack/f13Cash/random/denarius/med
	min_qty = MED_MIN / CASH_DEN
	max_qty = MED_MAX / CASH_DEN

/obj/item/stack/f13Cash/random/denarius/high
	min_qty = HIGH_MIN / CASH_DEN
	max_qty = HIGH_MAX / CASH_DEN

/obj/item/stack/f13Cash/random/denarius/legionpay_basic
	min_qty = LOW_MIN / CASH_DEN
	max_qty = LOW_MAX / CASH_DEN

/obj/item/stack/f13Cash/random/denarius/legionpay_veteran
	min_qty = MED_MIN / CASH_DEN
	max_qty = MED_MAX / CASH_DEN

/obj/item/stack/f13Cash/random/denarius/legionpay_officer
	min_qty = HIGH_MIN / CASH_DEN
	max_qty = HIGH_MAX / CASH_DEN

/obj/item/stack/f13Cash/aureus
	name = "gold coin"
	latin = 0
	singular_name = "Gold Coin"// -us or -i
	icon = 'icons/obj/economy.dmi'
	icon_state = "aureus"
	flavor_desc = 	"A golden coin used by aristocrats and upper class-men. Quite rare... a sight to behold, indeed. Also super shiny! Worth 100 copper coins, or 10 silver coins."
	value = CASH_AUR * CASH_CAP
	merge_type = /obj/item/stack/f13Cash/aureus
	pitch = -100

/obj/item/stack/f13Cash/aureus/five
	amount = 5
	merge_type = /obj/item/stack/f13Cash/aureus

/obj/item/stack/f13Cash/aureus/ten
	amount = 10
	merge_type = /obj/item/stack/f13Cash/aureus

/obj/item/stack/f13Cash/aureus/twenty
	amount = 20
	merge_type = /obj/item/stack/f13Cash/aureus

/obj/item/stack/f13Cash/aureus/hundo
	amount = 100
	merge_type = /obj/item/stack/f13Cash/aureus

/obj/item/stack/f13Cash/random/aureus
	money_type = /obj/item/stack/f13Cash/aureus

/obj/item/stack/f13Cash/random/aureus/low
	min_qty = 0
	max_qty = 0

/obj/item/stack/f13Cash/random/aureus/med
	min_qty = 0
	max_qty = 0

/obj/item/stack/f13Cash/random/aureus/high
	min_qty = 0
	max_qty = 0 //uses flat values because aurei are worth so much

/obj/item/stack/f13Cash/ncr
	name = "Trade Union scrip"
	singular_name = "Trade Union scrip"  /* same for denarius, we can pretend the legion can't latin properly */
	flavor_desc = "Scrip issued by the Texarkana Trade Union that can be exchanged for goods and services. Or copper. Currently worthless cus a kobold ate them all."
	max_amount = 15000
	icon = 'icons/obj/economy.dmi'
	icon_state = "ncr" /* 10 points to whoever writes flavour text for each bill */
	value = CASH_NCR * CASH_CAP * 0
	flippable = FALSE
	merge_type = /obj/item/stack/f13Cash/ncr
	pitch = 0

/obj/item/stack/f13Cash/ncr/twenty
	amount = 20
	merge_type = /obj/item/stack/f13Cash/ncr

/obj/item/stack/f13Cash/ncr/fourty
	amount = 40
	merge_type = /obj/item/stack/f13Cash/ncr

/obj/item/stack/f13Cash/ncr/eighty
	amount = 80
	merge_type = /obj/item/stack/f13Cash/ncr

/obj/item/stack/f13Cash/ncr/twohundo
	amount = 200
	merge_type = /obj/item/stack/f13Cash/ncr

/obj/item/stack/f13Cash/ncr/onekay
	amount = 1000
	merge_type = /obj/item/stack/f13Cash/ncr

/obj/item/stack/f13Cash/ncr/fivegees
	amount = 5000
	merge_type = /obj/item/stack/f13Cash/ncr

/obj/item/stack/f13Cash/ncr/update_icon()
	switch(amount)
		if(1  to 9)
			icon_state = "[initial(icon_state)]"
		if(10 to 19)
			icon_state = "[initial(icon_state)]10"
		if(20 to 49)
			icon_state = "[initial(icon_state)]20"
		if(50 to 99)
			icon_state = "[initial(icon_state)]50"
		if(100 to 199)
			icon_state = "[initial(icon_state)]100"
		if(200 to 499)
			icon_state = "[initial(icon_state)]200"
		if(500 to 15000)
			icon_state = "[initial(icon_state)]500"

/obj/item/stack/f13Cash/random/ncr
	money_type = /obj/item/stack/f13Cash/ncr

/obj/item/stack/f13Cash/random/ncr/twenty
	min_qty = SCRIP_MID / CASH_NCR
	max_qty = SCRIP_MID / CASH_NCR

/obj/item/stack/f13Cash/random/ncr/low
	min_qty = TEMP3_MIN / CASH_NCR
	max_qty = TEMP3_MAX / CASH_NCR

/obj/item/stack/f13Cash/random/ncr/med
	min_qty = TEMP_MIN / CASH_NCR
	max_qty = TEMP_MAX / CASH_NCR

/obj/item/stack/f13Cash/random/ncr/high
	min_qty = TEMP2_MIN / CASH_NCR
	max_qty = TEMP2_MAX / CASH_NCR

/obj/item/stack/f13Cash/random/ncr/ncrpay_basic
	min_qty = LOW_MIN / CASH_NCR
	max_qty = LOW_MAX / CASH_NCR

/obj/item/stack/f13Cash/random/ncr/ncrpay_veteran
	min_qty = MED_MIN / CASH_NCR
	max_qty = MED_MAX / CASH_NCR

/obj/item/stack/f13Cash/random/ncr/ncrpay_officer
	min_qty = HIGH_MIN / CASH_NCR
	max_qty = HIGH_MAX / CASH_NCR


#undef maxCoinIcon
#undef CASH_CAP
#undef CASH_AUR
#undef CASH_DEN
#undef CASH_NCR
#undef LOW_MIN
#undef LOW_MAX
#undef MED_MIN
#undef MED_MAX
#undef HIGH_MIN
#undef HIGH_MAX
#undef BANKER_MIN
#undef BANKER_MAX
#undef TEMP3_MIN
#undef TEMP3_MAX
#undef TEMP_MIN
#undef TEMP_MAX
#undef TEMP2_MIN
#undef TEMP2_MAX
