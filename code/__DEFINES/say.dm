/*
	Defines for use in saycode and text formatting.
	Currently contains speech spans and message modes
*/



//Spans. Robot speech, italics, etc. Applied in compose_message().
#define SPAN_ROBOT "robot"
#define SPAN_YELL "yell"
#define SPAN_ITALICS "italics"
#define SPAN_SANS "sans"
#define SPAN_PAPYRUS "papyrus"
#define SPAN_REALLYBIG "reallybig"
#define SPAN_COMMAND "command_headset"
#define SPAN_CLOWN "clown"
#define SPAN_SINGING "singing"

//bitflag #defines for return value of the radio() proc.
#define ITALICS 1
#define REDUCE_RANGE 2
#define NOPASS 4

//Eavesdropping
#define EAVESDROP_EXTRA_RANGE 1 //how much past the specified message_range does the message get starred, whispering only

// A link given to ghost alice to follow bob
#define FOLLOW_LINK(alice, bob) "<a href=?src=[REF(alice)];follow=[REF(bob)]>(F)</a>"
#define TURF_LINK(alice, turfy) "<a href=?src=[REF(alice)];x=[turfy.x];y=[turfy.y];z=[turfy.z]>(T)</a>"
#define FOLLOW_OR_TURF_LINK(alice, bob, turfy) "<a href=?src=[REF(alice)];follow=[REF(bob)];x=[turfy.x];y=[turfy.y];z=[turfy.z]>(F)</a>"

#define LINGHIVE_NONE 0
#define LINGHIVE_OUTSIDER 1
#define LINGHIVE_LING 2
#define LINGHIVE_LINK 3

//whether the emote is visible or audible.
#define EMOTE_VISIBLE 1
#define EMOTE_AUDIBLE 2

//Don't set this very much higher then 1024 unless you like inviting people in to dos your server with message spam
#define MAX_MESSAGE_LEN			4096		//Citadel edit: What's the WORST that could happen?
#define MAX_FLAVOR_LEN			4096
#define MIN_FLAVOR_LEN			100
#define MIN_OOC_LEN				20 // Will not allow just smileys to be on OOC notes.
#define MAX_TASTE_LEN			40
#define MAX_NAME_LEN			42
#define MAX_BROADCAST_LEN		512
#define MAX_CHARTER_LEN			80

// Template for OOC notes.
#define OOC_NOTE_TEMPLATE "Non-ERP Notes\n\
	This exist for things like how to approach this character for IC things such as how to ask for going on adventurers!\n\
	But this person hasn't changed the info yet!\n\
	\n\
	Icebreaker!\n\
	This exists for this person to have set a quick way for you to break the IC with their character in a way that may lead to ERP, but this person hasn't changed this text to set one!\n\
	\n\
	Slavery: Ask\n\
	Non-Con: Ask\n\
	Vore: Ask\n\
	\n\
	\n\
	ERP Notes\n\
	...............Erotic Roleplay: Ask\n\
	...............Non-Con Roleplay: Ask\n\
	...............Partner Prefs: Ask\n\
	.............- Slavery: Ask\n\
	.............- Non-Con: Ask\n\
	.............- Vore: Ask\n\
	\n\
	Big Yes's\n\
	.............- This area\n\
	.............- exists to\n\
	.............- List out\n\
	.............- things you\n\
	.............- like.\n\
	\n\
	Hard No\n\
	.............- This area exists\n\
	.............- For you to list things\n\
	.............- You very specifically\n\
	.............- Do not like.\n\
	\n\
	\n\
	\n\
	***Roleplay Prefs***\n\
	Character Orientation: Ask\n\
	...Desired Post length: Ask\n\
	\n\
	...Desired RP System: Ask, this is for subtle, subtler, or emote.  Or, when its added, a mechanical erotic roleplay system!  Or some mix inbetween, but this person hasn't changed the text so ASK!\n\
	.My Post Perspective: Ask!"

// Is something in the IC chat filter? This is config dependent.
#define CHAT_FILTER_CHECK(T) (config.ic_filter_regex && findtext(T, config.ic_filter_regex))

// Audio/Visual Flags. Used to determine what sense are required to notice a message.
#define MSG_VISUAL (1<<0)
#define MSG_AUDIBLE (1<<1)

//Used in visible_message_flags, audible_message_flags and runechat_flags
#define EMOTE_MESSAGE (1<<0)
// Only show the overhead thing
#define ONLY_OVERHEAD (1<<1)
// Append the player's name to the front
#define PUT_NAME_IN (1<<2)

#define EMOTE_HEADER_TEXT "\
	The Following Chat Functions Exist \n\
	- _text_ underlines text, +text+ bolds text, and |text| italicizes text. \n\
	-- Works in Emote, Subtle, Say, Whisper and Radio chat. \n\
	\n\
	- %text lets you siiiing. \n\
	\n\
	- @ moves your name to that position in emotes and subtles. \n\
	\n\
	- ! at the start of a radio comm to emote over the radio \n\

	\n\
	We have added the following emoticons to say, add them to the end of your 'say' messages for say verb variation \n\
	:), :(, :D, ;D, :P, :O, :|, :/, :S, :*, :3, :>, :<, :C, :L, <3, :X, :#, :$,  \n\
	:@, :^), :&, :!, :?, B^U, :B, :J, >:(, >:D, >:P, >:3, >:O, >:|, >:/, >:S,  \n\
	"
//Dan is the best, <3 ~TK
//put space before the \ so it reads properly
// use \ for readability, but one big line. \n for a new line. \n\ for a new line and readability.
