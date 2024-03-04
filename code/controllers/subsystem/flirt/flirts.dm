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
	categories = list("Reactions", "Approvals", "Coy") // yes its an approval
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
	categories = list("Reactions", "Approvals", "Coy") // yes its an approval
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
	categories = list("Actions", "Expressions", "Facial", "Lewd")
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
	categories = list("Actions", "Expressions", "Facial", "Self", "Coy", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/sniff_em
	flirtname = "Sniff them"
	flirtdesc = "Get a nice deep lungfull of someone's scent!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "sniffa"
	give_message = "You ready your sniffer!"
	give_message_span = "notice"
	self_message = "You stick out your nose at %TARGET% and try to take a deep <i>sniff</i>!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% leans in nice and close, then tries to <span class='love'>gives you a deep sniff</span>!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER tries to sniffs the air!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Facial", "Lewd")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/pinch_em // copy one of these datums, and replace the strings with the flirt stuffs
	flirtname = "Pinch them"
	flirtdesc = "Give them a pinch! Where? Perfect followup emote!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You ready your fingers!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>pinch</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to give you a <span class='love'>pinch</span>! Ow, maybe! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER tries to pinches someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/caress_them
	flirtname = "Caress them"
	flirtdesc = "Caress them somewhere on their body. Where?  Perfect followup emote!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to caress someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>caress</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>caress you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER tries to caress someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile", "Lewd", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/brush_against_them
	flirtname = "brush against them"
	flirtdesc = "Brush some part of you against some part of them. Where and what?  Perfect followup emote!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to brush against someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>brush against</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>brush against you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER tries to brush against someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile", "\"Accidental\"")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE


