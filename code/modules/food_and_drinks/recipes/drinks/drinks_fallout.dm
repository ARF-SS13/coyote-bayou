/// Fallout drink page, keep this page to fallout drinks, the other ones are for not so fallout drinks.

/// Nuka Variants

/datum/chemical_reaction/nukafloat
	name = "Cosmic Float"
	id = /datum/reagent/consumable/nukafloat
	results = list(/datum/reagent/consumable/nukafloat = 15)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 5, /datum/reagent/consumable/sugar = 5, /datum/reagent/consumable/cream = 5)

/datum/chemical_reaction/sunsetfloat
	name = "Sunset Float"
	id = /datum/reagent/consumable/sunsetfloat
	results = list(/datum/reagent/consumable/sunsetfloat = 15)
	required_reagents = list(/datum/reagent/consumable/sunset = 5, /datum/reagent/consumable/ice = 5, /datum/reagent/consumable/cream = 5)

/datum/chemical_reaction/nukashine
	name = "Cosmicshine"
	id = /datum/reagent/consumable/ethanol/nukashine
	results = list(/datum/reagent/consumable/ethanol/nukashine = 2)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 1, /datum/reagent/consumable/ethanol/beer = 1)

/datum/chemical_reaction/rotgut
	name = "Rotgut"
	id = /datum/reagent/consumable/ethanol/rotgut
	results = list(/datum/reagent/consumable/ethanol/rotgut = 5)
	required_reagents = list(/datum/reagent/abraxo_cleaner = 1, /datum/reagent/consumable/ethanol/whiskey = 2, /datum/reagent/oil = 1, /datum/reagent/consumable/ethanol = 1)

/datum/chemical_reaction/nukavictory
	name = "Cosmic Victory"
	id = /datum/reagent/consumable/ethanol/nukavictory
	results = list(/datum/reagent/consumable/ethanol/nukavictory = 2)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 1, /datum/reagent/consumable/ethanol/thirteenloko = 1)

/datum/chemical_reaction/nukaquartz
	name = "Cosmic Quartz"
	id = /datum/reagent/consumable/nukaquartz
	results = list(/datum/reagent/consumable/nukaquartz = 3)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 1, /datum/reagent/silicon = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/nukacherry
	name = "Cosmic Cherry"
	id = /datum/reagent/consumable/nukacherry
	results = list(/datum/reagent/consumable/nukacherry = 4)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 3, /datum/reagent/consumable/cherryjelly = 1)

/datum/chemical_reaction/nukalove
	name = "Cosmic Love"
	id = /datum/reagent/consumable/ethanol/nukalove
	results = list(/datum/reagent/consumable/ethanol/nukalove = 2)
	required_reagents = list(/datum/reagent/consumable/nukacherry = 1, /datum/reagent/consumable/nukaquartz = 1)

/datum/chemical_reaction/nukaquantum
	name = "Cosmic Quantum"
	id = /datum/reagent/consumable/ethanol/nukaquantum
	results = list(/datum/reagent/consumable/ethanol/nukaquantum = 3) ////results in only 3 instead of 5
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 2, /datum/reagent/radium = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/nukagrape
	name = "Cosmic Grape"
	id = "nukagrape"
	results = list(/datum/reagent/consumable/nukagrape = 2)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 1, /datum/reagent/consumable/grapejuice = 1)

/datum/chemical_reaction/nukadark
	name = "Cosmic Dark"
	id = "nukadark"
	results = list(/datum/reagent/consumable/ethanol/nukadark = 2)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 1, /datum/reagent/consumable/ethanol/rum = 1)

/datum/chemical_reaction/nukaorange
	name = "Cosmic Orange"
	id = "nukaorange"
	results = list(/datum/reagent/consumable/nukaorange = 2)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 1, /datum/reagent/consumable/orangejuice = 1)

/datum/chemical_reaction/nukastrawberry
	name = "Cosmic Strawberry"
	id = "nukastrawberry"
	results = list(/datum/reagent/consumable/nukastrawberry = 2)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 1, /datum/reagent/consumable/strawberryjuice = 1)

