/datum/flirt/debug
	debug = TRUE // so it doesnt show up in the actual game
	flirtname = "Stare at their boobiez"
	flirtdesc = "yeah gawk at them boobies"

	flirticon = 'icons/obj/food/burgerbread.dmi'
	flirticon_state = "superbiteburger"

	give_message = "You grab yourr look gazer and get ready to look at someone boob!"
	give_message_span = "colossus"

	self_message = "You look at with %TARGET%'s boobs! How sweet."
	self_message_span = "papyrus" // check them out in spans.dm!

	target_message = "You notice %FLIRTER% staring at your at your breats!! How sweet."
	target_message_span = "deadsay"

	aoe_message = "HEY EVERYONE, %FLIRTER% is looking at your boobs!"
	aoe_message_span = "greentext"

	aoe_range = 5

	categories = list("Debug", "If you can see this", "69 me")
	/// sound it makes to us bolth

/// flirts that approve of an incoming flirt
/datum/flirt/approve
	flirtname = "Generic Approval"
	flirtdesc = "Let them know you're down with whatever they're on about!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "thumbsup"
	give_message = "You get ready to approve someone's advances!"
	give_message_span = "love"
	self_message = "You approve %TARGET%'s advances! However you do that is up to you, though! <span class='love'>Maybe</span> make an emote for it?"
	self_message_span = "good" // check them out in spans.dm!
	target_message = "%FLIRTER% seems receptive to your advances! Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"
	target_message_span = "good"
	aoe_message = "%FLIRTER% approves!"
	aoe_message_span = "good"
	aoe_range = 1
	categories = list("Reactions", "Approvals")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = FALSE

/// flirts that arent really a decline, being all hard to get lol
/datum/flirt/approve/hard2get
	flirtname = "Play hard to get"
	flirtdesc = "Pretend to not be into their advances, but you <b>totally</b> are and want to play hard to get!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "hard2get"
	give_message = "You get ready to play hard to get!"
	give_message_span = "notice"
	self_message = "You outwardly pretend to not be into %TARGET%'s advances, but you totally are! Hopefully they'll <span class='love'>keep up the chase</span>!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% doesn't <i>seem</i> interested, but they might be if you kept on pushing! Looks like they're playing <span class='love'>playing hard to get</span>!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% doesn't <i>seem</i> interested! Not yet, at least."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Reactions", "Approvals") // yes its an approval
	sound_to_do = 'sound/effects/boowomp.ogg'
	requests_reply = FALSE

/// flirts that arent really a decline, being all hard to get lol
/datum/flirt/approve/coo
	flirtname = "Coo back at them"
	flirtdesc = "Give some cute little sounds of approval to someone!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "coofox"
	give_message = "You get ready to make some cute cooing!"
	give_message_span = "notice"
	self_message = "You make some cute noises at %TARGET%, trying to dote them with words!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% sounds like they're <span class='love'>cooing at you</span>? They sound approving~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% doesn't <i>seem</i> interested! Not yet, at least."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Reactions", "Approvals") // yes its an approval
	sound_to_do = 'sound/effects/boowomp.ogg'
	requests_reply = FALSE

/// flirts that decline of an incoming flirt
/datum/flirt/decline
	flirtname = "Generic Decline"
	flirtdesc = "Let them know you're not down with whatever they're on about!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "thumbsdown"
	give_message = "You get ready to decline someone's advances!"
	give_message_span = "notice"
	self_message = "You decline %TARGET%'s advances!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% doesn't seem interested!"
	target_message_span = "alert"
	aoe_message = "%FLIRTER% declines!"
	aoe_message_span = "alert"
	aoe_range = 1
	categories = list("Reactions", "Declines")
	sound_to_do = 'sound/effects/boowomp.ogg'
	requests_reply = FALSE

