/proc/escape_shell_arg(var/arg)
	if(world.system_type == MS_WINDOWS)
		arg = replacetext(arg, "^", "^^") // Escape char
		arg = replacetext(arg, "%", "%%") // %PATH% -> %%PATH%%
		arg = replacetext(arg, "!", "^!") // !PATH!, delayed variable expansion on Windows
		arg = replacetext(arg, "\"", "^\"")
		arg = "\"[arg]\""
	else
		arg = replacetext(arg, "\\", "\\\\'") // Escape char
		arg = replacetext(arg, "'", "\\'")    // No breaking out of the single quotes.
		arg = "'[arg]'"
	return arg

/proc/check_vpt(var/ckey, var/ip)
	var/script = "scripts/vptdetect.py"
	if(world.system_type == MS_WINDOWS)
		script = replacetext(script, "/", "\\")
	var/command = "python3 " + script + " " + escape_shell_arg(ip)
	var/response = shell(command)
	var/standardText = replacetext("ckey appears to have connected from an IP address with a known BADNEFARIOUSTHING.", "ckey", ckey)
	var/replacement = ""
	if (response == 100)
		replacement = "VPN"
	if (response == 101)
		replacement = "Proxy server"
	if (response == 102)
		replacement = "TOR exit node"
	if (response == 103)
		replacement = "internet relay"
	if (length(replacement) > 0)
		message_admins(replacetext(standardText, "BADNEFARIOUSTHING", replacement))
	if (replacement != "")
		return replacement
	return null