/datum/chemical_reaction/nukawild
	name = "Cosmic Wild"
	id = "nukawild"
	results = list(/datum/reagent/consumable/nukawild = 2)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 1, /datum/reagent/consumable/sunset = 1)

/datum/chemical_reaction/nukaray
	name = "Cosmic Ray"
	id = "nukaray"
	results = list(/datum/reagent/consumable/nukaray = 2)
	required_reagents = list(/datum/reagent/consumable/nukaorange = 1, /datum/reagent/consumable/ethanol/nukavictory = 1)

/datum/chemical_reaction/nukarush
	name = "Cosmic Rush"
	id = "nukarush"
	results = list(/datum/reagent/consumable/nukarush = 2)
	required_reagents = list(/datum/reagent/consumable/nukawild = 1, /datum/reagent/consumable/ethanol/nukavictory = 1)

/datum/chemical_reaction/nukaice
	name = "Iced Cosmic"
	id = "nukaice"
	results = list(/datum/reagent/consumable/nukaice = 2)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 1, /datum/reagent/consumable/ice = 1)

//nuka mixes

/datum/chemical_reaction/nukanew
	name = "NewCosmic Cola"
	id = "nukanew"
	results = list(/datum/reagent/consumable/nukanew = 3)
	required_reagents = list(/datum/reagent/consumable/nukaberry = 1, /datum/reagent/consumable/nukawild = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/nukaberry
	name = "Cosmic Berry"
	id = "nukaberry"
	results = list(/datum/reagent/consumable/nukaberry = 3)
	required_reagents = list(/datum/reagent/consumable/nukacherry = 1, /datum/reagent/consumable/nukagrape = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/nukabomb
	name = "Cosmic Bombdrop"
	id = "nukabomb"
	results = list(/datum/reagent/consumable/ethanol/nukabomb = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/nukadark = 1, /datum/reagent/consumable/ethanol/alcoholz = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/nukacide
	name = "Cosmiccide"
	id = "nukacide"
	results = list(/datum/reagent/consumable/ethanol/nukacide = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/nukabomb = 1, /datum/reagent/consumable/ethanol/nukaquantum = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/nukacooler
	name = "Cosmic Cooler"
	id = "nukacooler"
	results = list(/datum/reagent/consumable/nukacooler = 3)
	required_reagents = list(/datum/reagent/consumable/nukaice = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/nukafancy
	name = "Cosmic Fancy"
	id = "nukafancy"
	results = list(/datum/reagent/consumable/ethanol/nukafancy = 3)
	required_reagents = list(/datum/reagent/consumable/nukawild = 1, /datum/reagent/consumable/nukacherry = 1)

/datum/chemical_reaction/nukafree
	name = "Diet Cosmic"
	id = "nukafree"
	results = list(/datum/reagent/consumable/nukafree = 3)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 1, /datum/reagent/consumable/sodiumchloride = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/nukafrutti
	name = "Cosmic Frutti"
	id = "nukafrutti"
	results = list(/datum/reagent/consumable/nukafrutti = 3)
	required_reagents = list(/datum/reagent/consumable/nukaberry = 1, /datum/reagent/consumable/nukaorange = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/nukapunch
	name = "Cosmic Punch"
	id = "nukapunch"
	results = list(/datum/reagent/consumable/ethanol/nukapunch = 3)
	required_reagents = list(/datum/reagent/consumable/nukaberry = 5, /datum/reagent/consumable/nukaquartz = 5, /datum/reagent/consumable/orangejuice = 5)

/datum/chemical_reaction/nukasunrise
	name = "Cosmic Sunrise"
	id = "nukasunrise"
	results = list(/datum/reagent/consumable/ethanol/nukasunrise = 5)
	required_reagents = list(/datum/reagent/consumable/nukawild = 2, /datum/reagent/consumable/orangejuice = 2, /datum/reagent/consumable/grenadine = 1)

/datum/chemical_reaction/nukaxtreme
	name = "Cosmic X-Treme"
	id = "nukaxtreme"
	results = list(/datum/reagent/consumable/ethanol/nukaxtreme = 1)
	required_reagents = list(/datum/reagent/consumable/nuka_cola = 5, /datum/reagent/consumable/ethanol/nukaquantum = 5, /datum/reagent/consumable/nukagrape = 5)


/// Vim! from Fallout 4: Far Harbor

/datum/chemical_reaction/vimcap
	name = "Vim Captains Blend"
	id = "vimcap"
	results = list(/datum/reagent/consumable/ethanol/vimcap = 5)
	required_reagents = list(/datum/reagent/consumable/vim = 10, /datum/reagent/gold = 10, /datum/reagent/consumable/ethanol/brocbrew = 10)

/datum/chemical_reaction/vimquartz
	name = "Vim Quartz"
	id = "vimquartz"
	results = list(/datum/reagent/consumable/vimquartz = 3)
	required_reagents = list(/datum/reagent/consumable/vim = 1, /datum/reagent/consumable/soymilk = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/vimrefresh
	name = "Vim Refresh"
	id = "vimrefresh"
	results = list(/datum/reagent/consumable/vimrefresh = 3)
	required_reagents = list(/datum/reagent/consumable/vim = 1, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/vimice
	name = "Vim Ice"
	id = "vimice"
	results = list(/datum/reagent/consumable/vimice = 3)
	required_reagents = list(/datum/reagent/consumable/vim = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/water = 1)



//fallout cocktails - not canon, from the mind o scar

/datum/chemical_reaction/atombomb
	name = "Atom Bomb"
	id = "atombomb"
	results = list(/datum/reagent/consumable/ethanol/atombomb = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/species_drink/sludge = 1, /datum/reagent/consumable/ethanol/b52 = 1)

/datum/chemical_reaction/henessey
	name = "Henessey"
	id = "henessey"
	results = list(/datum/reagent/consumable/ethanol/henessey = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/hooch = 1, /datum/reagent/consumable/ethanol/bbrew = 1)

/datum/chemical_reaction/vaulttech
	name = "Vault-Tech Special"
	id = "vaulttech"
	results = list(/datum/reagent/consumable/ethanol/vaulttech = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/kamikaze = 1, /datum/reagent/consumable/bawls = 1)

/datum/chemical_reaction/vaultboy
	name = "Vault Boy"
	id = "vaultboy"
	results = list(/datum/reagent/consumable/ethanol/vaultboy = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/vaulttech = 1, /datum/reagent/consumable/ethanol/beer = 1)

/datum/chemical_reaction/vaultgirl
	name = "Vault Girl"
	id = "vaultgirl"
	results = list(/datum/reagent/consumable/ethanol/vaultgirl = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/vaulttech = 1, /datum/reagent/consumable/ethanol/between_the_sheets = 1)

/datum/chemical_reaction/femboy
	name = "Femboy Juice"
	id = "femboi"
	results = list(/datum/reagent/consumable/ethanol/vaultgirl/femboy = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/vaultgirl = 1, /datum/reagent/consumable/bawls = 1)

/datum/chemical_reaction/fernet_cola
	name = "Fernet Cola"
	id = "fernet_cola"
	results = list(/datum/reagent/consumable/ethanol/fernet_cola = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/fernet = 1, /datum/reagent/consumable/nuka_cola = 1)

/datum/chemical_reaction/moonshinez
	name = "Moonshine-Z"
	id = "moonshinez"
	results = list(/datum/reagent/consumable/ethanol/moonshinez = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/alcoholz = 1, /datum/reagent/consumable/ethanol/moonshine = 1)

/datum/chemical_reaction/corporate
	name = "Corporate"
	id = "corporate"
	results = list(/datum/reagent/consumable/ethanol/corporate = 4)
	required_reagents = list(/datum/reagent/consumable/vim = 1, /datum/reagent/consumable/nukawild = 1, /datum/reagent/consumable/bawls = 1)

/datum/chemical_reaction/ranchwhiskey
	name = "Ranchers Whiskey"
	id = "ranchwhiskey"
	results = list(/datum/reagent/consumable/ethanol/ranchwhiskey = 2)
	required_reagents = list(/datum/reagent/consumable/tea/feratea = 1, /datum/reagent/consumable/ethanol/whiskey = 1)

//finally, some fallout floats and shakes, 60s style!

/datum/chemical_reaction/bawlsshake
	name = "Bawls Shake"
	id = "bawlsshake"
	results = list(/datum/reagent/consumable/bawlsshake = 3)
	required_reagents = list(/datum/reagent/consumable/bawls = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/jakeshake
	name = "Jake Shake"
	id = "jakeshake"
	results = list(/datum/reagent/consumable/jakeshake = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/jakejuice = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/sweetwaterfloat
	name = "Sweetwater Float"
	id = "sweetwaterfloat"
	results = list(/datum/reagent/consumable/sweetwaterfloat = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/sweetwater = 1, /datum/reagent/water = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/sunsetter
	name = "Sunsetter"
	id = "sunsetter"
	results = list(/datum/reagent/consumable/sunsetter = 2)
	required_reagents = list(/datum/reagent/consumable/sunset = 1, /datum/reagent/consumable/ethanol/tequila_sunrise = 1)

/// Ghoul related below

/datum/chemical_reaction/sludge
	name = "Resilient Sludge"
	id = "sludge"
	results = list(/datum/reagent/consumable/ethanol/species_drink/sludge = 3)
	required_reagents = list(/datum/reagent/radium = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/strongsludge
	name = "Strong Sludge"
	id = "strongsludge"
	results = list(/datum/reagent/consumable/ethanol/species_drink/strongsludge = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/species_drink/sludge = 3, /datum/reagent/uranium = 1)

/// Fallout 2

/datum/chemical_reaction/alcoholz
	name = "Alcohol-Z"
	id = "alcoholz"
	results = list(/datum/reagent/consumable/ethanol/alcoholz = 1)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 1, /datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/ethanol/rum = 1)



/// Fallout 76 related

/datum/chemical_reaction/sweetwater
	name = "Sweet Water"
	id = "sweetwater"
	results = list(/datum/reagent/consumable/ethanol/sweetwater = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/wastemead = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/oldpossum
	name = "Old Possum"
	id = "oldpossum"
	results = list(/datum/reagent/consumable/ethanol/oldpossum = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer = 1, /datum/reagent/consumable/flour = 1, /datum/reagent/consumable/mutjuice = 1)

/*/datum/chemical_reaction/bbock
	name = "Ballistic Bock"
	id = "bbock"
	results = list(/datum/reagent/consumable/ethanol/bbock = 3)
	required_reagents = list(/datum/reagent/blackpowder = 1, /datum/reagent/radium = 1, /datum/reagent/water = 1)*/ //Made with TDM in mind. Just no. - Risingstarslash

/datum/chemical_reaction/hardlemonade
	name = "Hard Lemonade"
	id = "hardlemonade"
	results = list(/datum/reagent/consumable/ethanol/hardlemonade = 3)
	required_reagents = list(/datum/reagent/consumable/lemonade = 1, /datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/radium  = 1)

/datum/chemical_reaction/firecracker
	name = "Firecracker"
	id = "firecracker"
	results = list(/datum/reagent/consumable/ethanol/firecracker = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/salgam = 1, /datum/reagent/consumable/yuccajuice = 1)

/// Fallout Tactics

/datum/chemical_reaction/xbeer
	name = "XXXXXXBeer"
	id = "xbeer"
	results = list(/datum/reagent/consumable/ethanol/xbeer = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/beer = 1, /datum/reagent/consumable/ethanol = 1)

/datum/chemical_reaction/olflakey
	name = "Ol' Flakey"
	id = "olflakey"
	results = list(/datum/reagent/consumable/ethanol/olflakey = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 1, /datum/reagent/consumable/lemonjuice = 1, /datum/reagent/acetone = 1)

/// Fallout NV

/datum/chemical_reaction/jakejuice
	name = "Jake Juice"
	id = "jakejuice"
	results = list(/datum/reagent/consumable/ethanol/jakejuice = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 1, /datum/reagent/consumable/ethanol/beer = 1, /datum/reagent/radium  = 1)

/datum/chemical_reaction/wastetequila
	name = "Wasteland Tequila"
	id = "wastetequila"
	results = list(/datum/reagent/consumable/ethanol/wastetequila = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/tequila = 1, /datum/reagent/consumable/mutjuice = 1)

/datum/chemical_reaction/bbrew
	name = "Battle Brew"
	id = "bbrew"
	results = list(/datum/reagent/consumable/ethanol/bbrew = 2)
	required_reagents = list(/datum/reagent/medicine/medx = 1, /datum/reagent/consumable/ethanol/vodka = 1)

/datum/chemical_reaction/bbrew2
	name = "Blackwater Brew"
	id = "bbrew2"
	results = list(/datum/reagent/consumable/ethanol/bbrew2 = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/medicine/charcoal = 1, /datum/reagent/consumable/ethanol/beer = 1)

/// Fallout 4

/datum/chemical_reaction/dwastelander
	name = "Dirty Wastelander"
	id = "dwastelander"
	results = list(/datum/reagent/consumable/ethanol/dwastelander = 5)
	required_reagents = list(/datum/reagent/consumable/mutjuice = 1,/datum/reagent/consumable/ethanol/whiskey = 2, /datum/reagent/water = 2)

/datum/chemical_reaction/firebelly
	name = "Fire Belly"
	id = "firebelly"
	results = list(/datum/reagent/consumable/ethanol/firebelly = 1)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/sodiumchloride = 1, /datum/reagent/consumable/soysauce = 1)

/// Tribal related things below

/datum/chemical_reaction/yuccashake
	name = "Yucca Shake"
	id = "yuccashake"
	results = list(/datum/reagent/consumable/yuccashake = 3)
	required_reagents = list(/datum/reagent/consumable/yuccajuice = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/broctea
	name = "Broc Tea"
	id = "broctea"
	results = list(/datum/reagent/consumable/tea/broctea = 3)
	required_reagents = list(/datum/reagent/consumable/brocjuice = 1, /datum/reagent/water = 2)
	required_temp = 315

/datum/chemical_reaction/xandertea
	name = "Xander Tea"
	id = "xandertea"
	results = list(/datum/reagent/consumable/tea/xandertea = 3)
	required_reagents = list(/datum/reagent/consumable/xanderjuice = 1, /datum/reagent/water = 2)
	required_temp = 315

/datum/chemical_reaction/agavetea
	name = "Agave Tea"
	id = "agavetea"
	results = list(/datum/reagent/consumable/tea/agavetea = 3)
	required_reagents = list(/datum/reagent/consumable/agavejuice = 1, /datum/reagent/water = 2)
	required_temp = 315

/datum/chemical_reaction/feratea
	name = "Barrel Tea"
	id = "feratea"
	results = list(/datum/reagent/consumable/tea/feratea = 3)
	required_reagents = list(/datum/reagent/consumable/ferajuice = 1, /datum/reagent/water = 2)
	required_temp = 315

/datum/chemical_reaction/daturatea
	name = "Datura Tea"
	id = "daturatea"
	results = list(/datum/reagent/consumable/ethanol/daturatea = 3)
	required_reagents = list(/datum/reagent/consumable/daturajuice = 1, /datum/reagent/water = 2)
	required_temp = 315

/datum/chemical_reaction/coyotetea
	name = "Coyote Tea"
	id = "coyotetea"
	results = list(/datum/reagent/consumable/tea/coyotetea = 3)
	required_reagents = list(/datum/reagent/consumable/coyotejuice = 1, /datum/reagent/water = 2)
	required_temp = 315

/datum/chemical_reaction/fever_blossom_tea
	name = "Passion Tea"
	id = "fevertea"
	results = list(/datum/reagent/consumable/tea/fever_blossom_tea = 3)
	required_reagents = list(/datum/reagent/consumable/fever_blossom_juice = 1, /datum/reagent/water = 2)
	required_temp = 315
