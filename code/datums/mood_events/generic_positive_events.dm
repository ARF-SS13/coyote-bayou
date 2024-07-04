/datum/mood_event/hug
	description = span_nicegreen("Closeness with another, even if unwanted, reminds you that maybe people can be okay.")
	mood_change = 1
	timeout = 10 MINUTES

/datum/mood_event/arcade
	description = span_nicegreen("I beat the arcade game!")
	mood_change = 1
	timeout = 15 MINUTES

/datum/mood_event/blessing
	description = span_nicegreen("I've been blessed?  That's good, I think.")
	mood_change = 2
	timeout = 20 MINUTES

/datum/mood_event/book_nerd
	description = span_nicegreen("I have recently read a book.")
	mood_change = 3
	timeout = 25 MINUTES

/datum/mood_event/exercise
	description = span_nicegreen("Working out releases those endorphins!")
	mood_change = 3
	timeout = 45 MINUTES

/datum/mood_event/pet_animal
	description = span_nicegreen("Animals are adorable! I can't stop petting them!")
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/pet_pillow
	description = span_nicegreen("This is really nice pillow! If only it were real..")
	mood_change = 2
	timeout = 5 MINUTES

/*
/datum/mood_event/pet_animal/add_effects(mob/animal)
	description = span_nicegreen("\The [animal.name] is adorable! I can't stop petting [animal.p_them()]!")
*/

/datum/mood_event/honk
	description = span_nicegreen("Maybe clowns aren't so bad after all. Honk!")
	mood_change = 2
	timeout = 10 MINUTES

/datum/mood_event/bshonk
	description = span_nicegreen("Quantum mechanics can be fun and silly, too! Honk!")
	mood_change = 6
	timeout = 4800

/datum/mood_event/perform_cpr
	description = span_nicegreen("It feels good to save a life.")
	mood_change = 6
	timeout = 15 MINUTES

/datum/mood_event/oblivious
	description = span_nicegreen("What a lovely day.")
	mood_change = 3

/datum/mood_event/jolly
	description = span_nicegreen("I feel happy for no particular reason.")
	mood_change = 10
	timeout = 60 MINUTES

/datum/mood_event/optimism
	description = span_nicegreen("I feel kind of happy for no particular reason.")
	mood_change = 5
	timeout = 60 MINUTES

/datum/mood_event/focused
	description = span_nicegreen("I have a goal, and I will reach it, whatever it takes!") //Used for syndies, nukeops etc so they can focus on their goals
	mood_change = 12
	hidden = TRUE

/datum/mood_event/revolution
	description = span_nicegreen("VIVA LA REVOLUTION!")
	mood_change = 3
	hidden = TRUE

/datum/mood_event/cult
	description = span_nicegreen("I have seen the truth, praise the almighty one!")
	mood_change = 40 //maybe being a cultist isnt that bad after all
	hidden = TRUE

/datum/mood_event/heretics
	description = span_nicegreen("THE HIGHER I RISE, THE MORE I SEE.")
	mood_change = 12 //maybe being a cultist isnt that bad after all
	hidden = TRUE

/datum/mood_event/family_heirloom
	description = span_nicegreen("My family heirloom is safe with me.")
	mood_change = 1

/datum/mood_event/masked_mook
	description = span_nicegreen("I'm safe in my protective mask.")
	mood_change = 3

/datum/mood_event/goodmusic
	description = span_nicegreen("There is something soothing about that music I heard.")
	mood_change = 5
	timeout = 30 MINUTES

/datum/mood_event/chemical_euphoria
	description = span_nicegreen("Heh...hehehe...hehe...")
	mood_change = 4

/datum/mood_event/chemical_laughter
	description = span_nicegreen("Laughter really is the best medicine! Or is it?")
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/chemical_superlaughter
	description = span_nicegreen("*WHEEZE*")
	mood_change = 12
	timeout = 3 MINUTES

/datum/mood_event/betterhug
	description = span_nicegreen("Someone was very nice to me.")
	mood_change = 4
	timeout = 15 MINUTES

/datum/mood_event/betterhug/add_effects(mob/friend)
	description = span_nicegreen("[friend.name] was very nice to me.")

/datum/mood_event/besthug
	description = span_nicegreen("Someone is great to be around, they make me feel so happy!")
	mood_change = 5
	timeout = 20 MINUTES

/datum/mood_event/besthug/add_effects(mob/friend)
	description = span_nicegreen("[friend.name] is great to be around, [friend.p_they()] makes me feel so happy!")

/datum/mood_event/happy_empath
	description = span_warning("Someone seems happy!")
	mood_change = 3
	timeout = 10 MINUTES

/datum/mood_event/happy_empath/add_effects(mob/happytarget)
	description = span_nicegreen("[happytarget.name]'s happiness is infectious!")

