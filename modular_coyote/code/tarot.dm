/datum/tarotcard
	var/name = "playing card"
	var/desc = null
	var/card_icon = "card_back"
	var/back_icon = "card_back"

/obj/item/tarotdeck
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/playing_cards.dmi'
	name = "deck of tarot cards"
	desc = "For all your occult needs!"
	icon_state = "deck_tarot"
	var/list/cards = list()

/obj/item/tarotdeck/Initialize()
	. = ..()
	generate_deck()

/obj/item/tarotdeck/proc/generate_deck()
	var/datum/tarotcard/P
	for(var/name in list("Fool","Magician","High Priestess","Empress","Emperor","Hierophant","Lovers","Chariot","Strength","Hermit","Wheel of Fortune","Justice","Hanged Man","Death","Temperance","Devil","Tower","Star","Moon","Sun","Judgement","World"))
		P = new()
		P.name = "[name]"
		P.card_icon = "tarot_major"
		P.back_icon = "card_back_tarot"
		cards += P
	for(var/suit in list("wands","pentacles","cups","swords"))
		for(var/number in list("ace","two","three","four","five","six","seven","eight","nine","ten","page","knight","queen","king"))
			P = new()
			P.name = "[number] of [suit]"
			P.card_icon = "tarot_[suit]"
			P.back_icon = "card_back_tarot"
			cards += P

/obj/item/tarotdeck/attack_self(var/mob/user as mob)
	var/list/newcards = list()
	while(cards.len)
		var/datum/tarotcard/P = pick(cards)
		P.name = replacetext(P.name," reversed","")
		if(prob(50))
			P.name += " reversed"
		newcards += P
		cards -= P
	cards = newcards
	playsound(src.loc, 'sound/items/cardshuffle.ogg', 100, 1, -4)
	user.visible_message("\The [user] shuffles [src].")

/obj/item/tarotdeck/attack_hand(mob/user)
	if(cards.len && (src in user.held_items))
		draw_card(user, FALSE)
	else
		..()

/obj/item/tarotdeck/attackby(obj/O as obj, mob/user as mob)
	if(istype(O,/obj/item/hand))
		var/obj/item/hand/H = O
		for(var/datum/tarotcard/P in H.cards)
			cards += P
		qdel(O)
		to_chat(user, span_notice("You place your cards at the bottom of \the [src]."))
		return
	..()

/obj/item/tarotdeck/verb/draw_card()
	set category = "Object"
	set name = "Draw"
	set desc = "Draw a card from a deck."
	set src in view(1)
	select_card(usr)

/obj/item/tarotdeck/proc/select_card(var/mob/user)
	if(issilicon(user))
		to_chat(user, span_warning("You cannot hold \the [src]."))
		return
	if(!iscarbon(user))
		to_chat(user, span_warning("Your simple form can't operate \the [src]."))
		return
	if(!cards.len)
		to_chat(usr, span_warning("There are no cards in \the [src]."))
		return

	var/obj/item/hand/H
	if(user.held_items[1] && istype(user.held_items[1],/obj/item/hand))
		H = user.held_items[1]
	else if(user.held_items[2] && istype(user.held_items[2],/obj/item/hand))
		H = user.held_items[2]
	else
		H = new /obj/item/hand(get_turf(src))
		user.put_in_hands(H)

	if(!H || !user)
		return

	var/list/to_discard = list()
	for(var/datum/tarotcard/P in cards)
		to_discard[P.name] = P
	var/discarding = input(user, "Which card do you wish to draw?", "Deck of Cards") as null|anything in to_discard
	if(!discarding || !to_discard[discarding] || !user || !src)
		return

	var/datum/tarotcard/P = to_discard[discarding]
	H.cards += P
	cards -= P
	H.update_icon()
	user.visible_message("<b>\The [user]</b> draws a card.", span_notice("You draw the [P.name]."))

/obj/item/tarotdeck/verb/deal_card()
	set category = "Object"
	set name = "Deal"
	set desc = "Deal a card from a deck."
	set src in view(1)

	if(usr.stat || !Adjacent(usr))
		return

	if(!cards.len)
		to_chat(usr, span_warning("There are no cards in the deck."))
		return

	var/list/players = list()
	for(var/mob/living/player in viewers(3))
		if(!player.stat)
			players += player

	var/mob/living/M = input("Who do you wish to deal a card?") as null|anything in players
	if(!usr || !src || !M) return

	deal_at(usr, M)

