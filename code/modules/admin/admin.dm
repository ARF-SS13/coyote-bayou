
////////////////////////////////
/proc/log_and_message_admins(message as text, mob/user = usr)
	var/finalMessage = user ? "[key_name(user)] [message]" : "EVENT [message]"
	log_admin(finalMessage)
	message_admins(finalMessage)
	log_world(finalMessage)

/proc/message_admins(msg, pref, list/exceptfor)
	var/list/whosend = GLOB.admins.Copy()
	if(exceptfor)
		exceptfor = SANITIZE_LIST(exceptfor)
		for(var/ppl in exceptfor)
			whosend -= extract_client(ppl)
	msg = "<span class=\"admin filter_adminlog\"><span class=\"prefix\">ADMIN LOG:</span> <span class=\"message linkify\">[msg]</span></span>"
	to_chat(whosend, msg, confidential = TRUE, pref_check = pref)

/proc/relay_msg_admins(msg, pref, list/exceptfor)
	var/list/whosend = GLOB.admins.Copy()
	if(exceptfor)
		exceptfor = SANITIZE_LIST(exceptfor)
		for(var/ppl in exceptfor)
			whosend -= extract_client(ppl)
	msg = "<span class=\"admin filter_adminlog\"><span class=\"prefix\">RELAY:</span> <span class=\"message linkify\">[msg]</span></span>"
	to_chat(whosend, msg, confidential = TRUE, pref_check = pref)


///////////////////////////////////////////////////////////////////////////////////////////////Panels