/datum/mood_event/headpat
	description = span_nicegreen("Headpats are nice.")
	mood_change = 1
	timeout = 5 MINUTES

/datum/mood_event/hugbox
	description = span_nicegreen("I hugged a box of hugs recently...")
	mood_change = 1
	timeout = 5 MINUTES

/datum/mood_event/plushpet
	description = span_nicegreen("I pet a plushie recently.")
	mood_change = 1
	timeout = 5 MINUTES

/datum/mood_event/plushplay
	description = span_nicegreen("I've played with plushes recently.")
	mood_change = 3
	timeout = 10 MINUTES

/datum/mood_event/breakfast
	description = span_nicegreen("Nothing like a hearty breakfast to start the day.")
	mood_change = 2
	timeout = 15 MINUTES

/datum/mood_event/nanite_happiness
	description = "<span class='nicegreen robot'>+++++++HAPPINESS ENHANCEMENT+++++++</span>\n"
	mood_change = 7

/datum/mood_event/nanite_happiness/add_effects(message)
	description = "<span class='nicegreen robot'>+++++++[message]+++++++</span>\n"


/datum/mood_event/area
	description = "" //Fill this out in the area
	mood_change = 0

//Power gamer stuff below
/datum/mood_event/drankblood
	description = span_nicegreen("I have fed greedly from that which nourishes me.")
	mood_change = 10
	timeout = 900

/datum/mood_event/coffinsleep
	description = span_nicegreen("I slept in a coffin during the day. I feel whole again.")
	mood_change = 8
	timeout = 1200

//Cursed stuff below.

/datum/mood_event/orgasm
	description = span_userlove("I came!") //funny meme haha
	mood_change = 3
	timeout = 100 SECONDS

/datum/mood_event/fedpred
	description = span_nicegreen("I've devoured someone!")
	mood_change = 3

/datum/mood_event/fedprey
	description = span_nicegreen("It feels quite cozy in here.")
	mood_change = 3

/datum/mood_event/hope_lavaland
	description = span_nicegreen("What a peculiar emblem.  It makes me feel hopeful for my future.")
	mood_change = 5

/datum/mood_event/artok
	description = span_nicegreen("It's nice to see people are making art around here.")
	mood_change = 2
	timeout = 2 MINUTES

/datum/mood_event/artgood
	description = span_nicegreen("What a thought-provoking piece of art. I'll remember that for a while.")
	mood_change = 3
	timeout = 3 MINUTES

/datum/mood_event/artgreat
	description = span_nicegreen("That work of art was so great it made me believe in the goodness of humanity. Says a lot in a place like this.")
	mood_change = 4
	timeout = 4 MINUTES

/datum/mood_event/cleared_stomach
	description = span_nicegreen("Feels nice to get that out of the way!")
	mood_change = 3

// RINGS
/datum/mood_event/equipped_ring
	description = span_nicegreen("The ring steels your mind against worries about wealth.")
	mood_change = 0.3 //Just enough to cross a mood threshold

/datum/mood_event/equipped_ring/gold
	description = span_nicegreen("The ring steels your mind against worries about wealth.")
	mood_change = 0.6

/datum/mood_event/equipped_ring/plasma
	description = span_nicegreen("The ring steels your mind against worries about wealth.")
	mood_change = 1

/datum/mood_event/equipped_ring/diamond
	description = span_nicegreen("The ring steels your mind against worries about wealth.")
	mood_change = 2

/datum/mood_event/equipped_ring/bluespace
	description = span_nicegreen("The ring steels your mind against worries about wealth.")
	mood_change = 3

// NECKLACE

/datum/mood_event/equipped_necklace/any
	description = span_nicegreen("Fashion!")
	mood_change = 0.5

/datum/mood_event/equipped_necklace/sapphire
	description = span_nicegreen("The blue glow of the sapphire gem calms your mind.")
	mood_change = 1

/datum/mood_event/equipped_necklace/ruby
	description = span_nicegreen("The red glow of the ruby gem motivates your mind.")
	mood_change = 1

/datum/mood_event/equipped_necklace/heart
	description = span_nicegreen("Something about the heart shape of the necklace brings you hope.")
	mood_change = 1

/datum/mood_event/equipped_necklace/wolf
	description = span_nicegreen("The spirit of a wolf dwells within you.")
	mood_change = 1

/datum/mood_event/equipped_necklace/pearlnecklace
	description = span_nicegreen("Elegance. Grace. Beauty. What a lovely necklace.")
	mood_change = 1

// Lewd positive events

/datum/mood_event/butt_slap
	description = span_love("Smacking that butt felt extremely satisfying~!")
	mood_change = 3
	timeout = 2 MINUTES