/obj/item/tarotdeck/proc/deal_at(mob/user, mob/target)
	var/obj/item/hand/H = new(get_step(user, user.dir))

	H.cards += cards[1]
	cards -= cards[1]
	H.concealed = 1
	H.update_icon()
	if(user==target)
		user.visible_message("<b>\The [user]</b> deals a card to themself.")
	else
		user.visible_message("<b>\The [user]</b> deals a card to \the [target].")
	H.throw_at(get_step(target,target.dir),10,1,H)

/obj/item/tarotdeck/adhomai
	name = "adhomian divination cards deck"
	desc = "An adhomian deck of divination cards, used to read the one's fortune or play games."
	icon_state = "deck_adhomai"

/obj/item/tarotdeck/adhomai/generate_deck()
	var/datum/tarotcard/P
	for(var/name in list("D'as'ral Massacre","Mystic","Suns' Sister","Queen","King","Father of the Parivara","S'rendal'Matir","Tank","Enforcer","Kraszarrumalkarii","Rredouane's Dice","Great Revolution","Assassin","Assassination","Dymtris Line",
	"Rrak'narrr","Steeple","Messa","Raskara","S'rendarr","Kazarrhaldiye","Adhomai"))
		P = new()
		P.name = "[name]"
		P.card_icon = "adhomai_major"
		P.back_icon = "card_back_adhomai"
		cards += P
	for(var/suit in list("wands","pentacles","cups","swords"))
		for(var/number in list("ace","two","three","four","five","six","seven","eight","nine","ten","serf","soldier","queen","king"))
			P = new()
			P.name = "[number] of [suit]"
			P.card_icon = "adhomai_[suit]"
			P.back_icon = "card_back_adhomai"
			cards += P

/obj/item/tarotdeck/nralakk
	name = "qwei'paqui homeworld deck"
	desc = "A Skrellian deck of tarot cards depicting the main constellations of Nralakk."
	icon_state = "deck_nralakk"

/obj/item/tarotdeck/nralakk/generate_deck()
	var/datum/tarotcard/P
	for(var/name in list("Island","Hatching Egg","Star Chanter","Jiu'x'klua","Stormcloud","Gnarled Tree","Poet","Bloated Toad","Void","Qu'Poxii","Fisher","Mountain","Sraso","Nioh"))
		P = new()
		P.name = "[name]"
		var/suit = "nralakk"
		switch(name)
			if("Island")
				P.desc = "One of the main constellations that is shared by both Qeblak and Weishii. It is associated with Loneliness. Introspection. Earth. Rising above or Sinking beneath. Reality."
			if("Hatching Egg")
				name = "egg"
				P.desc = "One of the main constellations that is shared by both Qeblak and Weishii. It is associated with New beginnings. A fresh start. Youth. Life. Excitement. Ignorance. Foolishness. Joy."
			if("Star Chanter")
				name = "chanter"
				P.desc = "One of the main constellations that is shared by both Qeblak and Weishii. It is associated with Wisdom. Spirituality. Connection with the stars. Connection to history. Aloofness. A rigid path. Air."
			if("Jiu'x'klua")
				name = "klua"
				P.desc = "One of the main constellations that is shared by both Qeblak and Weishii. It is associated with Art. Creation. Loss. Sadness. Longing. Communication. The imaginary."
			if("Stormcloud")
				P.desc = "One of the main constellations that is shared by both Qeblak and Weishii. It is associated with Conflict. Shock. Surprises. Tension. Endurance. Strength. Force. Fire."
			if("Gnarled Tree")
				name = "gnarledtree"
				P.desc = "One of the main constellations that is shared by both Qeblak and Weishii. It is associated with Age. Wisdom. Sickness. Frailty, or, in certain orientations, toughness. Rigidity. Tradition. Plantlife. Balance."
			if("Poet")
				P.desc = "One of the main constellations that is shared by both Qeblak and Weishii. it is associated with Communication. Progress. Science. Advancement. Longing. Art. Expression. Loneliness. Contentment. Dreams."
			if("Bloated Toad")
				name = "bloatedtoad"
				P.desc = "One of the main constellations that is shared by both Qeblak and Weishii. it is associated with Greed. Arrogance. Wealth. Success. Smugness. Laziness. Accomplishment. Adulthood."
			if("Void")
				P.desc = "One of the main constellations that is shared by both Qeblak and Weishii. it is associated with Death. Endings. Mystery. The unknown. Fear. Danger. Creation."
			if("Qu'Poxii")
				name = "qupoxii"
				P.desc = "One of the main constellations that is shared by both Qeblak and Weishii. it is associated with Love. Friendship. Company. Opposites. Teamwork. Happiness. The material. Safety. Progress. Support."
			if("Fisher")
				P.desc = "One of the main constellations that is shared by both Qeblak and Weishii. it is associated with  Hard work. Stagnation. Embarrassment. Water. Patience. A long, but productive wait."
			if("Mountain")
				suit = "aweiji"
				P.desc = "One of the local constellations on the planet Aweiji. It is associated with Self-analysis. Feelings of accomplishment. Clearer view."
			if("Sraso")
				suit = "aweiji"
				P.desc = "One of the local constellations on the planet Aweiji. It is associated with Sustainability. Growth. Safety."
			if("Nioh")
				suit = "aweiji"
				P.desc = "One of the local constellations on the planet Aweiji. It is associated with Trust. Reliance. Perseverance. Survival."
		P.card_icon = "[suit]_[lowertext(name)]"
		P.back_icon = "card_off_[suit]"
		cards += P

