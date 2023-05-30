//Dont touch this code, this is what generates the shadow. Simply add this to your code and use;
//GenerateShadow(src,DIRECTION)

atom/var/shadows[0]
atom/var/shadow = 0

///SHADOW GENERATOR FOR MOBS/////////////////////////////
proc/GenerateShadowMob(atom/A, Dir = EAST)
	var/shadow/SH = new ; SH.appearance = A ; SH.color = "black" ; SH.alpha = 80
	var/icon/I = new/icon(A.icon,A.icon_state) //Used to calculate the size of the icon
	SH.pixel_y -= I.Height()/1.2
	if(Dir== SOUTH)
		var/matrix/M = matrix(); M.Turn(180) ; SH.transform = M
		SH.pixel_x = 0
	if(Dir == EAST)
		var/matrix/M = matrix(); M.Scale(-1,1); M.Turn(153);  SH.transform = M
		SH.pixel_x += I.Width()/5.1

	if(Dir == WEST)
		var/matrix/M = matrix(); M.Scale(-1,1); M.Turn(205) ; SH.transform = M
		SH.pixel_x -= I.Width()/5.1
	A.shadows.Add(SH);A.underlays += SH
////////////////////////////////////////////////////////


///SHADOW GENERATOR FOR ENVIRONMENT//////////////////////
proc/GenerateShadow(atom/A, Dir = EAST)
	var/icon/I = new/icon(A.icon,A.icon_state)
	I.Flip(WEST)
	var/shadow/SH = new ; SH.icon = I ; SH.color = "black"
	SH.pixel_y -= I.Height()/1.3
	if(Dir== SOUTH)
		SH.pixel_x = 0 ; SH.transform = turn(SH.transform, 180)
	if(Dir == EAST)
		SH.pixel_x += I.Width()/5.1 ; SH.transform = turn(SH.transform, 153)
	if(Dir == WEST)
		SH.pixel_x -= I.Width()/5.1 ;SH.transform = turn(SH.transform, 205)
	A.shadows.Add(SH); A.underlays += SH
////////////////////////////////////////////////////////////

shadow
	parent_type = /obj
	layer = 5 ; density = 0 ; alpha = 80

