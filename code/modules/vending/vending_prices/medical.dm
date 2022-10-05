/*
Custom prices for vendors go in a file like this
item path with custom_price var indented under it.
Price defined in code\__DEFINES\economy.dm
*/

/obj/item/stock_parts/chem_cartridge/garbage
    custom_price = PRICE_ABOVE_NORMAL

/obj/item/stock_parts/chem_cartridge/crafted
    custom_price = PRICE_ABOVE_EXPENSIVE

/obj/item/stock_parts/chem_cartridge/simple
    custom_price = PRICE_ABOVE_EXPENSIVE

/obj/item/stock_parts/chem_cartridge/pristine
    custom_price = PRICE_ULTRA_EXPENSIVE

/obj/item/reagent_containers/hypospray/medipen/stimpak
	custom_price = PRICE_STIMPAK

/obj/item/reagent_containers/hypospray/medipen/stimpak/super
    custom_price = PRICE_SUPER_STIM