/obj/item/tarotdeck/nonnralakk
	name = "qwei'paqui colonist deck"
	desc = "A Skrellian deck of tarot cards depicting the local constellations of planets outside Nralakk."
	icon_state = "deck_nonnralakk"

/obj/item/tarotdeck/nonnralakk/generate_deck()
	var/datum/tarotcard/P
	for(var/name in list("Shell","Wave","Trident","Palm Tree","Pulque","Eel","Iqi Star","Sky-Grazer","Dyn"))
		P = new()
		P.name = "[name]"
		var/suit = "slz"
		switch(name)
			if("Shell")
				P.desc = "One of the local constellations revered by the Skrell of Mendell City's Starlight Zone. It is associated with Home, Family (Severson). Refuge, Safety (Lekan)."
			if("Wave")
				P.desc = "One of the local constellations revered by the Skrell of Mendell City's Starlight Zone. It is associated with Pilgrimage, Journey (Severson). Escape, Freedom (Lekan)."
			if("Trident")
				P.desc = "One of the local constellations revered by the Skrell of Mendell City's Starlight Zone. It is associated with Protection, Security (Severson). Oppression, Subjugation (Lekan)."
			if("Palm Tree")
				name = "palm"
				suit = "mict"
				P.desc = "One of the local constellations on the planet Mictlan. It is associated with Tranquility. Agitation. Anxiety. Peace."
			if("Pulque")
				suit = "mict"
				P.desc = "One of the local constellations on the planet Mictlan. It is associated with Togetherness. Comraderie. Overindulgence. Celebration."
			if("Eel")
				suit = "mict"
				P.desc = "One of the local constellations on the planet Mictlan. It is associated with Turncoat. The unanticipated. Intrigue. Forthcoming."
			if("Iqi Star")
				name = "iqi"
				suit = "newgib"
				P.desc = "One of the local constellations on the planet New Gibson. It is associated with Self-Advancement. Social standing. Success."
			if("Sky-Grazer")
				name = "skygrazer"
				suit = "newgib"
				P.desc = "One of the local constellations on the planet New Gibson. It is associated with Expressiveness. Freedom. Adventure."
			if("Dyn")
				suit = "newgib"
				P.desc = "One of the local constellations on the planet New Gibson. It is associated with Survival. Generosity. Community."
		P.card_icon = "[suit]_[lowertext(name)]"
		P.back_icon = "card_off_[suit]"
		cards += P

/obj/item/tarotdeck/MouseDrop(atom/over)
	if(!usr || !over) return
	if(!Adjacent(usr) || !over.Adjacent(usr)) return // should stop you from dragging through windows

	if(!ishuman(over) || !(over in viewers(3))) return

	if(!cards.len)
		to_chat(usr, span_warning("There are no cards in the deck."))
		return

	deal_at(usr, over)

/obj/item/pack/
	name = "card pack"
	desc = "For those with disposible income."
	icon = 'icons/obj/playing_cards.dmi'
	icon_state = "card_pack"
	w_class = WEIGHT_CLASS_TINY
	var/list/cards = list()


/obj/item/pack/attack_self(var/mob/user as mob)
	user.visible_message("<b>\The [user]</b> rips open \the [src]!")
	var/obj/item/hand/H = new()

	H.cards += cards
	cards.Cut();
	user.dropItemToGround(src)
	H.update_icon()
	user.put_in_active_hand(H)
	qdel(src)

/obj/item/hand
	name = "hand of cards"
	desc = "Some playing cards."
	icon = 'icons/obj/playing_cards.dmi'
	icon_state = null
	w_class = WEIGHT_CLASS_TINY

	var/concealed = 0
	var/list/cards = list()

