/*******************************\
|		  Slot Machines		  	|
|	  Original code by Glloyd	|
|	  Tgstation port by Miauw	|
\*******************************/

#define SPIN_PRICE 25
#define SMALL_PRIZE 600
#define BIG_PRIZE 1500
#define DEFAULT_JACKPOT 10000
#define SPIN_TIME 65 //As always, deciseconds.
#define REEL_DEACTIVATE_DELAY 7
#define SEVEN "<font color='red'>7</font>"
#define MAX_CASH_STACK_AMOUNT 15000 // This should be the currencies max limit.

/obj/machinery/computer/slot_machine
	name = "slot machine"
	desc = "Gambling for the antisocial."
	icon = 'icons/obj/economy.dmi'
	icon_state = "slots1"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 50
	circuit = /obj/item/circuitboard/computer/slot_machine
	var/money = DEFAULT_JACKPOT //How much money it has CONSUMED
	var/plays = 0
	var/working = FALSE
	var/balance = 0 //How much money is in the machine, ready to be CONSUMED.
	var/jackpots = 0
	var/list/reels = list(list("", "", "") = 0, list("", "", "") = 0, list("", "", "") = 0, list("", "", "") = 0, list("", "", "") = 0)
	var/list/symbols = list(SEVEN = 1, "<font color='orange'>&</font>" = 2, "<font color='yellow'>@</font>" = 2, "<font color='green'>$</font>" = 2, "<font color='blue'>?</font>" = 2, "<font color='grey'>#</font>" = 2, "<font color='white'>!</font>" = 2, "<font color='fuchsia'>%</font>" = 2) //if people are winning too much, multiply every number in this list by 2 and see if they are still winning too much.
	connectable = FALSE

	light_color = LIGHT_COLOR_BROWN

/obj/machinery/computer/slot_machine/Initialize()
	. = ..()
	var/obj/item/circuitboard/computer/slot_machine/crct = circuit
	jackpots = rand(1, 4) //false hope
	plays = rand(75, 200)
	if(prob(25) && crct.start_cash)
		give_money(rand(1, 125))
		crct.start_cash = FALSE

	INVOKE_ASYNC(src, .proc/toggle_reel_spin, TRUE)//The reels won't spin unless we activate them

	var/list/reel = reels[1]
	for(var/i = 0, i < reel.len, i++) //Populate the reels.
		randomize_reels()

	INVOKE_ASYNC(src, .proc/toggle_reel_spin, FALSE)

/obj/machinery/computer/slot_machine/Destroy()
	if(balance)
		drop_caps(balance)
	return ..()

/obj/machinery/computer/slot_machine/process()
	. = ..() //Sanity checks.
	if(!.)
		return .

	money++ //SPESSH MAJICKS

/obj/machinery/computer/slot_machine/update_icon_state()
	if(stat & NOPOWER)
		icon_state = "slots0"

	else if(stat & BROKEN)
		icon_state = "slotsb"

	else if(working)
		icon_state = "slots2"

	else
		icon_state = "slots1"

/obj/machinery/computer/slot_machine/power_change()
	..()
	update_icon()

/obj/machinery/computer/slot_machine/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stack/f13Cash))
		var/obj/item/stack/f13Cash/currency = I
		if(!user.temporarilyRemoveItemFromInventory(currency))
			return
		to_chat(user, "<span class='notice'>You insert [currency] into [src]'s slot!</span>")
		give_money(round(currency.value * currency.amount))
		qdel(currency)
	else
		return ..()

