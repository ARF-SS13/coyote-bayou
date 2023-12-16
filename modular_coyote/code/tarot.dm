/* this is a playing card deck based off of the Rider-Waite Tarot Deck.
*/

/obj/item/toy/cards/deck/tarot
	name = "deck of tarot cards"
	desc = "For all your occult needs!"
	icon_state = "deck_tarot"
	deckstyle = "tarot"

/obj/item/toy/cards/deck/tarot/populate_deck()
	for(var/name in list("Fool","Magician","High Priestess","Empress","Emperor","Hierophant","Lovers","Chariot","Strength","Hermit","Wheel of Fortune","Justice","Hanged Man","Death","Temperance","Devil","Tower","Star","Moon","Sun","Judgement","World"))
		cards += name
	for(var/suit in list("wands","pentacles","cups","swords"))
		for(var/number in list("ace","two","three","four","five","six","seven","eight","nine","ten","page","knight","queen","king"))
			cards += "[number] of [suit]"

/obj/item/toy/cards/deck/tarot/attack_self(var/mob/user as mob)
	var/list/newcards = list()
	while(cards.len)
		var/card = pick(cards)
		var/oldcard = card
		card = replacetext(card," reversed","")
		if(prob(50))
			card += " reversed"
		newcards += card
		cards -= oldcard
	cards = newcards
	playsound(src.loc, 'sound/items/cardshuffle.ogg', 100, 1, -4)
	user.visible_message("\The [user] shuffles [src].")

/obj/item/toy/cards/deck/tarot/adhomai
	name = "adhomian divination cards deck"
	desc = "An adhomian deck of divination cards, used to read the one's fortune or play games."
	icon_state = "deck_adhomai"
	deckstyle = "adhomai"

/obj/item/toy/cards/deck/tarot/adhomai/populate_deck()
	for(var/name in list("D'as'ral Massacre","Mystic","Suns' Sister","Queen","King","Father of the Parivara","S'rendal'Matir","Tank","Enforcer","Kraszarrumalkarii","Rredouane's Dice","Great Revolution","Assassin","Assassination","Dymtris Line",
	"Rrak'narrr","Steeple","Messa","Raskara","S'rendarr","Kazarrhaldiye","Adhomai"))
		cards += name
	for(var/suit in list("wands","pentacles","cups","swords"))
		for(var/number in list("ace","two","three","four","five","six","seven","eight","nine","ten","serf","soldier","queen","king"))
			cards += "[number] of [suit]"

/obj/item/toy/cards/deck/tarot/nralakk
	name = "qwei'paqui homeworld deck"
	desc = "A Skrellian deck of tarot cards depicting the main constellations of Nralakk."
	icon_state = "deck_nralakk"
	deckstyle = "nralakk"

/obj/item/toy/cards/deck/tarot/nralakk/populate_deck()
	for(var/name in list("Island","Hatching Egg","Star Chanter","Jiu'x'klua","Stormcloud","Gnarled Tree","Poet","Bloated Toad","Void","Qu'Poxii","Fisher","Mountain","Sraso","Nioh"))
		cards += name

/obj/item/toy/cards/deck/tarot/nonnralakk
	name = "qwei'paqui colonist deck"
	desc = "A Skrellian deck of tarot cards depicting the local constellations of planets outside Nralakk."
	icon_state = "deck_nonnralakk"
	deckstyle = "nonnralakk"

/obj/item/toy/cards/deck/tarot/nonnralakk/populate_deck()
	for(var/name in list("Shell","Wave","Trident","Palm Tree","Pulque","Eel","Iqi Star","Sky-Grazer","Dyn"))
		cards += name