/obj/item/hand/MouseEntered(location, control, params)
	. = ..()
	if(cards.len == 1 && (!concealed || Adjacent(usr)))
		var/datum/tarotcard/P = cards[1]
		openToolTip(usr, src, params, P.name)

/obj/item/hand/MouseExited(location, control, params)
	. = ..()
	closeToolTip(usr)

/obj/item/hand/verb/discard()
	set category = "Object"
	set name = "Discard"
	set desc = "Place a card from your hand in front of you."

	draw_card(usr)

/obj/item/hand/proc/draw_card(var/mob/user, var/deploy_in_front = TRUE)
	var/list/to_discard = list()
	for(var/datum/tarotcard/P in cards)
		to_discard[P.name] = P
	var/input_text = "Which card do you wish to [deploy_in_front ? "put down" : "draw"]?"
	var/discarding = input(user, input_text, "Hand of Cards") as null|anything in to_discard
	if(!discarding || !to_discard[discarding] || !user || !src)
		return

	var/datum/tarotcard/card = to_discard[discarding]
	qdel(to_discard)

	var/obj/item/hand/H = new /obj/item/hand(src.loc)
	H.cards += card
	cards -= card
	H.concealed = FALSE
	H.update_icon()
	src.update_icon()
	if(deploy_in_front)
		user.visible_message("<b>\The [user]</b> plays \the [discarding].")
		H.forceMove(get_step(usr, usr.dir))
	else
		to_chat(user, span_notice("You draw \the [discarding]."))
		user.put_in_hands(H)

	if(!cards.len)
		qdel(src)

/obj/item/hand/attack_hand(mob/user)
	if(cards.len > 1 && (src in user.held_items))
		draw_card(user, FALSE)
	else
		..()

/obj/item/hand/attack_self(var/mob/user as mob)
	concealed = !concealed
	update_icon()
	user.visible_message("\The [user] [concealed ? "conceals" : "reveals"] their hand.")

/obj/item/hand/examine(mob/user)
	..(user)
	if((!concealed || src.loc == user) && cards.len)
		if(cards.len > 1)
			to_chat(user, "It contains: ")
		for(var/datum/tarotcard/P in cards)
			to_chat(user, "The [P.name]. [P.desc ? "<i>[P.desc]</i>" : ""]")

/obj/item/hand/update_icon(var/direction = 0)

	if(!cards.len)
		qdel(src)
		return
	else if(cards.len > 1)
		name = "hand of cards"
		desc = "Some playing cards."
	else
		name = "playing card"
		desc = "A playing card."

	cut_overlays()

	if(cards.len == 1)
		var/datum/tarotcard/P = cards[1]
		var/image/I = new(src.icon, (concealed ? "[P.back_icon]" : "[P.card_icon]") )
		I.pixel_x += (-5+rand(10))
		I.pixel_y += (-5+rand(10))
		add_overlay(I)
		return

	var/offset = FLOOR(20/cards.len, 1)

	var/matrix/M = matrix()
	if(direction)
		switch(direction)
			if(NORTH)
				M.Translate( 0,  0)
			if(SOUTH)
				M.Translate( 0,  4)
			if(WEST)
				M.Turn(90)
				M.Translate( 3,  0)
			if(EAST)
				M.Turn(90)
				M.Translate(-2,  0)
	var/i = 0
	for(var/datum/tarotcard/P in cards)
		var/image/I = new(src.icon, (concealed ? "[P.back_icon]" : "[P.card_icon]") )
		//I.pixel_x = origin+(offset*i)
		switch(direction)
			if(SOUTH)
				I.pixel_x = 8-(offset*i)
			if(WEST)
				I.pixel_y = -6+(offset*i)
			if(EAST)
				I.pixel_y = 8-(offset*i)
			else
				I.pixel_x = -7+(offset*i)
		I.transform = M
		add_overlay(I)
		i++

/obj/item/hand/dropped(mob/user as mob)
	..()
	if(locate(/obj/structure/table, loc))
		src.update_icon(user.dir)
	else
		update_icon()

/obj/item/hand/pickup(mob/user as mob)
	..()
	src.update_icon()

/obj/item/hand/attackby(obj/O as obj, mob/user as mob)
	if(istype(O,/obj/item/hand))
		var/obj/item/hand/H = O
		user.visible_message("<b>\The [user]</b> adds \the [H] to their hand.", span_notice("You add \the [H] to your hand."))
		for(var/datum/tarotcard/P in cards)
			H.cards += P
		H.concealed = src.concealed
		qdel(src)
		H.update_icon()
		return
	..()