/datum/admins/proc/show_player_panel(mob/M in GLOB.mob_list)
	set category = "Admin.Game"
	set name = "Show Player Panel"
	set desc="Edit player (respawn, ban, heal, etc)"

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use show_player_panel() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use show_player_panel() without admin perms.")
		return

	log_admin("[key_name(usr)] checked the individual player panel for [key_name(M)][isobserver(usr)?"":" while in game"].")

	if(QDELETED(M))
		to_chat(usr, span_warning("You seem to be selecting a mob that doesn't exist anymore."), confidential = TRUE)
		return

	var/ref = "[REF(usr.client.holder)];[HrefToken()]"
	var/ref_mob = REF(M)

	var/list/body = list("<b>[M.name]</b>")
	if(M.client)
		body += " played by <b>[M.client]</b> "
		body += " <a href='?src=[ref];editrights=[(GLOB.admin_datums[M.client.ckey] || GLOB.deadmins[M.client.ckey]) ? "rank" : "add"];key=[M.key];close=1'>[M.client.holder ? M.client.holder.rank : "Player"]</a>"
		if(CONFIG_GET(flag/use_exp_tracking))
			body += " <a href='?src=[ref];getplaytimewindow=[ref_mob]'>" + M.client.get_exp_living() + "</a> "

	if(isnewplayer(M))
		body += " <B>Hasn't Entered Game</B> "
	else
		body += " | <a href='?src=[ref];revive=[ref_mob]'>Heal</a> | <a href='?src=[ref];sleep=[ref_mob]'>Sleep</a>"

	if(M.client)
		body += "<br><b>First Seen:</b> [M.client.player_join_date]"
		body += "<br><b>Byond account registered on:</b> [M.client.account_join_date]"
		body += "<br><br><b>CentCom Galactic Ban DB: </b> "
		if(CONFIG_GET(string/centcom_ban_db))
			body += "<a href='?src=[ref];centcomlookup=[M.client.ckey]'>Search</a>"
		else
			body += "<i>Disabled</i>"
		body += "<br><br><b>Show related accounts by:</b> "
		body += " <a href='?src=[ref];showrelatedacc=cid;client=[REF(M.client)]'>CID</a> | "
		body += "<a href='?src=[ref];showrelatedacc=ip;client=[REF(M.client)]'>IP</a>"
		var/rep = 0
		rep += SSpersistence.antag_rep[M.ckey]
		body += "<br><br>Antagonist reputation: [rep]"
		body += "<br><a href='?src=[ref];modantagrep=add;mob=[ref_mob]'>increase</a> "
		body += "<a href='?src=[ref];modantagrep=subtract;mob=[ref_mob]'>decrease</a> "
		body += "<a href='?src=[ref];modantagrep=set;mob=[ref_mob]'>set</a> "
		body += "<a href='?src=[ref];modantagrep=zero;mob=[ref_mob]'>zero</a>"
		var/full_version = "Unknown"
		if(M.client.byond_version)
			full_version = "[M.client.byond_version].[M.client.byond_build ? M.client.byond_build : "xxx"]"
		body += "<br><b>Byond version:</b> [full_version]<br>"


	body += "<br><br> <a href='?_src_=vars;[HrefToken()];Vars=[ref_mob]'>VV</a> - "
	if(M.mind)
		body += "<a href='?src=[ref];traitor=[ref_mob]'>TP</a> - "
		// body += "<a href='?src=[ref];skill=[ref_mob]'>SKILLS</a> - "
	else
		body += "<a href='?src=[ref];initmind=[ref_mob]'>Init Mind</a> - "
	if (iscyborg(M))
		body += "<a href='?src=[ref];borgpanel=[ref_mob]'>BP</a> - "
	body += "<a href='?priv_msg=[M.ckey]'>PM</a> - "
	body += "<a href='?src=[ref];subtlemessage=[ref_mob]'>SM</a> - "
	if (ishuman(M) && M.mind)
		body += "<a href='?src=[ref];HeadsetMessage=[ref_mob]'>HM</a> - "
	body += "<a href='?src=[ref];adminplayerobservefollow=[ref_mob]'>FLW</a> - "
	//Default to client logs if available
	var/source = LOGSRC_MOB
	if(M.client)
		source = LOGSRC_CLIENT
	body += "<a href='?src=[ref];individuallog=[ref_mob];log_src=[source]'>LOGS</a>\] <br>"

	body += "<b>Mob type</b> = [M.type]<br>"
	body += "<a href='?src=[ref];removeProfilePic=[ref_mob]'>Remove Profile Picture</a><br><br>" // Coyote change here! Added removing pfp to the player panel <3

	body += "<a href='?src=[ref];boot2=[ref_mob]'>Kick</A> | "
	body += "<a href='?src=[ref];newban=[ref_mob]'>Ban</A> | "
	body += "<a href='?src=[ref];jobban2=[ref_mob]'>Jobban</A> | "
	body += "<a href='?src=[ref];appearanceban=[ref_mob]'>Identity Ban</A> | "
	if(jobban_isbanned(M, "OOC"))
		body+= "<a href='?src=[ref];jobban3=OOC;jobban4=[ref_mob]'><font color=red>OOCBan</font></A> | "
	else
		body += "<a href='?src=[ref];jobban3=OOC;jobban4=[ref_mob]'>OOCBan</A> | "
	if(QDELETED(M) || QDELETED(usr))
		return
	if(jobban_isbanned(M, "emote"))
		body+= "<a href='?src=[ref];jobban3=emote;jobban4=[ref_mob]'><font color=red>EmoteBan</font></A> | "
	else
		body+= "<a href='?src=[ref];jobban3=emote;jobban4=[ref_mob]'>Emoteban</A> | "
	if(QDELETED(M) || QDELETED(usr))
		return

	//body += "<A href='?_src_=holder;[HrefToken()];showmessageckey=[M.ckey]'>Notes | Messages | Watchlist</A> | "
	body += "<a href='?src=[ref];showmessageckey=[M.ckey]'>Notes</A> | "
	if(M.client)
		body += "<a href='?src=[ref];sendtoprison=[ref_mob]'>Prison</A> | "
		body += "<a href='?src=[ref];sendbacktolobby=[ref_mob]'>Send back to Lobby</A>"
		var/muted = M.client.prefs.muted
		body += {"<br><b>Mute: </b>
			<a href='?src=[ref];mute=[M.ckey];mute_type=[MUTE_IC]'><font color='[(muted & MUTE_IC) ? "#ff5e5e" : "white"]'>IC</font></a> |
			<a href='?src=[ref];mute=[M.ckey];mute_type=[MUTE_OOC]'><font color='[(muted & MUTE_OOC) ? "#ff5e5e" : "white"]'>OOC</font></a> |
			<a href='?src=[ref];mute=[M.ckey];mute_type=[MUTE_PRAY]'><font color='[(muted & MUTE_PRAY) ? "#ff5e5e" : "white"]'>PRAY</font></a> |
			<a href='?src=[ref];mute=[M.ckey];mute_type=[MUTE_ADMINHELP]'><font color='[(muted & MUTE_ADMINHELP) ? "#ff5e5e" : "white"]'>ADMINHELP</font></a> |
			<a href='?src=[ref];mute=[M.ckey];mute_type=[MUTE_DEADCHAT]'><font color='[(muted & MUTE_DEADCHAT) ? "#ff5e5e" : "white"]'>DEADCHAT</font></a>
			(<a href='?src=[ref];mute=[M.ckey];mute_type=[MUTE_ALL]'><font color='[(muted & MUTE_ALL) ? "#ff5e5e" : "white"]'>ALL</font></a>)
		"}

	body += {"
		<br><br>
		<a href='?src=[ref];jumpto=[ref_mob]'>Jump to</A> | 
		<a href='?src=[ref];getmob=[ref_mob]'>Get</A> | 
		<a href='?src=[ref];sendmob=[ref_mob]'>Send To</A>

		<br><br>
		<a href='?src=[ref];traitor=[ref_mob]'>Traitor panel</A> | 
		<a href='?src=[ref];narrateto=[ref_mob]'>Narrate to</A> | 
		<a href='?src=[ref];subtlemessage=[ref_mob]'>Subtle message</A> | 
		<a href='?src=[ref];languagemenu=[ref_mob]'>Language Menu</A>
		"}

	if (M.client)
		if(!isnewplayer(M))
			body += "<br><br><b>Transformation:</b><br>"

			var/list/transformation_options = list()

			//Human
			if(ishuman(M))
				transformation_options += "<B>Human</B>"
			else
				transformation_options += "<a href='?src=[ref];humanone=[ref_mob]'>Humanize</A>"

			//Monkey
			if(ismonkey(M))
				transformation_options += "<B>Monkeyized</B>"
			else
				transformation_options += "<a href='?src=[ref];monkeyone=[ref_mob]'>Monkeyize</A>"

			//Corgi
			if(iscorgi(M))
				transformation_options += "<B>Corgized</B>"
			else
				transformation_options += "<a href='?src=[ref];corgione=[ref_mob]'>Corgize</A>"

			//AI / Cyborg
			if(isAI(M))
				transformation_options += "<B>Is an AI</B>"
			else if(ishuman(M))
				transformation_options += {"
					<a href='?src=[ref];makeai=[ref_mob]'>Make AI</A>
					<a href='?src=[ref];makerobot=[ref_mob]'>Make Robot</A>
					<a href='?src=[ref];makealien=[ref_mob]'>Make Alien</A>
					<a href='?src=[ref];makeslime=[ref_mob]'>Make Slime</A>
					<a href='?src=[ref];makeblob=[ref_mob]'>Make Blob</A>
					"}

			//Simple Animals
			if(isanimal(M))
				transformation_options += "<a href='?src=[ref];makeanimal=[ref_mob]'>Re-Animalize</A>"
			else
				transformation_options += "<a href='?src=[ref];makeanimal=[ref_mob]'>Animalize</A>"
			
			body += transformation_options.Join(" | ")

			body += {"
				<br><br><b>Rudimentary transformation:</b><font size=2><br>These transformations only create a new mob type and copy stuff over. They do not take into account MMIs and similar mob-specific things. The buttons in 'Transformations' are preferred, when possible.</font>
				<br> Special: <a href='?src=[ref];simplemake=observer;mob=[ref_mob]'>Observer</A> | 
				<a href='?src=[ref];simplemake=robot;mob=[ref_mob]'>Cyborg</A>
				<br> Humanoid: <a href='?src=[ref];simplemake=human;mob=[ref_mob]'>Human</A> | 
				<a href='?src=[ref];simplemake=monkey;mob=[ref_mob]'>Monkey</A>
				<br> Alien: <a href='?src=[ref];simplemake=drone;mob=[ref_mob]'>Drone</A>, 
				<a href='?src=[ref];simplemake=hunter;mob=[ref_mob]'>Hunter</A> | 
				<a href='?src=[ref];simplemake=sentinel;mob=[ref_mob]'>Sentinel</A> | 
				<a href='?src=[ref];simplemake=praetorian;mob=[ref_mob]'>Praetorian</A> | 
				<a href='?src=[ref];simplemake=queen;mob=[ref_mob]'>Queen</A> | 
				<a href='?src=[ref];simplemake=larva;mob=[ref_mob]'>Larva</A>
				<br> Slime: <a href='?src=[ref];simplemake=slime;mob=[ref_mob]'>Baby</A> | 
				<a href='?src=[ref];simplemake=adultslime;mob=[ref_mob]'>Adult</A>
				<br> Pet: <a href='?src=[ref];simplemake=cat;mob=[ref_mob]'>Cat</A> | 
				<a href='?src=[ref];simplemake=runtime;mob=[ref_mob]'>Runtime</A> | 
				<a href='?src=[ref];simplemake=corgi;mob=[ref_mob]'>Corgi</A> | 
				<a href='?src=[ref];simplemake=ian;mob=[ref_mob]'>Ian</A> | 
				<a href='?src=[ref];simplemake=crab;mob=[ref_mob]'>Crab</A> | 
				<a href='?src=[ref];simplemake=coffee;mob=[ref_mob]'>Coffee</A>
				<br> Construct: <a href='?src=[ref];simplemake=constructarmored;mob=[ref_mob]'>Juggernaut</A> | 
				<a href='?src=[ref];simplemake=constructbuilder;mob=[ref_mob]'>Artificer</A> | 
				<a href='?src=[ref];simplemake=constructwraith;mob=[ref_mob]'>Wraith</A> | 
				<a href='?src=[ref];simplemake=shade;mob=[ref_mob]'>Shade</A>
				"}

		body += {"
			<br><br>
			<b>Other actions:</b>
			<br>
			<a href='?src=[ref];forcespeech=[ref_mob]'>Forcesay</A> | 
			<a href='?src=[ref];tdome1=[ref_mob]'>Thunderdome 1</A> | 
			<a href='?src=[ref];tdome2=[ref_mob]'>Thunderdome 2</A> | 
			<a href='?src=[ref];tdomeadmin=[ref_mob]'>Thunderdome Admin</A> | 
			<a href='?src=[ref];tdomeobserve=[ref_mob]'>Thunderdome Observer</A> | 
			<a href='?src=[ref];makementor=[M.ckey]'>Make mentor</A> | 
			<a href='?src=[ref];removementor=[M.ckey]'>Remove mentor</A> | 
			<a href='?src=[ref];makeeligible=[ref_mob]'>Allow reentering round</A>
			"}
	body += "<br></body></html>"

	var/datum/browser/browser = new(usr, "adminplayeropts-[ref_mob]", "<div align='center'>Player Panel</div>", 700, 500)
	browser.set_content(body.Join())
	browser.open()

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Player Panel") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/datum/admins/proc/access_news_network() //MARKER
	set category = "Admin.Events"
	set name = "Access Newscaster Network"
	set desc = "Allows you to view, add and edit news feeds."

	if (!istype(src, /datum/admins))
		src = usr.client.holder
	if (!istype(src, /datum/admins))
		to_chat(usr, "Error: you are not an admin!", confidential = TRUE)
		return
	var/dat
	dat = text("<HEAD><TITLE>Admin Newscaster</TITLE></HEAD><H3>Admin Newscaster Unit</H3>")

	switch(admincaster_screen)
		if(0)
			dat += "Welcome to the admin newscaster.<BR> Here you can add, edit and censor every newspiece on the network."
			dat += "<BR>Feed channels and stories entered through here will be uneditable and handled as official news by the rest of the units."
			dat += "<BR>Note that this panel allows full freedom over the news network, there are no constrictions except the few basic ones. Don't break things!</FONT>"
			if(GLOB.news_network.wanted_issue.active)
				dat+= "<HR><A href='?src=[REF(src)];[HrefToken()];ac_view_wanted=1'>Read Wanted Issue</A>"
			dat+= "<HR><BR><A href='?src=[REF(src)];[HrefToken()];ac_create_channel=1'>Create Feed Channel</A>"
			dat+= "<BR><A href='?src=[REF(src)];[HrefToken()];ac_view=1'>View Feed Channels</A>"
			dat+= "<BR><A href='?src=[REF(src)];[HrefToken()];ac_create_feed_story=1'>Submit new Feed story</A>"
			dat+= "<BR><BR><A href='?src=[REF(usr)];[HrefToken()];mach_close=newscaster_main'>Exit</A>"
			var/wanted_already = 0
			if(GLOB.news_network.wanted_issue.active)
				wanted_already = 1
			dat+="<HR><B>Feed Security functions:</B><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_menu_wanted=1'>[(wanted_already) ? ("Manage") : ("Publish")] \"Wanted\" Issue</A>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_menu_censor_story=1'>Censor Feed Stories</A>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_menu_censor_channel=1'>Mark Feed Channel with US Government D-Notice (disables and locks the channel).</A>"
			dat+="<BR><HR><A href='?src=[REF(src)];[HrefToken()];ac_set_signature=1'>The newscaster recognises you as:<BR> <FONT COLOR='green'>[src.admin_signature]</FONT></A>"
		if(1)
			dat+= "Station Feed Channels<HR>"
			if( !length(GLOB.news_network.network_channels) )
				dat+="<I>No active channels found...</I>"
			else
				for(var/datum/news/feed_channel/CHANNEL in GLOB.news_network.network_channels)
					if(CHANNEL.is_admin_channel)
						dat+="<B><FONT style='BACKGROUND-COLOR: LightGreen'><A href='?src=[REF(src)];ac_show_channel=[REF(CHANNEL)]'>[CHANNEL.channel_name]</A></FONT></B><BR>"
					else
						dat+="<B><A href='?src=[REF(src)];[HrefToken()];ac_show_channel=[REF(CHANNEL)]'>[CHANNEL.channel_name]</A> [(CHANNEL.censored) ? ("<FONT COLOR='red'>***</FONT>") : ""]<BR></B>"
			dat+="<BR><HR><A href='?src=[REF(src)];[HrefToken()];ac_refresh=1'>Refresh</A>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Back</A>"
		if(2)
			dat+="Creating new Feed Channel..."
			dat+="<HR><B><A href='?src=[REF(src)];[HrefToken()];ac_set_channel_name=1'>Channel Name</A>:</B> [src.admincaster_feed_channel.channel_name]<BR>"
			dat+="<B><A href='?src=[REF(src)];[HrefToken()];ac_set_signature=1'>Channel Author</A>:</B> <FONT COLOR='green'>[src.admin_signature]</FONT><BR>"
			dat+="<B><A href='?src=[REF(src)];[HrefToken()];ac_set_channel_lock=1'>Will Accept Public Feeds</A>:</B> [(src.admincaster_feed_channel.locked) ? ("NO") : ("YES")]<BR><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_submit_new_channel=1'>Submit</A><BR><BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Cancel</A><BR>"
		if(3)
			dat+="Creating new Feed Message..."
			dat+="<HR><B><A href='?src=[REF(src)];[HrefToken()];ac_set_channel_receiving=1'>Receiving Channel</A>:</B> [src.admincaster_feed_channel.channel_name]<BR>" //MARK
			dat+="<B>Message Author:</B> <FONT COLOR='green'>[src.admin_signature]</FONT><BR>"
			dat+="<B><A href='?src=[REF(src)];[HrefToken()];ac_set_new_message=1'>Message Body</A>:</B> [src.admincaster_feed_message.returnBody(-1)] <BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_submit_new_message=1'>Submit</A><BR><BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Cancel</A><BR>"
		if(4)
			dat+="Feed story successfully submitted to [src.admincaster_feed_channel.channel_name].<BR><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Return</A><BR>"
		if(5)
			dat+="Feed Channel [src.admincaster_feed_channel.channel_name] created successfully.<BR><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Return</A><BR>"
		if(6)
			dat+="<B><FONT COLOR='maroon'>ERROR: Could not submit Feed story to Network.</B></FONT><HR><BR>"
			if(src.admincaster_feed_channel.channel_name=="")
				dat+="<FONT COLOR='maroon'>Invalid receiving channel name.</FONT><BR>"
			if(src.admincaster_feed_message.returnBody(-1) == "" || src.admincaster_feed_message.returnBody(-1) == "\[REDACTED\]")
				dat+="<FONT COLOR='maroon'>Invalid message body.</FONT><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[3]'>Return</A><BR>"
		if(7)
			dat+="<B><FONT COLOR='maroon'>ERROR: Could not submit Feed Channel to Network.</B></FONT><HR><BR>"
			if(src.admincaster_feed_channel.channel_name =="" || src.admincaster_feed_channel.channel_name == "\[REDACTED\]")
				dat+="<FONT COLOR='maroon'>Invalid channel name.</FONT><BR>"
			var/check = 0
			for(var/datum/news/feed_channel/FC in GLOB.news_network.network_channels)
				if(FC.channel_name == src.admincaster_feed_channel.channel_name)
					check = 1
					break
			if(check)
				dat+="<FONT COLOR='maroon'>Channel name already in use.</FONT><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[2]'>Return</A><BR>"
		if(9)
			dat+="<B>[admincaster_feed_channel.channel_name]: </B><FONT SIZE=1>\[created by: <FONT COLOR='maroon'>[admincaster_feed_channel.returnAuthor(-1)]</FONT>\]</FONT><HR>"
			if(src.admincaster_feed_channel.censored)
				dat+="<FONT COLOR='red'><B>ATTENTION: </B></FONT>This channel has been deemed as threatening to the welfare of the station, and marked with a US Government D-Notice.<BR>"
				dat+="No further feed story additions are allowed while the D-Notice is in effect.</FONT><BR><BR>"
			else
				if( !length(src.admincaster_feed_channel.messages) )
					dat+="<I>No feed messages found in channel...</I><BR>"
				else
					var/i = 0
					for(var/datum/news/feed_message/MESSAGE in src.admincaster_feed_channel.messages)
						i++
						dat+="-[MESSAGE.returnBody(-1)] <BR>"
						if(MESSAGE.img)
							usr << browse_rsc(MESSAGE.img, "tmp_photo[i].png")
							dat+="<img src='tmp_photo[i].png' width = '180'><BR><BR>"
						dat+="<FONT SIZE=1>\[Story by <FONT COLOR='maroon'>[MESSAGE.returnAuthor(-1)]</FONT>\]</FONT><BR>"
						dat+="[MESSAGE.comments.len] comment[MESSAGE.comments.len > 1 ? "s" : ""]:<br>"
						for(var/datum/news/feed_comment/comment in MESSAGE.comments)
							dat+="[comment.body]<br><font size=1>[comment.author] [comment.time_stamp]</font><br>"
						dat+="<br>"
			dat+="<BR><HR><A href='?src=[REF(src)];[HrefToken()];ac_refresh=1'>Refresh</A>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[1]'>Back</A>"
		if(10)
			dat+="<B>Nanotrasen Feed Censorship Tool</B><BR>"
			dat+="<FONT SIZE=1>NOTE: Due to the nature of news Feeds, total deletion of a Feed Story is not possible.<BR>"
			dat+="Keep in mind that users attempting to view a censored feed will instead see the \[REDACTED\] tag above it.</FONT>"
			dat+="<HR>Select Feed channel to get Stories from:<BR>"
			if(!length(GLOB.news_network.network_channels))
				dat+="<I>No feed channels found active...</I><BR>"
			else
				for(var/datum/news/feed_channel/CHANNEL in GLOB.news_network.network_channels)
					dat+="<A href='?src=[REF(src)];[HrefToken()];ac_pick_censor_channel=[REF(CHANNEL)]'>[CHANNEL.channel_name]</A> [(CHANNEL.censored) ? ("<FONT COLOR='red'>***</FONT>") : ""]<BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Cancel</A>"
		if(11)
			dat+="<B>Nanotrasen D-Notice Handler</B><HR>"
			dat+="<FONT SIZE=1>A D-Notice is to be bestowed upon the channel if the handling Authority deems it as harmful for the station's"
			dat+="morale, integrity or disciplinary behaviour. A D-Notice will render a channel unable to be updated by anyone, without deleting any feed"
			dat+="stories it might contain at the time. You can lift a D-Notice if you have the required access at any time.</FONT><HR>"
			if(!length(GLOB.news_network.network_channels))
				dat+="<I>No feed channels found active...</I><BR>"
			else
				for(var/datum/news/feed_channel/CHANNEL in GLOB.news_network.network_channels)
					dat+="<A href='?src=[REF(src)];[HrefToken()];ac_pick_d_notice=[REF(CHANNEL)]'>[CHANNEL.channel_name]</A> [(CHANNEL.censored) ? ("<FONT COLOR='red'>***</FONT>") : ""]<BR>"

			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Back</A>"
		if(12)
			dat+="<B>[src.admincaster_feed_channel.channel_name]: </B><FONT SIZE=1>\[ created by: <FONT COLOR='maroon'>[src.admincaster_feed_channel.returnAuthor(-1)]</FONT> \]</FONT><BR>"
			dat+="<FONT SIZE=2><A href='?src=[REF(src)];[HrefToken()];ac_censor_channel_author=[REF(src.admincaster_feed_channel)]'>[(src.admincaster_feed_channel.authorCensor) ? ("Undo Author censorship") : ("Censor channel Author")]</A></FONT><HR>"

			if( !length(src.admincaster_feed_channel.messages) )
				dat+="<I>No feed messages found in channel...</I><BR>"
			else
				for(var/datum/news/feed_message/MESSAGE in src.admincaster_feed_channel.messages)
					dat+="-[MESSAGE.returnBody(-1)] <BR><FONT SIZE=1>\[Story by <FONT COLOR='maroon'>[MESSAGE.returnAuthor(-1)]</FONT>\]</FONT><BR>"
					dat+="<FONT SIZE=2><A href='?src=[REF(src)];[HrefToken()];ac_censor_channel_story_body=[REF(MESSAGE)]'>[(MESSAGE.bodyCensor) ? ("Undo story censorship") : ("Censor story")]</A>  -  <A href='?src=[REF(src)];[HrefToken()];ac_censor_channel_story_author=[REF(MESSAGE)]'>[(MESSAGE.authorCensor) ? ("Undo Author Censorship") : ("Censor message Author")]</A></FONT><BR>"
					dat+="[MESSAGE.comments.len] comment[MESSAGE.comments.len > 1 ? "s" : ""]: <a href='?src=[REF(src)];[HrefToken()];ac_lock_comment=[REF(MESSAGE)]'>[MESSAGE.locked ? "Unlock" : "Lock"]</a><br>"
					for(var/datum/news/feed_comment/comment in MESSAGE.comments)
						dat+="[comment.body] <a href='?src=[REF(src)];[HrefToken()];ac_del_comment=[REF(comment)];ac_del_comment_msg=[REF(MESSAGE)]'>X</a><br><font size=1>[comment.author] [comment.time_stamp]</font><br>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[10]'>Back</A>"
		if(13)
			dat+="<B>[src.admincaster_feed_channel.channel_name]: </B><FONT SIZE=1>\[ created by: <FONT COLOR='maroon'>[src.admincaster_feed_channel.returnAuthor(-1)]</FONT> \]</FONT><BR>"
			dat+="Channel messages listed below. If you deem them dangerous to the station, you can <A href='?src=[REF(src)];[HrefToken()];ac_toggle_d_notice=[REF(src.admincaster_feed_channel)]'>Bestow a D-Notice upon the channel</A>.<HR>"
			if(src.admincaster_feed_channel.censored)
				dat+="<FONT COLOR='red'><B>ATTENTION: </B></FONT>This channel has been deemed as threatening to the welfare of the station, and marked with a US Government D-Notice.<BR>"
				dat+="No further feed story additions are allowed while the D-Notice is in effect.</FONT><BR><BR>"
			else
				if( !length(src.admincaster_feed_channel.messages) )
					dat+="<I>No feed messages found in channel...</I><BR>"
				else
					for(var/datum/news/feed_message/MESSAGE in src.admincaster_feed_channel.messages)
						dat+="-[MESSAGE.returnBody(-1)] <BR><FONT SIZE=1>\[Story by <FONT COLOR='maroon'>[MESSAGE.returnAuthor(-1)]</FONT>\]</FONT><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[11]'>Back</A>"
		if(14)
			dat+="<B>Wanted Issue Handler:</B>"
			var/wanted_already = 0
			var/end_param = 1
			if(GLOB.news_network.wanted_issue.active)
				wanted_already = 1
				end_param = 2
			if(wanted_already)
				dat+="<FONT SIZE=2><BR><I>A wanted issue is already in Feed Circulation. You can edit or cancel it below.</FONT></I>"
			dat+="<HR>"
			dat+="<A href='?src=[REF(src)];[HrefToken()];ac_set_wanted_name=1'>Criminal Name</A>: [src.admincaster_wanted_message.criminal] <BR>"
			dat+="<A href='?src=[REF(src)];[HrefToken()];ac_set_wanted_desc=1'>Description</A>: [src.admincaster_wanted_message.body] <BR>"
			if(wanted_already)
				dat+="<B>Wanted Issue created by:</B><FONT COLOR='green'>[GLOB.news_network.wanted_issue.scannedUser]</FONT><BR>"
			else
				dat+="<B>Wanted Issue will be created under prosecutor:</B><FONT COLOR='green'>[src.admin_signature]</FONT><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_submit_wanted=[end_param]'>[(wanted_already) ? ("Edit Issue") : ("Submit")]</A>"
			if(wanted_already)
				dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_cancel_wanted=1'>Take down Issue</A>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Cancel</A>"
		if(15)
			dat+="<FONT COLOR='green'>Wanted issue for [src.admincaster_wanted_message.criminal] is now in Network Circulation.</FONT><BR><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Return</A><BR>"
		if(16)
			dat+="<B><FONT COLOR='maroon'>ERROR: Wanted Issue rejected by Network.</B></FONT><HR><BR>"
			if(src.admincaster_wanted_message.criminal =="" || src.admincaster_wanted_message.criminal == "\[REDACTED\]")
				dat+="<FONT COLOR='maroon'>Invalid name for person wanted.</FONT><BR>"
			if(src.admincaster_wanted_message.body == "" || src.admincaster_wanted_message.body == "\[REDACTED\]")
				dat+="<FONT COLOR='maroon'>Invalid description.</FONT><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Return</A><BR>"
		if(17)
			dat+="<B>Wanted Issue successfully deleted from Circulation</B><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Return</A><BR>"
		if(18)
			dat+="<B><FONT COLOR ='maroon'>-- STATIONWIDE WANTED ISSUE --</B></FONT><BR><FONT SIZE=2>\[Submitted by: <FONT COLOR='green'>[GLOB.news_network.wanted_issue.scannedUser]</FONT>\]</FONT><HR>"
			dat+="<B>Criminal</B>: [GLOB.news_network.wanted_issue.criminal]<BR>"
			dat+="<B>Description</B>: [GLOB.news_network.wanted_issue.body]<BR>"
			dat+="<B>Photo:</B>: "
			if(GLOB.news_network.wanted_issue.img)
				usr << browse_rsc(GLOB.news_network.wanted_issue.img, "tmp_photow.png")
				dat+="<BR><img src='tmp_photow.png' width = '180'>"
			else
				dat+="None"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Back</A><BR>"
		if(19)
			dat+="<FONT COLOR='green'>Wanted issue for [src.admincaster_wanted_message.criminal] successfully edited.</FONT><BR><BR>"
			dat+="<BR><A href='?src=[REF(src)];[HrefToken()];ac_setScreen=[0]'>Return</A><BR>"
		else
			dat+="I'm sorry to break your immersion. This shit's bugged. Report this bug to Agouri, polyxenitopalidou@gmail.com"

	usr << browse(dat, "window=admincaster_main;size=400x600")
	onclose(usr, "admincaster_main")


/datum/admins/proc/Game()
	if(!check_rights(0))
		return

	var/dat = {"
		<center><B>Game Panel</B></center><hr>\n
		<A href='?src=[REF(src)];[HrefToken()];c_mode=1'>Change Game Mode</A><br>
		"}
	if(GLOB.master_mode == "secret")
		dat += "<A href='?src=[REF(src)];[HrefToken()];f_secret=1'>(Force Secret Mode)</A><br>"
	if(GLOB.master_mode == "dynamic")
		if(SSticker.current_state <= GAME_STATE_PREGAME)
			dat += "<A href='?src=[REF(src)];[HrefToken()];f_dynamic_roundstart=1'>(Force Roundstart Rulesets)</A><br>"
			if (GLOB.dynamic_forced_roundstart_ruleset.len > 0)
				for(var/datum/dynamic_ruleset/roundstart/rule in GLOB.dynamic_forced_roundstart_ruleset)
					dat += {"<A href='?src=[REF(src)];[HrefToken()];f_dynamic_roundstart_remove=\ref[rule]'>-> [rule.name] <-</A><br>"}
				dat += "<A href='?src=[REF(src)];[HrefToken()];f_dynamic_roundstart_clear=1'>(Clear Rulesets)</A><br>"
			dat += "<A href='?src=[REF(src)];[HrefToken()];f_dynamic_options=1'>(Dynamic mode options)</A><br>"
		dat += "<hr/>"
	if(SSticker.IsRoundInProgress())
		dat += "<a href='?src=[REF(src)];[HrefToken()];gamemode_panel=1'>(Game Mode Panel)</a><BR>"
	dat += {"
		<BR>
		<A href='?src=[REF(src)];[HrefToken()];create_object=1'>Create Object</A><br>
		<A href='?src=[REF(src)];[HrefToken()];quick_create_object=1'>Quick Create Object</A><br>
		<A href='?src=[REF(src)];[HrefToken()];create_turf=1'>Create Turf</A><br>
		<A href='?src=[REF(src)];[HrefToken()];create_mob=1'>Create Mob</A><br>
		"}

	if(marked_datum && istype(marked_datum, /atom))
		dat += "<A href='?src=[REF(src)];[HrefToken()];dupe_marked_datum=1'>Duplicate Marked Datum</A><br>"

	usr << browse(dat, "window=admin2;size=240x280")
	return

/////////////////////////////////////////////////////////////////////////////////////////////////admins2.dm merge
//i.e. buttons/verbs


/datum/admins/proc/restart()
	set category = "Server"
	set name = "Reboot World"
	set desc="Restarts the world immediately"
	if (!usr.client.holder)
		return

	var/localhost_addresses = list("127.0.0.1", "::1")
	var/list/options = list("Regular Restart", "Regular Restart (with delay)", "Hard Restart (No Delay/Feeback Reason)", "Hardest Restart (No actions, just reboot)")
	if(world.TgsAvailable())
		options += "Server Restart (Kill and restart DD)";

	if(SSticker.admin_delay_notice)
		if(alert(usr, "Are you sure? An admin has already delayed the round end for the following reason: [SSticker.admin_delay_notice]", "Confirmation", "Yes", "No") != "Yes")
			return FALSE

	var/result = input(usr, "Select reboot method", "World Reboot", options[1]) as null|anything in options
	if(result)
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Reboot World") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		var/init_by = "Initiated by [usr.client.holder.fakekey ? "Admin" : usr.key]."
		switch(result)
			if("Regular Restart")
				if(!(isnull(usr.client.address) || (usr.client.address in localhost_addresses)))
					if(alert("Are you sure you want to restart the server?","This server is live","Restart","Cancel") != "Restart")
						return FALSE
				SSticker.Reboot(init_by, "admin reboot - by [usr.key] [usr.client.holder.fakekey ? "(stealth)" : ""]", 10)
			if("Regular Restart (with delay)")
				var/delay = input("What delay should the restart have (in seconds)?", "Restart Delay", 5) as num|null
				if(!delay)
					return FALSE
				if(!(isnull(usr.client.address) || (usr.client.address in localhost_addresses)))
					if(alert("Are you sure you want to restart the server?","This server is live","Restart","Cancel") != "Restart")
						return FALSE
				SSticker.Reboot(init_by, "admin reboot - by [usr.key] [usr.client.holder.fakekey ? "(stealth)" : ""]", delay * 10)
			if("Hard Restart (No Delay, No Feeback Reason)")
				to_chat(world, "World reboot - [init_by]")
				world.Reboot()
			if("Hardest Restart (No actions, just reboot)")
				to_chat(world, "Hard world reboot - [init_by]")
				world.Reboot(fast_track = TRUE)
			if("Server Restart (Kill and restart DD)")
				to_chat(world, "Server restart - [init_by]")
				world.TgsEndProcess()

/datum/admins/proc/end_round()
	set category = "Server"
	set name = "End Round"
	set desc = "Attempts to produce a round end report and then restart the server organically."

	if (!usr.client.holder)
		return
	var/confirm = alert("End the round and  restart the game world?", "End Round", "Yes", "Cancel")
	if(confirm == "Cancel")
		return
	if(confirm == "Yes")
		SSticker.force_ending = 1
		SSblackbox.record_feedback("tally", "admin_verb", 1, "End Round") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/datum/admins/proc/announce()
	set category = "Special Verbs"
	set name = "Announce"
	set desc="Announce your desires to the world"
	if(!check_rights(0))
		return

	var/message = input("Global message to send:", "Admin Announce", null, null)  as message
	if(message)
		if(!check_rights(R_SPAWN,0)) //fortuna edit
			message = adminscrub(message,500)
		to_chat(world, "<span class='adminnotice'><b>[usr.client.holder.fakekey ? "Administrator" : usr.key] Announces:</b></span>\n \t [message]", confidential = TRUE)
		log_admin("Announce: [key_name(usr)] : [message]")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Announce") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/set_admin_notice()
	set category = "Special Verbs"
	set name = "Set Admin Notice"
	set desc ="Set an announcement that appears to everyone who joins the server. Only lasts this round"
	if(!check_rights(0))
		return

	var/new_admin_notice = input(src,"Set a public notice for this round. Everyone who joins the server will see it.\n(Leaving it blank will delete the current notice):","Set Notice",GLOB.admin_notice) as message|null
	if(new_admin_notice == null)
		return
	if(new_admin_notice == GLOB.admin_notice)
		return
	if(new_admin_notice == "")
		message_admins("[key_name(usr)] removed the admin notice.")
		log_admin("[key_name(usr)] removed the admin notice:\n[GLOB.admin_notice]")
	else
		message_admins("[key_name(usr)] set the admin notice.")
		log_admin("[key_name(usr)] set the admin notice:\n[new_admin_notice]")
		to_chat(world, "<span class='adminnotice'><b>Admin Notice:</b>\n \t [new_admin_notice]</span>", confidential = TRUE)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Set Admin Notice") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	GLOB.admin_notice = new_admin_notice
	return

/datum/admins/proc/toggleooc()
	set category = "Server"
	set desc="Toggle dis bitch"
	set name="Toggle OOC"
	toggle_ooc()
	log_admin("[key_name(usr)] toggled OOC.")
	message_admins("[key_name_admin(usr)] toggled OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle OOC", "[GLOB.ooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggleooclocal()
	set category = "Server"
	set desc="Toggle dat bitch"
	set name="Toggle Local OOC"
	toggle_looc()
	log_admin("[key_name(usr)] toggled LOOC.")
	message_admins("[key_name_admin(usr)] toggled LOOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Local OOC", "[GLOB.looc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggleoocdead()
	set category = "Server"
	set desc="Toggle dis bitch"
	set name="Toggle Dead OOC"
	toggle_dooc()

	log_admin("[key_name(usr)] toggled Dead OOC.")
	message_admins("[key_name_admin(usr)] toggled Dead OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Dead OOC", "[GLOB.dooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggleaooc()
	set category = "Server"
	set desc="Toggle to bitch"
	set name="Toggle Antag OOC"
	toggle_aooc()
	log_admin("[key_name(usr)] toggled Antagonist OOC.")
	message_admins("[key_name_admin(usr)] toggled Antagonist OOC.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Antag OOC", "[GLOB.aooc_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/startnow()
	set category = "Server"
	set desc="Start the round RIGHT NOW"
	set name="Start Now"
	if(SSticker.current_state == GAME_STATE_PREGAME || SSticker.current_state == GAME_STATE_STARTUP)
		if(!SSticker.start_immediately)
			var/localhost_addresses = list("127.0.0.1", "::1")
			if(!(isnull(usr.client.address) || (usr.client.address in localhost_addresses)))
				if(alert("Are you sure you want to start the round?","Start Now","Start Now","Cancel") != "Start Now")
					return FALSE
			SSticker.start_immediately = TRUE
			log_admin("[usr.key] has started the game.")
			var/msg = ""
			if(SSticker.current_state == GAME_STATE_STARTUP)
				msg = " (The server is still setting up, but the round will be \
					started as soon as possible.)"
			message_admins("<font color='blue'>[usr.key] has started the game.[msg]</font>")
			SSblackbox.record_feedback("tally", "admin_verb", 1, "Start Now") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
			return TRUE
		SSticker.start_immediately = FALSE
		SSticker.SetTimeLeft(1800)
		to_chat(world, "<b>The game will start in 180 seconds.</b>")
		SEND_SOUND(world, sound(get_announcer_sound("attention")))
		message_admins("<font color='blue'>[usr.key] has cancelled immediate game start. Game will start in 180 seconds.</font>")
		log_admin("[usr.key] has cancelled immediate game start.")
	else
		to_chat(usr, "<font color='red'>Error: Start Now: Game has already started.</font>")
	return FALSE

/datum/admins/proc/toggleenter()
	set category = "Server"
	set desc="People can't enter"
	set name="Toggle Entering"
	GLOB.enter_allowed = !( GLOB.enter_allowed )
	if (!( GLOB.enter_allowed ))
		to_chat(world, "<B>New players may no longer enter the game.</B>", confidential = TRUE)
	else
		to_chat(world, "<B>New players may now enter the game.</B>", confidential = TRUE)
	log_admin("[key_name(usr)] toggled new player game entering.")
	message_admins(span_adminnotice("[key_name_admin(usr)] toggled new player game entering."))
	world.update_status()
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Entering", "[GLOB.enter_allowed ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggleAI()
	set category = "Server"
	set desc="People can't be AI"
	set name="Toggle AI"
	var/alai = CONFIG_GET(flag/allow_ai)
	CONFIG_SET(flag/allow_ai, !alai)
	if (alai)
		to_chat(world, "<B>The AI job is no longer chooseable.</B>", confidential = TRUE)
	else
		to_chat(world, "<B>The AI job is chooseable now.</B>", confidential = TRUE)
	log_admin("[key_name(usr)] toggled AI allowed.")
	world.update_status()
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle AI", "[!alai ? "Disabled" : "Enabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggleMulticam()
	set category = "Server"
	set desc="Turns mutlicam on and off."
	set name="Toggle Multicam"
	var/almcam = CONFIG_GET(flag/allow_ai_multicam)
	CONFIG_SET(flag/allow_ai_multicam, !almcam)
	if (almcam)
		for(var/i in GLOB.ai_list)
			var/mob/living/silicon/ai/aiPlayer = i
			if(aiPlayer.multicam_on)
				aiPlayer.end_multicam()
	log_admin("[key_name(usr)] toggled AI multicam.")
	world.update_status()
	to_chat(GLOB.ai_list | GLOB.admins, "<B>The AI [almcam ? "no longer" : "now"] has multicam.</B>", confidential = TRUE)
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Multicam", "[!almcam ? "Disabled" : "Enabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggleaban()
	set category = "Server"
	set desc="Respawn basically"
	set name="Toggle Respawn"
	var/new_nores = !CONFIG_GET(flag/norespawn)
	CONFIG_SET(flag/norespawn, new_nores)
	if (!new_nores)
		to_chat(world, "<B>You may now respawn.</B>", confidential = TRUE)
	else
		to_chat(world, "<B>You may no longer respawn :(</B>", confidential = TRUE)
	message_admins(span_adminnotice("[key_name_admin(usr)] toggled respawn to [!new_nores ? "On" : "Off"]."))
	log_admin("[key_name(usr)] toggled respawn to [!new_nores ? "On" : "Off"].")
	world.update_status()
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Respawn", "[!new_nores ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/delay()
	set category = "Server"
	set desc="Delay the game start"
	set name="Delay Pre-Game"

	var/newtime = input("Set a new time in seconds. Set -1 for indefinite delay.","Set Delay",round(SSticker.GetTimeLeft()/10)) as num|null
	if(SSticker.current_state > GAME_STATE_PREGAME)
		return alert("Too late... The game has already started!")
	if(newtime)
		newtime = newtime*10
		SSticker.SetTimeLeft(newtime)
		SSticker.start_immediately = FALSE
		if(newtime < 0)
			to_chat(world, "<b>The game start has been delayed.</b>", confidential = TRUE)
			log_admin("[key_name(usr)] delayed the round start.")
		else
			to_chat(world, "<b>The game will start in [DisplayTimeText(newtime)].</b>", confidential = TRUE)
			SEND_SOUND(world, sound(get_announcer_sound("attention")))
			log_admin("[key_name(usr)] set the pre-game delay to [DisplayTimeText(newtime)].")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Delay Game Start") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/unprison(mob/M in GLOB.mob_list)
	set category = "Admin"
	set name = "Unprison"
	if (is_centcom_level(M.z))
		SSjob.SendToLateJoin(M)
		message_admins("[key_name_admin(usr)] has unprisoned [key_name_admin(M)]")
		log_admin("[key_name(usr)] has unprisoned [key_name(M)]")
	else
		alert("[M.name] is not prisoned.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Unprison") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/refill_nearby_ammo()
	set category = "Debug"
	set desc = "Refills Nearby Guns and Magazines. Even refills things in containers and inventories!"
	set name = "Refill Nearby Ammo"

	var/maxrange = max(input(usr, "How far away should we look for guns/mags?", "Refill Ammo", 1) as num|null, 1)
	var/multi = alert(usr, "Fill all guns/mags within [maxrange] units, or just the closest one?", "Admin Fill Ammo", "All", "Closest")
	if(multi == "All")
		multi = TRUE
	else
		multi = FALSE

	var/list/filled = refill_ammo(usr, multi, maxrange)
	if(!LAZYLEN(filled))
		to_chat(usr, "Couldn't find anything to refill!")
		return
	to_chat(usr, "Refilled [english_list(filled)].")
	var/list/short_filled = filled.Copy(1,min(3,LAZYLEN(filled)))
	if(LAZYLEN(filled) > 3)
		short_filled += "[LAZYLEN(filled) - 3] more weapons.]"
	var/turf/here = get_turf(usr)
	if(LAZYLEN(filled) == 1)
		message_admins("[key_name_admin(usr)] has refilled [LAZYACCESS(filled, 1)] at [ADMIN_COORDJMP(here)].")
		log_admin("[key_name(usr)] has refilled [LAZYACCESS(filled, 1)] at [ADMIN_COORDJMP(here)].")
	else
		message_admins("[key_name_admin(usr)] has refilled [LAZYLEN(filled)] weapons, including [english_list(short_filled)] at [ADMIN_COORDJMP(here)].")
		log_admin("[key_name(usr)] has refilled [LAZYLEN(filled)] weapons, including [english_list(short_filled)] at [ADMIN_COORDJMP(here)].")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "afilled") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/proc/refill_ammo(atom/origin, multi, range)
	if(!isatom(origin))
		return
	var/list/origin_hands = list()
	var/list/origin_contents = list()
	var/list/all_in_range = list()
	/// First check the origin for guns
	if(isliving(origin))
		var/mob/living/live_origin = origin
		if(live_origin.get_active_held_item())
			origin_hands += live_origin.get_active_held_item()
		if(live_origin.get_inactive_held_item())
			origin_contents += live_origin.get_inactive_held_item()
	if(multi)
		for(var/obj/item/contained in origin.contents)
			origin_contents += contained
			var/list/scrape = list()
			SEND_SIGNAL(contained, COMSIG_TRY_STORAGE_RETURN_INVENTORY, scrape, TRUE) // Recursive search!
			origin_contents |= scrape
		/// now get *everything* in range. EVERYTHING!!!
		var/list/turf_spiral = spiral_range_turfs(range, origin, TRUE)
		for(var/turf/spiral_turf in turf_spiral)
			all_in_range |= get_all_in_turf(spiral_turf, TRUE, 10) // EV ERY THING
	var/list/load_these = origin_hands + origin_contents + all_in_range
	if(!LAZYLEN(load_these))
		return FALSE
	. = list()
	for(var/obj/item/load_this in load_these) // Will fill up held items first, then contents, then everything else
		if(!SEND_SIGNAL(load_this, COMSIG_GUN_MAG_ADMIN_RELOAD))
			continue
		. |= load_this
		if(!multi)
			return

////////////////////////////////////////////////////////////////////////////////////////////////ADMIN HELPER PROCS

/datum/admins/proc/spawn_atom(object as text)
	set category = "Debug"
	set desc = "(atom path) Spawn an atom"
	set name = "Spawn"

	if(!check_rights(R_SPAWN) || !object)
		return

	var/list/preparsed = splittext(object,":")
	var/path = preparsed[1]
	var/amount = 1
	if(preparsed.len > 1)
		amount = clamp(text2num(preparsed[2]),1, 50) //50 at a time!

	to_chat(usr,span_notice("<font size=1>Syntax: 'object : amount' \n example: wrench:50 will open a search for 'wrench', and then spawn 50 of your selection.</font>"), confidential = TRUE)
	var/chosen = pick_closest_path(path)
	if(!chosen)
		return
	var/turf/T = get_turf(usr)

	if(ispath(chosen, /turf))
		T.ChangeTurf(chosen)
	else
		for(var/i in 1 to amount)
			var/atom/A = new chosen(T)
			A.flags_1 |= ADMIN_SPAWNED_1
			SEND_SIGNAL(A,COMSIG_ATOM_POST_ADMIN_SPAWN)

	log_admin("[key_name(usr)] spawned [amount] x [chosen] at [AREACOORD(usr)]")
	message_admins("[key_name(usr)] spawned [amount] x [chosen] at [AREACOORD(usr)]")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Spawn Atom") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/podspawn_atom(object as text)
	set category = "Debug"
	set desc = "(atom path) Spawn an atom via supply drop"
	set name = "Podspawn"

	if(!check_rights(R_SPAWN))
		return

	var/chosen = pick_closest_path(object)
	if(!chosen)
		return
	var/turf/T = get_turf(usr)

	if(ispath(chosen, /turf))
		T.ChangeTurf(chosen)
	else
		var/obj/structure/closet/supplypod/centcompod/pod = new()
		var/atom/A = new chosen(pod)
		A.flags_1 |= ADMIN_SPAWNED_1
		new /obj/effect/abstract/DPtarget(T, pod)

	log_admin("[key_name(usr)] pod-spawned [chosen] at [AREACOORD(usr)]")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Podspawn Atom") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/spawn_cargo(object as text)
	set category = "Debug"
	set desc = "(atom path) Spawn a cargo crate"
	set name = "Spawn Cargo"

	if(!check_rights(R_SPAWN))
		return

	var/chosen = pick_closest_path(object, make_types_fancy(subtypesof(/datum/supply_pack)))
	if(!chosen)
		return
	var/datum/supply_pack/S = new chosen
	S.admin_spawned = TRUE
	S.generate(get_turf(usr))

	log_admin("[key_name(usr)] spawned cargo pack [chosen] at [AREACOORD(usr)]")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Spawn Cargo") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/show_traitor_panel(mob/target_mob in GLOB.mob_list)
	set category = "Admin"
	set desc = "Edit mobs's memory and role"
	set name = "Show Traitor Panel"
	var/datum/mind/target_mind = target_mob.mind
	if(!target_mind)
		to_chat(usr, "This mob has no mind!", confidential = TRUE)
		return
	if(!istype(target_mob) && !istype(target_mind))
		to_chat(usr, "This can only be used on instances of type /mob and /mind", confidential = TRUE)
		return
	target_mind.traitor_panel()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Traitor Panel") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/datum/admins/proc/toggletintedweldhelmets()
	set category = "Debug"
	set desc="Reduces view range when wearing welding helmets"
	set name="Toggle tinted welding helmes"
	GLOB.tinted_weldhelh = !( GLOB.tinted_weldhelh )
	if (GLOB.tinted_weldhelh)
		to_chat(world, "<B>The tinted_weldhelh has been enabled!</B>", confidential = TRUE)
	else
		to_chat(world, "<B>The tinted_weldhelh has been disabled!</B>", confidential = TRUE)
	log_admin("[key_name(usr)] toggled tinted_weldhelh.")
	message_admins("[key_name_admin(usr)] toggled tinted_weldhelh.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Tinted Welding Helmets", "[GLOB.tinted_weldhelh ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/toggleguests()
	set category = "Server"
	set desc="Guests can't enter"
	set name="Toggle guests"
	var/new_guest_ban = !CONFIG_GET(flag/guest_ban)
	CONFIG_SET(flag/guest_ban, new_guest_ban)
	if (new_guest_ban)
		to_chat(world, "<B>Guests may no longer enter the game.</B>", confidential = TRUE)
	else
		to_chat(world, "<B>Guests may now enter the game.</B>", confidential = TRUE)
	log_admin("[key_name(usr)] toggled guests game entering [!new_guest_ban ? "" : "dis"]allowed.")
	message_admins(span_adminnotice("[key_name_admin(usr)] toggled guests game entering [!new_guest_ban ? "" : "dis"]allowed."))
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Guests", "[!new_guest_ban ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/output_ai_laws()
	var/ai_number = 0
	for(var/i in GLOB.silicon_mobs)
		var/mob/living/silicon/S = i
		ai_number++
		if(isAI(S))
			to_chat(usr, "<b>AI [key_name(S, usr)]'s laws:</b>", confidential = TRUE)
		else if(iscyborg(S))
			var/mob/living/silicon/robot/R = S
			to_chat(usr, "<b>CYBORG [key_name(S, usr)] [R.connected_ai?"(Slaved to: [key_name(R.connected_ai)])":"(Independent)"]: laws:</b>", confidential = TRUE)
		else if (ispAI(S))
			to_chat(usr, "<b>pAI [key_name(S, usr)]'s laws:</b>", confidential = TRUE)
		else
			to_chat(usr, "<b>SOMETHING SILICON [key_name(S, usr)]'s laws:</b>", confidential = TRUE)

		if (S.laws == null)
			to_chat(usr, "[key_name(S, usr)]'s laws are null?? Contact a coder.", confidential = TRUE)
		else
			S.laws.show_laws(usr)
	if(!ai_number)
		to_chat(usr, "<b>No AIs located</b>" , confidential = TRUE)

/datum/admins/proc/output_all_devil_info()
	var/devil_number = 0
	for(var/datum/mind/D in SSticker.mode.devils)
		devil_number++
		var/datum/antagonist/devil/devil = D.has_antag_datum(/datum/antagonist/devil)
		to_chat(usr, "Devil #[devil_number]:<br><br>" + devil.printdevilinfo(), confidential = TRUE)
	if(!devil_number)
		to_chat(usr, "<b>No Devils located</b>" , confidential = TRUE)

/datum/admins/proc/output_devil_info(mob/living/M)
	if(is_devil(M))
		var/datum/antagonist/devil/devil = M.mind.has_antag_datum(/datum/antagonist/devil)
		to_chat(usr, devil.printdevilinfo(), confidential = TRUE)
	else
		to_chat(usr, "<b>[M] is not a devil.", confidential = TRUE)

/datum/admins/proc/manage_free_slots()
	if(!check_rights())
		return
	var/datum/browser/browser = new(usr, "jobmanagement", "Manage Free Slots", 520)
	var/list/dat = list()
	var/count = 0

	if(!SSjob.initialized)
		alert(usr, "You cannot manage jobs before the job subsystem is initialized!")
		return

	dat += "<table>"

	for(var/j in SSjob.occupations)
		var/datum/job/job = j
		count++
		var/J_title = html_encode(job.title)
		var/J_opPos = html_encode(job.total_positions - (job.total_positions - job.current_positions))
		var/J_totPos = html_encode(job.total_positions)
		dat += "<tr><td>[J_title]:</td> <td>[J_opPos]/[job.total_positions < 0 ? " (unlimited)" : J_totPos]"

		dat += "</td>"
		dat += "<td>"
		if(job.total_positions >= 0)
			dat += "<A href='?src=[REF(src)];[HrefToken()];customjobslot=[job.title]'>Custom</A> | "
			dat += "<A href='?src=[REF(src)];[HrefToken()];addjobslot=[job.title]'>Add 1</A> | "
			if(job.total_positions > job.current_positions)
				dat += "<A href='?src=[REF(src)];[HrefToken()];removejobslot=[job.title]'>Remove</A> | "
			else
				dat += "Remove | "
			dat += "<A href='?src=[REF(src)];[HrefToken()];unlimitjobslot=[job.title]'>Unlimit</A></td>"
		else
			dat += "<A href='?src=[REF(src)];[HrefToken()];limitjobslot=[job.title]'>Limit</A></td>"

	browser.height = min(100 + count * 20, 650)
	browser.set_content(dat.Join())
	browser.open()

/datum/admins/proc/dynamic_mode_options(mob/user)
	var/dat = {"
		<center><B><h2>Dynamic Mode Options</h2></B></center><hr>
		<br/>
		<h3>Common options</h3>
		<i>All these options can be changed midround.</i> <br/>
		<br/>
		<b>Force extended:</b> - Option is <a href='?src=[REF(src)];[HrefToken()];f_dynamic_force_extended=1'> <b>[GLOB.dynamic_forced_extended ? "ON" : "OFF"]</a></b>.
		<br/>This will force the round to be extended. No rulesets will be drafted. <br/>
		<br/>
		<b>No stacking:</b> - Option is <a href='?src=[REF(src)];[HrefToken()];f_dynamic_no_stacking=1'> <b>[GLOB.dynamic_no_stacking ? "ON" : "OFF"]</b></a>.
		<br/>Unless the threat goes above [GLOB.dynamic_stacking_limit], only one "round-ender" ruleset will be drafted. <br/>
		<br/>
		<b>Forced threat level:</b> Current value : <a href='?src=[REF(src)];[HrefToken()];f_dynamic_forced_threat=1'><b>[GLOB.dynamic_forced_threat_level]</b></a>.
		<br/>The value threat is set to if it is higher than -1.<br/>
		<br/>
		<br/>
		<b>Stacking threeshold:</b> Current value : <a href='?src=[REF(src)];[HrefToken()];f_dynamic_stacking_limit=1'><b>[GLOB.dynamic_stacking_limit]</b></a>.
		<br/>The threshold at which "round-ender" rulesets will stack. A value higher than 100 ensure this never happens. <br/>
		"}

	user << browse(dat, "window=dyn_mode_options;size=900x650")

/datum/admins/proc/create_or_modify_area()
	set category = "Debug"
	set name = "Create or modify area"
	create_area(usr)

//
//
//ALL DONE
//*********************************************************************************************************
//TO-DO:
//
//

//RIP ferry snowflakes

//Kicks all the clients currently in the lobby. The second parameter (kick_only_afk) determins if an is_afk() check is ran, or if all clients are kicked
//defaults to kicking everyone (afk + non afk clients in the lobby)
//returns a list of ckeys of the kicked clients
/proc/kick_clients_in_lobby(message, kick_only_afk = 0)
	var/list/kicked_client_names = list()
	for(var/client/C in GLOB.clients)
		if(isnewplayer(C.mob))
			if(kick_only_afk && !C.is_afk()) //Ignore clients who are not afk
				continue
			if(message)
				to_chat(C, message, confidential = TRUE)
			kicked_client_names.Add("[C.key]")
			qdel(C)
	return kicked_client_names

//returns TRUE to let the dragdrop code know we are trapping this event
//returns FALSE if we don't plan to trap the event
/datum/admins/proc/cmd_ghost_drag(mob/dead/observer/frommob, mob/tomob)

	//this is the exact two check rights checks required to edit a ckey with vv.
	if (!check_rights(R_VAREDIT,0) || !check_rights(R_SPAWN|R_DEBUG,0))
		return FALSE

	if (!frommob.ckey)
		return FALSE

	var/question = ""
	if (tomob.ckey)
		question = "This mob already has a user ([tomob.key]) in control of it! "
	question += "Are you sure you want to place [frommob.name]([frommob.key]) in control of [tomob.name]?"

	var/ask = alert(question, "Place ghost in control of mob?", "Yes", "No")
	if (ask != "Yes")
		return TRUE

	if (!frommob || !tomob) //make sure the mobs don't go away while we waited for a response
		return TRUE

	// Disassociates observer mind from the body mind
	if(tomob.client)
		tomob.ghostize(FALSE)
	else
		for(var/mob/dead/observer/ghost in GLOB.dead_mob_list)
			if(tomob.mind == ghost.mind)
				ghost.mind = null

	message_admins(span_adminnotice("[key_name_admin(usr)] has put [frommob.key] in control of [tomob.name]."))
	log_admin("[key_name(usr)] stuffed [frommob.key] into [tomob.name].")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Ghost Drag Control")

	tomob.ckey = frommob.ckey
	qdel(frommob)

	return TRUE

/client/proc/adminGreet(logout)
	if(SSticker.HasRoundStarted())
		var/string
	// 	if(logout && CONFIG_GET(flag/announce_admin_logout))
	// 		string = pick(
	// 			"Admin logout: [key_name(src)]")
		if(!logout /* && CONFIG_GET(flag/announce_admin_login) && (prefs.toggles & ANNOUNCE_LOGIN) */)
			string = pick(
				"Admin login: [key_name(src)]")
		if(string)
			message_admins("[string]")

/client/proc/cmd_admin_man_up(mob/M in GLOB.mob_list)
	set category = "Special Verbs"
	set name = "Man Up"

	if(!M)
		return
	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use cmd_admin_man_up() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use cmd_admin_man_up() without admin perms.")
		return

	to_chat(M, "<span class='warning bold reallybig'>Man up, and deal with it.</span><br><span class='warning big'>Move on.</span>")
	M.playsound_local(M, 'sound/voice/manup.ogg', 50, FALSE, pressure_affected = FALSE)

	log_admin("Man up: [key_name(usr)] told [key_name(M)] to man up")
	var/message = span_adminnotice("[key_name_admin(usr)] told [key_name_admin(M)] to man up.")
	message_admins(message)
	admin_ticket_log(M, message)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Man Up")

/client/proc/cmd_admin_man_up_global()
	set category = "Special Verbs"
	set name = "Man Up Global"

	if(!check_rights(R_ADMIN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use cmd_admin_man_up_global() without admin perms.")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use cmd_admin_man_up_global() without admin perms.")
		return

	to_chat(world, "<span class='warning bold reallybig'>Man up, and deal with it.</span><br><span class='warning big'>Move on.</span>")
	for(var/mob/M in GLOB.player_list)
		M.playsound_local(M, 'sound/voice/manup.ogg', 50, FALSE, pressure_affected = FALSE)

	log_admin("Man up global: [key_name(usr)] told everybody to man up")
	message_admins(span_adminnotice("[key_name_admin(usr)] told everybody to man up."))
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Man Up Global")
