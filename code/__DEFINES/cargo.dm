#define STYLE_STANDARD 1
#define STYLE_BLUESPACE 2
#define STYLE_CENTCOM 3
#define STYLE_SYNDICATE 4
#define STYLE_BLUE 5
#define STYLE_CULT 6
#define STYLE_MISSILE 7
#define STYLE_RED_MISSILE 8
#define STYLE_BOX 9
#define STYLE_SEETHROUGH 10
#define STYLE_FRUIT 11
#define STYLE_INVISIBLE 12


#define POD_ICON_STATE 1
#define POD_NAME 2
#define POD_DESC 3

#define POD_STYLES list(\
	list("supplypod", "supply pod", "An orbital supply drop pod."),\
	list("bluespacepod", "bluespace supply pod" , "An orbital supply drop pod. Returns upon delivery."),\
	list("centcompod", "\improper Centcom supply pod", "An orbital supply drop pod, this one appears to contain high-value cargo. Returns upon delivery."),\
	list("syndiepod", "blood-red supply pod", "An orbital supply drop pod, in intimidating colors. It's probably best to stand back from this."),\
	list("squadpod", "\improper MK. II supply pod", "An advanced orbital supply drop pod."),\
	list("cultpod", "bloody supply pod", "An orbital supply drop pod, this one bears the inscription ISS Event Horizon"),\
	list("missilepod", "cruise missile", "A missile that didn't detonate. There appears to be a hatch to access the internal payload, but it seems impossible to open."),\
	list("smissilepod", "\improper Syndicate cruise missile", "A missile that didn't detonate. There appears to be a hatch to access the internal payload, but it seems impossible to open."),\
	list("boxpod", "\improper Aussec supply crate", "An incredibly sturdy supply crate, designed to withstand orbital re-entry. Has 'Aussec Armory - 2532' engraved on the side."),\
	list("fruitpod", "\improper Orange", "An angry orange."),\
	list("", "\improper S.T.E.A.L.T.H. pod MKVII", "A supply pod that, under normal circumstances, is completely invisible to conventional methods of detection. How are you even seeing this?"),\
	list("", "", "")\
)

#define PACK_GOODY_NONE		0
#define PACK_GOODY_PUBLIC	1 //can be bought by both privates and cargo
#define PACK_GOODY_PRIVATE	2 //can be bought only by privates