/datum/flirt/grope_them_generically
	flirtname = "Grope them generically"
	flirtdesc = "Grope some part of them. Where and what?  Perfect followup emote!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to grope someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>grope</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>grope you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER tries to grope someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile", "Forward", "Lewd")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/grope_their_backside
	flirtname = "Grope their backside"
	flirtdesc = "Grope their rump! How hard and where exactly?  Perfect followup emote!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to grope someones backside!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>booty grope</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>booty grope you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER tries to booty grope someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Upper Body", "Tactile", "Lewd")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/grope_their_side
	flirtname = "Grope their side"
	flirtdesc = "Grope their side! How hard and where exactly?  Perfect followup emote!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to grope someones side!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>grope</span> %TARGET%'s side!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>grope your side</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER tries to grope someone's side!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Upper Body", "Tactile")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/kissy_face
	flirtname = "Make a kissy face at someone"
	flirtdesc = "Make a kissy face at them!  Maybe they'll smooch you!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to make a kissy face at somebody!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>make a kissy face at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>make a kissy face at you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe making a kissy face at someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Expressions", "Smooches", "Facial", "Self", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/kiss_offer
	flirtname = "Offer to kiss them"
	flirtdesc = "Offer somebody a kiss, maybe they'll bite."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to kiss somebody!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>get %TARGET% to kiss you!</span>"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>lure you in to kiss them</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe trying to get someone to kiss them!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Smooches", "Facial", "Self")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/wink_at_them
	flirtname = "Wink at them"
	flirtdesc = "Give someone a wink, maybe they'll notice how forward youa re!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to wink at somebody!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>wink at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>wink at you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe winking at someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Expressions", "Facial", "Self", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/finger_waggle
	flirtname = "Waggle a Finger at them"
	flirtdesc = "Waggle a finger at them admonishingly, how bad they are!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to waggle your finger at someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>waggle a finger at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>waggle a finger at you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe waggling a finger at someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expressions", "Gestures", "Coy", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/lean_on_them
	flirtname = "Lean On Them"
	flirtdesc = "Try to lean on someone, how sweet!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to lean up against someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>lean on</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>lean their weight against you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe leaning on someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/snuggle_into_them
	flirtname = "Snuggle into Them"
	flirtdesc = "Try to snuggle up close with someone!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to snuggle up close against someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>snuggle up close with</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>snuggle up close with you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe snuggling up close with someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/cheek_kiss_them
	flirtname = "Kiss their cheek"
	flirtdesc = "Try to smooch them on the cheek!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to kiss someone on the cheek!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>press a soft kiss on the cheek of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>press a kiss into your cheek</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe planting a cheek kiss on someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Smooches", "Facial", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/steal_deep_kiss
	flirtname = "Steal a full on kiss!"
	flirtdesc = "Dastardly try to steal a full blown kiss from them!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to give someone the BIG smooch!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>weasel in a full on kiss, attempting to latch onto</span> %TARGET%'s mouth!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>press their mouth to yours, they're trying to give you a full blown kiss</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe planting a deep kiss on someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Smooches", "Facial", "Lewd")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/steal_light_kiss
	flirtname = "Steal a light kiss"
	flirtdesc = "It's innocent, swear. You're not going to linger at all."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to lightly kiss someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>press a soft kiss on</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>press a soft kiss onto your lips</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe planting a soft kiss on someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Smooches", "Facial", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/smile_subtly_at_them
	flirtname = "Smile subtly at them"
	flirtdesc = "An innocent smile here, a wink there. You might get ahead if you take the gentler path."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to subtly smile at someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>subtly smile at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>smile at you subtly</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe giving someone a subtle smile!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expressions", "Facial", "Coy", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/smile_provocatively_at_them
	flirtname = "Smile provocatively at them"
	flirtdesc = "A not so innocent smile here, a wink there. You might get ahead if you take the more direct path."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to provocatively smile at someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>provocatively smile at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% tries to <span class='love'>smile at you provocatively</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe giving someone a provocative smile!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expressions", "Facial", "Lewd")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/play_with_own_hair
	flirtname = "Play with your hair"
	flirtdesc = "Fidgety hands need something to play with, and your own hair is on call.  Very girlish of you."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to play with your own hair, hopefully they don't notice! (Lie)"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>provocatively play with your hair to get</span> %TARGET%'s attention!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>playing with their hair while watching you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe playing with their hair?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expressions", "Facial", "Self", "Coy", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/bite_own_lower_lip
	flirtname = "Bite your own lower lip"
	flirtdesc = "Oral fixation or frustration, you can't bite them so you gotta bite SOMETHING."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to bite your own lower lip."
	give_message_span = "notice"
	self_message = "You <span class='love'>bite your lower lip</span>, hopefully that gets %TARGET%'s attention!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>biting their lower lip</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe biting their lower lip?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expressions", "Facial", "Self", "Coy", "Cute", "Bite")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/side_eye_that_mother_fucker
	flirtname = "Give em the old Side Eye"
	flirtdesc = "You can't stop yourself from watching them in the corner of your vision. It's their fault."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to give them the side eye of the century."
	give_message_span = "notice"
	self_message = "You try to <span class='love'>side eye them up like a piece of steak</span>, hopefully %TARGET% notices!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>giving you the most obvious side eye this side of the sahara</span>! They seem frisky.  Or maybe just thirsty~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe side eyeing hard at someone?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expressions", "Facial", "Coy")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/backside_into_target
	flirtname = "Push your backside into them"
	flirtdesc = "Wether it's bowling them over, or just trying to casually let them know you want them to touch it. That rumps getting sent forth."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to use your rear end as a lure."
	give_message_span = "notice"
	self_message = "You try to <span class='love'>press your backside against</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to press their rump into you</span>! They seem frisky~ Or maybe you should collect their insurance information?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe playing rump attack with someone?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile", "Upper Body", "Lewd")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/oops_didnt_see_you_there
	flirtname = "Touch them on 'accident'"
	flirtdesc = "Oops, I didn't see you there, how did my hand end up on your lap. Whoopsie."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to use put a hand on them somewhere."
	give_message_span = "notice"
	self_message = "You try to <span class='love'>casually touch</span> %TARGET% as if its not on purpose!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to touch you and make it seem like an accident</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe playing touch and go with someone?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile", "Lewd", "Coy", "\"Accidental\"") // lewd AND coy? =3
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/ear_bite_them
	flirtname = "Bite their ear"
	flirtdesc = "Hard or soft, that ear is yours if they give you even a little leeway!!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to bite one of their ears!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>bite the ear of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to bite your ear</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe playing touch and go with someone?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Facial", "Lewd", "Bite") // lewd AND coy? =3
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/nuzzle_wuzzle_their_necky_wecky_uwu
	flirtname = "Nuzzle their neck"
	flirtdesc = "Just some closeness, press your face into their neck and hope they don't dumpster you."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to relax your face against someones neck!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>relax your face against the neck of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to nuzzle into your neck</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe being a nuzzle creature with someone?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Facial", "Coy", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/neck_bite
	flirtname = "Bite their neck"
	flirtdesc = "Determination. One way or another if they let you you're going to bite that neck!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to sink your teeth into someones neck!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>bite into the neck of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to bite into your neck</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe trying to chew on someones neck!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Facial", "Bite")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/hold_hands_with_them_you_horrible_monster_how_could_you
	flirtname = "Hold their hand"
	flirtdesc = "Whats next? Missionary for the sole purpose of procreation?  You're a sicko.  Or just really cute."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to hold someones hand!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>hold the hand of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to hold your hand</span>! How scandalous!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe trying to hold someones hand!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile", "Lewd", "Cute", "Illegal")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/fondle_chest
	flirtname = "Fondle their chest/breasts"
	flirtdesc = "Be it fondling a tit or rubbing their rock hard chest. You wanna do it."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to sink your teeth into someones neck!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>bite into the neck of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to fondle your chest</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe trying to fondle someones chest!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile", "Upper Body", "Lewd")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/touch_their_crotch
	flirtname = "Touch their crotch"
	flirtdesc = "GO FOR THE GOAL, that'll get their FUCKING attention!!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to grab someones crotch!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>grab the crotch of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to grab you by the crotch</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe trying to crotchfondle someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile", "Lower Body", "Lewd")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/heavy_petting
	flirtname = "Heavily Pet their Lap"
	flirtdesc = "Whatever they have under those clothes this'll get you to rubbing on it.  Maybe."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to rub someones crotch!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>rub the crotch of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to rub your crotch</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe trying to crotchrub someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile", "Lower Body", "Lewd")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/stare_at_them
	flirtname = "Stare at them"
	flirtdesc = "You just can't help but stare a them. They're magnificent."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to stare a hole through someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>stare the clothes off</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>staring at you like they're awestruck</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe trying to stare at someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expression", "Facial", "Lewd", "Coy", "\"Accidental\"")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/avoid_looking_at_them
	flirtname = "Avoid looking at them"
	flirtdesc = "They're just too much, looking at them makes you nervous."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to not stare a hole through someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>not stare the clothes off</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>having a hard time looking at you.  They may be awestruck</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe trying to stare at nobody really obviously!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expression", "Facial", "Coy", "Cute")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/look_at_the_goods
	flirtname = "Stare at their assets"
	flirtdesc = "Be it boobs or bulge, you can't stop your eyes from wandering to whatever they have that you want!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to stare at someones goods!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>memorize every inch of the assets that belong to</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>staring at your assets like they want a slice of you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe trying to memorize the shape of something on somebody!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expression", "Facial", "Lewd")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/fail_to_pickpocket
	flirtname = "Fail to pickpocket them"
	flirtdesc = "Oh yeah, just totally stuff a hand into their pants.  They totally won't notice that."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to poorly steal their car keys!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>steal something out of the pockets of them and fail spectacularly</span>! %TARGET% might notice you just groped them!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to pick pocket you or feel you up?</span> Probably feel you up. They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe not so good at pickpocketing people!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Tactile", "Coy", "\"Accidental\"", "Illegal")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/raise_eyebrow
	flirtname = "Raise an eyebrow at them"
	flirtdesc = "Something about them either makes you curious or judgemental. They're interesting either way."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to list an eyebrow at someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>raise an eyebrow at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>raising an eyebrow at you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe maybe eyeballing someone funny!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Expression", "Facial", "Coy")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

		if("React - Loom over them.")
			to_chat(A, span_notice("[src] is trying to <span class='love'>loom over you.</span> Remember to honor their OOC preferences. Maybe give them a response?"))
			to_chat(user, "You try to loom over [A], maybe they'll care about it.")
			SEND_SOUND(A, 'sound/f13effects/sunsetsounds/blush.ogg')


/datum/flirt/loom_over_them
	flirtname = "Loom over them"
	flirtdesc = "Be it protective or predatory, you just want to loom over them. It's fun."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to loom over someone!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>loom over</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>looming over you</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER is maybe maybe looming over someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Actions", "Nearby", "Expression")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

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