/obj/machinery/computer/slot_machine/ui_interact(mob/living/user)
	. = ..()
	var/reeltext = {"<center><font face=\"courier new\">
	/*****^*****^*****^*****^*****\\<BR>
	| \[[reels[1][1]]\] | \[[reels[2][1]]\] | \[[reels[3][1]]\] | \[[reels[4][1]]\] | \[[reels[5][1]]\] |<BR>
	| \[[reels[1][2]]\] | \[[reels[2][2]]\] | \[[reels[3][2]]\] | \[[reels[4][2]]\] | \[[reels[5][2]]\] |<BR>
	| \[[reels[1][3]]\] | \[[reels[2][3]]\] | \[[reels[3][3]]\] | \[[reels[4][3]]\] | \[[reels[5][3]]\] |<BR>
	\\*****v*****v*****v*****v*****/<BR>
	</center></font>"}

	var/dat
	if(working)
		dat = reeltext

	else
		dat = {"[SPIN_PRICE] caps to play!<BR>
		<B>Prize Money Available:</B> [money] (jackpot payout is ALWAYS 100%!)<BR>
		<B>Caps Remaining:</B> [balance]<BR>
		[plays] players have tried their luck today, and [jackpots] have won a jackpot!<BR>
		<HR><BR>
		<A href='?src=[REF(src)];spin=1'>Play!</A><BR>
		<BR>
		[reeltext]
		<BR>
		<font size='1'><A href='?src=[REF(src)];refund=1'>Refund balance</A><BR>"}
	var/datum/browser/popup = new(user, "slotmachine", "Slot Machine")
	popup.set_content(dat)
	popup.open()

/obj/machinery/computer/slot_machine/Topic(href, href_list)
	. = ..() //Sanity checks.
	if(.)
		return .
	if(href_list["spin"])
		spin(usr)

	else if(href_list["refund"])
		drop_caps(balance)
		updateDialog()

/obj/machinery/computer/slot_machine/proc/drop_caps(amt)
	// Come back when you're a little bit richer...
	if(!balance)
		return FALSE

	if(isturf(get_turf(src)))
		var/currentamt = amt
		// Stop cash stacks from going over their limit.
		if(currentamt >= MAX_CASH_STACK_AMOUNT)
			while(currentamt >= MAX_CASH_STACK_AMOUNT)
				var/obj/item/stack/f13Cash/moneytodrop = new /obj/item/stack/f13Cash/caps(get_turf(src))
				moneytodrop.amount = MAX_CASH_STACK_AMOUNT
				moneytodrop.use(0) //Hacky, updates the sprite
				currentamt -= MAX_CASH_STACK_AMOUNT
		if(currentamt)
			var/obj/item/stack/f13Cash/moneytodrop = new /obj/item/stack/f13Cash/caps(get_turf(src))
			moneytodrop.amount = currentamt
			moneytodrop.use(0) //Hacky, updates the sprite
		balance -= amt
		return TRUE

	return FALSE

/obj/machinery/computer/slot_machine/proc/spin(mob/user)
	if(!can_spin(user))
		return

	visible_message("<span class='notice'>[user] pulls the lever and the slot machine starts spinning!</span>")

	balance -= SPIN_PRICE
	money += SPIN_PRICE
	plays += 1
	working = TRUE

	toggle_reel_spin(1)
	update_icon()
	updateDialog()

	spawn(0)
		while(working)
			randomize_reels()
			updateDialog()
			sleep(2)

	spawn(SPIN_TIME - (REEL_DEACTIVATE_DELAY * reels.len)) //WARNING: no sanity checking for user since it's not needed and would complicate things (machine should still spin even if user is gone), be wary of this if you're changing this code.
		toggle_reel_spin(0, REEL_DEACTIVATE_DELAY)
		working = FALSE
		give_prizes(user)
		update_icon()
		updateDialog()

/obj/machinery/computer/slot_machine/proc/can_spin(mob/user)
	if(!user)
		return 0
	if(stat & NOPOWER)
		to_chat(user, "<span class='warning'>The slot machine has no power!</span>")
	if(stat & BROKEN)
		to_chat(user, "<span class='warning'>The slot machine is broken!</span>")
	if(working)
		to_chat(user, "<span class='warning'>You need to wait until the machine stops spinning before you can play again!</span>")
		return 0
	if(balance < SPIN_PRICE)
		to_chat(user, "<span class='warning'>Insufficient money to play!</span>")
		return 0
	return 1

/obj/machinery/computer/slot_machine/proc/toggle_reel_spin(value, delay = 0) //value is 1 or 0 aka on or off
	for(var/list/reel in reels)
		reels[reel] = value
		sleep(delay)

/obj/machinery/computer/slot_machine/proc/randomize_reels()

	for(var/reel in reels)
		if(reels[reel])
			reel[3] = reel[2]
			reel[2] = reel[1]
			reel[1] = pick(symbols)

/obj/machinery/computer/slot_machine/proc/give_prizes(mob/user)
	var/linelength = get_lines()

	if(reels[1][2] + reels[2][2] + reels[3][2] + reels[4][2] + reels[5][2] == "[SEVEN][SEVEN][SEVEN][SEVEN][SEVEN]")
		visible_message("<b>[src]</b> says, 'JACKPOT! You win [money] caps!'")
		jackpots += 1
		give_money(money)
		money = 0

	else if(linelength == 5)
		visible_message("<b>[src]</b> says, 'Big Winner! You win [BIG_PRIZE] caps!'")
		give_money(BIG_PRIZE)

	else if(linelength == 4)
		visible_message("<b>[src]</b> says, 'Winner! You win [SMALL_PRIZE] caps!'")
		give_money(SMALL_PRIZE)

	else if(linelength == 3)
		to_chat(user, "<span class='notice'>You win three free games!</span>")
		give_money(SPIN_PRICE * 4)
		money = max(money - SPIN_PRICE * 4, money)

	else
		to_chat(user, "<span class='warning'>No luck!</span>")
/obj/machinery/computer/slot_machine/proc/get_lines()
	var/amountthesame
	for(var/i = 1, i <= 3, i++)
		var/inputtext = reels[1][i] + reels[2][i] + reels[3][i] + reels[4][i] + reels[5][i]
		for(var/symbol in symbols)
			var/j = 3 //The lowest value we have to check for.
			var/symboltext = symbol + symbol + symbol
			while(j <= 5)
				if(findtext(inputtext, symboltext))
					amountthesame = max(j, amountthesame)
				j++
				symboltext += symbol
			if(amountthesame)
				break

	return amountthesame

/obj/machinery/computer/slot_machine/proc/give_money(amt)
	balance += amt

#undef SEVEN
#undef SPIN_TIME
#undef DEFAULT_JACKPOT
#undef BIG_PRIZE
#undef SMALL_PRIZE
#undef SPIN_PRICE
#undef MAX_CASH_STACK_AMOUNT
