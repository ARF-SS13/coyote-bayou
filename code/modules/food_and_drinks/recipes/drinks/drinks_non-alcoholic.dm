/datum/chemical_reaction/icetea
	name = "Iced Tea"
	id = /datum/reagent/consumable/icetea
	results = list(/datum/reagent/consumable/icetea = 4)
	required_reagents = list(/datum/reagent/consumable/ice = 1, /datum/reagent/consumable/tea = 3)

/datum/chemical_reaction/pinktea
	name = "Strawberry Tea"
	id = /datum/reagent/consumable/pinktea
	results = list(/datum/reagent/consumable/pinktea = 5)
	required_reagents = list(/datum/reagent/consumable/strawberryjuice = 1, /datum/reagent/consumable/tea/arnold_palmer = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/arnold_palmer
	name = "Arnold Palmer"
	id = /datum/reagent/consumable/tea/arnold_palmer
	results = list(/datum/reagent/consumable/tea/arnold_palmer = 2)
	required_reagents = list(/datum/reagent/consumable/tea = 1, /datum/reagent/consumable/lemonade = 1, /datum/reagent/consumable/sugar = 1)
	mix_message = "The smells of fresh green grass and sand traps waft through the air as the mixture turns a friendly yellow-orange."

/datum/chemical_reaction/mush
	name = "Mush Tea"
	id = /datum/reagent/consumable/tea/mush
	results = list(/datum/reagent/consumable/tea/mush = 3)
	required_reagents = list(/datum/reagent/drug/mushroomhallucinogen = 3, /datum/reagent/consumable/tea = 3)

/datum/chemical_reaction/foresttea1
	name = "Forest Tea"
	id = /datum/reagent/consumable/tea/forest
	results = list(/datum/reagent/consumable/tea/forest = 3)
	required_reagents = list(/datum/reagent/consumable/buzz_fuzz= 3, /datum/reagent/consumable/tea = 3)

/datum/chemical_reaction/foresttea2
	name = "Forest Tea"
	id = /datum/reagent/consumable/tea/forest
	results = list(/datum/reagent/consumable/tea/forest = 3)
	required_reagents = list(/datum/reagent/consumable/honey = 1, /datum/reagent/consumable/tea = 3)

/datum/chemical_reaction/redtea1
	name = "Red Tea"
	id = /datum/reagent/consumable/tea/red
	results = list(/datum/reagent/consumable/tea/red = 3)
	required_reagents = list(/datum/reagent/colorful_reagent/crayonpowder/red = 1, /datum/reagent/consumable/tea = 3)

/datum/chemical_reaction/greentea1
	name = "Green Tea"
	id = /datum/reagent/consumable/tea/green
	results = list(/datum/reagent/consumable/tea/green = 3)
	required_reagents = list(/datum/reagent/colorful_reagent/crayonpowder/green = 1, /datum/reagent/consumable/tea = 3)

/datum/chemical_reaction/redtea2
	name = "Red Tea"
	id = /datum/reagent/consumable/tea/red
	results = list(/datum/reagent/consumable/tea/red = 3)
	required_reagents = list(/datum/reagent/toxin/teapowder/red = 1, /datum/reagent/water = 3)

/datum/chemical_reaction/greentea2
	name = "Green Tea"
	id = /datum/reagent/consumable/tea/green
	results = list(/datum/reagent/consumable/tea/green = 3)
	required_reagents = list(/datum/reagent/toxin/teapowder/green = 1, /datum/reagent/water = 3)

/datum/chemical_reaction/cream_soda
	name = "Cream Soda"
	id = /datum/reagent/consumable/cream_soda
	results = list(/datum/reagent/consumable/cream_soda = 4)
	required_reagents = list(/datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/sodawater = 2, /datum/reagent/consumable/vanilla = 1)

/datum/chemical_reaction/chocolatepudding
	name = "Chocolate Pudding"
	id = /datum/reagent/consumable/chocolatepudding
	results = list(/datum/reagent/consumable/chocolatepudding = 20)
	required_reagents = list(/datum/reagent/consumable/cream = 5, /datum/reagent/consumable/coco = 5, /datum/reagent/consumable/eggyolk = 2)

/datum/chemical_reaction/vanillapudding
	name = "Vanilla Pudding"
	id = /datum/reagent/consumable/vanillapudding
	results = list(/datum/reagent/consumable/vanillapudding = 20)
	required_reagents = list(/datum/reagent/consumable/vanilla = 5, /datum/reagent/consumable/cream = 5, /datum/reagent/consumable/eggyolk = 2)

/datum/chemical_reaction/drunkenblumpkin
	name = "Drunken Blumpkin"
	id = /datum/reagent/consumable/ethanol/drunkenblumpkin
	results = list(/datum/reagent/consumable/ethanol/drunkenblumpkin = 4)
	required_reagents = list(/datum/reagent/consumable/blumpkinjuice = 1, /datum/reagent/consumable/ethanol/irish_cream = 2, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/pumpkin_latte
	name = "Pumpkin space latte"
	id = /datum/reagent/consumable/pumpkin_latte
	results = list(/datum/reagent/consumable/pumpkin_latte = 15)
	required_reagents = list(/datum/reagent/consumable/pumpkinjuice = 5, /datum/reagent/consumable/coffee = 5, /datum/reagent/consumable/cream = 5)

/datum/chemical_reaction/gibbfloats
	name = "Gibb Floats"
	id = /datum/reagent/consumable/gibbfloats
	results = list(/datum/reagent/consumable/gibbfloats = 15)
	required_reagents = list(/datum/reagent/consumable/dr_gibb = 5, /datum/reagent/consumable/ice = 5, /datum/reagent/consumable/cream = 5)

/datum/chemical_reaction/triple_citrus
	name = "triple_citrus"
	id = /datum/reagent/consumable/triple_citrus
	results = list(/datum/reagent/consumable/triple_citrus = 5)
	required_reagents = list(/datum/reagent/consumable/lemonjuice = 1, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/orangejuice = 1)

/datum/chemical_reaction/grape_soda
	name = "grape soda"
	id = /datum/reagent/consumable/grape_soda
	results = list(/datum/reagent/consumable/grape_soda = 2)
	required_reagents = list(/datum/reagent/consumable/grapejuice = 1, /datum/reagent/consumable/sodawater = 1)

/datum/chemical_reaction/soy_latte
	name = "Soy Latte"
	id = /datum/reagent/consumable/soy_latte
	results = list(/datum/reagent/consumable/soy_latte = 2)
	required_reagents = list(/datum/reagent/consumable/coffee = 1, /datum/reagent/consumable/soymilk = 1)

/datum/chemical_reaction/cafe_latte
	name = "Cafe Latte"
	id = /datum/reagent/consumable/cafe_latte
	results = list(/datum/reagent/consumable/cafe_latte = 2)
	required_reagents = list(/datum/reagent/consumable/coffee = 1, /datum/reagent/consumable/milk = 1)

/datum/chemical_reaction/doctor_delight
	name = "The Doctor's Delight"
	id = /datum/reagent/consumable/doctor_delight
	results = list(/datum/reagent/consumable/doctor_delight = 5)
	required_reagents = list(/datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/tomatojuice = 1, /datum/reagent/consumable/orangejuice = 1, /datum/reagent/consumable/cream = 1, /datum/reagent/medicine/cryoxadone = 1)

/datum/chemical_reaction/icecoffee
	name = "Iced Coffee"
	id = /datum/reagent/consumable/icecoffee
	results = list(/datum/reagent/consumable/icecoffee = 4)
	required_reagents = list(/datum/reagent/consumable/ice = 1, /datum/reagent/consumable/coffee = 3)

/datum/chemical_reaction/nuka_cola
	name = "Cosmic Cola"
	id = /datum/reagent/consumable/nuka_cola
	results = list(/datum/reagent/consumable/nuka_cola = 6)
	required_reagents = list(/datum/reagent/uranium = 1, /datum/reagent/consumable/space_cola = 6)

/datum/chemical_reaction/lemonade
	name = "Lemonade"
	id = /datum/reagent/consumable/lemonade
	results = list(/datum/reagent/consumable/lemonade = 5)
	required_reagents = list(/datum/reagent/consumable/lemonjuice = 2, /datum/reagent/water = 2, /datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/ice = 1)
	mix_message = "You're suddenly reminded of home."

/datum/chemical_reaction/chocolate_milk
	name = "chocolate milk"
	id = /datum/reagent/consumable/milk/chocolate_milk
	results = list(/datum/reagent/consumable/milk/chocolate_milk = 2)
	required_reagents = list(/datum/reagent/consumable/milk = 1, /datum/reagent/consumable/coco = 1, /datum/reagent/consumable/cream = 1)
	mix_message = "The color changes as the mixture blends smoothly."

/datum/chemical_reaction/pwrgame
	name = "Power Gamer"
	id = /datum/reagent/consumable/pwr_game
	results = list(/datum/reagent/consumable/pwr_game = 5)
	required_reagents = list(/datum/reagent/consumable/sodawater = 1, /datum/reagent/colorful_reagent/crayonpowder/black = 1, /datum/reagent/consumable/sodiumchloride = 1)

/datum/chemical_reaction/pinkmilk
	name = "Strawberry Milk"
	id = /datum/reagent/consumable/pinkmilk
	results = list(/datum/reagent/consumable/pinkmilk = 2)
	required_reagents = list(/datum/reagent/consumable/strawberryjuice = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/cucumberlemonade
	name = "Cucumber Lemonade"
	id = /datum/reagent/consumable/cucumberlemonade
	results = list(/datum/reagent/consumable/cucumberlemonade = 5)
	required_reagents = list(/datum/reagent/consumable/lemon_lime = 3, /datum/reagent/consumable/cucumberjuice = 2, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/drink/roy_rogers
	name = "Roy Rogers"
	id = /datum/reagent/consumable/roy_rogers
	results = list(/datum/reagent/consumable/roy_rogers = 3)
	required_reagents = list(/datum/reagent/consumable/space_cola = 2, /datum/reagent/consumable/grenadine = 1)

/datum/chemical_reaction/drink/shirley_temple
	name = "Shirley Temple"
	id = /datum/reagent/consumable/shirley_temple
	results = list(/datum/reagent/consumable/shirley_temple = 3)
	required_reagents = list(/datum/reagent/consumable/sol_dry = 2, /datum/reagent/consumable/grenadine = 1)

/datum/chemical_reaction/drink/agua_fresca
	name = "Aqua Fresca"
	id = /datum/reagent/consumable/agua_fresca
	results = list(/datum/reagent/consumable/agua_fresca = 3)
	required_reagents = list(/datum/reagent/consumable/watermelonjuice = 4, /datum/reagent/consumable/ice = 1, /datum/reagent/water = 2, /datum/reagent/consumable/limejuice = 2, /datum/reagent/consumable/menthol = 1)

/datum/chemical_reaction/drink/cinderella
	name = "Cinderella"
	id = /datum/reagent/consumable/cinderella
	results = list(/datum/reagent/consumable/cinderella = 50)
	required_reagents = list(/datum/reagent/consumable/pineapplejuice = 10, /datum/reagent/consumable/orangejuice = 10, /datum/reagent/consumable/lemonjuice = 5, /datum/reagent/consumable/ice = 5, /datum/reagent/consumable/sol_dry = 20)

/datum/chemical_reaction/drink/italian_coco
	name = "Italian Hot Chocolate"
	id = /datum/reagent/consumable/italian_coco
	results = list(/datum/reagent/consumable/italian_coco = 10)
	required_reagents = list(/datum/reagent/consumable/hot_coco  = 5, /datum/reagent/consumable/corn_starch = 1, /datum/reagent/consumable/whipped_cream = 4)

/// Smoothies

/datum/chemical_reaction/drink/strawberry_banana
	name = "Strawberry Banana Smoothie"
	id = /datum/reagent/consumable/strawberry_banana
	results = list(/datum/reagent/consumable/strawberry_banana = 3)
	required_reagents = list(/datum/reagent/consumable/strawberryjuice = 1, /datum/reagent/consumable/banana = 1, /datum/reagent/consumable/milk = 1)

/datum/chemical_reaction/drink/berry_blast
	name = "Berry Blast Smoothie"
	id = /datum/reagent/consumable/berry_blast
	results = list(/datum/reagent/consumable/berry_blast = 3)
	required_reagents = list(/datum/reagent/consumable/berryjuice = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/funky_monkey
	name = "Funky Monkey Smoothie"
	id = /datum/reagent/consumable/funky_monkey
	results = list(/datum/reagent/consumable/funky_monkey = 3)
	required_reagents = list(/datum/reagent/consumable/coco = 1, /datum/reagent/consumable/banana = 1, /datum/reagent/consumable/milk = 1)

/datum/chemical_reaction/drink/green_giant
	name = "Green Giant Smoothie"
	id = /datum/reagent/consumable/green_giant
	results = list(/datum/reagent/consumable/green_giant = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/creme_de_menthe = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/consumable/limejuice = 1)

/datum/chemical_reaction/drink/melon_baller
	name = "Melon Baller Smoothie"
	id = /datum/reagent/consumable/melon_baller
	results = list(/datum/reagent/consumable/melon_baller = 3)
	required_reagents = list(/datum/reagent/consumable/watermelonjuice = 1, /datum/reagent/consumable/ethanol/creme_de_menthe = 1, /datum/reagent/consumable/milk = 1)

/datum/chemical_reaction/drink/vanilla_dream
	name = "Vanilla Dream Smoothie"
	id = /datum/reagent/consumable/vanilla_dream
	results = list(/datum/reagent/consumable/vanilla_dream = 3)
	required_reagents = list(/datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/milk = 1, /datum/reagent/consumable/cream = 1)

/// Milkshakes/Shakes

/datum/chemical_reaction/cherryshake
	name = "Cherry Shake"
	id = /datum/reagent/consumable/cherryshake
	results = list(/datum/reagent/consumable/cherryshake = 3)
	required_reagents = list(/datum/reagent/consumable/cherryjelly = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/bluecherryshake
	name = "Blue Cherry Shake"
	id = /datum/reagent/consumable/bluecherryshake
	results = list(/datum/reagent/consumable/bluecherryshake = 3)
	required_reagents = list(/datum/reagent/consumable/bluecherryjelly = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/vanillashake
	name = "Vanilla Shake"
	id = /datum/reagent/consumable/vanillashake
	results = list(/datum/reagent/consumable/vanillashake = 3)
	required_reagents = list(/datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/caramelshake
	name = "Caramel Shake"
	id = /datum/reagent/consumable/caramelshake
	results = list(/datum/reagent/consumable/caramelshake = 3)
	required_reagents = list(/datum/reagent/consumable/caramel = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/choccyshake
	name = "Chocolate Shake"
	id = /datum/reagent/consumable/choccyshake
	results = list(/datum/reagent/consumable/choccyshake = 3)
	required_reagents = list(/datum/reagent/consumable/coco = 1, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/cream = 1)
