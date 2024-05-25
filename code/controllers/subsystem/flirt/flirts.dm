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
	categories = list("Clarification")
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
	categories = list("Clarification") 
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
	categories = list("Ranged Flirts") // yes its an approval
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
	categories = list("Clarification")
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
	categories = list("Ranged Flirts")
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
	aoe_message = "%FLIRTER% <span class='love'>blushes</span>!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
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
	aoe_message = "%FLIRTER% tries to sniffs the air!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% tries to pinches someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% tries to caress someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% tries to brush against someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% tries to grope someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% tries to booty grope someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% tries to grope someone's side!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe making a kissy face at someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe trying to get someone to kiss them!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe winking at someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
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
	aoe_message = "%FLIRTER% is maybe waggling a finger at someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
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
	aoe_message = "%FLIRTER% is maybe leaning on someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe snuggling up close with someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe planting a cheek kiss on someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe planting a deep kiss on someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe planting a soft kiss on someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe giving someone a subtle smile!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
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
	aoe_message = "%FLIRTER% is maybe giving someone a provocative smile!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
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
	aoe_message = "%FLIRTER% is maybe playing with their hair?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
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
	aoe_message = "%FLIRTER% is maybe biting their lower lip?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/yummy_broob
	flirtname = "Bite them on the boob (or chest)"
	flirtdesc = "Sink your teeth into those teats (or chest)!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to chomp down on someone's boob (or chest)."
	give_message_span = "notice"
	self_message = "You try to <span class='love'>bite %TARGET%'s boob (or chest)</span>, that'll get their attention!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>chomping down on one of your boobs (or chest)!</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% looks kinda hungry."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe side eyeing hard at someone?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
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
	aoe_message = "%FLIRTER% is maybe playing rump attack with someone?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe playing touch and go with someone?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe playing touch and go with someone?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe being a nuzzle creature with someone?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe trying to chew on someones neck!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe trying to hold someones hand!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/fondle_chest
	flirtname = "Fondle their chest/breasts"
	flirtdesc = "Be it fondling a tit or rubbing their rock hard chest. You wanna do it."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to sink your teeth into someones neck!"
	give_message_span = "notice"
	self_message = "You try to <span class='love'>fondle the breasts of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to fondle your chest</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to fondle someones chest!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe trying to crotchfondle someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe trying to crotchrub someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe trying to stare at someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe trying to stare at nobody really obviously!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
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
	aoe_message = "%FLIRTER% is maybe trying to memorize the shape of something on somebody!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
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
	aoe_message = "%FLIRTER% is maybe not so good at pickpocketing people!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
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
	aoe_message = "%FLIRTER% is maybe maybe eyeballing someone funny!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

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
	aoe_message = "%FLIRTER% is maybe maybe looming over someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/pay_them_attention
	flirtname = "Pay them more attention than normal"
	flirtdesc = "You just can't help it, your eyes just don't want to pull away from them!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to ULTRA watch someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>are really watching</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>paying you way too much attention</span>! They seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe really paying attention to someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/sneed_at_them
	flirtname = "Snear at someone"
	flirtdesc = "Ugh, they're so awful, you can't help but snear at them. They're so below you."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to snear at someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>are really snearing at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>snearing at you</span>?  Maybe they need to be put in their place because they seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe snearing at someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/shove_them
	flirtname = "Shove someone"
	flirtdesc = "Baka!  You can't STAND them, push them over and assert your dominance!! (submissive)"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to shove someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>are really trying to shove</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to shove you</span>?  Maybe they need to be put in their place because they seem frisky~"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to shove someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/squeeze_them_like_a_ketchup_bottle
	flirtname = "Squeeze them"
	flirtdesc = "Maybe its cute agression, maybe they just seem squishable. But you're gonna mush them like a squishmallow!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to squeeze someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>are really trying to squeeze</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to squeeze you</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to squeeze someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/play_with_their_hair
	flirtname = "Play with their hair"
	flirtdesc = "Okay, its a bit possessive, but you just wanna play with their hair. Is that so bad?"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to play with someones hair!"
	give_message_span = "notice"
	self_message = "You <span class='love'>are really trying to play with the hair of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to play with your hair</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to play with someone's hair!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/tick_check
	flirtname = "Check them for wounds"
	flirtdesc = "Ohmygosh, how are they NOT hurt, maybe I can take a closer look...?"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to look someone over for hurts!"
	give_message_span = "notice"
	self_message = "You <span class='love'>are really looking over the possible wounds of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>checking your possible hurts out a little too closely</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to see if someones hurt a bit too hard!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/kabedon
	flirtname = "Corner them"
	flirtdesc = "If you just put your arm over them against the wall then maybe they can't get away...?"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to corner someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>are trying to corner</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to corner you to stop an escape</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to corner somebody for kisses!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/dont_go_please
	flirtname = "Grab their wrist"
	flirtdesc = "If you just grab their wrist they'll have to listen!!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to grab someone by the wrist!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to grab the wrist of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to grab your wrist</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to grab someones wrist!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/uwu_notice_me_senpai
	flirtname = "Appear more demure for them"
	flirtdesc = "I'll just act submissive, they like submissive, right? I hope they do..."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to act more submissive for someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to act more submissive for</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to act really submissive for you</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to act really submissive!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/time_to_break_in_the_kitchen_counter
	flirtname = "Bend them over"
	flirtdesc = "Just grab them and bend them over, it's not that hard you caveman."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to bend someone over!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to bend over</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to bend you over</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to bend somebody over!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/big_muscles_himbo_moment
	flirtname = "Look heroic for them"
	flirtdesc = "With armor this shiny and muscles this big there's no way they won't think I'm cool if I flex..."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to flex and look cool!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to flex and look cool for</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to flex and look like a hero for you</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to look cool for someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/am_baby
	flirtname = "Need help from them"
	flirtdesc = "Augh, this is just so complicated. I bet they could help though..."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to really flub what you're doing!"
	give_message_span = "notice"
	self_message = "You <span class='love'>absolutely fail to do something in hopes that you're noticed by</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>failing at some task on purpose to get your attention</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe a bit more clumsy than makes sense!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/grabby_hands
	flirtname = "Grab their arm"
	flirtdesc = "No you don't, you aren't getting away from me!!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to grab someone by the arm!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try like crazy to grab the arm of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to grab your arm</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe a bit more clumsy than makes sense!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/hair_puller
	flirtname = "Pull their hair"
	flirtdesc = "This'll get their attention for sure."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to grab someone's hair and pull!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try grab and pull the hair of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to grab your hair and pull it</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to pull someones hair!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/grab_belt
	flirtname = "Grab their belt"
	flirtdesc = "Surely you can't be move obvious than this...`"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to grab someone's belt and try to pull them to you."
	give_message_span = "notice"
	self_message = "You <span class='love'>try grab and pull the belt of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to grab your belt and pull you up against them</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to pull someones belt!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/melon_mush
	flirtname = "Squish your breasts together"
	flirtdesc = "They're fun to play with, but this'll probably get their attention pretty quick!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to squeeze your own tits together for a show!"
	give_message_span = "notice"
	self_message = "You <span class='love'>squeeze your tits together, hopefully gaining the attention of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to squish their cleavage together to get your attention</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to smush their own boobs together!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/ooooo_youre_in_trouble
	flirtname = "Cross your arms under your bosom"
	flirtdesc = "This will surely make it clear how upset you are at them, try sniffing and pulling your braid if you have one. Works every time."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to cross your arms under your breasts!"
	give_message_span = "notice"
	self_message = "You <span class='love'>cross your arms under your bosom, trying to make sure your displeasure is known by</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to cross their arms under their breasts to look upset, but all it does is frame them better</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to look cross at someone!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/look_what_i_got
	flirtname = "Draw attention to your breasts"
	flirtdesc = "One way or another, be it by finger, look or touch, I can surely get them to notice my breasts!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to make someone look at your tits!"
	give_message_span = "notice"
	self_message = "You <span class='love'>do something in hopes of getting your breasts to be the focus of attention for</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to get you to pay attention to their breasts one way or another</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to get themselves checked out!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/sneaky_nipple_stuff
	flirtname = "Let them catch you playing with a nipple"
	flirtdesc = "Oops, did I just let them see me pinch myself?  How could I make such a simple mistake?"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to pinch your own nipple and get caught!"
	give_message_span = "notice"
	self_message = "You <span class='love'>slide two fingers to one of your nipples, pinching it sneakily in hopes of being spotted by</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>pinching their own nipple and making sure you notice</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to rearrange their top?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/obvious_nipple_stuff
	flirtname = "Play with your nipples openly"
	flirtdesc = "Damnit, I can't stop myself. They're just so sensitive..."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to pinch your own nipple or nipples and get caught!"
	give_message_span = "notice"
	self_message = "You <span class='love'>slide two fingers to one of your nipples, pinching it super obviously in hopes of being spotted by</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>pinching their own nipples and making sure you notice</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to play with their nipples openly!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/oral_fixation_at_work
	flirtname = "Mouth an object"
	flirtdesc = "Fidgety today, my mouth just keeps watering. At least I have this pen to nibble on."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to suck on, or nibble, an object!"
	give_message_span = "notice"
	self_message = "You <span class='love'>start licking and sucking on some object. Maybe it will draw the attention of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>applying their oral fixation on something to get your attention</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to nibble an object to death!"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/tongue_in_cheek
	flirtname = "Push your tongue into your cheek"
	flirtdesc = "I'll push my tongue into my cheek, maybe they'll understand THAT."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to push your tongue into your cheek!"
	give_message_span = "notice"
	self_message = "You <span class='love'>push your tongue into your cheek, implying a lot for</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>sticking their tongue in their cheek to imply something</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe trying to get some food out of their teeth?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/whine_like_a_bitch
	flirtname = "Whine for their attention"
	flirtdesc = "Oh GOSH, they're just so- oh my gosh- augh- I just want to- shl;kgds-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to whine your brains out!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to let out a whine for attention at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>whining at you needily</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe hurt?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/touch_their_cheek
	flirtname = "Touch their cheek"
	flirtdesc = "If I just give them a soft touch maybe they'll be okay."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to touch someones cheek!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to touch the cheek of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to touch your cheek</span>? A bit frisky, innit?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is looking if someone has something in their eye?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/pet_them
	flirtname = "Pet them"
	flirtdesc = "Aww, they're so cute."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to pet someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to pet</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to pet you</span>? How patronizing!!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is petting someone like a dog."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/soothe_them
	flirtname = "Soothe them"
	flirtdesc = "Shh, calm down now."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to soothe someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to soothe</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to soothe you with soft noises</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is making soft noises."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/thighs_grater
	flirtname = "Rub your thighs together"
	flirtdesc = "Mmmf, I gotta find somewhere private if they keep this up..."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to rub your thighs together!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to sneakily rub your thighs together because of the stuff being done by</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>rubbing their thighs together because of what you've been doing</span>? How frisky."
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is trying to get comfy."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/hide_your_shame
	flirtname = "Hide your arousal"
	flirtdesc = "I've totally lost control, but maybe I can hide it from them..."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to try (and fail) to hide how turned on you are!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to shift and squirm, hiding just how down bad you are for</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to hide just how turned on they are</span>? How cute."
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is obviously uncomfortable."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/hand_to_breast
	flirtname = "Put a hand on your own breasts"
	flirtdesc = "Oh dear, that really took the air out of me, if only I could fan myself off too."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to put a hand to your chest."
	give_message_span = "notice"
	self_message = "You <span class='love'>put a hand to your own breasts, whatever happened to make you do this has you flustered and its all the fault of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>putting a hand to their own breast to hide how much you've flustered them</span>? How cute."
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe a bit overheated."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/arms_akimbo
	flirtname = "Put your hands on your hips"
	flirtdesc = "Ooooh, that creature!  I'll show them!!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to put put your hands on your hips!"
	give_message_span = "notice"
	self_message = "You <span class='love'>put your hands to your hips to show your displeasure with</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>puffing up and putting their hands to their hips to fluff up and look bigger</span>? How cute."
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is maybe a bit angry."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/breast_interception
	flirtname = "Push your breasts against them"
	flirtdesc = "Enough games, I'll just put my tits DIRECTLY on them. There's no way they can ignore THAT."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to put put your breasts directly on or against someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>put your breasts directly on or against</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>pushing their breasts against you to get your attention</span>? How cute."
	target_message_span = "notice"
	aoe_message = "%FLIRTER% isn't interested in personal space."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/crotch_interception
	flirtname = "Push your crotch against them"
	flirtdesc = "Enough games, I'll just put my crotch DIRECTLY on them. There's no way they can ignore THAT."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to put put your crotch directly on or against someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>put your crotch directly on or against</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>pushing their crotch against you to get your attention</span>? How lewd."
	target_message_span = "notice"
	aoe_message = "%FLIRTER% isn't interested in personal space."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/grind_on_them_mmo_style
	flirtname = "Grind on their lap"
	flirtdesc = "This seat is lumpy. Maybe if I just squirm on it some?"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to roll your hips and press your backside down against someones lap!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to grind against the lap of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>grinding against your lap</span>? How lewd!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% isn't very comfortable where they're sitting."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/boopersnooter
	flirtname = "Poke their nose"
	flirtdesc = "Aww that cute little button of a nose, I just can't help myself-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to poke the nose of somebody!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to boop the nose of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to boop your snoot</span>? AAAAA!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is probably not trying to pick someone elses nose."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/poke_their_chest
	flirtname = "Poke their chest"
	flirtdesc = "I'm going to poke them and THAT will get their attention!!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to poke the chest of somebody!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to poke the chest of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to poke your chest</span>? Okay?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% maybe has an issue with someones outfit."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/poke_their_breast
	flirtname = "Poke their breast"
	flirtdesc = "Squishy. Jiggly. Bouncy. Round. I just can't not-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to poke somebodies tit!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to poke the breast of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to poke your breast</span>? Whoa!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% probably didn't just poke someones tit."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/poke_their_tummy
	flirtname = "Poke their tummy"
	flirtdesc = "Rotund. Squishy. Jiggly. Bouncy. Round. Tight or flabby. I just can't not-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to poke somebodies stomach!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to poke the stomach of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to poke your stomach</span>? Whoa!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% probably didn't just poke someones belly."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/poke_their_thigh
	flirtname = "Poke their thigh"
	flirtdesc = "Melon destroying. Juicy. Well muscled. Shapely.  I have to-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to poke somebodies stomach!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to poke the stomach of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to poke your thigh</span>? Whoa!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% probably didn't just poke someones thigh."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/shush_em
	flirtname = "Put a finger over their mouth"
	flirtdesc = "Shshsh, no more words, only us!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to try and silence someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to put your finger over their mouth and silence</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to put a finger over your mouth to quiet you</span>? Whoa!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% probably didn't just hush someone."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/you_wont_no_balls_having_ass_fucker_you_cant
	flirtname = "Tell them to 'make' you do something"
	flirtdesc = "They're too much of a big baby to order you around! They couldn't make you do anything!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to brat out!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to tell</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>saying 'make me' at you</span>? Wait a minute here!"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% probably didn't just grow demon horns."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/stare_at_them
	flirtname = "Stare defiantly at them"
	flirtdesc = "Whatever. I won't do what they say, I'll stand my ground!!"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to have a staring contest with someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to stare a hole through</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>staring a hole through you defiantly</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% isn't blinking much."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/touch_me_uwu
	flirtname = "Beg them to touch you"
	flirtdesc = "asjklfdgh- I can't- please- please- please just- just touch me-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to beg to be touched!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to beg to be touched by</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>begging you with all their might to touch them</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is blathering a bit."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/take_me_now_you_fool
	flirtname = "Ask to be taken"
	flirtdesc = "I can't do this anymore, maybe if I just debase myself and ask-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to flat out ask to be taken!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to form the words to get taken by</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to get you to just flat out take them</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is blathering a lot."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/ask_for_kiss
	flirtname = "Ask to be kissed"
	flirtdesc = "It's just a kiss, how could it end up like this?"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to flat out ask to be kissed!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to form the words to get kissed by</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to get you to just flat out kiss them</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is blathering a lot."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/make_it_crytal_clear
	flirtname = "Let them know you want them"
	flirtdesc = "I hate these games, I'm just going to tell them what I want-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to flat out tell someone that you want them!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to form the words to make it clear you want</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to get you to just flat out kiss them</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is blathering a lot."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/eyelash_attack
	flirtname = "Flutter your eyelashes at them"
	flirtdesc = "I'm just gonna look oh so innocent real fast-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to flutter your eyelashes at someone!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to flutter your lashes at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to coyly flutter their lashes at you</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% maybe has something in their eye?"
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/tail_to_nose
	flirtname = "Boop their nose with your tail"
	flirtdesc = "I'll use tail whip-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to push your tail under someones nose!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to push your tail under the nose of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to push their tail up under your nose</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is being a little clumsy with their tail."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/asthma
	flirtname = "Lose your breath from them"
	flirtdesc = "Oh- ah- uh- I can't-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You breath is ready to catch!"
	give_message_span = "notice"
	self_message = "You <span class='love'>breath tries to catch while looking at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>losing their breath looking at you</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% might need a breather."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/earthquake
	flirtname = "Heave your bosom"
	flirtdesc = "Why you- you wretched creature- I'll-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You prepare to heave your breasts as a show of displeasure!"
	give_message_span = "notice"
	self_message = "You <span class='love'>heave your breasts in a displeasured manner towards</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>heaving their breasts at you?</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% stretches a bit."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/grin_deviously
	flirtname = "Grin at them deviously"
	flirtdesc = "Oh man, if I can just- and take that off them- and put them-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You prepare to give your most devious grin!"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to flash your most lecherious smile at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>grinning at you way too deviously</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% flashes a winning smile at someone."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/crotch_stare
	flirtname = "Stare at their crotch"
	flirtdesc = "It's just right there- I could just reach out- oh- I want that-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You prepare to try not to get caught (lie) staring at someones crotch!"
	give_message_span = "notice"
	self_message = "You <span class='love'>stare directly at the crotch of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>staring directly at your crotch</span>? Are they drooling a little?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% seems lost in thought."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/lick_your_lips
	flirtname = "Lick your lips"
	flirtdesc = "Oh my gosh, delicious- I just want to put them in my mouth-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You just about can't stop yourself from licking your lips at this point-"
	give_message_span = "notice"
	self_message = "You <span class='love'>try not to get caught licking your lips while looking at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>licking their lips when they look at you</span>? Are they drooling a little?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% could maybe use a snack."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/purse_your_lips
	flirtname = "Purse your lips"
	flirtdesc = "Gosh, they're so frustrating- I'm going to pout-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You just about can't stop yourself from pushing your lips together and pouting-"
	give_message_span = "notice"
	self_message = "You <span class='love'>push your lips together and pout at</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>pursing their lips together and pouting at you</span>? Kissable?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% could maybe use some chapstick."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/shake_from_touch
	flirtname = "Shake from their touch"
	flirtdesc = "They're so electric- I can't-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You just about can't stop yourself from shivering from a touch you just recieved-"
	give_message_span = "notice"
	self_message = "You <span class='love'>shiver at the touch of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>shivering from the touch you just gave them</span>?  Cute"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% looks a bit cold."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/gasp_from_touch
	flirtname = "Gasp from their touch"
	flirtdesc = "Their touch- I can't breath-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You just about can't breath after recieving the touch you just got-"
	give_message_span = "notice"
	self_message = "You <span class='love'>gasp from the touch of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>gasping from whatever you just did to them</span>?  Cute"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% looks a little surprised."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/moan_at_them
	flirtname = "Moan at them"
	flirtdesc = "It's too much- I can't stop myself from making noise- oh gosh-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You try to stop the moan, but you're probably going to fail-"
	give_message_span = "notice"
	self_message = "You <span class='love'>moan from the action that was just done by</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>moaning because of something you just did</span>?  Cute"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% yawned."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/eyeballing_you_boi
	flirtname = "Lid your eyes and watch them"
	flirtdesc = "What... are they up to?  I better keep an eye on them."
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "Your eyelids droop and you begin to prepare to watch someone closely-"
	give_message_span = "notice"
	self_message = "You <span class='love'>lid your eyes and watch</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>just started giving you bedroom eyes and watching you like a hawk</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% looks a little eepy." //sl is optional
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/sneaky_peaky
	flirtname = "Sneak a peak at the goods"
	flirtdesc = "Whoa- that's- oh boy I hope they don't catch me looking. (lie)"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You prepare to sneak a peak at someone nearby-"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to sneak a peak at something that belongs to</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to sneak a peak at you. Something about you has clearly roused their attention</span>."
	target_message_span = "notice"
	aoe_message = "%FLIRTER% looks distracted."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Ranged Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/take_them_in_hand
	flirtname = "Capture their hand between your breasts"
	flirtdesc = "Oh, they're just so sweet, maybe I can just hold their hand and-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You get ready to snatch someones hand and hold it to your breasts-"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to grab the hand of %TARGET% and put it between your breasts</span>!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to take your hand and bury it against their chest</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% seems a bit fidgety."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/head_to_boob
	flirtname = "Place their head on your chest"
	flirtdesc = "Surely I can make them feel better with a little closeness-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You prepare to put their hea"
	give_message_span = "notice"
	self_message = "You <span class='love'>attempt to place %TARGET%'s head to your chest!</span>"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to rest your head on their chest</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is snuggling with someone."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/grab_their_hips
	flirtname = "Grab their hips"
	flirtdesc = "Stop squirming- come here- I swear I'm going to-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You prepare mentally to grab someone by the hips-"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to grab the hips of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to grab you by the hips</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is trying to touch someone."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE

/datum/flirt/pull_their_tail
	flirtname = "Pull their tail"
	flirtdesc = "I'm gonna yank the mess out of that if I can grab it-"
	flirticon = 'icons/obj/in_hands.dmi'
	flirticon_state = "blushfox"
	give_message = "You prepare mentally to grab someone by the tail-"
	give_message_span = "notice"
	self_message = "You <span class='love'>try to grab the tail of</span> %TARGET%!"
	self_message_span = "notice" // check them out in spans.dm!
	target_message = "%FLIRTER% is maybe <span class='love'>trying to grab you by the tail</span>?"
	target_message_span = "notice"
	aoe_message = "%FLIRTER% is trying to touch someones tail."
	aoe_message_span = "notice"
	aoe_range = 1
	categories = list("Close Flirts")
	sound_to_do = 'sound/f13effects/sunsetsounds/blush.ogg'
	requests_reply = TRUE