/// initiators
/datum/flirt/check_em_out
	flirtname = "Leer - Check them out"
	flirtdesc = "Check someone out and eye up their goods!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "leerfox"
	give_message = "You get ready to stare (un)respectfully at someone!"
	give_message_span = "notice"
	self_message = "You give %TARGET% a nice long look!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "You notice %FLIRTER% <span class='love'>eye you up and down</span>! Seems as though they <span class='love'>like what they see</span>~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER's eyes begin to <span class='love'>wander</span> toward everyone nearby!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expressions")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/blush_at_them
	flirtname = "Blush at them"
	flirtdesc = "You flex your bottom muscles and give someone a cute blush!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to blush at someone!"
	give_message_span = "notice"
	self_message = "You can't help it, but %TARGET% is making you blush!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "You notice %FLIRTER% <span class='love'>start to blush at you</span>! Doesn't look like they can help it~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER <span class='love'>blushes</span>!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expressions")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/sniff_em
	flirtname = "Sniff them"
	flirtdesc = "Get a nice deep lungfull of someone's scent!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "sniffa"
	give_message = "You ready your sniffer!"
	give_message_span = "notice"
	self_message = "You stick out your nose at %TARGET% and take a deep <i>sniff</i>!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% leans in nice and close, then <span class='love'>gives you a deep sniff</span>!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER sniffs the air!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/pinch_em
	flirtname = "Pinch them"
	flirtdesc = "Give them a pinch! Where? Perfect followup emote!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You ready your fingers!"
	give_message_span = "notice"
	self_message = "You <span class='love'>pinch</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "Ow! %FLIRTER% gives you a <span class='love'>pinch</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER pinches someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE





		if("Touch - Caress them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>caress you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to caress [A], if they let you maybe you should clarify where in a small emote?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Brush against them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>brush closely up against you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to brush up against [A], hopefully they'll let you. Maybe clarify in what way?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grope them generically.")
			to_chat(A, span_notice("[src] is seemingly trying to <span class='love'>grope you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?")) 
			to_chat(user, "You attempt to be handsy and grope [A], if they let you maybe clarify where?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grope their bottom.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your ass?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?")) 
			to_chat(user, "You try to play grabass with [A], if they let you. ")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grope their side.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grope your side playfully?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?")) 
			to_chat(user, "You try to grab [A]\'s' side brisky.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Kissy face at them.")
			to_chat(A, span_notice("[src] is making a <span class='love'>kissy face at you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You make a goofy kissy face at [A], maybe they'll take the bait?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Offer a kiss to them.")
			to_chat(A, span_notice("[src] is pursing their lips, <span class='love'>maybe they want you to kiss them?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You offer [A] a kiss, maybe they'll take the bait?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Wink at them.")
			to_chat(A, span_notice("[src] is <span class='love'>winking at you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You wink at [A], hopefully they noticed your forwardness.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Waggle fingers at them.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>waggling their fingers at you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You waggle a finger at [A] teasingly.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Lean on them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>lean on you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to lean on [A], maybe make an emote if they let you?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Snuggle into them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>snuggle up against you?</span> Remember to honor their OOC preferences and maybe give them a response?"))
			to_chat(user, "You try to snuggle up against [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Kiss them lightly on the cheek.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>lightly kiss your cheek?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to kiss [A] lightly on the cheek.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Try to steal a deep kiss.")
			to_chat(A, span_notice("[src] is trying to steel <span class='love'>a deep kiss?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to go in for a deep kiss on [A]!")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Try to steal a light kiss.")
			to_chat(A, span_notice("[src] is trying <span class='love'>to steal a light kiss?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to steal a light kiss from [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Smile at them subtly.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>smiling at you subtly?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> but <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You smile at [A] subtly. Hopefully they noticed.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Smile at them provocatively.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>giving you a rakish smile?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You smile at [A] provocatively, hopefully they noticed.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Play with your hair.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>playing with their hair as they watch you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "Something about [A] makes you feel the need to play with your hair, maybe they'll notice the effect they have on you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Bite your own lower lip.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>biting their lower lip while watching you?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You can't help it but [A] made you bite your lower lip, maybe they'll notice the effect they have on you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Give them the side-eye.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>watching you intently but trying to hide it?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You look at [A] sideways, smiling a bit as you do so. Maybe they'll notice your attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Push your backside into them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>press their backside to you?</span> Remember to honor their OOC preference sbut <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try press your rump against [A], hopefully they want it.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Touch them on 'accident.'")
			to_chat(A, span_notice("[src] is trying to <span class='love'>touch you and make it look like an accident to get your attention?</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to touch [A] and make it look like an accident. Hopefully they realize it wasn't one.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Softly bite their ear.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>nibble your ear!</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to playfully nibble [A]\'s' ear. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Nuzzle their neck.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>nuzzle into your neck!</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to nuzzle into [A]\'s' neck. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Bite their neck.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>bite your neck!</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to bite [A]\'s' neck. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Hold hands with them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>hold your hand</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to hold [A]\'s hand. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Fondle their chest/breasts.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>fondle your chest, or breasts.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to fondle [A]\'s chest or breasts. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Touch their crotch.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>lay a hand on your lap.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to lay a hand on [A]\'s' crotch. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Heavy pet them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>rub your lap.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to rub [A]\'s' crotch. If they let you, maybe go into more detail?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Stare at them.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>staring at you openly and with clear interest.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You can't help but stare at [A], maybe they'll notice.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Avoid looking at them.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>trying a little too hard not to look at you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You desperately try to not look at [A], hopefully they won't notice \<Lie.\>.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Openly look at their assets.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>staring a bit too hard at whatever assets you have on display</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try but can't pull your eyes away from [A]\'s visible assets', hopefully they won't notice \<Lie.\>.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Fail to pickpocket.")
			to_chat(A, span_notice("[src] is trying to put a hand in one of your pockets <span class='love'>but is going to grab you somewhere instead!</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to steal something from [A] but you're about to cop a feel, hopefully they won't notice!")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Raise an eyebrow at them.")
			to_chat(A, span_notice("[src] just <span class='love'>rose an eyebrow at you, clearly they're curious.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You can't help but quirk a brow at [A], maybe they'll notice your curiosity.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Loom over them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>loom over you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to loom over [A], maybe they'll care about it.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Pay them more attention.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>maybe pay you a bit too much attention?</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pay [A] more attention, maybe they'll notice you care about them specifically.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Sneer at them.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>giving you the stink eye but... it feels off?</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You sneer at [A] but don't really mean it. Tsundere moment.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Shove them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>shove you playfully.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You playfully shove [A] but don't really mean it. Tsundere moment.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Squeeze them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>give you a BIG hug.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to give [A] a big hug, because you like them more.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Play with their hair.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>play with your hair.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to play with [A]\'s' hair, maybe they'll let you?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Check them for wounds.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>check if you're hurt a little too closely.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to check [A] over, for wounds.  Not because you just want to look at them.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Corner them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>corner you against something.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to corner [A] against something, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grab their wrist.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your wrist.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to grab [A]\'s wrist, if they let you maybe.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Appear more demure to them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>appear more submissive.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to make yourself appear more submissive for [A], hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Bend over for them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>bend over and get your attention.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to bend over and get [A] to look at your behind, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Look heroic for them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>look cool specifically for you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pose a bit and look good for [A], hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Look like you need their help.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>look like they need your help.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to look like you need [A]\'s help, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grab their arm.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your arm.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to grab [A]\'s arm, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Pull their hair.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>pull your hair.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s hair, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grab their belt.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your belt or pants.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s to you by the belt or pants, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Squish your breasts together.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention with their cleavage.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention to you by making your cleavage super obvious, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Fold your arms under your breasts.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention by framing their cleavage with an arm under it.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention to you by making your cleavage super obvious, hopefully they pay attention.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Draw attention to your breasts.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention by doing something with their breasts.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention to you breasts super obvious.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Play with your nipples sneakily.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention by playing with their nipples sneakily.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention by playing with your own nipples sneakily.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Play with your nipples openly.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention by playing with their nipples openly.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention by playing with your own nipples openly.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Mouth an object.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grab your attention by mouthing an object.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention by mouthing an object, maybe you should clarify what that object is?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Tongue in cheek.")
			to_chat(A, span_notice("[src] is trying to make you notice when they <span class='love'>press their tongue into their cheek coyly.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention by pretending to perform oral.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Whine needily.")
			to_chat(A, span_notice("[src] is trying to make you notice when they <span class='love'>whine needily at them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pull [A]\'s attention by whining like a bitch in heat.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Touch their cheek.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>touch your cheek.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to touch [A]\'s cheek.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Pet them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>pet you affectionately.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to pet [A]\'s head.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Sooth them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>soothe you by giving touches.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to softly sooth [A] over with soft touches.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Rub your thighs together.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>rubbing their thighs together as they look at you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You rub your thighs together while looking at [A], hopefully they notice how they excite you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Try to hide your arousal.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>trying to hide that you have a serious sexual effect on them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try, and possibly fail, at hiding how much [A] is having an effect on your desire.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Touch your hand to your bosom.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>put their hand to their chest, did someting about you cause that?</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You reflexively put your hand to your chest because [A] is just too much for you to handle.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Arms akimbo.")
			to_chat(A, span_notice("[src] might be looking at you <span class='love'>with their hands on their hips, and elbows out. Judgey.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You put your hands to your hips and stick your elbows out, judging [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Press your breasts against them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>press their breasts against you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to push your breasts agianst [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Press your crotch against them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>press their crotch against you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to push your crotch up against [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grind on their lap.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>grind against your lap.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to grind against [A]\'s lap.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Poke their nose.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>poke your nose cutely, boop even.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly boop [A]\'s nose.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Poke their Chest.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>poke your chest to get your attention.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly poke [A]\'s chest.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Poke their breast.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>poke your breast to get your attention.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly poke [A]\'s breast.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Poke their tummy.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>poke your tummy to get your attention.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly poke [A]\'s tummy.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Poke their thigh.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>poke your thigh to get your attention.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly poke [A]\'s thigh.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Put a finger over their mouth.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>put a finger in front of your mouth to hush you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to make [A] hush by putting a finger over their mouth.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Dare them to 'make you' do something.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly mouthed the words \"Make me.\" at you under their breath.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly demand that [A] makes you do something.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Stare defiantly.")
			to_chat(A, span_notice("[src] might be looking at you <span class='love'with open, and sexually tense, defiance.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You stare at [A] defiantly, daring them to do something about it.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Ask them to touch you.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly asked for you to touch them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly ask that [A] touches you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Ask them to take you.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly asked for you to take them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly ask that [A] takes you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Ask them to kiss you.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly asked for you to kiss them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly ask that [A] kisses you.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Verbally let them know you want them.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly informed you that they \"want\" you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly inform [A] that you want them.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Verbally let them know you need them.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>quietly informed you that they \"need\" you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You quietly inform [A] that you need them.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Flutter your eyelashes at them.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>fluttered their eyelashes at you cutely.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You cutely flutter your eyelashes at [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Tickle their nose with your tail.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>tickle your nose with their tail.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly tickle [A]\'s nose with your tail.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Lose your breath.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>lost their breath looking at you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You gently lose your breath from looking at [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Heave your bosom.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>heaved, their bosom lifting towards you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You heave your bosom at [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Grin deviously.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>grinned at you deviously.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You grin deviously at [A].")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Stare at their crotch.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>stared at your crotch.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You stare at [A]\'s crotch.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Lick your lips.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>licked their lips while looking at you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you lick your lips.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Purse your lips.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>pursed their lips thoughtfully while looking at you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you purse your lips thoughtfully.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Shake from their touch.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>shook a little when you touched them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you shake from their previous touching.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Shudder from overstimulation.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>shuddered. Something you did might have overstimulated them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you shudder from something they did.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Gasp from something they did.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>gasped. Something you did might have had an effect on them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you gasp from something they did.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Moan at them.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>moaned quietly. Something you did might have had an effect on them.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you moan quietly from something they did.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Lid your eyes and watch them.")
			to_chat(A, span_notice("[src] is maybe <span class='love'>watching you behind their lidded eyes.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to watch [A] with your eyes lidded.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Leer - Sneak a peak at their assets.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>sneak a peak at your assets.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to look at [A]\'s assets without getting spotted.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Put their HAND between your breasts.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>put your HAND between their breasts.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly place [A]\'s hand between your breasts.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Put their HEAD between your breasts.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>put your HEAD between their breasts.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to coyly place [A]\'s HEAD between your breasts.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("React - Want to tell them something.")
			to_chat(A, span_notice("[src] maybe just <span class='love'>wants to tell you something.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "[A] makes you make a face, you really want to tell them something important.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Grab their hips.")
			to_chat(A, span_notice("[src] is maybe reaching to <span class='love'>grab your hips?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to grab [A]'s hips, but will they let you catch them so easily?")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

		if("Touch - Pull their hair.")
			to_chat(A, span_notice("[src] is reaching to <span class='love'>pull your tail?</span> Remember to honor their OOC preferences and <span class='love'>maybe</span> give them a response?"))
			to_chat(user, "You try to pull [A]'s tail, maybe they'll notice you trying to be frisky!")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')

			return
