// Author: GremlingSS

// Some patches made to support the framework of having the matrix turfs transition you into different Z levels around the edges.
// To continue my coding standard.

// Oh for the love of God. Enough with the MORBIUS. What’s even the joke???? “Hahahaha hey guys the movie sucks but I pretend it’s good”???? THATS NOT EVEN A FUCKING JOKE. Holy shit my dick is going to fall out of its foreskin if I have to hear, “hehe it’s morbin time” ONE MORE TIME. Not only is it NOT funny, IT DOESNT EVEN MAKE SENSE. THE POWER RANGERS HAVENT BEEN RELEVANT IN DECADES. MORBIUS SUCKS THE MOVIE IS COMPLETE TRASH AND IM ASHAMED TO HAVE SPENT MONEY ON IT. You know…. I never would have seen the movie without all of these “memes”(unfunny shitposts). I would have been a MUCH HAPPIER PERSON. So fuck your “MORBIUS” your “mighty morbin more morbs morbidly MORBIUS BULLSHIT” NO ONE CARES, YOU ARENT FUNNY. Does not a singular human being have any independent thought anymore???? “Morb morb morb morb” you’re like a BUNCH OF SEAGULLS. SEA GULLS. What the FUCK does “morbin” even mean????? ITS NOT A WORD. ITS JUST GOBBLE GOOP. I feel like I am the last truly sentient human being on earth. IM BEING DRIVEN TO THE BRINK OF INSANITY. PLEASE FOR THE LOVE OF GOD. TAKE YOUR MORBIUS BULLSHIT, SHOVE IT UP YOUR ASS, AND GO OUTSIDE. Maybe if you went outside you could get “morb” bitches on your dick??!!! YOU LIKE THAT, YOU SEE WHAT YOUVE REDUCED ME INTO. I am a shell of a man and all of you collectively are to blame.

// This meme has spread like a debilitating illness AND I CANT GET AWAY FROM IT. THE FALL OF WESTERN SOCIETY IS HERE AND THIS COMPLETE UNFUNNY DRIBBLE OF A MEME IS PART OF THE PROBLEM. WHAT THE FUCK DOES “gETtiNg MoRBed” EVEN MEAN. it makes ZERO SENSE. ITS JUST GIBBERISH. FUCKING GIBB ER ISH. ITS NOT FUNNY. Saying “morb” LIKE ITS ITS OWN PUNCHLINE IS NOT COMEDY. IT IS COMEDIC AND CULTURAL DEGRADATION. Are we really so stunted as a generation that even the mention of any word that starts with m-o-r-b is FUNNY??? IN WHAT FUCKING UNIVERSE. Is it funny because it isn’t funny because praising something bad is now good??????? HOW MANY LAYERS OF IRONY DO WE NEED. HOW FAR DOES THE RABBIT HOLE GO. This website has stripped me of EVERY LAST BRAINCELL. GOING ON REDDIT FEELS LIKE IM GETTING A SUPER HERO INDUCED LOBOTOMY. I hate MORBIUS. I HATE IT. I know I’m just going to get FLOODED WITH “get morbed, this guy got morbed, what morb does to a man” HAHAHAHHAHAHHAHAHAHAHAHAHHQHQHAHAHAHAHAHWHHSHWBSQIISHWINSIQKSBDD SSSSOOOOOOOOOOOO FUNNNNNNNNYYYYYYY AGAGAGGAGHHHHHHHHH

/turf/closed/indestructible/f13/matrix
	var/destination_z
	var/destination_x
	var/destination_y

/turf/closed/indestructible/f13/matrix/Initialize()
	. = ..()


/turf/closed/indestructible/f13/matrix/is_transition_turf()
	if(destination_x || destination_y || destination_z)
		return 1

/turf/closed/indestructible/f13/matrix/Bumped(atom/movable/A)
	. = ..()

	if(destination_z && destination_x && destination_y && !(A.pulledby || !A.can_be_z_moved))
		var/tx = destination_x
		var/ty = destination_y
		var/turf/DT = locate(tx, ty, destination_z)
		var/itercount = 0
		while(DT.density || istype(DT.loc,/area/shuttle)) // Extend towards the center of the map, trying to look for a better place to arrive
			if (itercount++ >= 100)
				log_game("SPACE Z-TRANSIT ERROR: Could not find a safe place to land [A] within 100 iterations.")
				break
			if (tx < 128)
				tx++
			else
				tx--
			if (ty < 128)
				ty++
			else
				ty--
			DT = locate(tx, ty, destination_z)

		var/atom/movable/AM = A.pulling
		A.forceMove(DT)
		if(AM)
			var/turf/T = get_step(A.loc,turn(A.dir, 180))
			AM.can_be_z_moved = FALSE
			AM.forceMove(T)
			A.start_pulling(AM)
			AM.can_be_z_moved = TRUE

		//now we're on the new z_level, proceed the space drifting
		stoplag()//Let a diagonal move finish, if necessary

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/turf/closed/indestructible/f13/matrix/attack_ghost(mob/dead/observer/user)
	if(destination_z)
		var/turf/T = locate(destination_x, destination_y, destination_z)
		user.forceMove(T)
