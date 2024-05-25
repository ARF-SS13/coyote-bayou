/*********************MANUALS (BOOKS)***********************/

//Oh god what the fuck I am not good at computer
/obj/item/book/manual
	icon = 'icons/obj/library.dmi'
	due_date = 0 // Game time in 1/10th seconds
	w_class = WEIGHT_CLASS_TINY
	unique = TRUE   // FALSE - Normal book, TRUE - Should not be treated as normal book, unable to be copied, unable to be modified

/obj/item/book/manual/hydroponics_pod_people
	name = "The Human Harvest - From seed to market"
	icon_state ="bookHydroponicsPodPeople"
	author = "Farmer John" // Whoever wrote the paper or book, can be changed by pen or PC. It is not automatically assigned.
	title = "The Human Harvest - From seed to market"
	//book contents below
	dat = {"<html>
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<h3>Growing Humans</h3>

				Why would you want to grow humans? Well I'm expecting most readers to be in the slave trade, but a few might actually
				want to revive fallen comrades. Growing pod people is easy, but prone to disaster.
				<p>
				<ol>
				<li>Find a dead person who is in need of cloning. </li>
				<li>Take a blood sample with a syringe. </li>
				<li>Inject a seed pack with the blood sample. </li>
				<li>Plant the seeds. </li>
				<li>Tend to the plants water and nutrition levels until it is time to harvest the cloned human.</li>
				</ol>
				<p>
				It really is that easy! Good luck!

				</body>
				</html>
				"}

/obj/item/book/manual/ripley_build_and_repair
	name = "APLU \"Ripley\" Construction and Operation Manual"
	icon_state ="book"
	author = "Weyland-Yutani Corp"
	title = "APLU \"Ripley\" Construction and Operation Manual"
	dat = {"<html>
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<center>
				<b style='font-size: 12px;'>Weyland-Yutani - Building Better Worlds</b>
				<h1>Autonomous Power Loader Unit \"Ripley\"</h1>
				</center>
				<h2>Specifications:</h2>
				<ul>
				<li><b>Class:</b> Autonomous Power Loader</li>
				<li><b>Scope:</b> Logistics and Construction</li>
				<li><b>Weight:</b> 820kg (without operator and with empty cargo compartment)</li>
				<li><b>Height:</b> 2.5m</li>
				<li><b>Width:</b> 1.8m</li>
				<li><b>Top speed:</b> 5km/hour</li>
				<li><b>Operation in vacuum/hostile environment:</b> Possible</b>
				<li><b>Airtank Volume:</b> 500liters</li>
				<li><b>Devices:</b>
					<ul>
					<li>Hydraulic Clamp</li>
					<li>High-speed Drill</li>
					</ul>
				</li>
				<li><b>Propulsion Device:</b> Powercell-powered electro-hydraulic system.</li>
				<li><b>Powercell capacity:</b> Varies.</li>
				</ul>

				<h2>Construction:</h2>
				<ol>
				<li>Connect all exosuit parts to the chassis frame</li>
				<li>Connect all hydraulic fittings and tighten them up with a wrench</li>
				<li>Adjust the servohydraulics with a screwdriver</li>
				<li>Wire the chassis. (Cable is not included.)</li>
				<li>Use the wirecutters to remove the excess cable if needed.</li>
				<li>Install the central control module (Not included. Use supplied datadisk to create one).</li>
				<li>Secure the mainboard with a screwdriver.</li>
				<li>Install the peripherals control module (Not included. Use supplied datadisk to create one).</li>
				<li>Secure the peripherals control module with a screwdriver</li>
				<li>Install the internal armor plating (Not included due to US Government regulations. Can be made using 5 metal sheets.)</li>
				<li>Secure the internal armor plating with a wrench</li>
				<li>Weld the internal armor plating to the chassis</li>
				<li>Install the external reinforced armor plating (Not included due to US Government regulations. Can be made using 5 reinforced metal sheets.)</li>
				<li>Secure the external reinforced armor plating with a wrench</li>
				<li>Weld the external reinforced armor plating to the chassis</li>
				<li></li>
				<li>Additional Information:</li>
				<li>The firefighting variation is made in a similar fashion.</li>
				<li>A firesuit must be connected to the Firefighter chassis for heat shielding.</li>
				<li>Internal armor is plasteel for additional strength.</li>
				<li>External armor must be installed in 2 parts, totaling 10 sheets.</li>
				<li>Completed mech is more resiliant against fire, and is a bit more durable overall</li>
				<li>Nanotrasen is determined to the safety of its <s>investments</s> employees.</li>
				</ol>
				</body>
				</html>

				<h2>Operation</h2>
				Please consult the US Government compendium "Robotics for Dummies".
			"}

/obj/item/book/manual/chef_recipes
	name = "Chef Recipes"
	icon_state = "cooked_book"
	author = "Lord Frenrir Cageth"
	title = "Chef Recipes"
	dat = {"<html>
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h1>Food for Dummies</h1>
				Here is a guide on basic food recipes and also how to not poison your customers accidentally.


				<h2>Basic ingredients preparation:</h2>

				<b>Dough:</b> 10u water + 15u flour for simple dough.<br>
				6u egg yolk + 12 egg white + 15u flour + 5u sugar for cake batter.<br>
				Doughs can be transformed by using a knife and rolling pin.<br>
				All doughs can be microwaved.<br>
				<b>Bowl:</b> Add water to it for soup preparation.<br>
				<b>Meat:</b> Microwave it, process it, slice it into microwavable cutlets with your knife, or use it raw.<br>
				<b>Cheese:</b> Add 5u universal enzyme (catalyst) to milk and soy milk to prepare cheese (sliceable) and tofu.<br>
				<b>Rice:</b> Mix 10u rice with 10u water in a bowl then microwave it.

				<h2>Custom food:</h2>
				Add ingredients to a base item to prepare a custom meal.<br>
				The bases are:<br>
				- bun (burger)<br>
				- breadslices(sandwich)<br>
				- plain bread<br>
				- plain pie<br>
				- vanilla cake<br>
				- empty bowl (salad)<br>
				- bowl with 10u water (soup)<br>
				- boiled spaghetti<br>
				- pizza bread<br>
				- metal rod (kebab)

				<h2>Table Craft:</h2>
				Put ingredients on table, then click and drag the table onto yourself to see what recipes you can prepare.

				<h2>Microwave:</h2>
				Use it to cook or boil food ingredients (meats, doughs, egg, spaghetti, donkpocket, etc...).
				It can cook multiple items at once.

				<h2>Processor:</h2>
				Use it to process certain ingredients (meat into meatball, doughslice into spaghetti, potato into fries,etc...)

				<h2>Gibber:</h2>
				Stuff an animal in it to grind it into meat.

				<h2>Meat spike:</h2>
				Stick an animal on it then begin collecting its meat.


				<h2>Example recipes:</h2>
				<b>Vanilla Cake</b>: Microwave cake batter.<br>
				<b>Burger:</b> 1 bun + 1 meat steak<br>
				<b>Bread:</b> Microwave dough.<br>
				<b>Waffles:</b> 2 pastry base<br>
				<b>Popcorn:</b> Microwave corn.<br>
				<b>Meat Steak:</b> Microwave meat.<br>
				<b>Meat Pie:</b> 1 plain pie + 1u black pepper + 1u salt + 2 meat cutlets<br>
				<b>Boiled Spagetti:</b> Microwave spaghetti.<br>
				<b>Donuts:</b> 1u sugar + 1 pastry base<br>
				<b>Fries:</b> Process potato.

				<h2>Sharing your food:</h2>
				You can put your meals on your kitchen counter or load them in the snack vending machines.
				</body>
				</html>
			"}

/obj/item/book/manual/nuka_recipes
	name = "Cosmic-Cola Recipes"
	icon_state = "barbook"
	author = "Lord Frenrir Cageth"
	title = "Nuka-Cola Recipes"
	dat = {"<html>
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>

				<h1>Cosmic for Dummies</h1>
				Here is a list of all of the secret recipes to America's favorite soft drink! (Other, inferior drink recipes included.)


				<h2>Cosmic Recipes:</h2>

				<b>Cosmic Float:</b> Cosmic Cola 5u + Sugar 5u + Cream 5u.<br>
				<b>Cosmic Shine:</b> Cosmic Cola 5u + Beer 5u.<br>
				<b>Cosmic Victory:</b> Cosmic Cola 5u + Thirteen Loko 5u.<br>
				<b>Cosmic Quartz:</b> Cosmic Cola 5u + Sugar 5u + Silicon 5u.<br>
				<b>Cosmic Fancy:</b> Cosmic Wild 1u + Cosmic Cherry 1u<br>
				<b>Cosmic Cherry:</b> Cosmic Cola 3u + Cherry Jelly 1u<br>
				<b>Cosmic Love:</b> Cosmic Cherry 5u + Cosmic Quartz 5u<br>
				<b>Cosmic Quantum:</b> Cosmic Cola 2u + Radium 1u + Sugar 1u<br>
				<b>Cosmic Grape:</b> Cosmic Cola 5u + Grape Juice 5u<br>
				<b>Cosmic Dark:</b> Cosmic Cola 5u + Rum 5u<br>
				<b>Cosmic Orange:</b> Cosmic Cola 5u + Orange Juice 5u<br>
				<b>Cosmic Strawberry:</b> Cosmic Cola 5u + Strawberry Juice 5u<br>
				<b>Cosmic Wild:</b> Cosmic Cola 5u + Sunset Sasparilla 5u<br>
				<b>Cosmic Ray:</b> Cosmic Orange 1u + Cosmic Victory 1u<br>
				<b>Cosmic Rush:</b> Cosmic Wild 1u + Cosmic Victory 1u<br>
				<b>Cosmic with ice:</b> Cosmic Cola 5u + some ice<br>
				<b>Cewsmic Cola:</b> Cosmic Berry 5u + Cosmic Wild 5u + Ice 5u<br>
				<b>Cosmic Berry:</b> Cosmic Grape 5u + Cosmic Cherry 5u + Ice 5u<br>
				<b>Cosmic Bombdrop:</b> Cosmic Dark 5u + Alcohol Z 5u + Sugar 5u<br>
				<b>Industrial Strength Drain Cleaner (NOT FIT FOR HUMAN CONSUMPTION):</b> Cosmic Bombdrop 5u + Cosmic Quantum 5u + Ice 5u<br>
				<b>Cosmic Cooler:</b> Cosmic Iced 5u + more ice + some water<br>
				<b>Diet Cosmic:</b> Cosmic Cola 5u + salt + water<br>
				<b>Cosmic Frutti:</b> Cosmic Berry 5u + Cosmic Orange 5u + Ice 5u<br>
				<b>Cosmic Punch:</b> Cosmic Berry 5u + Cosmic Quartz 5u + Orange Juice 5u<br>
				<b>Cosmic X-TREME:</b> Cosmic Cola 5u + Cosmic Quantum 5u + Cosmic Grape 5u<br>


				<h2>Vim Drinks (Midwestern favorite!):</h2>
				<b>Vim Captain's Blend:</b> Vim 10u + Fermented Broc flower (broc brew) 10u + Gold 10u<br>
				<b>Vim Quartz:</b> Cosmic Cola 5u + Soy Milk 5u + Sugar 5u<br>
				<b>Vim Refresh:</b> Vim 5u + Lime Juice 5u + Ice 5u<br>
				<b>Vim Ice:</b> Cosmic Cola 5u + Ice 5u + Water 5u<br>


				<h2>Assorted Drinks:</h2>
				<b>Alcohol-Z:</b> Whiskey 5u + Vodka 5u + Rum 5u<br>
				<b>BATTLE BREW:</b> Med-X 5u + Vodka 5u<br>
				<b>Blackwater Brew:</b> Water 5u + Charcoal 5u + Beer 5u<br>
				<b>Dirty Wastelander:</b> Mutfruit Juice 5u + Whiskey 10u + Water 10u<br>
				<b>Fire Belly:</b> Vodka 5u + Soy Sauce 5u + Salt 5u<br>
				<b>Firecracker:</b> Fermented Xander Root (Salgam) 5u + Yucca Juice 5u<br>
				<b>Hard Lemonade:</b> Lemonade 5u + Vodka 5u + radium for some godforsaken reason<br>
				<b>Jake Juice:</b> Whiskey 5u + Beer 5u + more fucking radium<br>
				<b>Wasteland Tequila</b>: Tequila 5u + Mutfruit Juice 5u<br>
				<b>Resilient Sludge (for ghouls!):</b> 5u radium + 5u sugar + 5u water<br>
				<b>Strong Sludge (for ghouls!):</b> Uranium 5u + Resilient Sludge 15u<br>
				<b>Sunset Float:</b>Sunset Sasparilla 5u + Ice 5u + Cream 5u<br>
				</body>
				</html>
			"}

/obj/item/book/manual/nuclear
	name = "Fission Mailed: Nuclear Sabotage 101"
	icon_state ="bookNuclear"
	author = "Syndicate"
	title = "Fission Mailed: Nuclear Sabotage 101"
	dat = {"<html>
			<head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			</head>
			<body>
			Nuclear Explosives 101:<br>
			Hello and thank you for choosing the Syndicate for your nuclear information needs.<br>
			Today's crash course will deal with the operation of a Fusion Class US Government made Nuclear Device.<br>
			First and foremost, DO NOT TOUCH ANYTHING UNTIL THE BOMB IS IN PLACE.<br>
			Pressing any button on the compacted bomb will cause it to extend and bolt itself into place.<br>
			If this is done to unbolt it one must completely log in which at this time may not be possible.<br>
			To make the nuclear device functional:<br>
			<li>Place the nuclear device in the designated detonation zone.</li>
			<li>Extend and anchor the nuclear device from its interface.</li>
			<li>Insert the nuclear authorisation disk into slot.</li>
			<li>Type numeric authorisation code into the keypad. This should have been provided. Note: If you make a mistake press R to reset the device.
			<li>Press the E button to log onto the device.</li>
			You now have activated the device. To deactivate the buttons at anytime for example when you've already prepped the bomb for detonation	remove the auth disk OR press the R on the keypad.<br>
			Now the bomb CAN ONLY be detonated using the timer. Manual detonation is not an option.<br>
			Note: US Government is a pain in the neck.<br>
			Toggle off the SAFETY.<br>
			Note: You wouldn't believe how many Syndicate Operatives with doctorates have forgotten this step.<br>
			So use the - - and + + to set a det time between 5 seconds and 10 minutes.<br>
			Then press the timer toggle button to start the countdown.<br>
			Now remove the auth. disk so that the buttons deactivate.<br>
			Note: THE BOMB IS STILL SET AND WILL DETONATE<br>
			Now before you remove the disk if you need to move the bomb you can:<br>
			Toggle off the anchor, move it, and re-anchor.<br><br>
			Good luck. Remember the order:<br>
			<b>Disk, Code, Safety, Timer, Disk, RUN!</b><br>
			Intelligence Analysts believe that normal US Government procedure is for the Captain to secure the nuclear authorisation disk.<br>
			Good luck!
			</body>
			</html>"}

// Wiki books that are linked to the configured wiki link.

// A book that links to the wiki
/obj/item/book/manual/wiki
	var/page_link = ""
	window_size = "970x710"

/obj/item/book/manual/wiki/attack_self()
	if(!dat)
		initialize_wikibook()
	..()

/obj/item/book/manual/wiki/proc/initialize_wikibook()
	var/wikiurl = CONFIG_GET(string/wikiurltg)
	if(wikiurl)
		dat = {"

			<html><head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			<style>
				iframe {
					display: none;
				}
			</style>
			</head>
			<body>
			<script type="text/javascript">
				function pageloaded(myframe) {
					document.getElementById("loading").style.display = "none";
					myframe.style.display = "inline";
				}
			</script>
			<p id='loading'>You start skimming through the manual...</p>
			<iframe width='100%' height='97%' onload="pageloaded(this)" src="[wikiurl]/[page_link]?printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
			</body>

			</html>

			"}

/obj/item/book/manual/wiki/cit
	name = "Citadel infobook"
	icon_state ="book8"
	author = "Nanotrasen"
	title = "Citadel infobook"
	page_link = ""
	window_size = "1500x800" //Too squashed otherwise

/obj/item/book/manual/wiki/cit/initialize_wikibook()
	var/wikiurl = CONFIG_GET(string/wikiurl)
	if(wikiurl)
		dat = {"

			<html><head>
			<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			<style>
				iframe {
					display: none;
				}
			</style>
			</head>
			<body>
			<script type="text/javascript">
				function pageloaded(myframe) {
					document.getElementById("loading").style.display = "none";
					myframe.style.display = "block";
				}
			</script>
			<p id='loading'>You start skimming through the manual...</p>
			<iframe width='100%' height='97%' onload="pageloaded(this)" src="[wikiurl]/[page_link]" frameborder="0" id="main_frame"></iframe>
			</body>

			</html>

			"}

/obj/item/book/manual/wiki/cit/chemistry
	name = "Chemistry Textbook"
	icon_state ="chemistrybook"
	author = "Nanotrasen"
	title = "Chemistry Textbook"
	page_link = "main/guides/guide_chemistry"

/obj/item/book/manual/wiki/cit/chem_recipies
	name = "Chemistry Recipies"
	icon_state ="chemrecibook"
	author = "Chemcat"
	title = "Chemistry Recipies"
	page_link = "main/guides/chem_recipies"

/obj/item/book/manual/wiki/chemistry
	name = "Outdated Chemistry Textbook"
	icon_state ="chemistrybook_old"
	author = "Nanotrasen"
	title = "Outdated Chemistry Textbook"
	page_link = "Guide_to_chemistry"

///obj/item/book/manual/wiki/chemistry/Initialize()
//	..()
//	new /obj/item/book/manual/wiki/cit/chemistry(loc)
//	new /obj/item/book/manual/wiki/cit/chem_recipies(loc)

/obj/item/book/manual/wiki/engineering_construction
	name = "Station Repairs and Construction"
	icon_state ="bookEngineering"
	author = "Engineering Encyclopedia"
	title = "Station Repairs and Construction"
	page_link = "Guide_to_construction"

/obj/item/book/manual/wiki/engineering_guide
	name = "Engineering Textbook"
	icon_state ="bookEngineering2"
	author = "Engineering Encyclopedia"
	title = "Engineering Textbook"
	page_link = "Guide_to_engineering"

/obj/item/book/manual/wiki/engineering_singulo_tesla
	name = "Singularity and Tesla for Dummies"
	icon_state ="bookEngineeringSingularitySafety"
	author = "Engineering Encyclopedia"
	title = "Singularity and Tesla for Dummies"
	page_link = "Singularity_and_Tesla_engines"

/obj/item/book/manual/wiki/security_space_law
	name = "Space Law"
	desc = "A set of US Government guidelines for keeping law and order on their space stations."
	icon_state = "bookSpaceLaw"
	author = "Nanotrasen"
	title = "Space Law"
	page_link = "Space_Law"

/obj/item/book/manual/wiki/infections
	name = "Infections - Making your own pandemic!"
	icon_state = "bookInfections"
	author = "Infections Encyclopedia"
	title = "Infections - Making your own pandemic!"
	page_link = "Infections"

/obj/item/book/manual/wiki/telescience
	name = "Teleportation Science - Bluespace for dummies!"
	icon_state = "book7"
	author = "University of Bluespace"
	title = "Teleportation Science - Bluespace for dummies!"
	page_link = "Guide_to_telescience"

/obj/item/book/manual/wiki/engineering_hacking
	name = "Hacking"
	icon_state ="bookHacking"
	author = "Engineering Encyclopedia"
	title = "Hacking"
	page_link = "Hacking"

/obj/item/book/manual/wiki/detective
	name = "The Film Noir: Proper Procedures for Investigations"
	icon_state ="bookDetective"
	author = "Nanotrasen"
	title = "The Film Noir: Proper Procedures for Investigations"
	page_link = "Detective"

/obj/item/book/manual/wiki/barman_recipes
	name = "Barman Recipes: Mixing Drinks and Changing Lives"
	icon_state = "barbook"
	author = "Sir John Rose"
	title = "Barman Recipes: Mixing Drinks and Changing Lives"
	page_link = "Guide_to_food_and_drinks"

/obj/item/book/manual/wiki/robotics_cyborgs
	name = "Robotics for Dummies"
	icon_state = "borgbook"
	author = "XISC"
	title = "Robotics for Dummies"
	page_link = "Guide_to_robotics"

/obj/item/book/manual/wiki/research_and_development
	name = "Research and Development 101"
	icon_state = "rdbook"
	author = "Dr. L. Ight"
	title = "Research and Development 101"
	page_link = "Guide_to_Research_and_Development"

/obj/item/book/manual/wiki/experimentor
	name = "Mentoring your Experiments"
	icon_state = "rdbook"
	author = "Dr. H.P. Kritz"
	title = "Mentoring your Experiments"
	page_link = "Experimentor"

/obj/item/book/manual/wiki/medical_cloning
	name = "Cloning techniques of the 26th century"
	icon_state ="bookCloning"
	author = "Medical Journal, volume 3"
	title = "Cloning techniques of the 26th century"
	page_link = "Guide_to_genetics#Cloning"

/obj/item/book/manual/wiki/cooking_to_serve_man
	name = "To Serve Man"
	desc = "It's a cookbook!"
	icon_state ="cooked_book"
	author = "the Kanamitan Empire"
	title = "To Serve Man"
	page_link = "Guide_to_food_and_drinks"

/obj/item/book/manual/wiki/circuitry
	name = "Circuitry for Dummies"
	icon_state = "book1"
	author = "Dr. Hans Asperger"
	title = "Circuitry for Dummies"
	page_link = "Guide_to_circuits"

/obj/item/book/manual/wiki/tcomms
	name = "Subspace Telecommunications And You"
	icon_state = "book3"
	author = "Engineering Encyclopedia"
	title = "Subspace Telecommunications And You"
	page_link = "Guide_to_Telecommunications"

/obj/item/book/manual/wiki/atmospherics
	name = "Lexica Atmosia"
	icon_state = "book5"
	author = "the City-state of Atmosia"
	title = "Lexica Atmosia"
	page_link = "Guide_to_Atmospherics"

/obj/item/book/manual/wiki/medicine
	name = "Medical Space Compendium, Volume 638"
	icon_state = "book8"
	author = "Medical Journal"
	title = "Medical Space Compendium, Volume 638"
	page_link = "Guide_to_medicine"

/obj/item/book/manual/wiki/surgery
	name = "Brain Surgery for Dummies"
	icon_state = "book4"
	author = "Dr. F. Fran"
	title = "Brain Surgery for Dummies"
	page_link = "Surgery"

/obj/item/book/manual/wiki/grenades
	name = "DIY Chemical Grenades"
	icon_state = "book2"
	author = "W. Powell"
	title = "DIY Chemical Grenades"
	page_link = "Grenade"

/obj/item/book/manual/wiki/toxins
	name = "Toxins or: How I Learned to Stop Worrying and Love the Maxcap"
	icon_state = "book6"
	author = "Cuban Pete"
	title = "Toxins or: How I Learned to Stop Worrying and Love the Maxcap"
	page_link = "Guide_to_toxins"
