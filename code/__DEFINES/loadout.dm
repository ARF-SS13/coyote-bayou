//defines for loadout categories
//no category defines
#define LOADOUT_CATEGORY_NONE			"ERROR"
#define LOADOUT_SUBCATEGORY_NONE		"Miscellaneous"
#define LOADOUT_SUBCATEGORIES_NONE		list("Miscellaneous")

//the names of the customization tabs
#define SETTINGS_TAB 0
#define GAME_PREFERENCES_TAB 1
#define APPEARANCE_TAB 2
#define CHAR_INFO_TAB 3
#define ERP_TAB 4
//#define SPEECH_TAB 3
#define LOADOUT_TAB 5
#define CONTENT_PREFERENCES_TAB 6
#define KEYBINDINGS_TAB 7

//the names of the erp tabs - can be 0, 1, or "has_cock" thru "has_womb"
#define ERP_TAB_HOME 0
#define ERP_TAB_REARRANGE 1

//backpack
#define LOADOUT_CATEGORY_BACKPACK 				"In backpack"
#define LOADOUT_SUBCATEGORY_BACKPACK_GENERAL 	"General" //basically anything that there's not enough of to have its own subcategory
//#define LOADOUT_SUBCATEGORY_BACKPACK_TOYS 		"Toys"
#define LOADOUT_SUBCATEGORY_BACKPACK_BACKPACKS 	"Firearms"
#define LOADOUT_SUBCATEGORY_BACKPACK_MELEE	 	"Melee"
#define LOADOUT_SUBCATEGORY_BACKPACK_RATIONS 	"Snacks"
//#define LOADOUT_SUBCATEGORY_BACKPACK_VAULTGUNS	"Vault Guns"

//neck
#define LOADOUT_CATEGORY_NECK "Neck"
#define LOADOUT_SUBCATEGORY_NECK_GENERAL 	"General"
//#define LOADOUT_SUBCATEGORY_NECK_TIE 		"Ties"
#define LOADOUT_SUBCATEGORY_NECK_SCARVES 	"Scarves"

//mask
#define LOADOUT_CATEGORY_MASK "Mask"
#define LOADOUT_SUBCATEGORY_MASK_GENERAL 		"General"
#define LOADOUT_SUBCATEGORY_MASK_BANDANA 		"Bandanas"
//#define LOADOUT_SUBCATEGORY_MASK_MISCELLANEOUS  "Miscellaneous"

//hands
#define LOADOUT_CATEGORY_HANDS 				"Hands"

//uniform
#define LOADOUT_CATEGORY_UNIFORM 			"Uniform" //there's so many types of uniform it's best to have lots of categories
#define LOADOUT_SUBCATEGORY_UNIFORM_GENERAL "General"
#define LOADOUT_SUBCATEGORY_UNIFORM_TRADITIONAL  	"Traditional"
#define LOADOUT_SUBCATEGORY_UNIFORM_SUITS	"Suits"
#define LOADOUT_SUBCATEGORY_UNIFORM_SKIRTS	"Skirts"
#define LOADOUT_SUBCATEGORY_UNIFORM_DRESSES	"Dresses"
#define LOADOUT_SUBCATEGORY_UNIFORM_SWEATERS	"Sweaters"
#define LOADOUT_SUBCATEGORY_UNIFORM_PANTS	"Pants"
#define LOADOUT_SUBCATEGORY_UNIFORM_RAIDER	"Raider"
#define LOADOUT_SUBCATEGORY_UNIFORM_WASTELAND "Wasteland"
#define LOADOUT_SUBCATEGORY_UNIFORM_UNIFORMS "Uniforms"
#define LOADOUT_SUBCATEGORY_UNIFORM_JUMPSUITS "Jumpsuits"
#define LOADOUT_SUBCATEGORY_UNIFORM_MEDICAL "Medical Uniforms"
#define LOADOUT_SUBCATEGORY_UNIFORM_ESCORT "Escort"
#define LOADOUT_SUBCATEGORY_UNIFORM_TRIBAL "Tribal"

//suit
#define LOADOUT_CATEGORY_SUIT 				"Suit"
#define LOADOUT_SUBCATEGORY_SUIT_GENERAL 	"General"
#define LOADOUT_SUBCATEGORY_SUIT_MEDICAL 	"Medical Suits"
#define LOADOUT_SUBCATEGORY_SUIT_ARMOR 		"Armor"
#define LOADOUT_SUBCATEGORY_SUIT_BALLISTICVEST 		"Ballistic Vests"
#define LOADOUT_SUBCATEGORY_SUIT_JACKETS	"Jackets"
#define LOADOUT_SUBCATEGORY_SUIT_TAUR 		"Taur Saddles"
//#define LOADOUT_SUBCATEGORY_SUIT_FACTIONS		"Factions"

//Belt
#define LOADOUT_CATEGORY_BELT 				"Belt"

//head
#define LOADOUT_CATEGORY_HEAD 				"Head"
#define LOADOUT_SUBCATEGORY_HEAD_GENERAL 	"General"
#define LOADOUT_SUBCATEGORY_HEAD_COWBOY			"Cowboy hats"
#define LOADOUT_SUBCATEGORY_HEAD_HELMETS 		"Helmets"

//shoes
#define LOADOUT_CATEGORY_SHOES 		"Shoes"
#define LOADOUT_SUBCATEGORY_SHOES_GENERAL 	"General"
#define LOADOUT_SUBCATEGORY_SHOES_BOOTS 	"Boots"
//#define LOADOUT_SUBCATEGORY_SHOES_FACTIONS 		"Factions"

//gloves
#define LOADOUT_CATEGORY_GLOVES		"Gloves"

//glasses
#define LOADOUT_CATEGORY_GLASSES	"Glasses"

//donator items
#define LOADOUT_CATEGORY_DONATOR	"Special"

//how many prosthetics can we have
#define MAXIMUM_LOADOUT_PROSTHETICS	4

//what limbs can be amputated or be prosthetic
#define LOADOUT_ALLOWED_LIMB_TARGETS	list(BODY_ZONE_L_ARM,BODY_ZONE_R_ARM,BODY_ZONE_L_LEG,BODY_ZONE_R_LEG)

//options for modifiying limbs
#define LOADOUT_LIMB_NORMAL			"Normal"
#define LOADOUT_LIMB_PROSTHETIC		"Prosthetic"
#define LOADOUT_LIMB_AMPUTATED		"Amputated"

#define LOADOUT_LIMBS		 		list(LOADOUT_LIMB_NORMAL,LOADOUT_LIMB_PROSTHETIC,LOADOUT_LIMB_AMPUTATED) //you can amputate your legs/arms though

//loadout saving/loading specific defines
#define MAXIMUM_LOADOUT_SAVES 30	//Remember to increase this if more slots are added
#define LOADOUT_ITEM "loadout_item"
#define LOADOUT_COLOR "loadout_color"
#define LOADOUT_CUSTOM_NAME "loadout_custom_name"
#define LOADOUT_CUSTOM_DESCRIPTION "loadout_custom_description"
#define LOADOUT_CUSTOM_COLOR "loadout_custom_description"

//loadout item flags
#define LOADOUT_CAN_NAME (1<<0) //renaming items
#define LOADOUT_CAN_DESCRIPTION (1<<1) //adding a custom description to items
#define LOADOUT_CAN_COLOR (1<<2) //adding a custom dick to ur butt

//quirks
#define QUIRK_POSITIVE	"Positive"
#define QUIRK_NEGATIVE	"Negative"
#define QUIRK_NEUTRAL	"Neutral"
