// This is eventually for wjohn to add more color standardization stuff like I keep asking him >:(

#define COLOR_INPUT_DISABLED "#F0F0F0"
#define COLOR_INPUT_ENABLED "#D3B5B5"
#define COLOR_FLOORTILE_GRAY   "#8D8B8B"
#define COLOR_ALMOST_BLACK	   "#333333"
#define COLOR_WHITE            "#FFFFFF"
#define COLOR_BLACK            "#000000"
#define COLOR_RED              "#FF0000"
#define COLOR_RED_LIGHT        "#FF3333"
#define COLOR_MAROON           "#800000"
#define COLOR_YELLOW           "#FFFF00"
#define COLOR_OLIVE            "#808000"
#define COLOR_LIME             "#32CD32"
#define COLOR_GREEN            "#008000"
#define COLOR_CYAN             "#00FFFF"
#define COLOR_TEAL             "#008080"
#define COLOR_BLUE             "#0000FF"
#define COLOR_BLUE_LIGHT       "#33CCFF"
#define COLOR_NAVY             "#000080"
#define COLOR_PINK             "#FFC0CB"
#define COLOR_MAGENTA          "#FF00FF"
#define COLOR_PURPLE           "#800080"
#define COLOR_ORANGE           "#FF9900"
#define COLOR_BEIGE            "#CEB689"
#define COLOR_BLUE_GRAY        "#75A2BB"
#define COLOR_BROWN            "#BA9F6D"
#define COLOR_DARK_BROWN       "#997C4F"
#define COLOR_DARK_ORANGE      "#C3630C"
#define COLOR_GREEN_GRAY       "#99BB76"
#define COLOR_RED_GRAY         "#B4696A"
#define COLOR_PALE_BLUE_GRAY   "#98C5DF"
#define COLOR_PALE_GREEN_GRAY  "#B7D993"
#define COLOR_PALE_ORANGE      "#FFC066"
#define COLOR_PALE_RED_GRAY    "#D59998"
#define COLOR_PALE_PURPLE_GRAY "#CBB1CA"
#define COLOR_PURPLE_GRAY      "#AE8CA8"

//Color defines used by the assembly detailer.
#define COLOR_ASSEMBLY_BLACK   "#545454"
#define COLOR_ASSEMBLY_BGRAY   "#9497AB"
#define COLOR_ASSEMBLY_WHITE   "#E2E2E2"
#define COLOR_ASSEMBLY_RED     "#CC4242"
#define COLOR_ASSEMBLY_ORANGE  "#E39751"
#define COLOR_ASSEMBLY_BEIGE   "#AF9366"
#define COLOR_ASSEMBLY_BROWN   "#97670E"
#define COLOR_ASSEMBLY_GOLD    "#AA9100"
#define COLOR_ASSEMBLY_YELLOW  "#CECA2B"
#define COLOR_ASSEMBLY_GURKHA  "#999875"
#define COLOR_ASSEMBLY_LGREEN  "#789876"
#define COLOR_ASSEMBLY_GREEN   "#44843C"
#define COLOR_ASSEMBLY_LBLUE   "#5D99BE"
#define COLOR_ASSEMBLY_BLUE    "#38559E"
#define COLOR_ASSEMBLY_PURPLE  "#6F6192"
#define COLOR_ASSEMBLY_PINK    "#ff4adc"


/proc/get_contrasting_color(colorhex1, colorhex2)
	// This proc will return the color that contrasts the most with
	// the average of the two colors.
	var/c_num_1 = hex2num(colorhex1) // returns a number between 0 and 16777215
	var/c_num_2 = hex2num(colorhex2) // returns a number between 0 and 16777215
	var/c_num_avg = max((c_num_1 + c_num_2) / 2, 1)
	var/c_num_contrast = max(16777215 - c_num_avg, 1) // the color that contrasts the most with the average of the two colors
	/// account for luminance and return a color that has a contrast ratio of at least 7:1
	var/con_ratio = 0
	if(c_num_avg > c_num_contrast)
		con_ratio = c_num_avg / c_num_contrast
	else
		con_ratio = c_num_contrast / c_num_avg
	var/tries = 100
	while(con_ratio < 7 && tries-- > 0)
		if(c_num_contrast <= 0) // we've reached the end of the color spectrum
			return "#000000" 
		else if(c_num_contrast >= 16777215) // we've reached the end of the color spectrum
			return "#FFFFFF"
		if(c_num_avg > c_num_contrast)
			c_num_contrast += 65535
		else
			c_num_contrast -= 65535
		con_ratio = c_num_avg / c_num_contrast
	var/hexcode = num2hex(c_num_contrast, 6)
	return "#[hexcode]"












