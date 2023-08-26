/obj/machinery/mineral/wasteland_vendor/bank
	name = "Banking Machine"
	desc = "A machine that allows you to deposit coins into your account!"
	var/ckey = null
	var/banked_caps = 0

/obj/machinery/mineral/wasteland_vendor/bank/ui_interact(mob/user)
	. = ..()
	var/dat
	ckey = user.ckey
	banked_caps = getMoney(ckey)
	dat +="<div class='statusDisplay'>"
	dat += "<b>Coins stored:</b> [stored_caps]. <A href='?src=[REF(src)];choice=eject'>Eject coins</A><br>"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Coins banked:</b> [banked_caps]."
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Redeem coins:</b> <A href='?src=[REF(src)];choice=redeem'>Redeem coins</A><br>"
	dat += "</div>"
	dat += "<br>"

	var/datum/browser/popup = new(user, "tradingvendor", "Bank Machine", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/wasteland_vendor/bank/Topic(href, href_list)
	if(..())
		return
	if(href_list["choice"] == "eject")
		remove_all_caps()
	if(href_list["choice"] == "redeem")
		redeem_caps()

/obj/machinery/mineral/wasteland_vendor/bank/proc/redeem_caps()
	adjustMoney(usr.ckey, stored_caps)
	to_chat(usr, "You have added [stored_caps] coins to your account!")
	stored_caps = 0
	src.ui_interact(usr)
